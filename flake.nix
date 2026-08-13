{
  description = "OpenTitan Provisioning Services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bcr = {
      url = "github:bazelbuild/bazel-central-registry";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, bcr }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        buildBazel8Package = pkgs.callPackage "${pkgs.path}/pkgs/by-name/ba/bazel_8/build-support/bazelPackage.nix" {};

        # Bazel vendor Fixed-Output Derivation (FOD) SHA-256 hash.
        # When MODULE.bazel or go.mod changes:
        # 1. Temporarily replace sha256Hash with pkgs.lib.fakeHash (or "").
        # 2. Run: nix build path:.#all
        # 3. Copy the computed SHA-256 mismatch hash back here.
        sha256Hash = "sha256-lpTEaFMn9EvJaHhNcWturBOS1FK0d/beeHIc3sLmw94=";

        rawSource = pkgs.lib.cleanSourceWith {
          src = ./.;
          filter = path: type:
            let base = baseNameOf path;
            in !(base == "result" || base == ".git" || base == "flake.nix" || base == "flake.lock");
        };

        cleanedSource = pkgs.runCommand "opentitan-provisioning-src" {} ''
          cp -r ${rawSource} $out
          chmod -R +w $out
          cd $out
          rm -f .bazelversion
          sed -i 's|register_toolchains("@llvm_toolchain_host//:all")|# register_toolchains("@llvm_toolchain_host//:all")|g' MODULE.bazel
          cat << 'EOF' > util/get_workspace_status.sh
#!/bin/sh
echo "BUILD_SCM_REVISION 0.1.0"
echo "BUILD_GIT_VERSION 0.1.0"
echo "BUILD_SCM_STATUS clean"
EOF
          chmod +x util/get_workspace_status.sh
          cat << 'EOF' >> .bazelrc
build --spawn_strategy=standalone
build --genrule_strategy=standalone
EOF
        '';

        services = buildBazel8Package {
          name = "opentitan-provisioning-services";
          version = "0.1.0";
          src = cleanedSource;
          registry = "${bcr}";
          bazel = pkgs.bazel_8;
          targets = [
            "//src/pa:pa_server"
            "//src/spm:spm_server"
            "//src/proxy_buffer:pb_server"
          ];
          buildInputs = with pkgs; [
            stdenv.cc.cc.lib
            ncurses5
            zlib
          ];
          autoPatchelfIgnoreMissingDeps = [
            "libtiff.so.6"
            "libstdc++.so.6"
            "libgcc_s.so.1"
            "libtinfo.so.5"
            "libtinfo.so.6"
          ];
          bazelVendorDepsFOD = {
            outputHash = sha256Hash;
            outputHashAlgo = "sha256";
          };
          installPhase = ''
            mkdir -p $out/bin
            cp bazel-bin/src/pa/pa_server_/pa_server $out/bin/pa_server
            cp bazel-bin/src/spm/spm_server_/spm_server $out/bin/spm_server
            cp bazel-bin/src/proxy_buffer/pb_server_/pb_server $out/bin/pb_server
          '';
        };

        mkSingleService = name:
          pkgs.runCommand name {
            meta.mainProgram = name;
          } ''
            mkdir -p $out/bin
            ln -s ${services}/bin/${name} $out/bin/${name}
          '';
      in {
        packages = {
          all = services;
          default = services;
          pa_server = mkSingleService "pa_server";
          spm_server = mkSingleService "spm_server";
          pb_server = mkSingleService "pb_server";
        };

        apps = {
          pa_server = flake-utils.lib.mkApp {
            drv = self.packages.${system}.pa_server;
            name = "pa_server";
          };
          spm_server = flake-utils.lib.mkApp {
            drv = self.packages.${system}.spm_server;
            name = "spm_server";
          };
          pb_server = flake-utils.lib.mkApp {
            drv = self.packages.${system}.pb_server;
            name = "pb_server";
          };
          default = self.apps.${system}.pa_server;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bazel_8
            bazelisk
            go
            gopls
            softhsm
            protobuf
          ];
          USE_BAZEL_VERSION = "${pkgs.bazel_8.version}";
        };
      }
    );
}

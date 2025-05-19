class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.3.9267/FoundryLocal-osx-arm64-0.3.9267.42993.zip"
  sha256 "95b1747a7e89e8ec690b3fcb6a46bdd4c2fd07faa3c28fcdc98ee842a32f9b8b"


  keg_only "Install FoundryLocal as a keg-only so as to avoid polluting the global lib/include paths with internal libraries"

  def install
    bin.install Dir["bin/foundry"]
    bin.install Dir["bin/Inference.Service.Agent"]
    bin.install Dir["bin/libonnxruntime-genai.dylib"]
    bin.install Dir["bin/libonnxruntime.dylib"]
    bin.install Dir["bin/appsettings.json"]

    bin.install_symlink "bin/foundry"
  end
end

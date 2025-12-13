class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.8.115/FoundryLocal-osx-arm64-0.8.115.zip"
  sha256 "2b3dbdd17b6336ffc70cd15dc3cbbe4aff7835fb8b281b7816cb80444b14f202"
  license "https://github.com/microsoft/Foundry-Local/blob/main/LICENSE"

  def install
    prefix.install Dir["bin/foundry"]
    prefix.install Dir["bin/Inference.Service.Agent"]
    prefix.install Dir["bin/libonnxruntime-genai.dylib"]
    prefix.install Dir["bin/libonnxruntime.dylib"]
    prefix.install Dir["bin/appsettings.json"]

    bin.install_symlink prefix/"foundry"
  end
end

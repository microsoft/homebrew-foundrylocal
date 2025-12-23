class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.8.117/FoundryLocal-osx-arm64-0.8.117.zip"
  sha256 "efd2097ac060fd215cc01fb98061e633dab27955f38101d6b8f4540f8bd30fe3"
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

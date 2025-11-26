class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.8.113/FoundryLocal-osx-arm64-0.8.113.zip"
  sha256 "5c37a68d97b7d9c0fe8b0ce76d3572494dc31d3977399323e55ec546f40663aa"
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

class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.6.82/FoundryLocal-osx-arm64-0.6.82.zip"
  sha256 "6d64730964434f73ab6112a5454460c3481b349487e835a151cc8ce9fa77ccd6"

  def install
    prefix.install Dir["bin/foundry"]
    prefix.install Dir["bin/Inference.Service.Agent"]
    prefix.install Dir["bin/libonnxruntime-genai.dylib"]
    prefix.install Dir["bin/libonnxruntime.dylib"]
    prefix.install Dir["bin/appsettings.json"]

    bin.install_symlink prefix/"foundry"
  end
end

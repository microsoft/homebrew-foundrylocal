class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.4.92/FoundryLocal-osx-arm64-0.4.92.zip"
  sha256 "b9bd0a46964a2e2aa08f2bd1c435a36e82f3e0b5f6ad849b3a4c71822bfd4748"

  def install
    prefix.install Dir["bin/foundry"]
    prefix.install Dir["bin/Inference.Service.Agent"]
    prefix.install Dir["bin/libonnxruntime-genai.dylib"]
    prefix.install Dir["bin/libonnxruntime.dylib"]
    prefix.install Dir["bin/appsettings.json"]

    bin.install_symlink prefix/"foundry"
  end
end

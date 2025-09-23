class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.7.117/FoundryLocal-osx-arm64-0.7.117.zip"
  sha256 "acd80e5d2b20468c09586242ea4c37826737af9bc61286b8c78bb1f15c3e2121"

  def install
    prefix.install Dir["bin/foundry"]
    prefix.install Dir["bin/Inference.Service.Agent"]
    prefix.install Dir["bin/libonnxruntime-genai.dylib"]
    prefix.install Dir["bin/libonnxruntime.dylib"]
    prefix.install Dir["bin/appsettings.json"]

    bin.install_symlink prefix/"foundry"
  end
end

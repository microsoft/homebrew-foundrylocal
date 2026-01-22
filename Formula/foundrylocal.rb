class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.8.119/FoundryLocal-osx-arm64-0.8.119.zip"
  sha256 "dc9b321c8eeac3b05586535cb811e45342a0e4239d08e132209684d010ff9572"
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

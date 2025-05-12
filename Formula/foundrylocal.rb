require_relative "custom_download_strategy"

class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/homebrew-foundrylocal/releases/download/v0.2.9261.3846/FoundryLocal-osx-arm64-0.2.9261.3846.zip", using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "062a9afc78a827b814551dc1ecc8415e6529b3f79d88e6331d6053d42fa087a3"

  def install
    bin.install "bin/foundry"
    bin.install "bin/libonnxruntime-genai.dylib"
    bin.install "bin/libonnxruntime.dylib"
    bin.install "bin/Inference.Service.Agent"
    bin.install "bin/onnx.yml"
  end
end

require_relative "custom_download_strategy"

class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.2.9261/FoundryLocal-osx-arm64-0.2.9263.31084.zip", using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "3a6b1dc41e7be5cb8f478b7b23e4e79c353a1ce4717b15aa7788f5afd8e82451"

  def install
    bin.install "bin/foundry"
    bin.install "bin/libonnxruntime-genai.dylib"
    bin.install "bin/libonnxruntime.dylib"
    bin.install "bin/Inference.Service.Agent"
    bin.install "bin/onnx.yml"
  end
end

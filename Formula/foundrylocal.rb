require_relative "custom_download_strategy"

class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.2.9265/FoundryLocal-osx-arm64-0.2.9265.18890.zip",  using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "b76c0ce4284c8be23d4d0af9af3121e8bbbbd77e474b0e3bd3f434bdb9f818bc"

  def install
    bin.install "bin/foundry"
    bin.install "bin/libonnxruntime-genai.dylib"
    bin.install "bin/libonnxruntime.dylib"
    bin.install "bin/Inference.Service.Agent"
  end
end

require_relative "custom_download_strategy"

class Foundrylocal < Formula
  desc "Formula for Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/Foundry-Local/releases/download/v0.3.9267/FoundryLocal-osx-arm64-0.3.9267.42993.zip",  using: GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "95b1747a7e89e8ec690b3fcb6a46bdd4c2fd07faa3c28fcdc98ee842a32f9b8b"

  def install
    bin.install "bin/foundry"
    bin.install "bin/libonnxruntime-genai.dylib"
    bin.install "bin/libonnxruntime.dylib"
    bin.install "bin/Inference.Service.Agent"
  end
end

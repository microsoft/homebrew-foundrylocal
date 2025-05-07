require "formula"
require_relative "../custom_download_strategy.rb"

class Foundrylocal < Formula
  desc "Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/homebrew-foundrylocal/releases/download/v0.2.9257.39116/FoundryLocal-osx-arm64-0.2.9257.39116.zip", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
  sha256 "f852c9c4eecadd7fae102c5fe27c7ed837aa6895a4475e4c8a2305ab7d423b22"
  version "0.2.9257.39116"

  def install
    bin.install "bin/foundry"
    bin.install "bin/libonnxruntime-genai.dylib"
    bin.install "bin/libonnxruntime.dylib"
    bin.install "bin/Inference.Service.Agent"
    bin.install "bin/onnx.yml"
  end
end
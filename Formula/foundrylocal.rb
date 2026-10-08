class Foundrylocal < Formula
  desc "Preview CLI for running generative AI models locally"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/cli-preview-0.11.0/foundry-0.11.0-osx-arm64.zip"
  version "0.11.0"
  sha256 "e309bf717fd3c610875e0f713471aaee6df8893c06d427b49e1bfa13b6f938a2"
  license "https://github.com/microsoft/Foundry-Local/blob/main/LICENSE"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    runtime_dir = "bin"
    libexec.install "#{runtime_dir}/foundry",
                    "#{runtime_dir}/foundrylocald",
                    "#{runtime_dir}/libonnxruntime-genai.dylib",
                    "#{runtime_dir}/libonnxruntime.dylib",
                    "#{runtime_dir}/libfoundry_local.dylib",
                    "#{runtime_dir}/notices"

    chmod 0755, libexec/"foundrylocald"
    bin.install_symlink libexec/"foundry"
  end

  test do
    assert_predicate libexec/"foundrylocald", :executable?
    assert_equal version.to_s, shell_output("#{bin}/foundry --version").strip
  end
end

class Foundrylocal < Formula
  desc "Preview CLI for running generative AI models locally"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/cli-preview-0.10.3/foundry-0.10.3-osx-arm64.zip"
  version "0.10.3"
  sha256 "cc29c1c54a44131ed1db8fd920459b3c9420465177e45061a6f84e84eacf234f"
  license "https://github.com/microsoft/Foundry-Local/blob/main/LICENSE"

  depends_on arch: :arm64
  depends_on macos: :monterey

  def install
    runtime_dir = "bin"
    libexec.install "#{runtime_dir}/foundry",
                    "#{runtime_dir}/foundrylocald",
                    "#{runtime_dir}/libonnxruntime-genai.dylib",
                    "#{runtime_dir}/libonnxruntime.dylib",
                    "#{runtime_dir}/Microsoft.AI.Foundry.Local.Core.dylib",
                    "#{runtime_dir}/onnxruntime_providers_shared.dll",
                    "#{runtime_dir}/onnxruntime-genai.dll",
                    "#{runtime_dir}/onnxruntime.dll"

    chmod 0755, libexec/"foundrylocald"
    bin.install_symlink libexec/"foundry"
  end

  test do
    assert_predicate libexec/"foundrylocald", :executable?
    assert_equal version.to_s, shell_output("#{bin}/foundry --version").strip
  end
end

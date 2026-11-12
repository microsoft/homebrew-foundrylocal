class Foundrylocal < Formula
  desc "Preview CLI for running generative AI models locally"
  homepage "https://github.com/microsoft/Foundry-Local"
  url "https://github.com/microsoft/Foundry-Local/releases/download/cli-preview-0.14.0/foundry-0.14.0-osx-arm64.zip"
  version "0.14.0"
  sha256 "5ddf2e6a4d7974b9db65d4a76039bdae29bcfa7440523b3e9588ce542b154e42"
  license "https://github.com/microsoft/Foundry-Local/blob/main/LICENSE"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    runtime_dir = "bin"
    libexec.install "#{runtime_dir}/foundry",
                    "#{runtime_dir}/foundrylocald",
                    "#{runtime_dir}/libonnxruntime-genai.dylib",
                    "#{runtime_dir}/libonnxruntime.dylib",
                    "#{runtime_dir}/libonnxruntime.1.dylib",
                    "#{runtime_dir}/libfoundry_local.dylib",
                    "#{runtime_dir}/notices"

    chmod 0755, libexec/"foundrylocald"
    bin.install_symlink libexec/"foundry"
  end

  test do
    assert_predicate libexec/"foundrylocald", :executable?
    assert_predicate libexec/"libonnxruntime.1.dylib", :symlink?
    assert_equal (libexec/"libonnxruntime.dylib").realpath, (libexec/"libonnxruntime.1.dylib").realpath
    assert_equal version.to_s, shell_output("#{bin}/foundry --version").strip
  end
end

class Foundrylocal < Formula
  desc "Foundry Local CLI and Inference Agent installer"
  homepage "https://github.com/microsoft/homebrew-foundrylocal"
  url "https://github.com/microsoft/homebrew-foundrylocal/releases/download/v0.2.9257.39116/FoundryLocal-osx-arm64-0.2.9257.39116.zip"
  sha256 "f852c9c4eecadd7fae102c5fe27c7ed837aa6895a4475e4c8a2305ab7d423b22"
  version "0.2.9257.39116"

  def install
    # Install everything into libexec
    libexec.install Dir["*"]

    # Create a wrapper script to run the installer
    (bin/"install-foundry").write <<~EOS
      #!/bin/bash
      exec #{libexec}/install-foundry.command "$@"
    EOS
    chmod "+x", bin/"install-foundry"
  end

  def caveats
    <<~EOS
      To complete setup, run:

        install-foundry

      This will install binaries to ~/.inference_agent and link them to ~/bin.
    EOS
  end
end
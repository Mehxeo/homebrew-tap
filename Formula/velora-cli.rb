class VeloraCli < Formula
  desc "The Velora terminal app — agents, missions, and automations from your shell"
  homepage "https://runvelora.app"
  version "3.0.0-beta.7"
  license "Unlicense"

  if Hardware::CPU.arm?
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-arm64.zip"
    sha256 "8fcf29e6083f8cc021ae7c56bf01545e31c7c88edff023dca77411cb3bc905c1"
  else
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-x64.zip"
    sha256 "de62924e1df05e72f944c93c9478d149a92ebfb3b66c718b6a15614f572d8138"
  end

  def install
    binary = Hardware::CPU.arm? ? "velora-cli-macos-arm64" : "velora-cli-macos-x64"
    bin.install binary => "velora"
  end

  def caveats
    <<~EOS
      Sign in with `velora login` (same account as the desktop app; the CLI
      registers as its own device). Full command reference: `velora --help`.

      Browser takeover and the Background Computer need Playwright, which the
      standalone binary does not carry; those two features degrade gracefully.
      Windows ships x64 (runs on Arm through emulation) — install via Scoop or
      the release's PowerShell installer.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/velora --version")
  end
end

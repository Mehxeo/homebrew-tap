class VeloraCli < Formula
  desc "The Velora terminal app — agents, missions, and automations from your shell"
  homepage "https://runvelora.app"
  version "3.0.0-beta.29"
  license "Unlicense"

  if Hardware::CPU.arm?
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-arm64.zip"
    sha256 "d940836dd251b6f731c0ac2ccdbe6c6067f59681e0a7be0d12956669bfa30e31"
  else
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-x64.zip"
    sha256 "dd1a937ea671e1619d2bd24c66acf301769bbaa2d247f61e9088529f7e259e79"
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

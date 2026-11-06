class VeloraCli < Formula
  desc "The Velora terminal app — agents, missions, and automations from your shell"
  homepage "https://runvelora.app"
  version "3.0.0-beta.18"
  license "Unlicense"

  if Hardware::CPU.arm?
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-arm64.zip"
    sha256 "9289a0585c141dc15145b40b75f418963621d13cf9c857315b0d397d6b9788a1"
  else
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-x64.zip"
    sha256 "643482c22e24151f77ed08e8bf4f2d3fe2b85bcd055a9e6b087328b66ec10528"
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

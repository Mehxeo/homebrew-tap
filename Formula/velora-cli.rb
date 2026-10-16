class VeloraCli < Formula
  desc "The Velora terminal app — agents, missions, and automations from your shell"
  homepage "https://runvelora.app"
  version "3.0.0-beta.8"
  license "Unlicense"

  if Hardware::CPU.arm?
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-arm64.zip"
    sha256 "33ae5c5f4dc4dfb15320ee05d1011b3b703b27ec7d017bd94c27f95f10dea322"
  else
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-x64.zip"
    sha256 "45ba15a92cff7c9b5e2e163c61d7e95fe61ba96cd003c1cbadf45cc553f5838c"
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

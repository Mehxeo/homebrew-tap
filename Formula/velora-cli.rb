class VeloraCli < Formula
  desc "The Velora terminal app — agents, missions, and automations from your shell"
  homepage "https://runvelora.app"
  version "3.0.0-beta.49"
  license "Unlicense"

  if Hardware::CPU.arm?
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-arm64.zip"
    sha256 "e57bc9729c7de70c457d1decd9a35e1616fc71942804612482f875e88a29ff48"
  else
    url "https://github.com/Mehxeo/Velora/releases/download/v#{version}/velora-cli-macos-x64.zip"
    sha256 "171d5c3d9ab76b328f7e240fd061591266c652dbc25153d0d2ff6700b9e53886"
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

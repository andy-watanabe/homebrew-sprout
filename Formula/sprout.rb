class Sprout < Formula
  desc "Menu bar critter showing Mac load and which Claude Code session causes it"
  homepage "https://github.com/andy-watanabe/sprout"
  url "https://github.com/andy-watanabe/sprout/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "ea4a44d01655ee7769bf19d1870f7124b3d998dc4ee86232b692508bf063a322"

  # Only swiftc (from the Xcode Command Line Tools) is needed to build this,
  # not a full Xcode.app. Homebrew already requires the Command Line Tools.
  depends_on :macos

  # Builds from source rather than shipping a prebuilt binary: nothing to
  # notarize, nothing for Gatekeeper to quarantine, and it's obvious exactly
  # what's running on your machine.
  def install
    system "swiftc", "-O", "main.swift", "-o", "sprout", "-framework", "Cocoa"
    bin.install "sprout"
  end

  def caveats
    <<~EOS
      Sprout is a menu bar app, so `sprout` won't return on its own. Run it in
      the background to start it now:

        sprout &

      To keep it running after you log in again, click Sprout in the menu bar
      and turn on "Start at Login".

      Coming from ClaudeMeter? Quit it from its menu first.
    EOS
  end

  test do
    # --dump prints the menu's lines without needing a GUI session.
    assert_match "CPU", shell_output("#{bin}/sprout --dump")
  end
end

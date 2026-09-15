cask "kepler@beta" do
  version "0.8.4,42"
  sha256 "cddb71fe0259cdd601f6d0607d29bf6bd687476ebc2f2db48f3462dc8d654d7b"

  url "https://updates.kplr.space/releases/Kepler-#{version.csv.first}-#{version.csv.second}-beta.dmg"
  name "Kepler Beta"
  desc "Keyboard-driven command bar"
  homepage "https://kplr.space/"

  livecheck do
    skip "Beta releases are verified and updated manually from the appcast"
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Kepler.app"

  caveats <<~EOS
    Kepler Beta requires macOS 15.6 or later.
    Homebrew's macOS dependency check only enforces the major version (15).
  EOS
end

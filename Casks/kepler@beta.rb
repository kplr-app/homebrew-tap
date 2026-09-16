cask "kepler@beta" do
  version "0.8.5,43"
  sha256 "1e0a708029a1341c0ea50eab6e1a0faedb11e0f8c9cf0086ba118b9cf5fafd93"

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

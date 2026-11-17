cask "kepler@beta" do
  version "0.11.0,53"
  sha256 "2c699bf57aada2ea9f93d3f9eeca5180aa82306bf5637dd5587c181b483fe665"

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

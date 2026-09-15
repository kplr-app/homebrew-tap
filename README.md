# Kepler Homebrew tap

Install the public beta of [Kepler](https://kplr.space/), a keyboard-driven command bar. This is the `kplr-app/tap` tap, not an official Homebrew cask submission.

## Install the beta

Requires **macOS 15.6 or later**, on Apple Silicon or Intel. Homebrew checks only macOS 15 or later; the app declares the exact 15.6 minimum.

```sh
brew install --cask kplr-app/tap/kepler@beta
```

The cask installs `Kepler.app`. If you already have Kepler installed, stop and decide how to migrate that installation first. Don't use `--force` to overwrite it. Beta and stable builds use the same app name and aren't side-by-side installations.

The pinned release is **0.8.4, build 42, beta**. This tap provides no stable cask. Its download URL explicitly ends in `-beta.dmg`; it never uses `https://updates.kplr.space/Kepler.dmg`, which can switch between beta and stable.

Kepler installs updates through Sparkle, so the cask declares `auto_updates true`. This describes the app's update capability, not unattended installation: Sparkle's automatic checks are disabled and Kepler drives checks itself. The app's update-channel settings remain separate from Homebrew; this cask doesn't change them or guarantee that later in-app updates stay on beta.

To explicitly upgrade through Homebrew after the tap is updated:

```sh
brew update
brew upgrade --cask --greedy kplr-app/tap/kepler@beta
```

## Maintain a release

1. Read the upstream `kepler/README.md` and `scripts/release/release.sh`. Confirm the intended public **beta** release in the [live appcast](https://updates.kplr.space/appcast.xml): check `sparkle:channel`, short version, build number, and minimum system version. Don't copy example release identifiers from documentation or select an unlabelled/stable feed entry.
2. Download the matching immutable DMG from `https://updates.kplr.space/releases/Kepler-VERSION-BUILD-beta.dmg`. Replace `VERSION` and `BUILD` with the verified feed values. Stop if it isn't publicly available; never substitute the mutable alias or a different channel.
3. Run `shasum -a 256` and `hdiutil verify` on the downloaded DMG. Mount it read-only with `hdiutil attach -readonly -nobrowse`, then inspect `Kepler.app/Contents/Info.plist`: verify `CFBundleShortVersionString`, `CFBundleVersion`, `KeplerDistributionChannel`, and `LSMinimumSystemVersion`. Run `lipo -archs` on `Kepler.app/Contents/MacOS/Kepler`. Verify DMG and app signatures with `codesign --verify --strict` (also `--deep` for the app), validate both tickets with `xcrun stapler validate`, and assess the app with `spctl --assess --type execute --verbose`. Detach the mounted image afterward. Don't install over an existing app during verification.
4. Update `version` (`VERSION,BUILD`) and `sha256` in `Casks/kepler@beta.rb`. Update the requirements and this README if metadata changes. Keep the URL's beta suffix. Livecheck is deliberately skipped: the mixed-channel appcast requires manual beta selection. Never replace bytes at an existing versioned URL.
5. Validate the cask from a local checkout registered as `kplr-app/tap`:

   ```sh
   ruby -c Casks/kepler@beta.rb
   brew style Casks/kepler@beta.rb
   brew audit --cask --strict --online kplr-app/tap/kepler@beta
   brew fetch --cask kplr-app/tap/kepler@beta
   brew info --cask --json=v2 kplr-app/tap/kepler@beta
   ```

   Homebrew 7 audits require a tap name, not a file path. `brew fetch` verifies the declared checksum without installing the app. Homebrew can download its own lint tooling when running `brew style`.
6. Review and publish the tap changes through your normal Git workflow. A stable cask requires a separate explicit decision and a verified public stable artifact.

## Metadata sources

- [Kepler homepage](https://kplr.space/) and [published appcast](https://updates.kplr.space/appcast.xml).
- [Pinned beta DMG](https://updates.kplr.space/releases/Kepler-0.8.4-42-beta.dmg) (download): SHA-256 `cddb71fe0259cdd601f6d0607d29bf6bd687476ebc2f2db48f3462dc8d654d7b`. Bundle metadata and executable architectures verified directly.
- [Homebrew Cask cookbook](https://docs.brew.sh/Cask-Cookbook) for the DSL and `auto_updates`; [Homebrew manual](https://docs.brew.sh/Manpage) for upgrade flags. Validation used Homebrew 7.0.1, including its installed DSL source for major-only macOS requirements.

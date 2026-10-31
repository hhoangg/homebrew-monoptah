cask "monoptah-native" do
  version "0.36.1"
  sha256 "d22d138cc78f223981652ed5364b18a4dcae8d509563d051f13e4467b7a07f1a"

  url "https://github.com/hhoangg/monoptah/releases/download/native-v#{version}/MonoptahNative_#{version}_aarch64.zip"
  name "Monoptah Native"
  desc "Experimental native (Rust + GPUI) build of Monoptah"
  homepage "https://github.com/hhoangg/monoptah"

  # Native releases are tagged native-vX.Y.Z and are never the repo's "latest"
  # release, so look at the release list instead of github_latest.
  livecheck do
    url :url
    regex(/^native-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The app updates itself from the fork's native-latest feed, so Homebrew
  # should not treat an updated app as a damaged install.
  auto_updates true
  # Only an arm64 build is published.
  depends_on arch: :arm64
  depends_on :macos

  app "Monoptah Native.app"

  # Only Native's own paths. Its database and preferences live in the
  # Monoptah (Tauri) data directory, com.monoptah.desktop, which is not removed.
  zap trash: [
    "~/Library/Caches/com.monoptah.native",
    "~/Library/HTTPStorages/com.monoptah.native",
    "~/Library/Preferences/com.monoptah.native.plist",
    "~/Library/Saved Application State/com.monoptah.native.savedState",
  ]

  caveats <<~EOS
    Monoptah Native is experimental. It installs next to Monoptah (the Tauri
    app) and does not replace it.

    It is signed ad-hoc rather than with an Apple Developer certificate, so
    macOS will refuse to open it the first time. To allow it once, open
    System Settings > Privacy & Security, scroll to Security, and choose
    "Open Anyway" next to Monoptah Native. Afterwards it launches normally, and
    the app updates itself from #{homepage}/releases.

    Both apps share one database (com.monoptah.desktop/monocode.db). Run only
    one of them at a time while Telegram forwarding, Contributors sync or
    scoring, or scheduled Mono workflows are on, and avoid editing the same
    conversation in both. Settings changed in Native are stored separately from
    Monoptah's. Uninstalling Native does not remove the shared data.
  EOS
end

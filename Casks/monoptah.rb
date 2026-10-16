cask "monoptah" do
  version "0.23.1"
  sha256 "cb6859b1016f144211756243b79f74ef7346913bf11adb1b15b0b0c42f88193a"

  url "https://github.com/hhoangg/monoptah/releases/download/v#{version}/Monoptah_#{version}_aarch64.zip"
  name "Monoptah"
  desc "One UI for every agent harness"
  homepage "https://github.com/hhoangg/monoptah"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from the fork's releases, so Homebrew should not
  # treat an updated app as a damaged install.
  auto_updates true
  # Only an arm64 build is published.
  depends_on arch: :arm64
  depends_on :macos

  app "Monoptah.app"

  zap trash: [
    "~/Library/Application Support/com.monoptah.desktop",
    "~/Library/Caches/com.monoptah.desktop",
    "~/Library/HTTPStorages/com.monoptah.desktop",
    "~/Library/Preferences/com.monoptah.desktop.plist",
    "~/Library/Saved Application State/com.monoptah.desktop.savedState",
    "~/Library/WebKit/com.monoptah.desktop",
  ]

  caveats <<~EOS
    Monoptah is signed ad-hoc rather than with an Apple Developer certificate,
    so macOS will refuse to open it the first time with a message about an
    unidentified developer.

    To allow it once:
      Open System Settings > Privacy & Security, scroll to Security, and choose
      "Open Anyway" next to Monoptah. Or right-click the app in Finder and
      choose Open.

    Afterwards it launches normally, and the app updates itself from
    #{homepage}/releases.
  EOS
end

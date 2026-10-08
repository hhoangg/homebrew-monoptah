cask "monoptah" do
  version "0.9.4"
  sha256 "e88673aa0071d661f6008c4358d1c98c66afa48062c0c626800d3c4147dc5376"

  url "https://github.com/hhoangg/monoptah/releases/download/v#{version}/Monoptah_#{version}_aarch64.zip",
      verified: "github.com/hhoangg/monoptah/"
  name "Monoptah"
  desc "One UI for every agent harness"
  homepage "https://github.com/hhoangg/monoptah"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Only an arm64 build is published.
  depends_on arch: :arm64
  depends_on macos: ">= :high_sierra"

  app "Monoptah.app"

  # The app updates itself from the fork's releases, so Homebrew should not
  # treat an updated app as a damaged install.
  auto_updates true

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

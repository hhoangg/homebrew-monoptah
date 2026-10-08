# Homebrew tap for Monoptah

[Monoptah](https://github.com/hhoangg/monoptah) is one UI for every agent harness —
a fork of [monocode](https://github.com/hardbeat920/monocode).

```sh
brew tap hhoangg/monoptah
brew trust hhoangg/monoptah
brew install --cask monoptah
```

Homebrew 7 refuses to load casks from a third-party tap until you trust it, so the
`brew trust` step is required — without it the install stops with "Refusing to load
cask ... from untrusted tap".

Apple Silicon only.

## First launch

The app is signed ad-hoc rather than with an Apple Developer certificate, so macOS
refuses to open it the first time and reports an unidentified developer. Allow it once
in **System Settings → Privacy & Security → Open Anyway**, or right-click the app in
Finder and choose **Open**. After that it starts normally.

Homebrew no longer offers a flag to skip this check: `--no-quarantine` was removed in
Homebrew 5.0 because it bypassed macOS security. The prompt is the honest cost of an
unsigned build.

## Updating

The app updates itself from the releases of the main repository, so `brew upgrade` is
not usually needed. This tap exists to install it in the first place.

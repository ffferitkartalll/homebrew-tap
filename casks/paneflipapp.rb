cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.3"
  # The disk image is built when the release is published, after this file is merged: its checksum cannot be known here.
  sha256 :no_check

  url "https://github.com/ffferitkartalll/paneflipapp/releases/download/v#{version}/PaneFlip-#{version}.dmg"
  name "PaneFlip"
  desc "Zones for displays, with stacked apps switched by a glass pill"
  homepage "https://github.com/ffferitkartalll/paneflipapp"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "PaneFlip.app"

  # The app is signed with a certificate of its own, not an Apple developer one: without this macOS refuses the first open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PaneFlip.app"]
  end

  # BEGIN release notes (written by the Release workflow of the app)
  caveats <<~'EOS'
    What's new in PaneFlip 1.3:

    Float a zone over the middle of another zone: one window at a time that glides in and out beyond the screen's edge as the focus comes and goes (#364)

    A layout can have one floating zone: a window of its own over the middle of one of its zones, a quarter to three quarters of that zone's size. Dropped windows and apps assigned to it live there, one in view at a time. The window that has the focus is shown; when the focus goes to another window it glides out beyond the screen's right edge, and when it comes back, or another window of the zone is chosen with the Dock or Cmd+Tab, that window glides in, with the same spring as the slides inside a zone. The zone never stacks windows: it has no pill. It is set per layout in Settings, in the layout's card.

    * Translate the texts that stayed in English in Indonesian, Malay and Filipino (#363)
    * Show the pictures that stand in for windows while they slide with the shadow and rounded corners of a window (#365)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

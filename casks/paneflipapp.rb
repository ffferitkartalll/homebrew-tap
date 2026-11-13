cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.6"
  # The disk image is built when the release is published, after this file is merged: its checksum cannot be known here.
  sha256 :no_check

  url "https://github.com/ffferitkartalll/paneflipapp/releases/download/v#{version}/PaneFlip-#{version}.dmg"
  name "PaneFlip"
  desc "Zones for displays, with stacked apps switched from an island in the menu bar"
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
    What's new in PaneFlip 1.6:

    See all the windows of a zone as a grid, and open it with a mouse wheel click or a swipe (#677)

    A zone's windows can be shown as a grid of pictures laid over the zone, the way Mission Control lays out windows. A click on a card chooses that window, a card can be carried to another place, and a click on the dimmed zone closes the grid. The grid opens and closes with one smooth movement.

    * The notch of a zone shows its windows as parts, the front one in the accent colour, at rest too (#672)
    * Settings to open the zone notch only on a click, and to light it up while windows switch (#674)
    * The lit part of the notch slides to the window in front, and the notch stays in sight while windows switch (#675)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

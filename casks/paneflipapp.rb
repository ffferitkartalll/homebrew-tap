cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.5.1"
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
    What's new in PaneFlip 1.5.1:

    * Show the Dock's notification badge on the cards of a zone's notch (#633)
    * Fade the buttons of the cards in the expanded notch in and out (#635)
    * Do nothing when the trackpad swipe goes toward a window or a screen that is not there (#637)
    * Fit the open notch's cards to the notification badges that come and go (#639)
    * Show the Dock's notification badge on a zone's notch that opens after the notification came (#641)
    * Keep a zone at an aspect ratio in the layout editor (#643)
    * Make a grid of zones in the layout editor (#645)
    * Layouts, Grid and Reset of the layout editor work on the screen in view (#646)
    * Zones of equal size are shown equal, and merging two zones leaves the others as they were (#647)
    * The lines of the zones reach the edge of the usable screen, and keep a zone's aspect ratio on the desktop too (#648)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

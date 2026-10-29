cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.3"
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
    What's new in PaneFlip 1.4.3:

    * Move the zone focus shortcuts to Control+Option and I, J, K, L (#454)
    * Remove the note about unplugged screens from the layout apps settings (#456)
    * Send the focused window to a zone with the keyboard, through the island (#458)
    * Arrange the displays as a staircase and set where they stand on your desk in a new Displays tab (#461)
    * Move the focus through the zones beyond the screen's edge before it goes to another display (#462)
    * Give the focus to the window it was moved to when its app has a window on another display (#463)
    * Show the Apps tab between Shortcuts and Updates in Settings (#464)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

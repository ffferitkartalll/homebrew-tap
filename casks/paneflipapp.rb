cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.1"
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
    What's new in PaneFlip 1.4.1:

    * Show every window's title in the island's window row, with Closed, Hidden or Minimized under the title of an app that is not open (#409)
    * Scroll the layout back to the screen's own zones when the focus goes to one of them, from the keyboard, the island or a click (#410)
    * Fit the cards of the island's window row within the island: the one in front keeps the width of the frame, the others share the rest (#413)
    * Widen the open island where a zone holds several windows and zones do not wait beyond both edges of the screen (#414)
    * Open the island's window row together with the island when the pointer comes onto it while a zone has the focus (#416)
    * Put the windows of a zone in another order by dragging their cards in the island's window row (#418)
    * Put a dragged window in a chosen place among a zone's windows by waiting over the zone in the open island (#420)
    * Hide the island, sliding it up, while an app is full screen or Mission Control or App Exposé is open, and bring it back down afterwards (#422)
    * Remove moving through a zone's windows with the mouse's wheel button (#424)
    * Remove the pill: the island in the menu bar is the only place that shows and switches a zone's windows (#426)
    * Always stack apps in a zone: remove the switch for it from Settings (#427)
    * Give PaneFlip a new app icon and menu bar icon: three zones side by side with two windows in the middle one (#433)
    * Switch PaneFlip on and off with a left click on the menu bar icon, and open the menu with a right click (#434)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

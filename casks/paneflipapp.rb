cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.7"
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
    What's new in PaneFlip 1.7:

    The grid of the whole layout shows every zone of every display, those beyond the edges too, with the windows of each (#703)

    One view shows the whole layout: every zone of every display, the zones of the screens beyond the edges too, each with the grid of its windows, as the grid of one zone shows them. It opens with the island's "Switch to grid view" button, the layout grid shortcut (Command+Option+Control+Tab, or Caps Lock+Shift+Tab with Caps Lock as a modifier key, changeable in the Shortcuts tab), a click of the mouse's wheel button, or a swipe up with two fingers (with the keys that scroll toward the screens beyond the edges held) or four fingers, and the swipe leads it like the grid of one zone. Two fingers sideways, at the speed of the layout's own scroll, and the mouse wheel go from one screen to the next; the arrow keys go from card to card, on to the other displays too. The panel covers the whole display, so nothing cuts the cards' shadows, and the desktop is not dimmed.

    * A swipe with three or four fingers also scrolled the window under the pointer (#681)
    * The grid of a zone's windows opens and closes at the pace of the other swipes, and can be caught in the middle (#683)
    * Lighting the zone notch while windows switch is off by default (#685)
    * The zone notch no longer shows in Mission Control (#690)
    * The island stays closed under the pointer while the grid of a zone's windows shows (#691)
    * The desktops in the Layouts tab are numbered as the system numbers them (#693)
    * The screens beyond the screen's edges need no switch, and the windows of a removed one go to the default zone (#695)
    * The buttons that add a screen beyond an edge are in the layout editor's top row (#696)
    * The buttons of the open island are evenly spaced on a display without a notch (#697)
    * A setting lets scrolling between screens stop at the lines between zones (#699)
    * The focus moves on to the zones of the screens beyond the edge (#700)
    * The frame of the focus comes in with the zone when the layout scrolls to it (#701)
    * A card is carried to any zone, and the other cards make room where the pointer is (#704)
    * Every place of a zone's grid has a dashed line, and the cards of apps that are not open come in fully visible (#705)
    * The shadows of the cards in a zone's grid are not cut near the zone's edge (#706)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

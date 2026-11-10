cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.5"
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
    What's new in PaneFlip 1.5:

    Add a notch to every zone that opens a row of its windows (#603)

    Every zone that holds a window has a small notch at the top middle of its edge. It lights up when the pointer is on it. A click on it opens a row of the zone's windows; a click on a card of the row brings that window to the front of the zone and gives it the focus. The wheel and two fingers on the notch switch the zone's windows, as on the open island's row of cards. Each card is as wide as its window's name, up to the width the island gives a title (a longer name ends in "..."). The row stays open while the pointer is on it.

    * Edit the layout, open the selected apps, open Settings or quit from the open island (#572)
    * Choose the apps to start with a layout from the cards of the open island (#574)
    * Choose the default zone of a layout in the layout editor (#575)
    * Set the gap between zones, the margin at screen edges and the minimum zone size in the layout editor (#576)
    * Show the screens beyond the edge like the screen in the layout editor (#577)
    * Remove the Apps button and its sheet from the Layouts tab (#578)
    * Set the gap, the edge margin and the minimum zone size for each layout of each screen (#580)
    * Cards of apps that are not open say why in brackets after their title (#582)
    * The open island has a row of buttons with a symbol and words, and the same room everywhere (#583)
    * Everything the pointer can click in the open island lights up under it (#584)
    * Turn zone edge editing on with a right click on Edit layout (#585)
    * The Shortcuts tab of Settings no longer grows past the height limit (#586)
    * The open island casts a soft shadow (#589)
    * The buttons in the top row of the island are as large as the layout editor's buttons (#590)
    * Everything that can be clicked in Settings lights up under the pointer (#591)
    * Settings keeps its accent colour while the window is not in front (#592)
    * A card carried out of the island lights the zones like a dragged window does (#593)
    * Lit zones have the corners of a window (#594)
    * Give the island a faint rim so it shows against a black window behind it (#596)
    * Keep the margin of the layout round the screen's edges when a window is enlarged (#600)
    * Make the buttons of the island's message line as large as the buttons of its top row (#601)
    * Show the switch of a zone's windows in the zone's notch, not in the island (#604)
    * Do not open the focused zone's windows when the pointer comes onto the island (#605)
    * Keep the island's row of windows inside the island while it opens and closes (#607)
    * Switch a zone's windows only when the zone has the focus and the pointer is on it (#609)
    * Bring a zone's window forward when its card is clicked in a zone without the focus (#610)
    * Keep a window that is in no zone in front while the layout scrolls to other screens (#611)
    * Leave a zone's notch as it is while the island shows its row of windows (#612)
    * Tint the card under the pointer in a zone's open notch (#614)
    * Open the notch of a zone with one window by a click (#615)
    * Draw app icons smoothly (#617)
    * Slide to the window when its card is clicked in a zone without the focus (#619)
    * Sort the windows of a zone by dragging their cards in its notch (#621)
    * Make the notch of a zone as wide as its open windows ask (#623)
    * Cut the notch under the pointer into a part for each open window (#624)
    * Grow the notch into its row of windows, and back, as one movement (#625)
    * Expand the open notch into the island's row of cards with a "more" button (#627)
    * Sort the windows by dragging their cards in the expanded notch (#628)
    * Put the button that ticks an app to start with the layout to the left of the remove button (#629)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

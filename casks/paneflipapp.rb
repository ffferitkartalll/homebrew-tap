cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.7.1"
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
    What's new in PaneFlip 1.7.1:

    * The arrow keys in the grid of the whole layout go to the screen that lies beside or below, as the desk shows (#710)
    * One card is chosen at a time, and the card with the focus is the chosen one while the pointer is on none (#711)
    * The shadows of the cards in the grid of a zone's windows are not cut at the menu bar or the Dock (#713)
    * The card that is carried in a grid grows as it is taken up instead of at once (#714)
    * The windows of a display that is unplugged are left alone (#716)
    * Every display starts with a layout of one zone (#718)
    * The last layout of a display cannot be removed, only reset (#719)
    * The first layout of a display is its default layout (#721)
    * Layouts that were not renamed are named in the app's language (#722)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

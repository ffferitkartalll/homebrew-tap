cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.5.2"
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
    What's new in PaneFlip 1.5.2:

    * The list of layouts in the layout editor scrolls (#654)
    * The screens beyond the edge show the gap and the margin in the layout editor, and the line to be made reaches the edge (#655)
    * The buttons and the hints of the layout editor show only when asked for (#656)
    * Choose whether PaneFlip works as an island; without it, the menu bar icon opens it as a popover (#658)
    * Only the zone with the focus shows a notch, on whichever display it is (#662)
    * The notch of a zone is out of sight while one of its windows is dragged (#667)
    * A window put back by Undo returns to its place among the zone's windows, not to the end (#668)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

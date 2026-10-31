cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.6"
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
    What's new in PaneFlip 1.4.6:

    * Quit, close, hide, minimize or remove a window from its card on the island (#498)
    * Show an app that is not running as "Not running" on its card (#499)
    * Show the windows of a zone on 16:9 cards as tall as the screen in the island's picture (#500)
    * Open the island fully when the pointer comes onto it while the windows of a zone are shown alone (#501)
    * Keep the island usable while an undo message shows (#502)
    * Scroll from one screen of the layout to the next, not to the lines between zones (#505)
    * Move the focus between zones on the screen first, then on to the other display, never to the screens beyond the edge (#506)
    * Call the zones beyond the screen's edges "screens" in the app, the README and the website (#507)
    * Keep the windows of screens beyond the edge completely out of sight, on a hidden display for each display (#509)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

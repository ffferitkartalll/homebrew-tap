cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.8"
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
    What's new in PaneFlip 1.4.8:

    * Windows behind in a stack no longer show during a scroll beyond the edge (#528)
    * Scrolls beyond the edge keep a steady frame rate (#529)
    * The Settings window no longer slows the scrolls beyond the edge, open or closed (#531)
    * Windows behind in a stack show less often in a scroll beyond the edge (#532)
    * Use Caps Lock as a modifier key of the shortcuts (#536)
    * Show the Settings window's tabs live again (#537)
    * Keep the send-to-zone shortcut for other apps when it would do nothing (#540)
    * Give Caps Lock back when the app is stopped or crashes (#541)
    * Open Settings when the running app is opened again (#546)
    * Let the Settings window go behind other windows and grow up to 960 pt (#547)
    * Show only the accent colour in Settings (#548)
    * Open Settings when the app is opened again, also while the island is shown (#550)
    * Ask before a layout is removed (#551)
    * Keep the scrolls smooth after the Settings window was closed (#553)
    * Try the Caps Lock key mapping again when it failed, mark the layout removal button as destructive (#555)
    * Scrolls no longer photograph windows that are out of view (#557)
    * Drag a card of the island's window row onto a zone of the island or of the screen, or out of its zone (#559)
    * Show the Dock's notification badge on the cards of the island's window row (#561)
    * Show the notification badge of a card where its remove button stands (#563)
    * Move the lines between zones by hand on the desktop, and undo the moves (#565)
    * Give every screen beyond the edge its own margin and a gap to the next one, and let the scroll skip the gap (#566)
    * Number the zones of screens further beyond the edge with a sign more for each screen (#567)
    * Drag a window into a zone with Control and Option by default (#568)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

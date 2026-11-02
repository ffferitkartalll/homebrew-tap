cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.7"
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
    What's new in PaneFlip 1.4.7:

    * Windows show how they look now when switching between windows of a zone and scrolling to screens beyond the edge (#513)
    * A two-finger swipe no longer jumps ahead while the pictures are taken, and one lifted early still moves one step (#514)
    * Scrolls to screens beyond the edge and swipes start sooner (#515)
    * The island shows the step when two fingers lift before the pictures of a swipe through a zone's windows are ready (#517)
    * Stepping through a zone's windows no longer jumps over a window or goes back (#519)
    * Scrolling beyond the screen's edge no longer dims the menu bar or drops frames (#521)
    * Slides and scrolls run at a steadier frame rate and use less CPU (#522)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

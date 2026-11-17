cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.8"
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
    What's new in PaneFlip 1.8:

    Choose the layout of every display at once and where the windows of an unplugged display go (Scenes) (#726)

    A scene sets the layout of each display in one go and says where the windows of a display go when it is unplugged. Switch scenes in the new Scenes tab or from the menu bar. When a display is unplugged, its windows move to the zones you chose for them or, where you chose none, to the zones that lie nearest to them on your desk, and they go back to their own zones when the display is plugged in again.

    * Preview a layout large with the zones beyond the screen's edges, and see every layout as large as its display on the desk (#727)
    * Lines between zones were cut off in the pictures of layouts on some displays (#728)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

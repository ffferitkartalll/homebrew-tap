cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.2"
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
    What's new in PaneFlip 1.4.2:

    * Hide the island while the layout editor is open (#438)
    * Spread the windows of an unplugged display over the remaining display and bring them back when it returns (#442)
    * Lay out a display that was unplugged with the Dock on it as if the Dock were still there (#444)
    * Windows of an unplugged display return to the zones they came from when it is plugged in again (#446)
    * Keep a two-finger swipe from sticking when the system switches the scroll listener off (#447)
    * Return to the menu bar when the Settings window cannot be opened (#448)
    * Do not wait for the Dock after a display change without the Accessibility permission (#449)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.4"
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
    What's new in PaneFlip 1.4.4:

    * Move the pointer between displays by the arrangement on your desk (#468)
    * Use the real size of the displays for the arrangement on your desk (#469)
    * Show the windows of a zone on the island while you step through them (#471)
    * Show all cards of the island's window row at full width and widen the island to hold them (#472)
    * Remove the spring from the movements of the island (#473)
    * Do not show a frame in the window row of a zone with no open window (#474)
    * Stop apps that are not open showing as closed in the default zone after switching the zones beyond the edges off and on (#475)
    * Bring only the window you move the focus to forward, not the other windows of its app (#476)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

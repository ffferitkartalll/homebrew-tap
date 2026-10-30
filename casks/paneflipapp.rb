cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4.5"
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
    What's new in PaneFlip 1.4.5:

    * Show the closed island on both sides of the notch (#480)
    * Remove the floating zone (#482)
    * Remove the shadow of the pictures of sliding windows (#483)
    * Stop the app from freezing when the app in focus is slow to answer (#484)
    * Place and list windows off the main thread, and leave a slow app alone for a while (#485)
    * Keep the pointer from stalling while the app is busy (#486)
    * Do not show the old window for a moment after a slide when the next window comes forward slowly (#487)
    * Make the island lighter while it rests (#488)
    * Clicking a window card on the open island while a slide runs now takes the slide over at once (#490)
    * Undo adding a window to a zone or taking it out, with a message on the island and a shortcut (#492)
    * Enlarge a window of a zone to the whole usable area of its screen for 15 seconds (#494)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.4"
  # The disk image is built when the release is published, after this file is merged: its checksum cannot be known here.
  sha256 :no_check

  url "https://github.com/ffferitkartalll/paneflipapp/releases/download/v#{version}/PaneFlip-#{version}.dmg"
  name "PaneFlip"
  desc "Zones for displays, with stacked apps switched by a glass pill"
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
    What's new in PaneFlip 1.4:

    A menu bar island shows the zones of each display and the zone you are in (#371)

    PaneFlip now has an island in the menu bar of every display. It hangs from the notch, or sits in the middle where there is none, and shows the zones of that display drawn small, the ones beyond the screen's edges too, with the zone of the window you are working in lit up and its name beside it. When you scroll through the zones, the frame of the screen glides along with the real windows.

    The island opens below the menu bar when the pointer is on it and shows every zone with its name (#375)

    Move the pointer onto the island in the menu bar and it grows below the menu bar and shows every zone, with its name or number. The zone with the focus stays lit. When the pointer leaves, the island shrinks back.

    Drop a dragged window on a zone of the island (#376)

    Drag a window onto the island and it opens; drop the window on one of its zones and it goes into that zone, whether the window was in a zone before or not. Zones beyond the screen's edges can be dropped on too (the window waits there and the layout does not scroll). The zone the window would go into lights up while you drag, and the island closes again when you drop.

    Show and scroll the windows of a zone in the open island (#389)

    Clicking a zone in the open island opens a carousel of that zone's windows under the picture. The front window fills a frame as large as the zone, the other windows lie against it, and the mouse wheel and two fingers scroll through them in step with the slide inside the zone. Clicking the zone again closes it.

    * A small, quick swipe with two fingers moves on to the next zone, also after catching a glide (#372)
    * The zone in the island shows - and + beyond the edges, and takes no room when no zone has the focus (#377)
    * The frame in the island glides with the scroll on a display with no windows too (#380)
    * The open island shows the real gap between the zones (#381)
    * The island shows only the zones, in the middle of the screen (#382)
    * On a display with a notch the island shows only when the pointer comes (#383)
    * The map of the strip no longer shows in the corner of the screen while the layout scrolls (#384)
    * The windows behind the island no longer see the pointer (#385)
    * Scroll the zones with the mouse wheel or two fingers over the open island (#388)
    * Fix stutter when scrolling the windows of a zone quickly (#390)
    * Light the zone with the focus in the island at once, also beyond the screen's edge, and when it is clicked (#392)
    * Write the zone numbers of the island in the menu bar's font and hide them as the island shrinks (#393)
    * Use the island's green as the app's accent colour, in the controls too, and highlight the zone the focus reaches with a thin frame (#394)
    * Fix quick focus moves between zones with the keyboard, beyond the screen's edge too (#395)
    * Fix the delay of the focus and the stalls of the app when a slow app such as Mail takes the focus (#396)
    * Show the windows of the zone with the focus as soon as the pointer comes onto the island (#397)
    * Use the system accent colour everywhere, and the app's green when the system accent is Multicolor (#399)
    * Choose a window from the window row of the open island and bring it to the front (#400)
    * Let a click on a zone beyond the screen's edge in the open island scroll it into view and focus it, without a focus frame (#401)
    * Show the window title as far from the frame as from the island's lower edge (#402)
    * Remove the shake of the pointer that switched the window snapping on during a drag (#403)
    * Show the apps of a zone that are not open in its window row, with Closed, Hidden or Minimized under them, and open them with a click (#404)
    * Complete the translations of the strings that had none (#405)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

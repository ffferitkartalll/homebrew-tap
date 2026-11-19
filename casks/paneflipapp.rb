cask "paneflipapp" do
  # A release pull request raises this together with MARKETING_VERSION in macos/project.yml (the Tests workflow checks).
  version "1.8.1"
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
    What's new in PaneFlip 1.8.1:

    * An app that is not open opens in the zone it was moved to, also on another display (#732)
    * The Layouts tab no longer activates layouts or shows desktops, and Import and Add sit in each display's title row (#734)
    * A layout chosen for a display in the scene in use is put on it at once (#736)
    * The menu switches scenes instead of layouts (#737)
    * Windows go to the zones that lie where theirs lay when another layout is put on a display (#739)
    * A right click on a layout in a scene shows the apps in its zones (#740)
    * The layout choice of a scene tells what a right click on a layout does (#742)
    * Each scene keeps its own windows, also when two scenes use the same layout (#744)
    * Windows the chosen scene does not remember are stacked in the display's usable area (#745)
    * A right click on a layout in a scene shows that scene's apps, and does nothing for the layout in use (#746)
    * Each layout of a scene keeps its own windows, so changing one never changes another (#748)
    * The layout pictures in Settings are no longer huge when only one display is connected (#750)
    * The title and the buttons of the cards in the grid view stand out in the accent colour (#752)
    * The cards of apps that are not open no longer grow out of the middle when the grid view opens (#754)
    * Step through the layouts of a display in the Layouts tab with the mouse wheel, and let the row rest on the nearest layout (#756)
    * The grid view of a whole layout opens and closes as smoothly as the grid of one zone (#758)
    * Cards of apps that are not open stay behind the open cards while the grid view slides (#759)
    * A card closed or quit in the grid view turns into the card of a closed app (#760)
    * The grid views no longer jump to where the fingers went while the windows were moving away (#761)

  EOS
  # END release notes

  zap trash: [
    "~/Library/Application Support/PaneFlip",
    "~/Library/Preferences/dev.ffferitkartalll.paneflip.plist",
  ]
end

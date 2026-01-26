# Homebrew Cask for CatsUp
# Install: brew install --cask geiserx/catsup/catsup

cask "catsup" do
  version "0.0.2"
  sha256 "e3a5a7e97192104999526bb9320aae39e5be243d54dc0e17799d7b941dda8dc1"

  url "https://github.com/GeiserX/CatsUp/releases/download/v#{version}/CatsUp-#{version}.dmg"
  name "CatsUp"
  desc "AI-powered meeting assistant that runs locally"
  homepage "https://github.com/GeiserX/CatsUp"

  depends_on macos: ">= :ventura"

  app "CatsUp.app"

  postflight do
    # Remove quarantine attribute to avoid Gatekeeper warning
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/CatsUp.app"],
                   sudo: false
    
    # Sign the app after installation (ad-hoc) for permissions to work
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/CatsUp.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/CatsUp",
    "~/Library/Preferences/com.geiserx.catsup.plist",
    "~/Library/Caches/com.geiserx.catsup",
  ]
end

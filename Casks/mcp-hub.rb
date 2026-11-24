cask "mcp-hub" do
  arch arm: "arm64", intel: "x86_64"

  version "1.3.1"
  sha256 arm:   "267d6522e1f334ee9950f47e544a54da96f35aeede55bef2ebde73e626a2f8a8",
         intel: "4cf4b7adb2fac15ab5dd7ccfee2438215c8107baadce1cff74f2dbfc43bb5362"

  url "https://github.com/LuigiElleBalotta/mcp-hub/releases/download/#{version}/mcp-hub-gui-macos-#{arch}.zip"
  name "mcp-hub"
  desc "Shared local hub for MCP servers and Rizzo Flow / Jev"
  homepage "https://github.com/LuigiElleBalotta/mcp-hub"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "mcp-hub-gui.app"
  # `mcp-hub serve | import | apply`: the app binary also works as the CLI.
  binary "#{appdir}/mcp-hub-gui.app/Contents/MacOS/mcp-hub-gui", target: "mcp-hub"

  # The app is not signed or notarized: drop the download quarantine flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/mcp-hub-gui.app"]
  end

  zap trash: "~/Library/Application Support/mcp-hub"
end

cask "mcp-hub" do
  arch arm: "arm64", intel: "x86_64"

  version "1.1.1"
  sha256 arm:   "78a737e327881ada33c96b74de433228b6fd1fca7aa6892069f834905f684cd2",
         intel: "9749b24af2c73236fad9527d7fb625890444698cc9ef7fdd559fb35659dad830"

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

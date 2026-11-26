cask "mcp-hub" do
  arch arm: "arm64", intel: "x86_64"

  version "1.3.3"
  sha256 arm:   "3031f53124e120f66696dfc2d5c7d6b34de815fb95b9fd54d006c2c316c18fd4",
         intel: "7805ec1c2a80edda43df3be7cbe0ea3793e4797e815c33ab5dd32f3fa2df3361"

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

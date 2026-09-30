cask "mcp-hub" do
  arch arm: "arm64", intel: "x86_64"

  version "1.1.2"
  sha256 arm:   "efeaff8ccbc02ad0d7af77d6e6d2c48ed2c104c3a6fa84fc175265d327d350ec",
         intel: "1c1dcf25f635c090bdde57f762e609ed3471978a59da8d74238cf1977429af9d"

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

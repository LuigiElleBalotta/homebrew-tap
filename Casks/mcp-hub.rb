cask "mcp-hub" do
  arch arm: "arm64", intel: "x86_64"

  version "1.2.0"
  sha256 arm:   "5132ccd5eeda6142117c979a8bd0d02e1aa17a7897d26bedad6f8aeb8e33d4b4",
         intel: "56174f9db0ce3b4180fe6f651b7854de593d670ed7b033f20f629c96878930b0"

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

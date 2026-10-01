# homebrew-tap

Homebrew tap of [LuigiElleBalotta](https://github.com/LuigiElleBalotta).

## mcp-hub (macOS, experimental)

Verified: install with Homebrew and app start-up on an **Intel** Mac. Not verified yet: Apple Silicon.

[mcp-hub](https://github.com/LuigiElleBalotta/mcp-hub) shares one instance of each MCP server between all
your Claude Code sessions, and manages Rizzo Flow / Jev.

```sh
brew tap LuigiElleBalotta/tap
brew trust LuigiElleBalotta/tap
brew install --cask mcp-hub
```

Homebrew 6.0 and later asks you to trust a third-party tap before its code runs: `brew trust` is that
one-time consent (older Homebrew versions do not have the command; skip it there).

- Installs `mcp-hub-gui.app` in `/Applications` (Apple Silicon or Intel, picked automatically) and removes the
  download quarantine flag (the app is not signed or notarized), so there is no "damaged app" warning.
- Adds the `mcp-hub` command (`mcp-hub serve | import | apply`), the same binary as the app.
- Update with `brew upgrade --cask mcp-hub`; the app's **Installa e riavvia** button does the same.
- Remove with `brew uninstall --cask mcp-hub` (`--zap` also deletes `~/Library/Application Support/mcp-hub`).

The cask follows the latest GitHub release; `scripts/update_cask.py` rewrites the version and both checksums
(a workflow runs it every 6 hours and on request).

---

Tap di [LuigiElleBalotta](https://github.com/LuigiElleBalotta). Per installare mcp-hub su macOS:
`brew tap LuigiElleBalotta/tap && brew trust LuigiElleBalotta/tap && brew install --cask mcp-hub`
(`brew trust` serve da Homebrew 6.0: è il consenso, una tantum, a eseguire il codice della tap). Aggiornamento: `brew upgrade --cask mcp-hub`
(oppure il pulsante **Installa e riavvia** dell'app). L'app non è firmata: il cask toglie da solo la quarantena.

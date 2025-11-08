# RustDesk Server Pro - Home Assistant Add-on Repository

Self-hosted RustDesk Pro server add-on for Home Assistant. Run your own private remote desktop server as an alternative to TeamViewer, AnyDesk, and other commercial solutions.

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmekenthompson%2Fhass-addon-rustdesk-server-pro)

## Add-ons in This Repository

### [RustDesk Server Pro](rustdesk-server-pro)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]

Run a complete RustDesk Pro server with web-based admin console, multiple concurrent connections, and enterprise features.

**Features:**
- 🔐 Self-hosted remote desktop solution
- 🌐 Web-based admin console
- 🚀 Better performance and reliability
- 📱 Support for Windows, macOS, Linux, Android, iOS
- 🔒 End-to-end encryption
- 📋 Address book and device management

## Installation

### Step 1: Add Repository

Click the button above or manually add this repository to your Home Assistant:

1. Navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the **⋮** menu in the top right
3. Select **Repositories**
4. Add this repository URL:
   ```
   https://github.com/mekenthompson/hass-addon-rustdesk-server-pro
   ```
5. Click **Add** → **Close**

### Step 2: Install Add-on

1. Refresh the Add-on Store page
2. Find "RustDesk Server Pro" in the list
3. Click on it and press **Install**
4. **Wait for the build to complete** (first install builds the Docker image locally - this may take 5-10 minutes)
5. Once built, click **Start**

> **Note:** This add-on builds locally on your Home Assistant instance. No pre-built images are used.

### Step 3: Configure

The add-on works out of the box with no configuration required. See the add-on's documentation tab for detailed setup instructions including:

- How to obtain and install your RustDesk Pro license
- Configuring RustDesk clients to use your server
- Accessing the web admin console
- Port forwarding for remote access
- Troubleshooting common issues

## Requirements

- **RustDesk Pro License**: This add-on requires a valid RustDesk Pro license. Purchase from [RustDesk](https://rustdesk.com/pricing.html) or request a trial.
- **Host Networking**: The add-on uses host networking which is required for licensing to function properly.
- **Ports**: Ensure ports 21114-21119 are available on your Home Assistant host.

## Support

- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/mekenthompson/hass-addon-rustdesk-server-pro/issues)
- **RustDesk Documentation**: [Official RustDesk Docs](https://rustdesk.com/docs/)
- **Community**: [RustDesk Discord](https://discord.com/invite/nDceKgxnkV)

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Development

This add-on was created with AI assistance using:
- **[Amp by Sourcegraph](https://ampcode.com)** - AI coding agent
- **Claude 3.5 Sonnet** - LLM for code generation and documentation

See [AGENTS.md](AGENTS.md) for information to help AI agents contribute to this project.

## Disclaimer

This is an unofficial add-on and is not affiliated with RustDesk. RustDesk and RustDesk Server Pro are trademarks of their respective owners.

---

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg

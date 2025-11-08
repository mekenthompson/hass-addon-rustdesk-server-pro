# AGENTS.md - AI Development Guide

This add-on was created with AI assistance. This file helps AI agents understand the project structure and make better contributions.

## Project Overview

Home Assistant add-on for RustDesk Server Pro - a self-hosted remote desktop solution.

## Key Technologies

- **Base Image**: `rustdesk/rustdesk-server-pro:latest`
- **Services**: hbbs (main server), hbbr (relay server)
- **Ports**: 21114-21119 (TCP/UDP)
- **Data Storage**: `/config` (mapped to `addon_config`)
- **Networking**: Host networking (required for licensing)

## Build Process

This add-on builds **locally on Home Assistant** - no external image registry or CI/CD pipeline.

When a user installs the add-on:
1. Home Assistant reads the Dockerfile from the repository
2. Builds the Docker image on the user's hardware
3. Runs the container with host networking

## Important Files

### config.yaml
- Defines add-on metadata, ports, architecture support
- Uses `addon_config:rw` for persistent storage
- No `image:` field (forces local build)

### Dockerfile
- Based on official RustDesk Pro image
- Adds bash for Home Assistant integration
- Copies run.sh as entrypoint

### run.sh
- Starts both hbbr and hbbs services
- Uses `/config` directory for persistence
- Logs public key for user convenience

## Commands

### Testing
```bash
# No automated tests yet - manual testing required
# Install on Home Assistant and verify:
# - Both services start
# - Web console accessible
# - Clients can connect
```

### Building Locally (for testing)
```bash
cd rustdesk-server-pro
docker build -t rustdesk-test .
docker run --network host -v $(pwd)/test-data:/config rustdesk-test
```

### Version Updates
1. Update `version` in `rustdesk-server-pro/config.yaml`
2. Add entry to `rustdesk-server-pro/CHANGELOG.md`
3. Commit and push to GitHub
4. Users will see update available in Home Assistant

## Architecture Support

Currently supports:
- aarch64 (ARM 64-bit)
- amd64 (x86 64-bit)
- armhf (ARM hard float)
- armv7 (ARM v7)

## Common Issues

### Licensing
RustDesk Pro requires `host_network: true` for licensing to work. Don't remove this.

### Port Conflicts
All ports 21114-21119 must be available. Check for conflicts if add-on won't start.

### Data Persistence
License files and keys are stored in `/config` which maps to `/addon_configs/<slug>/` on the host.

## Making Changes

### Adding Configuration Options
1. Add to `options:` and `schema:` in config.yaml
2. Read in run.sh using bashio (e.g., `bashio::config 'option_name'`)
3. Document in README.md and DOCS.md

### Updating Base Image
If RustDesk releases a new version:
1. Test with new image tag
2. Update Dockerfile if needed
3. Increment version in config.yaml
4. Update CHANGELOG.md

### Documentation
- **README.md** (in addon dir): Quick start, shown in Home Assistant UI
- **DOCS.md** (in addon dir): Detailed setup guide, accessible via Documentation tab
- **CHANGELOG.md**: Version history

## Development Notes

- No automated builds/CI - keeps things simple
- Users build on their own hardware
- First install is slower (building), updates are faster
- Host networking is non-negotiable for licensing

## Questions to Ask User

Before making major changes, consider asking:
- What version of Home Assistant are you running?
- What architecture is your system? (amd64, aarch64, etc.)
- Do you have the RustDesk Pro license?
- Have you tested this change on a live Home Assistant instance?

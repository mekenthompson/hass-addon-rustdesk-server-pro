# Changelog

All notable changes to this add-on will be documented in this file.

## [1.0.0] - 2025-11-09

### Added
- Initial release of RustDesk Server Pro add-on
- Support for RustDesk Pro server (hbbs and hbbr services)
- Web-based admin console access on port 21118
- Host networking support for proper licensing
- Multi-architecture support (aarch64, amd64, armhf, armv7)
- Comprehensive documentation and setup guides
- Automatic data persistence via addon_config mapping
- Complete port exposure for all RustDesk services (21114-21119)

### Features
- Self-hosted remote desktop server
- End-to-end encryption
- Multiple concurrent connections
- Address book and device management
- API server for Pro features
- NAT traversal and relay services

### Notes
- Requires valid RustDesk Pro license
- Uses host networking (required for licensing)
- License files stored in `/addon_configs/<slug>/` directory

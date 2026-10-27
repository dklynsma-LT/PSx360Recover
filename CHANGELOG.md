# Changelog for PSx360Recover

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- For new features.

### Changed

- For changes in existing functionality.

### Deprecated

- For soon-to-be removed features.

### Removed

- For now removed features.

### Fixed

- For any bug fix.
- `Get-x360RecoverBackupJobHistory`: `-jobsAfter` is now sent to the API as `starttime_begin`. Previously it was sent as an unrecognized `jobsAfter` query parameter, so the date filter was ignored and the full job history was returned.

### Security

- In case of vulnerabilities.


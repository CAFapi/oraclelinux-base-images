#### Version Number
${version-number}

#### New Features
- US969005: Update secret handling in check-create-pgdb-impl.sh.  
  - Secrets can be retrieved from the following sources:
    - Environment variables (direct value) - enabled via `CAF_ENABLE_ENV_SECRETS` (defaults to `true`)
    - File content (path specified by environment variable with `_FILE` suffix) - enabled via `CAF_ENABLE_FILE_SECRETS` (defaults to `false`)

- US969005: Curl version updated from `7.76.1` to `8.10.1`.

#### Known Issues
- None

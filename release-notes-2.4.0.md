!not-ready-for-release!

#### Version Number
${version-number}

#### New Features
- **US1212235**: Created new `oraclelinux-jre21-otel` and `oraclelinux-jre25-otel` as base images pre-configured with OpenTelemetry Java auto-instrumentation agent which is **disabled by default** and can be enabled at runtime by setting the `OTEL_JAVAAGENT_ENABLED` environment variable to `true`. Additional configurations can be done via standard OpenTelemetry environment variables.

#### Known Issues

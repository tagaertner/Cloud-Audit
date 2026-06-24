# CloudAudit

A serverless Java 21 application that scans AWS accounts for idle or wasted
cloud resources — stopped EC2 instances, unattached EBS volumes, unused
Elastic IPs — and calculates the estimated monthly cost of each finding.

This is a portfolio/learning project, built to simulate production-readiness
throughout rather than to actually run in production.

## Stack

- **Language / Runtime:** Java 21 (Amazon Corretto 21)
- **Framework:** Quarkus, SmallRye GraphQL
- **Compute:** AWS Lambda with SnapStart
- **Infrastructure as Code:** Terraform
- **Database:** DynamoDB (single-table design)
- **Frontend:** Vaadin (Java-native, long polling for real-time scan updates)
- **Auth:** Amazon Cognito (JWT, validated at API Gateway)
- **CI/CD:** GitHub Actions (OIDC, Checkov, Infracost, Dependabot)
- **Observability:** X-Ray + OpenTelemetry, structured JSON logging, CloudWatch alarms
- **Edge/Security:** CloudFront + AWS WAF, shared-secret origin header

## Status

🚧 Infrastructure and security architecture complete. Scanner logic in progress.

## Documentation

- `docs/RUNBOOK.md` — incident response reference, one entry per CloudWatch alarm
- Pre-Start Checklist and MVP Architecture docs (maintained outside this repo)
- Scanner Development Kickoff doc (maintained outside this repo)

## Local Development

1. Install Java 21, Maven, Terraform, AWS CLI, AWS SAM CLI, Docker Desktop
2. Copy `.env.example` to `.env` and fill in real values
3. `./mvnw quarkus:dev` — Quarkus Dev Services auto-starts a local DynamoDB container
4. GraphQL Playground available at `http://localhost:8080/graphql-ui`

## License

MIT — see [LICENSE](LICENSE)

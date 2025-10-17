#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCKER_COMPOSE_FILE="$PROJECT_ROOT/docker-compose.yml"

REQUIRED_SERVICES=("s3" "sqs" "sns" "lambda" "events")

echo "Starting LocalStack..."
docker-compose -f "$DOCKER_COMPOSE_FILE" up -d

echo "Waiting for LocalStack services..."
while :; do
    all_ready=true
    for svc in "${REQUIRED_SERVICES[@]}"; do
        if ! curl -s http://localhost:4566/_localstack/health | jq -r ".services.\"$svc\"" | grep -q "available"; then
            all_ready=false
            break
        fi
    done
    $all_ready && break
    printf "."
    sleep 2
done

echo -e "\nLocalStack is ready!"

terraform -chdir="$PROJECT_ROOT/" init -input=false
terraform -chdir="$PROJECT_ROOT/" apply -auto-approve -input=false

echo "Infrastructure applied successfully!"

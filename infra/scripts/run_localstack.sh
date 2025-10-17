#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCKER_COMPOSE_FILE="$PROJECT_ROOT/terraform/dev/docker-compose.yml"
REQUIRED_SERVICES=("s3" "sqs" "sns" "lambda" "events")
MAX_WAIT=120

start_localstack() {
    echo "Starting LocalStack..."
    docker-compose -f "$DOCKER_COMPOSE_FILE" up -d
}

restart_localstack() {
    echo "Restarting LocalStack..."
    docker-compose -f "$DOCKER_COMPOSE_FILE" down
    start_localstack
}

wait_for_services() {
    local elapsed=0
    echo "Waiting for LocalStack services..."
    while :; do
        all_ready=true
        health_json=$(curl -s http://localhost:4566/_localstack/health || echo "{}")
        for svc in "${REQUIRED_SERVICES[@]}"; do
            status=$(echo "$health_json" | jq -r ".services.\"$svc\" // empty")
            if [[ "$status" != "running" && "$status" != "available" ]]; then
                all_ready=false
                break
            fi
        done

        $all_ready && break

        sleep 2
        elapsed=$((elapsed+2))
        if (( elapsed >= MAX_WAIT )); then
            echo -e "\nTimeout waiting for LocalStack services."
            exit 1
        fi
        printf "."
    done
    echo -e "\nAll LocalStack services are ready!"
}

# Start LocalStack initially
start_localstack

# Check if any service is already running and restart if needed
health_json=$(curl -s http://localhost:4566/_localstack/health || echo "{}")
for svc in "${REQUIRED_SERVICES[@]}"; do
    status=$(echo "$health_json" | jq -r ".services.\"$svc\" // empty")
    if [[ "$status" == "running" || "$status" == "available" ]]; then
        restart_localstack
        break
    fi
done

# Wait for services to be fully ready
wait_for_services

# Apply Terraform
terraform -chdir="$PROJECT_ROOT/terraform/dev/" init -input=false
terraform -chdir="$PROJECT_ROOT/terraform/dev/" apply -auto-approve -input=false

echo "Infrastructure applied successfully!"

#!/bin/bash

# Load env variables
export $(grep -v '^#' .env | xargs)

# Start port forwarding in background
echo "Starting port-forwarding to MySQL..."
kubectl port-forward svc/mysqlserver1 3306:3306 -n my-namespace &
PORT_FORWARD_PID=$!

# Give it a second to establish
sleep 2

# Run the Go app
go run .

# When app exits, kill port-forwarding
kill $PORT_FORWARD_PID



# chmod +x run-local.sh

# ./run-local.sh
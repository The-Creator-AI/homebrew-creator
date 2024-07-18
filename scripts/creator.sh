#!/bin/bash

export CUR_WRK_DIR=$(readlink -f ${1:-$(pwd)})
echo Working Directory: $CUR_WRK_DIR

# Check if the creator is already running
if pgrep -f "node dist/main.js" > /dev/null; then
    echo "creator is already running. Opening the app in a new tab..."
    # Use xdg-open, open, or sensible-browser based on availability
    if command -v xdg-open > /dev/null; then
        xdg-open "http://localhost:3001/?path=$CUR_WRK_DIR" &
    elif command -v open > /dev/null; then
        open "http://localhost:3001/?path=$CUR_WRK_DIR" &
    elif command -v sensible-browser > /dev/null; then
        sensible-browser "http://localhost:3001/?path=$CUR_WRK_DIR" &
    else
        echo "Could not find a suitable command to open the browser."
    fi
else 
    echo "Starting the backend and frontend..."
    cd "/Users/pulkitsingh/creator-app/frontend/build" && PORT=3001 serve -s  &
    FRONTEND_PID=$!
    cd "/Users/pulkitsingh/creator-app/backend" && node dist/main.js &
    BACKEND_PID=$!

    # Use xdg-open, open, or sensible-browser based on availability
    if command -v xdg-open > /dev/null; then
        xdg-open "http://localhost:3001/?path=$CUR_WRK_DIR" &
    elif command -v open > /dev/null; then
        open "http://localhost:3001/?path=$CUR_WRK_DIR" &
    elif command -v sensible-browser > /dev/null; then
        sensible-browser "http://localhost:3001/?path=$CUR_WRK_DIR" &
    else
        echo "Could not find a suitable command to open the browser."
    fi

    wait $FRONTEND_PID $BACKEND_PID # Wait for both processes to finish
fi
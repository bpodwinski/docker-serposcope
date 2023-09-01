#!/bin/bash

# Launch application in background to generate SQLite file
/bin/bash -c "/usr/share/serposcope/serposcope.sh" &
APP_PID=$!

# Wait for SQLite file to be created
while [ ! -f /usr/share/serposcope/database.sqlite3.db ]; do
  sleep 1
done

# Kill
kill $APP_PID

# Move SQLite file
while [ ! -f /usr/share/serposcope/db/database.sqlite3.db ]; do
  mv /usr/share/serposcope/database.sqlite3.db* /usr/share/serposcope/db/
done

# Relaunch application in foreground
/bin/bash -c "/usr/share/serposcope/serposcope.sh"

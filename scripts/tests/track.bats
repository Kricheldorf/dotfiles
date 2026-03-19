#!/usr/bin/env bats
# scripts/tests/track.bats

setup() {
  export TIMETRACK_DATA_DIR="$(mktemp -d)"
  TRACK="$BATS_TEST_DIRNAME/../scripts/track"
}

teardown() {
  rm -rf "$TIMETRACK_DATA_DIR"
}

@test "no args prints usage and exits 1" {
  run bash "$TRACK"
  [ "$status" -eq 1 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "unknown subcommand prints usage and exits 1" {
  run bash "$TRACK" foobar
  [ "$status" -eq 1 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "data dir is created on first run" {
  local dir
  dir="$(mktemp -d)"
  rm -rf "$dir"
  TIMETRACK_DATA_DIR="$dir" run bash "$TRACK"
  [ -d "$dir" ]
}

load_track() {
  source "$BATS_TEST_DIRNAME/../scripts/track"
  init_data_dir  # files aren't created when sourcing (only when executing)
}

@test "get_open_session returns empty when file is empty" {
  load_track
  result=$(get_open_session)
  [ -z "$result" ]
}

@test "clock_in appends an i line" {
  load_track
  clock_in "Shipix:Backend Dev:SHIP-123" "2026-03-19T09:00:00"
  last=$(tail -1 "$TIMECLOCK_FILE")
  [ "$last" = "i 2026-03-19 09:00:00 Shipix:Backend Dev:SHIP-123" ]
}

@test "get_open_session returns account after clock_in" {
  load_track
  clock_in "Shipix:Backend Dev:SHIP-123" "2026-03-19T09:00:00"
  result=$(get_open_session)
  [ "$result" = "Shipix:Backend Dev:SHIP-123" ]
}

@test "clock_out appends an o line and clears open session" {
  load_track
  clock_in "Shipix:Backend Dev:SHIP-123" "2026-03-19T09:00:00"
  clock_out "2026-03-19T10:30:00"
  result=$(get_open_session)
  [ -z "$result" ]
  last=$(tail -1 "$TIMECLOCK_FILE")
  [ "$last" = "o 2026-03-19 10:30:00" ]
}

@test "clock_out on zero-duration session removes the i line" {
  load_track
  clock_in "Shipix:Backend Dev:SHIP-123" "2026-03-19T09:00:00"
  clock_out "2026-03-19T09:00:00"
  [ ! -s "$TIMECLOCK_FILE" ]
}

@test "track stop with no active session exits 0 with message" {
  run bash "$TRACK" stop
  [ "$status" -eq 0 ]
  [ "$output" = "No active session." ]
}

@test "track stop clocks out an open session" {
  load_track
  clock_in "Shipix:Backend Dev:SHIP-123" "2026-03-19T09:00:00"
  run bash "$TRACK" stop
  [ "$status" -eq 0 ]
  [ "$output" = "Stopped: SHIP-123" ]
  open=$(get_open_session)
  [ -z "$open" ]
}

@test "track status with no active session exits 0 with message" {
  run bash "$TRACK" status
  [ "$status" -eq 0 ]
  [ "$output" = "No active session." ]
}

@test "track status shows ticket and elapsed time" {
  load_track
  local start
  start=$(date -d "90 minutes ago" "+%Y-%m-%dT%H:%M:%S")
  clock_in "Shipix:Backend Dev:SHIP-123" "$start"
  run bash "$TRACK" status
  [ "$status" -eq 0 ]
  [[ "$output" == "SHIP-123 ("*")"* ]]
}

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

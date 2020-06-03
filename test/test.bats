#!/usr/bin/env bats

# Tests using the Bats testing framework
# https://github.com/bats-core/bats-core

ROOT_MISSPELLING_COUNT=5
FILENAME_MISSPELLING_COUNT=1
HIDDEN_MISSPELLING_COUNT=1
EXCLUDED_MISSPELLING_COUNT=1
SUBFOLDER_MISSPELLING_COUNT=1
# From all files called example.txt
EXAMPLE_MISSPELLING_COUNT=5

export RUNNER_TEMP="/foo/runner_temp"

# This function runs before every test
function setup() {
    # Set default input values
    export INPUT_CHECK_FILENAMES=""
    export INPUT_CHECK_HIDDEN=""
    export INPUT_EXCLUDE_FILE=""
    export INPUT_SKIP=""
    export INPUT_PATH="./test/testdata"
    export INPUT_ONLY_WARN=""
}

@test "Run with defaults" {
    # codespell's exit status is the number of misspelled words found
    expectedExitStatus=$((ROOT_MISSPELLING_COUNT + SUBFOLDER_MISSPELLING_COUNT))
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]

    # Check output
    [ "${lines[1]}" == "::add-matcher::${RUNNER_TEMP}/_github_workflow/codespell-matcher.json" ]
    outputRegex="^Running codespell on '${INPUT_PATH}'"
    [[ "${lines[2]}" =~ $outputRegex ]]
    [ "${lines[-3]}" == "Codespell found one or more problems" ]
    [ "${lines[-2]}" == "::remove-matcher owner=codespell-matcher-default::" ]
    [ "${lines[-1]}" == "::remove-matcher owner=codespell-matcher-specified::" ]
}

@test "Check file names" {
    expectedExitStatus=$((ROOT_MISSPELLING_COUNT + SUBFOLDER_MISSPELLING_COUNT + FILENAME_MISSPELLING_COUNT))
    INPUT_CHECK_FILENAMES=true
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Check a hidden file" {
    expectedExitStatus=$HIDDEN_MISSPELLING_COUNT
    INPUT_CHECK_HIDDEN=true
    INPUT_PATH="./test/testdata/.hidden"
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Check a hidden file without INPUT_CHECK_HIDDEN set" {
    expectedExitStatus=0
    INPUT_PATH="./test/testdata/.hidden"
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Use an exclude file" {
    expectedExitStatus=$((ROOT_MISSPELLING_COUNT + SUBFOLDER_MISSPELLING_COUNT - EXCLUDED_MISSPELLING_COUNT))
    INPUT_EXCLUDE_FILE="./test/exclude-file.txt"
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Check the skip option" {
    expectedExitStatus=$((ROOT_MISSPELLING_COUNT + SUBFOLDER_MISSPELLING_COUNT - EXAMPLE_MISSPELLING_COUNT))
    INPUT_SKIP="example.txt"
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Custom path" {
    expectedExitStatus=$((SUBFOLDER_MISSPELLING_COUNT))
    INPUT_PATH="./test/testdata/subfolder"
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

@test "Only warn" {
    expectedExitStatus=0
    INPUT_ONLY_WARN=true
    run "./entrypoint.sh"
    [ $status -eq $expectedExitStatus ]
}

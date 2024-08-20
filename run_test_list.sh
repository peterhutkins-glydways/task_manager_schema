#!/bin/bash

#set -x

# Directory paths
RESULTS_DIR="./results"
CUE_FILE="test/test_list.cue"

# Create results directory if it doesn't exist
mkdir -p $RESULTS_DIR

# Function to trim the leading and trailing quotes from a string
trim_quotes() {
    local var="$1"
    var="${var%\"}"  # Remove the trailing quote
    var="${var#\"}"  # Remove the leading quote
    echo "$var"
}

# Function to run a test case
run_test() {
    local test_name=$1
    local command=$2
    local expected_outcome=$3

    echo "Running test: \"$test_name\" with command: \"$command\""

    # Execute the CUE command
    PATH=$PATH eval "$command" > "$RESULTS_DIR/${test_name}_output.txt" 2>&1
    local result=$?

    if [ $expected_outcome == "pass" ] && [ $result -eq 0 ]; then
        echo "Test passed as expected."
        return 0
    elif [ $expected_outcome == "fail" ] && [ $result -ne 0 ]; then
        echo "Test failed as expected."
        return 0
    else
        echo "Test did not behave as expected."
        return 1
    fi
}

# First, validate the CUE file that defines the test cases
run_test "CUE test file validation" "cue eval $CUE_FILE -c" "pass"

# Iterate over each test case defined in the CUE test file
index=0
while true; do
    test_name=$(cue eval -e "tests[$index].name" $CUE_FILE 2>/dev/null)
    command=$(cue eval -e "tests[$index].command" $CUE_FILE 2>/dev/null)
    expected=$(cue eval -e "tests[$index].expected" $CUE_FILE 2>/dev/null)

        # Trim quotes from the extracted values
    test_name=$(trim_quotes "$test_name")
    command=$(trim_quotes "$command")
    expected=$(trim_quotes "$expected")
    
    # Break the loop if no more tests are found
    if [ -z "$test_name" ]; then
        break
    fi

    run_test "$test_name" "$command" "$expected"
    if [ $? -ne 0 ]; then
        echo "Test $test_name failed"
    fi

    # Increment the index to move to the next test case
    index=$((index + 1))
done
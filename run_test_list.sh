#!/bin/bash

#set -x

# Directory paths
RESULTS_DIR="./results"
CUE_FILE="test/test_list.cue"

# Create results directory if it doesn't exist
mkdir -p "${RESULTS_DIR}"

# Function to trim the leading and trailing quotes from a string
trim_quotes() {
	local var="$1"
	var="${var%\"}" # Remove the trailing quote
	var="${var#\"}" # Remove the leading quote
	echo "${var}"
}

# Function to run a test case
run_test() {
	local test_name=$1
	local command=$2
	local expected_outcome=$3

	echo -n "Running test: \"${test_name}\" with command: \"${command}\" ... "

	# Execute the CUE command
	PATH="${PATH}" eval "${command}" >"${RESULTS_DIR}/${test_name}_output.txt" 2>&1
	local result=$?

	if [[ ${expected_outcome} == "pass" ]] && [[ ${result} -eq 0 ]]; then
		echo "PASS"
		return 0
	elif [[ ${expected_outcome} == "fail" ]] && [[ ${result} -ne 0 ]]; then
		echo "PASS"
		return 0
	else
		echo "FAIL"
		return 1
	fi
}

# First, make sure this script is working as expected
run_test "self-test-of-failure" "non-existent-command" "fail"
run_test "self-test-of-success" "echo 'Hello, World!'" "pass"
run_test "self-test-validate-test-list" "cue eval ${CUE_FILE} -c" "pass"

# To report at the the end of the script
total_passes=0
total_fails=0
total_tests=0

# Iterate over each test case defined in the CUE test file
index=0
while true; do
	test_name=$(cue eval -e "tests[${index}].name" "${CUE_FILE}" 2>/dev/null)
	command=$(cue eval -e "tests[${index}].command" "${CUE_FILE}" 2>/dev/null)
	expected=$(cue eval -e "tests[${index}].expected" "${CUE_FILE}" 2>/dev/null)

	# cue return strings within quotes. trim quotes from the extracted values.
	test_name=$(trim_quotes "${test_name}")
	command=$(trim_quotes "${command}")
	expected=$(trim_quotes "${expected}")

	# Break the loop if no more tests are found
	if [[ -z ${test_name} ]]; then
		break
	fi

	total_tests=$((total_tests + 1))
	if ! run_test "${test_name}" "${command}" "${expected}"; then
		total_fails=$((total_fails + 1))
	else
		total_passes=$((total_passes + 1))
	fi

	# Increment the index to move to the next test case
	index=$((index + 1))
done

echo "Total tests: ${total_tests}"
echo "Total passes: ${total_passes}"
echo "Total fails: ${total_fails}"

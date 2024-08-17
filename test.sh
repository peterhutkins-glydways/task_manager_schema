#!/bin/env bash

# This command verifies the correctness of the .yaml file against the .cue files.
# It errors out if the .yaml file is not correct against the schema, or if there are any errors in the .cue files.
cue vet *.cue test/test_system1.yaml

# This command evaluates the .yaml file against the .cue files, and produces 
# the output in yaml format.
#cue eval *.cue test/test_system1.yaml --out yaml
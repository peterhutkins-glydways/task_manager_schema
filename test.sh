#!/bin/env bash

# This command verifies the correctness of the .yaml file against the .cue schema files.
# It errors out if the .yaml file is not correct against the schema, or if there are any errors in the .cue files.
cue vet ./agent/... test/test_system1.yaml

# This command evaluates a cue configuration against the agent schema, and produces
# a concrete definition from the two. 
cue eval ./agent/... test/test_system1.cue --concrete
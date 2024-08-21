package agent_tests

#TestDef : {
    name:      string
    command:   string
    expected:  string | *"pass"
}

tests: [...#TestDef] & [
    {
        name:      "null-system"
        command:   "cue eval ./agent/... -c"
    },
    {
        name:      "test-system1-cue"
        command:   "cue eval ./agent/... test/test_system1.cue -c"
    },
    {
        name:      "test-system1-yaml"
        command:   "cue export ./agent/... test/test_system1.yaml"
    },
    {
        name:      "test-system1-cue-nonlinear-field-sequence"
        command:   "cue export ./agent/... test/test_system1.cue -e signals.signal5.special_field"
    },
    {
        name:      "test-system1-cue-nonexistent-field"
        command:   "cue export ./agent/... test/test_system1.cue -e signals.signal5.non_existent_field"
        expected:  "fail"
    },
    {
        name:      "test-agent-refers-to-non-existent-signal"
        command:   "cue eval ./agent/... test/test_agent_refers_to_non_existent_signal.cue -c"
        expected:  "fail"
    },
    {
        name:      "test-agent-refers-to-existent-signal"
        command:   "cue eval ./agent/... test/test_agent_refers_to_existent_signal.cue -c"
        expected:  "pass"
    }

]


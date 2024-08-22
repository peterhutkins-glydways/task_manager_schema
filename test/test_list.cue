package agent_tests

#TestDef : {
    name:      string
    command:   string
    expected:  string | *"pass"
}

#tool : *"cue" | "hof"

tests: [...#TestDef] & [
    {
        name:      "null-system"
        command:   "\(#tool) eval agent/*.cue -c"
    },
    {
        name:      "test-system1-cue-against-agent-schema"
        command:   "\(#tool) eval agent/*.cue test/test_system1.cue -c"
    },
    {
        name:      "test-system1-cue-against-agent-schema"
        command:   "\(#tool) export agent/*.cue test/test_system1.yaml"
    },
    {
        name:      "test-system1-cue-accepts-later-field-declaration"
        command:   "\(#tool) export agent/*.cue test/test_system1.cue -e signals.signal5.special_field"
    },
    {
        name:      "test-system1-cue-rejects-nonexistent-field-access"
        command:   "\(#tool) export agent/*.cue test/test_system1.cue -e signals.signal5.non_existent_field"
        expected:  "fail"
    },
    {
        name:      "test-agent-refers-to-non-existent-signal"
        command:   "\(#tool) eval agent/*.cue test/test_agent_refers_to_non_existent_signal.cue -c"
        expected:  "fail"
    },
    {
        name:      "test-agent-refers-to-existent-signal"
        command:   "\(#tool) eval agent/*.cue test/test_agent_refers_to_existent_signal.cue -c"
        expected:  "pass"
    }

]


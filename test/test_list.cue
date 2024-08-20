package agent_tests

#TestDef : {
    name:      string
    command:   string
    expected:  string | *"pass"
}

tests: [...#TestDef] & [
    {
        name:      "null_system"
        command:   "cue eval ./agent/... -c"
    },
]


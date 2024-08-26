package agent

// High-level definition of a system of agents
// This is further refined in the various agent *.cue files.
#SystemDef: {
    name : string
    agents : [string] : {...}
    signals : [string] : {...}
}

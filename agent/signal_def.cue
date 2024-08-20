// Definition of schema for signals
package agents

import "list"

signals : [Name=string]: #SignalDef & {name: Name}

// Generate signal_names list from signals, either simple or expanded
signal_names: [for _, signal in signals {signal.name}]

#SignalDef : {
    name : string 
    ...
}

// PredefinedSignals must be a list of unique signals, all of which exist in the 'signal_names' list
// The "_valid" hidden field fails to resolve (with a contextual error) if the test is not true. 
#PredefinedSignalName : S={
    string
    _valid: true & { if !list.Contains(signal_names, S) {"Undefined signal: \(S)"}}
}
#PredefinedSignalNames: [...#PredefinedSignalName]


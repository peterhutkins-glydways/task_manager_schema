// Definition of schema for signals
package agents

signals : [Name=_]: #SignalDef & {name: Name}

// Generate signal_names list from signals, either simple or expanded
signal_names: [for _, signal in signals {signal.name}]

#SignalDef : {
    name : string 
    ...
}

// PredefinedSignals must be a list of unique signals, all of which exist in the 'signals' list
#PredefinedSignalName : or(signal_names)
#PredefinedSignalNames: [...#PredefinedSignalName]


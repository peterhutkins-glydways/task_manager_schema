// Definition of schema for signals
package agents

import "list"

signals : [...#SignalDef]
signals : list.UniqueItems

// Generate signal_names list from signals, either simple or expanded
signal_names: [for _, signal in signals {
        *signal.name | signal 
    }]

#SignalDef : #SimpleSignal | #ExpandedSignal
#SimpleSignal : string
#ExpandedSignal : {
    name : string 
    ...
}

// PredefinedSignals must be a list of unique signals, all of which exist in the 'signals' list
#PredefinedSignalName : or(signal_names)
#PredefinedSignalNames: [...#PredefinedSignalName] & list.UniqueItems


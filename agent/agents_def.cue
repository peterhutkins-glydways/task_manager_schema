// Definition of schema for agents

// At this time, all schemas are under the "agents" package. 
// TODO: break off sub-schemas into their own independnet packages
// and import them into "agents". 
package agents

agents:  [AgentName=string]: #AgentDef & {name: AgentName}

#AgentDef: {
    name: string
    priority: #PriorityDef
    resources: #ResourcesDef
    signals: #SignalsDef
    actions: [...#ActionDef]
}

// Definition of Agent priority
#PriorityDef: uint8 | *_defaultPriority
_defaultPriority: 1

_default_stack_size: 256
// Definition of Agent resources
#ResourcesDef: {
    stack_size: uint32 | *_default_stack_size
    memory_pool?: string
    interfaces: [...#InterfaceDef]
}

// Definition of Agent signals
#SignalsDef: {
    produces: #PredefinedSignalNames
    consumes: #PredefinedSignalNames
}

// Definition of Agent actions
#ActionDef: {
    name: string
    events: [...#EventDef]
    execution_window: "event_bounded" | *"unbounded" | "time_bounded"
    deadline: uint32
    callable_name: string
    callable_type: "C" | "C++" | "Ada"
}

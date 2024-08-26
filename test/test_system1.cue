agents: {
	agent0: {
		name:     "agent0" // unique Agent name
		priority: 3
		resources: {
			stack_size:  256
			memory_pool: "memory_pool1"
			interfaces: [{
				type: "Pin"
				id:   "PIN_AB31"
			}, {
				type: "UART"
				id:   "UART_1"
			}]
		}
		signals: {// protected, shared objects that the Agent interacts with.
			produces: ["signal1", "signal3", "signal_has_a_long_name"] // List of signal names from Signal_Dictionary, defined elsewhere
			consumes: ["signal6"]
		}
		actions: [{
			name: "sleepy_c" // identifying action name. 
			events: ["signal1_went_high"] // List of named Events to be serviced by this Action.
			execution_window:             "time_bounded" // one of "event_bounded", "unbounded", "time_bounded"
			deadline:                     32             // Required if execution_window is "time_bounded", represents time in milliseconds
			callable_name:                "sleepy_c"     // The function/procedure to be called upon an event.
			callable_type:                "Ada"
		}]
	}
	agent1: {
		resources: stack_size: 256
	}
}

signals: {
	signal1: {...}
	signal3: {...}
	signal4: {...}
	signal5: {...}
	signal_has_a_long_name: {...}
	signal6: {
		type:          "boolean"
		initial_value: "false"
	}
}

// Can add definitions later, like this:
signals: signal5: special_field: "true"

package test_agent_refers_to_non_existent_signal

agents: agent_with_good_signals: signals: produces: ["existent_signal"]

signals:
    existent_signal: {}

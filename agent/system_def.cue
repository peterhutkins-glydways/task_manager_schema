package agent

// An experiment from https://docs.hofstadter.io/data-modeling/ 

// The "import" version did not work for me. 
import (
	"github.com/hofstadter-io/hof/schema/dm"
)
// import "path"

System: {
    @datamodel()
    // system_name: string | *path.Base()
    // agents:  [AgentName=string]: agents.#AgentDef & {name: AgentName}
    // signals : [Name=string]: signals.#SignalDef & {name: Name}
    agents : [string] : {...}
    signals : [string] : {...}
}

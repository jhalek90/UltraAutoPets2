//State machine functions
function stateMachineInit(){
	state="idle"
	stateTimer=0
	statePrevious="idle"
}

function stateStep(){
	stateTimer++
}

function stateSet(_state){
	statePrevious=state
	stateTimer=0
	state=_state
}


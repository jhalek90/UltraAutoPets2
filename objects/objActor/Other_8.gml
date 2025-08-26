/// @description Event


if path_exists(myPath){
	path_delete(myPath)
	myPath=-1
	state="idle"
	if collectTarget !=-1 and (task="" or task="farm"){
		if instance_exists(collectTarget){
			state="collecting"
		}
	}
}
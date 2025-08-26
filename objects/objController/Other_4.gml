/// @description Event


if room=Room1{
	
	if global.gameData.levelGrid!=-1{
		mp_grid_destroy(global.gameData.levelGrid)
		global.gameData.levelGrid=-1
	}
	
	global.gameData.levelGrid=mp_grid_create(0,0,room_width/16,room_height/16,16,16)
	mp_grid_add_instances(global.gameData.levelGrid,objWall,true)
}

if instance_exists(objPlayer){
	snapCameraToObject(objPlayer)
}
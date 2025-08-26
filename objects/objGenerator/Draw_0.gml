/// @description Event



if !surface_exists(surf){
	surf=surface_create(room_width,room_height)
	
	surface_set_target(surf)
	draw_clear_alpha(c_black,0)
	
	drawMap()
	surface_reset_target()
}


draw_surface(surf,0,0)


for(var i=0; i<array_length(mapPoints); i++){
	var _thisPoint=mapPoints[i]
	draw_set_color(c_white)
	draw_circle(_thisPoint.x,_thisPoint.y,4,true)
}

draw_set_color(c_white)


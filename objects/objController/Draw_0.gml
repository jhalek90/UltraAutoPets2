/// @description Event


if DEBUG and keyboard_check(vk_shift){
	//mp_grid_draw(global.gameData.levelGrid)
}

if mouseDrag{
	
	draw_set_color(c_lime)
	draw_set_alpha(0.5)
	draw_rectangle(mouse_x,mouse_y,mouseDragStartX,mouseDragStartY,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_rectangle(mouse_x,mouse_y,mouseDragStartX,mouseDragStartY,true)
}

if array_length(unitList)>0 and mouseDrag=false and tool="move"{
	draw_set_alpha(0.5)
	draw_set_color(c_black)
		
	var _mx=round(mouse_x/16)*16
	var _my=round(mouse_y/16)*16
	var _points=place_units(_mx,_my,unitList, unitSize)
	for (var i=0; i<array_length(_points); i++){
		var _p=_points[i]
		draw_circle(_p[0],_p[1],unitSize/2,false)
	}
		
	draw_set_color(c_white)
	draw_set_alpha(1)
}

#macro DEBUG true

#macro CAM view_camera[0]
#macro CAM_X camera_get_view_x(CAM)
#macro CAM_Y camera_get_view_y(CAM)
#macro CAM_W camera_get_view_width(CAM)
#macro CAM_H camera_get_view_height(CAM)

//mp_potential_settings(90, 90, 3, true)

function drawTooltip(_tx,_ty,_text,_sprite){
	var _w=string_width(_text)
	draw_set_color(c_black)
	draw_rectangle(_tx,_ty,_tx+_w+16,_ty+11,false)
	
	
	draw_set_color(c_white)
	draw_set_font(fntPixel)
	draw_set_valign(fa_top)
	draw_set_halign(fa_left)
	
	draw_text(_tx+16,_ty-4,_text)
	draw_sprite(_sprite,0,_tx,_ty+6)
}

function resourceItem(_name,_sprite) constructor{
	name=_name
	sprite=_sprite
}

function game() constructor{
	levelGrid=-1
	//mp_grid_destroy(levelGrid)

}

function drawPathFancy(_path,_start,_end,_steps){

	var _points=[]
	var _progress=_start
	var _inc=(_end-_start)/_steps
	var _totalDist=0
	var _a
	var _b
	var _xx
	var _yy
	var _angle
	var _dist
	var i
	
	
	
	for(i=0; i<_steps-1; i++){
		_xx=path_get_x(_path,_progress)
		_yy=path_get_y(_path,_progress)
		array_push(_points, {posX:_xx, posY:_yy})
		_progress+=_inc
	}
	
	_xx=path_get_x(_path,_end)
	_yy=path_get_y(_path,_end)
	array_push(_points, {posX:_xx, posY:_yy})
	
	
	draw_set_color(c_yellow)
	for(var j=0; j<array_length(_points)-1; j++){
		_a=_points[j]
		_b=_points[j+1]
		draw_line_width(_a.posX,_a.posY,_b.posX,_b.posY,4)
		//draw_circle(_a.posX,_a.posY,8,false)
		//_angle=point_direction(_a.posX,_a.posY,_b.posX,_b.posY)
		//_dist=point_distance(_a.posX,_a.posY,_b.posX,_b.posY)
		//_totalDist+=_dist
		//if _totalDist>64{
		//	draw_sprite_ext(sprPathArrow,0,_a.posX,_a.posY,1,1,_angle,c_white,1)
		//	_totalDist=0
		//}
		
	}
	
	draw_set_color(c_white)

}

function actorPathToPoint(_x,_y){
	if myPath !=-1{
		if path_exists(myPath){
			path_delete(myPath)
		}
	}
	myPath=path_add()
	if mp_grid_path(global.gameData.levelGrid,myPath,x,y,_x,_y,true){
		path_start(myPath,walkSpeed,path_action_stop,true)
		state="walking"
	}else{
		myPath=-1
	}
}

function actorDepositResources(_container){
	while (array_length(contents)>0 and array_length(_container.contents)<_container.maxContentsSize){
		array_push(_container.contents,array_shift(contents))
	}
	
}

function actorMineResource(_resource){
	var _amount=mineRate*_resource.mineRate
	_resource.mineProgress+=_amount
	
	if _resource.mineProgress>=1{
		_resource.mineProgress=0
		//get resource here
		if array_length(_resource.contents)>0{
			array_push(contents,array_shift(_resource.contents))
		}else{
			//reset to idle state when collecting is completed.
			state="idle"
			collectTarget=-1
		}
		
		if array_length(contents)>0{
			task="deposit"
			state="idle"
		}
	}
}

function drawUiPanel(_x,_y,_width,_height,_title){
	
	var _w=_width/64
	var _h=_height/64
	
	if (mouseGuiX>_x)and(mouseGuiX<_x+_width)and(mouseGuiY>_y)and(mouseGuiY<_y+_height){
		mouseGuiHover=true
	}
	
	draw_sprite_ext(sprGuiPanel,0,_x,_y,_w,_h,0,c_white,1)
	
	draw_set_color(c_white)
	draw_set_font(fntPixel)
	draw_set_valign(fa_top)
	draw_set_halign(fa_center)
	draw_text(_x+(_width/2),_y-1,_title)
}

function setSelected(_selected){
	selected=_selected
	var _arr=objController.unitList
	
	if selected{
		
		if !array_contains(_arr,id){
			if array_length(_arr)<objController.maxUnitsSelected{
				array_push(_arr,id)
			}else{
				selected=false
			}
		}
		
	}else{
		if array_contains(_arr,id){

			array_delete(_arr,array_get_index(_arr,id),1)
			with(objController){
				if cameraFollowTarget=other.id{
					cameraFollowTarget=-1
				}
			}
		}
	}

}


function playSound(_snd){
	return audio_play_sound(_snd,1,0,1,0,random_range(0.8,1.2))
}

/// @func place_units(unit_array, spacing)
/// @desc Returns array of {x,y} positions near mouse, spaced and avoiding walls.
/// @param unit_array   Array of units to place
/// @param spacing      Minimum distance between placed units
function place_units(_x,_y,unit_array, spacing) {
    //var mouse_x = device_mouse_x(0);
    //var mouse_y = device_mouse_y(0);
    var result = [];

    var count = array_length(unit_array);
    var radius = 0//spacing; // start radius for placement ring
    var angle_step;
    var placed = 0;

    // keep looping until all units placed
    while (placed < count) {
        angle_step = 360 / max(1, floor(2 * pi * radius / spacing));
        for (var a = 0; a < 360 && placed < count; a += angle_step) {
            var px = _x + lengthdir_x(radius, a);
            var py = _y + lengthdir_y(radius, a);

            // --- Check collisions ---
            var too_close = false;
            for (var i = 0; i < array_length(result); i++) {
                if (point_distance(px, py, result[i][0], result[i][1]) < spacing) {
                    too_close = true;
                    break;
                }
            }

            // skip if too close or on a wall
            if (too_close) continue;
            if (place_meeting(px, py, objWall)) continue;
			if (place_meeting(px, py, objActor)) continue;

            // --- Valid placement ---
            array_push(result, [px, py]);
            placed++;
        }

        radius += spacing; // expand outward in rings if needed
    }

    return result;
}

/// @description Event

draw_set_color(c_white)


if selected or hover{
	var _c=c_white
	if hover{_c=c_yellow}
	gpu_set_fog(true,_c,0,0)
	
	draw_sprite_ext(sprite_index,image_index,x-1,y,animationFlip,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x+1,y,animationFlip,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y-1,animationFlip,image_yscale,image_angle,image_blend,image_alpha)
	draw_sprite_ext(sprite_index,image_index,x,y+1,animationFlip,image_yscale,image_angle,image_blend,image_alpha)
	
	gpu_set_fog(false,c_white,0,0)
}

draw_sprite_ext(sprite_index,image_index,x,y,animationFlip,image_yscale,image_angle,image_blend,image_alpha)

if array_length(contents)>0{
	var _item=contents[0].sprite
	draw_sprite_ext(_item,0,x,y-20,animationFlip,image_yscale,image_angle,image_blend,image_alpha)
}

/*
if selected{
	if myPath !=-1{
		if path_exists(myPath){
			drawPathFancy(myPath,path_position,1,path_get_length(myPath)/64)
			
			//draw_path(myPath,0,0,true)
		}
	}
}

*/
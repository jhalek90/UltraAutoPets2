/// @description Event




if hover{
	gpu_set_fog(true,c_yellow,0,0)
	draw_sprite_ext(sprite_index,image_index,x-1,y,image_xscale,image_yscale,image_angle,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x+1,y,image_xscale,image_yscale,image_angle,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale,image_yscale,image_angle,c_white,1)
	draw_sprite_ext(sprite_index,image_index,x,y+1,image_xscale,image_yscale,image_angle,c_white,1)
	gpu_set_fog(false,c_white,0,0)
}


draw_self()


if mineProgress>0{
	
	draw_set_color(c_black)
	draw_rectangle(x-10,y-4,x+10,y+4,false)
	var _prog=mineProgress*18
	
	draw_set_color(c_white)
	draw_rectangle(x-9,y-3,(x-9)+_prog,y+3,false)
}
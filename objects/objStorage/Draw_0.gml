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


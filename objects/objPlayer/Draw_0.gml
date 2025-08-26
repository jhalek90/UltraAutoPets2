/// @description Event

event_inherited()

/*
var _headOff=0

if round(image_index+1) % 2 ==0 {
	_headOff=1
}

//_headOff=sin((image_index+1)/4)
draw_sprite_ext(sprite_index,image_index,x,y,aniScaleX,image_yscale,image_angle,c_white,1)
draw_sprite_ext(sprPlayerHead,aniHeadImage,x,y+_headOff,aniScaleX,image_yscale,headAngle,c_white,1)
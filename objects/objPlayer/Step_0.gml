/// @description Player Step

event_inherited()

/*
var _walkSpeed=2
var _walking=false
var _inputX=0
var _inputY=0

depth=-y

if keyboard_check(ord("A")){
	_inputX=-1
	aniScaleX=-1
	_walking=true
}
if keyboard_check(ord("D")){
	_inputX=1
	aniScaleX=1
	_walking=true
}
if keyboard_check(ord("W")){
	_inputY=-1
	_walking=true
}
if keyboard_check(ord("S")){
	_inputY=1
	_walking=true
}

if _walking{
	image_speed=1
	var _walkDir=point_direction(0,0,_inputX,_inputY)
	hspd=lengthdir_x(_walkSpeed,_walkDir)
	vspd=lengthdir_y(_walkSpeed,_walkDir)
}else{
	image_speed=0
	image_index=0
	hspd=hspd*0.5
	vspd=vspd*0.5
}

headAngle=lerp(headAngle,hspd*10,0.7)
x+=hspd
y+=vspd


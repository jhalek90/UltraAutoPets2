/// @description Event
toolTip=""
mouseGuiHover=false
mouseGuiX=device_mouse_x_to_gui(0)
mouseGuiY=device_mouse_y_to_gui(0)

draw_set_color(c_white)
draw_set_font(fntPixel)
draw_set_valign(fa_top)
draw_set_halign(fa_left)

#region debug window

var _xx=currentWindowWidth-258
var _yy=2

drawUiPanel(_xx,_yy,256,80,"Debug Data")

draw_set_halign(fa_left)
draw_text(_xx+6,_yy+22,"FPS: "+string(fps)+" / "+string(fps_real))
draw_text(_xx+6,_yy+38,"Tool: "+tool)
draw_text(_xx+6,_yy+54,"Units Selected: "+string(array_length(unitList)))

draw_text(_xx+126,_yy+22,"Window: "+string(window_get_width())+"x"+string(window_get_height()))
draw_text(_xx+126,_yy+38,"Zoom Level: "+string(cameraZoom))
#endregion

#region Units Window
var _xx=2
var _yy=2
var _space=18
drawUiPanel(_xx,_yy,256,32+(array_length(unitList)*_space),"-")


var _c=c_white

if (mouseGuiX>_xx+160) and (mouseGuiX<_xx+254) and(mouseGuiY>_yy-2) and (mouseGuiY<_yy+16){
	_c=c_yellow
	if mouse_check_button_pressed(mb_left){
		playSound(choose(sndClick1,sndClick2,sndClick3))
		with(objActor){
			setSelected(false)
		}
	}
}

draw_set_halign(fa_right)
draw_set_color(_c)
draw_text(_xx+252,_yy-1,"Deselect all")


draw_set_halign(fa_left)
draw_set_color(c_white)
draw_text(_xx+2,_yy-1,"Selected Units")




_yy+=22
_xx+=3
draw_set_color(c_white)
draw_set_font(fntPixel)
draw_set_valign(fa_top)
draw_set_halign(fa_left)

for(var i=0; i<array_length(unitList); i++){
	if unitList[i].hover{
		draw_set_color(c_yellow)
	}else{
		draw_set_color(c_white)
	}
	draw_text(_xx,_yy-1,string(unitList[i].name))
	
	draw_set_color(c_gray)
	draw_line(_xx,_yy+17,_xx+250,_yy+17)
	
	
	_yy+=_space
}

//reset coords for next bits
_yy=22
draw_set_halign(fa_center)
draw_set_color(c_gray)
for(var i=0; i<array_length(unitList); i++){
	draw_text(_xx+123,_yy+1,string(unitList[i].task)+" - "+string(unitList[i].state))
	_yy+=_space
}

//reset coords for next bits
_yy=22
draw_set_halign(fa_right)
draw_set_color(c_white)
for(var i=0; i<array_length(unitList); i++){
	
	var _dx=_xx+200
	var _dy=_yy+11
	var _img=0
	if (mouseGuiX>_dx-8)and(mouseGuiX<_dx+8)and(mouseGuiY>_dy-8)and(mouseGuiY<_dy+8){
		_img=1
		toolTip="Find"
		if mouse_check_button_pressed(mb_left){
			playSound(choose(sndClick1,sndClick2,sndClick3))
			cameraSoftTarget(unitList[i].x,unitList[i].y)
		}
	}
	draw_sprite(sprUiIconFind,_img,_dx,_dy)
	
	
	_dx=_xx+220
	_dy=_yy+11
	_img=0
	if cameraFollowTarget=unitList[i]{_img=2}
	
	if (mouseGuiX>_dx-8)and(mouseGuiX<_dx+8)and(mouseGuiY>_dy-8)and(mouseGuiY<_dy+8){
		_img=1
		toolTip="Follow"
		if mouse_check_button_pressed(mb_left){
			playSound(choose(sndClick1,sndClick2,sndClick3))
			
			if cameraFollowTarget=unitList[i]{
				cameraFollowTarget=-1
			}else{
				cameraFollowTarget=unitList[i]
			}
		}
	}
	draw_sprite(sprUiIconFollow,_img,_dx,_dy)
	
	var _dx=_xx+240
	var _dy=_yy+11
	var _img=0
	if (mouseGuiX>_dx-8)and(mouseGuiX<_dx+8)and(mouseGuiY>_dy-8)and(mouseGuiY<_dy+8){
		_img=1
		toolTip="Unselect"
		if mouse_check_button_pressed(mb_left){
			playSound(choose(sndClick1,sndClick2,sndClick3))
			with(unitList[i]){
				setSelected(false)
			}
			//cameraSoftTarget(unitList[i].x,unitList[i].y)
		}
	}
	draw_sprite(sprUiIconDeselect,_img,_dx,_dy)
	
	
	_yy+=_space
}
#endregion

#region Actions Window

var _avalibleActions=[]


array_push(_avalibleActions,"select")
if array_length(unitList)>0{
	array_push(_avalibleActions,"move")
	array_push(_avalibleActions,"collect")
	array_push(_avalibleActions,"build")
}


var _xx=(currentWindowWidth/2)-128
var _yy=2
drawUiPanel(_xx,_yy,256,32+(18*array_length(_avalibleActions)),"Actions")

draw_set_color(c_white)
draw_set_font(fntPixel)
draw_set_valign(fa_top)
draw_set_halign(fa_left)

_yy+=22
_xx+=2
for(var i=0; i<array_length(_avalibleActions); i++){
	
	draw_set_color(c_white)
	if tool=_avalibleActions[i]{
		draw_set_color(c_lime)
	}
	
	if mouseGuiX>_xx and mouseGuiX<_xx+32 and mouseGuiY>_yy and mouseGuiY<_yy+14{
		draw_set_color(c_yellow)
		if mouse_check_button_pressed(mb_left){
			playSound(choose(sndClick1,sndClick2,sndClick3))
			tool=_avalibleActions[i]
		}
	}
	
	draw_text(_xx,_yy,_avalibleActions[i])
	_yy+=18
}

#endregion

draw_set_color(c_white)

if toolTip!=""{
	drawTooltip(mouseGuiX,mouseGuiY,toolTip,sprEmpty)
	

}
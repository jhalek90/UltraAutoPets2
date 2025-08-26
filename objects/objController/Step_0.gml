/// @description Step logic


if tool="collect"{
	if mouse_check_button_pressed(mb_left){
		if place_meeting(mouse_x,mouse_y,objResoruce){
			var _this=instance_place(mouse_x,mouse_y,objResoruce)
			if instance_exists(_this){
				for (var i=0; i<array_length(unitList); i++){
					var _actor=unitList[i]
					_actor.state="collecting"
					_actor.collectTarget=_this
				}
			}
		}
	}
}

var _cwx=window_get_width()
var _cwy=window_get_height()

if _cwx!=0 and _cwy!=0{
	currentWindowWidth=_cwx
	currentWindowHeight=_cwy


	if (currentWindowWidth!=previousWindowWidth)or(currentWindowHeight!=previousWindowHeight){
		resizeWindow()
	}

}


if keyboard_check(vk_escape){
	unitList=[]
	with(objActor){
		selected=false
	}
}

if mouse_check_button_pressed(mb_left) and !mouseGuiHover{
	mouseDragStartX=mouse_x
	mouseDragStartY=mouse_y
}

if mouse_check_button(mb_left) and !mouseGuiHover{
	if mouseDrag=false{

		if point_distance(mouse_x,mouse_y,mouseDragStartX,mouseDragStartY)>8{
			mouseDrag=true
			
			if keyboard_check(vk_shift){
		
			}else{
				unitList=[]
				with(objActor){selected=false}
			}
		}	
	}
}

if mouse_check_button_released(mb_left) and !mouseGuiHover{
	
	if place_meeting(mouse_x,mouse_y,objActor) and !mouseDrag{
		exit
	}
	
	if !mouseDrag and tool="move"{
		var _mx=round(mouse_x/16)*16
		var _my=round(mouse_y/16)*16
		var _points=place_units(_mx,_my,unitList, unitSize)
		for(var i=0; i<array_length(unitList); i++){
			with(unitList[i]){
				actorPathToPoint(_points[i][0],_points[i][1])
				collectTarget=-1//reset collect target on move
			}
		}
	}
	mouseDrag=false
}

if mouseDrag{
	

	var _x=min(mouse_x,mouseDragStartX)
	var _X=max(mouse_x,mouseDragStartX)
	var _y=min(mouse_y,mouseDragStartY)
	var _Y=max(mouse_y,mouseDragStartY)
	
	with(objActor){
			
		if x>_x and x<_X and y>_y and y<_Y {
			setSelected(true)
		} 
		
	}
	
}


#region camera
if mouse_wheel_up() and !mouseGuiHover{
	cameraZoomIndex--
	if cameraZoomIndex<0{cameraZoomIndex=0}
	cameraZoom=cameraZoomLevels[cameraZoomIndex]
	resizeCamera()
}

if mouse_wheel_down() and !mouseGuiHover{
	cameraZoomIndex++
	if cameraZoomIndex>array_length(cameraZoomLevels)-1 {cameraZoomIndex=array_length(cameraZoomLevels)-1}
	cameraZoom=cameraZoomLevels[cameraZoomIndex]
	resizeCamera()
}

if cameraAnimateProgress<1{
	cameraAnimateProgress+=0.05
}

cameraAnimateX=twerp(TwerpType.out_expo,cameraStartX,cameraTargetX,cameraAnimateProgress)
cameraAnimateY=twerp(TwerpType.out_expo,cameraStartY,cameraTargetY,cameraAnimateProgress)

camera_set_view_pos(CAM,cameraAnimateX,cameraAnimateY)

if cameraFollowTarget!=-1{
	if instance_exists(cameraFollowTarget){
		var _cx=(cameraFollowTarget.x)-(CAM_W/2)
		var _cy=(cameraFollowTarget.y)-(CAM_H/2)
		
		cameraTargetX=_cx
		cameraTargetY=_cy
		
		camera_set_view_pos(CAM,_cx,_cy)
	}else{
		cameraFollowTarget=-1
	}
}


if cameraHold=true{
	var _dx=(mouse_x-cameraHoldPreviousX)/1
	var _dy=(mouse_y-cameraHoldPreviousY)/1

	
	if( abs(_dx)+abs(_dy) )>1{
		
		var _tx=clamp(CAM_X-_dx,0,room_width-CAM_W)
		var _ty=clamp(CAM_Y-_dy,0,room_height-CAM_H)
		
		camera_set_view_pos(CAM,_tx,_ty)
		cameraResetAnimation()
	}
	
	
	cameraHoldPreviousX=mouse_x
	cameraHoldPreviousY=mouse_y
	
}
#endregion
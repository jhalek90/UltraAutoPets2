/// @description Event
surface_resize(application_surface,1280,720)
display_set_gui_size(1280,720)

if instance_number(objController)>1{
	instance_destroy()
	exit
}

cameraZoomLevels=[0.25,0.5,1,2]
cameraZoomIndex=0
cameraZoom=cameraZoomLevels[cameraZoomIndex]

cameraBaseWidth=427
cameraBaseHeight=240

cameraStartX=CAM_X
cameraStartY=CAM_Y
cameraTargetX=CAM_X
cameraTargetY=CAM_Y
cameraAnimateX=CAM_X
cameraAnimateY=CAM_Y
cameraAnimateProgress=1
cameraFollowTarget=-1

cameraHold=false
cameraHoldPreviousX=CAM_X
cameraHoldPreviousY=CAM_Y



mouseDrag=false
mouseDragStartX=mouse_x
mouseDragStartY=mouse_y

preToolTip=""
toolTip=""

tool="select"
unitList=[]
unitSize=16
maxUnitsSelected=50

currentWindowWidth=window_get_width()
currentWindowHeight=window_get_height()
previousWindowWidth=0
previousWindowHeight=0

mouseGuiHover=false
mouseGuiX=0
mouseGuiY=0

function resizeWindow(){
	previousWindowWidth=currentWindowWidth
	previousWindowHeight=currentWindowHeight
	
	var _w=currentWindowWidth
	var _h=currentWindowHeight
	
	show_debug_message("width: "+string(currentWindowWidth)+"\nheight: "+string(currentWindowHeight))
	//show_message("width: "+string(currentWindowWidth)+"\nheight: "+string(currentWindowHeight))

	cameraBaseWidth=_w
	cameraBaseHeight=_h

	view_set_wport(0,_w)
	view_set_hport(0,_h)
	resizeCamera()



	surface_resize(application_surface,_w,_h)
	display_set_gui_size(_w,_h)
	draw_flush()

	
}


function resizeCamera(){
	
	var _oldCenterX=CAM_X+(CAM_W/2)
	var _oldCenterY=CAM_Y+(CAM_H/2)
	
	camera_set_view_size(CAM,cameraBaseWidth*cameraZoom,cameraBaseHeight*cameraZoom)
	
	
	var _minX=0
	var _minY=0
	var _maxX=room_width-CAM_W
	var _maxY=room_height-CAM_H
	
	var _cTargetX=_oldCenterX-(CAM_W/2)
	var _cTargetY=_oldCenterY-(CAM_H/2)
	
	_cTargetX=clamp(_cTargetX,_minX,_maxX)
	_cTargetY=clamp(_cTargetY,_minY,_maxY)
	
	camera_set_view_pos(CAM,_cTargetX,_cTargetY)
	cameraResetAnimation()
	
}

function cameraResetAnimation(){
	cameraStartX=CAM_X
	cameraStartY=CAM_Y
	cameraTargetX=CAM_X
	cameraTargetY=CAM_Y
	cameraAnimateX=CAM_X
	cameraAnimateY=CAM_Y
	cameraAnimateProgress=1
}

function cameraSoftTarget(_x,_y){
	cameraStartX=CAM_X
	cameraStartY=CAM_Y
	cameraAnimateX=CAM_X
	cameraAnimateY=CAM_Y
	cameraTargetX=_x-(CAM_W/2)
	cameraTargetY=_y-(CAM_H/2)
	cameraAnimateProgress=0
}

function snapCameraToObject(_o){
	
	
	var _minX=0
	var _minY=0
	var _maxX=room_width-CAM_W
	var _maxY=room_height-CAM_H
	var _cTargetX=_o.x-(CAM_W/2)
	var _cTargetY=_o.y-(CAM_H/2)
	
	_cTargetX=clamp(_cTargetX,_minX,_maxX)
	_cTargetY=clamp(_cTargetY,_minY,_maxY)
	
	camera_set_view_pos(CAM,_cTargetX,_cTargetY)
	
	cameraResetAnimation()
	
}

depth=-10000
global.gameData=new game()

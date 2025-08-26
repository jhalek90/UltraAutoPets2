/// @description Event

var mouseGuiX=device_mouse_x_to_gui(0)
var mouseGuiY=device_mouse_y_to_gui(0)

if hover{
	
	drawTooltip(mouseGuiX,mouseGuiY,name,sprEmpty)
	
	var _arr=[]
	var _name
	var _sprite
	var _match
	var _dx=mouseGuiX
	var _dy=mouseGuiY
	
	for(var i=0; i<array_length(contents); i++){
		var _this=contents[i]
		_name=_this.name
		_sprite=_this.sprite
		
		_match=false
		for(var j=0; j<array_length(_arr); j++){
			if _arr[j].name=_name{
				_arr[j].amount++
				_match=true
			}
		}
		
		if !_match{
			array_push(_arr,{name: _name, amount:1, sprite:_sprite})
		}
	}

	_dy+=18
	for( var i=0; i<array_length(_arr); i++){
		drawTooltip(_dx,_dy,_arr[i].name+" x"+string(_arr[i].amount),_arr[i].sprite)
		_dy+=18
	}
}
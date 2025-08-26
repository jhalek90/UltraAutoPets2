/// @description generate map
randomize()

startTime=current_time

function mapPoint(_x,_y,_biome)constructor{
	x=_x
	y=_y
	biome=_biome
}

function pushMapPointsAwayFromEachOther(){
	for(var i=0; i<array_length(mapPoints); i++){
		var _pointA=mapPoints[i]
		
		for(var j=0; j<array_length(mapPoints); j++){
			if (i != j){
				var _pointB=mapPoints[j]
				var _dis=fastDist(_pointA.x,_pointA.y,_pointB.x,_pointB.y)
				
				if _dis<320 and _dis>0{
					var _dir=point_direction(_pointB.x,_pointB.y,_pointA.x,_pointA.y)
					var _push=100/_dis
					 _pointA.x+=lengthdir_x(_push,_dir)
					 _pointA.y+=lengthdir_y(_push,_dir)
				}
			}
		}
	}
}
	
function getNearestMapPoint(_x,_y){
	var _minDist=999999
	var _closestPoint=-1
	for(var i=0; i<array_length(mapPoints); i++){
		var _thisPoint=mapPoints[i]
		var _thisDist=fastDist(_x,_y,_thisPoint.x,_thisPoint.y)
		if _thisDist<_minDist{
			_minDist=_thisDist
			_closestPoint=_thisPoint
		}
	}
	
	return _closestPoint
}
	
function drawMap(){
	for(var i=0; i<array_length(mapPoints); i++){
		var _thisPoint=mapPoints[i]
		draw_set_color(_thisPoint.biome)
		draw_circle(_thisPoint.x,_thisPoint.y,4,true)
	}




	for(var _yy=0; _yy<mapGridHeight; _yy++){
		for(var _xx=0; _xx<mapGridWidth; _xx++){
			var _thisGrid=mapGrid[# _xx,_yy]
			draw_set_color(_thisGrid)
			draw_rectangle(_xx*mapGridSize,_yy*mapGridSize,(_xx+1)*mapGridSize,(_yy+1)*mapGridSize,false)

		}
	}

	draw_set_color(c_white)
}
	
function fastDist(x1,y1,x2,y2){
	return point_distance(x1,y1,x2,y2)
}

surf=-1
//Initialize points
mapPoints=[]
mapGridSize=1
mapGridWidth=floor(room_width/mapGridSize)
mapGridHeight=floor(room_height/mapGridSize)
mapGrid=ds_grid_create(mapGridWidth,mapGridHeight)
ds_grid_set_region(mapGrid,0,0,mapGridWidth,mapGridHeight,c_white)

array_push(mapPoints,new mapPoint(room_width/2,room_height/2,c_lime))
array_push(mapPoints,new mapPoint(irandom(room_width),irandom(room_height/2),c_gray))


array_push(mapPoints,new mapPoint(irandom(room_width/2),irandom(room_height),c_blue))
array_push(mapPoints,new mapPoint(irandom(room_width/2)+(room_width/2),irandom(room_height),c_green))
array_push(mapPoints,new mapPoint(irandom(room_width),irandom(room_height/2)+(room_height/2),c_red))


repeat(10){
	array_push(mapPoints,new mapPoint(irandom(room_width),irandom(64),c_black))
}


pushMapPointsAwayFromEachOther()

for(var _yy=0; _yy<mapGridHeight; _yy++){
	for(var _xx=0; _xx<mapGridWidth; _xx++){
		var _cx=(_xx*mapGridSize)+(mapGridSize/2)
		var _cy=(_yy*mapGridSize)+(mapGridSize/2)
		
		mapGrid[# _xx,_yy]=getNearestMapPoint(_cx,_cy).biome
		
	}
}


genTime=current_time-startTime
show_debug_message("map generation took: "+string(genTime)+"ms")
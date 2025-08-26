/// @description Event
stateStep()
depth=-y

if task="deposit"{
	if instance_exists(objStorage){
		var _near=instance_nearest(x,y,objStorage)
		if point_distance(x,y,_near.x,_near.y )>32{
			if myPath=-1{
				var _x=_near.x+random_range(-32,32)
				var _y=_near.y+random_range(-32,32)
				actorPathToPoint(_x,_y)
			}
		}else{
			//we deposit
			actorDepositResources(_near)
			task=""
			//actorMineResource(_near)
		}
	}else{
		task=""
	}
}

if state="collecting"{
	if instance_exists(collectTarget){
		
		if array_length(collectTarget.contents)<=0{
			collectTarget=-1
			state="idle"
		}else{
			//if we are too far away to mine, we walk there
			if point_distance(x,y,collectTarget.x,collectTarget.y )>32{
				if myPath=-1{
					task="farm"
					var _x=collectTarget.x+random_range(-32,32)
					var _y=collectTarget.y+random_range(-32,32)
					actorPathToPoint(_x,_y)
				}
			}else{
				//we mine
				actorMineResource(collectTarget)
			}
		}
	}else{
		collectTarget=-1
		state="idle"
	}
}
	
if state="idle"{
	idleTimer++
	if random(100)>99 and idleTimer>60{
		var _tx=idleX+random_range(-64,64)
		var _ty=idleY+random_range(-64,64)
		
		_tx=clamp(_tx,0,room_width)
		_ty=clamp(_ty,0,room_height)
		
		actorPathToPoint(_tx,_ty)
	}
}else{
	idleTimer=0
	idleX=x
	idleY=y
}
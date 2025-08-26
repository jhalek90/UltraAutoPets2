/// @description Event
event_inherited()
mineRate=0.001


image_xscale=choose(-1,1)



name="Stone Node"
repeat(irandom_range(90,110)){
	array_push(contents,new resourceItem("stone",sprResourceStone))
}


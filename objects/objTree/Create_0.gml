/// @description Event
event_inherited()
mineRate=0.01
name="Oak Tree"
image_index=random(10)
sprite_index=choose(sprTree2892,sprTree6973,sprTree7304)
image_xscale=choose(-1,1)

repeat(irandom_range(5,10)){
	array_push(contents,new resourceItem("wood",sprResourceWood))
}

if random(100)>20{
	array_push(contents,new resourceItem("bird",sprResourceBird))
}
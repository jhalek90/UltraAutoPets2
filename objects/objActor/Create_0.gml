/// @description Event
stateMachineInit()
stateSet("idle")
selected=false
myPath=-1
walkSpeed=random_range(1,3)
animationFlip=1
name="Pig"
hover=false
contents=[]
collectTarget=-1
targetResource=-1

mineRate=1.0

task=""
job=""

idleX=x
idleY=y
idleTimer=0
extends KinematicBody2D


var speed=100
var accel=4
#Referencia a la maquina de estados del del animation tree
onready var state_machine=$AnimationTree.get("parameters/playback")
onready var timer=$Timer
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	print("timeout!")
	var duration= rand_range(3,7)
	#Reproducir animacion
	state_machine.travel("Attack")
	timer.start(duration)
	

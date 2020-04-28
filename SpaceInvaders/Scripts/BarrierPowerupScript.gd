extends Area2D
export(int) var Speed = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position.y += Speed


func _on_Area2D_body_entered(body):
	if(body.is_in_group("players")):
		self.queue_free()
		GlobalVariables.barrierRestore()

extends KinematicBody2D

var velocity = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):

	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)
	
func missileHit():
	GlobalVariables.score += 10	
	GlobalVariables.playerScore.set_text(str(GlobalVariables.score))
	self.queue_free()

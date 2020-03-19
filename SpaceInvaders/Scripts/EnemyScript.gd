extends KinematicBody2D
export(PackedScene) var EnemyMissileScene

var velocity = Vector2()
var shootTimer

var missile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	shootTimer = GlobalVariables.newTimer(5.0, self, self, "shootTimerStopped")
	shootTimer.start()


func _physics_process(delta):

	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)
	
func missileHit():
	GlobalVariables.score += 10	
	GlobalVariables.enemiesKilled += 1
	GlobalVariables.playerScore.set_text(str(GlobalVariables.score))
	self.queue_free()

func shootTimerStopped():
	missile = EnemyMissileScene.instance()
	
	missile.global_position.x = self.global_position.x - 9
	missile.global_position.y = self.global_position.y + 9
	
	missile.add_to_group("enemymissiles")
	
	get_tree().get_root().add_child(missile)
	shootTimer.start()

extends StaticBody2D
var sprite
var collision

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = self.get_node("Sprite")
	collision = self.get_node("CollisionShape2D")
	GlobalVariables.barrierArray.push_front(self)


func missileHit():
	collision.set_deferred("disabled", true)
	sprite.set_modulate(Color(0, 0, 0, 0))

func respawnBarrier():
	collision.set_deferred("disabled", false)
	sprite.set_modulate(Color(1, 1, 1, 1))

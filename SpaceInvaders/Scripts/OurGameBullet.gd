extends Area2D
export(PackedScene) var BarrierPowerUpScene
export(int) var Speed = 8
var powerUp
var angle
var playerNode
var randomGenerator
var chance


func _ready():
	randomGenerator = RandomNumberGenerator.new()
	get_node("notifier").connect("screen_exited", self, "_on_screen_exited")
	angle = Vector2(cos(90), sin(90))


func _physics_process(delta):
	position.y -= Speed


func _on_screen_exited():
	GlobalVariables.canFire = true
	self.queue_free()
	

func _on_Bullet_body_entered(body):
	self.queue_free()
	if(body.is_in_group("barriers") or body.is_in_group("enemies")):
		body.missileHit()
		randomGenerator.randomize()
		chance = randomGenerator.randf_range(0, 100)
		if(chance > 97):
			powerUp = BarrierPowerUpScene.instance()
			powerUp.position.x = self.global_position.x
			powerUp.position.y = self.global_position.y
			powerUp.add_to_group("powerUps")
			get_tree().get_root().add_child(powerUp)
	GlobalVariables.canFire = true

extends Area2D

export(int) var Speed = 3

var angle

var playerNode

func _ready():
	get_node("notifier").connect("screen_exited", self, "_on_screen_exited")
	angle = Vector2(cos(90), sin(90))


func _physics_process(delta):
	position.y += Speed


func _on_screen_exited():
	self.queue_free()

func _on_Bullet_body_entered(body):
	self.queue_free()
	if(body.is_in_group("players") or body.is_in_group("barriers")):
		body.missileHit()

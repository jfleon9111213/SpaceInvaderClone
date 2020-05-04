extends Area2D
export(int) var Speed = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position.y += Speed


func _on_Area2D_body_entered(body):
	if(body.is_in_group("players")):
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite.set_modulate(Color(0, 0, 0, 0))
		
		var randomVolume = rand_range(-2, 0)
		$collectSound.set_volume_db(randomVolume)
		$collectSound.play()
		var t = Timer.new()
		t.set_wait_time(0.1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		
		self.queue_free()
		GlobalVariables.barrierRestore()

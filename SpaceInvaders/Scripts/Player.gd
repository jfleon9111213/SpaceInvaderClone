extends KinematicBody2D
export(PackedScene) var MissileScene

var speed = 150
var velocity = Vector2()

var missile

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1

	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_released("fire"):			
			firePressed()

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	


func firePressed():
	
	if GlobalVariables.canFire:
		GlobalVariables.canFire = false
		fireMissile()


func fireMissile():
	
	missile = MissileScene.instance()
	
	missile.position.x = self.position.x + 245
	missile.position.y = self.position.y + 560
	
	missile.add_to_group("missiles")
	
	get_tree().get_root().add_child(missile)

func missileHit():
	var randomVolume = rand_range(-2, 0)
	$deathSound.set_volume_db(randomVolume)
	$deathSound.play()
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	GlobalVariables.player = null
	self.queue_free()
	GlobalVariables.playerDead = true
	return true

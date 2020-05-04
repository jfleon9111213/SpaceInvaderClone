extends KinematicBody2D
export(PackedScene) var MissileScene

var speed = 300
var velocity = Vector2()

var missile

var firingTimer

func _ready():
	GlobalVariables.player = self
	firingTimer = GlobalVariables.newTimer(0.2, self, self, "onFiringTimerStopped")

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if (Input.is_action_pressed('ui_right')):
		velocity.x += 1
	elif (Input.is_action_pressed('ui_left')):
		velocity.x -= 1
	else:
		velocity.x = 0
		
	if (Input.is_action_pressed('ui_down')):
		velocity.y += 1
	elif (Input.is_action_pressed('ui_up')):
		velocity.y -= 1
	else:
		velocity.y = 0

	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("fire"):			
			firePressed()

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	


func firePressed():
	
	if GlobalVariables.canFire:
		fireMissile()
		
		# Start the firing timer
		firingTimer.start()
	
		# Turn off the ability to fire until the firing interval time runs out
		GlobalVariables.canFire = false


func fireMissile():
	
	missile = MissileScene.instance()
	
	missile.position.x = self.position.x + 235
	missile.position.y = self.position.y + 560
	
	missile.add_to_group("playerBullets")
	
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


func _on_Area2D_body_entered(body):
	if(body.is_in_group("enemies")):
		self.missileHit()
		body.missileHit()

func onFiringTimerStopped():
	GlobalVariables.canFire = true

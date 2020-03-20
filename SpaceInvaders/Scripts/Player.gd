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
		
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1

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
		#firingTimer.start()
	
		# Turn off the ability to fire until the firing interval time runs out
		#canFire = false


func fireMissile():
	
	missile = MissileScene.instance()
	
	missile.position.x = self.position.x + 245
	missile.position.y = self.position.y + 560
	
	missile.add_to_group("missiles")
	GlobalVariables.canFire = false
	
	get_tree().get_root().add_child(missile)

func missileHitPlayer():
	self.queue_free()
	GlobalVariables.playerDead = true
	return true

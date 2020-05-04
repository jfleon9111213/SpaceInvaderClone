extends Area2D

export var speed = 350
export var steer_force = 50.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
var lifeTime

func _ready():
	lifeTime = GlobalVariables.newTimer(GlobalVariables.missileLifeTime, self, self, "missileTimerStopped")
	lifeTime.start()
	rotation += rand_range(-0.09, 0.09)

func seek():
	target = GlobalVariables.player
	var steer = Vector2.ZERO
	if target:
		var desired = (target.global_position - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	else:
		self.queue_free()
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta

func missileTimerStopped():
	explode()
	
func missileHit():
	explode()
	

func explode():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.set_modulate(Color(0, 0, 0, 0))
	var randomVolume = rand_range(-2, 0)
	$missileSound.set_volume_db(randomVolume)
	$missileSound.play()
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	
	self.queue_free()


func _on_Area2D_body_entered(body):
	if(body.is_in_group("players") or body.is_in_group("barriers")):
		explode()
		body.missileHit()


func _on_Missile_area_entered(area):
	if(area.is_in_group("playerBullets")):
		explode()
		area.missileHit()

func _on_screen_exited():
	self.queue_free()

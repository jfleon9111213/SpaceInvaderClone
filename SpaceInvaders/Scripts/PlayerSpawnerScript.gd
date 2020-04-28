extends Node2D
export(PackedScene) var PlayerScene


var player
var respawnTimer
signal you_died
var invincibleTimer
var playerCollision
var playerSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPlayer()
	respawnTimer = GlobalVariables.newTimer(0.5, self, self, "spawnTimerStopped")

func spawnPlayer():
	player = PlayerScene.instance()

	player.position.x = self.position.x
	player.position.y = self.position.y
	
	invincibleTimer = GlobalVariables.newTimer(1.0, self, self, "onInvincibleTimerStopped")
		
	playerCollision = player.get_node("Player").get_node("PlayerCollision")
	playerCollision.disabled = true
		
	playerSprite = player.get_node("Player").get_node("PlayerSprite")
	playerSprite.set_modulate(Color(1, 1, 1, 0.25))
		
	invincibleTimer.start()

	player.add_to_group("players")
	get_tree().get_root().add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GlobalVariables.playerDead):
		if(GlobalVariables.lives == 0):
			GlobalVariables.startGame()
			emit_signal('you_died')
			get_tree().change_scene("res://Scenes/GameOverScene.tscn")
		else:
			GlobalVariables.lives -= 1	
			GlobalVariables.playerLives.set_text(str(GlobalVariables.lives))
			GlobalVariables.playerDead = false
			respawnTimer.start()

func spawnTimerStopped():
	spawnPlayer()
	
func onInvincibleTimerStopped():
	playerCollision.disabled = false
	playerSprite.set_modulate(Color(1, 1, 1, 1))

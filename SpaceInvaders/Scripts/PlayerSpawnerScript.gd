extends Node2D
export(PackedScene) var PlayerScene


var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPlayer()

func spawnPlayer():
	player = PlayerScene.instance()

	player.position.x = self.position.x
	player.position.y = self.position.y

	#player.add_to_group("player")
	get_tree().get_root().add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

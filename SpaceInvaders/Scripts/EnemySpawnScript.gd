extends YSort
export(PackedScene) var EnemyScene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy
var list

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = EnemyScene.instance()

	enemy.position.x = self.global_position.x
	enemy.position.y = self.global_position.y

	get_tree().get_root().add_child(enemy)
	enemy.add_to_group("enemies")


func clearEnemies():
	for i in get_tree().get_root().get_children():
		if(i.is_in_group("enemies") or i.is_in_group("missiles")):
			i.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerSpawner_you_died():
	clearEnemies() # Replace with function body.

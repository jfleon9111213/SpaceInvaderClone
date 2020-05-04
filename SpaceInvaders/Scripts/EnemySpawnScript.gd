extends YSort
export(PackedScene) var EnemyScene

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


func _on_PlayerSpawner_you_died():
	clearEnemies()

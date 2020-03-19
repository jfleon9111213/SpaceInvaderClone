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

	enemy.position.x = self.position.x
	enemy.position.y = self.position.y

	enemy.add_to_group("enemies")
	get_tree().get_root().add_child(enemy)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

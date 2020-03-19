extends YSort


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var list
var respawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	list = get_children()
	respawnTimer = GlobalVariables.newTimer(0.5, self, self, "spawnTimerStopped")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GlobalVariables.enemiesKilled == 2):
		GlobalVariables.enemiesKilled = 0
		respawnTimer.start()

func spawnTimerStopped():
	for spawner in list:
		spawner._ready()

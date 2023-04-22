extends Node

enum {IDLE, PLAYING, ENTERING}

var state = IDLE

var maxButtons = 4

var sequence = []
signal buttonDone

func startGame():
	state = IDLE
	sequence = []
	
func addNewItem():
	var item = randi_range(0, maxButtons-1)
	sequence.push_back(item)
	
func startRound():
	addNewItem()
	state = PLAYING
	
func finishedPlaying():
	state = ENTERING

func gameOver():
	state = IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

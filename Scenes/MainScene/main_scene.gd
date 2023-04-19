extends Node2D

#font: Inter by rsms.me

var playedIndex = 0
var btns

# Called when the node enters the scene tree for the first time.
func _ready():
	btns = get_tree().get_nodes_in_group("buttons")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activateButton(num):
	
	btns[num].activate()

func _on_new_game_button_pressed():
	Globals.startGame()
	Globals.startRound()
	playedIndex = 0
	activateButton(Globals.sequence[playedIndex])

func _on_button_done():
	playedIndex+=1
	if playedIndex < len(Globals.sequence):
		activateButton(playedIndex)
	else:
		Globals.finishedPlaying()
		for btn in btns:
			btn.clickable = true

func _on_button_activated():
	pass

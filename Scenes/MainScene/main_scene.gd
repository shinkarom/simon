extends Node2D

#font: Inter by rsms.me

var playedIndex = 0
var btns

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	btns = get_tree().get_nodes_in_group("buttons")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activateButton(num):
	btns[num].activate()

func _on_new_game_button_pressed():
	Globals.startGame()
	startRound()

func startRound():
	Globals.startRound()
	var roundNum = len(Globals.sequence)
	$StateLabel.text = "Round "+str(roundNum) +"\nListen"
	playedIndex = 0
	activateButton(Globals.sequence[playedIndex])

func _on_button_done():
	playedIndex+=1
	if playedIndex < len(Globals.sequence):
		$Timer.start()
	else:
		Globals.finishedPlaying()
		var roundNum = len(Globals.sequence)
		$StateLabel.text = "Round "+str(roundNum) +"\nRepeat"
		playedIndex = 0
		for btn in btns:
			btn.clickable = true

func _on_button_activated(n):
	if n == Globals.sequence[playedIndex]:
		playedIndex+=1
		if playedIndex >= len(Globals.sequence):
			for btn in btns:
				btn.clickable = false
			$Timer.start()
	else:
		Globals.gameOver()
		$StateLabel.text = "Game Over\nin "+str(len(Globals.sequence))+" rounds"
		for btn in btns:
			btn.clickable = false


func _on_timer_timeout():
	if Globals.state == Globals.PLAYING:
		activateButton(Globals.sequence[playedIndex])
	else:
		startRound()

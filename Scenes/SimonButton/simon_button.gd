extends Node2D

var colorString = "red"
var simpletexture = load("res://Assets/"+colorString+".png")
var pressedtexture = load("res://Assets/"+colorString+"_pressed.png")

var state = 2

@export var color: String:
	get:	return colorString
	set(value):
		colorString = value
		$AudioStreamPlayer.stream = load("res://Assets/"+colorString+".ogg")
		simpletexture = load("res://Assets/"+colorString+".png")
		pressedtexture = load("res://Assets/"+colorString+"_pressed.png")
		$TextureButton.texture_normal = simpletexture
		$TextureButton.texture_hover = simpletexture
		$TextureButton.texture_pressed = pressedtexture	
		if pressed:
			$TextureButton.texture_disabled = pressedtexture
		else:
			$TextureButton.texture_disabled = simpletexture
		
var ispressed = false
@export var pressed: bool:
	get:
		return ispressed
	set(value):
		if value:
			$TextureButton.texture_disabled = pressedtexture
		else:
			$TextureButton.texture_disabled = simpletexture
			ispressed = value
		$TextureButton.button_pressed = value
		
var isclickable = false
@export var clickable: bool:
	get:	return isclickable
	set(value):
		isclickable = value
		$TextureButton.disabled = not value

signal activated
signal done	

func activate():
	state = 2
	$AudioStreamPlayer.play()
	$TextureButton.toggle_mode = true
	pressed = true
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	state -= 1
	if state == 0:
		pressed = false
		$TextureButton.toggle_mode = false
		emit_signal("done")

func _on_texture_button_button_up():
	if clickable:
		var t = get_meta("tag")
		emit_signal("activated", t)


func _on_audio_stream_player_finished():
	state -= 1
	if state == 0:
		if clickable:
			var t = get_meta("tag")
			emit_signal("activated", t)
		else:
			pressed = false
			$TextureButton.toggle_mode = false
			emit_signal("done")


func _on_texture_button_button_down():
	$AudioStreamPlayer.play()

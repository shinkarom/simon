extends Node2D

var colorString = "red"
var simpletexture = load("res://Assets/"+colorString+".png")
var pressedtexture = load("res://Assets/"+colorString+"_pressed.png")

@export var color: String:
	get:	return colorString
	set(value):
		colorString = value
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
	$TextureButton.toggle_mode = true
	pressed = true
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_button_pressed():
	if clickable:
		emit_signal("activated")

func _on_timer_timeout():
	pressed = false
	$TextureButton.toggle_mode = false
	emit_signal("done")


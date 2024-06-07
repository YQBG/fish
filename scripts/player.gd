extends CharacterBody2D


const SPEED = 5000
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
		
	if Input.is_action_pressed("up"):
		animated_sprite.play("up")
	elif Input.is_action_pressed("down"):
		animated_sprite.play("down")	
	elif Input.is_action_pressed("left"):
		animated_sprite.flip_h = true
		animated_sprite.play("left")
	elif Input.is_action_pressed("right"):
		animated_sprite.flip_h = false
		animated_sprite.play("right")
			
	velocity = direction * SPEED * delta
	move_and_slide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		var zoom_val = camera_2d.zoom.x + 0.1
		camera_2d.zoom = Vector2(zoom_val,zoom_val)
	elif Input.is_action_just_pressed("zoom_out"):	
		var zoom_val = camera_2d.zoom.x - 0.1
		camera_2d.zoom = Vector2(zoom_val,zoom_val)		

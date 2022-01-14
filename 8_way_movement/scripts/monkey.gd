extends KinematicBody2D

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")

var x_screen_size: int = 384
var y_screen_size: int = 256

var velocity: Vector2

export(int) var speed
export(int) var friction
export(int) var acceleration

func _physics_process(delta: float) -> void:
	move(delta)
	verify_position()
	
	
func move(delta: float) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/run/blend_position", input_vector)
		animation_state.travel("run")
		
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
		
	else:
		animation_state.travel("idle")
		
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = move_and_slide(velocity)


func verify_position() -> void:
	var screen_transform: Transform2D = get_transform()
	if screen_transform.origin.x > x_screen_size:
		screen_transform.origin.x = 0
		
	if screen_transform.origin.x < 0:
		screen_transform.origin.x = x_screen_size
		
	if screen_transform.origin.y > y_screen_size:
		screen_transform.origin.y = 0
		
	if screen_transform.origin.y < 0:
		screen_transform.origin.y = y_screen_size
		
	set_transform(screen_transform)

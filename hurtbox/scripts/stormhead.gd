extends KinematicBody2D

onready var sprite: Sprite = get_node("Texture")
onready var hurtbox: Area2D = get_node("Hurtbox")
onready var animation: AnimationPlayer = get_node("Animation")

var current_attack: String = ""

var velocity: Vector2

export(int) var speed
export(bool) var is_attacking

func _physics_process(_delta: float) -> void:
	move()
	attack()
	velocity = move_and_slide(velocity)
	animate()
	
	
func move() -> void:
	var direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	
	
func attack() -> void:
	if Input.is_action_just_pressed("attack_1") and not is_attacking:
		set_attack("attack_1")
	elif Input.is_action_just_pressed("attack_2") and not is_attacking:
		set_attack("attack_2")
		
		
		
func set_attack(attack: String) -> void:
	set_physics_process(false)
	current_attack = attack
	is_attacking = true
	
	
func animate() -> void:
	verify_direction()
	if is_attacking:
		animation.play(current_attack)
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
		
		
func verify_direction() -> void:
	if velocity.x > 0:
		hurtbox.scale.x = 1
		sprite.flip_h = false
	elif velocity.x < 0:
		hurtbox.scale.x = -1
		sprite.flip_h = true
		
		
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "attack_1" or anim_name == "attack_2":
		set_physics_process(true)
		current_attack = ""
		is_attacking = false

extends CharacterBody2D

@export var speed = 50.0
@export var jump = -150.0
@export var max_speed = 50
@onready var animator = $AnimatedSprite2D
var facing_right = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
	
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		velocity.x = 0
	
	if velocity.x != 0:
		velocity.x = clamp(velocity.x * speed,-max_speed,max_speed)
		if velocity.x > 0:
			facing_right = true
			animator.play("walk right")
		else:
			facing_right = false
			animator.play("walk left")
	else:
		if facing_right:
			animator.play("idle right")
		else:
			animator.play("idle left")
	
	#position += velocity * delta
	move_and_slide()

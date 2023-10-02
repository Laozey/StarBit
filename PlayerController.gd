extends Area2D

@export var rotation_speed = 0.02
@export var acceleration = 15
@export var coef_friction = 0.02

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1 
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	
	velocity += acceleration * direction.normalized() 
	
	var friction = velocity * coef_friction
	velocity -= friction
	print(velocity)
	position += velocity * delta 

extends CharacterBody2D

var start_time: int

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var is_jumping = false

@onready var timer: Timer = $Timer

@onready var point_light_2d: PointLight2D = $PointLight2D

@onready var jump_audio: AudioStreamPlayer2D = $jump_audio

#func start_the_jump_anim_timer():
	#print("started")
	#timer.start()
	
func _ready() -> void:
	start_time= Time.get_ticks_msec()
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var elapsed_seconds = (Time.get_ticks_msec() - start_time)/1000.0
	var y = (-1.0/200.0)*elapsed_seconds+1.0
	
	#print(y)
	point_light_2d.scale = Vector2(y,y)
	
	#print(position.y)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#print("JUMP!")
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_audio.play()
		animated_sprite_2d.play("jump")
		timer.start()
		#start_the_jump_anim_timer()
		#print(await animated_sprite_2d.animation_finished)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0: 
		animated_sprite_2d.flip_h = true
		
	if is_jumping: 
		#print("jump")
		var blah = 1
	elif direction == 0:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("walk")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
#
func _on_timer_timeout() -> void:
	is_jumping = false

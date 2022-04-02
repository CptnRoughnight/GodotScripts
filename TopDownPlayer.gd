extends KinematicBody2D

onready var animation = $AnimatedSprite

######################################################## Movement Variablen
var speed : float = 120.0
var runspeed : float = 180.0
var targetSpeed : float = 0.0
var curspeed : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO


func _ready():
	pass
	
	
func _physics_process(_delta):
	movement(_delta)
	Animation()
		
		
func _process(_delta):
	curspeed = direction.normalized()*targetSpeed
	curspeed = move_and_slide(curspeed,Vector2.UP)


#####################################################
##
##	Movement
## 
##  Move the player
##
#####################################################

func movement(_delta):
	if Input.is_action_pressed("left"):
		direction.x = -1
	elif Input.is_action_pressed("right"):
		direction.x = 1
	else:
		direction.x = 0
		
	if Input.is_action_pressed("up"):
		direction.y = -1
	elif Input.is_action_pressed("down"):
		direction.y = 1
	else:
		direction.y = 0
	
	if Input.is_action_pressed("sprint"):
		targetSpeed = runspeed
	else:
		targetSpeed = speed
#####################################################
	

#####################################################
##
##	Animation
## 
##  Animate the Player
##
#####################################################

func Animation() :
	var anim = "idle"
	
	if direction.x < 0 :
		anim="walk_left"
	elif direction.x > 0 :
		anim="walk_right"
	if direction.y < 0 :
		anim="walk_up"
	elif direction.y > 0 :
		anim="walk_down"
		
	# prevent animation stalling when 2 directions simultanously 
	if direction.x < 0 and direction.y < 0 :
		anim="walk_left"
	if direction.x > 0 and direction.y < 0 :
		anim="walk_right"
	if direction.x < 0 and direction.y > 0 :
		anim="walk_down"
	if direction.x > 0 and direction.y > 0 :
		anim="walk_down"
	
	if animation.animation!=anim:
		animation.play(anim)
#####################################################

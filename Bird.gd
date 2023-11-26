extends RigidBody2D

@onready var pipes = $"../ParallaxBackground"
var pipesList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pipesList = pipes.pipesList
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			self.set_linear_velocity(Vector2(0, -150))
			self.set_angular_velocity(-3)
			$AnimatedSprite2D.play("Fly")

## Called when hit detected, creates a 'bounce' and deletes the bird
func _hit_detected(x, y):
	self.set_linear_velocity(Vector2(x, y))
	await get_tree().create_timer(0.25).timeout
	self.queue_free()
	return

func _on_area_2d_body_entered(body):
	print('body name: ' + body.name)
	
	match body.name:
		"Floor":
			_hit_detected(0, -150)

		"Pipes":
			_hit_detected(-150, 0)
			
	for pipe in pipesList:
		if body.name in str(pipe):
			_hit_detected(-150, 0)
	
	
#

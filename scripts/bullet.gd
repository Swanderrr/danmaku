extends Spatial

var speed = 40
var motion_dir = Vector3()

func _physics_process(dt):
	translation += motion_dir * speed * dt
	pass





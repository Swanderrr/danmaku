extends Spatial

export(int, "manual", "auto") var control_type
onready var bullet_group    = get_node("/root/main/world/entities/bullets")
onready var bullet_spawner = get_node("visuals/bullet_spawner")

func _process(dt):
	var mouse_pos = get_viewport().get_camera().project_position(get_viewport().get_mouse_position(),get_viewport().get_camera().global_transform.origin.z)
	look_at(mouse_pos,Vector3(0,0,1))
	rotate_object_local(Vector3(1,0,0),deg2rad(-90))
	pass

func _physics_process(dt):
	pass

func shoot():
	#print("Bang-bang from " + name)
	
	var bullet = Bullets.bullet_def.instance()
	var temp_angle = get_rotation_degrees().z + 90
	
	bullet_group.add_child(bullet)	
	bullet.motion_dir  = Vector3(cos(deg2rad(temp_angle)),sin(deg2rad(temp_angle)),0)
	bullet.translation = bullet_spawner.get_global_transform().origin
	bullet.rotation_degrees = Vector3(0,0,temp_angle-90)
	
	pass



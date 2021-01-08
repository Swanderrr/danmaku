extends KinematicBody

var speed = {"def":0, "mod":0, "cur":1, "maximum":20};

onready var ship_parts = $parts;
onready var trans_def  = ship_parts.transform

var turrets = []


var velocity = Vector3();
var acc = 40
var dec = 40


var input_lead_name = {"x":"","y":""}
var input_lead = Vector2();
var input_cur  = 0;
var input = Vector2();

func _ready():
	
	_init_turrets()
	
	pass






func _input(event):
	
	if(Input.is_action_just_pressed("p_shoot")):
		for turret in turrets: turret.shoot()
	
	
	if(Input.is_action_just_pressed("p_left")):   
		input_lead.x = -1;
		input_lead_name.x = "p_left"
	elif(Input.is_action_just_pressed("p_right")):
		input_lead.x =  1;
		input_lead_name.x = "p_right"
		
	if(Input.is_action_just_released("p_left")    and Input.is_action_pressed("p_right")): 
		input_lead.x =  1;
		input_lead_name.x = "p_right"
	elif(Input.is_action_just_released("p_right") and Input.is_action_pressed("p_left")):  
		input_lead.x = -1;
		input_lead_name.x = "p_left"
	
	
	if(Input.is_action_just_pressed("p_up")):   
		input_lead.y =  1;
		input_lead_name.y = "p_up"
	elif(Input.is_action_just_pressed("p_down")):
		input_lead.y = -1;
		input_lead_name.y = "p_down"
		
	if(Input.is_action_just_released("p_up")     and Input.is_action_pressed("p_down")): 
		input_lead.y = -1;
		input_lead_name.y = "p_down"
	elif(Input.is_action_just_released("p_down") and Input.is_action_pressed("p_up")):  
		input_lead.y =  1;
		input_lead_name.y = "p_up"
	
	input.x = Input.get_action_strength(input_lead_name.x) * input_lead.x;
	input.y = Input.get_action_strength(input_lead_name.y) * input_lead.y;
	pass

func _process(dt):
	
	var vel_perc_x = velocity.x / speed.maximum
	var vel_perc_y = velocity.y / speed.maximum
	var rot_deg  = 15

	var trans_temp       = trans_def.rotated(Vector3(1,0,0),deg2rad(-rot_deg / 2 * vel_perc_y))
	trans_temp           = trans_temp.rotated(Vector3(0,1,0),deg2rad(rot_deg * vel_perc_x))
	ship_parts.transform = trans_temp.rotated(Vector3(0,0,1),deg2rad(-rot_deg * vel_perc_x))
	pass


func _physics_process(dt):
	

	if(input.x):
		velocity.x = clamp(velocity.x + acc * input.x * dt, -speed.maximum, speed.maximum);
	else:
		if(velocity.x < 0): velocity.x = min(velocity.x + dec * -sign(velocity.x) * dt,0)
		else:               velocity.x = max(velocity.x + dec * -sign(velocity.x) * dt,0)
	
	if(input.y):
		velocity.y = clamp(velocity.y + acc * input.y * dt, -speed.maximum, speed.maximum);
	else:
		if(velocity.y < 0): velocity.y = min(velocity.y + dec * -sign(velocity.y) * dt,0)
		else:               velocity.y = max(velocity.y + dec * -sign(velocity.y) * dt,0)
	
		
	
	velocity = move_and_slide(velocity)
	
	
	pass
	
	
func _init_turrets():
	turrets = get_node("turrets").get_children()
	pass
	
	
	
	
	

extends Node2D

var X_CUT = 15
var Y_CUT = 15
var frame_counter = 0
var all_fragments = []
var start_process = false
#var weight = 900

func _ready():
	$Sprite.set_vframes(Y_CUT)
	$Sprite.set_hframes(X_CUT)

#var debug_counter = 0
func _process(delta):
	$fps.text = "FPS: "+str(Engine.get_frames_per_second())
#	debug_counter+=delta
#	if debug_counter > 0.5:
	if frame_counter < X_CUT*Y_CUT: # and start_process == true
		generate_fragment(frame_counter)
		frame_counter+=1

func generate_fragment(i):
	## DIVIDING SPRITE ##
	var fragmt_sprite = Sprite.new()
	fragmt_sprite.set_texture($Sprite.texture)
	fragmt_sprite.scale = $Sprite.scale
	fragmt_sprite.set_vframes(Y_CUT)
	fragmt_sprite.set_hframes(X_CUT)
	fragmt_sprite.set_frame(i)
	
	## COLLISION SHAPE ##
	var fragmt_shape = CollisionShape2D.new()
	var rect_shape = RectangleShape2D.new()
	var sprite_size = fragmt_sprite.get_rect().position*$Sprite.scale
	rect_shape.set_extents(Vector2(16,10.5))
	rect_shape.set_extents(sprite_size)
	fragmt_shape.set_shape(rect_shape)
	
	## ASSEMBLING IT INTO A RIGIDBODY ##
	var fragmt = RigidBody2D.new()
	fragmt.name = "GENERATED BODY"
	fragmt.add_child(fragmt_sprite)
	fragmt.add_child(fragmt_shape)
	fragmt.set_mode(RigidBody2D.MODE_STATIC)
	
	# SET PIECES TO PROPER POSITIONS
#	fragmt.set_position($debug_spawn.position)
	var new_pos = $debug_spawn.position
	new_pos.x -= (fragmt_sprite.get_frame_coords().x+1)*(sprite_size.x*2)
	new_pos.y -= (fragmt_sprite.get_frame_coords().y+1)*(sprite_size.y*2)
	fragmt.set_position(new_pos)
	
	all_fragments.append(fragmt)
	add_child(fragmt)
#	if i+1 == Y_CUT*X_CUT:
#		for f in all_fragments:
#			f.set_mode(RigidBody2D.MODE_RIGID)
#			f.set_applied_torque(1000)
#			var new_force = Vector2(0,0)
#			new_force.x = rand_range(-100,100)
#			new_force.y = rand_range(-300,0)
#			f.set_linear_velocity(new_force)
#			$despawn_tween.interpolate_property(f,"scale",
#			f.scale,Vector2(0,0),2.5,
#			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			$despawn_tween.start()

func destruction():
	for f in all_fragments:
		f.set_mode(RigidBody2D.MODE_RIGID)
		f.set_applied_torque(1000)
		var new_force = Vector2(0,0)
		new_force.x = rand_range(-100,100)
		new_force.y = rand_range(-200,0)
		f.set_linear_velocity(new_force)
		$despawn_tween.interpolate_property(f,"scale",
		f.scale,Vector2(0,0),3.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$despawn_tween.start()


func get_all_children():
	for c in get_children():
		prints(c,c.name)


func _on_despawn_tween_tween_completed(object, key):
	object.queue_free()


func _on_Button_pressed():
	destruction()
	$Button.disabled = true
#	start_process = true
	

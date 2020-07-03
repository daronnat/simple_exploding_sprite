extends Node2D

var X_CUT = 2
var Y_CUT = 3

var frame_counter = 0
#var fragment_counter = 0
#var fragments

func _ready():
#	print($Sprite.get_rect())
	$Sprite.set_vframes(Y_CUT)
	$Sprite.set_hframes(X_CUT)
	
#	test_generate_rigid_body()
	
var debug_counter = 0
func _process(delta):
	$fps.text = "FPS: "+str(Engine.get_frames_per_second())
	debug_counter+=delta
	if debug_counter > 0.5:
		debug_counter = 0
		
		
		
		if frame_counter < X_CUT*Y_CUT:
			generate_fragment(frame_counter)
			frame_counter+=1
			
func generate_fragment(i):
	print(i)
#	$Sprite.set_frame(i)
	
	var fragmt = RigidBody2D.new()
	
	var fragmt_sprite = Sprite.new()
	fragmt_sprite.set_texture($Sprite.texture)
	fragmt_sprite.set_vframes(Y_CUT)
	fragmt_sprite.set_hframes(X_CUT)
	fragmt_sprite.set_frame(i)
	
	var fragmt_shape = CollisionShape2D.new()
	var rect_shape = RectangleShape2D.new()
	rect_shape.set_extents(Vector2(16,10.5))
	rect_shape.set_extents(fragmt_sprite.get_rect().position)
	fragmt_shape.set_shape(rect_shape)
	
	fragmt.name = "GENERATED BODY"
	fragmt.add_child(fragmt_sprite)
	fragmt.add_child(fragmt_shape)
	fragmt.set_position($debug_spawn.position)
	
	add_child(fragmt)
	
#	$Sprite.set_frame(i)
	

func test_generate_rigid_body():
	var fragmt = RigidBody2D.new()
	var fragmt_sprite = Sprite.new()
	fragmt_sprite.set_texture($debug_sprite.texture)
	
	var fragmt_shape = CollisionShape2D.new()
	var rect_shape = RectangleShape2D.new()
	rect_shape.set_extents(Vector2(50,20))
	fragmt_shape.set_shape(rect_shape)
	
	fragmt.name = "GENERATED BODY"
	fragmt.add_child(fragmt_sprite)
	fragmt.add_child(fragmt_shape)
	fragmt.set_position($debug_spawn.position)
	
	add_child(fragmt)
#	var instance_fragmt = fragmt.instance()
#	self.get_parent().add_child(instance_fragmt)
	
#	get_all_children()

func get_all_children():
	for c in get_children():
		prints(c,c.name)



#	fragments = generate_fragment()
#
#var debug_counter = 0
#func _process(delta):
#	debug_counter+=delta
#	if debug_counter > 0.5:
#		debug_counter = 0
#		select_frame()
#
#func generate_fragment():
#	fragments = []
#	var i = 0
#	for y in Y_CUT:
#		for x in X_CUT:
#			i+=1
#			fragments.append(Vector2(x,y))
#	print(fragments)
#	return fragments
#
#func select_frame():
#	$Sprite.set_vframes(fragments[fragment_counter].x)
#	$Sprite.set_hframes(fragments[fragment_counter].y)
#	if fragment_counter < len(fragments)-1:
#		fragment_counter += 1


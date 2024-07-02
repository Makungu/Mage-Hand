extends Node

class_name State

var character: CharacterBody2D
var next_state: State

func state_input(event: InputEvent):
	pass
	
#function should be overridden for use in individual states to do any additional processing when entering a state
func on_enter():
	pass

#function should be overridden for use in individual states to do any additional processing when exiting a state
func on_exit():
	pass

#function should be overridden for use in individual states to do any processing on each game tick
func state_process(delta):
	pass

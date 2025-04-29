extends Node

var two_player: bool
var game_track_path: String
var number_of_laps = 0
var player_one_car = -1 # The index of the car in `car_paths`
var player_two_car = -1 # `-1` means none selected

var car_path_header = "res://assets/models/OBJ format/" # The directory the models are stored in
var car_file_type = ".obj" # The file extension for the car models
var car_names = ["ambulance", "delivery-flat", "delivery", "firetruck",
"garbage-truck", "hatchback-sports", "police", "race-future", "race",
"sedan-sports", "sedan", "suv-luxury", "suv", "taxi", "tractor-police", "tractor-shovel",
"tractor", "truck-flat", "truck", "van"]

var car_image_path_header = "res://assets/images/model-previews/"
var car_image_file_type = ".png"

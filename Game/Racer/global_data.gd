extends Node

var two_player: bool
var game_track_path: String
var number_of_laps = 0
var player_one_car = -1 # The index of the car in `car_paths`
var player_two_car = -1 # `-1` means none selected

var car_path_header = "assets/models/OBJ format/" # The directory the models are stored in
var car_file_types = ".obj" # The file extension for the car models
var car_paths = ["ambulance", "delivery-flat", "delivery", "firetruck",
"garbage-truck", "hatchback-sports", "police", "race-future", "race",
"sedan-sports", "sedan", "suv-luxury", "suv", "taxi", "tractor-police", "tractor-shovel",
"tractor", "truck-flat", "truck", "van"]

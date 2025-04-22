extends Node

var two_player: bool
var game_track_path: String
var number_of_laps = 0
var player_one_car = -1 # The index of the car in `car_paths`
var player_two_car = -1 # `-1` means none selected

var car_paths = ["assets/models/", "assets/models/"]

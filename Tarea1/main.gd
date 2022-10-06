extends Node
var board : Array

# State of player, X or O
var player : String

# State for a winner or not
var is_winner: bool = false

# State for game over or not
var is_gameover: bool = false

# State for draw/tie or not
var is_draw: bool = false

# LOAD IMAGE FILES
# Button unpressed
var unpressed = preload("res://unpressed-tile.png")
# Button for Player X
var player_x = preload("res://XGlow.png")

# Button for Player O
var player_o =preload("res://OGlow.png")
signal points_changex(new_speed)
signal points_changeo(new_speed)
var pointsx=0
var pointso=0
# Initiates board/game data
func initiate_board() -> void:
	board = [
		"0", "0", "0",
		"0", "0", "0",
		"0", "0", "0"
	]
	$Board/Row1/button1.texture_normal = unpressed
	$Board/Row1/button2.texture_normal = unpressed
	$Board/Row1/button3.texture_normal = unpressed	
	$Board/Row2/button4.texture_normal = unpressed
	$Board/Row2/button5.texture_normal = unpressed
	$Board/Row2/button6.texture_normal = unpressed
	$Board/Row3/button7.texture_normal = unpressed
	$Board/Row3/button8.texture_normal = unpressed
	$Board/Row3/button9.texture_normal = unpressed
	is_gameover = false
	is_winner = false
	is_draw = false	

# Initiates a player
func initiate_player() -> void:
	player = "x"

# Runs automatically when scene is loaded
func _ready() -> void:
	initiate_board()
	initiate_player()

# Next player's turn
func update_player() -> void:
	if player == "x":
		player = "o"
	else:
		player = "x"

# Check rows for a match 3
func is_row_matched() -> bool:
	var offset = 0
	for row in range(3):
		for index in range(0 + offset, 3 + offset):
			if board[index] == player:
				is_winner = true
			else:
				is_winner = false
				break
		if is_winner:
			return true
		offset += 3
	return false

# Check columns for a match 3
func is_col_matched() -> bool:
	var offset = 0
	for col in range(3):
		for index in range(0 + offset, 7 + offset, 3):
			if board[index] == player:
				is_winner = true
			else:
				is_winner = false
				break
		if is_winner:
			return true
		offset += 1
	return false
	
# Check diagonals for a match 3
func is_diag_matched() -> bool:
	for i in range(0, 9, 4):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	for i in range(2, 7, 2):
		if board[i] == player:
			is_winner = true
		else:
			is_winner = false
			break
	if is_winner:
		return true
	return false

# Check if board is full
func is_board_full() -> bool:
	if board.has("0"):
		return false
	return true

# Check for win/draw conditions
func check_gameover() -> void:
	if is_row_matched() || is_col_matched() || is_diag_matched():
		is_gameover = true
		
		add_gameover_message()
	elif is_board_full():
		is_gameover = true
		is_draw = true
		add_gameover_message()

# Show a gameover message
func add_gameover_message() -> void:
	if is_draw:
		$Label.text = "Game is a draw!"
	else:
		$Label.text = "Player " + player + " wins!"
		points()
		
# Increment points
func points ():
	if player=="x" && is_gameover == true && is_draw == false:
		pointsx+=10
		emit_signal("points_changex",pointsx)
	elif player=="o" && is_gameover == true && is_draw == false:
		pointso+=10
		emit_signal("points_changeo",pointso)
# Mark player's move
func make_move(index: int) -> void:
	board[index] = player
	check_gameover()

# Check if button/square is free or open
func is_square_free(index: int) -> bool:
	if board[index] == "0":
		return true
	return false

# Update board with X or O button image
func update_board(row: int, index: int) -> void:
	var path = "Board/Row" + String(row+1) + "/button" + String(index+1)
	if player == "x":
		get_node(path).texture_normal = player_x
	elif player == "o":
		get_node(path).texture_normal = player_o
	update_player()


func _on_button1_button_up():
	if is_square_free(0) && !is_gameover:
		make_move(0)
		update_board(0, 0)


func _on_button2_button_up():
	if is_square_free(1) && !is_gameover:
		make_move(1)
		update_board(0, 1)


func _on_button3_button_up():
	if is_square_free(2) && !is_gameover:
		make_move(2)
		update_board(0, 2)


func _on_button4_button_up():
	if is_square_free(3) && !is_gameover:
		make_move(3)
		update_board(1, 3)


func _on_button5_button_up():
	if is_square_free(4) && !is_gameover:
		make_move(4)
		update_board(1, 4)


func _on_button6_button_up():
	if is_square_free(5) && !is_gameover:
		make_move(5)
		update_board(1, 5)


func _on_button7_button_up():
	if is_square_free(6) && !is_gameover:
		make_move(6)
		update_board(2, 6)


func _on_button8_button_up():
	if is_square_free(7) && !is_gameover:
		make_move(7)
		update_board(2, 7)


func _on_button9_button_up():
	if is_square_free(8) && !is_gameover:
		make_move(8)
		update_board(2, 8)



func _on_Button_button_up():
	
	initiate_board()
	initiate_player()

using DelimitedFiles

function readInput(filename::String)
	f = readdlm(filename, ' ')
	no_players = f[1]
	final_pts = f[7]
	return no_players, final_pts
end

function addMarble(marbles::Array{Int64,1}, marble::Int64, current_idx::Int64, 
	scores::Array{Int64,1}, player::Int64)
	if marble%23 != 0
		if current_idx + 2 >= length(marbles)+2
			current_idx = 2
		else
			current_idx += 2
		end
		insert!(marbles, current_idx, marble)
	else
		scores[player] += marble
		if current_idx - 7 <= 0
			current_idx = length(marbles) + (current_idx - 7)
		else
			current_idx -= 7
		end
		scores[player] += marbles[current_idx]
		deleteat!(marbles, current_idx)
	end
	return marbles, current_idx, scores
end

function playGame(no_players::Int64, final_pts::Int64)
	scores = zeros(Int, no_players)
	marbles = [0]
	current_idx = 1
	player = 1
	for i = 1:final_pts
		marbles, current_idx, scores = addMarble(marbles, i, current_idx,
			scores, player)

		player += 1
		if player > no_players
			player = 1
		end
	end
	return maximum(scores)
end

function addMarbleCircular(marbles::Array{Int64,1}, marble::Int64, 
	scores::Array{Int64,1}, player::Int64)
	if marble%23 != 0
		marbles = circshift(marbles, -2)
		prepend!(marbles, marble)
	else
		scores[player] += marble
		marbles = circshift(marbles, 6)
		scores[player] += pop!(marbles)
	end
	return marbles, scores
end

function playGameCircular(no_players::Int64, final_pts::Int64)
	scores = zeros(Int, no_players)
	marbles = [0]
	current_idx = 1
	player = 1
	for i = 1:final_pts
		marbles, scores = addMarbleCircular(marbles, i,
			scores, player)

		player += 1
		if player > no_players
			player = 1
		end
	end
	return maximum(scores)
end

# part 1
no_players, final_pts = readInput("day9.input")
mscore = playGame(no_players, final_pts)
println("winning Elf's score: ", mscore)

# part 2
# mscore = playGame(no_players, final_pts*100)
println("Winning Elf's score with 100x marbles: ", mscore)
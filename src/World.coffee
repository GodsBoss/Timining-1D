class World
	constructor:(@player, @level)->
		@furnaces = []
		@items = []
		@time = 0

	createItem:(type, position)->

	tick:(time)->
		@time += time
		@player.tick time

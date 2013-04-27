class World
	constructor:(@player)->
		@furnaces = []
		@items = []
		@time = 0
		@bushes = {}
		@trees = {}

	tick:(time)->
		@time += time
		@player.tick time
		for position, bush of @bushes
			bush.grow time
		for position, tree of @trees
			tree.grow time

	createItem:(type, position)->

	createTree:(position)->
		@trees[position] = new Tree position

	createBush:(position)->
		@bushes[position] = new Bush position

	playerHit:()->
		console.log 'Hit!'

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
		item = new Item type, position
		@items.push item
		console.log item

	createTree:(position)->
		@trees[position] = new Tree position

	createBush:(position)->
		@bushes[position] = new Bush @, position

	playerHit:()->
		position = Math.round @player.getHitPoint()
		piece = @level.getPiece position
		if piece.special?
			if piece.special.type == 'bush'
				piece.special.bush.loseApple()

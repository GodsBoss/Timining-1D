class World
	constructor:(@player)->
		@furnaces = []
		@items = []
		@time = 0
		@bushes = {}
		@trees = {}

	tick:(time)->
		@time += time
		@player.tick time, @level
		for position, bush of @bushes
			bush.grow time
		for position, tree of @trees
			tree.grow time
		@playerPicksItems()

	createItem:(type, position, random = true)->
		item = new Item type, position + (if random then Math.random() - 0.5 else 0)
		@items.push item

	createItems:(type, position, number, random = true)->
		for i in [1..number]
			@createItem type, position, random

	createTree:(position)->
		@trees[position] = new Tree @, position

	createBush:(position)->
		@bushes[position] = new Bush @, position

	playerHit:()->
		position = Math.round @player.getHitPoint()
		piece = @level.getPiece position
		if piece.type == 'dirt-flat'
			if piece.special?
				if piece.special.type == 'bush'
					piece.special.bush.loseApple()
				if piece.special.type == 'tree'
					piece.special.tree.hit 0.2
		if piece.type == 'dirt'
			@player.dig piece, position, @
		if piece.type == 'rock'
			@player.mine piece, position, @

	playerPicksItems:()->
		itemsToRemove = []
		for item, index in @items
			if Math.abs(@player.position - item.position) < 0.2
				itemsToRemove.unshift index
		for index in itemsToRemove
			@items[index] = @items[@items.length-1]
			@player.gatherItem @items.pop()

	destroyTree:(tree)->
		delete @trees[tree.position]
		@level.removeTree tree

	getPossiblePlayerActions:()->
		[]

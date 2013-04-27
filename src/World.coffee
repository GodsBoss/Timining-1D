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
		@playerPicksItems()

	createItem:(type, position, random = true)->
		item = new Item type, position + (if random then Math.random() - 0.5 else 0)
		@items.push item

	createTree:(position)->
		@trees[position] = new Tree @, position

	createBush:(position)->
		@bushes[position] = new Bush @, position

	playerHit:()->
		position = Math.round @player.getHitPoint()
		piece = @level.getPiece position
		if piece.special?
			if piece.special.type == 'bush'
				piece.special.bush.loseApple()
			if piece.special.type == 'tree'
				piece.special.tree.hit 0.2

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

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

	playerPicksItems:()->
		itemsToRemove = []
		for item, index in @items
			if Math.abs(@player.position - item.position) < 0.2
				itemsToRemove.unshift index
		for index in itemsToRemove
			@items[index] = @items[@items.length-1]
			@player.gatherItem @items.pop()

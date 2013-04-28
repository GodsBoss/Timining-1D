class World
	constructor:(@player)->
		@furnaces = {}
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
		for position, furnace of @furnaces
			furnace.pass time
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

	createFurnace:(position)->
		@furnaces[position] = new Furnace @, position

	playerHit:()->
		position = Math.round @player.getHitPoint()
		piece = @level.getPiece position
		if piece.type == 'dirt-flat'
			if piece.special?
				if piece.special.type == 'bush'
					piece.special.bush.loseApple()
				if piece.special.type == 'tree'
					piece.special.tree.hit @player.getChoppingPower()
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
			item = @items[index]
			@items[index] = @items[@items.length-1]
			@items.pop()
			@player.gatherItem item

	destroyTree:(tree)->
		delete @trees[tree.position]
		@level.removeTree tree

	getPossiblePlayerActions:()->
		actions = []
		piece = @level.getPiece(Math.round @player.position)
		if @player.canEat() and @player.has 'apple'
			actions.push new PlayerEatsAppleAction @player
		if @player.has 'sapling'
			if piece.type == 'dirt-flat' and (!piece.special? or piece.special.type == 'grass')
				actions.push new PlantSaplingAction @
		if @player.has 'wood', 4
			if (piece.type == 'dirt-flat' or piece.type == 'rock-flat') and (!piece.special? or piece.special.type == 'grass')
				actions.push new CreateWorkbenchAction @
		if @player.has 'furnace'
			if (piece.type == 'dirt-flat' or piece.type == 'rock-flat') and (!piece.special? or piece.special.type == 'grass')
				actions.push new CreateFurnaceAction @
		if piece.special? and piece.special.type == 'workbench'
			for name, recipe of Recipe.recipes.workbench
				if recipe.ingredientsContainedIn @player.bag
					actions.push new WorkbenchRecipeAction recipe, @player
		if piece.special? and piece.special.type == 'furnace' and piece.special.furnace.isEmpty()
			for name, recipe of Recipe.recipes.furnace
				if recipe.ingredientsContainedIn @player.bag
					actions.push new FurnaceRecipeAction recipe, @player, piece.special.furnace
		actions

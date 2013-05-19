class World
	@MAX_ZOMBIES = 20
	@SPAWN_THRESHOLD = 30
	@MIN_SPAWN_THRESHOLD = 10
	@SPAWNING_CONVERSION = 0.025

	constructor:(@player)->
		@furnaces = {}
		@items = []
		@time = 0
		@bushes = {}
		@trees = {}
		@zombies = []
		@spawnZone =
			left: 0
			right: 0
		@spawnValue = -60
		@spawnFactor = 0

	tick:(time)->
		@time += time
		@player.tick time, @level
		for position, bush of @bushes
			bush.grow time
		for position, tree of @trees
			tree.grow time
		for position, furnace of @furnaces
			furnace.pass time
		deadZombies = []
		for zombie, index in @zombies
			zombie.pass time
			if zombie.isDead()
				deadZombies.unshift index
		for index in deadZombies
			@zombies[index] = @zombies[@zombies.length-1]
			@zombies.pop()
		@playerPicksItems()
		@maybeSpawnZombies time

	createItem:(type, position, random = true)->
		item = new Item type, position + (if random then Math.random() - 0.5 else 0)
		@items.push item

	createItems:(type, position, number, random = true)->
		for i in [1..number]
			@createItem type, position, random

	createTree:(position, size)->
		@trees[position] = new Tree @, position, size

	createBush:(position)->
		@bushes[position] = new Bush @, position

	createFurnace:(position)->
		@furnaces[position] = new Furnace @, position

	playerHit:()->
		if @playerHitsZombie()
			return
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

	playerHitsZombie:()->
		playerPosition = @player.getHitPoint()
		for zombie in @zombies
			zombiePosition = zombie.position
			if Math.abs(playerPosition - zombiePosition) <= Zombie.WIDTH
				zombie.isHit @player.getAttackPower()
				return true

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

	maybeSpawnZombies:(time)->
		@spawnFactor += time
		@spawnValue += time
		@adjustSpawnZones()
		if @zombies.length < World.MAX_ZOMBIES and @spawnValue > @spawnThreshold()
			@spawnZombie()
			@spawnValue -= @spawnThreshold()

	adjustSpawnZones:()->
		@spawnZone.left = Math.min @spawnZone.left, @player.position
		@spawnZone.right = Math.max @spawnZone.right, @player.position

	spawnThreshold:()->
		Math.max World.MIN_SPAWN_THRESHOLD, World.SPAWN_THRESHOLD - @spawnFactor * World.SPAWNING_CONVERSION

	spawnZombie:()->
		possiblePositions = []
		if @player.position - 6 > @spawnZone.left
			possiblePositions.push @player.position - 6
		if @player.position + 6 < @spawnZone.right
			possiblePositions.push @player.position + 6
		if possiblePositions.length > 0
			position = possiblePositions[Math.floor Math.random()*possiblePositions.length]
			@zombies.push new Zombie @, position, 1

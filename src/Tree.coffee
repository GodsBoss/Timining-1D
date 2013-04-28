class Tree
	@GROWTH_PER_SECOND = 1 / 40
	@MAX_SIZE = 3

	constructor:(@world, @position)->
		@size = Tree.GROWTH_PER_SECOND
		@structure = 1

	grow:(time)->
		@size += Tree.GROWTH_PER_SECOND * time
		if @size > Tree.MAX_SIZE
			@size = Tree.MAX_SIZE

	getSize:()->
		1 + Math.floor (Tree.MAX_SIZE - 1) * @size / Tree.MAX_SIZE

	hit:(force)->
		@structure -= force
		if @structure <= 0
			@world.createItem 'sapling', @position
			for i in [1..Math.floor(2 + Math.random() * 3)]
				@world.createItem 'wood', @position
			@world.destroyTree @

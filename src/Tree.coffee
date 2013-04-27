class Tree
	@GROWTH_PER_SECOND = 1 / 40
	@MAX_SIZE = 3

	constructor:(@position)->
		@size = Tree.GROWTH_PER_SECOND

	grow:(time)->
		@size += Tree.GROWTH_PER_SECOND * time
		if @size > Tree.MAX_SIZE
			@size = Tree.MAX_SIZE

	getSize:()->
		1 + Math.floor (Tree.MAX_SIZE - 1) * @size / Tree.MAX_SIZE

class Furnace
	constructor:(@world, @position)->
		@burnTime = 0

	isBurning:()->
		@burnTime > 0

	isEmpty:()->
		@burnTime <= 0

	melt:(recipe)->
		@burnTime = recipe.burnTime
		@resultItemType = recipe.resultItemType

	pass:(time)->
		if @isBurning()
			@burnTime -= time
			if @burnTime < 0
				@burnTime = 0
				@world.createItem @resultItemType, @position

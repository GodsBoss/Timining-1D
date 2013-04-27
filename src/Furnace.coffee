class Furnace
	constructor:(@world, @position)->

	isBurning:()->
		@recipe?

	isFree:()->
		!@recipe?

	melt:(@recipe)->
		@fullBurnTime = @recipe.getBurnTime()
		@burnTime = @fullBurnTime

	pass:(time)->
		if @isBurning()
			@burnTime -= time
			if @burnTime < 0
				@world.createItem @recipe.resultType, @position
				@recipe = null

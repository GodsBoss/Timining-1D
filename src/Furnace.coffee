class Furnace
	constructor:(@world, @position)->
		@burnTime = 0

	isBurning:()->
		@burnTime > 0

	isFree:()->
		@burnTime <= 0

	melt:(@resultItemType, @burnTime)->

	pass:(time)->
		if @isBurning()
			@burnTime -= time
			if @burnTime < 0
				@burnTime = 0
				@world.createItem @resultItemType, @position

class Bush
	@MAX_APPLES = 3
	@APPLES_PER_SECOND = 1 / 60 # 1 Apple per minute

	constructor:()->
		@apples = Bush.MAX_APPLES

	hasApple:()->
		@apples >= 1

	numberOfApples:()->
		Math.floor @apples

	loseApple:()->
		if @hasApple()
			@apples--
			true
		else
			false

	grow:(time)->
		@apples = Math.min Bush.MAX_APPLES, @apples + time * Bush.APPLES_PER_SECOND

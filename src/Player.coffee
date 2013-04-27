class Player
	@LEFT = -1
	@RIGHT = 1
	@ARM_LENGTH = 0.333
	@MAX_HEALTH = 40
	@MAX_SATURATION = 20
	@SATURATION_CONVERSION_FACTOR = MAX_HEALTH / MAX_SATURATION
	@SATURATION_CONVERSION_PER_SECOND = 1

	constructor:()->
		@position = 0
		@direction = RIGHT
		@health = 40
		@saturation = 20

	canEat:()->
		@saturation < Player.MAX_SATURATION

	eat:(food)->
		@saturation += food.saturation

	# time is in seconds
	tick:(time)->
		if @health < Player.MAX_HEALTH and @saturation > 0
			@heal(time)

	heal:(time)->
		potSatUsage = Player.SATURATION_CONVERSION_FACTOR * Math.min time, @saturation
		conversion = Math.min potSatUsage, Player.MAX_HEALTH - @health
		@health += conversion
		@saturation -= conversion / Player.SATURATION_CONVERSION_FACTOR

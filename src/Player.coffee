class Player
	@LEFT = 'left'
	@RIGHT = 'right'
	@ARM_LENGTH = 0.333
	@MAX_HEALTH = 40
	@MAX_SATURATION = 20
	@SATURATION_CONVERSION_FACTOR = @MAX_HEALTH / @MAX_SATURATION
	@SATURATION_CONVERSION_PER_SECOND = 1
	@MAX_SPEED = 2
	@HIT_RECOVER_TIME = 0.5
	@DIGGING_PROGRESS_DECAY = 0.2

	constructor:(@type)->
		@position = 0
		@direction = Player.RIGHT
		@health = Player.MAX_HEALTH
		@saturation = Player.MAX_SATURATION
		@speed = 0
		@walking = false
		@recover = 0
		@bag = {}
		@diggingProgress = 0

	canEat:()->
		@saturation < Player.MAX_SATURATION

	has:(itemType, number = 1)->
		@bag[itemType]? and @bag[itemType] >= number

	eatApple:()->
		if @canEat() and @bag['apple']? and @bag['apple'] > 0
			@saturation += 5
			@bag['apple']--

	# time is in seconds
	tick:(time, level)->
		if @health < Player.MAX_HEALTH and @saturation > 0
			@heal(time)
		@walk time, level
		@recover = Math.max 0, @recover - time
		@diggingProgress -= Player.DIGGING_PROGRESS_DECAY * time
		if @diggingProgress < 0
			@diggingProgress = 0

	walk:(time, level)->
		if @walking
			f = if @direction is Player.LEFT then -1 else 1
			@speed += f * time
			if Player.MAX_SPEED < Math.abs @speed
				@speed = f * Player.MAX_SPEED
		else
			@speed *= Math.pow 0.1, time
		newPosition = @position + @speed * time
		pieceType = level.getPiece(Math.round newPosition).type
		if pieceType == 'dirt' or pieceType == 'rock'
			@speed = 0
		@position += @speed * time

	heal:(time)->
		potSatUsage = Player.SATURATION_CONVERSION_FACTOR * Math.min time, @saturation
		conversion = Math.min potSatUsage, Player.MAX_HEALTH - @health
		@health += conversion
		@saturation -= conversion / Player.SATURATION_CONVERSION_FACTOR

	isWalking:()->
		@walking or 0.1 < Math.abs @speed

	beWalkingLeft:()->
		@walking = true
		@direction = Player.LEFT

	beWalkingRight:()->
		@walking = true
		@direction = Player.RIGHT

	dontBeWalking:()->
		@walking = false

	hit:()->
		if @recover > 0
			false
		else
			@recover = Player.HIT_RECOVER_TIME
			true

	isHitting:()->
		@recover > Player.HIT_RECOVER_TIME - 0.1

	getHitPoint:()->
		@position + Player.ARM_LENGTH * (if @direction == Player.LEFT then -1 else 1)

	gatherItem:(item)->
		if !@bag[item.type]?
			@bag[item.type] = 0
		@bag[item.type]++

	dig:(piece, piecePosition, world)->
		@diggingProgress += 0.333
		if @diggingProgress >= 1
			@diggingProgress = 0
			world.level.setPiece piecePosition, 'dirt-flat'

	mine:(piece, piecePosition, world)->
		if piece.special?
			progressValues =
				coal: 0.18
				iron: 0.14
				gold: 0.09
				diamond: 0.05
			progress = progressValues[piece.special.type]
		else
			progress = 0.2
		@diggingProgress += progress
		if @diggingProgress >= 1
			@diggingProgress = 0
			if piece.special?
				if piece.special.type == 'coal'
					world.createItems 'coal', piecePosition, Math.floor 2 + Math.random()*3
				if piece.special.type == 'iron'
					world.createItems 'iron-ore', piecePosition, Math.floor 2 + Math.random()*2
				if piece.special.type == 'gold'
					world.createItems 'gold-ore', piecePosition, Math.floor 1 + Math.random()*1.5
				if piece.special.type == 'diamond'
					world.createItem 'diamond', piecePosition
				world.createItems 'rock', piecePosition, Math.floor 1 + Math.random()*2
			else
				world.createItems 'rock', piecePosition, Math.floor 3 + Math.random()*3
			world.level.setPiece piecePosition, 'rock-flat'

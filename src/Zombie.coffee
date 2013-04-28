class Zombie
	@HEALING_PER_SECOND = 0.05
	@ARM_LENGTH = 0.25
	@WIDTH = 0.5
	@KNOCKBACK_SPEED = 4
	@HIT_RECOVERY_TIME = 0.75
	@DAMAGE = 4

	@movement =
		left: -1
		right: 1

	constructor:(@world, @position, @maxHealth)->
		@health = @maxHealth
		@lifeTime = 0
		@walking = yes
		@knockback = 0
		@recovering = 0

	pass:(time)->
		if !@dead
			@health += time * Zombie.HEALING_PER_SECOND
			@recovering = Math.max 0, @recovering - time
		@lifeTime += time
		if @knockback == 0
			if Math.abs(@position - @world.player.position) >= Zombie.ARM_LENGTH
				@position += Zombie.movement[@getDirection()] * time
				@walking = yes
			else
				@walking = no
				if @recovering is 0
					@world.player.isHit Zombie.DAMAGE
					@recovering = Zombie.HIT_RECOVERY_TIME
		else
			newPosition = @position - Zombie.movement[@getDirection()] * time * Zombie.KNOCKBACK_SPEED * @knockback
			@knockback = Math.max 0, @knockback - time
			piece = @world.level.getPiece Math.round newPosition
			if piece.type is 'rock' or piece.type is 'dirt'
				@knockback = 0
				newPosition = Zombie.movement[@getDirection()] * 0.51 + Math.round newPosition
			@position = newPosition

	getDirection:()->
		if @position > @world.player.position then 'left' else 'right'

	isWalking:()->
		@walking and @knockback is 0

	isHit:(power)->
		@knockback = 1
		@health -= power
		if @health <= 0
			@beginDying()

	beginDying:()->
		@dead = true

	isDead:()->
		@dead and @knockback == 0

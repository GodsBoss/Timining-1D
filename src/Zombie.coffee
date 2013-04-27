class Zombie
	@HEALING_PER_SECOND = 0.25

	constructor:(@position, @maxHealth)->
		@health = @maxHealth
		@lifeTime = 0

	pass:(time)->
		@health += time * Zombie.HEALING_PER_SECOND
		@lifeTime += time

class PlayerEatsAppleAction
	constructor:(@player)->

	name: 'eat-apple'

	action:()=>
		@player.eatApple()

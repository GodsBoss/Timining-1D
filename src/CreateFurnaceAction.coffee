class CreateFurnaceAction
	name: 'furnace'

	constructor:(@world)->

	action:()=>
		@world.player.consume 'furnace'
		@world.level.addFurnace Math.round @world.player.position

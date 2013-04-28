class CreateWorkbenchAction
	name: 'workbench'

	constructor:(@world)->

	action:()=>
		@world.player.consume 'wood', 4
		@world.level.getPiece(Math.round @world.player.position).special =
			type: 'workbench'

class PlantSaplingAction
	constructor:(@world)->

	name: 'plant-sapling'

	action:()=>
		@world.player.consume 'sapling'
		@world.level.addTree Math.round @world.player.position

class CloseIngameMenuAction
	constructor:(@game)->

	name:'close'

	action:()=>
		@game.closeIngameMenu()

class IngameMenu
	constructor:(@game, @choices)->
		@selected = 0

	selectNext:()->
		@selected = (@selected+1) % @choices.length

	selectPrevious:()->
		@selected = (@selected+@choices.length-1) % @choices.length

	getChoice:(index)->
		index = index % @choices.length
		if index < 0
			index += @choices.length
		@choices[index]

	getCurrentChoice:()->
		@choices[@selected]

	invoke:()->
		@game.closeIngameMenu()
		@choices[@selected].action()

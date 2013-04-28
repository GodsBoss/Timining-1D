class IngameMenuRenderer
	@actionSprites =
		close: 'exit'

	constructor:(@context, @spriteSheet)->

	draw:(ingameMenu)->
		y = 120
		for indexOffset in [-2..2]
			x = 136 + indexOffset*60
			choice = ingameMenu.getChoice ingameMenu.selected + indexOffset
			if IngameMenuRenderer.actionSprites[choice.name]?
				@context.drawImage @spriteSheet.getNamedSprite(IngameMenuRenderer.actionSprites[choice.name]), x, y
		@context.strokeStyle = '#bbbbbb'
		@context.strokeRect 135, 119, 50, 50

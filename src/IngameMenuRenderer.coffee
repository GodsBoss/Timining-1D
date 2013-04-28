class IngameMenuRenderer
	@actionSprites =
		close: 'exit'
		'eat-apple': 'item-apple'
		'plant-sapling': 'item-sapling'

	constructor:(@context, @spriteSheet)->

	draw:(ingameMenu)->
		spriteCenterY = 145
		for indexOffset in [-2..2]
			spriteCenterX = 160 + indexOffset*60
			choice = ingameMenu.getChoice ingameMenu.selected + indexOffset
			if IngameMenuRenderer.actionSprites[choice.name]?
				sprite = @spriteSheet.getNamedSprite(IngameMenuRenderer.actionSprites[choice.name])
				x = spriteCenterX - sprite.width/2
				y = spriteCenterY - sprite.height/2
				@context.drawImage sprite, x, y
		@context.strokeStyle = '#bbbbbb'
		@context.strokeRect 135, 119, 50, 50

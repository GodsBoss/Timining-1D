class IngameMenuRenderer
	@actionSprites =
		close: 'exit'
		'eat-apple': 'item-apple'
		'plant-sapling': 'item-sapling'
		'workbench': 'workbench'

	constructor:(@context, @spriteSheet)->

	draw:(ingameMenu)->
		spriteCenterY = 145
		@context.lineWidth = 2
		for indexOffset in [-2..2]
			spriteCenterX = 160 + indexOffset*60
			choice = ingameMenu.getChoice ingameMenu.selected + indexOffset
			sprite = null
			if IngameMenuRenderer.actionSprites[choice.name]?
				sprite = @spriteSheet.getNamedSprite IngameMenuRenderer.actionSprites[choice.name]
			if !sprite? and @spriteSheet.hasNamedSprite 'recipe-' + choice.name
				sprite = @spriteSheet.getNamedSprite 'recipe-' + choice.name
			if !sprite? and @spriteSheet.hasNamedSprite 'item-' + choice.name
				sprite = @spriteSheet.getNamedSprite 'item-' + choice.name
			if sprite?
				x = spriteCenterX - sprite.width/2
				y = spriteCenterY - sprite.height/2
				@context.drawImage sprite, x, y
			@context.strokeStyle = '#111111'
			@context.strokeRect 135 + indexOffset*60, 119, 50, 50
		@context.strokeStyle = '#bbbbbb'
		@context.strokeRect 135, 119, 50, 50

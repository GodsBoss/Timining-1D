class ScalingSpriteSheet
	constructor:(@spriteSheet, @imageScaling, @factor)->

	scale:(image)=>
		@imageScaling.scale image, @factor

	getSprite:(x, y, w, h)->
		@scale @spriteSheet.getSprite x, y, w, h

	getNamedSprite:(name, fresh = no)->
		@scale @spriteSheet.getNamedSprite name, fresh

	getAnimationSprites:(name, number, fresh = no)->
		(@scale image for image in @spriteSheet.getAnimationSprites name, number, fresh)

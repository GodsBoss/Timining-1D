class SpriteSheet
	constructor:(@document, @image, @spriteMap)->
		@spriteCache = {}

	getSprite:(x, y, w, h)->
		if not @context?
			@initContext()
		canvas = @document.createElement 'canvas'
		canvas.width = w
		canvas.height = h
		context = canvas.getContext '2d'
		context.clearRect 0, 0, w, h
		sourceImageData = @context.getImageData x, y, w, h
		context.putImageData sourceImageData, 0, 0
		canvas

	getNamedSprite:(name, fresh = no)->
		if not fresh and @spriteCache[name]?
			@spriteCache[name]
		else
			s = @spriteMap.getSpriteInfo name
			@getSprite s.x, s.y, s.w, s.h

	getAnimationSprites:(name, number, fresh = no)->
		(@getNamedSprite(name+'_'+n, fresh) for n in [0..number-1])

	initContext:()->
		canvas = @document.createElement 'canvas'
		canvas.width = @image.width
		canvas.height = @image.height
		@context = canvas.getContext '2d'
		@context.clearRect 0, 0, @image.width, @image.height
		@context.drawImage @image, 0, 0

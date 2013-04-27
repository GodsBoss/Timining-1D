class SpriteSheet
	constructor:(@document, @image)->

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

	initContext:()->
		canvas = @document.createElement 'canvas'
		canvas.width = @image.width
		canvas.height = @image.height
		@context = canvas.getContext '2d'
		@context.clearRect 0, 0, @image.width, @image.height
		@context.drawImage @image, 0, 0

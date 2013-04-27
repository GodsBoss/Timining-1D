class WorldRenderer
	constructor:(@context, @spriteSheet)->

	draw:(world)->
		@context.fillStyle = 'black'
		@context.fillRect 0, 0, @context.canvas.width, @context.canvas.height

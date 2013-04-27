class TiminingInit
	constructor:(@window)->

	init:()->
		@window.addEventListener 'load', @loadSpriteSheet, false

	loadSpriteSheet:()=>
		@image = @window.document.createElement 'img'
		@image.src = 'gfx.png'
		@image.addEventListener 'load', @initGame, false

	initGame:()=>
		spriteSheet = new SpriteSheet @window.document, @image, new SpriteMap
		canvas = @window.document.getElementById 'screen'
		context = canvas.getContext '2d'
		sprites = {}
		scaling = new ImageScaling @window.document
		scalingSpriteSheet = new ScalingSpriteSheet spriteSheet, scaling, 3
		menuRenderer = new MenuRenderer context, scalingSpriteSheet, 1
		worldRenderer = new WorldRenderer context, scalingSpriteSheet
		game = new Game menuRenderer, worldRenderer, 40
		canvas.addEventListener 'mousemove', game.mouseMove, false
		canvas.addEventListener 'mouseleave', game.mouseLeave, false
		canvas.addEventListener 'click', game.mouseClick, false
		document.addEventListener 'keydown', game.keyDown, false
		document.addEventListener 'keyup', game.keyUp, false
		game.start()

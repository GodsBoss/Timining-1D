class Game
	@STATE_START_MENU = 1
	@STATE_CHOOSE_CHARACTER = 2
	@STATE_GAME_RUNNING = 3
	@STATE_GAME_PAUSE = 4
	@STATE_DEAD = 5

	constructor:(@menuRenderer, @fps)->
		@state = Game.STATE_DEAD

	start:()->
		@loop()

	loop:()=>
		setTimeout @loop, 1000/@fps
		@menuRenderer.pass 1/@fps
		@draw()

	mouseLeave:(event)=>
		event.target.className = ''

	mouseMove:(event)=>
		pos = @mouseEventCoordinates event
		if @state is Game.STATE_START_MENU
			event.target.className = if @menuRenderer.isInsideStartButton pos.x, pos.y then 'clickable' else ''
		if @state is Game.STATE_GAME_PAUSE
			event.target.className = if @menuRenderer.isInsidePauseButton pos.x, pos.y then 'clickable' else ''
		if @state is Game.STATE_DEAD
			event.target.className = if @menuRenderer.isInsideAgainButton pos.x, pos.y then 'clickable' else ''
		if @state is Game.STATE_GAME_RUNNING
			event.target.className = ''
		if @state is Game.STATE_CHOOSE_CHARACTER
			event.target.className = if @menuRenderer.isInsideCharacterOneButton(pos.x, pos.y) or @menuRenderer.isInsideCharacterTwoButton(pos.x, pos.y) then 'clickable' else ''

	mouseClick:(event)=>
		pos = @mouseEventCoordinates event
		if @state is Game.STATE_START_MENU and @menuRenderer.isInsideStartButton pos.x, pos.y
			@state = Game.STATE_CHOOSE_CHARACTER
			@mouseMove event
			return
		if @state is Game.STATE_DEAD and @menuRenderer.isInsideAgainButton pos.x, pos.y
			@state = Game.STATE_START_MENU
			@mouseMove event
			return

	mouseEventCoordinates:(event)->
		x: event.clientX - event.target.offsetLeft
		y: event.clientY - event.target.offsetTop

	keyDown:(event)=>
		console.log event

	keyUp:(event)=>
		console.log event

	draw:()->
		if @state is Game.STATE_START_MENU
			@menuRenderer.drawStartMenu()
		if @state is Game.STATE_CHOOSE_CHARACTER
			@menuRenderer.drawChooseCharacter()
		if @state is Game.STATE_GAME_RUNNING
			@drawRunningGame()
		if @state is Game.STATE_GAME_PAUSE
			@menuRenderer.drawPausedGame()
		if @state is Game.STATE_DEAD
			@menuRenderer.drawDead()

	drawRunningGame:()->

class Game
	@STATE_START_MENU = 1
	@STATE_CHOOSE_CHARACTER = 2
	@STATE_GAME_RUNNING = 3
	@STATE_GAME_PAUSE = 4
	@STATE_DEAD = 5

	constructor:(@menuRenderer, @worldRenderer, @ingameMenuRenderer, @fps)->
		@state = Game.STATE_START_MENU
		@time = 0
		@avoidHitting = 0
		@keysDown = {}

	start:()->
		@loop()

	loop:()=>
		setTimeout @loop, 1000/@fps
		if @state is Game.STATE_GAME_RUNNING
			@world.player.dontBeWalking()
			if !@ingameMenu?
				if @keysDown.a and !@keysDown.d
					@world.player.beWalkingLeft()
				if !@keysDown.a and @keysDown.d
					@world.player.beWalkingRight()
				if @keysDown.s and @avoidHitting == 0
					hit = @world.player.hit()
					if hit
						@world.playerHit()
			if @keysDown.p
				@state = Game.STATE_GAME_PAUSE
			else
				if !@ingameMenu?
					@world.tick 1/@fps
		@menuRenderer.pass 1/@fps
		if @avoidHitting > 0
			@avoidHitting = Math.max 0, @avoidHitting - 1/@fps
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
		if @state is Game.STATE_GAME_PAUSE and @menuRenderer.isInsidePauseButton pos.x, pos.y
			@state = Game.STATE_GAME_RUNNING
			@mouseMove event
			return
		if @state is Game.STATE_CHOOSE_CHARACTER and (@menuRenderer.isInsideCharacterOneButton(pos.x, pos.y) or @menuRenderer.isInsideCharacterTwoButton pos.x, pos.y)
			@initWorld if @menuRenderer.isInsideCharacterOneButton(pos.x, pos.y) then 'a' else 'b'
			@state = Game.STATE_GAME_RUNNING
			@mouseMove event
			return

	mouseEventCoordinates:(event)->
		x: event.clientX - event.target.offsetLeft
		y: event.clientY - event.target.offsetTop

	keyDown:(event)=>
		if event.keyCode == 65 # 'a'
			@keysDown.a = true
		if event.keyCode == 68 # 'd'
			@keysDown.d = true
		if event.keyCode == 83 # 's'
			@keysDown.s = true

	keyUp:(event)=>
		if event.keyCode == 65
			@keysDown.a = false
		if event.keyCode == 68
			@keysDown.d = false
		if event.keyCode == 83
			@keysDown.s = false

	keyPress:(event)=>
		if event.keyCode == 112 # 'p'
			if @state is Game.STATE_GAME_RUNNING or @state is Game.STATE_GAME_PAUSE
				@state = if @state is Game.STATE_GAME_RUNNING then Game.STATE_GAME_PAUSE else Game.STATE_GAME_RUNNING
		if event.keyCode == 119 # 'w'
			if @state is Game.STATE_GAME_RUNNING
				if @ingameMenu?
					@closeIngameMenu()
				else
					@openIngameMenu()
		if @ingameMenu?
			if event.keyCode == 97 # 'a'
				@ingameMenu.selectPrevious()
			if event.keyCode == 100 # 'd'
				@ingameMenu.selectNext()
			if event.keyCode == 115 # 's'
				@ingameMenu.getCurrentChoice().action()
				@closeIngameMenu()
				@avoidHitting = 0.1

	draw:()->
		if @state is Game.STATE_START_MENU
			@menuRenderer.drawStartMenu()
		if @state is Game.STATE_CHOOSE_CHARACTER
			@menuRenderer.drawChooseCharacter()
		if @state is Game.STATE_GAME_RUNNING
			@worldRenderer.draw @world
			if @ingameMenu?
				@ingameMenuRenderer.draw @ingameMenu
		if @state is Game.STATE_GAME_PAUSE
			@menuRenderer.drawPausedGame()
		if @state is Game.STATE_DEAD
			@menuRenderer.drawDead()

	initWorld:(playerType)->
		player = new Player playerType
		@world = new World player
		level = new Level @world
		@world.level = level # !!!

	closeIngameMenu:()->
		delete @ingameMenu

	openIngameMenu:()->
		choices = @world.getPossiblePlayerActions()
		choices.push new CloseIngameMenuAction @
		@ingameMenu = new IngameMenu choices

	isInsideInGameMenu:()->
		Game.STATE_GAME_RUNNING and @ingameMenu?

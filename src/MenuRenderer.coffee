class MenuRenderer
	@LEFT_CHARACTER_BUTTON = true
	@RIGHT_CHARACTER_BUTTON = false

	constructor:(@context, @spriteSheet, @globalScalingFactor = 1)->
		@charOneAnimation = new Animation @spriteSheet.getAnimationSprites('player-a-right', 2), 0.25
		@charTwoAnimation = new Animation @spriteSheet.getAnimationSprites('player-b-left', 2), 0.25
		@time = 0

	getButtonSize:()->
		64 * @globalScalingFactor

	drawStartMenu:()->
		@drawSingleButtonScreen 'menu-start'

	drawPausedGame:()->
		@drawSingleButtonScreen 'menu-pause'

	drawDead:()->
		@drawSingleButtonScreen 'menu-again'

	drawSingleButtonScreen:(spriteName)->
		@clear()
		center = @getCenter()
		buttonSize = @getButtonSize()
		@context.drawImage @spriteSheet.getNamedSprite(spriteName), center.x - buttonSize/2, center.y - buttonSize/2

	drawChooseCharacter:()->
		@clear()
		center = @getCenter()
		oneSixth = Math.floor @context.canvas.width/6
		buttonSize = @getButtonSize()
		@context.drawImage @spriteSheet.getNamedSprite('menu-empty'), center.x - buttonSize/2 - oneSixth, center.y - buttonSize/2
		@context.drawImage @spriteSheet.getNamedSprite('menu-empty'), center.x - buttonSize/2 + oneSixth, center.y - buttonSize/2
		charOne = @charOneAnimation.getImage @time
		charTwo = @charTwoAnimation.getImage @time + 0.125
		@context.drawImage charOne, center.x - oneSixth - charOne.width/2, center.y - charOne.height/2
		@context.drawImage charTwo, center.x + oneSixth - charTwo.width/2, center.y - charTwo.height/2

	getCenter:()->
		x: @context.canvas.width / 2
		y: @context.canvas.height / 2

	clear:()->
		@context.clearRect 0, 0, @context.canvas.width, @context.canvas.height

	isInsideStartButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsidePauseButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsideAgainButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsideCenteredButton:(x, y)->
		center = @getCenter()
		buttonSize = @getButtonSize()
		Math.abs(center.x - x) <= buttonSize/2 and Math.abs(center.y - y) <= buttonSize/2

	isInsideCharacterOneButton:(x, y)->
		@isInsideCharacterButton x, y, MenuRenderer.LEFT_CHARACTER_BUTTON

	isInsideCharacterTwoButton:(x, y)->
		@isInsideCharacterButton x, y, MenuRenderer.RIGHT_CHARACTER_BUTTON

	isInsideCharacterButton:(x, y, isLeft)->
		buttonCenter =
			x: @context.canvas.width * if isLeft then 1/3 else 2/3
			y: @context.canvas.height / 2
		buttonSize = @getButtonSize()
		Math.abs(buttonCenter.x - x) <= buttonSize/2 and Math.abs(buttonCenter.y - y) <= buttonSize/2

	pass:(time)->
		@time += time

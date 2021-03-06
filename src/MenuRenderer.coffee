class MenuRenderer
	@LEFT_CHARACTER_BUTTON = true
	@RIGHT_CHARACTER_BUTTON = false
	@DO_NOT_CLEAR = false

	constructor:(@context, @spriteSheet, @globalScalingFactor = 1)->
		@charOneAnimation = new Animation @spriteSheet.getAnimationSprites('player-a-right', 2), 0.25
		@charTwoAnimation = new Animation @spriteSheet.getAnimationSprites('player-b-left', 2), 0.25
		@time = 0

	getButtonSize:()->
		@spriteSheet.getNamedSprite('menu-empty').width * @globalScalingFactor

	drawStartMenu:()->
		@drawSingleButtonScreen 'menu-start'
		@drawTitle()

	drawPausedGame:()->
		@drawSingleButtonScreen 'menu-pause', MenuRenderer.DO_NOT_CLEAR

	drawDead:()->
		@drawSingleButtonScreen 'menu-again', MenuRenderer.DO_NOT_CLEAR

	drawVictory:()->
		@drawSingleButtonScreen 'menu-victory', MenuRenderer.DO_NOT_CLEAR

	drawSingleButtonScreen:(spriteName, clear = true)->
		if clear
			@clear()
		center = @getCenter()
		sprite = @spriteSheet.getNamedSprite(spriteName)
		@context.drawImage sprite, center.x - sprite.width/2, center.y - sprite.height/2

	drawChooseCharacter:()->
		@clear()
		@drawTitle()
		center = @getCenter()
		sprite = @spriteSheet.getNamedSprite('menu-empty')
		margin = Math.floor (@context.canvas.width - 2 * sprite.width) / 3
		@context.drawImage sprite, margin, center.y - sprite.height/2
		@context.drawImage sprite, @context.canvas.width - sprite.width - margin, center.y - sprite.height/2
		charOne = @charOneAnimation.getImage @time
		charTwo = @charTwoAnimation.getImage @time + 0.125
		@context.drawImage charOne, margin + sprite.width/2 - charOne.width/2, center.y - charOne.height/2
		@context.drawImage charTwo, @context.canvas.width - sprite.width/2 - margin - charTwo.width/2, center.y - charTwo.height/2

	drawTitle:()->
		title = @spriteSheet.getNamedSprite 'title'
		x = @context.canvas.width/2 - title.width/2
		y = 10
		@context.drawImage title, x, y

	getCenter:()->
		x: @context.canvas.width / 2
		y: @context.canvas.height / 2

	clear:()->
		@context.drawImage @spriteSheet.getNamedSprite('background'), 0, 0

	isInsideStartButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsidePauseButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsideAgainButton:(x, y)->
		@isInsideCenteredButton x, y

	isInsideVictoryButton:(x, y)->
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
		sprite = @spriteSheet.getNamedSprite('menu-empty')
		margin = Math.floor (@context.canvas.width - 2 * sprite.width) / 3
		buttonCenter =
			x:
				if isLeft
					margin + sprite.width/2
				else
					@context.canvas.width - margin - sprite.width/2
			y: @context.canvas.height / 2
		buttonSize = @getButtonSize()
		Math.abs(buttonCenter.x - x) <= buttonSize/2 and Math.abs(buttonCenter.y - y) <= buttonSize/2

	pass:(time)->
		@time += time

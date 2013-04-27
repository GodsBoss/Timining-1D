class WorldRenderer
	constructor:(@context, @spriteSheet)->

	draw:(@world)->
		@clear()
		@drawLandscape()
		@drawPlayer()
		@drawItems()
		@drawHealth()
		@drawSaturation()

	clear:()->
		@context.fillStyle = '#333333'
		@context.fillRect 0, 0, @context.canvas.width, @context.canvas.height

	drawLandscape:()->
		@context.strokeStyle = '#888888'
		@context.beginPath()
		@context.moveTo 0, 60
		@context.lineTo @context.canvas.width, 60
		@context.moveTo 0, 60 + 3*16
		@context.lineTo @context.canvas.width, 60 + 3*16
		@context.stroke()
		@context.closePath()

		centerPiecePosition = Math.round @world.player.position
		offset = Math.floor (centerPiecePosition - @world.player.position) * (3*16)
	
		for pieceIndex in [centerPiecePosition-4 .. centerPiecePosition+4]
			piece = @world.level.getPiece pieceIndex
			x = @context.canvas.width / 2 - (3*16/2) + (pieceIndex - centerPiecePosition)*(3*16) + offset
			y = 60+1
			@context.drawImage @spriteSheet.getNamedSprite(piece.type), x, y
			if piece.special?
				if piece.special.type == 'grass'
					@context.drawImage @spriteSheet.getNamedSprite('grass'), x, y
				if piece.special.type == 'bush'
					@context.drawImage @spriteSheet.getNamedSprite('bush'+piece.special.bush.numberOfApples()), x, y
				if piece.special.type == 'tree'
					@context.drawImage @spriteSheet.getNamedSprite('tree'+piece.special.tree.getSize()), x, y

	drawPlayer:()->
		if !@playerAnimations?
			@initPlayerAnimations()
		image = @playerAnimations[@world.player.direction].getImage(if @world.player.isWalking() then @world.time else 0)
		@context.drawImage image, @context.canvas.width / 2 - image.width / 2, 61
		if @world.player.isHitting()
			@context.drawImage @spriteSheet.getNamedSprite('hit-effect-' + @world.player.direction), @context.canvas.width / 2 - image.width / 2, 61

	initPlayerAnimations:()->
		@playerAnimations =
			left:  new Animation @spriteSheet.getAnimationSprites('player-' + @world.player.type + '-left',  2), 0.25
			right: new Animation @spriteSheet.getAnimationSprites('player-' + @world.player.type + '-right', 2), 0.25

	drawItems:()->
		for item in @world.items
			diff = item.position - @world.player.position
			if Math.abs(diff) < 5
				x = @context.canvas.width/2 + diff * 16 * 3 - 8 * 3 / 2
				@context.drawImage @spriteSheet.getNamedSprite('item-'+item.type), x, 60 + 3*16 - 4*3 - 8*3/2

	drawHealth:()->
		fullHearts = Math.floor 10 * @world.player.health / Player.MAX_HEALTH
		fullHeartSprite = @spriteSheet.getNamedSprite 'heart4'
		for i in [0..fullHearts-1]
			@context.drawImage fullHeartSprite, i * 3 * (8+1), 3*1
		if fullHearts is 10
			return
		partial = Math.ceil 4 * (10 * @world.player.health / Player.MAX_HEALTH - fullHearts)
		@context.drawImage @spriteSheet.getNamedSprite('heart' + partial), fullHearts * 3 * (8+1), 3*1
		if fullHearts is 9
			return
		emptyHeartSprite = @spriteSheet.getNamedSprite 'heart0'
		for i in [fullHearts+1..9]
			@context.drawImage emptyHeartSprite, i * 3 * (8+1), 3*1

	drawSaturation:()->
		fullSats = Math.floor 10 * @world.player.saturation / Player.MAX_SATURATION
		fullSatSprite = @spriteSheet.getNamedSprite 'saturation2'
		for i in [0..fullSats-1]
			@context.drawImage fullSatSprite, i * 3 * (8+1), 3*(1+8+1)
		if fullSats is 10
			return
		partial = Math.ceil 2 * (10 * @world.player.saturation / Player.MAX_SATURATION - fullSats)
		@context.drawImage @spriteSheet.getNamedSprite('saturation' + partial), fullSats * 3 * (8+1), 3*(1+8+1)
		if fullSats is 9
			return
		emptySatSprite = @spriteSheet.getNamedSprite 'saturation0'
		for i in [fullSats+1..9]
			@context.drawImage emptySatSprite, i * 3 * (8+1), 3*(1+8+1)

class WorldRenderer
	constructor:(@context, @spriteSheet)->

	draw:(@world)->
		@clear()
		@drawLandscape()
		@drawZombies()
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
		@context.moveTo 0, 62 + 3*16
		@context.lineTo @context.canvas.width, 62 + 3*16
		@context.stroke()
		@context.closePath()

		centerPiecePosition = Math.round @world.player.position
		offset = Math.floor (centerPiecePosition - @world.player.position) * (3*16)
	
		visibility = 2
		for pieceIndex in [centerPiecePosition .. centerPiecePosition+4]
			piece = @world.level.getPiece pieceIndex
			if visibility == 0
				@context.drawImage @spriteSheet.getNamedSprite('fog-full'), @getPieceX(pieceIndex, centerPiecePosition, offset), 60+1
			if visibility == 2
				@drawPiece pieceIndex, piece, centerPiecePosition, offset
			if ((piece.type is 'dirt') or (piece.type is 'rock')) and visibility == 2
				visibility = 1
			if visibility == 1
				@drawPiece pieceIndex, piece, centerPiecePosition, offset
				@context.drawImage @spriteSheet.getNamedSprite('fog-right'), @getPieceX(pieceIndex, centerPiecePosition, offset), 60+1
				visibility--

		visibility = 2
		for pieceIndex in [centerPiecePosition .. centerPiecePosition-4]
			piece = @world.level.getPiece pieceIndex
			if visibility == 0
				@context.drawImage @spriteSheet.getNamedSprite('fog-full'), @getPieceX(pieceIndex, centerPiecePosition, offset), 60+1
			if visibility == 2
				@drawPiece pieceIndex, piece, centerPiecePosition, offset
			if ((piece.type is 'dirt') or (piece.type is 'rock')) and visibility == 2
				visibility = 1
			if visibility == 1
				@drawPiece pieceIndex, piece, centerPiecePosition, offset
				@context.drawImage @spriteSheet.getNamedSprite('fog-left'), @getPieceX(pieceIndex, centerPiecePosition, offset), 60+1
				visibility--

	drawPiece:(index, piece, centerPiecePosition, offset)->
		x = @getPieceX index, centerPiecePosition, offset
		y = 60+1
		@context.drawImage @spriteSheet.getNamedSprite(piece.type), x, y
		if piece.special?
			if piece.special.type == 'grass'
				@context.drawImage @spriteSheet.getNamedSprite('grass'), x, y
			if piece.special.type == 'workbench'
				@context.drawImage @spriteSheet.getNamedSprite('workbench'), x, y
			if piece.special.type == 'furnace'
				furnace = piece.special.furnace
				if furnace.isBurning()
					if !@furnaceAnimation?
						@furnaceAnimation = new Animation @spriteSheet.getAnimationSprites('furnace', 4), 0.25
					@context.drawImage @furnaceAnimation.getImage(furnace.burnTime), x, y
				else
					@context.drawImage @spriteSheet.getNamedSprite('furnace'), x, y
			if piece.special.type == 'bush'
				@context.drawImage @spriteSheet.getNamedSprite('bush'+piece.special.bush.numberOfApples()), x, y
			if piece.special.type == 'tree'
				@context.drawImage @spriteSheet.getNamedSprite('tree'+piece.special.tree.getSize()), x, y
			if piece.type == 'rock'
				@context.drawImage @spriteSheet.getNamedSprite('rock-'+piece.special.type), x, y

	getPieceX:(index, centerPiecePosition, offset)->
		@context.canvas.width / 2 - (3*16/2) + (index - centerPiecePosition)*(3*16) + offset

	drawPlayer:()->
		if !@playerAnimations?
			@initPlayerAnimations()
		image = @playerAnimations[@world.player.direction].getImage(if @world.player.isWalking() then @world.time else 0)
		@context.drawImage image, @context.canvas.width / 2 - image.width / 2, 61
		if @world.player.isHitting()
			@context.drawImage @spriteSheet.getNamedSprite('hit-effect-' + @world.player.direction), @context.canvas.width / 2 - image.width / 2, 61
		else
			if @world.player.currentTool?
				tool = @world.player.currentTool
				spriteName = [tool.type, tool.material, @world.player.direction].join '-'
				@context.drawImage @spriteSheet.getNamedSprite(spriteName), @context.canvas.width / 2 - image.width / 2, 61

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
		fullHearts = Math.min 10, Math.floor 10 * @world.player.health / Player.MAX_HEALTH
		fullHeartSprite = @spriteSheet.getNamedSprite 'heart4'
		if fullHearts > 0
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
		fullSats = Math.min 10, Math.floor 10 * @world.player.saturation / Player.MAX_SATURATION
		fullSatSprite = @spriteSheet.getNamedSprite 'saturation2'
		if fullSats > 0
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

	drawZombies:()->
		if !@zombieAnimations?
			@zombieAnimations =
				left: new Animation @spriteSheet.getAnimationSprites('zombie-left', 2), 0.25
				right: new Animation @spriteSheet.getAnimationSprites('zombie-right', 2), 0.25
		for zombie in @world.zombies
			diff = zombie.position - @world.player.position
			if Math.abs(diff) < 5
				if zombie.isWalking()
					sprite = @zombieAnimations[zombie.getDirection()].getImage zombie.lifeTime
				else
					sprite = @zombieAnimations[zombie.getDirection()].getImage 0
				x = @context.canvas.width/2 + diff * 16 * 3 - sprite.width/2
				@context.drawImage sprite, x, 61

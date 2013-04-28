class Level
	@GENERATION_SIZE = 5
	@SPECIALS = true
	@NO_SPECIALS = false

	constructor:(@world)->
		@pieces =
			0:
				type: 'dirt-flat'
				special:
					type: 'grass'
		@leftPiece =
			position: 0
			type: 'dirt-flat'
		@rightPiece =
			position: 0
			type: 'dirt-flat'
		@generate -1, Level.NO_SPECIALS
		@generate 1, Level.NO_SPECIALS
		@addBush 1
		@addTree -1, Tree.MAX_SIZE
		@addTree 2, Tree.MAX_SIZE

	getPiece:(position)->
		if !@pieces[position]?
			@generate position
		@pieces[position]

	setPiece:(position, type)->
		@pieces[position] =
			type: type

	generate:(position, specials = Level.SPECIALS)->
		step = if position > 0 then 1 else -1
		lastDefiningPiece = if step > 0 then @rightPiece else @leftPiece
		x = Math.random()
		if x < 1/3
			type = 'dirt-flat'
		else if x < 2/3
			type = 'dirt'
		else
			type = 'rock'
		for i in [1..Level.GENERATION_SIZE]
			piece =
				type: if i <= Math.floor(Level.GENERATION_SIZE/2) then lastDefiningPiece.type else type
			if piece.type == 'dirt-flat'
				piece.special =
					type: 'grass'
			piecePosition = lastDefiningPiece.position + i*step
			if specials
				@addSpecial piece, piecePosition
			@pieces[piecePosition] = piece
		lastDefiningPiece.position += step * Level.GENERATION_SIZE
		lastDefiningPiece.type = type

	addBush:(position)->
		@pieces[position].special =
			type: 'bush'
			bush: @world.createBush position

	addTree:(position, startSize = 0.00001)->
		@pieces[position].special =
			type: 'tree'
			tree: @world.createTree position
		@pieces[position].special.tree.size = startSize

	addFurnace:(position)->
		@pieces[position].special =
			type: 'furnace'
			furnace: @world.createFurnace position

	removeTree:(tree)->
		@pieces[tree.position].special =
			type: 'grass'

	addSpecial:(piece, position)->
		v = Math.random()
		if piece.type == 'dirt-flat'
			if v < 0.02
				piece.special =
					type: 'bush'
					bush: @world.createBush position
				return
			if v < 0.15
				piece.special =
					type: 'tree'
					tree: @world.createTree position
				return
		if piece.type == 'rock'
			if v < 0.01
				if 50 < Math.abs position
					piece.special =
						type: 'diamond'
				return
			if v < 0.03
				if 40 < Math.abs position
					piece.special =
						type: 'gold'
				return
			if v < 0.1
				if 25 < Math.abs position
					piece.special =
						type: 'iron'
				return
			if v < 0.2
				if 15 < Math.abs position
					piece.special =
						type: 'coal'
				return

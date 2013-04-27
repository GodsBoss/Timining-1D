class Level
	@GENERATION_SIZE = 5

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
		@generate -1
		@generate 1
		@addBush 1
		@addTree -1
		@addTree 2
		@pieces[-1].special.tree.size = Tree.MAX_SIZE
		@pieces[2].special.tree.size = Tree.MAX_SIZE

	getPiece:(position)->
		if !@pieces[position]?
			@generate position
		@pieces[position]

	generate:(position)->
		step = if position > 0 then 1 else -1
		lastDefiningPiece = if step > 0 then @rightPiece else @leftPiece
		x = Math.random()
		if x < 1/3
			type = 'dirt-flat'
		else if x < 2/3
			type = 'dirt'
		else
			type = 'rock'
		for i in [1..4]
			piece =
				type: if i <= 2 then lastDefiningPiece.type else type
			if piece.type == 'dirt-flat'
				piece.special =
					type: 'grass'
			@pieces[lastDefiningPiece.position + i*step] = piece
		lastDefiningPiece.position += step * Level.GENERATION_SIZE
		lastDefiningPiece.type = type
		@pieces[lastDefiningPiece.position] =
			type: lastDefiningPiece.type

	addBush:(position)->
		@pieces[position].special =
			type: 'bush'
			bush: @world.createBush position

	addTree:(position, startSize)->
		@pieces[position].special =
			type: 'tree'
			tree: @world.createTree position

	removeTree:(tree)->
		@pieces[tree.position].special =
			type: 'grass'

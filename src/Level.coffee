class Level
	@GENERATION_SIZE = 5

	constructor:()->
		@pieces =
			0:
				type: 'grass'
		@leftPiece =
			position: 0
			type: 'grass'
		@rightPiece =
			position: 0
			type: 'grass'
		@generate -1
		@generate 1

	getPiece:(position)->
		if !@pieces[position]?
			@generate position
		@pieces[position]

	generate:(position)->
		step = if position > 0 then 1 else -1
		lastDefiningPiece = if step > 0 then @rightPiece else @leftPiece
		x = Math.random()
		if x < 1/3
			type = 'grass'
		else if x < 2/3
			type = 'dirt'
		else
			type = 'rock'
		for i in [1..4]
			piece =
				type: if i <= 2 then lastDefiningPiece.type else type
			@pieces[lastDefiningPiece.position + i*step] = piece
		lastDefiningPiece.position += step * Level.GENERATION_SIZE
		lastDefiningPiece.type = type
		@pieces[lastDefiningPiece.position] =
			type: lastDefiningPiece.type

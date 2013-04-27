class Animation
	constructor:(@frames, @interval)->

	getImage:(time)->
		@frames[((time / @interval) | 0) % @frames.length]

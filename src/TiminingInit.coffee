class TiminingInit
	constructor:(@window)->

	init:()->
		@window.addEventListener 'load', @initGame, false

	initGame:()=>

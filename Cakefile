fs = require 'fs'
cp = require 'child_process'

build = (options)->
	# Only windows for now :'-(
	files = fs.readdirSync 'src'
	files = files.map (file)->'src\\'+file
	args = ['/C', 'coffee', '-j', 'timining.coffee', '-c', '-b']
	process = cp.spawn 'cmd', args.concat files

	errors = []

	process.stderr.on 'data', (data)->
		errors.push data+''

	process.on 'close', (code)->
		if code != 0
			console.log 'There was at least one error:'
			errors.forEach (error)->console.log error

	cp.spawn 'cmd', ['/C', 'coffee', '-c', 'init.coffee']

task 'build', 'Build the game', build

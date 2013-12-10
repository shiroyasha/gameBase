define (require, exports, module) ->

	area = $('canvas')[0];
	c    = area.getContext '2d'
	RenderQueue = require 'RenderQueue'
	Background = require 'Background'
	Stars = require 'Stars'


	$(document).on 'keydown', (e) -> KEYS[e.keyCode] = true
	$(document).on 'keyup', (e) -> delete KEYS[e.keyCode]


	$ ->
		queue = new RenderQueue()
		queue.add new Background()
		queue.add new Stars()

		render = (dt) ->
			queue.update(dt)
			queue.render(c)		

		lastTime = null
		_loop = (time) ->
			if lastTime == null then lastTime = time
			dt = time - lastTime
			
			render(dt)
			lastTime = time

			requestAnimationFrame (_loop)

		requestAnimationFrame (_loop)
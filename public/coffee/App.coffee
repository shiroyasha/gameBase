define (require, exports, module) ->

	RenderQueue  = require 'RenderQueue'
	Background   = require 'Background'
	Stars        = require 'Stars'
	Asteroids    = require 'Asteroids'
	Planets      = require 'Planets'
	InputHandler = require 'InputHandler'
	Player       = require 'Player'
	Glow         = require 'Glow'
	model		 = require 'Model'


	class App

		constructor: (@c)->
			@model   = model

			InputHandler( @model )

			@queue   = new RenderQueue()

			@queue.add new Background(model)
			@queue.add new Stars(model)
			@queue.add new Planets(model)
			@queue.add new Asteroids(model)
			@queue.add new Player(model)
			@queue.add new Glow( model )

			@lastTime = null
			requestAnimationFrame ( @_loop.bind(this) )

		update: (dt) ->
			@queue.update(dt)

		render: (c) ->
			@queue.render(c)

		_loop: (time) ->
			if @lastTime == null then @lastTime = time
			dt = time - @lastTime

			@update(dt)
			@render(@c)

			@lastTime = time

			requestAnimationFrame ( @_loop.bind(this) )

	return App
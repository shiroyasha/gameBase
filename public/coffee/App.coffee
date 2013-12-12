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
	Physics      = require 'physics/modelUpdater'


	class App

		constructor: (@c)->
			@model   = model

			InputHandler( @model )

			@queue   = new RenderQueue()

			@back  = new Background(model)
			@stars = new Stars(model)

			@queue.add new Planets(model)
			@queue.add new Asteroids(model)

			@player = new Player(model)
			@glow   = new Glow( model )

			@lastTime = null
			requestAnimationFrame ( @_loop.bind(this) )
			@angle = -Math.PI/6
		update: (dt) ->

			if @model.inputDirection.y == -1
				@model.me.velocity.x += Math.cos(@model.me.orientation)*10
				@model.me.velocity.y += Math.sin(@model.me.orientation)*10


			Physics.updateModel( model, dt/100 )
			@queue.update(dt)
			@stars.update(dt)
			@back.update(dt)
			@player.update(dt)
			@glow.update(dt)

			#@angle += dt/1000
			#@model.me.orientation = dt/1000

		render: (c) ->
			X = 600 - @model.me.position.x
			Y = 500 - @model.me.position.y

			@back.render(c)


			c.save()

			#c.scale(0.1, 0.1)
			#c.translate(1000, 1000)
			c.translate( X, Y )
			c.translate( @model.me.position.x , @model.me.position.y )
			c.rotate( @angle )
			c.translate( (-@model.me.position.x), (-@model.me.position.y) )
			@stars.render(c)

			c.fillStyle = 'red'
			c.fillRect( 0, 0, 1280, 10)
			c.fillStyle = 'blue'
			c.fillRect( 0, 0, 10, 720)
			#c.translate( 600*Math.cos(-@angle ), -500*Math.sin(-@angle ) )

			#console.log @model.me.orientation
			@queue.render(c)
			@glow.render(c)
			#@player.render(c)

			#@player.render(c)

			c.restore()

		_loop: (time) ->
			if @lastTime == null then @lastTime = time
			dt = time - @lastTime

			@update(dt)
			@render(@c)

			@lastTime = time

			requestAnimationFrame ( @_loop.bind(this) )

	return App
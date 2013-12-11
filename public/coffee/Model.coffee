define (require, exports, module) ->

	model = {

		inputDirection: {
				x: 0
				y: 0
		}

		background: {
			angle: 0
			scale: 1
		}

		me: {
			position: {
				x: 640
				y: 550
			}
			velocity: {
				x: 0
				y: 0
			}
			orientation: 0 #rad
			mass: 10
			radius: 20

			speedFactor: 1
			isOnFire: false

			numberOfLives: 3
			points: 0
		}


		asteroids: [
			{
				position: {
					x: 200
					y: 300
				}
				velocity: {
					x: 0
					y: 0
				}
				orientation: 0 #rad
				mass: 10
				radius: 10
				rotation: 0 #rad/sec
			}
		]


		planets: [
			{
				position: {
					x: 200
					y: 300
				}
				velocity: {
					x: 0
					y: 0
				}
				orientation: 0 #rad
				mass: 10
				radius: 10
				rotation: 0 #rad/sec
			}
		]

	}
		

	return model


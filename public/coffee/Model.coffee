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
				x: 600
				y: 600
			}
			velocity: {
				x: 0
				y: 0
			}
			orientation: 0 #rad
			rotation: 0
			mass: 10000
			radius: 20

			speedFactor: 1
			isOnFire: false

			numberOfLives: 3
			points: 0
		}


		asteroids: [
			# {
			# 	position: {
			# 		x: 600
			# 		y: 400
			# 	}
			# 	velocity: {
			# 		x: 0
			# 		y: 0
			# 	}
			# 	orientation: Math.PI/4 #rad
			# 	mass: 10
			# 	radius: 60
			# 	rotation: 0 #rad/sec
			# },
			# {
			# 	position: {
			# 		x: 200
			# 		y: 300
			# 	}
			# 	velocity: {
			# 		x: 0
			# 		y: 0
			# 	}
			# 	orientation: Math.PI/3 #rad
			# 	mass: 10
			# 	radius: 60
			# 	rotation: 0 #rad/sec
			# },
			# {
			# 	position: {
			# 		x: 400
			# 		y: 300
			# 	}
			# 	velocity: {
			# 		x: 0
			# 		y: 0
			# 	}
			# 	orientation: 0 #rad
			# 	mass: 10
			# 	radius: 200
			# 	rotation: 0 #rad/sec
			# }

		]


		planets: [
			{
				position: {
					x: 100
					y: -300
				}
				velocity: {
					x: 0
					y: 0
				}
				orientation: 0 #rad
				mass: 10
				radius: 300
				rotation: 0 #rad/sec
			}
		]

	}


	return model


define (require, exports, module) ->

    NUM_OF_ASTEROIDS= 200

    MAX_DISTANCE     = 3000 #max distance between the asteroid and the player after which the asteroid is deleted
    MIN_DISTANCE     = 0 #minimum distance at which an asteroid can be generated without the player noticing
    SPEED            = 100
    SPEED_VARIATION  = 100
    RADIUS           = 50
    RADIUS_VARIATION = 45
    MASS             = 100
    MAX_ROTATION     = 0.002 #rad/s


    AsteroidHandler = {}

    AsteroidHandler.updateAsteroids= (model) ->
        centerX = model.me.position.x
        centerY = model.me.position.y

        for aster in model.asteroids
            #QUICK FIX, FIND OUT WHY
            if aster? and magnitude(aster.position.x - centerX, aster.position.y - centerY) > MAX_DISTANCE
                model.asteroids.splice(model.asteroids.indexOf(aster),1)
            #pobije daleke asteroide

        # console.log model.asteroids.length, NUM_OF_ASTEROIDS
        for i in [model.asteroids.length..NUM_OF_ASTEROIDS] by 1
            model.asteroids.push(createNewAsteroid(model))


    createNewAsteroid= (model) ->
        newAsteroid = {}
        newAsteroid.position = {}
        newAsteroid.velocity = {}

        cX = model.me.position.x
        cY = model.me.position.y

        while true
            newAsteroid.position.x = MAX_DISTANCE - Math.random()*MAX_DISTANCE*2 #krece se izmedju -MAX i MAX
            newAsteroid.position.y = MAX_DISTANCE - Math.random()*MAX_DISTANCE*2 #krece se izmedju -MAX i MAX
            if MIN_DISTANCE < magnitude(newAsteroid.position.x - cX, newAsteroid.position.y - cY) < MAX_DISTANCE
                break

        newAsteroid.velocity.x = SPEED - Math.random() * SPEED_VARIATION
        newAsteroid.velocity.y = SPEED - Math.random() * SPEED_VARIATION
        newAsteroid.radius     = RADIUS - Math.random() * RADIUS_VARIATION
        newAsteroid.mass       = newAsteroid.radius * newAsteroid.radius

        newAsteroid.orientation = Math.random() * Math.PI * 2
        newAsteroid.rotation = MAX_ROTATION -  2 * Math.random() * MAX_ROTATION


        return newAsteroid


    magnitude= (dx, dy) ->
        r = Math.sqrt(dx*dx+ dy*dy)


    return AsteroidHandler

    #body = [pX, pY, vX, vY, m, r, or, rot]
    #pozicija, brzina, masa, radius, orijentacija, rotacija

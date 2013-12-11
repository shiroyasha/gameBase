

    #body = [pX, pY, vX, vY, m, r, or, rot] 
    #pozicija, brzina, masa, radius, orijentacija, rotacija

define (require, exports, module) ->

    exp = {}

    damping = 0.95 #uspori pri sudaru

    class Asteroid 

        constructor: (@px=0, @py=0, @vx=0, @vy=0, @r=0, @m=0, @ori=0, @rot=0) ->


    exp.updateModel = (model, dt) ->
    #polygoni nisu podrzani zasada  
        list = model.players.concat(model.asteroids)
        
        updateBodies(list, dt)
        resolveCollisions(list)

        return model

    exp.renderModel = (c, model) ->
        for ast in model.asteroids
            c.fillStyle = "red"
            c.beginPath();
            c.arc(ast.px, ast.py, ast.r, 0, Math.PI*2, true); 
            c.closePath();
            c.fill();

    exp.addRandomAsteroid= (model) ->
        newAst = new Asteroid(100+Math.random()*200, 200+Math.random()*200, 200-Math.random()*400, 200-Math.random()*400, 5+Math.random()*35, 50+Math.random()*100)
        model.asteroids.push(newAst)    

    updateBodies= (list, dt) ->
        for body in list
            body.px += body.vx*dt
            body.py += body.vy*dt
            body.ori += body.rot*dt 

    resolveCollisions= (list) ->
        for b1 in [0...list.length]
            for b2 in [b1+1...list.length]
                collisionCheck(list[b1], list[b2])

    collisionCheck= (body1, body2) ->
        dist = Math.sqrt((body1.px-body2.px)*(body1.px-body2.px)+(body1.py-body2.py)*(body1.py-body2.py))
        if dist < (body1.r+body2.r)
            bounce(body1, body2, dist, damping)

    bounce= (body1, body2, dist, damping=1) ->
        # NE DIRAJ. AKO HOCES DA OPTIMIZUJES, OBRATI SE MIKI. RADI. PROVERENO. KRAJ.

        dx    = body1.px - body2.px
        dy    = body1.py - body2.py
        ang   = Math.atan2(dy, dx)
        
        mag1  = Math.sqrt(body1.vx*body1.vx + body1.vy*body1.vy)
        mag2  = Math.sqrt(body2.vx*body2.vx + body2.vy*body2.vy)

        dir1  = Math.atan2(body1.vy, body1.vx)
        dir2  = Math.atan2(body2.vy, body2.vx)

        nSx1  = mag1*Math.cos(dir1-ang)
        nSy1  = mag1*Math.sin(dir1-ang)

        nSx2  = mag2*Math.cos(dir2-ang)
        nSy2  = mag2*Math.sin(dir2-ang)

        fSx1  = ((body1.m-body2.m)*nSx1+(body2.m+body2.m)*nSx2)/(body1.m+body2.m);
        fSx2  = ((body1.m+body1.m)*nSx1+(body2.m-body1.m)*nSx2)/(body1.m+body2.m);
        fSy1  = nSy1;
        fSy2  = nSy2;

        body1.vx = Math.cos(ang)*fSx1+Math.cos(ang+Math.PI/2)*fSy1;
        body1.vy = Math.sin(ang)*fSx1+Math.sin(ang+Math.PI/2)*fSy1;
        body2.vx = Math.cos(ang)*fSx2+Math.cos(ang+Math.PI/2)*fSy2;
        body2.vy = Math.sin(ang)*fSx2+Math.sin(ang+Math.PI/2)*fSy2;

        if damping != 1
            body1.vx *= damping
            body1.vy *= damping
            body2.vx *= damping
            body2.vy *= damping 

        #razmakne ih kako bi se sprecilo vezivanje tela.
        
        gap = body1.r + body2.r - dist
        gapX = gap * Math.cos(ang)
        gapY = gap * Math.sin(ang)
        

        massSum = body1.m + body2.m
        body1.px += gapX * body1.m / massSum
        body1.py += gapY * body1.m / massSum
        body2.px -= gapX * body2.m / massSum
        body2.py -= gapY * body2.m / massSum

    return exp
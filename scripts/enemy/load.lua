function game.enemy.load()

    enemy = {}
    enemy.shot = {}
    --Тип Врага №1--
    enemy.type1 = {}
    enemy.type1.texture = {}
    enemy.type1.texture.ship = love.graphics.newImage("textures/enemy/1/ship.png")
    enemy.type1.texture.shot = love.graphics.newImage("textures/enemy/1/shot.png")
    enemy.type1.shot = {}
    enemy.type1.shot.height = {}
    enemy.type1.shot.damage = 100
    enemy.type1.shot.speed = 1000
    enemy.type1.width = 100
    enemy.type1.height = 50
    enemy.type1.health = 250
    enemy.type1.x = 1500
    enemy.type1.y = 360
    enemy.type1.speed = {current = 0, max = 2500}
    enemy.type1.acceleration = 500
    enemy.massEnemyIndex = 0
    --Тип Врага №1--
    enemy.type2 = {}
    enemy.type2.texture = {}
    enemy.type2.texture.ship = love.graphics.newImage("textures/enemy/2/ship.png")
    enemy.type2.texture.shot = love.graphics.newImage("textures/enemy/2/shot.png")
    enemy.type2.shot = {}
    enemy.type2.shot.height = {}
    enemy.type2.shot.damage = 150
    enemy.type2.shot.speed = 500
    enemy.type2.width = 100
    enemy.type2.height = 50
    enemy.type2.health = 250
    enemy.type2.x = 1500
    enemy.type2.y = 360
    enemy.type2.speed = {current = 0, max = 1000}
    enemy.type2.acceleration = 250

    enemy.massEnemyIndex = 0
    
    test = {}
    test.angle1 = {x = 0, y = 0}
    test.angle2 = {x = 0, y = 0}
    test.angle3 = {x = 0, y = 0}
    test.angle4 = {x = 0, y = 0}
    
end
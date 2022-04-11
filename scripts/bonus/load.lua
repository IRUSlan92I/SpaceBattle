function game.bonus.load()
    bonus = {}
    bonus.texture = {}
    bonus.types = 5
    bonus.textures = {}
    bonus.textures.lvlUp = love.graphics.newImage("textures/bonus/lvlUp.png")
    bonus.textures.laser = love.graphics.newImage("textures/bonus/laser.png")
    bonus.textures.plasma = love.graphics.newImage("textures/bonus/plasma.png")
    bonus.textures.health = love.graphics.newImage("textures/bonus/health.png")
    bonus.textures.life = love.graphics.newImage("textures/bonus/life.png")
end

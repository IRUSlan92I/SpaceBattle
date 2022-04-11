function game.interface()

    --HP--
    game.player.health()
    
    game.player.score()
    
    --Перегрев--
    game.player.heat()
    
    --Пауза--
    if current.pause then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.drawq(menu.texture.buttons, menu.texture.interface.pause, 490, 260)
    end
    
    game.menu()
    
    

end

-----Отрисовка Меню в Игре-----
function game.menu()
    if player.dead then
        
        menu.selection()
        menu.enter()

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(menu.texture.dead, 50, 50)

        love.graphics.setColor(255, 255, 255, 255)
        if current.button == buttonRestart then
            love.graphics.drawq(menu.texture.buttons, menu.texture.button.restart.pressed, 200, 500)
        else
            love.graphics.drawq(menu.texture.buttons, menu.texture.button.restart.unpressed, 200, 500)
        end
        
        if current.button == buttonMenu then
            love.graphics.drawq(menu.texture.buttons, menu.texture.button.menu.pressed, 900, 500)
        else
            love.graphics.drawq(menu.texture.buttons, menu.texture.button.menu.unpressed, 900, 500)
        end
    end
end

-----Отрисовка HP Игрока-----
function game.player.health()
    
    local health = {x = 50, y = 50, multiplier = 0.5} --координаты левого верхнего угла полоски здоровья и множитель зависимости от HP

    if not player.dead then
        --Красное--
        love.graphics.setColor(255, 0, 0, 100)
        love.graphics.rectangle("fill", health.x + player.health.current * health.multiplier, health.y, (player.health.max - player.health.current) * health.multiplier, 25)
        --Зеленое--
        love.graphics.setColor(0, 255, 0, 100)
        love.graphics.rectangle("fill", health.x, health.y, player.health.current * health.multiplier, 25)
        
        if current.godmode then
            love.graphics.setColor(255, 100, 0, 200)
            love.graphics.print("Godmode", health.x+175, health.y, 0, 2.5, 2.5, 0, 0)
        end
    else
        love.graphics.setColor(255, 0, 0, 100)
        love.graphics.rectangle("fill", health.x, health.y, player.health.max * health.multiplier, 25)
    end

end

-----Отрисовка Перегрева Оружия-----
function game.player.heat()
    
    local heat = {x = 50, y = 80, multiplier = 5} --координаты левого верхнего угла полоски перегрева и множитель зависимости от перегрева

    if player.weapon.heat.current >= 0 then
        --Серое--
        love.graphics.setColor(100, 100, 100, 100)
        love.graphics.rectangle("fill", heat.x + player.weapon.heat.current * heat.multiplier, heat.y, (player.weapon.heat.max - player.weapon.heat.current) * heat.multiplier, 10)
        --Оранжевое--
        love.graphics.setColor(220, 100, 0, 100)
        love.graphics.rectangle("fill", heat.x, heat.y, player.weapon.heat.current * heat.multiplier, 10)
    else
        love.graphics.setColor(100, 100, 100, 100)
        love.graphics.rectangle("fill", heat.x, heat.y, player.weapon.heat.max * heat.multiplier, 10)
    end

end

-----Очки и Жизни-----
function game.player.score()
    local score = {x = 50, y = 100}
    local life = {x = 50, y = 150}
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.print(player.score, score.x, score.y, 0, 2.5, 2.5, 0, 0)
    for i = 0, player.lifes.current-1 do
        love.graphics.draw(menu.texture.live, life.x + life.x * i /2, life.y)
    end
end
-----Отрисовка Врагов-----
function game.enemy.draw()
    for i,v in ipairs(enemy) do
        if v.type == 1 then
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(v.texture.ship, v.x, v.y, v.angle, -1, 1)
        elseif v.type == 2 then
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(v.texture.ship, v.x, v.y, v.angle, -1, 1)
        end

    end
end

function game.enemy.shot.draw()
    for i,v in ipairs(enemy.shot) do
        love.graphics.setColor(255, 100, 0, 255)
        love.graphics.draw(v.texture, v.x, v.y, v.angle, 1, 1)
    end
end
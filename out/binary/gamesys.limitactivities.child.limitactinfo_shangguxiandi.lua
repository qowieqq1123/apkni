









local limitActInfo_shangguxiandi={name='shangguxiandi'}


function limitActInfo_shangguxiandi:onInit()

end


function limitActInfo_shangguxiandi:onStart()

end


function limitActInfo_shangguxiandi:onUpdate()

end


function limitActInfo_shangguxiandi:onDelete()

end


function limitActInfo_shangguxiandi:checkReddot()
return false
end


function limitActInfo_shangguxiandi:jump()
mysteryWeekActivityController:openFightWeekEnterWin()
end

function limitActInfo_shangguxiandi:checkJump_time(isWarning)
return true
end

function limitActInfo_shangguxiandi:checkJump_data(isWarning)
local fb=mysteryWeekActivityModel:getNextMystery()
if isWarning and fb==nil then
UIManager.error("大世界暂无上古险地")
end
return fb~=nil
end


return limitActInfo_shangguxiandi
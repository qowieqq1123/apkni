









local limitActInfo_worldleader={name='worldleader'}


function limitActInfo_worldleader:onInit()

end


function limitActInfo_worldleader:onStart()
if self:checkOpen()and not self:checkIdle()then
worldLeaderController:send_248_31()
end
end


function limitActInfo_worldleader:onUpdate()

end


function limitActInfo_worldleader:onDelete()

end


function limitActInfo_worldleader:checkReddot()
if self:checkDoing()then
return worldLeaderModel:getReddot()
end
return false
end


function limitActInfo_worldleader:jump()
UIFullWorldBigBossController:showRankWindow()
end

return limitActInfo_worldleader






function fightEntity:initHuaSe()
self.huaSeList={}
end


function fightEntity:getHuaSeList()
return self.huaSeList or{}
end

function fightEntity:changeHuaSe(huaSeList)
self.huaSeList=huaSeList
end

function fightEntity:refreshHuaSeHUD()
if self.hud and self.hud.callExtraFunc then
self.hud:callExtraFunc("refreshHuaSe")
end
end

function fightEntity:refreshShenShiHUD()
if self.hud and self.hud.callExtraFunc then
self.hud:callExtraFunc("refreshShenShi")
end
end
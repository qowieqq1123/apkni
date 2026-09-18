
def_class('entityHUDCtr',{})

local createQueue={}
local entityHudPool={}
local bossHudList={}
local shieldHudList={}

function entityHUDCtr:enter()
createQueue={}
entityHudPool={}
bossHudList={}
shieldHudList={}
end


function entityHUDCtr:leave()
createQueue={}

entityHudPool={}
bossHudList={}
shieldHudList={}
end

function entityHUDCtr:createEntityHud(entity)
local hud=entityHUD(entity)
entityHudPool[hud.id]=hud
if self.mainHUD~=nil then
hud:setFlowGen(self.mainHUD.flow)
end

return hud
end

function entityHUDCtr:removeHud(hud)
entityHudPool[hud.id]=nil
end


function entityHUDCtr:setMainHUD(mainHUD)
if mainHUD~=nil then
self.mainHUD=mainHUD
for id,hud in pairs(createQueue)do
self:doCreateHUD(hud)
end

for _,hud in pairs(entityHudPool)do
hud:setFlowGen(self.mainHUD.flow)
end
createQueue={}
else
self.mainHUD=nil
for i,hud in pairs(entityHudPool)do
hud:setFlowGen(nil)
end
entityHudPool={}
end
end

function entityHUDCtr:createHUD(hud)
if self.mainHUD~=nil then
self:doCreateHUD(hud)
hud:setFlowGen(self.mainHUD.flow)
else
createQueue[hud.id]=hud
end
end

function entityHUDCtr:removeHUD(hud)
if self.mainHUD~=nil then
self:doRemoveHUD(hud)
else
createQueue[hud.id]=nil
end
end

function entityHUDCtr:doCreateHUD(hud)
if hud:checkType(true)==0 then
self.mainHUD:createHUD(hud)
end
end

function entityHUDCtr:doRemoveHUD(hud)
if hud:checkType(false)==0 then
self.mainHUD:removeHUD(hud)
end
end

function entityHUDCtr:saveBossHud(hud)
bossHudList[#bossHudList+1]=hud
end

function entityHUDCtr:removeBossHud(hud)
local index=nil
for k,v in pairs(bossHudList)do
if v==hud then
index=k
break
end
end
table.remove(bossHudList,index)
end

function entityHUDCtr:getBossHudList()
return bossHudList
end

function entityHUDCtr:isEnptyToBossHudList()
return#bossHudList==0
end

function entityHUDCtr:saveShieldHud(hud)
shieldHudList[#shieldHudList+1]=hud
end

function entityHUDCtr:removeShieldHud(hud)
local index=nil
for k,v in pairs(shieldHudList)do
if v==hud then
index=k
break
end
end
table.remove(shieldHudList,index)
end

function entityHUDCtr:getShieldHudList()
return shieldHudList
end

function entityHUDCtr:isEmptyToShieldHudList()
return#shieldHudList==0
end

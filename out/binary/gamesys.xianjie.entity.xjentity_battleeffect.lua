









local xjEntity_battleEffect={}


function xjEntity_battleEffect:onInit()
self:initData()
end

function xjEntity_battleEffect:initData()
local data=self.data
self.battleType=data.battleType
self.guid_str=data.guid_str
self.targetDataID=data.targetDataID
self.marchtype=data.marchtype
self.NoModelPlay=false
if self.marchtype and self.marchtype==xjServerMarchType.eMJSLDebuffAdd then
self.NoModelPlay=true
end
self.atkLookup={}

local targetData=xianjieController:getXJClass(self.targetDataID)
if data.fightEffect then
self.fightEffect=data.fightEffect
else
if targetData.getCfg then
local cfg=targetData:getCfg()
self.fightEffect=cfg.fightEffect or{}
else
self.fightEffect={}
end
end
self.atkSize=targetData:getAtkSize()
self.size=targetData:getWorldSize()
self.pos=targetData:getWorldPos_1()
end

function xjEntity_battleEffect:addBattleTime(key,stime,etime,params)
local atk=self.atkLookup[key]
if atk==nil then
atk={stime,etime,nil,params}
self.atkLookup[key]=atk
local widget=self:getWidget()
if widget then
self:initAllBattleAtkEffect(widget)
end
end
end

function xjEntity_battleEffect:removeBattleTime(key)
self:removeBattleAtkEffect(key)
if not self:checkBattleTime()then
local flag=xianjieController:removeBatterEffect(self.battleType,self.guid_str)
if not flag then
xianjieController:removeEntity(self:getKey())
end
end
end


function xjEntity_battleEffect:checkAndRemoveBattleTime(key)
if not self:checkBattleTime()then
self:removeBattleAtkEffect(key)
local flag=xianjieController:removeBatterEffect(self.battleType,self.guid_str)
if not flag then
xianjieController:removeEntity(self:getKey())
end
end
end

function xjEntity_battleEffect:checkBattleTime()
if self.atkLookup~=nil and next(self.atkLookup)then
local curTime=gameUtilityModel.getServerShortTime2()
for key,atk in pairs(self.atkLookup)do
if curTime>=atk[1]and curTime<atk[2]then
return true
end
end
end
return false
end


function xjEntity_battleEffect:onCreateWidget(widget)
self:initAllBattleAtkEffect(widget)
end


function xjEntity_battleEffect:onRemoveWidget(widget)

self:removeAllBattleAtkEffect()

end


function xjEntity_battleEffect:initBattleEffect(widget)
if self.fightAttactTime==nil and self.fightEffect and self.fightEffect[2]then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
if self.fightEffect[1]~=nil and self.fightEffect[1]>0 then
self:modelPlayAnimation(self.fightEffect[1])
end
end
end











function xjEntity_battleEffect:modelPlayAnimation(amin)
if not amin then
return
end
local tagEntKey
local targetData=xianjieController:getXJClass(self.targetDataID)
if targetData then
tagEntKey=targetData:getEntityKey()
end
if tagEntKey and not self.NoModelPlay then
xianjieController:invokeEntityFunc(tagEntKey,'modelPlayAnimation',amin)
end
end


function xjEntity_battleEffect:initAllBattleAtkEffect(widget)
local has=false
local curTime=gameUtilityModel.getServerShortTime2()
for _,atk in pairs(self.atkLookup)do
if curTime>=atk[1]and curTime<atk[2]then
has=true
if atk[3]==nil then
local data_=atk[4]
data_.size=self.atkSize
data_.pos=self.pos
atk[3]=xianjieController:addEntity(XJ_ENTITY_TYPE.eBattleAtk,data_,true)
end
end
end
if has then
self:initBattleEffect(widget)
end
end

function xjEntity_battleEffect:removeBattleAtkEffect(key)
local atk=self.atkLookup[key]
if atk==nil then return end
if atk[3]~=nil then
xianjieController:removeEntity(atk[3])
end
self.atkLookup[key]=nil
end

function xjEntity_battleEffect:removeAllBattleAtkEffect()
for key,atk in pairs(self.atkLookup)do
if atk[3]~=nil then
xianjieController:removeEntity(atk[3])
atk[3]=nil
end
end
end



function xjEntity_battleEffect:onUpdate()
if not self:checkBattleTime()then
local flag=xianjieController:removeBatterEffect(self.battleType,self.guid_str)
if not flag then
xianjieController:removeEntity(self:getKey())
end
return
end
local widget=self:getWidget()
if widget then
if self.fightAttactTime then
if Time.realtimeSinceStartup>=self.fightAttactTime then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
self:modelPlayAnimation(self.fightEffect[1])
end
end
end
end

function xjEntity_battleEffect:onDelete()

end

return xjEntity_battleEffect










local xjEntity_plotMonster={}


function xjEntity_plotMonster:onInit()
local data=self.data
self.cloudid=data[1]
self.plotIdx=data[2]
local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
self.fightEffect=cloudPlotData.cfg.fightEffect
self.pos=cloudPlotData:getWorldPos_1()
self.size=cloudPlotData:getWorldSize()
end


function xjEntity_plotMonster:onCreateWidget(widget)
local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,self.cloudid,self.plotIdx)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local monsterGroupId=cfg.data[2]
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupId)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,modelParams.body,modelParams.componets,'Entity',entCfg.sortOrder,1,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)


self:initBattleEffect(widget)
end


function xjEntity_plotMonster:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
self:removeBattleEffect(widget)
end

function xjEntity_plotMonster:activeBattleEffect(flag)
if flag then
self.battleFlag=true
self:initBattleEffect()
else
self.battleFlag=nil
local widget=self:getWidget()
self:removeBattleEffect(widget)
end
end

function xjEntity_plotMonster:initBattleEffect(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
if self.battleFlag then
if self.fightAttactTime==nil then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local modelID=self.fightEffect[3]
local size=self.fightEffect[5]
widget:SetChildSceneEntityCreateModel(1,modelID,{},'Entity',entCfg.sortOrder+1,size,nil,false)
widget:SetChildLocalPos(1,self.fightEffect[6][1],self.fightEffect[6][2],0)
local flipX
if self.fightEffect[4]==0 then
flipX=false
else
flipX=true
end
widget:SetChildSceneEntityFlipX(1,flipX)
widget:SetChildSceneEntityPlayAnimation(0,self.fightEffect[1])
end
else
self:removeBattleEffect(widget)
end
end

function xjEntity_plotMonster:removeBattleEffect(widget)
if self.fightAttactTime~=nil then
if widget then
widget:SetChildSceneEntityRemoveModel(1)
end
self.fightAttactTime=nil
end
end


function xjEntity_plotMonster:onMyClick(boxParams)
xianjieController:createCloudPlotBehavior(self.cloudid,self.plotIdx,true)
end


function xjEntity_plotMonster:onUpdate()
local widget=self:getWidget()
if widget==nil then return end
if self.fightAttactTime then
if Time.realtimeSinceStartup>=self.fightAttactTime then
self.fightAttactTime=Time.realtimeSinceStartup+self.fightEffect[2]
widget:SetChildSceneEntityPlayAnimation(0,self.fightEffect[1])
end
end
end

function xjEntity_plotMonster:onDelete()

end

return xjEntity_plotMonster
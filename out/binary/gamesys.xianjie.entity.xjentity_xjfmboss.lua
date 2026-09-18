









local xjEntity_XJFMBoss={}


function xjEntity_XJFMBoss:onInit()
local data=XianJieFuMoController:getBossData()
local modelCfg=data:getBossModel()
self.pos=data:getWorldPos_1()
self.pos.y=self.pos.y+(modelCfg[3]or 0)
self.size=data:getWorldSize()

self.canSelect=true
self.allowClickGrid=false
self.createTeamtime=gameUtilityModel.getServerShortTime2()+math.random(5,10)


local baseCfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
local monsterIdx=XianJieFuMoModel:getMonsterIdx()
local cfg=baseCfg.monster[monsterIdx]
local lvIdx=XianJieFuMoModel:getData().lvIdx or 1
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg[1][lvIdx])
self.ent_name=monsterCfg.name
end


function xjEntity_XJFMBoss:onSelectHandle(widget,isSelect)

end


function xjEntity_XJFMBoss:onCreateWidget(widget)


self.widget=widget

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local data=XianJieFuMoController:getBossData()
local modelCfg=data:getBossModel()
local animId=data:getBossAnimID()





widget:SetChildSceneEntityCreateModel(0,modelCfg[1],{},'Entity',entCfg.sortOrder,modelCfg[2],nil,false)
widget:SetChildSceneEntityPlayAnimation(0,animId,1)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)

end


function xjEntity_XJFMBoss:onRemoveWidget(widget)

widget:SetChildSceneEntityRemoveModel(0)
self.widget=nil
end


function xjEntity_XJFMBoss:onMyClick(boxParams)
UIFullXianJieFuMoController:showChallengeWin()
end

function xjEntity_XJFMBoss:chanegeBossAmiState(animId)
if self.widget then
self.widget:SetChildSceneEntityPlayAnimation(0,animId,1)
end
end

function xjEntity_XJFMBoss:onUpdate(boxParams)

if self.createTeamtime and gameUtilityModel.getServerShortTime2()>self.createTeamtime then
self.createTeamtime=gameUtilityModel.getServerShortTime2()+math.random(5,10)
local data=XianJieFuMoController:getBossData()
data:checkCreateAniTeam()
end
end

function xjEntity_XJFMBoss:onDelete()

end

return xjEntity_XJFMBoss

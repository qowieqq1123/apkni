






local _MODULENAME="worldModel"




def_table(_MODULENAME)
worldModel.name=_MODULENAME



worldModel.data={}



worldModel.UNITTYPE=eWorldUnitTpye

worldModel.ON_SCENE_STATE=
{
ENTER=1,
EXIT=2,
}


worldModel.UNITTYPENAME=
{
[worldModel.UNITTYPE.EXPERIENCE]='历练',
[worldModel.UNITTYPE.MYSTERY]='秘境',
[worldModel.UNITTYPE.MONSTER]='妖怪',
[worldModel.UNITTYPE.RESPOINT]='资源点',
[worldModel.UNITTYPE.FAMILY]='修真家族',
[worldModel.UNITTYPE.TOURPOINT]='游历',
[worldModel.UNITTYPE.RESMYSTERY]='仙迹福地',
}


worldModel.world=nil












worldModel.chatPosKey="WorldChatPosition"
worldModel.defaultChatPosition={-30,-175}
worldModel.chatPosition=nil

local _this=worldModel

local dragonbone_ScaleEx={
[eWorldUnitTpye.EXPERIENCE]=2,
[eWorldUnitTpye.WORLDLEADER]=3,
[eWorldUnitTpye.SYSTEMZM_OUTGOER]=1.1,
}


function worldModel:onAppStart()

end


function worldModel:onEnterState()
self:loadChatPosition()
end


function worldModel:onLeaveState(isReconnet)

self.data={}
if not isReconnet then
self:clearPanelTab()
end

end


function worldModel:onServerDataInitFinish()

end


function worldModel:finishInit(unitType)
self.data[unitType]=true
end

function worldModel:checkInit(unitType)
return self.data[unitType]or false
end

function worldModel:checkInits(unitTypes)
for i,v in ipairs(unitTypes)do
if not self:checkInit(v)then
return false
end
end
return true
end



function worldModel:isSameWorld(id)
return self.world==id
end




function worldModel:convertUnitKey(datas)
return table.concat(datas,"_")
end




function worldModel:separateUnitKey(key)
return string.split(key,'_')
end




function worldModel:getModelSettings(id,type)
local modelSettings=nil
if id then

local modelCfg=cfgHelper.get1(cfg_worldmodelconfig_get,id)
if modelCfg then
local v=modelCfg.data

local info=v[4]
local sound=v[5]
local soundData=nil
if sound then
soundData=CS.WorldModelSound.New(sound[1],sound[2],sound[3],sound[4])
end
local range=mathHelper.convertArrayToVector({v[1],v[2]})
if v[3]then

local cfg=cfgHelper.get1(cfg_characterModelConfig_get,info[1])
local scale=cfg.Scale and cfg.Scale[2]or 0
local height=cfg.Bounds and cfg.Bounds[5]or 0
modelSettings=CS.WorldPrefabSetting.New(range,height*scale,soundData,info[1],Vector3.zero)
else
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,info[1])
local scaleInfo=cfg.worldScales
local lookup=type and dragonbone_ScaleEx[type]or 1
local scale=scaleInfo and scaleInfo[lookup]or 1
local height=cfg.size and cfg.size[2]or 0
local offset=cfg.worldOffset and
mathHelper.convertArrayToVector(cfg.worldOffset)or
Vector3.zero

modelSettings=CS.WorldEntitySetting.New(range,height*scale,soundData,
info[1],info[2],info[3],scale,offset)
if api_Available_SetWorldEntityUseSmall()then
modelSettings:SetWorldEntityUseSmall(false)
end
end

else
loggerUtil.logErrFMT("无效的大世界模型id：{0}",id)
end
end
return modelSettings
end




function worldModel:getHUDSetting(id)
local hudSetting=nil
if id then
local hudCfg=cfgHelper.get1(cfg_worldhudconfig_get,id)
local hudCmpCfg=cfgHelper.get(cfg_worldhudcomponentconfig_get,hudCfg.target)
local range=mathHelper.convertArrayToVector(hudCfg.range)
local rate=mathHelper.convertArrayToVector(hudCfg.rate)
local offset=hudCfg.offset and mathHelper.convertArrayToVector(hudCfg.offset)or Vector2.zero
local super=hudCfg.super and mathHelper.convertArrayToVector(hudCfg.super)or Vector3.zero
local pivot=hudCfg.pivot or 0
hudSetting=CS.WorldHUDSetting.New(range,hudCmpCfg.creator,hudCmpCfg.abName,hudCmpCfg.assetName,rate,offset,pivot,super)
end
return hudSetting
end




function worldModel:getSymbolSetting(id)
local symbolSetting=nil
if id then
local symbolCfg=cfgHelper.get1(cfg_worldsymbolconfig_get,id)
symbolSetting=CS.WorldSymbolSetting.New(symbolCfg.target,symbolCfg.frame,symbolCfg.angel)
end
return symbolSetting
end

function worldModel:saveChatPosition(position)
self.chatPosition={position.x,position.y}
userActorSetting.set(self.chatPosKey,self.chatPosition)
userActorSetting.flush()
end

function worldModel:loadChatPosition()
self.chatPosition=userActorSetting.get(self.chatPosKey,self.defaultChatPosition)
end

function worldModel:setPanelTab(tab)
self.panelTab=tab
end

function worldModel:getPanelTab()
return self.panelTab
end

function worldModel:clearPanelTab()
self.panelTab=nil
end

function worldModel:getDragonbone_ScaleEx(type)
return dragonbone_ScaleEx[type]
end



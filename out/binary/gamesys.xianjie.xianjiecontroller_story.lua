




local gameInterface=CS.GameInterface
local hideInPlotLookup={}

function xianjieController:onAppStart_Story()

end

function xianjieController:onEnterState_Story(isReconnet)
self.hideUnitTypeLookup={}
self.hideUnitTypeLookup2={}
local cfgs=cfg_xianjieentityconfig()
for _,cfg in pairs(cfgs)do
if cfg.isHideInPlot and cfg.id~=XJ_ENTITY_TYPE.eStoryPlot then
hideInPlotLookup[cfg.id]=true
end
end
end

function xianjieController:onLeaveState_Story(isReconnet)
if isReconnet then
xianjieController:leaveStoryMode()
end
hideInPlotLookup={}
self.hideUnitTypeLookup={}
self.hideUnitTypeLookup2={}
end



function xianjieController:enterStoryMode(closeTips)

if self.isInStoryModel then return end
self.isInStoryModel=true

xianjieController:activeHudWin(false)


xianjieController:stopCameraControl()

baseFullScreenUI:openMain(false)


UIManager:showWindow("UIXianJieHudWin")



if closeTips~=false then
UIManager.enableTopHourceTips(false)

UIManager.closeTopHourceLamp()
end

notifySystem:postNotify(notifyConfig.onEnterXianJieBt)
end

function xianjieController:leaveStoryMode()

if not self.isInStoryModel then return end
self.isInStoryModel=false


xianjieController:activeHudWin(true)

xianjieController:resumeCameraControl()



xianjieController:resumeAllTypeUnitInPlot()

UIManager.clearTipsFlag()

baseFullScreenUI:openMain(true)

notifySystem:postNotify(notifyConfig.onLeaveXianJieBt)
end

function xianjieController:chcekIsInStoryMode()
return self.isInStoryModel
end

function xianjieController:pushStoryUnit(unitKey,unitType,data,needRefreshAOI)
local entKey=xianjieController:addEntity(unitType,data,needRefreshAOI)
local result=entKey~=nil
if result then
xianjieModel:pushStoryUnit(unitKey,entKey)
end
return result
end

function xianjieController:popStoryUnit(unitKey)
local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey~=nil then
local result=xianjieController:removeEntity(entKey,true)
xianjieModel:pushStoryUnit(unitKey,nil)
return result
else
logErr("仙界 剧情实体删除失败",unitKey)
end
return false
end

function xianjieController:removeAllStoryEntity()
local lookup=xianjieModel:getLookUp()
for unitKey,entKey in pairs(lookup)do
xianjieController:popStoryUnit(unitKey)
end

local effectLoopUp=xianjieModel:getEffectLookup()
for key,handle in pairs(effectLoopUp)do
xianjieController:stopEffect_GameInterface(key)
end

end


function xianjieController:unitSpeak(unitKey,content,duration,offset,callback)
local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
if ent and ent.hudID then
local hudObj=xianjieController:getEntityHud(ent.hudID)
if hudObj and hudObj.speak then
hudObj:speak(content,duration,offset,callback)
return true
else
logErr("仙界 行为树 实体 lua 缺少 speak 接口")
end
logErr("仙界 行为树 实体 没有 hud")
end
else
logErr("仙界 行为树 实体 unitKey 错误")
end
return false
end

function xianjieController:cameraDOShake(duration,strength,vibrato,callback)
local cameraTF=xianjieController:getCameraTransform()
if cameraTF then
local tweener=_DOTweenProxy.DOShakePosition(cameraTF,duration,strength,vibrato)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(callback)
end
end

function xianjieController:showUnit(unitKey,show)
local entKey=xianjieModel:getStoryUnit(unitKey)
if entKey then
local ent=xianjieController:getEntity(entKey)
if ent then
ent:setShow(show)
end
else
logErr("仙界 行为树 实体 unitKey 错误")
end
end



function xianjieController:getUnitModelParam(unitType)
local modelCfg=cfgHelper.get1(cfg_xianjiestoryplotmodelconfig_get,unitType)
local speId=modelCfg.speId
if speId~=nil then
if speId==-1 then
local sortFunc=function(sortA,sortB)
if sortA.jingjielv==sortA.jingjielv then
local aFight=UIDiscipleModel:getDiscipleFightValue(sortA.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(sortB.discipleguid)
return aFight>bFight
else
return sortA.jingjielv>sortA.jingjielv
end

end
local sortList=UIDiscipleModel:getSortList(nil,sortFunc)
local data=sortList[1]
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(data.discipleguid)
return{modelParams.body,modelParams.componets}
end

if speId==-2 then
local discipleguid=JiuChongTianJieEnterController:getDuJieDisciple()
discipleguid=tostring(discipleguid)
if tonumber(discipleguid)<=0 then
local sortFunc=function(sortA,sortB)
if sortA.jingjielv==sortA.jingjielv then
local aFight=UIDiscipleModel:getDiscipleFightValue(sortA.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(sortB.discipleguid)
return aFight>bFight
else
return sortA.jingjielv>sortA.jingjielv
end

end
local sortList=UIDiscipleModel:getSortList(nil,sortFunc)
local data=sortList[1]
discipleguid=data.discipleguid
end
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleguid)
return{modelParams.body,modelParams.componets}
end

if speId==-3 then
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zm')
local modelId=modelset.model
local sceneidx=xianjieModel:getSceneIndex()or xianjienSceneIndexType.eXianJie
local zmData=xianjieModel:getMyZongMenData(sceneidx)
if zmData and zmData.sectdress and zmData.sectdress~=0 then
local sectdressId=zmData.sectdress
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.zongmen,sectdressId)
if settingcfg then
modelId=settingcfg.modelId
end
end
local offset=modelset.offset

return{modelId,{},offset}
end
end

if modelCfg.showArgs~=nil then
return modelCfg.showArgs
end

return{}
end



function xianjieController:palyEffect_GameInterface(key,effectID,pos,delay)
local handle=xianjieModel:getEffectHandle(key)
if handle==nil then
pos=Vector3(pos[1],pos[2],pos[3])
delay=delay or 0
handle=gameInterface.PlayEffect(effectID,pos,delay)
xianjieModel:pushEffectHandle(key,handle)
else
logErr("仙界剧情特效 key 已被占用",key)
end
end

function xianjieController:stopEffect_GameInterface(key)
local handle=xianjieModel:getEffectHandle(key)
if handle then
gameInterface.StopEffect(handle)
xianjieModel:pushEffectHandle(key,nil)
else
logErr("仙界剧情特效 key 无效",key)
end
end



function xianjieController:checkHideInStoryPlotCrateUnit(entityType)
return self.hideUnitTypeLookup[entityType]==true or self.hideUnitTypeLookup2[entityType]==true
end

function xianjieController:hideAllTypeUnit(typeList)
local old=self.hideUnitTypeLookup
typeList=typeList or{}
local lp={}
for _,entityType in ipairs(typeList)do
lp[entityType]=true
end
self.hideUnitTypeLookup=lp
local lp2=self.hideUnitTypeLookup2
local hide={}
local show={}
for entityType,_ in pairs(old)do
if lp[entityType]==nil and lp2[entityType]==nil then
table.insert(show,entityType)
end
end
for entityType,_ in pairs(lp)do
if old[entityType]==nil and lp2[entityType]==nil then
table.insert(hide,entityType)
end
end
if#show>0 then
xianjieController:setEntityTypesLogicShow(show)
end
if#hide>0 then
xianjieController:setEntityTypesLogicShow(hide)
end
end

function xianjieController:hideAllTypeUnitInPlot()
local hide={}
local lp=self.hideUnitTypeLookup
local lp2=self.hideUnitTypeLookup2
for entityType,_ in pairs(hideInPlotLookup)do
if lp[entityType]==nil and lp2[entityType]==nil then
table.insert(hide,entityType)
end
lp2[entityType]=true
end
if#hide>0 then
xianjieController:setEntityTypesLogicShow(hide)
end
end

function xianjieController:resumeAllTypeUnitInPlot()
local show={}
local lp=self.hideUnitTypeLookup
local lp2=self.hideUnitTypeLookup2
for entityType,_ in pairs(hideInPlotLookup)do
if lp[entityType]==true or lp2[entityType]==true then
table.insert(show,entityType)
end
end
self.hideUnitTypeLookup2={}
if#show>0 then
xianjieController:setEntityTypesLogicShow(show)
end
end

function xianjieController:checkUnitCreateFinish(unitKey)
return xianjieModel:getUnit(unitKey)~=nil
end

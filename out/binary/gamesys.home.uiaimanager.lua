
uiAIManager=gameState.addListener({})

local _def_dz_scale=1
local _def_dz_chuiwei_scale=1.8

function uiAIManager:onAppStart()

end

function uiAIManager:onEnterState(isReconnect)
if isReconnect then
return
end
self.uiDZDatas={}
self.loadingList={}
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end

function uiAIManager:onLeaveState(isReconnect)
if isReconnect then
return
end
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self.uiDZDatas={}
self.loadingList={}
end

function uiAIManager.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local dzStr=tostring(discipleguid)
for k,v in pairs(uiAIManager.uiDZDatas)do
if dzStr==v.dzIdStr then
local dzWidget=v.bt:getSharedVar('dzWidget')
local dzId=v.bt:getSharedVar('dzId')
local otherData={scale=v.data.scale,weaponslot=v.data.weaponslot,keepButtonEvent=true}
uiAIManager:setDiscipleModel(dzWidget,dzId,otherData)
if v.data.cwCallback then
v.data.cwCallback(v.bt,old,cur)
end
end
end
end
end

function uiAIManager:clearUIWinData(winName)
for k,v in pairs(self.uiDZDatas)do
if v.winName==winName then
self:removeUIInstance(v.bt)
end
end


for k,v in pairs(self.loadingList)do
if v.winName==winName then
_InstantiateManager.RemoveInstance(k)
self.loadingList[k]=nil
end
end
end










function uiAIManager:createUIDisciple(winName,fileName,dzId,parent,pos,initData,otherData,callback)
local dzIdStr=tostring(dzId)
otherData=otherData or{}

local stype=otherData.instanceType or INSTANCE_TYPE.eUIDisciple
local id=_InstantiateManager.AddInstance(stype,parent,function(id)
local dzWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
dzWidget:SetChildAnchoredPosition(0,pos)

self:setDiscipleModel(dzWidget,dzId,otherData,winName)

local baseData={
dzId=dzId,
stId=id,
dzWidget=dzWidget,
dzIndex=0,
stWidget=dzWidget,
stIndex=-1,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
dzWidget:SetChildCanvasEx(baseData.dzIndex,'',otherData.order)
end
self.uiDZDatas[id]={dzIdStr=dzIdStr,bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end

function uiAIManager:setDiscipleModel(dzWidget,dzId,otherData,winName)
local scale=otherData.scale
local weaponslot=otherData.weaponslot
local clearButtonEvent=not otherData.keepButtonEvent
local checkChuiWei=otherData.checkChuiWei==nil and true or otherData.checkChuiWei
local state=UIDiscipleModel:getDiscipleState(dzId)
if not scale then
scale=1
end
if state==DISCIPLE_STATE_TYPE.eChuiWei and checkChuiWei then
scale=scale*_def_dz_chuiwei_scale
weaponslot=nil
else
scale=scale*_def_dz_scale
end

local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
if info==nil then
logErr(FMT.fmt('获取弟子形象为空:{0} {1}',winName,dzId))
return
end

local modelParams
local weaponId
local slotName
if weaponslot then
local slotData=cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,weaponslot)
weaponId=slotData[1]
slotName=slotData[2]
if slotName then
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
else
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(dzId,weaponId)
end
else
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
end
local dzScale=isometricMapSystem:getModelScale(modelParams.body,true)
if state==DISCIPLE_STATE_TYPE.eChuiWei and checkChuiWei then
local sex=UIDiscipleModel:getDiscipleSex(dzId)
modelParams.body=sex==1 and 1114103 or 1114104
modelParams.componets=nil
if not otherData.noRescueClick then
dzWidget:SetChildButtonClick(2,function()
local chuiwei=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.eChuiWei)
if chuiwei then
discipleSelectController.onJiuZhiClick(dzId)
end
end)
end
else
if clearButtonEvent then
dzWidget:SetChildButtonClick(2,nil,true,0)
end
end
dzWidget:SetChildUIModelShowTarget(0,modelParams.body,dzScale*scale,modelParams.componets,eAnimationID.stand)
if weaponId and slotName and modelParams.hideWeapon==nil then
local outSide=cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponId,'out_side')
dzWidget:SetChildLoadSlot(0,slotName,outSide)
end
end

function uiAIManager:removeUIInstance(bt)
if bt then
local stId=bt:getSharedVar('stId')
if stId then
self.uiDZDatas[stId]=nil
_InstantiateManager.RemoveInstance(stId)
end
behaviorManager:removeBehaviorTree(bt)
end
end

function uiAIManager:createUIObject(winName,fileName,stType,bodyId,parent,pos,initData,otherData,callback)
otherData=otherData or{}
local id=_InstantiateManager.AddInstance(stType,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(0,pos)

local scale=isometricMapSystem:getModelScale(bodyId,true)
if otherData.scale then
scale=scale*otherData.scale
end
stWidget:SetChildUIModelShowTarget(0,bodyId,scale,otherData.componets,eAnimationID.stand)

local baseData={
bodyId=bodyId,
stId=id,
stWidget=stWidget,
stIndex=0,
dzWidget=stWidget,
dzIndex=0,
stWinName=winName,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
stWidget:SetChildCanvasEx(baseData.stIndex,'',otherData.order)
end
self.uiDZDatas[id]={bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end

function uiAIManager:createEmptyObject(winName,fileName,stType,parent,pos,initData,otherData,callback)
otherData=otherData or{}
local id=_InstantiateManager.AddInstance(stType,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(0,pos)

local baseData={
stId=id,
stWidget=stWidget,
stIndex=0,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
stWidget:SetChildCanvasEx(baseData.stIndex,'',otherData.order)
end
self.uiDZDatas[id]={bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end

function uiAIManager:createALingShou(winName,fileName,lsId,parent,pos,initData,otherData,callback)
otherData=otherData or{}
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local lsdata=lingshouModel:getLingShouData(lsId)
stWidget:SetChildAnchoredPosition(0,pos)
local lscfg=lsdata.cfg
local scale=lscfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lscfg.model,true)
end
if otherData.scale then
scale=scale*otherData.scale
end
local modelId=lsdata.cfg.model
stWidget:SetChildUIModelShowTarget(0,modelId,scale,nil,eAnimationID.stand)
local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'headPos')or{0,0}
local headPosX=headPos[1]*scale*125
local headPosY=headPos[2]*scale*125
local offset={-headPosX*0.2,-headPosY*0.2}
initData.offset=offset

local baseData={
stId=id,
stWidget=stWidget,
stIndex=0,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
stWidget:SetChildCanvasEx(baseData.stIndex,'',otherData.order)
end
self.uiDZDatas[id]={bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end

function uiAIManager:createAquariunFish(winName,fileName,modelId,parent,pos,initData,otherData,callback)
otherData=otherData or{}
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFish,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(-1,pos)
local scale=1
stWidget:SetChildUIModelShowTarget(-1,modelId,scale,nil,eAnimationID.stand)
local baseData={
stId=id,
stWidget=stWidget,
stIndex=-1,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
stWidget:SetChildCanvasEx(baseData.stIndex,'',otherData.order)
end
self.uiDZDatas[id]={bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end

function uiAIManager:createNPC(winName,fileName,npcId,parent,pos,initData,otherData,callback)
otherData=otherData or{}
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(0,pos)

local modelParams=npcModel:getImageInfoOutSide(npcId,1)
local scale=isometricMapSystem:getModelScale(modelParams.body,true)
if otherData.scale then
scale=scale*otherData.scale
end
stWidget:SetChildActive(2,false)
stWidget:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,eAnimationID.stand)

local baseData={
npcId=npcId,
stId=id,
stWidget=stWidget,
stIndex=0,
stWinName=winName,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
stWidget:SetChildCanvasEx(baseData.stIndex,'',otherData.order)
end
self.uiDZDatas[id]={bt=bt,data=otherData,winName=winName}
self.loadingList[id]=nil
callback(bt)
end)
self.loadingList[id]={winName=winName}
return id
end
local _funcDoResult={
[1]=function(resultData)
local disciplename=resultData[1]
local loyaltyChange=resultData[2]
systemZongMenController:showOutgoerLoyaltyNotify(disciplename,loyaltyChange)
end,
[2]=function(resultData)
local result=resultData[1]
local zmName=resultData[2]
local disciplename=resultData[3]
local loyaltyChange=resultData[4]
local renownChange=resultData[5]
if result==true then
UIManager.info("弟子策反成功")
local mesgContent=cfgHelper.getlang("systemzongmen_incite_success")
local mesg=FMT.fmt(mesgContent,disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
else
UIManager.info("弟子策反失败")
local mesgContent=cfgHelper.getlang("systemzongmen_incite_failure")
local mesg=FMT.fmt(mesgContent,disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end
systemZongMenController:showOutgoerLoyaltyNotify(disciplename,loyaltyChange)
systemZongMenController:showMoneyNotify(zmName,systemZongMenInfoMoneyType.eShengWang,renownChange)
end,
[3]=function(resultData)
local result=resultData[1]
local zmName=resultData[2]
local disciplename=resultData[3]
local renownChange=resultData[4]
if result==0 then
local mesgContent=cfgHelper.getlang("systemzongmen_arrest_success")
local mesg=FMT.fmt(mesgContent,disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
UIManager.info("弟子抓捕成功")
else
local langKey=result==1 and"systemzongmen_arrest_failure_noexposure"or"systemzongmen_arrest_failure_exposure"
local mesgContent=cfgHelper.getlang(langKey)
local mesg=FMT.fmt(mesgContent,zmName,disciplename)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
UIManager.info("弟子抓捕失败")
end
systemZongMenController:showMoneyNotify(zmName,systemZongMenInfoMoneyType.eShengWang,renownChange)
end,
}

local _StopEffect=CS.GameInterface.StopEffect







local _sceneInfo=nil
local _stationSpacing=2
local _otherPositionOffset={
Vector3.zero,Vector3.back*3,Vector3.forward*3,
}

function systemZongMenController:createOutgoerEntity(data)
local serial=data.serial
local infoData=systemZongMenModel:getInfoData(serial)
if infoData==nil or not systemZongMenModel:checkFightFlagOutgoerShow(infoData.flag)then
return
end

local guid=data.discipleguid
local unitKey=systemZongMenModel:convertOutgoerUnitKey(guid)
local position=data.position
local luaData={eWorldUnitTpye.SYSTEMZM_OUTGOER,guid}

local imageInfo=UIDiscipleModel.calculationDiscipleImage(data.discipledata,data.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local weaponItemID=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
local weaponItemCfg=itemsConfig.getConfig(weaponItemID)
local weaponID=weaponItemCfg.imageID or 0
table_insert(modelParams.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))

local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelParams.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4
scale=scale*worldModel:getDragonbone_ScaleEx(eWorldUnitTpye.SYSTEMZM_OUTGOER)
local mSetting=CS.WorldEntitySetting.New(
mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value")),
height*scale,nil,
modelParams.body,modelParams.componets,
"Entity",scale,Vector3.zero)
local hudid=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"outgoerHUD")
local hSettings=worldModel:getHUDSetting(hudid)
worldController:pushUnit(unitKey,position,luaData,mSetting,hSettings,nil,true)
worldController:setUnitFlipX(unitKey,data.flip)
end

function systemZongMenController:deleteOutgoerEntity(guid)
local unitKey=systemZongMenModel:convertOutgoerUnitKey(guid)
worldController:popUnit(unitKey)
end

function systemZongMenController:createWorldOutgoerEntity(world)
local list=systemZongMenModel:getAllOutgoerData()
for i,v in pairs(list)do
if v.world==world then
self:createOutgoerEntity(v)
end
end
end

function systemZongMenController:deleteWorldOutgoerEntity(world)
local list=systemZongMenModel:getAllOutgoerData()
for i,v in pairs(list)do
if v.world==world then
self:deleteOutgoerEntity(v.discipleguid)
end
end
end

function systemZongMenController:createBlockOutgoerEntity(world,block)
local list=systemZongMenModel:getAllOutgoerData()
for i,v in pairs(list)do
if v.world==world and v.block==block then
self:createOutgoerEntity(v)
end
end
end

function systemZongMenController:deleteBlockOutgoerEntity(world,block)
local list=systemZongMenModel:getAllOutgoerData()
for i,v in pairs(list)do
if v.world==world and v.block==block then
self:deleteOutgoerEntity(v.discipleguid)
end
end
end

function systemZongMenController:enterOutgoerScene(guid,height)

if self:isLoadingOutgoerStage()then
return
end

local outgoer=systemZongMenModel:getOutgoerData(guid)

if not outgoer then
return
end


self:req_outgoer_dataInfo(outgoer.serial,outgoer.discipleguid)

if _sceneInfo then
if mathHelper.compareInt64(_sceneInfo.outgoer.data.discipleguid,guid)then
self:showInteractWin()
else

self:changeOutgoerStage(outgoer)
end
return
end

self:loadOutgoerStage(outgoer,height,true)
end

function systemZongMenController:getOutgoerSceneInfo()
return _sceneInfo
end

function systemZongMenController:getOutgoerSceneInfo_OutgoerData()
return _sceneInfo and _sceneInfo.outgoer.data or nil
end

function systemZongMenController:isSameOutgoerSceneInfo_OutgoerData(serial,discipleguid)
local outgoer=self:getOutgoerSceneInfo_OutgoerData()
if outgoer then
return mathHelper.compareInt64(outgoer.serial,serial)and mathHelper.compareInt64(outgoer.discipleguid,discipleguid)
end
return false
end

function systemZongMenController:getOutgoerSceneInfo_VisitorData()
return _sceneInfo and _sceneInfo.visitor.data or nil
end

function systemZongMenController:isLoadingOutgoerStage()
return _sceneInfo~=nil and(not _sceneInfo.stage.init or not _sceneInfo.outgoer.init or not _sceneInfo.visitor.init)
end

function systemZongMenController:loadOutgoerStage(outgoer,height,smoke)

local other={height=height,smoke=smoke,}
_sceneInfo={}
_sceneInfo.other=other
_sceneInfo.show={}
_sceneInfo.animation=nil

local checkStage=false
local stage=fightStage:create(screenStageType.interactSystemZongMenOutgoer,function()
if checkStage then return end
checkStage=true
if _sceneInfo.stage then
_sceneInfo.stage.init=checkStage
end
local outgoerInfo=_sceneInfo.outgoer
local visitorInfo=_sceneInfo.visitor
if outgoerInfo and outgoerInfo.init and visitorInfo and visitorInfo.init then
self:afterLoadedOutgoerStage()
end
end,nil,nil,nil,true,function()
systemZongMenController:dieOffOutgoerStage()
end)
_sceneInfo.stage={stage=stage,init=checkStage}

local imageInfo=UIDiscipleModel.calculationDiscipleImage(outgoer.discipledata,outgoer.discipleimage)
local oModel=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
local weaponItemID=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
local weaponItemCfg=itemsConfig.getConfig(weaponItemID)
local weaponID=weaponItemCfg.imageID or 0
table_insert(oModel.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
local checkOutgoer=false
local oIndex,oEntity=stage:addEntityEx(outgoer.position,oModel.body,oModel.componets,1,not outgoer.flip,function()
if checkOutgoer then return end
checkOutgoer=true
if _sceneInfo.outgoer then
_sceneInfo.outgoer.init=checkOutgoer
end
local stageInfo=_sceneInfo.stage
local visitorInfo=_sceneInfo.visitor
if stageInfo and stageInfo.init and visitorInfo and visitorInfo.init then
self:afterLoadedOutgoerStage()
end
end)
oEntity:setVisible(false)

_sceneInfo.outgoer={index=oIndex,entity=oEntity,data=outgoer,init=checkOutgoer}

local disciple=npcModel:getInteractDZ()

local vModel=UIDiscipleModel:getDiscipleOutsideModelInfo(disciple,true,1)
local offset=outgoer.flip and Vector3.left or Vector3.right
local checkVistor=false
local vIndex,vEntity=stage:addEntityEx(outgoer.position+offset*_stationSpacing,vModel.body,vModel.componets,1,outgoer.flip,function()
if checkVistor then return end
checkVistor=true
if _sceneInfo.visitor then
_sceneInfo.visitor.init=checkVistor
end
local stageInfo=_sceneInfo.stage
local outgoerInfo=_sceneInfo.outgoer
if stageInfo and stageInfo.init and outgoerInfo and outgoerInfo.init then
self:afterLoadedOutgoerStage()
end
end)
vEntity:setVisible(false)

_sceneInfo.visitor={index=vIndex,entity=vEntity,data=UIDiscipleModel:getDiscipleData(disciple),init=checkVistor}
end

function systemZongMenController:showInteractWin()
if not UIManager:isActive('UISystemZongMenOutgoerInteractWin')then
worldController:changeRightView('UISystemZongMenOutgoerInteractWin')
else
UIManager:invokeUIMethod('UISystemZongMenOutgoerInteractWin','onShow')
end
end

function systemZongMenController:changeOutgoerStage(outgoer)
self:checkFuncDoResult()
self:clearOutgoerShow()
self:clearVisitorShow()
self:clearAnimationData()
self:setOutgoerSceneDoing()

_sceneInfo.outgoer.data=outgoer
local imageInfo=UIDiscipleModel.calculationDiscipleImage(outgoer.discipledata,outgoer.discipleimage)
local oModel=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
local weaponItemID=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"syssectWeapon")
local weaponItemCfg=itemsConfig.getConfig(weaponItemID)
local weaponID=weaponItemCfg.imageID or 0
table_insert(oModel.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
_sceneInfo.outgoer.entity:changeBody(oModel.body,oModel.componets,1)
_sceneInfo.outgoer.entity:setVisible(false)
_sceneInfo.outgoer.entity:setPosition(outgoer.position)
_sceneInfo.outgoer.entity:flipX(not outgoer.flip)

local discipleGuid=npcModel:getInteractDZ()
_sceneInfo.visitor.data=UIDiscipleModel:getDiscipleData(discipleGuid)
local vModel=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuid,true,1)
local offset=outgoer.flip and Vector3.left or Vector3.right
_sceneInfo.visitor.entity:changeBody(vModel.body,vModel.componets,1)
_sceneInfo.visitor.entity:setVisible(false)
_sceneInfo.visitor.entity:setPosition(outgoer.position+offset*_stationSpacing)
_sceneInfo.visitor.entity:flipX(outgoer.flip)

self:afterLoadedOutgoerStage()
end

function systemZongMenController:afterLoadedOutgoerStage()
local outgoer=_sceneInfo.outgoer.data
local offset=outgoer.flip and Vector3.left or Vector3.right
local delayHandle=function()
if _sceneInfo==nil then return end

self:showMainSceneWin(false)

_sceneInfo.outgoer.entity:setVisible(true)
local vEntity=_sceneInfo.visitor.entity

local showFunc=function()
if _sceneInfo==nil then return end
vEntity:setVisible(true)
end

if _sceneInfo.other.smoke then
vEntity:playEffect(worldDispatchFactory.fadeEffect,Vector3.zero,false,true)
timeEventController.delayDo(0.5,showFunc)
else
showFunc()
end

self:showInteractWin()
end
timeEventController.delayDo(0.1,delayHandle)
local minZoom=npcController:getWordLookNPCHigh(worldModel.world)
worldController:lookAtPosition_Duration(outgoer.position+offset*_stationSpacing/2,minZoom,0.6,nil,DG.Tweening.Ease.OutExpo)
end

function systemZongMenController:showMainSceneWin(show)
worldController:showObjectRoot(show)
worldController:displayHUD(show)
worldController:displaySymbol(show)
UIManager:invokeUIMethod('UIWorldWin','forceShowTeam',show)
end

function systemZongMenController:unloadOutgoerStage()
if _sceneInfo then

self:checkFuncDoResult()
self:clearOutgoerShow()
self:clearVisitorShow()
self:clearAnimationData()
_sceneInfo.stage.stage:close()
systemZongMenModel:clearOutgoerFuncData()
end
end

function systemZongMenController:dieOffOutgoerStage()
if _sceneInfo then

self:checkFuncDoResult()
systemZongMenModel:clearOutgoerFuncData()
self:clearSceneInfo()
end
end

function systemZongMenController:clearOutgoerShow()
if _sceneInfo.outgoer.effect then
for i,v in ipairs(_sceneInfo.outgoer.effect)do
_StopEffect(v)
end
_sceneInfo.outgoer.effect={}
end
if _sceneInfo.outgoer.emotObj then
_sceneInfo.outgoer.entity:stopText(_sceneInfo.outgoer.emotObj)
_sceneInfo.outgoer.emotObj=nil
end
if _sceneInfo.outgoer.emot then
_sceneInfo.outgoer.emot:cancel()
_sceneInfo.outgoer.emot=nil
end
if _sceneInfo.outgoer.expression then
_sceneInfo.outgoer.entity:setExpression(0)
_sceneInfo.outgoer.expression:cancel()
_sceneInfo.outgoer.expression=nil
end

end

function systemZongMenController:clearVisitorShow()
if _sceneInfo.visitor.effect then
for i,v in ipairs(_sceneInfo.visitor.effect)do
_StopEffect(v)
end
_sceneInfo.visitor.effect={}
end
if _sceneInfo.visitor.emotObj then
_sceneInfo.visitor.entity:stopText(_sceneInfo.visitor.emotObj)
_sceneInfo.visitor.emotObj=nil
end
if _sceneInfo.visitor.emot then
_sceneInfo.visitor.emot:cancel()
_sceneInfo.visitor.emot=nil
end
if _sceneInfo.visitor.expression then
_sceneInfo.visitor.entity:setExpression(0)
_sceneInfo.visitor.expression=nil
end

end

function systemZongMenController:exitOutgoerScene(returnHeight)
if not _sceneInfo then return end

if returnHeight and worldController:isInWorld()then
local cameraPos=self:getCameraLookAt()
local range=worldController:getCameraZoomRange()
local height=Mathf.Clamp(_sceneInfo.other.height,range[1],range[2])
worldController:lookAtPosition_Duration(cameraPos,height,0.6,nil,DG.Tweening.Ease.InQuart)
end
_sceneInfo.exiting=true
worldController:resetRightView()
end

function systemZongMenController:getCameraLookAt()
if _sceneInfo then
local outgoer=_sceneInfo.outgoer.data
local offset=outgoer.flip and Vector3.left or Vector3.right
return outgoer.position+offset*_stationSpacing/2
end
end

function systemZongMenController:closeOutgoerScene()
if _sceneInfo then
local normal=_sceneInfo.exiting
local cameraPos=self:getCameraLookAt()
local height=_sceneInfo.other.height

self:unloadOutgoerStage()
self:showMainSceneWin(true)
self:clearSceneInfo()

if not normal and cameraPos and worldController:isInWorld()then
local range=worldController:getCameraZoomRange()
height=Mathf.Clamp(height,range[1],range[2])
worldController:resetRightView()
worldController:lookAtPosition(cameraPos,height,true)
end
end
end

function systemZongMenController:clearSceneInfo()
if self:haveOutgoerSceneDoResult()then
worldController:resumeCameraControl()
end
_sceneInfo=nil
end

function systemZongMenController:changeOutgoerSceneVisitor(discipleGuid)
if not _sceneInfo then return end
if _sceneInfo.visitor then
_sceneInfo.visitor.data=UIDiscipleModel:getDiscipleData(discipleGuid)
local vModel=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuid,true,1)
_sceneInfo.visitor.entity:changeBody(vModel.body,vModel.componets,1)
_sceneInfo.visitor.entity:playEffect(worldDispatchFactory.fadeEffect,Vector3.zero,false,true)
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerSceneChangeVisitor,discipleGuid)
end
end

function systemZongMenController:setOutgoerSceneEntity_PlayEffect(isOutgoer,effect,keep,hideSelf,offset)
if not _sceneInfo then return end
local info=isOutgoer and _sceneInfo.outgoer or _sceneInfo.visitor
local effectHandle=info.entity:playEffect(effect,offset or Vector3.zero,false,true)
if keep then
if not info.effect then
info.effect={}
end
table.insert(info.effect,effectHandle)
end
if hideSelf then
info.entity:setVisible(false)
end
end

function systemZongMenController:setOutgoerSceneEntity_StopAllEffect(isOutgoer)
if not _sceneInfo then return end
local info=isOutgoer and _sceneInfo.outgoer or _sceneInfo.visitor
for i,v in ipairs(info.effect or{})do
_StopEffect(v)
end
info.effect={}
info.entity:setVisible(true)
end

function systemZongMenController:setOutgoerSceneEntity_Emot(isOutgoer,emot,time,callback)
if not _sceneInfo then return end
local info=isOutgoer and _sceneInfo.outgoer or _sceneInfo.visitor
info.emotObj=info.entity:flowText(flowObjTypo.biaoQing,{strPara=nil,nunPara=emot,stayTime=time or 3})
local func=function()
if not _sceneInfo then return end
if info.emotObj then
info.entity:stopText(info.emotObj)
info.emotObj=nil
info.emot=nil
end
if callback then
callback()
end
end
info.emot=timeEventController.delayDo(time or 3,func)
end

function systemZongMenController:setOutgoerSceneEntity_Expression(isOutgoer,expression,time,callback)
if not _sceneInfo then return end
local info=isOutgoer and _sceneInfo.outgoer or _sceneInfo.visitor
info.entity:setExpression(expression)
local func=function()
if not _sceneInfo then return end
if info.expression then
info.entity:setExpression(0)
info.expression=nil
end
if callback then
callback()
end
end
info.expression=timeEventController.delayDo(time or 3,func)
end

function systemZongMenController:setOutgoerSceneAnimationEntity_Emot(emot,time,callback)
if not _sceneInfo then return end

for i,v in ipairs(_sceneInfo.animation.objects)do
v.emotObj=v.entity:flowText(flowObjTypo.biaoQing,{strPara=nil,nunPara=emot,stayTime=time or 3})
end
local func=function()
if not _sceneInfo then return end
for i,v in ipairs(_sceneInfo.animation.objects)do
v.entity:stopText(v.emotObj)
v.emotObj=nil
end
if _sceneInfo.animation.emot then
_sceneInfo.animation.emot=nil
end
if callback then
callback()
end
end
_sceneInfo.animation.emot=timeEventController.delayDo(time or 3,func)
end

function systemZongMenController:setOutgoerSceneAnimationEntity_Expression(expression,time,callback)
if not _sceneInfo then return end

for i,v in ipairs(_sceneInfo.animation.objects)do
v.entity:setExpression(expression)
end
local func=function()
if not _sceneInfo then return end
for i,v in ipairs(_sceneInfo.animation.objects)do
v.entity:setExpression(0)
end
_sceneInfo.animation.expression=nil
if callback then
callback()
end
end
_sceneInfo.animation.expression=timeEventController.delayDo(time or 3,func)
end

function systemZongMenController:setOutgoerSceneEntity_ChangeBody(isOutgoer,body,components,scale)
if not _sceneInfo then return end
local info=isOutgoer and _sceneInfo.outgoer or _sceneInfo.visitor
info.entity:changeBody(body,components,scale or 1)
end

function systemZongMenController:showOutgoerSceneArrestAnimation(serial,target,guids,result)
if not _sceneInfo then return end
if not guids or#guids<=0 then return end
if not systemZongMenModel:isSameOutgoerFuncData(serial,target)then return end

_sceneInfo.animation={}
_sceneInfo.animation.objects={}
_sceneInfo.animation.timer=nil
_sceneInfo.animation.emot=nil
_sceneInfo.animation.expression=nil
local outgoer=_sceneInfo.outgoer.data
local stage=_sceneInfo.stage.stage
local zmData=systemZongMenModel:getInfoData(serial)
local zmName=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,zmData.id)
local zbCfg=cfgHelper.get1(cfg_syssectzbconfig_get,zmCfg.zbid)
_sceneInfo.visitor.entity:setVisible(false)
local offset=outgoer.flip and Vector3.left or Vector3.right
for index,discipleGuid in ipairs(guids)do
local vModel=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuid,true,1)
local vPosition=outgoer.position+_otherPositionOffset[index]+offset*_stationSpacing/(index>1 and 2 or 1)
local vIndex,vEntity=stage:addEntityEx(vPosition,vModel.body,vModel.componets,1,outgoer.flip,nil)
vEntity:setVisible(false)
_sceneInfo.animation.objects[index]={
index=vIndex,
entity=vEntity,
effect={},
emotObj=nil,
}
end

local stepFlow={}
local stepIdx=0
local step0=function()
if _sceneInfo==nil then return end
_sceneInfo.animation.timer=nil
stepIdx=stepIdx+1
local tempStep=stepFlow[stepIdx]
if tempStep then
if not systemZongMenModel:isSameOutgoerFuncData(serial,target)then return end
tempStep()
end
end

local step1=function()
worldController:resetLeftView()
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","doPreLeaveAnim",step0)
end

local step2=function()
for i,v in ipairs(_sceneInfo.animation.objects)do
v.entity:setVisible(true)
v.entity:playEffect(worldDispatchFactory.fadeEffect,Vector3.zero,false,true)
end
_sceneInfo.animation.timer=timeEventController.delayDo(0.5,step0)
end

local step3=function()
self:setOutgoerSceneEntity_Expression(true,1,1,step0)
self:setOutgoerSceneEntity_Emot(true,13,1,nil)
self:setOutgoerSceneAnimationEntity_Expression(8,1,nil)
end

local step4=function()
for index,entityInfo in pairs(_sceneInfo.animation.objects)do
entityInfo.entity:runAnimator(eAnimationID.run)
entityInfo.entity:moveTo(outgoer.position,true,0.5,1,function()
entityInfo.entity:setVisible(false)
entityInfo.entity:runAnimator(eAnimationID.stand)
end)
end
_sceneInfo.animation.timer=timeEventController.delayDo(0.5,step0)
end

local step5=function()
self:setOutgoerSceneEntity_PlayEffect(true,worldDispatchFactory.fightEffect,true,true)
_sceneInfo.animation.timer=timeEventController.delayDo(2,step0)
end

local step6=function()
self:setOutgoerSceneEntity_ChangeBody(true,3050,{},0.4)
self:setOutgoerSceneEntity_StopAllEffect(true)
for index,entityInfo in pairs(_sceneInfo.animation.objects)do
local position=outgoer.position+_otherPositionOffset[index]+offset*_stationSpacing/(index>1 and 2 or 1)
entityInfo.entity:setVisible(true)
entityInfo.entity:flipX(not outgoer.flip)
entityInfo.entity:runAnimator(eAnimationID.run)
entityInfo.entity:moveTo(position,false,0.5,1,function()
entityInfo.entity:flipX(outgoer.flip)
entityInfo.entity:runAnimator(eAnimationID.stand)
end)
end
_sceneInfo.animation.timer=timeEventController.delayDo(0.5,step0)
end

local step7=function()
self:setOutgoerSceneAnimationEntity_Expression(8,2,nil)
local word=zbCfg.succsay[math.random(1,#zbCfg.succsay)]
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showTalk",outgoer.flip,word,2,step0)
end

local step8=function()
local params={
list={{discipleguid=target}},
closeCallback=function()
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","closeWindow","UICaptureWin")
step0()
end
}
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showWindow","UICaptureWin",params)
end

local step9=function()
self:setOutgoerSceneEntity_StopAllEffect(true)
for index,entityInfo in pairs(_sceneInfo.animation.objects)do
local position=outgoer.position+_otherPositionOffset[index]+offset*_stationSpacing/(index>1 and 2 or 1)
entityInfo.entity:setVisible(true)
entityInfo.entity:flipX(not outgoer.flip)
entityInfo.entity:runAnimator(eAnimationID.run)
entityInfo.entity:moveTo(position,true,0.5,1,function()
entityInfo.entity:flipX(outgoer.flip)
entityInfo.entity:runAnimator(eAnimationID.stand)
end)
end
_sceneInfo.animation.timer=timeEventController.delayDo(0.5,step0)
end

local step10=function()
self:setOutgoerSceneAnimationEntity_Emot(11,2,nil)
local word=zbCfg.failsay[math.random(1,#zbCfg.failsay)]
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showTalk",outgoer.flip,word,2,step0)
end

local step11=function()
if result~=0 then
UIManager.info("抓捕失败，目标已返回宗门")
end
self:setOutgoerSceneDoing()
self:exitOutgoerScene(true)

if result==0 then
local mesgContent=cfgHelper.getlang("systemzongmen_arrest_success")
local mesg=FMT.fmt(mesgContent,outgoer.disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
else
local langKey=result==1 and"systemzongmen_arrest_failure_noexposure"or"systemzongmen_arrest_failure_exposure"
local mesgContent=cfgHelper.getlang(langKey)
local mesg=FMT.fmt(mesgContent,zmName,outgoer.disciplename)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end
end

table.insert(stepFlow,step1)
table.insert(stepFlow,step2)
table.insert(stepFlow,step3)
table.insert(stepFlow,step4)
table.insert(stepFlow,step5)
if result==0 then
table.insert(stepFlow,step6)
table.insert(stepFlow,step7)
table.insert(stepFlow,step8)
else
table.insert(stepFlow,step9)
table.insert(stepFlow,step10)
end
table.insert(stepFlow,step11)

step0()
end

function systemZongMenController:clearAnimationData()
if _sceneInfo.animation==nil then return end
local animation=_sceneInfo.animation
for i,v in pairs(animation.objects)do
for j,w in ipairs(v.effect)do
_StopEffect(w)
end
if v.emotObj then
v.entity:stopText(v.emotObj)
end
v.entity:setExpression(0)
_sceneInfo.stage.stage:removeEntity(v.index)
end
if animation.timer then
animation.timer:cancel()
end
if animation.emot then
animation.emot:cancel()
end
if animation.expression then
animation.expression:cancel()
end

_sceneInfo.animation=nil
end

function systemZongMenController:setOutgoerSceneDoing(buttonIdx)

if _sceneInfo then
_sceneInfo.other.doing=buttonIdx
if _sceneInfo.other.doResult~=nil then
worldController:resumeCameraControl()
end
_sceneInfo.other.doResult=nil
if buttonIdx==nil then
xiantuchengjiuController:checkShowTaskTips()
UIManager:invokeUIMethod("UISystemZongMenListWin","refreshViewImp")
end
end
end

function systemZongMenController:isOutgoerSceneDoing()
if _sceneInfo then
return _sceneInfo.other.doing~=nil
end
return false
end

function systemZongMenController:setOutgoerSceneDoResult(result)

if _sceneInfo then
_sceneInfo.other.doResult=result
if result~=nil then
worldController:stopCameraControl()
else
worldController:resumeCameraControl()
end
end
end

function systemZongMenController:haveOutgoerSceneDoResult()
if _sceneInfo then
return _sceneInfo.other.doResult~=nil
end
return false
end

function systemZongMenController:checkFuncDoResult()
if _sceneInfo then
local otherData=_sceneInfo.other

if otherData.doing then
_funcDoResult[otherData.doing](otherData.doResult)
end
end
end

function systemZongMenController:isSceneBelongSystemZongMen(serial)
if _sceneInfo and _sceneInfo.outgoer and _sceneInfo.outgoer.data then
local outgoer=_sceneInfo.outgoer.data
return mathHelper.compareInt64(serial,outgoer.serial)
end
return false
end

function systemZongMenController:checkCloseSceneWhenAnimationFinish(serial)
if not systemZongMenModel:checkFightFlagOutgoerShowEx(serial)then
systemZongMenController:exitOutgoerScene(true)
UIManager.info("宗门情况有变，外出弟子已迅速返回")
end
end

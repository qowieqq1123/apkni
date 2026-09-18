




newbieControl=gameState.addListener({})

local _data={}

local _topLayer='UITopModel'
local _topOrder=2001
local _delayTime=0.03
local _dirtyTable=nil
local _dirtyTimer=nil
local _closeNames={}



function newbieControl:onAppStart()

notifySystem:listenNotify(notifyConfig.onShowUI,self.onShowUI)
end

function newbieControl:onEnterState()
_data={}
newbieModel.initData()
_closeNames={}
end

function newbieControl:onLeaveState()
newbieControl.disableBloker()
newbieControl.interruptNewbie(false)
newbieControl.stopDirtyTimer()
_data={}
newbieModel.initData()
_dirtyTable=nil
_closeNames={}
end

function newbieControl:onLostConnection()
newbieControl.disableBloker()
newbieControl.interruptNewbie(false)
newbieControl.stopDirtyTimer()
end

function newbieControl:onEnterScene(sceneType,first,firstScene)
if firstScene then
loginControl:reportEnterMainScene()
end
end

function newbieControl:onProtocolReq()
newbieModel.initConfig()
end


function newbieControl.onShowUI(name,flag)
if flag then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eOpenWindow,name)
newbieTriggerControl.startBenmingNewbie(name)
end
end


local _update=function(delayTime)
if _data.runManagerGroup then
local runManagerGroup=_data.runManagerGroup
local state=runManagerGroup:update(delayTime)
if state==NEW_BIE_STATE.eErr then
newbieControl.interrupt(runManagerGroup.newbieId,runManagerGroup.stepIdx)
elseif state==NEW_BIE_STATE.eOk or state==NEW_BIE_STATE.eSkip then
newbieControl.finish(runManagerGroup.newbieId)
end
end
end

local _dirtyUpdate=function(delayTime)
if _dirtyTable and#_dirtyTable>0 and newbieControl.canStart()and not newbieControl.isInNewbie()then
for i,v in ipairs(_dirtyTable)do
if v and type(v)=='table'then
newbieControl.startNewbie(unpack(v))
else
loggerUtil.logErrFMT('dirtyUpdate处理参数有问题：{0}',tostring(v))
end
end
_dirtyTable=nil
newbieControl.stopDirtyTimer()
end
end


function newbieControl.startAction(newbieId)
newbieControl.stopAction()
newbieControl.initRunAction(newbieId)
end

function newbieControl.stopAction()
if _data.runManagerGroup~=nil then
_data.runManagerGroup:leave(true)
end
if _data.runManagerGroup~=nil then
_data.runManagerGroup:onRelease()
end
_data.runManagerGroup=nil
newbieManager.stopMask()
newbieControl.closeLastWindow()
end

function newbieControl.initRunAction(newbieId)
_data.runManagerGroup=newbieManagerGroup.create(newbieId)
local runManagerGroup=_data.runManagerGroup
local state=runManagerGroup:start()
if state==NEW_BIE_STATE.eErr then
newbieControl.interrupt(runManagerGroup.newbieId,runManagerGroup.stepIdx)
elseif state==NEW_BIE_STATE.eOk or state==NEW_BIE_STATE.eSkip then
newbieControl.finish(runManagerGroup.newbieId)
elseif state==NEW_BIE_STATE.eRun then
newbieControl.startTimer()
end
end

function newbieControl.enableUIComponent(cmpId)
if _data.runManagerGroup then
_data.runManagerGroup:enableUIComponent(cmpId)
end
end

function newbieControl.disableUIComponent(cmpId)
if _data.runManagerGroup then
_data.runManagerGroup:disableUIComponent(cmpId)
end
end

function newbieControl.removeEntity(guid)
if _data.runManagerGroup then
_data.runManagerGroup:removeEntity(guid)
end
end

function newbieControl.tryClickEntity(screenPos)
if _data.newbieInfo and _data.newbieInfo.newbieId and _data.newbieInfo.stepIdx then
newbieEntityControl.tryClickEntity(screenPos)
end
end


function newbieControl.clearCache(typo,args)
if args==nil then
loggerUtil.logErrFMT('clearCache 传参错误 :{0}',tostring(typo))
return
end
if _dirtyTable==nil then return end
local len=#_dirtyTable
if len>0 then
for i=len,1,-1 do
local v=_dirtyTable[i]
local flag=typo==v[1]
if flag then
for ii,vv in ipairs(v)do
if ii>1 and vv~=args[ii-1]then
flag=false
break
end
end
end
if flag then
table.remove(_dirtyTable,i)
end
end
end
if#_dirtyTable<=0 then
newbieControl.stopDirtyTimer()
end
end

local tryMainStart=function(config,isRepeat)
if isRepeat==nil then isRepeat=false end


if not config then

return false
end
local newbieId=config.id


if newbieModel.isFinish(newbieId)and not isRepeat then
newbieControl.log(FMT.fmt('newbie_指引{0}已完成，不能再次进行:',newbieId))
return false
end
newbieControl.tryFinish()

if newbieControl.isInNewbie()then
local isMain=_data.newbieInfo.isMain
local doingid=_data.newbieInfo.newbieId
if not isMain or newbieId>doingid then
newbieControl.log(FMT.fmt('指引{0}直接完成,开始指引{1}',doingid,newbieId))
newbieControl.interruptNewbie()
else
newbieControl.log(FMT.fmt('指引{0}优先级不足，继续进行当前指引{1}',newbieId,doingid))
return false
end
end

local mActions=newbieConfig.getNewbieConfig(newbieId).mActions
if mActions==nil or#mActions==0 then
return false
end

_data.newbieInfo={}
_data.newbieInfo.newbieId=newbieId
_data.newbieInfo.stepIdx=1
newbieControl.log(FMT.fmt('newbie_指引{0}正式开始:',newbieId))

newbieControl.reqPrize(newbieId,1)
newbieControl.startAction(newbieId)
notifySystem:postNotify(notifyConfig.inNewbie,newbieId,true)
return true
end


local tryBranchStart=function(config,isRepeat)
if isRepeat==nil then isRepeat=false end


if not config or config.active==false then return false end
local newbieId=config.id


if newbieModel.isFinish(newbieId)and not isRepeat then
newbieControl.log(FMT.fmt('newbie_支线指引{0}已经完成:',newbieId))
return false
end
newbieControl.tryFinish()

if newbieControl.isInNewbie()then
local isMain=_data.newbieInfo.isMain
local doingid=_data.newbieInfo.newbieId
if isMain then
newbieControl.log(FMT.fmt('指引{0}优先级不足，继续进行当前指引{1}',newbieId,doingid))
return false
else
local sort=config.sort
local cfg=newbieConfig.getNewbieConfig(doingid)
if sort and(cfg.sort==nil or sort>cfg.sort)then
newbieControl.log(FMT.fmt('指引{0}直接完成,开始指引{1}',doingid,newbieId))
newbieControl.interruptNewbie()
else
newbieControl.log(FMT.fmt('指引{0}优先级不足，继续进行当前指引{1}',newbieId,doingid))
return false
end
end
end

local mActions=config.mActions
if mActions==nil or#mActions==0 then
return false
end

_data.newbieInfo={}
_data.newbieInfo.newbieId=newbieId
_data.newbieInfo.stepIdx=1
newbieControl.log(FMT.fmt('newbie_指引{0}正式开始:',newbieId))

newbieControl.reqPrize(newbieId,1)
newbieControl.startAction(newbieId)
notifySystem:postNotify(notifyConfig.inNewbie,newbieId,true)
return true
end

function newbieControl.tryStart(lookupCfg,isRepeat)
if lookupCfg==nil then return false end
local newbieId=lookupCfg.id
return newbieControl.tryStartByNewbieId(newbieId,isRepeat)
end


function newbieControl.tryStartByNewbieId(newbieId,isRepeat)





local cfg=newbieConfig.getNewbieConfig(newbieId)
if cfg==nil then return end
if newbieConfig.isBranchNewbieId(newbieId)then
return tryBranchStart(cfg,isRepeat)
else
return tryMainStart(cfg,isRepeat)
end
end

function newbieControl.hasCache()
return _dirtyTable~=nil
end





function newbieControl.canStart()
local showGame=sceneControl:isEnter()
local isRecv=newbieModel.isRecvData()
return showGame and isRecv
end

function newbieControl.checkStart(...)

local flag=newbieControl.canStart()
if not flag then
if _dirtyTable==nil then _dirtyTable={}end
_dirtyTable[#_dirtyTable+1]={...}
newbieControl.startDirtyTimer()
end
return flag
end

function newbieControl.checkLuaCondition(funcType)

return true
end


function newbieControl.tryFinish()
_update(0)
end

function newbieControl.reqPrize(newbieId,index)
local newbieCfg=newbieConfig.getNewbieConfig(newbieId)
if newbieCfg.reward and newbieCfg.reward[index]then
socketManager:send_254_75(newbieId,index)
end
end


function newbieControl.finish(newbieId)
newbieControl.onFinish(newbieId)
newbieControl.stopAction()
newbieControl.stopTimer()
newbieControl.doFinishNext(newbieId,true)
end

function newbieControl.interrupt(newbieId,stepIdx)
newbieControl.onInterrupt(newbieId,stepIdx)
newbieControl.stopAction()
newbieControl.stopTimer()
newbieControl.doFinishNext(newbieId,false)
end

function newbieControl.onInterrupt(newbieId,stepIdx)
loggerUtil.log(FMT.fmt('指引{0}第{1}中断',newbieId,stepIdx))
newbieControl.setFinish(newbieId,false)
end

function newbieControl.onFinish(newbieId)
loggerUtil.log(FMT.fmt('指引{0}完成 ',newbieId))
newbieControl.setFinish(newbieId,true)
end

function newbieControl.onStep(newbieId,stepIdx)
loggerUtil.log(FMT.fmt('指引{0}准备进行第{1}步',newbieId,stepIdx))
if newbieControl.isCurrentNewbie(newbieId)then
newbieControl.setNewbieStep(stepIdx)
end
newbieControl.closeLastWindow()
end

function newbieControl.onBind(newbieId,stepIdx,index,actionType)
newbieControl.log(FMT.fmt('指引{0}第{1}步第{2}序列已绑定控件：',newbieId,stepIdx,index))
end

function newbieControl.onFocus(newbieId,stepIdx,index)
newbieControl.log(FMT.fmt('指引{0}第{1}步第{2}序列 onFocus：',newbieId,stepIdx,index))
local actionid=newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
if actionid then
local conf=newbieConfig.getNewbieAction(actionid)
if conf.onFocus then
newbieForceHandle:triggerGetForce(conf.onFocus)
end
end
end

function newbieControl.lostFocus(newbieId,stepIdx,index)
newbieControl.log(FMT.fmt('指引{0}第{1}步第{2}序列 lostFocus：',newbieId,stepIdx,index))
local actionid=newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
if actionid then
local conf=newbieConfig.getNewbieAction(actionid)
if conf.onFocus then
newbieForceHandle:triggerLostForce(conf.onFocus)
end
end
end


function newbieControl.onClick(cmpId)
newbieControl.log('点击控件：',cmpId)
if _data.runManagerGroup then
_data.runManagerGroup:onClick(cmpId)
end
end

function newbieControl.onClickFinished(cmpId)
if _data.runManagerGroup then
_data.runManagerGroup:onClickFinished(cmpId)
end
end


function newbieControl.onRayHitEntity(guid)
if _data.runManagerGroup then
_data.runManagerGroup:onClickEntity(guid)
end
end


function newbieControl.forceStartNextStep()
if _data.runManagerGroup then
return _data.runManagerGroup:forceStartNextGroup()
end
return false
end




function newbieControl.setFinish(newbieId,finish)
if _data.newbieInfo==nil then return end
newbieManager.stopMask()
newbieControl.disableBloker()
newbieManager.setBlockAction(nil)
if _data.newbieInfo and _data.newbieInfo.newbieId==newbieId then
_data.newbieInfo=nil
newbieModel.setFinish(newbieId)
newbieEntityControl.invokeEntityAction()
notifySystem:postNotify(notifyConfig.inNewbie,newbieId,false)
else
loggerUtil.logErrFMT('当前失败的指引id:{0}和保存数据:{1}不符',newbieId,_data.newbieInfo and _data.newbieInfo.newbieId or'nil')
end
end


function newbieControl.interruptNewbie()
if _data.runManagerGroup then
local runManagerGroup=_data.runManagerGroup
newbieControl.log('跳过当前指引:',_data.runManagerGroup.newbieId)
newbieControl.onInterrupt(runManagerGroup.newbieId,runManagerGroup.stepIdx)
end
newbieControl.stopAction()
newbieControl.stopTimer()
end


function newbieControl.doFinishNext(newbieId,finish)
if gameState.isLeaveState()then
return
end

UIFullFightPrepareControl:setTopMask(false)


local newbieCfg=newbieConfig.getNewbieConfig(newbieId)
local finishPlot=newbieCfg.finishPlot
local nextNewbieId=newbieConfig.getNextNewbie(newbieId)
if finish and finishPlot then
gameplotController.activePlot(finishPlot)
if nextNewbieId then
loggerUtil.logErrFMT('指引{0}同时配置了完成剧情和下一个指引',newbieId)
end
elseif nextNewbieId then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eNextNewbie,nextNewbieId)
elseif newbieCfg.reward then
newbieControl.reqPrize(newbieId,2)
end
end





function newbieControl.setNewbieStep(stepIdx)
if _data.newbieInfo then
_data.newbieInfo.stepIdx=stepIdx
end
end
















function newbieControl.isInNewbie()
return _data.newbieInfo~=nil and _data.newbieInfo.newbieId~=nil
end

function newbieControl.isCurrentNewbie(newbieId)
local ret=_data.newbieInfo and _data.newbieInfo.newbieId==newbieId or false
if ret==false and _data.newbieInfo then
newbieControl.log('非当前指引：',_data.newbieInfo.newbieId,newbieId)
end
return ret
end

function newbieControl.isCurrentNewbieStep(newbieId,stepIdx)
local ret=_data.newbieInfo and _data.newbieInfo.newbieId==newbieId and _data.newbieInfo.stepIdx==stepIdx or false
if ret==false and _data.newbieInfo then
newbieControl.log('是否当前步骤：',_data.newbieInfo.newbieId,newbieId,stepIdx,_data.newbieInfo.stepIdx)
end
return ret
end

function newbieControl.getNewbieId()
if _data.newbieInfo then
return _data.newbieInfo.newbieId or 0
end
return 0
end

function newbieControl.getNewbieInfo()
return _data.newbieInfo
end




function newbieControl.setTopUI(newbieId,stepIdx,index,cmpId)
local actionid=newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
if actionid then
local conf=newbieConfig.getNewbieAction(actionid)
if conf and conf.light~=false then
if conf.threeUI==nil then
newbieManager.setSortLayer(cmpId,_topLayer,_topOrder)
else
local camera=newbieControl.getUITopCamera(conf.threeUI)
newbieManager.setUITransformTopWithCamera(cmpId,camera)
end
else
if conf==nil then
loggerUtil.logErrFMT('没有找到指引actionid={0}的配置',actionid)
end
end
else
loggerUtil.logErrFMT('没有找到当前指引id：{0}的mActions第{1}个配置',newbieId,stepIdx)
end
end

function newbieControl.resetTopUI(cmpId)

newbieManager.resetSortLayer(cmpId)

newbieManager.resetUITransformTop(cmpId)
end

function newbieControl.setTopEntity(newbieId,stepIdx,index,args)
local actionid=newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
if actionid then
local conf=newbieConfig.getNewbieAction(actionid)
if conf and conf.light~=false then
local guid=args.guid
local camera=args.camera

if guid and camera then
newbieManager.setEntityTransformTop(guid,camera)
end
end
else
loggerUtil.logErrFMT('没有找到当前指引id：{0}的mActions第{1}个配置',newbieId,stepIdx)
end
end

function newbieControl.getUITopCamera(threeUI)
if threeUI==1 then
return CS.CSGUIManager.Instance:GetSceneCanvasCamera()
end
end




function newbieControl.enableBloker()
_data.activeBlock=true
newbieManager.enableBloker()
end

function newbieControl.disableBloker()
_data.activeBlock=false
newbieManager.disableBloker()
end

function newbieControl.isBlockActive()
return _data.activeBlock or false
end


function newbieControl.addCloseWindow(name)

_closeNames[name]=true
end

function newbieControl.closeLastWindow()
for k,v in pairs(_closeNames)do

UIManager:closeWindow(k)
end
_closeNames={}
end





function newbieControl.newbieFunc()
xpcall(function()
_update(_delayTime)
end,function(err)
logErr(err)
end)
end

function newbieControl.newbieDirtyFunc()
xpcall(function()
_dirtyUpdate(_delayTime)
end,function(err)
logErr(err)
end)
end

function newbieControl.startTimer()
if _data.timer==nil then
_data.timer=FrameTimer.New(newbieControl.newbieFunc,0,-1)
_data.timer:Start()
end
end


function newbieControl.startDirtyTimer()
if _dirtyTimer==nil then
_dirtyTimer=FrameTimer.New(newbieControl.newbieDirtyFunc,0,-1)
_dirtyTimer:Start()
end
end

function newbieControl.stopTimer()
if _data.timer then
_data.timer:Stop()
end
_data.timer=nil
end

function newbieControl.stopDirtyTimer()
if _dirtyTimer then
_dirtyTimer:Stop()
end
_dirtyTimer=nil
end





function newbieControl.log(content,...)




end

function newbieControl.xlog(content,...)




end

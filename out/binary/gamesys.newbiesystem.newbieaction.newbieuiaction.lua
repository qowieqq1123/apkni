




newbieUIAction=simple_class(refObject)

local _outTime=20
local _raycast_OutTime=10
function newbieUIAction.create(...)
local object=refObject.get('newbieUIAction',...)
return object
end

function newbieUIAction:init(newbieId,actionid,stepIdx,index,actionType,group,args)
self.newbieId=newbieId
self.actionConfig=cfg_newbieaction_get(actionid)
self.readyTime=self.actionConfig.readyTime or 0
self.isFinish=self.actionConfig.isFinish or false
self.clickEvent=self.actionConfig.clickEvent~=false
self.stepIdx=stepIdx
self.actionid=actionid
self.index=index
self.autoClick=self.actionConfig.mAutoClick
self.autoClickStamp=nil
self.isFocus=false
self.state=NEW_BIE_STATE.eUnStart
self.focusStamp=nil
self.isBind=false
self.outTimeStamp=nil
self.actionType=actionType
self.group=group
self.cmpId=args[1]
self.hasFocus=false
self.runTime=nil
self.checkSkip=false
self.readyStamp=nil

pfCommonHelper.newbieUIActionPoint(actionid)
end

function newbieUIAction:onRelease()
if self.actionConfig.window then
local name=self.actionConfig.window[1]
local isClose=self.actionConfig.window[2]
if name and isClose~=0 then
newbieControl.addCloseWindow(name)

end
end
self.actionConfig=nil
self.cmpId=nil
self.state=NEW_BIE_STATE.eUnStart
self.isFocus=false
self.focusStamp=nil
self.stepIdx=0
self.autoClick=0
self.autoClickStamp=nil
self.newbieId=0
self.isBind=false
self.outTimeStamp=nil
self.actionType=nil
self.group=nil
self.actionid=nil
self.hasFocus=false
self.runTime=nil
self.checkSkip=false
self.readyTime=0
self.readyStamp=nil
end

function newbieUIAction:start()
if self.actionConfig==nil then
newbieControl.log(FMT.fmt('UI指引{0}当前步骤{1}没找到actionConfig配置，中断退出',self.newbieId,self.stepIdx))
self:doErr()
else
if self.readyTime>0 then
self.state=NEW_BIE_STATE.eReady
self.readyStamp=timeHelper.getServerLongTime()
else
self:enterStart()
end
end
return self.state
end

function newbieUIAction:enterStart()
newbieControl.log(FMT.fmt('第{0}步控件{1}进入指引:',self.stepIdx,self.cmpId))
if self.actionConfig.jump then
newbieControl.enableBloker()
jumpManager:jump(self.actionConfig.jump,nil,JUMP_BACK.eNoBack)
end
if self.actionConfig.window and self.actionConfig.window[1]then
local name=self.actionConfig.window[1]
newbieControl.enableBloker()
UIManager:showWindow(name)
end
self.state=NEW_BIE_STATE.eStart
end

function newbieUIAction:bindUIComponent(cmpId,flag)
if cmpId~=self.cmpId then return end
if flag then
if self:isStartState()and newbieManager.hasNewBieActiveComponent(cmpId)then
newbieControl.log(FMT.fmt('第{0}步控件{1}已绑定指引:',self.stepIdx,self.cmpId))
self.state=NEW_BIE_STATE.eRun
self.isBind=true
self.group:bindAction(self,true)
newbieControl.onBind(self.newbieId,self.stepIdx,self.index,self.actionType)
self:moveCameraPosition()
end
else
if self:isRunState()then
newbieControl.log(FMT.fmt('控件{1}隐藏或关闭，指引第{0}步中断:',self.stepIdx,self.cmpId))
self:doErr()
end
end
end

function newbieUIAction:update()
if self:isReadyState()then
local stamp=timeHelper.getServerLongTime()
local pass=stamp-self.readyStamp
if pass>self.readyTime then
self:enterStart()
end
elseif self:isStartState()then
self:bindUIComponent(self.cmpId,true)
if self:isStartState()then
local outTime=newbieControl.isBlockActive()and _raycast_OutTime or _outTime
local stamp=timeHelper.getServerLongTime()
if self.outTimeStamp==nil then self.outTimeStamp=stamp end
local pass=stamp-self.outTimeStamp
if pass>outTime then
loggerUtil.debugErrFMT(FMT.fmt('指引{0}无法找到第{1}步控件{2}，超时中断指引:',self.newbieId,self.stepIdx,self.cmpId))
self.outTimeStamp=nil
self:doErr()
end
end
elseif self:isRunState()then
local stamp=timeHelper.getServerLongTime()
if self.runTime==nil then
self.runTime=stamp
end


if self.runTime==nil then self.runTime=stamp end
local pass=stamp-self.runTime
if pass>0.5 and not self.checkSkip then
self.checkSkip=true
if self:skip()then
self.state=NEW_BIE_STATE.eSkip
newbieControl.log(FMT.cfmt(FONT_COLOR.eRedColor,'指引{0}当前步骤{1}经检测不可继续，直接跳过当前指引',self.newbieId,self.stepIdx))
return self.state
end
end

self.outTimeStamp=nil
if not self.isFocus then
if self.focusStamp==nil then self.focusStamp=stamp end
local pass=stamp-self.focusStamp
local focusDelay=self.actionConfig.mFocusDelay or 0
if pass>=focusDelay then
self.focusStamp=nil
self:focus()
end
elseif self.isFocus and self.autoClick>0 then
if self.autoClickStamp==nil then self.autoClickStamp=stamp end
local pass=stamp-self.autoClickStamp
if pass>self.autoClick then
self.autoClickStamp=nil
self:dofinish()
end
end
end
return self.state
end

function newbieUIAction:moveCameraPosition()
local actionConfig=self.actionConfig
if actionConfig.cameraPos then
newbieControl.enableBloker()
local cameraPos=actionConfig.cameraPos
newbieEntityControl.moveToPosition(cameraPos[1],cameraPos[2],cameraPos[3]or 0.6,nil,nil)
end
end

function newbieUIAction:skip()
if newbieSkipFuncHelper.checkSkip(self.actionid)then
return true
end
end

function newbieUIAction:isBindComponent()
return self.isBind
end

function newbieUIAction:isRunState()
return self.state==NEW_BIE_STATE.eRun
end

function newbieUIAction:isReadyState()
return self.state==NEW_BIE_STATE.eReady
end

function newbieUIAction:isStartState()
return self.state==NEW_BIE_STATE.eStart
end

function newbieUIAction:isUnStartState()
return self.state==NEW_BIE_STATE.eUnStart
end


function newbieUIAction:dofinish()
if self.clickEvent then
newbieManager.clickUITarget(self.cmpId)
end
self:lostFocus()
self.state=NEW_BIE_STATE.eOk
if self.isFinish then
newbieModel.storeServerOnFinish(self.newbieId)
end

end

function newbieUIAction:doErr()
self:lostFocus()
self.state=NEW_BIE_STATE.eErr

end

function newbieUIAction:isSelfEntity()
return false
end

function newbieUIAction:isEntity()
return false
end

function newbieUIAction:leave(finish)
self:lostFocus(finish)
end


function newbieUIAction:lostFocus(finish)
newbieControl.log('指引 lostFocus:')
if self.actionConfig==nil then return end

local actionConfig=self.actionConfig

local clearMask=actionConfig.clearMask
if clearMask==1 or clearMask==2 then
newbieControl.disableBloker()
end

if clearMask==1 or clearMask==3 then
newbieManager.stopMask()
else
newbieManager.revertMask()
end

if self.isFocus==false then return end
self.isFocus=false


newbieManager.removeClickAction(self.cmpId)

newbieControl.resetTopUI(self.cmpId)

newbieManager.setSkipActive(true)

if actionConfig.markName then
UIManager:closeWindow(actionConfig.markName)
end

newbieControl.lostFocus(self.newbieId,self.stepIdx,self.index)

end

function newbieUIAction:focus()
if self.isFocus then return end
if self.hasFocus then return end

self.hasFocus=true
self.isFocus=true
local actionConfig=self.actionConfig
local hasMask=actionConfig.mask==nil or actionConfig.mask==true
local skip=actionConfig.skip
if skip==nil then skip=true end


if self.clickEvent~=false then
newbieManager.addClickAction(self.cmpId)
else
local newbieId=self.newbieId
local stepIdx=self.stepIdx
newbieManager.setBlockAction(function()
if self:isRunState()and self.newbieId==newbieId and self.stepIdx==stepIdx then
self:dofinish()
end
end)
end

newbieControl.setTopUI(self.newbieId,self.stepIdx,self.index,self.cmpId)

newbieManager.setSkipActive(skip)

newbieControl.enableBloker()

if actionConfig.markName then
local cmpId=self.cmpId
UIManager:showWindow(actionConfig.markName,{conf=actionConfig,cmpId=cmpId})
end

if hasMask then
if actionConfig.maskDuation and actionConfig.maskDuation>0 then
newbieManager.startMask(self.cmpId,0,actionConfig.maskDuation)
else
newbieManager.enableMask(true)
end
end

newbieControl.onFocus(self.newbieId,self.stepIdx,self.index)
end

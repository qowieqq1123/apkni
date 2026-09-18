




newbieEntityAction=simple_class(refObject)

local _outTime=15
local _out2Time=90
function newbieEntityAction.create(...)
local object=refObject.get('newbieEntityAction',...)
return object
end

function newbieEntityAction:init(newbieId,actionid,stepIdx,index,actionType,group)
self.newbieId=newbieId
self.actionConfig=cfg_newbieaction_get(actionid)
self.readyTime=self.actionConfig.readyTime or 0
self.isFinish=self.actionConfig.isFinish or false
self.stepIdx=stepIdx
self.actionid=actionid
self.index=index
self.autoClick=self.actionConfig.mAutoClick or 0
self.clickEvent=self.actionConfig.clickEvent~=false
self.autoClickStamp=nil
self.isFocus=false
self.state=NEW_BIE_STATE.eUnStart
self.focusStamp=nil
self.outTimeStamp=nil
self.entityinfo=nil
self.moveToEntity=false
self.actionType=actionType
self.group=group
self.hasFocus=false
self.runTime=nil
self.checkSkip=false
self.readyStamp=nil
end

function newbieEntityAction:onRelease()
if self.actionConfig.window then
local name=self.actionConfig.window[1]
local isClose=self.actionConfig.window[2]
if name and isClose~=0 then
newbieControl.addCloseWindow(name)

end
end
self.actionConfig=nil
self.state=NEW_BIE_STATE.eUnStart
self.isFocus=false
self.focusStamp=nil
self.stepIdx=0
self.autoClick=0
self.autoClickStamp=nil
self.newbieId=0
self.outTimeStamp=nil
self.entityinfo=nil
self.moveToEntity=false
self.actionType=nil
self.group=nil
self.actionid=nil
self.hasFocus=false
self.runTime=nil
self.checkSkip=false
self.readyTime=0
self.readyStamp=nil
end

function newbieEntityAction:start()
if self.actionConfig==nil then
newbieControl.log(FMT.fmt('实体指引{0}当前步骤{1}没找到actionConfig配置，中断退出',self.newbieId,self.stepIdx))
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

function newbieEntityAction:enterStart()
self.focusStamp=timeHelper.getServerLongTime()
if self.actionConfig.jump then
jumpManager:jump(self.actionConfig.jump,nil,JUMP_BACK.eNoBack)
newbieControl.enableBloker()
end
if self.actionConfig.window and self.actionConfig.window[1]then
local name=self.actionConfig.window[1]
UIManager:showWindow(name)
newbieControl.enableBloker()
end
self.state=NEW_BIE_STATE.eStart
end

function newbieEntityAction:bindEntity(flag)

if flag then
if self:isStartState()then
if self.entityinfo==nil then
local entityArgs=self.actionConfig.entity
if entityArgs then
self.entityinfo=newbieEntityControl.bindEntity(table.unpackEx(entityArgs))
else
self.entityinfo=newbieEntityControl.bindEntityByLuaType(self.actionConfig.luacndfunc)
end
if self.entityinfo then
newbieControl.enableBloker()
self.state=NEW_BIE_STATE.eRun
self.group:bindAction(self,true)
newbieControl.onBind(self.newbieId,self.stepIdx,self.index,self.actionType)
newbieEntityControl.moveToEntity(self.entityinfo,function()self:moveCallback()end)
else
newbieControl.log('newbie_bindEntity 失败')
end
end
end
else
if self:isRunState()then
newbieControl.log('newbie_bindEntity 删除，指引异常退出')
self:doErr()
end
end
end

function newbieEntityAction:update()
if self:isReadyState()then
local stamp=timeHelper.getServerLongTime()
local pass=stamp-self.readyStamp
if pass>self.readyTime then
self:enterStart()
end
elseif self:isStartState()then
self:bindEntity(true)
if self:isStartState()then
local stamp=timeHelper.getServerLongTime()
if self.outTimeStamp==nil then self.outTimeStamp=stamp end
local pass=stamp-self.outTimeStamp
if newbieControl.isBlockActive()then
if pass>_outTime then
loggerUtil.debugErrFMT(FMT.fmt('实体指引{0}第{1}步第{2}序列实体无法找到，超时中断指引:',self.newbieId,self.stepIdx,self.index))
self.outTimeStamp=nil
self:doErr()
end
else
if pass>_out2Time then
loggerUtil.debugErrFMT(FMT.fmt('实体指引{0}第{1}步第{2}序列实体无法找到，超时中断指引:',self.newbieId,self.stepIdx,self.index))
self.outTimeStamp=nil
self:doErr()
end
end
end
elseif self:isRunState()then
local stamp=timeHelper.getServerLongTime()


if self.runTime==nil then self.runTime=stamp end
local pass=stamp-self.runTime
if pass>0.5 and not self.checkSkip then
self.checkSkip=true
if self:skip()then
self.state=NEW_BIE_STATE.eSkip
newbieControl.log(FMT.fmt('指引{0}当前步骤{1}经检测不可继续，跳过当前指引',self.newbieId,self.stepIdx))
return self.state
end
end

self.outTimeStamp=nil
if not self.isFocus then
if self.focusStamp==nil then self.focusStamp=stamp end
local pass=stamp-self.focusStamp
local focusDelay=self.actionConfig.mFocusDelay or 0
if pass>=focusDelay and self.moveToEntity then
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

function newbieEntityAction:skip()
if newbieSkipFuncHelper.checkSkip(self.actionid)then
newbieControl.log(FMT.fmt('指引{0}当前步骤{1}经检测不可继续，跳过当前指引',self.newbieId,self.stepIdx))
return true
end
end

function newbieEntityAction:moveCallback()
if self and self.actionConfig then
self.moveToEntity=true
end
end

function newbieEntityAction:entityTop()
local args={guid=self.entityinfo.guid,camera=self.entityinfo.camera}
newbieControl.setTopEntity(self.newbieId,self.stepIdx,self.index,args)
end

function newbieEntityAction:isRunState()
return self.state==NEW_BIE_STATE.eRun
end

function newbieEntityAction:isReadyState()
return self.state==NEW_BIE_STATE.eReady
end

function newbieEntityAction:isStartState()
return self.state==NEW_BIE_STATE.eStart
end

function newbieEntityAction:isReadyState()
return self.state==NEW_BIE_STATE.eReady
end

function newbieEntityAction:isUnStartState()
return self.state==NEW_BIE_STATE.eUnStart
end

function newbieEntityAction:dofinish()
self:clickEntity()
self:lostFocus(true)
self.state=NEW_BIE_STATE.eOk
if self.isFinish then
newbieModel.storeServerOnFinish(self.newbieId)
end

end

function newbieEntityAction:doErr()
self:lostFocus(true)
self.state=NEW_BIE_STATE.eErr
newbieControl.log('指引 doErr:',self.state)
end

function newbieEntityAction:isEntity()
return true
end

function newbieEntityAction:isSelfEntity(guid)
return self.entityinfo and tostring(self.entityinfo.guid)==tostring(guid)or false
end

function newbieEntityAction:clickEntity()

if self:isRunState()and self.entityinfo and self.isFocus then
newbieEntityControl.clickEntity(self.entityinfo,self.clickEvent)
return true
end
return false
end

function newbieEntityAction:finish()

end

function newbieEntityAction:leave(finish)
self:lostFocus(finish)
end


function newbieEntityAction:lostFocus(finish)
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


if self.entityinfo and self.entityinfo.guid then
newbieManager.resetEntityTransformTop(self.entityinfo.guid)
end

newbieManager.setSkipActive(true)

if actionConfig and actionConfig.markName then
UIManager:closeWindow(actionConfig.markName)
end

newbieControl.lostFocus(self.newbieId,self.stepIdx,self.index)

end

function newbieEntityAction:focus()
if self.isFocus then return end
if self.hasFocus then return end
self.hasFocus=true
self.isFocus=true
local actionConfig=self.actionConfig
local hasMask=actionConfig.mask==nil or actionConfig.mask==true
local skip=actionConfig.skip
if skip==nil then skip=true end


if not self.clickEvent then
local newbieId=self.newbieId
local stepIdx=self.stepIdx
newbieManager.setBlockAction(function()

if self:isRunState()and self.newbieId==newbieId and self.stepIdx==stepIdx then
self:dofinish()
end
end)
end


self:entityTop()

newbieManager.setSkipActive(skip)

newbieControl.enableBloker()

if actionConfig.markName then
UIManager:showWindow(actionConfig.markName,{conf=actionConfig,info=self.entityinfo})
end

if hasMask and self.entityinfo then
newbieManager.enableMask(true)
end

newbieControl.onFocus(self.newbieId,self.stepIdx,self.index)
end

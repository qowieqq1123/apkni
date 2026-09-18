




newbieWinAction=simple_class(refObject)

function newbieWinAction.create(...)
local object=refObject.get('newbieWinAction',...)
return object
end

function newbieWinAction:init(newbieId,actionid,stepIdx,index,actionType,group)
self.newbieId=newbieId
self.actionid=actionid
self.actionConfig=cfg_newbieaction_get(actionid)
self.readyTime=self.actionConfig.readyTime or 0
self.isFinish=self.actionConfig.isFinish or false
self.stepIdx=stepIdx
self.index=index
self.state=NEW_BIE_STATE.eUnStart
self.actionType=actionType
self.group=group
self.readyStamp=nil
end

function newbieWinAction:onRelease()
if self.actionConfig.markName then
newbieControl.addCloseWindow(self.actionConfig.markName)

end
self.actionConfig=nil
self.state=NEW_BIE_STATE.eUnStart
self.stepIdx=0
self.newbieId=0
self.actionType=nil
self.group=nil
self.actionid=nil
self.readyTime=0
self.readyStamp=nil
end

function newbieWinAction:start()
if self.actionConfig==nil then
newbieControl.log(FMT.fmt('指引{0}当前步骤{1}没找到actionConfig配置，中断退出',self.newbieId,self.stepIdx))
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

function newbieWinAction:enterStart()
self.group:bindAction(self,true)
if self.actionConfig.jump then
jumpManager:jump(self.actionConfig.jump,nil,JUMP_BACK.eNoBack)
end
if newbieSkipFuncHelper.checkSkip(self.actionid)then
self.state=NEW_BIE_STATE.eSkip
newbieControl.log(FMT.fmt('指引{0}当前步骤{1}经检测不可继续，直接跳过当前指引',self.newbieId,self.stepIdx))
return self.state
end
if self.actionConfig.markName then
UIManager:showWindow(self.actionConfig.markName,{newbieId=self.newbieId,stepIdx=self.stepIdx,conf=self.actionConfig})
end
self.state=NEW_BIE_STATE.eRun
end

function newbieWinAction:update()
if self:isReadyState()then
local stamp=timeHelper.getServerLongTime()
local pass=stamp-self.readyStamp
if pass>self.readyTime then
self:enterStart()
end
end
return self.state
end

function newbieWinAction:isRunState()
return self.state==NEW_BIE_STATE.eRun
end

function newbieWinAction:isEnterState()
return self:isStartState()or self:isRunState()
end

function newbieWinAction:isStartState()
return self.state==NEW_BIE_STATE.eStart
end

function newbieWinAction:dofinish()
self.state=NEW_BIE_STATE.eOk
if self.isFinish then
newbieModel.storeServerOnFinish(self.newbieId)
end

end

function newbieWinAction:doErr()
self.state=NEW_BIE_STATE.eErr

end

function newbieWinAction:isSelfEntity()
return false
end

function newbieWinAction:isEntity()
return false
end

function newbieWinAction:leave(finish)

end

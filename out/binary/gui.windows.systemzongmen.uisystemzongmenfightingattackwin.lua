







def_class("UISystemZongMenFightingAttackWin",UIWindowBase)









function UISystemZongMenFightingAttackWin:bindComponents()

self.background=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.ScrollView=UIObject.get(self,2)
self.infoList=UIObject.get(self,3)
self.root=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)



end


function UISystemZongMenFightingAttackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil
local _itemCmp={
name=0,
state=1,
button=2,
buttonTx=3,
}
local _cdType={
noCD=1,
needRefresh=2,
}
local _stateType={
noTeam=1,
goingTo=2,
fighting=3,
}
local _stateHandle={
[_stateType.noTeam]={
refreshTx="setStateTx_NoTeam",
btnTx="前往宗门",
btnHandle="gotoZongMen",
cdType=_cdType.noCD,
},
[_stateType.goingTo]={
refreshTx="setStateTx_GoingTo",
btnTx="前往",
btnHandle="gotoTeam",
cdType=_cdType.needRefresh,
},
[_stateType.fighting]={
refreshTx="setStateTx_Fighting",
btnTx="查看战斗",
btnHandle="watchFightResult",
cdType=_cdType.noCD,
},
}



function UISystemZongMenFightingAttackWin:onLoaded(...)
self:bindComponents()
_this=self

self.cdDatas={}
self.fightDuration=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"reportDuration")

self:addNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
self:addNotify(notifyConfig.onSystemZMFightResultNew,self.onSystemZMFightResultNew)
self:addNotify(notifyConfig.onSystemZMFightWaitResultNew,self.onSystemZMFightWaitResultNew)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
end


function UISystemZongMenFightingAttackWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTimer()
end




function UISystemZongMenFightingAttackWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.arrow:setChildAnchoredPosition(argtable.arrow)
self:refreshView()
end


function UISystemZongMenFightingAttackWin:onHide()

end





function UISystemZongMenFightingAttackWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISystemZongMenFightingAttackWin:gotoZongMen(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
self:onBackground()

local unitKey=systemZongMenModel:convertUnitKey(serial)
if worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)then
worldController:clickUnit(unitKey)
else
worldController:enterWorld(infoData.worldId,{clickUnit=unitKey})
end
end
end

function UISystemZongMenFightingAttackWin:gotoTeam(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local tasks=worldTaskModel:findAllFakeEx(function(task)
return task.target_type==eWorldUnitTpye.SYSTEMZM and mathHelper.compareInt64(serial,task.target_guid)and task.target_id>0
end)
for i,v in ipairs(tasks)do
local unitKey=worldTaskModel:convertTaskUnitKey(v,0)
if worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)then
worldController:lookAtUnit(unitKey)
else
worldController:enterWorld(infoData.worldId,{lookAtUnit=unitKey})
end
return
end
end
end

function UISystemZongMenFightingAttackWin:watchFightResult(serial)
if systemZongMenController:playFightBattle(serial,true)then
self:onBackground()
end
end

function UISystemZongMenFightingAttackWin:refreshView()
self.datas={}
self.lookup={}

local resultList=systemZongMenModel:getAllWaitNotifyResult()
for serial_str,data in pairs(resultList)do
if data.teamIndex>0 then
local temp=self.lookup[serial_str]
if temp then
if temp.state<_stateType.fighting then
temp.time=data.timeStamp+self.fightDuration
temp.state=_stateType.fighting
end
else
self.lookup[serial_str]={
serial=data.serial,
time=data.timeStamp+self.fightDuration,
state=_stateType.fighting,
}
end
end
end

local teamList=systemZongMenModel:getAllBattleWaitResult()
for index,data in ipairs(teamList)do
if data.teamIndex>0 then
local temp=self.lookup[data.serial_str]
if temp then

if temp.state<_stateType.goingTo then
temp.time=data.gameStamp
temp.state=_stateType.goingTo
end
else
self.lookup[data.serial_str]={
serial=data.serial,
time=data.gameStamp,
state=_stateType.goingTo,
}
end
end
end

local stateList=systemZongMenModel:getFightFlagLookup(systemZongMenFightFlagType.eBeAttacked)
if stateList then
for index,serial in ipairs(stateList)do
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local temp=self.lookup[infoData.serial_str]
if temp then
if temp.state<_stateType.noTeam then
temp.time=infoData.end_time
temp.state=_stateType.noTeam
end
else
self.lookup[infoData.serial_str]={
serial=infoData.serial,
time=infoData.end_time,
state=_stateType.noTeam,
}
end
end
end
end

if next(self.lookup)==nil then
self:onBackground()
return
end

for i,v in pairs(self.lookup)do
table.insert(self.datas,v)
end
table.sort(self.datas,self.sortDataFunc)

local nowTime=timeHelper.getServerShortTime()
self.infoList:setChildLayoutGroupCreateItems(#self.datas,function(index)
local item=self.infoList:getChildLayoutGroupGridItem(index-1)
local data=self.datas[index]
local serial=data.serial
local endTime=data.time
local state=data.state
local handle=_stateHandle[state]
local infoData=systemZongMenModel:getInfoData(serial)
local nameStr=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
item:SetChildText(_itemCmp.name,nameStr)
item:SetChildButtonClick(_itemCmp.button,function()
self[handle.btnHandle](self,serial)
end)
item:SetChildText(_itemCmp.buttonTx,handle.btnTx)
self[handle.refreshTx](self,item,endTime,nowTime)
if handle.cdType==_cdType.needRefresh then
self.cdDatas[index]={item=item,state=state,endTime=endTime}
end
end)
local height=Mathf.Clamp(7.5+#self.datas*102.5,0,500)
self.root:setChildSizeDelta(422,height)
self.ScrollView:setChildScrollRectEnable(height>=500)
if next(self.cdDatas)~=nil then
self:startCDTimer()
end
end

function UISystemZongMenFightingAttackWin.sortDataFunc(a,b)
if a.state~=b.state then
return a.state>b.state
elseif a.time~=b.time then
return a.time<b.time
else
return a.serial<b.serial
end
end

function UISystemZongMenFightingAttackWin:startCDTimer()
if not self.cdTimer then
self.cdTimer=self:setTimer(1,0,function()
self:updateCDTimer()
end)
end
end

function UISystemZongMenFightingAttackWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UISystemZongMenFightingAttackWin:updateCDTimer()
local nowTime=timeHelper.getServerShortTime()
local removes={}
for i,v in pairs(self.cdDatas)do
local handle=_stateHandle[v.state]
if handle.cdType==_cdType.needRefresh then
self[handle.refreshTx](self,v.item,v.endTime,nowTime)
end
if nowTime>v.endTime then
table.insert(removes,i)
end
end

for i,v in ipairs(removes)do
self.cdDatas[v]=nil
end

if next(self.cdDatas)==nil then
self:stopCDTimer()
end
end

function UISystemZongMenFightingAttackWin:setStateTx_NoTeam(item,endTime,nowTime)
item:SetChildText(_itemCmp.state,"<color=#65615F>未派遣队伍</color>")
end

function UISystemZongMenFightingAttackWin:setStateTx_GoingTo(item,endTime,nowTime)
local waitTime=endTime-nowTime
if waitTime>=0 then
item:SetChildText(_itemCmp.state,FMT.fmt("队伍<color=#56a105>{0}</color>后到达",timeHelper.format_time_stamp3(waitTime)))
else
item:SetChildText(_itemCmp.state,"<color=#BC4F4F>即将展开战斗</color>")
end
end

function UISystemZongMenFightingAttackWin:setStateTx_Fighting(item,endTime,nowTime)
item:SetChildText(_itemCmp.state,"<color=#BC4F4F>队伍战斗中</color>")
end

function UISystemZongMenFightingAttackWin.onSystemZMFightRecordNew(serial,teamIndex)
_this:refreshView()
end

function UISystemZongMenFightingAttackWin.onSystemZMFightWaitResultNew(serial,teamIndex)
if teamIndex>0 then
local serial_str=tostring(serial)
local temp=_this.lookup[serial_str]
if temp then
if temp.state<_stateType.goingTo then
local result=systemZongMenModel:findBattleWaitResultEx(serial,teamIndex)
if reuslt then
temp.state=_stateType.goingTo
temp.time=reuslt.timeStamp

local handle=_stateHandle[temp.state]
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(_this.datas)do
if mathHelper.compareInt64(v.serial,serial)then
local item=_this.infoList:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_itemCmp.buttonTx,handle.btnTx)
_this[handle.refreshTx](_this,item,temp.time,nowTime)
if handle.cdType==_cdType.needRefresh then
_this.cdDatas[index]=temp
end
return
end
end
else
_this:refreshView()
end
end
else
_this:refreshView()
end
end
end

function UISystemZongMenFightingAttackWin.onSystemZMFightResultNew(serial,teamIndex)
if teamIndex>0 then
local serial_str=tostring(serial)
local temp=_this.lookup[serial_str]
if temp then
local reuslt=systemZongMenModel:getWaitNotifyResultImp(serial_str)
if reuslt then
if temp.state<_stateType.fighting then
temp.state=_stateType.fighting
temp.time=reuslt.timeStamp+_this.fightDuration

local handle=_stateHandle[temp.state]
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(_this.datas)do
if mathHelper.compareInt64(v.serial,serial)then
local item=_this.infoList:getChildLayoutGroupGridItem(i-1)
item:SetChildText(_itemCmp.buttonTx,handle.btnTx)
_this[handle.refreshTx](_this,item,temp.time,nowTime)
if handle.cdType==_cdType.needRefresh then
_this.cdDatas[index]=temp
end
return
end
end
end
else
_this:refreshView()
end
end
end
end

function UISystemZongMenFightingAttackWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if newFlag==systemZongMenFightFlagType.eBeAttacked then
_this:refreshView()
end
end

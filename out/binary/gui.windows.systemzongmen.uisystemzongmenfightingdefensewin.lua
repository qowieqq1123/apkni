







def_class("UISystemZongMenFightingDefenseWin",UIWindowBase)









function UISystemZongMenFightingDefenseWin:bindComponents()

self.background=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.nameTx=UIText.get(self,2)
self.timeTx=UIText.get(self,3)
self.detailBtn=UIButton.get(self,4)
self.fightBtn=UIButton.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)



end


function UISystemZongMenFightingDefenseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
end















local _this=nil



function UISystemZongMenFightingDefenseWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
self:addNotify(notifyConfig.onSystemZMFightResultNew,self.onSystemZMFightResultNew)
self:addNotify(notifyConfig.onSystemZMFightWaitResultNew,self.onSystemZMFightWaitResultNew)
end


function UISystemZongMenFightingDefenseWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTimer()
end




function UISystemZongMenFightingDefenseWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.arrow:setChildAnchoredPosition(argtable.arrow)
self:refreshView()
end


function UISystemZongMenFightingDefenseWin:onHide()

end




function UISystemZongMenFightingDefenseWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end


function UISystemZongMenFightingDefenseWin:onDetailBtn()
local attackInfo=systemZongMenModel:getAttackInfo(self.serial)
if attackInfo then

local teamList={}
for i=1,attackInfo.teamLen do
local v=attackInfo.teamList[i]
local index=math.ceil(i/fightPreSelectModel.maxPosNum)
local tempList=teamList[index]
if tempList==nil then
tempList={}
teamList[index]=tempList
end
local pos=i-(index-1)*fightPreSelectModel.maxPosNum
if v and v.disciple_id>0 then
tempList[pos]=v
else
tempList[pos]=nil
end
end
local args={
title="来袭队伍",
parentWin=self,
teamList=teamList,
}
self:showWindow("UISystemZongMenComingTeamWin",args)
else
loggerUtil.logWarnFMT("没有对应队伍信息：{0}",tostring(self.serial))
end
end

function UISystemZongMenFightingDefenseWin:onFightBtn()
systemZongMenController:playFightBattle(self.serial,true)
end

function UISystemZongMenFightingDefenseWin:refreshView()
self:stopCDTimer()

local resultList=systemZongMenModel:getAllWaitNotifyResult()
for i,v in pairs(resultList)do
if v.teamIndex==0 then
self.serial=v.serial
local infoData=systemZongMenModel:getInfoData(self.serial)
self.nameTx:setText(systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
self.fightBtn:setActive(true)
self.detailBtn:setActive(false)
self.timeTx:setText("<color=#BC4F4F>正在战斗中</color>")
return
end
end


local teamList=systemZongMenModel:getAllBattleWaitResult()
for index,data in ipairs(teamList)do
if data.teamIndex==0 then
self.serial=data.serial
self.deadline=data.gameStamp
local infoData=systemZongMenModel:getInfoData(self.serial)
self.nameTx:setText(systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
self.fightBtn:setActive(false)
self.detailBtn:setActive(true)
self:startCDTimer()
return
end
end

self:onBackground()
end

function UISystemZongMenFightingDefenseWin:startCDTimer()
if not self.cdTimer then
self:updateCDTimer()
self.cdTimer=self:setTimer(1,0,function()
if self:updateCDTimer()then
self:refreshView()
end
end)
end
end

function UISystemZongMenFightingDefenseWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UISystemZongMenFightingDefenseWin:updateCDTimer()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.deadline-nowTime
if deltaTime<0 then
self.timeTx:setText("<color=#BC4F4F>即将展开战斗</color>")
self:stopCDTimer()
return true
else
local timeStr=timeHelper.format_time_stamp3(deltaTime)
self.timeTx:setText(FMT.fmt("队伍<color=#56a105>{0}</color>后到达",timeStr))
return false
end
end

function UISystemZongMenFightingDefenseWin.onSystemZMFightRecordNew(serial,teamIndex)
if teamIndex==0 then
_this:refreshView()
end
end

function UISystemZongMenFightingDefenseWin.onSystemZMFightResultNew(serial,teamIndex)
if teamIndex==0 then
if mathHelper.compareInt64(serial,_this.serial)then
_this.fightBtn:setActive(true)
_this.detailBtn:setActive(false)
_this.timeTx:setText("<color=#BC4F4F>正在战斗中</color>")
else
_this:refreshView()
end
end
end

function UISystemZongMenFightingDefenseWin.onSystemZMFightWaitResultNew(serial,teamIndex)
if teamIndex==0 then
_this:refreshView()
end
end
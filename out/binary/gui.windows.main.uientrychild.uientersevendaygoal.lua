







def_class("UIEnterSevenDayGoal",UICloneObject)





UIEnterSevenDayGoal.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterSevenDayGoal.assetName="UIEnterNomalItem"


function UIEnterSevenDayGoal:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterSevenDayGoal:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end







local iconname='button_hdrk_0003'
local _isInit=false

function UIEnterSevenDayGoal:onLoaded(...)
self:bindComponents()
end

function UIEnterSevenDayGoal:__delete()
self:stopLeftTimer()
_isInit=false
self:unbindComponents()
end

function UIEnterSevenDayGoal:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

if not _isInit then
self:addNotify(notifyConfig.building_event,function(...)
self:on_building_event(...)
end)

self:addNotify(notifyConfig.onZongMenFightChange,function()
self:freshReddot_event()
end)

self:addNotify(notifyConfig.onDiscipleCreate,function()
self:freshReddot_event()
end)

self:addNotify(notifyConfig.onDiscipleJJChange,function()
self:freshReddot_event()
end)

self:addNotify(notifyConfig.onDiscipleJJBroke,function()
self:freshReddot_event()
end)

self:addNotify(notifyConfig.onDiscipleLTChange,function()
self:freshReddot_event()
end)

self:addNotify(notifyConfig.onGuBaoActive,function()
self:freshReddot_event()
end)

_isInit=true
end

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)


self:freshReddot()


self.widget:SetChildText(2,'')


self.widget:SetChildText(3,'')


self.widget:SetChildActive(4,true)

local clickFun=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eSevenDayTarget)then
UIManager.info("七日试炼未开启")
return
else
local isEnd=sevenDayGoalModel:checkIsEnd()
if isEnd==nil or isEnd then
UIManager.info("七日试炼已结束")
return
end
end


sevenDayGoalModel:clearSevenDayGoalIndex()

UIFullSevenDayGoalController:showMainUI()
end

self.widget:SetChildButtonClick(0,clickFun,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),clickFun,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
if systemModel.isOpen(SYSTEM_DEFINE.eSevenDayTarget)then
local isEnd=sevenDayGoalModel:checkIsEnd()
if isEnd~=nil then
if not isEnd then

self:startTimer()
else



sevenDayGoalController:reqEnd()

sevenDayGoalController:removeSevenDayGoalEnter()
end
end
end
end

function UIEnterSevenDayGoal:onHide()

end





function UIEnterSevenDayGoal:freshReddot()
if not initProControl.isDone()then
return
end

UIManager:invokeUIMethod('UIMain','freshSimpleBtnReddot')

local reddot=sevenDayGoalModel:checkEnterReddot()
self.widget:SetChildActive(1,reddot)
end

function UIEnterSevenDayGoal:freshReddot_recv()
if not initProControl.isDone()then
return
end

UIManager:invokeUIMethod('UIMain','freshSimpleBtnReddot')

local reddot=sevenDayGoalModel:checkEnterReddot(true)
self.widget:SetChildActive(1,reddot)
end

function UIEnterSevenDayGoal:freshReddot_event()
self:freshReddot()
end

function UIEnterSevenDayGoal.on_building_event(etype,level,exp,lastLv)
if etype==buildingEvent.zongmenLevelUp or etype==buildingEvent.levelUpComplete then
self:freshReddot()
end
end

function UIEnterSevenDayGoal:startTimer()
self:stopLeftTimer()

local func
func=function()
if not self or self.isClose then return end
local nowTime=gameUtilityModel.getServerShortTime()
local endTime=sevenDayGoalModel:getEndTime()
if not endTime then

self:stopLeftTimer()
return
end
local lerp=endTime-nowTime
if lerp>0 then
local timeStr=nil
local finalTime=sevenDayGoalModel:getFinalTime()
lerp=finalTime-nowTime
if lerp<86400 and lerp>=0 then

timeStr=timeHelper.format_time_stamp3(lerp,true)
self.widget:SetChildText(3,FMT.fmt("{0}",timeStr))


self.widget:SetChildActive(4,true)
else


self.widget:SetChildText(3,'')


self.widget:SetChildActive(4,false)
end



local nextOpenDay=sevenDayGoalModel:getNextOpenDay()
if nextOpenDay then
lerp=sevenDayGoalModel:getDayTime(nextOpenDay)-nowTime
if lerp<=0 then

sevenDayGoalModel:checkDayLock(nextOpenDay)

sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end
end
else

sevenDayGoalController:reqEnd()

sevenDayGoalController:removeSevenDayGoalEnter()
end
end
self.timer=self:setTimer(1,0,func)

func()
end

function UIEnterSevenDayGoal:stopLeftTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterSevenDayGoal:onIcon()

end

function UIEnterSevenDayGoal:onClickBg()

end








def_class("UIEnterLunDaoDaHui",UICloneObject)





UIEnterLunDaoDaHui.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterLunDaoDaHui.assetName="UIEnterNomalItem"


function UIEnterLunDaoDaHui:bindComponents()

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


function UIEnterLunDaoDaHui:unbindComponents()
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









function UIEnterLunDaoDaHui:onLoaded(...)
self:bindComponents()
self.onLundaodahuiJingCai=function()
self:refreshReddot()
end
notifySystem:listenNotify(notifyConfig.onLundaodahuiJingCai,self.onLundaodahuiJingCai)
end

function UIEnterLunDaoDaHui:__delete()
self:stopSelfTimer()
self:unbindComponents()
self.act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil
notifySystem:removelistener(notifyConfig.onLundaodahuiJingCai,self.onLundaodahuiJingCai)
end

function UIEnterLunDaoDaHui:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable

local abname,iconname=activitiesModel.getEnterIcon(1)
self.widget:SetChildCSImageSprite(0,abname,"button_hdrk_00041")
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.reddot:setActive(false)


self:refreshReddot()
self:startTimer()

self.widget:SetChildButtonClick(0,function()
UIFullLunDaoDaHuiControl:showLunDaoDaHui()
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIFullLunDaoDaHuiControl:showLunDaoDaHui()
end,true)

self.isEx=argtable.isEx or false

self:refreshQiPao()

self.extendbg:setActive(self.isEx)
end

function UIEnterLunDaoDaHui:refreshReddot()
local flag=lundaodahuiModel:checkJingCaiAllReddot()

local setTeamFlag=lundaodahuiController:checkShowSetTeamFlag()

if self.reddot then
self.reddot:setActive(flag or setTeamFlag)
end
end

function UIEnterLunDaoDaHui:refreshQiPao()
local isEx=self.isEx or false

local isShowSetTeamFlag=lundaodahuiController:checkShowSetTeamFlag()
local isShowQiPao=(not isEx)and isShowSetTeamFlag

self.lldhQiPao:setActive(isShowQiPao)
end

function UIEnterLunDaoDaHui:startTimer()
self.widget:SetChildActive(4,true)

local openDayZeroTime=lundaodahuiModel:getLundaodahuiOpenDayZeroTime()
if not openDayZeroTime then
return
end
local cfg=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local endTime=openDayZeroTime+cfg.actTime
self.stamp=endTime

self:stopSelfTimer()

local func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local left=self.stamp-nowTime
if self==nil or self.isClose or self.widget==nil then return end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
if left<=1 then
lundaodahuiController:removeMatchEnter()
return
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterLunDaoDaHui:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterLunDaoDaHui:onHide()

end



function UIEnterLunDaoDaHui:onIcon()

end

function UIEnterLunDaoDaHui:onClickBg()

end

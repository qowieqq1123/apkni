







def_class("UIEnterLunDaoDaHui_RongYuTang",UICloneObject)





UIEnterLunDaoDaHui_RongYuTang.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterLunDaoDaHui_RongYuTang.assetName="UIEnterNomalItem"


function UIEnterLunDaoDaHui_RongYuTang:bindComponents()

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


function UIEnterLunDaoDaHui_RongYuTang:unbindComponents()
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









function UIEnterLunDaoDaHui_RongYuTang:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onLundaodahuiDianZan,function()
self:refreshReddot()
end)
end


function UIEnterLunDaoDaHui_RongYuTang:__delete()
self:unbindComponents()
end




function UIEnterLunDaoDaHui_RongYuTang:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)

self:startTimer()
self.reddot:setActive(false)
local abname,iconname=activitiesModel.getEnterIcon(1)
self.widget:SetChildCSImageSprite(0,abname,"button_hdrks_0002")
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.widget:SetChildButtonClick(0,function()
UIManager:showWindow("UILDRongYuTongWin",{ftype=1})
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow("UILDRongYuTongWin",{ftype=1})
end,true)
self:refreshReddot()
self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterLunDaoDaHui_RongYuTang:onHide()

end

function UIEnterLunDaoDaHui_RongYuTang:refreshReddot()
local flag=lundaodahuiModel:getDzNum()>0
if self.reddot then
self.reddot:setActive(flag)
end
end

function UIEnterLunDaoDaHui_RongYuTang:startTimer()
self.widget:SetChildActive(4,true)

local openDayZeroTime=lundaodahuiModel:getLundaodahuiOpenDayZeroTime()
if not openDayZeroTime then
return
end
local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"entryRYTOpenTime")
local entryRYTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"entryRYTTime")
local endTime=openDayZeroTime+entryTime+entryRYTime
self.stamp=endTime

self:stopSelfTimer()

local func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local left=self.stamp-nowTime
if self==nil or self.isClose or self.widget==nil then return end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
if left<=1 then
lundaodahuiController:removeRongYuTangEnter()
return
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterLunDaoDaHui_RongYuTang:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end


function UIEnterLunDaoDaHui_RongYuTang:onClickBg()

end
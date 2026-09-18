







def_class("UIEnterNewWenJuan",UICloneObject)





UIEnterNewWenJuan.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterNewWenJuan.assetName="UIEnterNomalItem"


function UIEnterNewWenJuan:bindComponents()

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


function UIEnterNewWenJuan:unbindComponents()
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







local iconname='button_zjmwenjuan'

function UIEnterNewWenJuan:onLoaded(...)
self:bindComponents()
end

function UIEnterNewWenJuan:__delete()
self:unbindComponents()
end

function UIEnterNewWenJuan:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.widget:SetChildActive(1,newQuestionModel:hasPrize())

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

local clickFunc=function()
local list=newQuestionModel:getOpenQuestionList()
if list and#list>0 then
newQuestionController:showClientShowQuestionWin()
else

newQuestionController:freshEntry()
end
end

self.widget:SetChildButtonClick(0,function()
clickFunc()
end,true)
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
clickFunc()
end,true)

self.extendbg:setActive(argtable.isEx or false)

self.stamp,self.leftTimeQId=newQuestionModel:getWenJuanLeftTime()
if self.stamp then
self:startTimer()
end
self.qipao:setActive(false)
end

function UIEnterNewWenJuan:onHide()

end




function UIEnterNewWenJuan:freshReddot()
self.widget:SetChildActive(1,newQuestionModel:hasPrize())
end

function UIEnterNewWenJuan:onIcon()

end

function UIEnterNewWenJuan:onClickBg()

end

function UIEnterNewWenJuan:startTimer()
self:stopSelfTimer()

local showDurationLimit=cfgHelper.get2(cfg_clientquestionnairebaseconfig_get,1,"show_time_limit")
local left=self.stamp-os.time()
local isShowTime=showDurationLimit>=left
local isShowTime2=showDurationLimit>=left
self.widget:SetChildActive(4,isShowTime)

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
left=self.stamp-os.time()
if left<0 then left=0 end

isShowTime2=showDurationLimit>=left
if isShowTime~=isShowTime2 then
isShowTime=isShowTime2
self.widget:SetChildActive(4,isShowTime)
end
if isShowTime2 then
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterNewWenJuan:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end
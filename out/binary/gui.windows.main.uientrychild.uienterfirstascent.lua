







def_class("UIEnterFirstAscent",UICloneObject)





UIEnterFirstAscent.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterFirstAscent.assetName="UIEnterNomalItem"


function UIEnterFirstAscent:bindComponents()

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


function UIEnterFirstAscent:unbindComponents()
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









function UIEnterFirstAscent:onLoaded(...)
self:bindComponents()
end


function UIEnterFirstAscent:__delete()
self:unbindComponents()
end




function UIEnterFirstAscent:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
self.info=argtable.info
local enterIconType=self.info.enterIconType
local enterType=self.info.enterType
self.cfg=enterConfig.getConfig(enterIconType,enterType)

local abname,iconname=limitActivitiesModel.getActIcon(17)
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.reddot:setActive(false)

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.qipao:setActive(false)


self:freshReddot()
self.extendbg:setActive(argtable.isEx or false)

self:startTimer()
end


function UIEnterFirstAscent:onHide()

end

function UIEnterFirstAscent:startTimer()
local isShow=jiuchongtianjieFirstAscentModel:getCanTipsByDay()
if isShow then
self.widget:SetChildActive(4,true)
self.stamp=jiuchongtianjieFirstAscentModel:getEndTime()
self:stopSelfTimer()

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
local left=self.stamp-os.time()
if left<0 then
left=0
self:stopSelfTimer()
jiuchongtianjieFirstAscentController:freshActEnd()
end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end
end

function UIEnterFirstAscent:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterFirstAscent:freshReddot()

local flag=self.info.getReddotFun()
self.reddot:setActive(flag)
end

function UIEnterFirstAscent:onIcon()
UIManager:showWindow("UIJiuChongTianJieFirstAscentWin")
end

function UIEnterFirstAscent:onClickBg()
UIManager:showWindow("UIJiuChongTianJieFirstAscentWin")
end



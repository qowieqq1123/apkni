







def_class("UIEnterTianJiangFuYuan",UICloneObject)





UIEnterTianJiangFuYuan.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterTianJiangFuYuan.assetName="UIEnterNomalItem"


function UIEnterTianJiangFuYuan:bindComponents()

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


function UIEnterTianJiangFuYuan:unbindComponents()
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





local iconname='button_hdrk_0044'
local _isInit=false



function UIEnterTianJiangFuYuan:onLoaded(...)
self:bindComponents()
end


function UIEnterTianJiangFuYuan:__delete()
self:stopLeftTimer()
_isInit=false
self:unbindComponents()
end




function UIEnterTianJiangFuYuan:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

if not _isInit then
_isInit=true
end


self:freshReddot()


self.widget:SetChildText(2,'')


self.widget:SetChildText(3,'')


self.widget:SetChildActive(4,true)

self:startLeftTimer()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterTianJiangFuYuan:onHide()

end



function UIEnterTianJiangFuYuan:freshReddot()
local reddot=tianJiangFuYuanModel:checkActEnterReddot()
self.widget:SetChildActive(1,reddot)
end



function UIEnterTianJiangFuYuan:onClickBg()
tianJiangFuYuanController:clickActEnter()
end

function UIEnterTianJiangFuYuan:onIcon()
tianJiangFuYuanController:clickActEnter()
end


function UIEnterTianJiangFuYuan:stopLeftTimer()
if self.timeId then
self:stopTimerByID(self.timeId)
self.timeId=nil
end
end

function UIEnterTianJiangFuYuan:startLeftTimer()
self:stopLeftTimer()



local leftStamp=tianJiangFuYuanModel:getActEnterTime()

local func=function()

local serverTime=timeHelper.getServerShortTime()
local left=leftStamp-serverTime

local timeStr=timeHelper.format_time_stamp3(left)

self.widget:SetChildText(3,timeStr)
end

self.timeId=self:setTimer(1,0,func)
func()
end




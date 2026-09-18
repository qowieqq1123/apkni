







def_class("UITianMoJieShareWin",UIWindowBase)









function UITianMoJieShareWin:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.channels=UIObject.get(self,3)
self.shareBtn=UIButton.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UITianMoJieShareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.channels);self.channels=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
end















local _this=nil
local _chooseCmp={
root=-1,
toggle=0,
tick=1,
lock=2,
name=3,
toggleBg=4,
}
local _channels={CHAT_CHANNNEL.eXianmeng}



function UITianMoJieShareWin:onLoaded(...)
self:bindComponents()
_this=self
self.selects={}
end


function UITianMoJieShareWin:__delete()
self:unbindComponents()
_this=nil
end




function UITianMoJieShareWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.monsterGuid=argtable.monsterGuid
self.actorId=argtable.actorId
self.opens={}
self.channels:setChildLayoutGroupCreateItems(#_channels)
local channelItems=self.channels:getChildLayoutGroupGridList()
for index=1,channelItems.Count do
local item=channelItems[index-1]
local channelID=_channels[index]
local channelCfg=cfgHelper.get1(cfg_chatchannnelconfig_get,channelID)
local isOpen=true
if channelCfg.sysid then
isOpen=systemModel.isOpen(channelCfg.sysid)
if channelCfg.sysid==SYSTEM_DEFINE.eXianMeng then
isOpen=isOpen and xianmengModel:hasXM()
end
end
self.opens[index]=isOpen
item:SetChildButtonClick(_chooseCmp.toggle,function()
self:onClickChannel(index)
end)
item:SetChildText(_chooseCmp.name,CHAT_CHANNNEL_NAME[channelID])
item:SetChildActive(_chooseCmp.lock,not isOpen)
item:SetChildActive(_chooseCmp.tick,isOpen)
item:SetChildActive(_chooseCmp.toggleBg,not isOpen)
if isOpen then
self.selects[index]=true
end
end
end


function UITianMoJieShareWin:onHide()

end




function UITianMoJieShareWin:onBackground()
self:onCancelBtn()
end


function UITianMoJieShareWin:onCancelBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UITianMoJieShareWin:onShareBtn()
local channelIds={}
for i,v in pairs(self.selects)do
if v then
table.insert(channelIds,_channels[i])
end
end
if#channelIds>0 then
local jsonStr=""
chatControl:reqShare(CHAT_REGEX_TYPE.eTianMoJie,jsonStr,channelIds,{})
UIManager.info("分享成功")
tianMoJieModel:recordShareTime()
self:onCancelBtn()
else
UIManager.error("请先选择需要分享的频道")
end
end

function UITianMoJieShareWin:onClickChannel(index)
if self.opens[index]then
local tick=not self.selects[index]
self.selects[index]=tick
item:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_chooseCmp.tick,tick)
item:SetChildActive(_chooseCmp.toggleBg,not tick)
end
end

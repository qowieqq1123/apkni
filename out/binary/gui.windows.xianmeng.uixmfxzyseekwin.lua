







def_class("UIXMFXZYSeekWin",UIWindowBase)









function UIXMFXZYSeekWin:bindComponents()

self.background=UIButton.get(self,0)
self.seekBtn=UIButton.get(self,1)
self.numTx=UIText.get(self,2)
self.item=UIBaseItem.get(self,3)
self.desc=UIText.get(self,4)
self.tips=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.seekBtn:setButtonClick(function()self:onSeekBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXMFXZYSeekWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.seekBtn);self.seekBtn=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















function UIXMFXZYSeekWin:onLoaded(...)
self:bindComponents()
end


function UIXMFXZYSeekWin:__delete()
self:unbindComponents()
end




function UIXMFXZYSeekWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemid
self.config=cfgHelper.get1(cfg_guildaskforconfig_get,self.itemId)

local cur=xianmengModel:getSeekTimes_fenxiangziyuan()or 0
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"askfor")
self.numTx:setText(FMT.fmt("祖师还可发布<color=#C82C2C>{0}</color>条求助",max-cur))

local itemCount=self.config.max*self.config.num
local showCountBG=itemCount>1
local countStr=showCountBG and mathHelper.formatNumber(itemCount)or""
local conf={itemid=self.itemId,showCountBG=showCountBG,showStage=true,itemcount=countStr,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)

local itemName=itemsConfig.getItemName(self.itemId)
local itemColor=FONT_COLOR_VAL[itemsConfig.getItemColor(self.itemId)]
local descStr=FMT.fmt("祖师将求助<color={2}>{0}</color>个<color={2}>{1}</color>，是否立刻发布求助",itemCount,itemName,itemColor)
self.desc:setText(descStr)



end


function UIXMFXZYSeekWin:onHide()

end





function UIXMFXZYSeekWin:onBackground()
self:closeSelf()
end



function UIXMFXZYSeekWin:onSeekBtn()
local cur=xianmengModel:getSeekTimes_fenxiangziyuan()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"askfor")
if cur and cur<max then
xianmengController:req_protocol_20_42(self.itemId)
self:closeSelf()
else
UIManager.error("求助次数不足")
end
end

function UIXMFXZYSeekWin:onCloseBtn()
self:closeSelf()
end
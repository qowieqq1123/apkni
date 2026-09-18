







def_class("UIXMFXZYShareWin",UIWindowBase)









function UIXMFXZYShareWin:bindComponents()

self.background=UIButton.get(self,0)
self.shareBtn=UIButton.get(self,1)
self.numTx=UIText.get(self,2)
self.item=UIBaseItem.get(self,3)
self.desc=UIText.get(self,4)
self.rewardNum=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXMFXZYShareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewardNum);self.rewardNum=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this=nil



function UIXMFXZYShareWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXMFXZYShareWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXMFXZYShareWin:onShow(argtable,afterOnloaded)
self.data=argtable
self.config=cfgHelper.get1(cfg_guildaskforconfig_get,self.data.item)

local rewardItem=self.config.reward[1]
local showCountBG=rewardItem[2]>1
local countStr=showCountBG and mathHelper.formatNumber(rewardItem[2])or""
local conf={itemid=rewardItem[1],showCountBG=showCountBG,showStage=true,itemcount=countStr,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)

local cur=xianmengModel:getShareTimes_fenxiangziyuan()or 0
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"answer_askfor")
local least=max-cur
if least<=0 then
least=FMT.cfmt(FONT_COLOR.eRedColor,least)
end
self.numTx:setText(FMT.fmt("本日剩余分享次数：{0}",least))

local actorName=xianmengModel:getXMMemberName(self.data.actor)or""
local itemNum=self.config.num
local itemName=itemsConfig.getItemName(self.data.item)
local itemColor=FONT_COLOR_VAL[itemsConfig.getItemColor(self.data.item)]
local descStr=FMT.fmt("祖师将分享<color={3}>{0}</color>个<color={3}>{1}</color>给<color=#7D3B17>{2}</color>，可获得",itemNum,itemName,actorName,itemColor)
self.desc:setText(descStr)









end


function UIXMFXZYShareWin:onHide()

end





function UIXMFXZYShareWin:onBackground()
self:closeSelf()
end



function UIXMFXZYShareWin:onShareBtn()
local cur=xianmengModel:getShareTimes_fenxiangziyuan()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"answer_askfor")
if cur and cur<max then
local have=itemsModel.getCount(self.data.item)
local need=self.config.num
if have>=need then
xianmengController:req_protocol_20_44(self.data.guid)
self:closeSelf()
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(self.data.item)))
end
else
UIManager.error("本周分享次数已达上限")
end
end

function UIXMFXZYShareWin:onCloseBtn()
self:closeSelf()
end








def_class("UIServerTransferRewardWin",UIWindowBase)









function UIServerTransferRewardWin:bindComponents()

self.blackMask=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.receiveBtn=UIButton.get(self,2)
self.receiveFlag=UIObject.get(self,3)
self.rewardList=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.xmItem_1=UIObject.get(self,6)
self.xmItem_2=UIObject.get(self,7)
self.xmItem_3=UIObject.get(self,8)
self.xmItem_4=UIObject.get(self,9)
self.xmItem_5=UIObject.get(self,10)

self.blackMask:setButtonClick(function()self:onBlackMask()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)
self.xmItem={
self.xmItem_1,
self.xmItem_2,
self.xmItem_3,
self.xmItem_4,
self.xmItem_5,
}



end


function UIServerTransferRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackMask);self.blackMask=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveFlag);self.receiveFlag=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.xmItem_1);self.xmItem_1=nil;
_UIObject_release(self.xmItem_2);self.xmItem_2=nil;
_UIObject_release(self.xmItem_3);self.xmItem_3=nil;
_UIObject_release(self.xmItem_4);self.xmItem_4=nil;
_UIObject_release(self.xmItem_5);self.xmItem_5=nil;
self.xmItem=nil;
end


















local _this

function UIServerTransferRewardWin:onLoaded(...)
self:bindComponents()
_this=self
self:addProNotify(20,11,self.on_20_11)
end


function UIServerTransferRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UIServerTransferRewardWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
local baseCfg=cfgHelper.get1(cfg_switchserverbasicconfig_get,1)
local reward=baseCfg.reward
self.rewardList:setChildLayoutGroupCreateItems(#reward,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(reward[index])
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local conf={itemid=itemid,itemcount=countStr,showCountBG=itemnum>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end)
self:refreshRewardBtnState()
self:refreshXianMengList()
end

function UIServerTransferRewardWin:refreshRewardBtnState()
local flag=ServerTransferModel:getTransferRewardFlag()
self.receiveBtn:setActive(flag==0)
self.receiveFlag:setActive(flag~=0)
end

function UIServerTransferRewardWin:refreshXianMengList()
local list_=xianmengModel:getAllSearchXMData()
local list=xianmengModel:getSearchXMSortList(list_,2)
for idx,v in ipairs(self.xmItem)do
local data=list[idx]
if data then
v:setActive(true)
local item=v:getChildWidgetBase()
local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local name_str=data.guildname






item:SetChildText(4,name_str)

local fightnum=data.memberfight_num
item:SetChildText(5,string.format('实力：%s',mathHelper.formatNumber3(fightnum)))

item:SetChildButtonClick(6,function()
local guildid=data.guildid
xianmengController:openXMDetailInfoWin(guildid,6)
end)
else
v:setActive(false)
end
end
end

function UIServerTransferRewardWin.on_20_11()
_this:refreshXianMengList()
end


function UIServerTransferRewardWin:onCancelButton()
UIFullServerTransferControl:closeUI(true,true)
end

function UIServerTransferRewardWin:onReceiveBtn()
ServerTransferController:send_254_99()
end

function UIServerTransferRewardWin:onBlackMask()
UIFullServerTransferControl:closeUI(true,true)
end
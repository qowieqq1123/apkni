







def_class("UICaiShenJiaDaoRedPacketRewardWin",UIWindowBase)









function UICaiShenJiaDaoRedPacketRewardWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rewardList=UIObject.get(self,2)
self.tipsTx=UIText.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICaiShenJiaDaoRedPacketRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end



















function UICaiShenJiaDaoRedPacketRewardWin:onLoaded(...)
self:bindComponents()
end


function UICaiShenJiaDaoRedPacketRewardWin:__delete()
self:unbindComponents()
end




function UICaiShenJiaDaoRedPacketRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.config=argtable.config
local numStr=self.config.max_get_cnt~=nil and self.config.max_get_cnt>0 and tostring(self.config.max_get_cnt)or"不限次数"
local tipsStr=FMT.fmt("红包可供<color=#ca631d>{0}</color>位盟友领取\n每位祖师每天最多可领取<color=#ca631d>{1}</color>个红包\n每份奖励获得概率相同",self.config.cnt,numStr)
self.tipsTx:setText(tipsStr)

self.rewardList:setChildLayoutGroupCreateItems(#self.config.rand_reward_lib,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardCfg=self.config.rand_reward_lib[index]
local rewards=rewardCfg[4]
local rewardData=rewards[1]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local num=rewardCfg[3]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(0,itemProp)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildText(1,itemsConfig.getItemName(itemId))
item:SetChildText(2,FMT.fmt("数量：{0}份",num))
end)
end


function UICaiShenJiaDaoRedPacketRewardWin:onHide()

end




function UICaiShenJiaDaoRedPacketRewardWin:onBackground()
self:onCloseBtn()
end


function UICaiShenJiaDaoRedPacketRewardWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


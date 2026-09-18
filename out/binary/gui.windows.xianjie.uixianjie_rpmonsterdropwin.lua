







def_class("UIXianJie_RPMonsterDropWin",UIWindowBase)









function UIXianJie_RPMonsterDropWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.itemList=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_RPMonsterDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end















local _this=nil



function UIXianJie_RPMonsterDropWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_RPMonsterDropWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_RPMonsterDropWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

local dropCfg=cfgHelper.get(cfg_awardconfig_get,argtable.dropId)
local rewardList=dropCfg and dropCfg.detailItems or{}
local count=#rewardList
self.itemList:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.itemList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1 or rewardData.range~=nil
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=rewardData.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardData.range~=nil and rewardNum<0)
end)
self.scrollView:setChildScrollRectEnable(count>20)
end


function UIXianJie_RPMonsterDropWin:onHide()

end




function UIXianJie_RPMonsterDropWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_RPMonsterDropWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end


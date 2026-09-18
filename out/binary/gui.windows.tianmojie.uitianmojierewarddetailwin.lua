







def_class("UITianMoJieRewardDetailWin",UIWindowBase)









function UITianMoJieRewardDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.itemList_1=UIObject.get(self,2)
self.itemList_2=UIObject.get(self,3)
self.scrollView_1=UIObject.get(self,4)
self.scrollView_2=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.itemList={
self.itemList_1,
self.itemList_2,
}
self.scrollView={
self.scrollView_1,
self.scrollView_2,
}



end


function UITianMoJieRewardDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList_1);self.itemList_1=nil;
_UIObject_release(self.itemList_2);self.itemList_2=nil;
_UIObject_release(self.scrollView_1);self.scrollView_1=nil;
_UIObject_release(self.scrollView_2);self.scrollView_2=nil;
self.itemList=nil;
self.scrollView=nil;
end















local _this=nil
local _itemCmp={
item=0,
gailv=1,
teyou=2,
}



function UITianMoJieRewardDetailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UITianMoJieRewardDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UITianMoJieRewardDetailWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.monsterId=argtable.monsterId
self:refreshView()
end


function UITianMoJieRewardDetailWin:onHide()

end




function UITianMoJieRewardDetailWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UITianMoJieRewardDetailWin:onBackground()
self:onCloseBtn()
end

function UITianMoJieRewardDetailWin:refreshView()
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,self.monsterId)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
local drops=monsterGroup.drops
self:refreshRewardList(1,drops[2])
self:refreshRewardList(2,drops[1])
end

function UITianMoJieRewardDetailWin:refreshRewardList(index,drop)
local cmp=self.itemList[index]
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,drop)
local dropList=dropCfg.detailItems or{}
cmp:setChildLayoutGroupCreateItems(#dropList,function(index)
local item=cmp:getChildLayoutGroupGridItem(index-1)
local dropData=dropList[index]
local itemId=dropData[1]
local itemNum=dropData[2]
local range=dropData.range
local showCountBG=range==nil and itemNum>0
local conf={itemid=itemId,itemcount=itemNum,range=range,showname=false,showStage=true,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_itemCmp.item,prop)
item:SetBaseItemClickEvent(_itemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_itemCmp.gailv,range==nil and itemNum<0)
end)
self.winlua:SetChildScrollRectEnable(self.scrollView[index]:getID(),#dropList>6)
end
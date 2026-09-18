







def_class("UIXianJie_SGMonsterDropWin",UIWindowBase)









function UIXianJie_SGMonsterDropWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.itemList_1=UIObject.get(self,2)
self.itemList_2=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.scrollView_1=UIObject.get(self,5)
self.scrollView_2=UIObject.get(self,6)
self.synum=UIText.get(self,7)
self.scrollView_3=UIObject.get(self,8)
self.itemList_3=UIObject.get(self,9)
self.tipsText_1=UIText.get(self,10)
self.tipsText_2=UIText.get(self,11)
self.tipsText_3=UIText.get(self,12)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.itemList={
self.itemList_1,
self.itemList_2,
self.itemList_3,
}
self.scrollView={
self.scrollView_1,
self.scrollView_2,
self.scrollView_3,
}
self.tipsText={
self.tipsText_1,
self.tipsText_2,
self.tipsText_3,
}



end


function UIXianJie_SGMonsterDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList_1);self.itemList_1=nil;
_UIObject_release(self.itemList_2);self.itemList_2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView_1);self.scrollView_1=nil;
_UIObject_release(self.scrollView_2);self.scrollView_2=nil;
_UIObject_release(self.synum);self.synum=nil;
_UIObject_release(self.scrollView_3);self.scrollView_3=nil;
_UIObject_release(self.itemList_3);self.itemList_3=nil;
_UIObject_release(self.tipsText_1);self.tipsText_1=nil;
_UIObject_release(self.tipsText_2);self.tipsText_2=nil;
_UIObject_release(self.tipsText_3);self.tipsText_3=nil;
self.itemList=nil;
self.scrollView=nil;
self.tipsText=nil;
end
















local _this=nil
local _tipsStrList={
[1]="【{0}】被击败后，发现者可获得以下奖励：",
[2]="【{0}】被攻击后，攻击者可获得以下奖励：",
[3]="【{0}】被攻击后，击败者可获得以下奖励：",
}



function UIXianJie_SGMonsterDropWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_SGMonsterDropWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_SGMonsterDropWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.entityType=argtable.entityType or xjServerEnityType.eMonster
self.drop=argtable.drop
self.sgleast=argtable.sgleast
if self.sgleast then
self.synum:setText(FMT.fmt('（剩余{0}次）',self.sgleast)or'')
else
self.synum:setText('')
end

for i=1,3 do
local v=self.drop[i]
self.scrollView[i]:setActive(v~=nil)
if v then
local dropCfg=cfgHelper.get(cfg_awardconfig_get,v)
local rewardList=dropCfg and dropCfg.detailItems or{}
if i==3 then
rewardList=dropCfg and dropCfg.showItems or{}
end
local count=#rewardList
local list=self.itemList[i]
local scrollView=self.scrollView[i]
local tipsText=self.tipsText[i]
local tipsStr=_tipsStrList[i]
local name=xianjieModel:getSgMonsterTypeName()
tipsStr=FMT.fmt(tipsStr,name)
tipsText:setText(tipsStr)
list:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.itemList[i]:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local percent=rewardData[4]
local isxmkf=rewardData.isxmkf or false

local isPercent=percent~=nil
local isShowCount,countStr,range,showCountBG,countStr
if isPercent then
showCountBG=false
countStr=""
else
isShowCount=rewardNum>1 or rewardData.range~=nil
countStr=isShowCount and mathHelper.formatNumber(rewardNum)or""
range=rewardData.range
showCountBG=isShowCount
end

local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=range,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardNum==-1 and range==nil and percent==nil)

rewardItem:SetChildActive(2,isPercent)
if isPercent then
rewardItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rewardItem:SetChildActive(4,isxmkf)
end)
self.winlua:ForceLayoutRect(list:getID())

end
end

self.winlua:ForceLayoutRect(self.root:getID())
for i=1,3 do
local list=self.itemList[i]
local scrollView=self.scrollView[i]
local height1=list:getChildSizeDeltaY()
local height2=scrollView:getChildSizeDeltaY()
scrollView:setChildScrollRectEnable(height1>height2)
end
end


function UIXianJie_SGMonsterDropWin:onHide()

end




function UIXianJie_SGMonsterDropWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_SGMonsterDropWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

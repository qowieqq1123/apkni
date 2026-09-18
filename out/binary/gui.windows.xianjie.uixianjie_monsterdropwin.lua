







def_class("UIXianJie_MonsterDropWin",UIWindowBase)









function UIXianJie_MonsterDropWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.itemList_1=UIObject.get(self,2)
self.itemList_2=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.scrollView_1=UIObject.get(self,5)
self.scrollView_2=UIObject.get(self,6)
self.tipsone=UIText.get(self,7)
self.tipstwo=UIText.get(self,8)

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


function UIXianJie_MonsterDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemList_1);self.itemList_1=nil;
_UIObject_release(self.itemList_2);self.itemList_2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView_1);self.scrollView_1=nil;
_UIObject_release(self.scrollView_2);self.scrollView_2=nil;
_UIObject_release(self.tipsone);self.tipsone=nil;
_UIObject_release(self.tipstwo);self.tipstwo=nil;
self.itemList=nil;
self.scrollView=nil;
end















local _this=nil
local _changeText={
[xjServerEnityType.eMoJieBox]={'采集上古魔物宝箱可获得以下奖励','宝箱奖励'},
}



function UIXianJie_MonsterDropWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_MonsterDropWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_MonsterDropWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.entityType=argtable.entityType or xjServerEnityType.eMonster

self.ex_drop=argtable.ex_drop
self.has_ex_drop=false

if self.ex_drop then
self.ex_dropCfg=cfgHelper.get1(cfg_awardconfig_get,self.ex_drop[2])
local csid=xianjieController:getMoJieSaiJiWanFaID()
if csid then
if seasonController:checkSeasonStageBegined(csid,self.ex_drop[1])then
self.has_ex_drop=true
end
end
if self.ex_drop[1]==0 then
self.has_ex_drop=true
end
end
for i=1,2 do
local v=argtable.drop[i]
self.scrollView[i]:setActive(v~=nil)
if v then
local dropCfg=cfgHelper.get(cfg_awardconfig_get,v)
local rewardList=dropCfg and dropCfg.detailItems or{}
if i==1 and self.ex_dropCfg and self.has_ex_drop then





local ex_dropItems=self.ex_dropCfg.detailItems or{}
local rewards2=table.weakCopy(ex_dropItems)
local old_rewards=dropCfg.showItems or{}
for k,v in ipairs(old_rewards)do
table.insert(rewards2,v)
end
rewardList=rewards2
end
local count=#rewardList
local list=self.itemList[i]
local scrollView=self.scrollView[i]
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
for i=1,2 do
local list=self.itemList[i]
local scrollView=self.scrollView[i]
local height1=list:getChildSizeDeltaY()
local height2=scrollView:getChildSizeDeltaY()
scrollView:setChildScrollRectEnable(height1>height2)
end

self:changeNameText(self.entityType)
end


function UIXianJie_MonsterDropWin:onHide()

end




function UIXianJie_MonsterDropWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_MonsterDropWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

function UIXianJie_MonsterDropWin:changeNameText(entityType)
if entityType then
local temp=_changeText[entityType]
if temp then
self.tipsone:setText(temp[1]or'征讨奖励')
self.tipstwo:setText(temp[2]or'击杀魔物可获得以下奖励')
end
end
end

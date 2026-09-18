







def_class("UIBlueDiamondLevelRewardTipsWin",UIWindowBase)









function UIBlueDiamondLevelRewardTipsWin:bindComponents()

self.Content=UIObject.get(self,0)
self.mbg=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.ScrollerView=UIObject.get(self,3)
self.titleText=UIText.get(self,4)



end


function UIBlueDiamondLevelRewardTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this




function UIBlueDiamondLevelRewardTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBlueDiamondLevelRewardTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBlueDiamondLevelRewardTipsWin:onShow(argtable,afterOnloaded)
local list=argtable.list
local len=#list

local iconInfo=playerModel:getActorIconInfo()
local info=playerModel.getBlueinfo(iconInfo.blueinfo)

self.ScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
local widget=grids[i-1]

local conf=list[i]

local level=self:getLevel(conf.conditions)
local iconname=blueDiamondModel.getBuleDiamondIcon({level=level})
widget:SetChildCSImageSprite(0,globalABLookup.bluediamondIcon,iconname)
widget:SetChildActive(1,level==info.level)

local rewards=rechargeModel:getXianGouLiBaoRewards(conf.rewards)
local len=#rewards
widget:SetChildSizeDelta(2,len*84,82)
widget:SetChildLayoutGroupCreateItems(2,len,function(index)
local item=widget:GetChildLayoutGroupGridItem(2,index-1)

local itemID=rewards[index][1]
local num=rewards[index][2]
local str=''
if num>0 then
str=tostring(num)
end
local graynum=0
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)self:onGoodItemClick(...)end)
end)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6195,1,nil,eAnimationID.enter,false,false,0)
self:delayDo(0.3,function()
if not _this then return end
_this.root:setChildCanvasGroupDOFade(1,0.5,nil)
end)
end
end

function UIBlueDiamondLevelRewardTipsWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end


function UIBlueDiamondLevelRewardTipsWin:onHide()

end

function UIBlueDiamondLevelRewardTipsWin:getLevel(conditions)
if conditions==nil then
return 0
end
for i,v in pairs(conditions)do
if v[1]==8 then
return v[2]
end
end
return 0
end




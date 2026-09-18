







def_class("UITouZiXianShuRewardChangeWin",UIWindowBase)









function UITouZiXianShuRewardChangeWin:bindComponents()

self.goUpLevel=UIButton.get(self,0)
self.modelBg=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.scrollview=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)

self.goUpLevel:setButtonClick(function()self:onGoUpLevel()end)



end


function UITouZiXianShuRewardChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.goUpLevel);self.goUpLevel=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UITouZiXianShuRewardChangeWin:onLoaded(...)
self:bindComponents()
end


function UITouZiXianShuRewardChangeWin:__delete()
self:unbindComponents()
end




function UITouZiXianShuRewardChangeWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
self.modelBg:setChildUIModelShowTarget(6153,1,nil,eAnimationID.enter,false,false,0.2)
self:delayDo(0.3,function()
self.uiRoot:setChildCanvasGroupDOFade(1,1)
end)
end

local xsID=UIXianShuControl:getCurrentId()
local rewardChangeItemList=cfgHelper.get2(cfg_fairybookconfig_get,xsID,'rewardChangeItemList')or{}

local rewardLen=#rewardChangeItemList
self.scrollview:setChildScrollViewCreateGrids(rewardLen,rewardLen)

self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count

local item,data
local itemNum,isNew
local propData
local showCountBg=false
local conf={itemid=0,itemcount=0,showCountBG=false,showStage=true,showname=false}
for i=1,count do
item=self.grids[i-1]
data=rewardChangeItemList[i]

local itemId=data[1]
itemNum=data[2]
isNew=data[3]==1

showCountBg=itemNum>1

conf.itemid=itemId
conf.itemcount=itemNum
conf.showCountBG=showCountBg

propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetChildActive(1,isNew)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemId)
end)
end
end


function UITouZiXianShuRewardChangeWin:onHide()

end





function UITouZiXianShuRewardChangeWin:onGoUpLevel()
self:onCloseBtn()
UIManager:showWindow('UIXianShuActiveWin')
end

function UITouZiXianShuRewardChangeWin:onCloseBtn()
self:closeSelf()
UIXianShuControl:writeLocalRewardChangeItem()
end


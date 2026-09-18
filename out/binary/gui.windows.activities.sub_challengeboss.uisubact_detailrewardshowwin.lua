







def_class("UISubAct_detailRewardShowWin",UIWindowBase)









function UISubAct_detailRewardShowWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.itemPanel=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_detailRewardShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end



















function UISubAct_detailRewardShowWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_detailRewardShowWin:__delete()
self:unbindComponents()
end




function UISubAct_detailRewardShowWin:onShow(argtable,afterOnloaded)
local reward=argtable.rewardList
if reward then
self:showItemPanel(reward)
end
end


function UISubAct_detailRewardShowWin:onHide()

end

function UISubAct_detailRewardShowWin:sortReward(itemsList)
local list=itemsList
local fun=function(itemid)
local cfg=itemsConfig.getConfig(itemid)
return cfg.color
end

table.sort(list,function(a,b)
return fun(a[1])>fun(b[1])
end)
return list
end

function UISubAct_detailRewardShowWin:showItemPanel(args)
local itemList=self:sortReward(args)
if itemList then
local count=#itemList
self.itemPanel:setChildScrollViewCreateGrids(count,9)
local grids=self.itemPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]

if reward then
local rewardNum=reward[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1

local gray=0
local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=true,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,self.onClickItem)
item:SetChildPropData(2,prop)
item:SetChildActive(0,false)
else
item:SetChildActive(1,false)
end
end
end
end

function UISubAct_detailRewardShowWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end




function UISubAct_detailRewardShowWin:onBackground()
self:closeSelf()
end


function UISubAct_detailRewardShowWin:onCloseBtn()
self:closeSelf()
end


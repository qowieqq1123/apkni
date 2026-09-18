







def_class("UISubAct_tanbaoge_percentWin",UIWindowBase)









function UISubAct_tanbaoge_percentWin:bindComponents()

self.list=UIObject.get(self,0)



end


function UISubAct_tanbaoge_percentWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end



















function UISubAct_tanbaoge_percentWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_tanbaoge_percentWin:__delete()
self:unbindComponents()
end




function UISubAct_tanbaoge_percentWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

local floorNumMin=argtable.floorNumMin
local floorNumMax=argtable.floorNumMax
local floorNumMin_ignoreLoop=argtable.floorNumMin_ignoreLoop

local showCount=floorNumMax-floorNumMin

local datas=self.config.reward_percent_floor
self.list:setChildLayoutGroupCreateItems(showCount)
local grids=self.list:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[showCount-i]
local dataIndex=floorNumMin_ignoreLoop+i
local data=datas[dataIndex]
if data then
widget:SetChildActive(-1,true)
local layerCfg=self.config.layerList[dataIndex]
local keyItemId=layerCfg and layerCfg[1]or nil
local isGold=layerCfg and layerCfg[2]==1 or false

local floorNum=floorNumMin+i
local floorStr=FMT.fmt("第{0}层",floorNum)
widget:SetChildText(0,floorStr)

local rewards=data
local canSelectRewardItem=layerCfg[7]==1
local selectRewardItemId=self.activityData:getSelectRewardItemIdByFloorNum(floorNum)
local hasSelect=not canSelectRewardItem or selectRewardItemId~=nil
if hasSelect and canSelectRewardItem then
local selectItemList=self.config.zxReward
local selectRewardItemCount=1
for _,v in ipairs(selectItemList)do
local itemId=v[1]
local itemCount=v[2]
if itemId==selectRewardItemId then
selectRewardItemCount=itemCount
break
end
end
rewards={{selectRewardItemId,selectRewardItemCount,10000}}
end

widget:SetChildActive(2,not hasSelect)
widget:SetChildActive(1,hasSelect)
if hasSelect then

widget:SetChildLayoutGroupCreateItems(1,#rewards)
local itemGrids=widget:GetChildLayoutGroupGridList(1)
for itemIdx=1,itemGrids.Count do
local item=itemGrids[itemIdx-1]
local itemData=rewards[itemIdx]
local rewardId=itemData[1]
local rewardNum=itemData[2]
local rewardPercent=itemData[3]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
item:SetChildText(2,FMT.fmt("{0}%",rewardPercent/100))

local isKey=keyItemId and rewardId==keyItemId or false
item:SetChildActive(3,isKey and not isGold)
end
end

else
widget:SetChildActive(-1,false)
end
end
end


function UISubAct_tanbaoge_percentWin:onHide()

end




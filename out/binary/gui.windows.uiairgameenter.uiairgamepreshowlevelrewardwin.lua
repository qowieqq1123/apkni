







def_class("UIAirGamePreShowLevelRewardWin",UIWindowBase)









function UIAirGamePreShowLevelRewardWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.rewardlist=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)



end


function UIAirGamePreShowLevelRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIAirGamePreShowLevelRewardWin:onLoaded(...)
self:bindComponents()
end


function UIAirGamePreShowLevelRewardWin:__delete()
self:unbindComponents()
end




function UIAirGamePreShowLevelRewardWin:onShow(argtable,afterOnloaded)
self.list=argtable.list

local len=#self.list

local contentHeight=0

local heightList={}

for index=1,len do
local rewardInfo=self.list[index]
local rlist=rewardInfo[2]

local rlen=#rlist

local height=0
local rowLen=Mathf.Ceil(rlen/4)
local listHeight=rowLen*82+(rowLen-1)*5
height=listHeight+50

contentHeight=contentHeight+height

heightList[#heightList+1]=height
end

local createFunc=function(index)
local item=self.rewardlist:getChildLayoutGroupGridItem(index-1)

local rewardInfo=self.list[index]
local type=rewardInfo[1]
local rlist=rewardInfo[2]

local rlen=#rlist

local title=type==1 and"解锁武器"or"解锁宝物"
item:SetChildText(0,title)

local rewardCreateFunc=function(rindex)
local ritem=item:GetChildLayoutGroupGridItem(1,rindex-1)
local rdata=rlist[rindex]
local itemId=rdata

local itemCfg,itemType=airGameEnterConfig.getAirItemCfg(itemId)

local iconName=iconHelper.getItemIconName(itemCfg.icon)

local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemCfg.color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=""
prop[PropIndex(DataPropKey.eWidgetText,4)]=""
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false

prop[DataPropKey.eItemID]=itemId
ritem:SetChildPropData(-1,prop)
ritem:SetBaseItemClickEvent(-1,function()
self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=itemType,fromType=1})
end)
end
item:SetChildLayoutGroupCreateItems(1,rlen,rewardCreateFunc)

item:SetChildSizeDelta(-1,372,heightList[index])
end
self.rewardlist:setChildLayoutGroupCreateItems(len,createFunc)

self.rewardlist:setChildSizeDelta(372,contentHeight)
end


function UIAirGamePreShowLevelRewardWin:onHide()

end




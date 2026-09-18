







def_class("tipsChildFubaoFJReward",UICloneObject)





tipsChildFubaoFJReward.abName="ui/windows/tips/child/tipschildfubaofjreward.ab"

tipsChildFubaoFJReward.assetName="tipsChildFubaoFJReward"


function tipsChildFubaoFJReward:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildFubaoFJReward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildFubaoFJReward:onLoaded(...)
self:bindComponents()
self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildFubaoFJReward:__delete()
self:unbindComponents()
end




function tipsChildFubaoFJReward:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid

local itemConfig=itemsConfig.getConfig(itemid)

local decompose=itemConfig.decomposeItems
self.scrollview:setChildScrollViewCreateGrids(#decompose,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local reward=decompose[i]
local rId=reward[1]
local count=reward[2]
local iconname=iconHelper.getIconName(rId)
item:SetChildCSImageIcon(1,iconname,false)
item:SetChildText(2,count)
end
end


function tipsChildFubaoFJReward:onHide()

end



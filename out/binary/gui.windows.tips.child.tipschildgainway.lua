







def_class("tipsChildGainWay",UICloneObject)





tipsChildGainWay.abName="ui/windows/tips/child/tipschildgainway.ab"

tipsChildGainWay.assetName="tipsChildGainWay"


function tipsChildGainWay:bindComponents()

self.scrollview=UIObject.get(self,0)

end


function tipsChildGainWay:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
end








local cmpIndex=
{
title=0,
desc=1,
button=2,
unLock=3,
icon=4,
}

local globalab="ui/sharedtextures/uiglobalspriteatlas_1.ab"

local iconName=
{
"icon_zhuyao_1",
"image_dysuo_1",
"icon_tyshijian",
}



function tipsChildGainWay:onLoaded(...)
self:bindComponents()
end


function tipsChildGainWay:__delete()
self:unbindComponents()
end






function tipsChildGainWay:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)

local gainWays=itemConfig.gainWay or{}
local lenth=#gainWays
local count=lenth>3 and 3 or lenth
if count<=0 then
self:recycleSelf()
return
end
self.scrollview:setChildScrollViewCreateGrids(count,1)

local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local gainWay=gainWays[i]
if gainWay then
item:SetChildText(cmpIndex.title,gainWay.title)
item:SetChildText(cmpIndex.desc,gainWay.subtitle)
item:SetChildActive(cmpIndex.icon,false)
if gainWay.isMain and gainWay.isMain==1 then
item:SetChildActive(cmpIndex.icon,true)
item:SetChildCSImageSprite(cmpIndex.icon,globalab,iconName[1])
end

local sysid=gainWay.limitSystem
if sysid then
local unLock=self:checkGainIsUnLock(sysid)
item:SetChildActive(cmpIndex.button,unLock)
item:SetChildText(cmpIndex.unLock,(not unLock)and"<color=#a18cfd>未解锁</color>"or"")
if not unLock then
item:SetChildActive(cmpIndex.icon,true)
item:SetChildCSImageSprite(cmpIndex.icon,globalab,iconName[2])
end
end

item:SetChildButtonClick(2,function(...)
local jumpParam=gainWay.jump
jumpManager:jump(jumpParam)
end)
end
end


end

function tipsChildGainWay:checkGainIsUnLock(sysid)
if sysid then
return systemModel.isOpen(sysid)
end
return true
end


function tipsChildGainWay:onHide()

end



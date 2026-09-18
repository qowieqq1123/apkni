







def_class("tipsChildDesc",UICloneObject)





tipsChildDesc.abName="ui/windows/tips/child/tipschilddesc.ab"

tipsChildDesc.assetName="tipsChildDesc"


function tipsChildDesc:bindComponents()

self.desc=UIText.get(self,0)
self.countPanel=UIObject.get(self,1)
self.countText=UIText.get(self,2)
self.descEx=UIText.get(self,3)
self.descLayout=UIObject.get(self,4)

end


function tipsChildDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.descEx);self.descEx=nil;
_UIObject_release(self.descLayout);self.descLayout=nil;
end





function tipsChildDesc:onLoaded()
self:bindComponents()
end

function tipsChildDesc:__delete()
self:unbindComponents()
end

function tipsChildDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)

local descInfo=string.split(itemConfig.desc,"\n\n<color=#9999FF>【用途】</color>")
self.desc:setText(descInfo[1])

local len=#descInfo
local descStr
if len>1 then
for i=2,len do
local str=descInfo[i]
if str and str~=""then
if not descStr then
descStr=str
else
descStr=FMT.fmt('{0}\n{1}',descStr,str)
end
end
end
end
local showDescEx=descStr~=nil and descStr~=""
self.descEx:setActive(showDescEx)
if showDescEx then
self.descEx:setText(descStr)
end
local showCount=itemConfig.dup and itemConfig.dup>1 and not itemConfig.hideTipsHasNum and not attach.hideTipsHasNum
self.countPanel:setActive(showCount)
if showCount then
local itemCount=bagModel.getItemCountById(itemid)
local isExpire=bagUseControl.isItemExpire(itemguid)
local NotExpireCount=bagModel.getNotExpireItemCountById(itemid)
if isExpire then
self.countText:setText(FMT.fmt('<color=#c82c2c>已过期：{0}</color>',itemCount-NotExpireCount))
else
self.countText:setText(FMT.fmt('拥有：{0}',NotExpireCount))
end
end

self.widget:SetChildLayoutElementEnable(self.descLayout:getID(),false)
end

function tipsChildDesc:onFreshed()
local descHeight=self.desc:getChildRectHeight()
if descHeight>=360 then
self.widget:SetChildLayoutElementEnable(self.descLayout:getID(),true)
self.widget:SetChildLayoutElementPreferredHeight(self.descLayout:getID(),360)
end
end
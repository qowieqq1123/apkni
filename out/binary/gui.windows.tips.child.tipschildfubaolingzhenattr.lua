







def_class("tipsChildFubaoLingZhenAttr",UICloneObject)





tipsChildFubaoLingZhenAttr.abName="ui/windows/tips/child/tipschildfubaolingzhenattr.ab"

tipsChildFubaoLingZhenAttr.assetName="tipsChildFubaoLingZhenAttr"


function tipsChildFubaoLingZhenAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildFubaoLingZhenAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildFubaoLingZhenAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildFubaoLingZhenAttr:__delete()
self:unbindComponents()
end




function tipsChildFubaoLingZhenAttr:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local attach=argData.attach

if not systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
self:recycleSelf()
return
end

local isOther=false
local data=UIYuFuLingZhenControl:getLingZhenData(itemguid)
if not data then
local equip=equipsHelper.getEquip(itemguid)
if equip then
if equip.itemData and equip.itemData.lzItem then
local zItem=equip.itemData.lzItem

if zItem and zItem.zhentuId~=0 then
local list={}
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if vv.itemId>0 then
list[vv.index]=vv
end
end
end
data={yufuGuid=itemguid,zhentuId=zItem.zhentuId,len=zItem.len,kongList=list,other=true}
isOther=true
end
end
end
end

if data and data.zhentuId>0 then
self.title:setText("灵阵属性")


local attrDatas,diziAttr=UIYuFuLingZhenControl:countAllAttr(itemid,itemguid,isOther and data or nil)

local list={}
for k,v in pairs(attrDatas)do
table.insert(list,{k,v})
end

local diziAttrLen=#diziAttr

local len=#list

if len+diziAttrLen==0 then
self:emptylingzhen()
return
end

self.scrollview:setChildScrollViewCreateGrids(len+diziAttrLen,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
for i=1,len do
local item=grids[i-1]
local attr=list[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(0,FMT.fmt("{0}：{1}",name,str))
end

for i=len+1,len+diziAttrLen do
local item=grids[i-1]
local attr=diziAttr[i-len]
item:SetChildText(0,attr)
end
else
self:emptylingzhen()
end

end

function tipsChildFubaoLingZhenAttr:emptylingzhen()
self.title:setText("阵图灵阵")
self.scrollview:setChildScrollViewCreateGrids(1,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,'未布置阵图')
end
end


function tipsChildFubaoLingZhenAttr:onHide()

end



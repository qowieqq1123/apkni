







def_class("tipsChildLingZhenAttr",UICloneObject)





tipsChildLingZhenAttr.abName="ui/windows/tips/child/tipschildlingzhenattr.ab"

tipsChildLingZhenAttr.assetName="tipsChildLingZhenAttr"


function tipsChildLingZhenAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildLingZhenAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildLingZhenAttr:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
end


function tipsChildLingZhenAttr:__delete()
self:unbindComponents()
end




function tipsChildLingZhenAttr:onShow(argtable,afterOnloaded)
local argData=argtable.argtable
local itemid=argData.itemid
local itemguid=argData.itemguid
local attach=argData.attach

local cfg=itemsConfig.getConfig(itemid)
local isSPItem=cfg.type1==6
if isSPItem then
self.title:setText('基础属性')
local baseAttr=cfg.baseAttr


local strList={}
for i,v in ipairs(baseAttr)do
local l=self:getItemDescList(v)
strList=table.concatTableX(strList,l)
end

self.scrollview:setChildScrollViewCreateGrids(#strList,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]





item:SetChildText(0,strList[i])
end
else
self.title:setText('镶嵌属性')

local level=attach.level
if not level then
level=UIYuFuLingZhenControl:getItemLevel(itemid)
end

local attrs=UIYuFuLingZhenControl:getAttrs(itemid)
self.scrollview:setChildScrollViewCreateGrids(#attrs,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=attrs[i]

local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(0,FMT.fmt('{0}：{1}',name,str))
end
end
end

function tipsChildLingZhenAttr:getItemDescList(levelAttr)
local strList={}
local baseCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"levelAttrDesc")or{}
local percent,wuxing
if levelAttr[1]==2 then
local attrList=levelAttr[2]

for i,v in ipairs(attrList)do
local name,str=equipsHelper.getAttr(v[1],v[2])
table.insert(strList,FMT.fmt('{0}：{1}',name,str))
end
else
local str=baseCfg[1]or""
percent=levelAttr[1]==1 and 100 or 1
if str then

if levelAttr[2]==0 then
str=str[2]
table.insert(strList,FMT.fmt(str,percent*levelAttr[3]))
else
str=str[1]
wuxing=UIYuFuLingZhenControl.data.prefix[levelAttr[2]]
table.insert(strList,FMT.fmt(str,percent*levelAttr[3],wuxing))
end

end
end

return strList
end


function tipsChildLingZhenAttr:onHide()

end



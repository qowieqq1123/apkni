







def_class("shenShiPoint",UICloneObject)





shenShiPoint.abName="ui/windows/fight/shenshipoint.ab"

shenShiPoint.assetName="shenShiPoint"


function shenShiPoint:bindComponents()

self.shenShiRoot=UIObject.get(self,0)

end


function shenShiPoint:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.shenShiRoot);self.shenShiRoot=nil;
end









function shenShiPoint:onLoaded(...)
self:bindComponents()
end


function shenShiPoint:__delete()
self:unbindComponents()
self.lastBuff={}
end




function shenShiPoint:onShow(argtable,afterOnloaded)
self.parent=argtable.parent
self.ent=self.parent.ent
self.lastBuff={}
self:refreshShenShi()
end


function shenShiPoint:onHide()

end

function shenShiPoint:refreshShenShi()
if not self or self.isClose or not self.shenShiRoot then return end
if not self.ent then
self.ent=self.parent.ent
end

if self.ent then
local config=cfgHelper.get(cfg_spdiziskillhudconfig_get,2,"args")
local buffList=self.ent.buff
local activeBuff={}
local newBuff={}
local buffLookup={}
for i,v in pairs(buffList or defaultT)do
if config[v.id]then
local img=config[v.id]
if not self.lastBuff[v.id]then
newBuff[img]=v.id
end
buffLookup[v.id]=img
table.insert(activeBuff,{img,v.id})
end
end
if next(newBuff)then
table.sort(activeBuff,function(a,b)
return a[2]<b[2]
end)
end
self.lastBuff=buffLookup

self.shenShiRoot:setChildLayoutGroupCreateItems(5)
local grids=self.shenShiRoot:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local huase=activeBuff[i]
if huase then
grid:SetChildActive(0,true)
grid:SetChildCSImageSprite(0,"ui/windows/fight/shenshi_atlas_pak.ab",huase[1])
if newBuff[huase[1]]then
grid:SetChildShowEffect(2,5093,true)
end
else
grid:SetChildActive(0,false)
end
end
end

end



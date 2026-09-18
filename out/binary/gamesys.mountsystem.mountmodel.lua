






local _MODULENAME="mountModel"


def_table(_MODULENAME)
mountModel.name=_MODULENAME
mountModel.data={}

function mountModel:onAppStart()

end


function mountModel:onEnterState(isReconnect)
self:resetData()
end


function mountModel:onLeaveState(isReconnect)
self:resetData()
end

function mountModel:onProtocolReq()

end


function mountModel:resetData()
self.mounts={}
self.mountsLookup={}
self.attrsLookup={}
self.dzLookup={}
end

function mountModel:initMount(diziArray)
self.mounts={}
self.mountsLookup={}
for i,v in ipairs(diziArray)do
self:addNewDZ(v)
end
end

function mountModel:deleDZ(dzguid)
self:deleteMount(dzguid)
end

function mountModel:addNewDZ(dizidata,showFightTips)
if self.mounts==nil then self.mounts={}end
if self.mountsLookup==nil then self.mountsLookup={}end
local dzguid=dizidata.discipleguid
local array=dizidata.mountList or{}
for i,v in ipairs(array)do
self:addMount(dzguid,v,showFightTips)
end
end

function mountModel:addMount(dzguid,item,showFightTips)
local dzguidStr=tostring(dzguid)
local litem=self.mountsLookup[dzguidStr]
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then
return
end

local itemguid=item.itemguid
local itemid=item.itemid
self.mountsLookup[dzguidStr]=item
self.mounts[tostring(item.itemguid)]=item
self.dzLookup[tostring(item.itemguid)]=dzguid
mountHelper.freshRoleMoveMount(dzguid)
self:onChangeAttrsOnMount(dzguid,itemguid,itemid,showFightTips)
end

function mountModel:deleteMount(dzguid)
local dzguidStr=tostring(dzguid)
local item=self.mountsLookup[dzguidStr]
if item==nil then return false end
self.mountsLookup[dzguidStr]=nil
local itemguid=item.itemguid
self.mounts[tostring(itemguid)]=nil
self.dzLookup[tostring(itemguid)]=nil
self:onChangeAttrsOnMount(dzguid,itemguid,item.itemid,true)
return true
end

function mountModel:changeMount(dzguid,item,showFightTips)
local dzguidStr=tostring(dzguid)
local litem=self.mountsLookup[dzguidStr]
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then
return
end

if litem then
local oldguid=litem.itemguid
local oldguidStr=tostring(oldguid)
self.mounts[oldguidStr]=nil
self.dzLookup[oldguidStr]=nil
end

local itemguid=item.itemguid
local itemid=item.itemid
local newguidStr=tostring(itemguid)
self.mountsLookup[dzguidStr]=item
self.mounts[newguidStr]=item
self.dzLookup[newguidStr]=dzguid
mountHelper.freshRoleMoveMount(dzguid)
self:onChangeAttrsOnMount(dzguid,itemguid,itemid,showFightTips)
end

function mountModel:getMount(itemguid)
return self.mounts[tostring(itemguid)]
end

function mountModel:getMountByDZ(dzguid)
local dzguidStr=tostring(dzguid)
if self.mountsLookup[dzguidStr]==nil then return end
return self.mountsLookup[dzguidStr]
end

function mountModel:getMountIdByDZ(dzguid)
local mount=self:getMountByDZ(dzguid)
if mount then
return mount.itemid
end
end

function mountModel:getDzguidByItemguid(itemguid)
return self.dzLookup[tostring(itemguid)]
end


function mountModel:onDress(dzguid,itemguid)
local item=bagModel.getItem(itemguid)
if item==nil then
loggerUtil.logErrFMT('背包不存在此装备',tostring(itemguid))
return
end
self:addMount(dzguid,item,true)
end

function mountModel:onTakeoff(dzguid)
local equip=self:getMountByDZ(dzguid)
if equip==nil then return end
self:deleteMount(dzguid)
end

function mountModel:isEquipedOnAnyDZ(itemguid)
return self:getDzguidByItemguid(itemguid)~=nil
end

function mountModel:isEquipedItemIdOnAnyDZ(itemid)
for _,item in ipairs(self.mountsLookup)do
if item.itemid==itemid then return true end
end
return false
end


function mountModel:isEquipedOnDZ(dzguid,itemguid)
local item=self:getMountByDZ(dzguid)
if item and tostring(item.itemguid)==tostring(itemguid)then
return true
end
return false
end



function mountModel:onChangeAttrsOnMount(dzguid,itemguid,itemid,showFightTips)
local dzguidStr=tostring(dzguid)
if self.attrsLookup[dzguidStr]==nil then self.attrsLookup[dzguidStr]={}end

local newLookup=nil
local mount=self:getMount(itemguid)
if mount~=nil then
newLookup=mountHelper.getAttrsLookupByItemguid(itemid)
end

local oldLookup=self.attrsLookup[dzguidStr]

self.attrsLookup[dzguidStr]=newLookup

equipsHelper.printAttrListChange(oldLookup,newLookup,'单件坐骑：')

UIDiscipleModel:setDiscipleAttrListDirtyX(dzguid,DISCIPLE_ATTRIBUTE_TYPE.eMount,showFightTips)
end

function mountModel:getAttrsLookup(dzguid)
local dzguidStr=tostring(dzguid)
if self.attrsLookup[dzguidStr]==nil then return{}end
return self.attrsLookup[dzguidStr]
end


function mountModel:getMountByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(self.mounts,filter,useCache)
end


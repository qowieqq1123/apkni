







def_class("UIDiscipleListComponent",UIWindowBase)









function UIDiscipleListComponent:bindComponents()

self.root=UIObject.get(self,0)
self.discipleList=UIScrollView.get(self,1)



end


function UIDiscipleListComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
end



















function UIDiscipleListComponent:onLoaded(...)
self:bindComponents()

self.discipleList:setClickAction(function(...)self:onSelectDZ(...)end)
end


function UIDiscipleListComponent:__delete()
self:unbindComponents()
end




function UIDiscipleListComponent:onShow(argtable,afterOnloaded)
self.discipleList:setActive(true)
local dzguid=argtable.guid
self.pageIndex=argtable.pageIndex
self.sortType=argtable.sortType
self.checkClothing=argtable.checkClothing
self:freshDZList(dzguid,afterOnloaded)
self:onSelect(dzguid,afterOnloaded)
end


function UIDiscipleListComponent:onHide()
self.discipleList:setActive(false)
end

function UIDiscipleListComponent:getDiscipleList()
local sortType=self.sortType or UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}

if self.checkClothing then
if sortCondition then
sortCondition[3]=1
else
sortCondition={[3]=1}
end
end
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
return list
end

function UIDiscipleListComponent:freshDZList(_dzguid,isInit)
if not self.dzlist then
self.dzlist=self:getDiscipleList()
isInit=true
end
local tNum=#self.dzlist
if isInit then
self.discipleList:freshGridsNum(tNum,tNum,1,true)
end

for i=1,tNum do
local info=self.dzlist[i]
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=info.netData.net
local dzguid=netdata.discipleguid



comHelper.setChildModelHeadIconBG(item,0,dzguid)

comHelper.setChildModelRawImage(item,dzguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.dzguid or _dzguid,dzguid)
item:SetChildActive(3,isSelect)
item:SetChildActive(2,false)
item:SetBaseItemChildGUID(-1,dzguid)
end
end

function UIDiscipleListComponent:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end


function UIDiscipleListComponent:onSelect(dzguid,isInit,needJump2Select)
if mathHelper.compareInt64(self.dzguid,dzguid)then return end

self.dzguid=dzguid
local selectIdx=self.selectIdx
self.selectIdx=self:getDZIdx(dzguid)


if isInit or needJump2Select then
if selectIdx~=self.selectIdx then
self.discipleList:jumpToLockX(self.selectIdx)
end
end

if not isInit then

oneTabScreenController:changeArgs({guid=self.dzguid})
oneTabScreenController:selectTabView(self.pageIndex,true)
end
end

function UIDiscipleListComponent:getDZIdx(dzguid)
for i,v in pairs(self.dzlist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,dzguid)then
return i
end
end
end


function UIDiscipleListComponent:onSelectDZ(id,index,guid,attach)
if mathHelper.compareInt64(guid,self.dzguid)then return end


local oldIdx=self.selectIdx
local newIdx=index
self.selectIdx=newIdx
if oldIdx then
local olditem=self.discipleList:getGridObjectByindex(oldIdx-1)
self:changItemSelect(olditem,false)
end
local newitem=self.discipleList:getGridObjectByindex(newIdx-1)
self:changItemSelect(newitem,true)


self:onSelect(guid)
end

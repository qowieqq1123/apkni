







def_class("UIWorldMapFilterWin",UIWindowBase)









function UIWorldMapFilterWin:bindComponents()

self.filtterGrid=UIObject.get(self,0)
self.selectGrid=UIObject.get(self,1)
self.allToggle=UIToggleButton.get(self,2)



end


function UIWorldMapFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.filtterGrid);self.filtterGrid=nil;
_UIObject_release(self.selectGrid);self.selectGrid=nil;
_UIObject_release(self.allToggle);self.allToggle=nil;
end
















local lockChange=false




function UIWorldMapFilterWin:onLoaded(...)
self:bindComponents()
end


function UIWorldMapFilterWin:__delete()
self:unbindComponents()
end


function UIWorldMapFilterWin:onHide()

end




function UIWorldMapFilterWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
lockChange=false
self.saveFiltter=worldMapModel:getMapfiltter()
self.selectIndex=1

self:initView()
self:updateFiltterGrid()
end

function UIWorldMapFilterWin:initView()

self.selectList={}
for k,v in pairs(worldInfoFiltterGroupType)do
table.insert(self.selectList,v)
end
table.sort(self.selectList,function(a,b)
return a<b
end)

local num=#self.selectList
self.selectGrid:setChildLayoutGroupCreateItems(num)
local selectWidgetList=self.selectGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=selectWidgetList[i-1]
local groupType=self.selectList[i]
item:SetChildActive(0,self.selectIndex==i)
item:SetChildText(1,cfgHelper.getdef2(cfg_worldinfofiltterconfig,'groupName',groupType))
item:SetChildButtonClick(2,function()
self:onSelectItemClick(i)
end)
end

self.allToggle:setToggleChange(function(name,ison,data)
self:onAllToggleChange(ison)
end)
end

function UIWorldMapFilterWin:updateAllToggle()
local all=true
for i,v in ipairs(self.filtterlist)do
if self.saveFiltter[tostring(v.filtterType)]~=true then
all=false
break
end
end
if self.allToggleFlag~=all then
self.allToggleFlag=all
self.allToggle:setToggle(self.allToggleFlag)
end
end

function UIWorldMapFilterWin:updateFiltterGrid()
self.filtterlist={}
local groupType=self.selectList[self.selectIndex]
if groupType==worldInfoFiltterGroupType.eAll then
for i,v in pairsBySortKey(self.selectList)do
if v~=worldInfoFiltterGroupType.eAll then
local group=cfgHelper.get1(cfg_worldinfofiltterconfig_get,v)
for i,v in pairsBySortKey(group)do
table.insert(self.filtterlist,v)
end
end
end
else
local group=cfgHelper.get1(cfg_worldinfofiltterconfig_get,groupType)
for i,v in pairsBySortKey(group)do
table.insert(self.filtterlist,v)
end
end

local num=#self.filtterlist
self.filtterGrid:setChildLayoutGroupCreateItems(num)
local filtterWidgetList=self.filtterGrid:getChildLayoutGroupGridList()

lockChange=true
for i=1,num do
local item=filtterWidgetList[i-1]
local cfg=self.filtterlist[i]
local filtterType=cfg.filtterType

item:SetChildText(1,cfg.filtterName)
item:SetChildToggle(2,self.saveFiltter[tostring(filtterType)]==true)
item:SetChildToggleChange(2,function(name,ison,data)
self:onFiltterToggleChange(i,ison)
end)
end
self:updateAllToggle()
lockChange=false
end

function UIWorldMapFilterWin:onSelectItemClick(idx)
if self.selectIndex==idx then return end

local old=self.selectIndex
self.selectIndex=idx
local oldItem=self.selectGrid:getChildLayoutGroupGridItem(old-1)
oldItem:SetChildActive(0,false)
local item=self.selectGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildActive(0,true)

self:updateFiltterGrid()
end

function UIWorldMapFilterWin:onFiltterToggleChange(idx,ison)
if lockChange then return end
local cfg=self.filtterlist[idx]
local filtterType=cfg.filtterType
local str_key=tostring(filtterType)
if self.saveFiltter[str_key]==nil then
self.saveFiltter[str_key]=false
end
if self.saveFiltter[str_key]~=ison then
self.saveFiltter[str_key]=ison
self:saveMapfiltter()

lockChange=true
self:updateAllToggle()
lockChange=false

self:onFiltterChange({filtterType})
end
end

function UIWorldMapFilterWin:onAllToggleChange(ison)
if lockChange then return end

self.allToggleFlag=ison

local changelist={}
lockChange=true
for i,v in ipairs(self.filtterlist)do
local filtterType=v.filtterType
local str_key=tostring(filtterType)
local flag=self.saveFiltter[str_key]
if flag==nil then flag=false end
if flag~=ison then
self.saveFiltter[str_key]=ison
local filtterItem=self.filtterGrid:getChildLayoutGroupGridItem(i-1)
filtterItem:SetChildToggle(2,ison)
table.insert(changelist,filtterType)
end
end
lockChange=false
if#changelist>0 then
self:saveMapfiltter()
self:onFiltterChange(changelist)
end
end

function UIWorldMapFilterWin:onFiltterChange(changelist)
if self.callback then
local list=worldMapModel:getMapfiltterlistEx(self.saveFiltter)
self.callback(list,changelist)
end
end

function UIWorldMapFilterWin:saveMapfiltter()
worldMapModel:saveMapfiltter(self.saveFiltter)
end
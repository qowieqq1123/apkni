







def_class("UIRoomSelectWin",UIWindowBase)









function UIRoomSelectWin:bindComponents()

self.scrollview=UIObject.get(self,0)



end


function UIRoomSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
end



















function UIRoomSelectWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIRoomSelectWin:__delete()
self:unbindComponents()
end

function UIRoomSelectWin:isCanShow(bdData)
local build_type=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'build_type')
if build_type~=SLG_SYSTEM_TYPE.eDanRen and build_type~=SLG_SYSTEM_TYPE.eDuoRen then
return false
end
if emergenciesModel:isInRepairTime(bdData.un_build_id)then
return false
end
if emergenciesModel:isCreeper(bdData.un_build_id)then
return false
end
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return false
end
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype~=bdFlagType.normal then
return false
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_connect_road==1 and not bdData.isLinkRoad then
return false
end
return true
end

function UIRoomSelectWin:getDatas()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local list={}
for k,v in pairs(datas)do
if self:isCanShow(v)then
local data={}
data.name=v.name
data.level=v.level
local currNum=0
local maxNum=0
for ii,vv in ipairs(v.caveGeziList)do
if tostring(vv.dizi_id)~='0'then
currNum=currNum+1
end
maxNum=maxNum+1
end
data.currNum=currNum
data.maxNum=maxNum
data.isFull=currNum>=maxNum
data.data=v
table.insert(list,data)
end
end
table.sort(list,function(a,b)
if a.isFull and not b.isFull then
return false
elseif a.isFull==b.isFull then
return a.level>b.level
else
return true
end
end)
return list
end




function UIRoomSelectWin:onShow(argtable,afterOnloaded)
local bdData=argtable

local datas=self:getDatas()
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local index=nil
for i=1,count do
local item=grids[i-1]
local data=datas[i]
item:SetChildText(0,data.name)
item:SetChildText(1,FMT.fmt('{0}级',data.level))
item:SetChildText(2,data.isFull and FMT.fmt("{0}/{1}",data.maxNum,data.maxNum)or toColorStringX("#0bb40b",FMT.fmt("{0}/{1}",data.currNum,data.maxNum)))
local notCurr=data.data.un_build_id~=bdData.un_build_id
item:SetChildActive(4,notCurr)
if notCurr then
item:SetChildButtonClick(4,function()
UIManager:invokeUIMethod('UIDzRoomWin','switchRoom',data.data)
self:onCloseClick()
end)
else
index=i
end
end
if index then
self.winlua:SetChildScrollViewSelectItem(self.scrollview:getID(),index-1,false,true,false)
end
end


function UIRoomSelectWin:onHide()

end




function UIRoomSelectWin:onCloseClick()

UIManager:closeWindow('UICommonPageWin')
end

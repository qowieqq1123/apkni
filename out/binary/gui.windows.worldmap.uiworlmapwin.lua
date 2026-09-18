







def_class("UIWorlMapWin",UIWindowBase)









function UIWorlMapWin:bindComponents()

self.mapList=UIObject.get(self,0)



end


function UIWorlMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mapList);self.mapList=nil;
end
















local _this=nil


function UIWorlMapWin:onLoaded(...)
self:bindComponents()
_this=self
self:initView()
end


function UIWorlMapWin:__delete()
self:unbindComponents()
_this=nil
end


function UIWorlMapWin:onHide()

end




function UIWorlMapWin:onShow(argtable,afterOnloaded)
self:updateView()
end

function UIWorlMapWin:initView()
self.mapWidgetList={}
self.mapBlockWidgetList={}
local mapGrid=self.mapList:getChildCommonLayoutGroupWidgetList()
for i=1,mapGrid.Count do
local mapWidget=mapGrid[i-1]
self.mapWidgetList[i]=mapWidget
self.mapBlockWidgetList[i]={}

mapWidget:SetChildButtonClick(1,function()
self:onMapClick(i)
end)
local pieceGrid=mapWidget:GetChildCommonLayoutGroupWidgetList(2)
for j=1,pieceGrid.Count do
local blockWidget=pieceGrid[j-1]
self.mapBlockWidgetList[i][j]=blockWidget
end
end
self.filtterTypelist=worldMapModel:getMapfiltterlist()
end

function UIWorlMapWin:updateView()

self:getFiltterResult(self.filtterTypelist)

for i,v in ipairs(self.mapWidgetList)do
self:updataMapWidget(i)
end
end

function UIWorlMapWin:refreshPlayerInMap()
if self.curInWorldDataOld~=nil then
local worldid=self.curInWorldDataOld[2]
local mapIndex=worldMapModel:getMapIndexByWorldID(worldid)
self:updatePlayerMap(mapIndex,false)
self.curInWorldDataOld=false
end
if self.curInWorldData~=nil then
local worldid=self.curInWorldData[2]
local mapIndex=worldMapModel:getMapIndexByWorldID(worldid)
self:updatePlayerMap(mapIndex,true)
end
end

function UIWorlMapWin:getPlayerInWorldID()
if self.curInWorldData~=nil then
return self.curInWorldData[2]
end
return nil
end

function UIWorlMapWin:updatePlayerMap(mapIndex,isin)
local mapWidget=self.mapWidgetList[mapIndex]
local color=isin==true and Color.red or Color.white
mapWidget:SetChildColor(0,color)
end

function UIWorlMapWin:updataMapWidget(mapIndex)
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
local isin=self:getPlayerInWorldID()==worldid
self:updatePlayerMap(mapIndex,isin)

for i,v in ipairs(self.mapBlockWidgetList[mapIndex])do
self:updateBlockWidget(v,mapIndex,i)
end

self:updateMapSignGrid(mapIndex)
end

function UIWorlMapWin:updateBlockWidget(blockWidget,mapIndex,blockIndex)
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
if blockWidget==nil then
blockWidget=self.mapBlockWidgetList[mapIndex][pieceIndex]
end
local blockcfg=worldMapModel:getBlockConfigByIndex(worldid,blockIndex)
if blockcfg then
local blockid=blockcfg.blockId
local isOpen=worldMapModel:checkBlockOpen(worldid,blockid)
blockWidget:SetChildActive(0,not isOpen)
if not isOpen then
local canOpen=worldMapModel:canBlockOpenEx(worldid,blockid)
blockWidget:SetChildActive(2,canOpen)
end
end
end

function UIWorlMapWin:updateAllMapSignGrid()
for i,v in ipairs(self.mapWidgetList)do
self:updateMapSignGrid(i)
end
end

function UIWorlMapWin:updateMapSignGrid(mapIndex)
local mapWidget=self.mapWidgetList[mapIndex]
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
local filtterlist=self.filtterTypeResult[worldid]or{}
local num=#filtterlist
mapWidget:SetChildLayoutGroupCreateItems(3,num)

if num>0 then
for i=1,num do
self:updateMapSignItem(mapIndex,i)
end
end
end

function UIWorlMapWin:updateMapSignItem(mapIndex,itemIndex)
local mapWidget=self.mapWidgetList[mapIndex]
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
local filtterlist=self.filtterTypeResult[worldid]or{}
local data=filtterlist[itemIndex]
local filtterType=data[1]
local filtterData=data[2]
local cfg=worldMapModel:getFiltterTypeCfg(filtterType)
local item=mapWidget:GetChildLayoutGroupGridItem(3,itemIndex-1)


local pos={x=filtterData[3],y=filtterData[4]}
local spos=worldMapModel:map2ScreenPos(worldid,pos)
item:SetChildLocalPos(0,spos.x,spos.y,0)



local showprogress=false
item:SetChildActive(2,showprogress)

local showhead=false
item:SetChildActive(3,showhead)

local showbtn=false
item:SetChildActive(4,showbtn)
if showbtn then
item:SetChildButtonClick(4,function()
self:onMapSignClick(mapIndex,itemIndex)
end)
end

item:SetChildText(5,cfg.filtterName)
end

function UIWorlMapWin:onMapClick(mapIndex)
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
if worldModel.world==worldid then return end

worldController:enterWorld(worldid)

self:closeSelf()
end

function UIWorlMapWin:onMapSignClick(mapIndex,itemIndex)
local mapcfg=worldMapModel:getMapConfigByIndex(mapIndex)
local worldid=mapcfg.id
local filtterlist=self.filtterTypeResult[worldid]or{}
local data=filtterlist[itemIndex]
local filtterType=data[1]
local filtterData=data[2]

end

function UIWorlMapWin:onFilterClick()
UIManager:showWindow("UIWorldMapFilterWin",{callback=self.onFiltterBack})
end

function UIWorlMapWin.onFiltterBack(filtterTypelist,changelist)
if _this==nil then return end

_this.filtterTypelist=filtterTypelist
_this:getFiltterResult(filtterTypelist)

_this:refreshPlayerInMap()
_this:updateAllMapSignGrid()
end

function UIWorlMapWin:getFiltterResult(filtterTypelist)
self.filtterTypeResult=worldMapModel:getFiltterList(self.filtterTypelist)
self.curInWorldDataOld=self.curInWorldData
self.curInWorldData=nil
for worldid,filtterlist in pairs(self.filtterTypeResult)do
for i,v in ipairs(filtterlist)do
if v[1]==worldInfoFiltterType.ePlayer then
self.curInWorldData=v[2]
table.remove(filtterlist,i)
break
end
end
end
end

function UIWorlMapWin:onHomeClick()
local zmworldid=0
if worldModel.world~=zmworldid then

end

worldController:closeWorldMap()
end

function UIWorlMapWin:onCloseClick()

worldController:closeWorldMap()
end






def_class("designLayoutExport",{})

local path='/data/config/monijytemplatePosExportconfig.lua'

function designLayoutExport:__init(args)
self.info=args
end

function designLayoutExport:setWindow(win)
self.win=win
win.roadListData={}
end

function designLayoutExport:initRoadData(win)
self.win=win
self:clearRoadData(win)
local sfId=mapIdType.zhufeng
local roadListData={}
local roadDatas=zongmenModel:getMountainRoadDatas(sfId)
local cfgs=cfg_roadstyleconfig()
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end
if roadDatas then
for k,v in pairs(roadDatas)do
roadListData[k]={v.x,v.y,v.type,v.style}
local rt=v.type
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=v.x
count=count+1
rdlist[count]=v.y
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=v.style
end
end
win.roadListData=roadListData
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapIdType.zhufeng_design,v,mapLayer[cfg.layer])
end
end

function designLayoutExport:initRoadDataByConfigId(win,mapId)
self.win=win
self:clearRoadData(win)
local sfId=mapIdType.zhufeng
local roadListData={}
local roadDatas={}
local cfgs=cfg_roadstyleconfig()

local mapConfig=ims_design_layout:getTemplatePosConfig(mapId)
for id,datas in pairs(mapConfig.roadDatas)do

for ii,vv in ipairs(datas)do
local x=vv[1]
local y=vv[2]
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]={x=x,y=y,style=vv[3],type=vv[4]or 2}
end

end
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end
if roadDatas then
for k,v in pairs(roadDatas)do
roadListData[k]={v.x,v.y,v.type,v.style}
local rt=v.type
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=v.x
count=count+1
rdlist[count]=v.y
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=v.style
end
end


win.roadListData=roadListData
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapIdType.zhufeng_design,v,mapLayer[cfg.layer])
end
end


function designLayoutExport:loadLayoutMap(id)

end

function designLayoutExport:saveLayoutMap(win,id)
local sfId=mapIdType.zhufeng
local content=fileHelper.readFileEx(path)
local config={}
if content then
config=loadstring(content)()
end
local buildingList={}
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(buildingDatas)do
local ubdId=v.un_build_id
local designData=zongmenModel:getDesignBuildingData(ubdId)
local storageData=zongmenModel:getDesignStorageBuildingData(ubdId)
if not storageData then
local x=designData and designData.x or v.x
local y=designData and designData.y or v.y
local orientation=designData and designData.orientation or v.orientation

buildingList[v.build_id]=buildingList[v.build_id]or{}
table.insert(buildingList[v.build_id],{x,y,orientation})
end
end

for i,v in ipairs(buildingList)do
table.sort(v,function(a,b)return _MapManager.GetAreaID(sfId,_MapManager.ToVector3Int(a[1],a[2],0))<_MapManager.GetAreaID(sfId,_MapManager.ToVector3Int(b[1],b[2],0))end)
end



local roadList={}






if win.roadListData then
for i,v in pairs(win.roadListData)do
local pos=_MapManager.ToVector3Int(v[1],v[2],0)
local areaId=_MapManager.GetAreaID(sfId,pos)
roadList[areaId]=roadList[areaId]or{}
table.insert(roadList[areaId],v)
end
end

if next(buildingList)then
config[id]={id=id,unlock_build_list=buildingList,}
if next(roadList)then
config[id].roadDatas=roadList
end
end

local str=FMT.fmt("local ___noname___ =\n{0}\nreturn ___noname___",serializeHelper.serialize(config))
fileHelper.writeFileEx(path,str)

UIManager.info("导出成功")
end

function designLayoutExport:sortLayoutMap()
local sfId=mapIdType.zhufeng
local content=fileHelper.readFileEx(path)
local config={}
if content then
config=loadstring(content)()
end

for i,v in pairs(config)do
if v.unlock_build_list then
for _,vv in pairs(v.unlock_build_list)do
table.sort(vv,function(a,b)return _MapManager.GetAreaID(sfId,_MapManager.ToVector3Int(a[1],a[2],0))<_MapManager.GetAreaID(sfId,_MapManager.ToVector3Int(b[1],b[2],0))end)
end
end
end

local str=FMT.fmt("local ___noname___ =\n{0}\nreturn ___noname___",serializeHelper.serialize(config))
fileHelper.writeFileEx(path,str)

UIManager.info("导出成功")
end

function designLayoutExport:setRoadData(win,path)
win.roadListData=win.roadListData or{}
for i,v in pairs(path)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
win.roadListData[key]=v
end

end

function designLayoutExport:delRoadData(win,path)
win.roadListData=win.roadListData or{}
for i,v in pairs(path)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
win.roadListData[key]=nil
end
end

function designLayoutExport:clearRoadData(win)
win.roadListData={}
local mapId=mapIdType.zhufeng_design
_MapManager.Erase(mapId,mapLayer.Road1)
_MapManager.Erase(mapId,mapLayer.Data)
end

function designLayoutExport:refreshBuildingList(win)
local cfg=cfg_monijybuildconfig()
if not self.buildingList then
local buildingList={}
for i,v in pairs(cfg)do
if v.func_type==1 then
table.insert(buildingList,v)
end
end
self.buildingList=buildingList
end
win.storageScrollview:setChildScrollViewCreateGrids(#self.buildingList,0)
local grids=win.storageScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local cfg=self.buildingList[i+1]
local item=grids[i]

item:SetChildText(0,cfg.name)

item:SetChildIcon(1,cfg.icon,true)
end

end

function designLayoutExport:OnStorageItemSelect(win,index)
local cfg=self.buildingList[index+1]
local level=1
local bpos=win:getBDShowPos()
local func=function(bdata)

hudControl:changeContainer(bdata.hudId,1)

if not win or(win and win.isClose)then
hudControl:removeHUD(bdata.hudId)
_MapManager.RemoveTilemapObject(bdata.guid)
return
end

if not isometricMapSystem:hasPreviewBuilding()then
return
end

local building=bdata
local guid=building.guid
win.buildingGuid=guid
isometricMapSystem:setEditorMode(editorMode.ePlace)
isometricMapSystem:setPlaceObject(guid)

win.hudWidget=hudControl:getHUDWidget(building.hudId)
win.hudWidget:SetChildButtonClick(0,function()
win:Cancel()
win.hudWidget=nil
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
end)
win.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0)
building.orientation=building.orientation==0 and 1 or 0

end)
win.hudWidget:SetChildButtonClick(2,function()
if win:IsCanPlace(guid,6)then

local pv=isometricMapSystem:getObjectPosValue(guid)


hudControl:removeHUD(building.hudId)

local bdId=ims_design_layout:geyExportKey()
local data={un_build_id=bdId,entityId=guid,modelIndex=bdata.modelIndex}


data.x=pv[1]
data.y=pv[2]
data.orientation=building.orientation

zongmenModel:saveDesignBuildingData(win.sfId,bdId,data)

zongmenModel:setDesignEntityId(bdId,guid)


if _MapManager.IsPlace(guid)then
_MapManager.PickUpFromMap(guid)
end
_MapManager.SetPosition(data.entityId,_MapManager.ToVector3Int(data.x,data.y,0))
isometricMapSystem:setflipX(ata.entityId,data,data.orientation==1)
_MapManager.PlaceToMap(data.entityId,conditionConfig.designPlace)
local layer
if cfg.etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(data.entityId,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(data.entityId,layer)


win.hudWidget=nil
win.hType=0

win:showRootWin(true)

isometricMapSystem:clearStatus()


win.lastBDPos=_MapManager.ToVector3Int(data.x,data.y,0)


else

win:Cancel()
end

end)
local showOrientation=win:isShowOrientation(cfg,building.bdData)
win.hudWidget:SetChildActive(1,showOrientation)
win.hudWidget:SetChildActive(3,false)
win.hudWidget:SetChildActive(4,false)

end

local args={
id=cfg.id,

cfg=cfg,
level=level,
pos=bpos,
useDefPos=false,
callback=func,
pCfgId=6,

flag=0,
checkPlaceId=6,


flip=false,

}
isometricMapSystem:createBuilding(args)

end

function designLayoutExport:PickUpBuilding(win,guid,bdData)
win.hType=3
_MapManager.SetObjectPlaceCheckID(guid,6)
isometricMapSystem:onPickUpBuilding(guid,bdData,function(data)
_MapManager.SetObjectPlaceCheckID(guid,6)
hudControl:changeContainer(data.hudId,1)

if not isometricMapSystem:hasPreviewBuilding()then
return
end

UIManager:invokeUIMethod("UILayoutWin","showBuildingInfo",bdData.build_id,bdData.level)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local building=data

win:showBuildingLinkSlot(false,guid)

win.buildingGuid=guid
win.hudWidget=hudControl:getHUDWidget(building.hudId)
local showOrientation=win:isShowOrientation(cfg,bdData)
win.hudWidget:SetChildActive(1,showOrientation)
local cancelFunc=function()
win:Cancel()
win.hudWidget=nil
win:showBuildingLinkSlot(true,bdData)
end
win.hudWidget:SetChildButtonClick(0,cancelFunc)
win.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0

end)
win.hudWidget:SetChildButtonClick(2,function()
if win:IsCanPlace(guid,conditionConfig.designPlace)then


AudioManager.playAudio(432)
local pv=isometricMapSystem:getObjectPosValue(guid)
if pv[1]~=bdData.x or pv[2]~=bdData.y or bdData.orientation~=building.orientation then
isometricMapSystem:onDesignMove(win.sfId,bdData.un_build_id,pv[1],pv[2],building.orientation)


win.hudWidget=nil
win.hType=0
isometricMapSystem:hideBuffArea()

self:showRootWin(true)

zongmenModel:saveDesignData()
zongmenModel:flushSaveDesignData()

UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
else
cancelFunc()
end

end

end)

local showStorage=true
win.hudWidget:SetChildActive(3,showStorage)
if showStorage then
self.hudWidget:SetChildButtonClick(3,function()


if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
end
_MapManager.RemoveTilemapObject(data.entityId)

zongmenModel:saveDesignBuildingData(win.sfId,bdData.un_build_id,nil)










self.hType=0
end)
end

self.hudWidget:SetChildActive(4,false)

end)
end

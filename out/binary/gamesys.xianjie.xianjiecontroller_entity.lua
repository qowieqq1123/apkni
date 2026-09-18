







local entityLookup={}
local entityLookup_update={}
xianjieController.perWidgetCreateNum=1
local entityWidgetPool={}
local entityRemovePool={}

local _clickEntityPriorityTypes={
[XJ_ENTITY_TYPE.eZongMen]=true,
[XJ_ENTITY_TYPE.eMonster]=true,
[XJ_ENTITY_TYPE.eRPMonster]=true,
[XJ_ENTITY_TYPE.eRPEvent]=true,
[XJ_ENTITY_TYPE.eRPCollectible]=false,
[XJ_ENTITY_TYPE.eRPNPC]=true,
[XJ_ENTITY_TYPE.eRPMystery]=true,
[XJ_ENTITY_TYPE.eRPCtCollectible]=true,
[XJ_ENTITY_TYPE.eMarchTeam]=true,
[XJ_ENTITY_TYPE.eArena]=true,
[XJ_ENTITY_TYPE.eXJFMBoss]=true,
[XJ_ENTITY_TYPE.eRPMarchTeam]=true,
[XJ_ENTITY_TYPE.eMoGong]=true,
[XJ_ENTITY_TYPE.eXianMeng]=true,
[XJ_ENTITY_TYPE.eMoJieGate]=true,
}


function xianjieController.onEntityWidgetCreate(key,widgetID,widget)
local ent=entityLookup[key]
if ent then
entityWidgetPool[key]=widgetID

end
end

function xianjieController.onEntityWidgetRemove(key,widgetID,widget)
if entityWidgetPool[key]~=nil then
entityWidgetPool[key]=nil
else
local ent=entityLookup[key]
if ent then
ent:removeWidget(widgetID,widget)
end
end
end


function xianjieController.updateEntityWidgetCache()

if next(entityWidgetPool)then
local nun=1
local useNun=xianjieController.perWidgetCreateNum
for key,widgetID in pairs(entityWidgetPool)do
entityWidgetPool[key]=nil
local ent=entityLookup[key]
if ent~=nil then
useNun=useNun-1
ent:createWidgetCache(widgetID)
end
nun=nun-1
if nun<0 or useNun<0 then
break
end
end
end
end

function xianjieController.updateEntityRomoveCache()
if next(entityRemovePool)then

local nun=20
local lp={}
for key,_ in pairs(entityRemovePool)do
lp[key]=true
nun=nun-1
if nun<0 then
break
end
end
if next(lp)then
for key,_ in pairs(lp)do
entityRemovePool[key]=nil
xianjieController:removeEntity(key,true)
end
end
end
end

function xianjieController.onEntityChangeLOD(key,inAOI,curLODLevel,logicShow)
local ent=entityLookup[key]
if ent then
ent:changeLOD(inAOI,curLODLevel,logicShow)
end
end





function xianjieController:getEntityWidget(widgetID)
if self.manager then
return self.manager:GetEntityWidget(widgetID)
end
end

function xianjieController:checkCSEnity(key)
if self.manager then
return self.manager:CheckEntity_lua(key)
end
end


function xianjieController:findEnitys(pos,size)
if self.manager then
return self.manager:FindEntity_lua(pos,size)
end
end


function xianjieController:findAOIEnity()
if self.manager then
return self.manager:FindAOIEntity_lua()
end
end


function xianjieController:findEnitysEx(pos,size)
if self.manager then
local list={}
if deviceHelper.getAPILevel()>=400 then
local keys=self.manager:FindEntityEx_lua(pos,size)
for i=1,keys.Count do
list[i]=keys[i-1]
end
else
local keys=self.manager:FindEntity_lua(pos,size)
for i=1,keys.Count do
local key=keys[i-1]
local ent=xianjieController:getEntity(key)
if ent~=nil and ent:crashRect(pos.x,pos.y,size.x,size.y)then
table.insert(list,key)
end
end
end
return list
end
end


function xianjieController:findAOIEnityEx()
if self.manager then
local list={}
if deviceHelper.getAPILevel()>=400 then
local keys=self.manager:FindAOIEntityEx_lua()
for i=1,keys.Count do
list[i]=keys[i-1]
end
else
local keys=self.manager:FindAOIEntity_lua()
for i=1,keys.Count do
local key=keys[i-1]
local ent=xianjieController:getEntity(key)
if ent~=nil and ent:crashAOI()then
table.insert(list,key)
end
end
end
return list
end
end

function xianjieController:resetEntityPos(key,pos)
if self.manager then
return self.manager:ResetEntityPos_lua(key,pos)
end
end

function xianjieController:resetEntityPosList(key,posList)
if self.manager then
return self.manager:ResetEntityPosList_lua(key,posList)
end
end

function xianjieController:resetEntitySize(key,size)
if self.manager then
return self.manager:ResetEntitySize_lua(key,size)
end
end


function xianjieController:refreshAOIEntity(isChangeLOD)
if self.manager then
if isChangeLOD==nil then
isChangeLOD=false
end
return self.manager:RefreshAOIEntity(isChangeLOD)
end
end


function xianjieController:refreshAOIEntity_lua(isChangeLOD)
if self.manager then
if isChangeLOD==nil then
isChangeLOD=false
end
return self.manager:RefreshAOIEntity_lua(isChangeLOD)
end
end

function xianjieController:refreshEnityAOI(key,isChangeLOD)
if not self.manager then
return nil
end
if isChangeLOD==nil then
isChangeLOD=false
end
self.manager:RefreshEnityAOI(key,isChangeLOD)
end

function xianjieController:setEntityLogicShow(key)
if not self.manager then
return nil
end
local ent=xianjieController:getEntity(key)
if ent~=nil then
local logicShow=xianjieController:checkEntityLogicShow(ent)
self.manager:SetEntityLogicShow_lua(key,logicShow)
end
end

function xianjieController:setEntitysLogicShow(keys)
if not self.manager then
return nil
end
if deviceHelper.getAPILevel()<330 then
for _,key in ipairs(keys)do
local ent=xianjieController:getEntity(key)
if ent~=nil then
local logicShow=xianjieController:checkEntityLogicShow(ent)
self.manager:SetEntityLogicShow_lua(key,logicShow)
end
end
else
local keys_={}
local logicShows={}
for _,key in ipairs(keys)do
local ent=xianjieController:getEntity(key)
if ent~=nil then
local logicShow=xianjieController:checkEntityLogicShow(ent)
local k=#keys_+1
keys_[k]=key
logicShows[k]=logicShow
end
end
if#keys_>0 then
self.manager:SetEntitysLogicShow_lua(keys_,logicShows)
end
end
end

function xianjieController:setEntityTypeLogicShow(entityType)
if not self.manager then
return nil
end
local list=xianjieController:getEntitysByEntityType(entityType)
if#list>0 then
if deviceHelper.getAPILevel()<330 then
for _,ent in ipairs(list)do
local logicShow=xianjieController:checkEntityLogicShow(ent)
self.manager:SetEntityLogicShow_lua(ent:getKey(),logicShow)
end
else
local keys={}
local logicShows={}
for i,ent in ipairs(list)do
local logicShow=xianjieController:checkEntityLogicShow(ent)
keys[i]=ent:getKey()
logicShows[i]=logicShow
end
self.manager:SetEntitysLogicShow_lua(keys,logicShows)
end
end
end

function xianjieController:setEntityTypesLogicShow(entityTypes)
if not self.manager then
return nil
end
local list=xianjieController:getEntitysByEntityTypes(entityTypes)
if#list>0 then
if deviceHelper.getAPILevel()<330 then
for _,ent in ipairs(list)do
local logicShow=xianjieController:checkEntityLogicShow(ent)
self.manager:SetEntityLogicShow_lua(ent:getKey(),logicShow)
end
else
local keys={}
local logicShows={}
for i,ent in ipairs(list)do
local logicShow=xianjieController:checkEntityLogicShow(ent)
keys[i]=ent:getKey()
logicShows[i]=logicShow
end
self.manager:SetEntitysLogicShow_lua(keys,logicShows)
end
end
end



function xianjieController:getClickEntityPriorityTypes(entityType)
return _clickEntityPriorityTypes[entityType]
end

function xianjieController:getEntityLookup()
local lp={}
for key,ent in pairs(entityLookup)do
if entityRemovePool[key]==nil then
lp[key]=ent
end
end
return lp
end

function xianjieController:getEntity(key)
if key==nil then return end
if entityRemovePool[key]==nil then
return entityLookup[key]
end
end

function xianjieController:getEntitysByEntityType(entityType)
local list={}
local n=0
for _,ent in pairs(entityLookup)do
if ent:containType(entityType)then
n=n+1
list[n]=ent
end
end
return list
end

function xianjieController:getEntitysByEntityTypes(entityTypes)
local list={}
local n=0
local lp={}
for _,entityType in ipairs(entityTypes)do
lp[entityType]=true
end
for _,ent in pairs(entityLookup)do
if lp[ent.entityType]==true then
n=n+1
list[n]=ent
end
end
return list
end


function xianjieController:checkEntityTypeLogicShow(entityType)
return not xianjieController:checkHideInStoryPlotCrateUnit(entityType)
end


function xianjieController:checkEntityLogicShow(ent)
return xianjieController:checkEntityTypeLogicShow(ent.entityType)and ent:checkLogicShow()
end

function xianjieController:addEntity(entityType,data,needRefreshAOI)
if needRefreshAOI==nil then needRefreshAOI=false end
local ent=new_xjEntity(entityType,data)
local key=ent.m_key
assert(entityLookup[key]==nil)
entityLookup[key]=ent
if ent.onUpdate then
entityLookup_update[key]=ent
end
local logicShow=xianjieController:checkEntityLogicShow(ent)
local lodLevelRange=ent.lodLevelRange or{}
local flag=self.manager:CreateLuaEntity(key,entityType,ent.pos,ent.size,lodLevelRange,ent.lodLevel,needRefreshAOI,logicShow)
notifySystem:postNotify(notifyConfig.onXianJieEntityAdd,key,entityType,data,1)
if not flag then
logErr(FMT.fmt('仙界实体C#部分创建失败,key={0},entityType={1}',key,entityType))
xianjieController:removeEntity(key)
key=nil
end
return key
end

function xianjieController:addTeamEntity(entityType,data,needRefreshAOI)
if needRefreshAOI==nil then needRefreshAOI=false end
local ent=new_xjEntity(entityType,data)
local key=ent.m_key
assert(entityLookup[key]==nil)
entityLookup[key]=ent
if ent.onUpdate then
entityLookup_update[key]=ent
end
local logicShow=xianjieController:checkEntityLogicShow(ent)
local pos=ent.pos or Vector3.zero
local lodLevelRange=ent.lodLevelRange or{}
local flag=self.manager:CreateTeamEntity(key,entityType,pos,ent.posList,lodLevelRange,ent.lodLevel,needRefreshAOI,logicShow)
notifySystem:postNotify(notifyConfig.onXianJieEntityAdd,key,entityType,data,2)
if not flag then
logErr(FMT.fmt('仙界实体C#部分创建失败,key={0},entityType={1}',key,entityType))
xianjieController:removeEntity(key)
key=nil
end
return key
end


function xianjieController:removeEntity(key,now)
if key==nil then return end
if now then
entityWidgetPool[key]=nil

xianjieController:remove2DEntity(key)
local ent=entityLookup[key]
if ent then

entityLookup[key]=nil
entityLookup_update[key]=nil
local entityType=ent.entityType
release_xjEntity(ent)

local flag=self.manager:RemoveEntity(key)
notifySystem:postNotify(notifyConfig.onXianJieEntityRemove,key)
if not flag then
logErr(FMT.fmt('仙界实体C#部分已销毁或不存在，移除失败,key={0},entityType={1}',key,entityType))
end
return flag
end
else

if entityRemovePool[key]==nil then
entityRemovePool[key]=true
else



end
end
end

function xianjieController:refreshEntityFunc(entityType,funcName,...)
for _,ent in pairs(entityLookup)do
if ent.entityType==entityType then
ent[funcName](ent,...)
end
end
end

function xianjieController:clearAllEntity(isReconnet)

entityWidgetPool={}
entityRemovePool={}
xianjieController.lineDrawCache={}
if entityLookup~=nil and next(entityLookup)~=nil then
local list={}
local c=0
if isReconnet then
for key,_ in pairs(entityLookup)do
c=c+1
list[c]=key
end
for _,key in ipairs(list)do
xianjieController:removeEntity(key,true)
end
entityLookup={}
entityLookup_update={}
else
for _,ent in pairs(entityLookup)do
c=c+1
list[c]=ent
end
entityLookup={}
entityLookup_update={}
for i,ent in ipairs(list)do
release_xjEntity(ent)
end
end
list={}



clear_xjEntityLookup()
if not isReconnet then
self.manager:ClearEntity_lua()
end
end
end

function xianjieController:updataAllEntitiy()
if entityLookup_update~=nil then
for key,ent in pairs(entityLookup_update)do
if entityRemovePool[key]==nil then
if not ent.updataError then
if ent.pcallUpdateFunc1==nil then
ent.pcallUpdateFunc1=function()
ent:onUpdate()
end
ent.pcallUpdateFunc2=function(err)
ent.updataError=true
loggerUtil.logErrFMT('xjEntity onUpdate err!{0}',err)
end
end
xpcall(ent.pcallUpdateFunc1,ent.pcallUpdateFunc2)
end

end
end
end
end

function xianjieController:invokeEntityFunc(key,funcName,...)
if key==nil then return end
local ent=xianjieController:getEntity(key)
if ent then
local f=ent[funcName]
if f~=nil then
return f(ent,...)
end
end
end

function xianjieController:triggerClickEntities(clickDataList)

local selectIdx=0
if clickDataList.Length>1 then
local prioritys={}
local lookup={}
local showList=false
for i=1,clickDataList.Length do
local clickData=clickDataList[i-1]
local boxParams=clickData.args
local paramsCnt=#boxParams
local ent_key=boxParams[paramsCnt]
local entityType=boxParams[paramsCnt-1]
local priority=xianjieController:getClickEntityPriorityTypes(entityType)
if priority~=nil and lookup[ent_key]==nil then
table.insert(prioritys,clickData)
lookup[ent_key]=true
selectIdx=i-1
showList=showList or priority
end
end
if#prioritys>1 then
if showList then
xianjieController:closeRightWin()

UIManager:showWindow("UIXianJieClickEntityListWin",{clickDatas=prioritys})
else
for i,v in ipairs(prioritys)do
xianjieController:triggerClickEntity(v)
end
end
return
end
end

local clickData=clickDataList[selectIdx]
xianjieController:triggerClickEntity(clickData)
end

function xianjieController:triggerClickEntity(clickData)
local clickPos=clickData.pos
local boxParams=clickData.args
local ent_key=boxParams[#boxParams]
local ent=xianjieController:getEntity(ent_key)
if ent then
ent:onClick(boxParams,clickPos)
end
end


function xianjieController:findTouchEntityWithGrid(sceneidx,gridX,gridZ,pos)
local clickEnt=nil
if self.manager then
local gridSize=xianjieController:getMapGridSize()
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX,gridZ)

local t_pos=Vector2(worldX,worldZ)
local size=Vector2(gridSize,gridSize)

local keys=self.manager:FindEntity_lua(t_pos,size)
if keys then
local c=keys.Count
for i=0,c-1 do
local key=keys[i]
local ent=xianjieController:getEntity(key)
if ent and ent.getGridSize and ent.pos then
local pos_ent=ent.pos
local distanceX=math.abs(pos_ent.x-pos.x)
local distanceZ=math.abs(pos_ent.z-pos.z)
local gridwidth,gridheight=ent:getGridSize()
if distanceX<gridwidth*size.x/2 and distanceZ<gridheight*size.y/2 then
if ent.allowClickGrid then
clickEnt=ent
break
end
end
end
end
end
end
if clickEnt~=nil then
clickEnt:onClickGrid()
return true
end
return false
end

function xianjieController:findEntityByGrid(sceneidx,gridX_c,gridZ_c,entityType)
if self.manager then
local gridSize=xianjieController:getMapGridSize()
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX_c,gridZ_c)
local t_pos=Vector2(worldX,worldZ)
local size=Vector2(gridSize,gridSize)
local keys=self.manager:FindEntity_lua(t_pos,size)
if keys then
local c=keys.Count
for i=0,c-1 do
local key=keys[i]
local ent=xianjieController:getEntity(key)
if ent and ent:containType(entityType)then
return ent
end
end
end
end
end


function xianjieController:findEntityByGridEX(sceneidx,gridX_c,gridZ_c,entityType)
if self.manager then
local gridSize=xianjieController:getMapGridSize()
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX_c,gridZ_c)
local t_pos=Vector2(worldX,worldZ)
local size=Vector2(gridSize,gridSize)
local keys=xianjieController:findEnitysEx(t_pos,size)
if keys then
local c=#keys
for i=0,c-1 do
local key=keys[i]
local ent=xianjieController:getEntity(key)
if ent and ent:containType(entityType)then
return ent
end
end
end
end
end


function xianjieController:getInRangeZmEntitys(xjdata,leftOffset,rightOffset,bottonOffset,topOffset)
local gridX=xjdata.gridX
local gridZ=xjdata.gridZ
local gridWidth=xjdata.gridWidth
local gridHeight=xjdata.gridHeight
local leftX=gridX-leftOffset
local rightX=gridX+rightOffset
local bottomZ=gridZ-bottonOffset
local rightZ=gridZ+topOffset
local list={}
local lookup_={}
for i=leftX,rightX do
for j=bottomZ,rightZ do
local entitys=xianjieModel:getZmDataByPos(i,j)
if entitys then
for _,in_entityId in ipairs(entitys)do
if in_entityId~=entityId then
_insert(list,in_entityId)
end
end
end
end
end
return list
end

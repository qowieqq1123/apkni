






local _MODULENAME="jctjDuJieXianDanController"

gameState.addListener(def_table(_MODULENAME))
jctjDuJieXianDanController.name=_MODULENAME
jctjDuJieXianDanController.data={}

function jctjDuJieXianDanController:onAppStart()

jctjDuJieXianDanModel:onAppStart()


socketManager:register_receiver(34,101,jctjDuJieXianDanController.recv_34_101)
socketManager:register_receiver(34,104,jctjDuJieXianDanController.recv_34_104)
socketManager:register_receiver(34,102,jctjDuJieXianDanController.recv_34_102)
socketManager:register_receiver(34,103,jctjDuJieXianDanController.recv_34_103)
socketManager:register_receiver(34,105,jctjDuJieXianDanController.recv_34_105)




















notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end


function jctjDuJieXianDanController:onEnterState(isReconnect)
jctjDuJieXianDanModel:onEnterState()
end


function jctjDuJieXianDanController:onProtocolReq()
jctjDuJieXianDanModel:onProtocolReq()
end


function jctjDuJieXianDanController:onLeaveState(isReconnect)
jctjDuJieXianDanModel:onLeaveState(isReconnect)

self.data={}
end


function jctjDuJieXianDanController:onLostConnection()

end


function jctjDuJieXianDanController:onReConnection(isInitPro)

end

function jctjDuJieXianDanController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
jctjDuJieXianDanController:checkEntity(mapIdType.zhufeng)
jctjDuJieXianDanController:playAllRepair()
elseif etype==homeEvent.eLeaveHome then
jctjDuJieXianDanController:deleteEntity(mapIdType.zhufeng)
end
end

function jctjDuJieXianDanController:createEntity(mapId,danlingId)

local ent=jctjDuJieXianDanModel:getEntity(mapId)
if ent then
return ent.oriPos
end

local visitorCfg=cfgHelper.get1(cfg_djxddanlingconfig_get,danlingId)
local posCfg=zongmenVisitorController:calculatePos(mapId)
local modelCfg=visitorCfg.model
local body=modelCfg[1]
local slots=modelCfg[2]
local scale=modelCfg[3]
local pos=posCfg[math.random(1,#posCfg)]


local guid=isometricMapSystem:createRoleEntity(objectType.eDuJieXianDanMon,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
if not isometricMapSystem:isInNormalMode()then

_MapManager.SetObjectDisplay(objectType.eDuJieXianDanMon,false)
end
local bt=nil
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_sjgantanhao')
widget:SetChildButtonClick(1,function()
UIManager:showWindow("UIDuJieDanLingWin",danlingId)
end)


end)

jctjDuJieXianDanModel:setEntity(mapId,guid,bt,hud,danlingId,pos)



return pos
end

function jctjDuJieXianDanController:deleteEntity(mapId)
local entData=jctjDuJieXianDanModel:getEntity(mapId)
if entData then
if entData.entBt then
behaviorManager:removeBehaviorTree(entData.entBt)
end
if entData.entHud then
hudControl:removeHUD(entData.entHud)
end
_MapManager.RemoveTilemapObject(entData.entGuid)

jctjDuJieXianDanModel:clearEntity(mapId)
end
end

function jctjDuJieXianDanController:checkEntity(mapId)
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)then
local dlId=jctjDuJieXianDanModel:hasEntity()
if dlId then
return jctjDuJieXianDanController:createEntity(mapId,dlId)
end
end
end

function jctjDuJieXianDanController:showPlot(jdId,callback)
jdId=jdId or jctjDuJieXianDanModel:getLianZhiJieDuan()
local config=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId)
if config and config.startPlot then
local building=jctjDuJieXianDanModel:getLianZhiBuild()
local bdpos,bdgrid
local bdentity
if building then
local data=zongmenModel:getBuildingData(building)
if data then

local mapId=zongmenModel:getMountainId()
local temppos=_MapManager.ToVector3Int(data.x,data.y,0)
bdpos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
bdpos={bdpos.x,bdpos.y+3}
bdgrid={data.x,data.y}
bdentity=data.entityId
end
end
local entity=jctjDuJieXianDanModel:getEntity(mapIdType.zhufeng)
local entPos,entGrid,entitypos
if entity then
entitypos=_MapManager.GetTilemapObjectPosition(entity.entGuid)


if entitypos then
entGrid=_MapManager.Vector3IntToArray(entitypos)
local mapId=zongmenModel:getMountainId()
entPos=_MapManager.GetCellCenterWorld(mapId,entitypos,mapLayer.Data)
entGrid={entPos.x,entPos.y}
end
end

local initData={bdpos=bdpos,bdgrid=bdgrid,bdEntId=bdentity,entitypos=entPos,entgrid=entGrid,stateId=entGrid==nil and 1 or 2}

return storyAIManager:startStoryBehavior(config.startPlot[2],initData,callback)
end
end

function jctjDuJieXianDanController:showEffectWin()
local jdId=jctjDuJieXianDanModel:getLianZhiJieDuan()
UIManager:showWindow("UIDuJieXianDanEffectWin",jdId)
end

function jctjDuJieXianDanController:closeEffectWin()
UIManager:closeWindow("UIDuJieXianDanEffectWin")
end

function jctjDuJieXianDanController:changeBuildVisible(isVisible)
local building=jctjDuJieXianDanModel:getLianZhiBuild()
local bdData=zongmenModel:getBuildingData(building)
if bdData then
isometricMapSystem:changeBuildingModelVisible(bdData,isVisible)
end
end

function jctjDuJieXianDanController:startRepair(bdData)
if jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)and bdData.entityId then
buildingCDControl:addCDData(buildingCDType.lianDanXiuFu,bdData)
_MapManager.SetFadeToColor(bdData.entityId,Color.New(0.65,0.65,0.65,1),1,nil)
local mdata=isometricMapSystem:getModelByData(bdData)
local effectScale=1/mdata.scale
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eMaoYan,nil,nil,effectScale)

end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

function jctjDuJieXianDanController:endRepair(bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
buildingCDControl:removeCDData(buildingCDType.lianDanXiuFu,bdData.un_build_id)
if not emergenciesModel:isInRepairTime(bdData.un_build_id)then
local check=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if not check then
_MapManager.SetFadeToColor(bdData.entityId,Color.New(1,1,1,1),1,nil)
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eMaoYan)
end
end
end

function jctjDuJieXianDanController:playAllRepair()
local datas=jctjDuJieXianDanModel:getRepairData()
for k,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(k)
if bdData then
self:startRepair(bdData)
end
end
end

function jctjDuJieXianDanController:playBattlePlot()
local dlid=jctjDuJieXianDanModel:hasEntityConfig()
if dlid then
local config=cfgHelper.get(cfg_djxddanlingconfig_get,dlid)
if config and config.plot then















local entity=jctjDuJieXianDanModel:getEntity(mapIdType.zhufeng)
local entPos,entGrid,entitypos
if entity then
entitypos=_MapManager.GetTilemapObjectPosition(entity.entGuid)
if entitypos then
entGrid=_MapManager.Vector3IntToArray(entitypos)
local mapId=zongmenModel:getMountainId()
entPos=_MapManager.GetCellCenterWorld(mapId,entitypos,mapLayer.Data)
entPos={entPos.x,entPos.y}

end
end

local initData={entPos=entPos,entGrid=entGrid,}

return storyAIManager:startStoryBehavior(config.plot[2],initData,function()
local data=jctjDuJieXianDanModel:getDuJieJJUpDiziList()
if data and next(data)then
UIManager:showWindow("UIDanLingSuccessWin")
end
end)


end
end
end


function jctjDuJieXianDanController:findBreakBuilding()
local ubid=jctjDuJieXianDanModel:getLianZhiBuild()
local jdId=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId)
if cfg and cfg.shnum and ubid then
local bcfg=cfgHelper.get(cfg_dujiexiandanbaseconfig_get,1,"destroy_build_id_list")

local shnum=cfg.shnum
local shfw=cfg.shfw
local bdData=zongmenModel:getBuildingData(ubid)
if bdData then
local entityId=bdData.entityId
local rect=_MapManager.GetObjectRectInMap(entityId)
if rect then
local sx=rect[1]-shfw
local sy=rect[2]-shfw
local ex=sx+rect[3]-1+shfw
local ey=sy+rect[4]-1+shfw
local num=0
local buildingDatas=zongmenModel:getAllBuildingData(mapIdType.zhufeng)
local breakList={}
for kk,v in pairs(buildingDatas)do
if num>=shnum then
break
end
if v.entityId and bcfg[v.build_id]then

if isometricMapSystem:checkOverlap(v.x,v.y,v.x,v.y,sx,sy,ex,ey)then
breakList[v.un_build_id]=v
num=num+1
end
end
end
if num<shnum then
for kk,v in pairs(buildingDatas)do
if num>=shnum then
break
end
if v.entityId and bcfg[v.build_id]and not breakList[v.un_build_id]then
breakList[v.un_build_id]=v
num=num+1
end
end
end

local list={}
for uid,v in pairs(breakList)do
table.insert(list,uid)
end
return list
end

end

end
end

function jctjDuJieXianDanController:checkReddot()
return jctjDuJieXianDanModel:getLianZhiEndFlag()~=1 and(jctjDuJieXianDanModel:isLianDanFinish()or jctjDuJieXianDanModel:checkLianZhiLingQu()or false)
end

function jctjDuJieXianDanController:refreshHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLianDanFang)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end




function jctjDuJieXianDanController:send_34_101()
socketManager:send_34_101()
end


function jctjDuJieXianDanController:send_34_104()
socketManager:send_34_104()
end




function jctjDuJieXianDanController:send_34_102(sfid,jzGuid)
socketManager:send_34_102(sfid,jzGuid)
end


function jctjDuJieXianDanController:send_34_103()
local un_build_id_list=jctjDuJieXianDanController:findBreakBuilding()or{}
socketManager:send_34_103(#un_build_id_list,un_build_id_list)
end










function jctjDuJieXianDanController.recv_34_101(argtable)
local sfid,buildUid,jdId,endTime,klFlag,monDieFlag,endFlag,jzshTime,build_list_len,buildList,danluOpenTime=unpack(argtable)
jctjDuJieXianDanModel:initXianDanData(sfid,buildUid,jdId,endTime,klFlag,monDieFlag,endFlag)
jctjDuJieXianDanModel:setLianZhiJieDuanServerStartId(jdId)
local jdId=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId)
if cfg and cfg.shtime then
jctjDuJieXianDanModel:initRepairTime(jzshTime+cfg.shtime,buildList)
jctjDuJieXianDanController:playAllRepair()
end
local bdData=zongmenModel:getBuildingData(buildUid)
if bdData and endTime>0 then
buildingCDControl:addCDData(buildingCDType.dujiexiandan,bdData)
end
jctjDuJieXianDanModel:openDanLuTime(danluOpenTime)
reddotControl.on_change_catch_type(CATCH_TYPE.eDuJieXianDan)

taskController.DuJieXianDanJieDuanChange()

UIManager:callWindowFunc("UIDuJieXianDanWin","refresh")

jctjDuJieXianDanController:refreshHUD()
end



function jctjDuJieXianDanController.recv_34_104(endFlag)
jctjDuJieXianDanModel:setEndFlag(endFlag)



UIFullLianDanFangControl:closeUI()
reddotControl.on_change_catch_type(CATCH_TYPE.eDuJieXianDan)
UIManager:showWindow("UIDuJieXianDanFinishWin")
end






function jctjDuJieXianDanController.recv_34_102(sfid,jzGuid,jdid,endTime)
jctjDuJieXianDanModel:beginLianZhi(jzGuid,jdid,endTime)
jctjDuJieXianDanModel:setLianZhiJieDuanServerStartId(jdid)
UIManager:callWindowFunc("UIDuJieXianDanWin","refresh")
local bdData=zongmenModel:getBuildingData(jzGuid)
if bdData and endTime>0 then
buildingCDControl:addCDData(buildingCDType.dujiexiandan,bdData)
end

taskController.DuJieXianDanJieDuanChange()

jctjDuJieXianDanController:refreshHUD()
end



function jctjDuJieXianDanController.recv_34_103(klFlag,jzshTime,build_list_len,buildList,danluOpenTime)
local jdId=jctjDuJieXianDanModel:getLianZhiJieDuan()
local cfg=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId)
jctjDuJieXianDanModel:openDanLuTime(danluOpenTime)
jctjDuJieXianDanModel:setNextJieDuan()

if jdId==1 then
UIFullLianDanFangControl:closeUI()
UIManager:showWindow("UIDuJieXianDanFinishWin",{closeCall=function()
UIFullLianDanFangControl:showDuJieXianDan()
end,jieduan=jdId+1,mainText="丹基凝练",hideImg=true})
else
jctjDuJieXianDanController:checkEntity(mapIdType.zhufeng)
loadingControl.openCloud(function()
jctjDuJieXianDanController:showPlot(jdId)
end,0.5,true)

end



UIManager:callWindowFunc("UIDuJieXianDanWin","refresh")

reddotControl.on_change_catch_type(CATCH_TYPE.eDuJieXianDan)

if cfg and cfg.shtime then
jctjDuJieXianDanModel:initRepairTime(jzshTime+cfg.shtime,buildList)
jctjDuJieXianDanController:playAllRepair()
end
taskController.DuJieXianDanJieDuanChange()
end

function jctjDuJieXianDanController.recv_34_105(len,dzList)
local now=timeHelper.getServerShortTime()

jctjDuJieXianDanModel:setDuJieJJUpDizi(dzList,now)
end



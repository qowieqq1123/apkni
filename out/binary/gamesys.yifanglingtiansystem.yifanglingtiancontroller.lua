






local _MODULENAME="YiFangLingTianController"

gameState.addListener(def_table(_MODULENAME))
YiFangLingTianController.name=_MODULENAME
YiFangLingTianController.data={}
YiFangLingTianController.x_max=6
YiFangLingTianController.y_max=6
YiFangLingTianController.xy_max=6*6
YFLTGridState={
eLock=1,
eUnPlanted=2,
ePlanted=3,
}

function YiFangLingTianController:onAppStart()

YiFangLingTianModel:onAppStart()
socketManager:register_receiver(3,80,self.recv_3_80)
socketManager:register_receiver(3,81,self.recv_3_81)
socketManager:register_receiver(3,82,self.recv_3_82)
socketManager:register_receiver(3,84,self.recv_3_84)
socketManager:register_receiver(3,85,self.recv_3_85)
socketManager:register_receiver(3,86,self.recv_3_86)



end


function YiFangLingTianController:onEnterState(isReconnect)

YiFangLingTianModel:onEnterState()
self.isEnterHome=false
end


function YiFangLingTianController:onProtocolReq()
YiFangLingTianModel:onProtocolReq()


notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function YiFangLingTianController:onLeaveState(isReconnect)
YiFangLingTianModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

self.data={}
end


function YiFangLingTianController:onLostConnection()

end


function YiFangLingTianController:onReConnection(isInitPro)

end
function YiFangLingTianController.on_building_event(etype,id,bdId,args)
if etype==buildingEvent.buildStart then
if systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
local data=zongmenModel:getBuildingData(bdId)
local build_id=data.build_id
local lt_constcfg=cfg_yifanglintianconfig().const_def
local buildId=lt_constcfg.buildId
if buildId==build_id then
local build_sf=cfgHelper.get2(cfg_monijybuildconfig_get,buildId,'build_sf')
zongmenControl:reqBuildComplete(build_sf[1],bdId)
end
end
end
end


function YiFangLingTianController.on_system_open(sysId)

if sysId==SYSTEM_DEFINE.eYiFangLingTian then
local Un_build_id=YiFangLingTianModel:GetUn_build_id()
if not Un_build_id then
Un_build_id=0
end
if Un_build_id==0 then
YiFangLingTianController:reqRepairYFLT()
end
end
end

function YiFangLingTianController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
YiFangLingTianController.isEnterHome=true


if systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
local Un_build_id=YiFangLingTianModel:GetUn_build_id()
if not Un_build_id or Un_build_id==0 then
YiFangLingTianController:reqRepairYFLT()
end

end
elseif etype==homeEvent.eLeaveHome then

end
end

function YiFangLingTianController:reqRepairYFLT()
if not self.isEnterHome then
return
end
local lt_constcfg=cfg_yifanglintianconfig().const_def
local buildId=lt_constcfg.buildId
local build_sf=cfgHelper.get2(cfg_monijybuildconfig_get,buildId,'build_sf')
local data=isometricMapSystem:getUnlockRepairDataByID(build_sf[1],buildId)

if not data then

local mapCfg=cfgHelper.get1(cfg_monijysfconfig_get,build_sf[1])
local posList=mapCfg.repair_build_list and mapCfg.repair_build_list[SLG_SYSTEM_TYPE.eYiFangLingTian]
if not posList then
logErr("主峰内未找到可修复的一方灵田 请检查山峰配置表repair_build_list字段中是否已配置万宝商会")
return
end
local mapId=mapIdType.zhufeng
for _,posIndex in ipairs(posList)do
isometricMapSystem:createRepairBuilding(mapId,buildId,posIndex)
end
end
zongmenControl:reqBuild(build_sf[1],data.id,data.x,data.y,0)
end


function YiFangLingTianController:req_3_80()
socketManager:send_3_80()
end


function YiFangLingTianController:req_3_81(itemid,posid,x,y)
socketManager:send_3_81(itemid,posid,x,y)
end

function YiFangLingTianController:req_3_82(len,geziList)
socketManager:send_3_82(len,geziList)
end

function YiFangLingTianController:req_3_83(len,plantlist)

socketManager:send_3_83(len,plantlist)

end


function YiFangLingTianController:req_3_87(len,plantlist)

socketManager:send_3_87(len,plantlist)
end


function YiFangLingTianController:req_3_84(len,plantlist,is_assistant)
socketManager:send_3_84(len,plantlist,is_assistant or 0)
end


function YiFangLingTianController:req_3_85(x,y)
socketManager:send_3_85(x,y)
end


function YiFangLingTianController:req_3_86(cnt)
socketManager:send_3_86(cnt)
end


function YiFangLingTianController.recv_3_80(un_build_id,gezi_len,gezilist,ly_begintimes,extranum)

YiFangLingTianModel:SetYFLTData(un_build_id,gezi_len,gezilist,ly_begintimes,extranum)
YiFangLingTianModel:HandleGridData(gezilist)
UIManager:invokeUIMethod("UIYFLTMapWin","initGridView")
UIManager:invokeUIMethod("UIYFLTcuishuWin","refresh")
UIManager:invokeUIMethod("UIYFLTTipsWin","refresh")
UIManager:invokeUIMethod("UIYFLTMoneyGainWin","refreshwindow")
UIManager:invokeUIMethod("UIYFLTgubaoWin","SetLingYeData")
UIManager:invokeUIMethod("UIYFLTGetPlantWin","refreshList")
UIManager:invokeUIMethod("UIYiFangLingTianMain","refreshwin")
taskController.YFLTGridStateChange()
taskController.YFLTUnlockGridChange()
end


function YiFangLingTianController.recv_3_81(geziInfo)
YiFangLingTianModel:SetYFLTgeziData(geziInfo)
YiFangLingTianModel:HandleSingleGridData(geziInfo)
UIManager:invokeUIMethod("UIYFLTSelectPlantMain","Refresh")
taskController.YFLTGridStateChange()
end


function YiFangLingTianController.recv_3_82(len,gezilist)
YiFangLingTianModel:HandleUnlockGridData(gezilist)
UIManager:invokeUIMethod("UIYFLTMapWin","unlockGrid",gezilist)
taskController.YFLTUnlockGridChange()
end

function YiFangLingTianController.recv_3_84(len,gezilist,is_assistant)
local show,again=YiFangLingTianModel:Get_Setting()
if again then
YiFangLingTianModel:againPlant(len,gezilist)
end
end


function YiFangLingTianController.recv_3_85(x,y)
YiFangLingTianModel:ChangeChanChuData(x,y)
YiFangLingTianModel:HandleCleanGridData(x,y)
UIManager.info("成功铲除")

UIManager:invokeUIMethod("UIYFLTcuishuWin","refresh")
taskController.YFLTGridStateChange()
end

function YiFangLingTianController.recv_3_86(cnt,begin_times)
YiFangLingTianModel:Setbegintimes(begin_times)
UIManager:invokeUIMethod("UIYFLTMoneyGainWin","refreshwindow")
end




function YiFangLingTianController:xyToIdx(x,y)
local idx=(x-1)*YiFangLingTianController.y_max+y
return idx
end


function YiFangLingTianController:idxToXY(idx)
local x=math.floor((idx-1)/YiFangLingTianController.y_max)+1
local y=(idx-1)%YiFangLingTianController.y_max+1
return x,y
end



function YiFangLingTianController:getGridState(idx)
local gridDatas=YiFangLingTianModel:GetGridData()
local gridData=gridDatas[idx]
if not gridData then return YFLTGridState.eLock end
if gridData.item_id~=0 or gridData.combinedGridIdx then return YFLTGridState.ePlanted end
return YFLTGridState.eUnPlanted
end




function YiFangLingTianController:getGridUnlockCondNum()
local unlockNum=YiFangLingTianModel:GetUnlockGridNum()
local unlock_gezi_level=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_level_conf")
local unlock_gezi_cost=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_cost")
local unlock_gezi_itemid=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_itemid")
local zmLvCondNum=0
local zmLevel=zongmenModel:getLevel()
for x,v in ipairs(unlock_gezi_level)do
for y,needLv in ipairs(v)do
local idx=YiFangLingTianController:xyToIdx(x,y)
if YiFangLingTianController:getGridState(idx)==YFLTGridState.eLock then
if zmLevel>=needLv then
zmLvCondNum=zmLvCondNum+1
end
end
end
end
local costCondNum=0
local have=itemsModel.getCount(unlock_gezi_itemid)
for i=unlockNum+1,#unlock_gezi_cost do
if have>=unlock_gezi_cost[i]then
have=have-unlock_gezi_cost[i]
costCondNum=costCondNum+1
end
end
return zmLvCondNum,costCondNum
end


function YiFangLingTianController:checkGridUnlockCond(idx)
local unlock_gezi_level=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_level_conf")
local zmLevel=zongmenModel:getLevel()
local x,y=YiFangLingTianController:idxToXY(idx)
if unlock_gezi_level[x]and unlock_gezi_level[x][y]then
return zmLevel>=unlock_gezi_level[x][y],unlock_gezi_level[x][y]
end
return false,99
end


function YiFangLingTianController:checkAnyPlantMatched()
local gridDatas=YiFangLingTianModel:GetGridData()
for idx,_ in pairs(gridDatas)do
if YiFangLingTianController:getGridState(idx)==YFLTGridState.eUnPlanted then
return true
end
end
return false
end


function YiFangLingTianController:checkAnySeedPlantMatched()
local cfg=cfg_yifanglintianconfig()
local lv=zongmenModel:getLevel()or 0
for itemid,v in pairs(cfg)do
local need_level=v.need_level or 0
if itemsModel.getCount(itemid)>0 and lv>=need_level then
for x=1,YiFangLingTianController.x_max do
for y=1,YiFangLingTianController.y_max do
local idx=YiFangLingTianController:xyToIdx(x,y)
local ret=YiFangLingTianController:checkGridMatched(idx,itemid)
if ret then
return true
end
end
end
end
end
return false
end





function YiFangLingTianController:getTheBestGrid(itemid)
local safeIdx=YiFangLingTianController:xyToIdx(math.floor(YiFangLingTianController.x_max/2),math.floor(YiFangLingTianController.y_max/2))
for x=1,YiFangLingTianController.x_max do
for y=1,YiFangLingTianController.y_max do
local idx=YiFangLingTianController:xyToIdx(x,y)
local ret,pos_idx=YiFangLingTianController:checkGridMatched(idx,itemid)
if ret then
return true,idx,pos_idx
end
end
end

for x=1,YiFangLingTianController.x_max do
for y=1,YiFangLingTianController.y_max do
local idx=YiFangLingTianController:xyToIdx(x,y)
for pos_idx=1,4 do
local ret,errType=YiFangLingTianController:checkGridMatched(idx,itemid,pos_idx)
if not ret and errType==1 then
return false,idx,pos_idx
end
end
end
end
return false,safeIdx,1
end





function YiFangLingTianController:checkGridOutBorder(idx,itemid,pos_idx)
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
if pos_idx then
local ret,errType=YiFangLingTianController:checkGridMatched(idx,itemid,pos_idx)
if not ret and errType==2 then
return true
end
else
for i=1,#cfg.coordinate_conf do
local coordinate_conf=cfg.coordinate_conf[i]
local x,y=YiFangLingTianController:idxToXY(idx)
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid~=x or y_grid~=y then
local combinedIdx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
if x_grid<=0 or x_grid>YiFangLingTianController.x_max or y_grid<=0 or y_grid>YiFangLingTianController.y_max then
return true
end
end
end
end
end
return false
end





function YiFangLingTianController:checkGridMatched(idx,itemid,pos_idx)
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
if not cfg then return false end
if pos_idx then
local coordinate_conf=cfg.coordinate_conf[pos_idx]
if not coordinate_conf then return false end
local x,y=YiFangLingTianController:idxToXY(idx)
local ok=true
local errType=1
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid<=0 or x_grid>YiFangLingTianController.x_max or y_grid<=0 or y_grid>YiFangLingTianController.y_max then
ok=false
errType=2
end
local combinedIdx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
if YiFangLingTianController:getGridState(combinedIdx)~=YFLTGridState.eUnPlanted then
ok=false
end
end
if not ok then
return false,errType
end
return true,pos_idx
else
for i=1,#cfg.coordinate_conf do
local coordinate_conf=cfg.coordinate_conf[i]
local x,y=YiFangLingTianController:idxToXY(idx)
local ok=true
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid<=0 or x_grid>YiFangLingTianController.x_max or y_grid<=0 or y_grid>YiFangLingTianController.y_max then
ok=false
break
end
local combinedIdx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
if YiFangLingTianController:getGridState(combinedIdx)~=YFLTGridState.eUnPlanted then
ok=false
break
end
end
if ok then
pos_idx=i
break
end
end
return pos_idx~=nil,pos_idx
end
return false,2
end

function YiFangLingTianController:setBuildingModelShow(isShow)
local Un_build_id=YiFangLingTianModel:GetUn_build_id()
if Un_build_id==nil then
logErr("setBuildingModelShow Un_build_id == nil")
return
end
local bdData=zongmenModel:getBuildingData(Un_build_id)
if bdData==nil then
logErr("setBuildingModelShow bdData == nil")
return
end
isometricMapSystem:changeBuildingModelVisible(bdData,isShow)
if isShow then
hudControl:addProgressData(mapIdType.zhufeng,bdData.un_build_id,true)
else
hudControl:removeProgressData(bdData.un_build_id)
end
end
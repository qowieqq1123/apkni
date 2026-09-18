






local _MODULENAME="AutoBuildController"

gameState.addListener(def_table(_MODULENAME))
AutoBuildController.name=_MODULENAME
AutoBuildController.data={}

function AutoBuildController:onAppStart()
AutoBuildModel:onAppStart()
socketManager:register_receiver(6,195,self.recv_6_195)
socketManager:register_receiver(6,196,self.recv_6_196)
socketManager:register_receiver(6,197,self.recv_6_197)
socketManager:register_receiver(6,198,self.recv_6_198)

end


function AutoBuildController:onEnterState(isReconnect)
AutoBuildModel:onEnterState()
end


function AutoBuildController:onProtocolReq()
AutoBuildModel:onProtocolReq()
end


function AutoBuildController:onLeaveState(isReconnect)
AutoBuildModel:onLeaveState(isReconnect)

self.data={}
end


function AutoBuildController:onLostConnection()

end


function AutoBuildController:onReConnection(isInitPro)

end


function XianMengBaoXiaController:send_6_195()
socketManager:send_6_195()
end

function XianMengBaoXiaController:send_6_196(sf_id,un_build_id)
socketManager:send_6_196(sf_id,un_build_id)
end

function XianMengBaoXiaController:send_6_197(sf_id,un_build_id,len,itemList)
socketManager:send_6_197(sf_id,un_build_id,len,itemList)

end

function XianMengBaoXiaController:send_6_198(sf_id,un_build_id)
socketManager:send_6_198(sf_id,un_build_id)

end



function AutoBuildController.recv_6_195(len,buildList)
AutoBuildModel:setAutoBuildingData(len,buildList)
end

function AutoBuildController.recv_6_196(buildList)
AutoBuildModel:setAutoBuildingSingleData(buildList)
UIManager:invokeUIMethod("UIAutoBuildingLvlupWin","refreshLHdata")
local un_build_id=buildList.un_build_id or 0
UIManager:invokeUIMethod("UIAutoBuildingWin","severfreah",un_build_id)
end

function AutoBuildController.recv_6_197(sf_id,un_build_id,level,exp)

end

function AutoBuildController.recv_6_198(sf_id,un_build_id)

AutoBuildController:refreshABHUD(sf_id)

local fun=function(...)
AutoBuildController.zfTimer=nil
AutoBuildController:refreshABHUD(sf_id)
end
AutoBuildController.zfTimer=timer.new()
AutoBuildController.zfTimer:start(60,fun,1)
end


function AutoBuildController:checkIsOpen()
local flag=true
return flag
end


function AutoBuildController:checkAutoReddotByUnBuildid(un_build_id)
if AutoBuildController:checkIsOpen()then
if un_build_id then
local buildlvl=AutoBuildModel:getAutoBuildingLvl(un_build_id)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
local max_exp=cfg.exp
if max_exp then
local cfg_refine_conf=cfg_autocreatebuildconfig().const_def.cost_map
if cfg_refine_conf then
for itemid,v in pairs(cfg_refine_conf)do
local num=itemsModel.getCount(itemid)
if num>0 then
return true
end
end
end
end
end
end
return false
end


function AutoBuildController:checkAutoBuildingGetRewards(un_build_id)
if not AutoBuildController:checkIsOpen()then
return false
end
if un_build_id then
local createList=AutoBuildModel:getAutoBuildingCreateList(un_build_id)
if createList then
local stamp=timeHelper.getServerShortTime()
for k,starttime in ipairs(createList)do
local cfg=cfg_autocreatebuildconfig_get(k)
local create_conf=cfg.create_conf[1]
local time=create_conf[3]

local delay=stamp-starttime
if delay>=time then
return true
end
end
end
end
return false
end


function AutoBuildController:refreshABHUD(sf_id)
local bdData=zongmenModel:findBuildingDataByID(sf_id,SLG_SYSTEM_TYPE.eAutoBuilding)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
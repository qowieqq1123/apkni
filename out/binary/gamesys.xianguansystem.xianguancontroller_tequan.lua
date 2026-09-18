





local guid=0
local getGUID=function()
guid=guid+1
return guid
end

function xianguanController:onAppStart_TeQuan()
socketManager:register_receiver(35,75,self.recv_35_75)
socketManager:register_receiver(35,76,self.recv_35_76)
socketManager:register_receiver(35,77,self.recv_35_77)
end

function xianguanController:onEnterState_TeQuan(isReconnect)
self.data.updateList={}
self.data.updateListLen=0

xianguanModel:onEnterState_TeQuan(isReconnect)
end

function xianguanController:onLeaveState_TeQuan(isReconnect)
self:clearUpdateList()

xianguanModel:onLeaveState_TeQuan(isReconnect)
end



function xianguanController.sendUsePrivilege(xgId,tqId,exInfoJsonStr)
if xianjieController:checkInMoGongZhengDuo()then
UIManager.info('活动期间无法使用')
return
end

exInfoJsonStr=exInfoJsonStr or""
local curSceneId=xianjieModel:getSceneIndex()or xianjienSceneIndexType.eXianJie
socketManager:send_35_77(xgId,tqId,exInfoJsonStr,curSceneId)
end

function xianguanController.reqSetXianGuanBroadcast(broadcast)
socketManager:send_35_75(broadcast)
end

function xianguanController.recv_35_75(broadcast)
xianguanModel:setXianGuanBroadcastOpen(broadcast)
end



function xianguanController.recv_35_76(len,tqDataList,broadcast)
xianguanModel:setOriginalServerData(len,tqDataList)
xianguanModel:setXianGuanBroadcastOpen(broadcast)
end

function xianguanController.recv_35_77(tqData,ret)
xianguanModel:updateTeQuanData(tqData,ret)
if tqData and tqData.tqid then
if tqData.tqid==XIANGUAN_PRIVILEGE_ENUM.eTqType_20 and ret~=0 then
UIManager:showWindow("UITQyTTMSeffectWin",{_ret=ret})
end
end

notifySystem:postNotify(notifyConfig.onTeQuanInfoChange,tqData)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanTeQuan)
end



function xianguanController.resetSelefPrivilege(type)

local resetCount=0
local lookup=xianguanModel:getSelfTqQuanObjLookUp()
for key,obj in pairs(lookup)do
local baseData=obj:getBaseInfo()
local reset=xianguanConfig.getTeQuanCfg(baseData.tqid,"reset")
if reset and reset==type then
obj:resetData()
resetCount=resetCount+1
end
end


if resetCount>0 then
notifySystem:postNotify(notifyConfig.onTeQuanInfoReset)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianGuanTeQuan)

UIManager:invokeUIMethod("UIXianGuanMainWin","refreshPrivilegeBtn")
UIManager:invokeUIMethod("UIXianGuanTeQuanWin","refreshAll")
end
end


function xianguanController:initPassiveTeQuanObj()
local jobList=xianguanModel:getSelfGroupJobInfoList()
for index,jobData in ipairs(jobList)do

xianguanController:buildPassiveTeQuanObjByXgId(jobData.jobId)
end
end

function xianguanController:buildPassiveTeQuanObjByXgId(xgid)
local privilegeList=xianguanConfig.getJobConfig(nil,xgid,"privilegeList")
for index,tqid in ipairs(privilegeList)do
if not xianguanConfig.checkIsActiveTeQuan(tqid)then
local tqtype=xianguanConfig.getTeQuanCfg(tqid,"type")
local tempData={
xgid=xgid,
tqid=tqid,
tqtype=tqtype,
times=0,
cd=0,
}
local key=xianguanConfig.getTeQuanFindKey(tempData.xgid,tqid)
xianguanModel:addSelfTequan(key,tempData,true)
end
end
end


function xianguanController:startTimer()
if not self.data.updateTimer then
self.data.updateTimer=timer.new()
local callback=function()
xianguanController:doUpdate()
end
self.data.updateTimer:start(0.01,callback)
end
end

function xianguanController:doUpdate()
if self.data.updateListLen>0 then
for _,tqObj in ipairs(self.data.updateList)do
if tqObj then
tqObj:update()
end
end
end
end

function xianguanController:clearUpdateList()
if self.data.updateTimer then
table.clear(self.data.updateList)
self.data.updateListLen=0

self.data.updateTimer:cancel()
self.data.updateTimer=nil
end
end

function xianguanController:pushUpdateTqObj(obj)
if obj==nil then
logErr("参数为nil")
return
end

if obj.updateGuid~=nil then return end

local guid=getGUID()
self.data.updateList[guid]=obj
self.data.updateListLen=self.data.updateListLen+1
obj.updateGuid=guid
xianguanController:startTimer()
end

function xianguanController:removeUpdateTqObj(obj)
if obj==nil then
logErr("参数为nil")
return
end

if obj.updateGuid==nil then



return
end

local guid=obj.updateGuid
self.data.updateList[guid]=nil
self.data.updateListLen=self.data.updateListLen-1
obj.updateGuid=nil

if self.data.updateListLen<=0 then
xianguanController:clearUpdateList()
end
end


function xianguanController:chatNoticeJump(xgid,tqid)
local useJump=xianguanConfig.getTeQuanCfg(tqid,"logJump")
local type=xianguanConfig.getTeQuanCfg(tqid,"type")

if useJump==nil then
return false
end

local args=table.weakCopy(useJump.args)or{}
args.baseData={
xgid=xgid,
tqid=tqid,
tqtype=type,
}
return jumpManager:jump({id=useJump.id,args=args})
end


local _tequanReddotExInfoFuncs={
[XIANGUAN_PRIVILEGE_ENUM.eXianShiYaoWu]=function()
return true
end,
[XIANGUAN_PRIVILEGE_ENUM.ePoJieZhuTian]=function()
return false
end,
[XIANGUAN_PRIVILEGE_ENUM.eYiTianYiRi]=function()
return false
end,
[XIANGUAN_PRIVILEGE_ENUM.eTqType_19]=function()
return false
end,
}

function xianguanController:getTequanExReddot(tqData)
local reddotExInfoFunc=_tequanReddotExInfoFuncs[tqData.tqid]
if reddotExInfoFunc then
return reddotExInfoFunc(tqData)
else
return true
end
end


function xianguanController:checkIsActiveXGBuff(GridX,GridZ,Sceneidx)
local data=xianguanModel:getJobInfoListByJobType(XIANGUAN_TYPE_ENUM.eFuLuXianShi)

if data then
for k,v in ipairs(data)do
local zmData=xianjieModel:getZongMenData(v.actorid)
if zmData then
local sceneidx=zmData.sceneidx
local gridX_left=zmData.gridX-4
local gridX_right=zmData.gridX_c+4
local gridZ_left=zmData.gridZ-4
local gridZ_right=zmData.gridZ_c+4

if sceneidx==Sceneidx and GridX>=gridX_left and GridX<=gridX_right and GridZ>=gridZ_left and GridZ<=gridZ_right then
return true,v.jobId,zmData.guildid
end
end
end
end
return false
end


function xianguanController:refreshAOIZMEntityRangeGrids()
local list=xianjieController:findAOIEnity()
if list and list.Count>0 then
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and ent.entityType==XJ_ENTITY_TYPE.eZongMen then
ent:checkShowInvisibleRangeGrids()
end
end
end
end


function xianguanController:refreshAOIZMEntityAndHUD(actorid)
local list=xianjieController:findAOIEnity()
if list and list.Count>0 then
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and ent.entityType==XJ_ENTITY_TYPE.eZongMen then
local zmData=ent.zmData
local entActorid=ent.actorid
if entActorid and mathHelper.compareInt64(entActorid,actorid)then
zmData:onInitExtraData()
zmData:refreshEntity()

xianjieController:onRefreshZongmenInvisibleEffect(zmData)
xianjieController:onRefreshSkillPengLaiAddEffect(zmData)

xianjieController:onRefreshSkillAddIcon(zmData)
local hud=ent and ent:getHud()
if hud and(not hud.hudType or hud.hudType==1)then
hud:refreshJobBuff()
end
end
end
end
end
end



local _tequanfunc=
{

}


function xianguanController:handleTeQuanByAddEntity(xjdata)
local xglistlen=xjdata.xglistlen
if xglistlen==0 then return end
local xglist=xjdata.xglist
for _,xgid in ipairs(xglist)do
local privilegeList=cfg_xianguanconfig_get(xgid).privilegeList
for _,tqid in ipairs(privilegeList)do
self:addEntityTeQuan(xjdata,tqid)
end
end
end


function xianguanController:handleTeQuanByRemoveEntity(xjdata)
local xglistlen=xjdata.xglistlen
if xglistlen==0 then return end
local xglist=xjdata.xglist
for _,xgid in ipairs(xglist)do
local privilegeList=cfg_xianguanconfig_get(xgid).privilegeList
for _,tqid in ipairs(privilegeList)do
self:removeEntityTeQuan(xjdata,tqid)
end
end
end

function xianguanController:addEntityTeQuan(xjdata,tqid)
local cfg_func=_tequanfunc[tqid]
if cfg_func then
cfg_func.add(tqid,xjdata)
end
end

function xianguanController:removeEntityTeQuan(xjdata,tqid)
local cfg_func=_tequanfunc[tqid]
if cfg_func then
cfg_func.remove(tqid,xjdata)
end
end


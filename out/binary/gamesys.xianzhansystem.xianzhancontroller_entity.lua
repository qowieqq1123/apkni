







xianzhanmanType={
eWaiter=1,
eDiner=2,
eZhiKe=3,
eFangKe=4,
ePasserby=5,
eKeShang=6,
}

function xianzhanController:onAppStart_entity()

end

function xianzhanController:onEnterState_entity()
xianzhanController:loadKeShangEntityNpcIdPosLookup()
end

function xianzhanController:onLeaveState_entity()
xianzhanController:clearXianZhanEnity()
xianzhanController:saveKeShangEntityNpcIdPosLookup()
end

function xianzhanController:initXianZhanEnity()
if xianzhanController.isInitEnity==true then
return
end

xianzhanController.isInitEnity=true
local timer=FrameTimer.New(function()
xianzhanController:updataEnityBehaviorTree()
end,1,-1)
timer:Start()
xianzhanController.entiytAITimer=timer

xianzhanController.aiEntityLookup={}
end

function xianzhanController:clearXianZhanEnity()
if xianzhanController.isInitEnity==nil then
return
end

xianzhanController.entiytAITimer:Stop()
xianzhanController.entiytAITimer=nil
xianzhanController.isInitEnity=nil

xianzhanController.aiEntityLookup={}
xianzhanController:setEnityStopModel(nil)
end

function xianzhanController:setEnityStopModel(flag)
xianzhanController.enityStopModel=flag
end

function xianzhanController:updataEnityBehaviorTree()
for k,entity in pairs(xianzhanController.aiEntityLookup)do
local bt=entity.bt
if bt~=nil then
local check=not xianzhanController.enityStopModel
if entity.always==true then
check=true
end
if check then
bt:regularUpdate()
end
end
end
end

function xianzhanController:activeEnitys(flag)
for k,entity in pairs(xianzhanController.aiEntityLookup)do
local bt=entity.bt
if bt~=nil then
if flag==false then
local needBroke=entity.needBroke
if needBroke then
bt:broke()
end
else
local needBroke=entity.needBroke
if needBroke then
bt:reset()
end
end
end
end
end

function xianzhanController:onEntityUpdata()
for k,entity in pairs(xianzhanController.aiEntityLookup)do
if entity.manType==xianzhanmanType.ePasserby then
xianzhanController:onPasserbyEvent(entity)
end
end
end


function xianzhanController:enterXianZhan_entity()
xianzhanController.isInXianZhan=true
xianzhanController:setEnityStopModel(false)
xianzhanController:activeEnitys(true)

xianzhanController:createAllRoomModel()
xianzhanController:createWaiter()
xianzhanController:createDiner()
xianzhanController:createZhiKe()
xianzhanController:initFangKeEntitys()
xianzhanController:createPasserbyOnce()
xianzhanController:createPasserbyCreateTrigger()
xianzhanController:initKeShangEntitys()


xianzhanController:createEntityUpdataTimer()
end


function xianzhanController:leaveXianZhan_entity()
xianzhanController.isInXianZhan=nil
xianzhanController:setEnityStopModel(true)
xianzhanController:activeEnitys(false)

local isclear=true
xianzhanController:createEntityUpdataTimer(isclear)
end

function xianzhanController:createEntityUpdataTimer(isclear)
if xianzhanController.entityUpdataTimer~=nil then
xianzhanController.entityUpdataTimer:cancel()
xianzhanController.entityUpdataTimer=nil
end
if isclear then
return
end
local updataTimer=timer.new()
local func=function()
xianzhanController:onEntityUpdata()
end
updataTimer:start(1,func,-1)
xianzhanController.entityUpdataTimer=updataTimer
end


function xianzhanController:leaveSceneClearEntity()
if not xianzhanController.isInitEnity then
return
end
xianzhanController.isInXianZhan=nil
local isclear=true
xianzhanController:removeAllRoomModel()
xianzhanController:createWaiter(isclear)
xianzhanController:createDiner(isclear)
xianzhanController:createZhiKe(isclear)
xianzhanController:deleteAllFangKeEntitysEx()
xianzhanController:deleteAllKeShangEntitysEx()
xianzhanController:createPasserbyOnce(isclear)
xianzhanController:createPasserbyCreateTrigger(isclear)
end

function xianzhanController:findXianZhanEnity(manType,guid)
if manType==xianzhanmanType.eWaiter then
return xianzhanController.waiterEntityLookup[guid]
elseif manType==xianzhanmanType.eDiner then
return xianzhanController.dinerEntityLookup[guid]
elseif manType==xianzhanmanType.eZhiKe then
return xianzhanController.zhikeEntityLookup[1]
elseif manType==xianzhanmanType.eFangKe then
return xianzhanController.fangkeEntityLookup[guid]
elseif manType==xianzhanmanType.ePasserby then
return xianzhanController.aiEntityLookup[guid]
elseif manType==xianzhanmanType.eKeShang then
return xianzhanController.keShangEntityLookup[guid]
end
return nil
end

function xianzhanController:findXianZhanEnityEx(guid)
if xianzhanController.aiEntityLookup then
return xianzhanController.aiEntityLookup[guid]
end
return nil
end

function xianzhanController:findXianZhanKeShangEnityByPosIndex(posIndex)
if xianzhanController.keShangEntityPosLookup then
return xianzhanController.keShangEntityPosLookup[posIndex]
end
return nil
end

function xianzhanController:clearXianZhanEnityByArr(arrname)
local lp=xianzhanController[arrname]
for guid,entity in pairs(lp)do
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
if entity.guid then
_MapManager.RemoveTilemapObject(entity.guid)
entity.guid=nil
end
xianzhanController.aiEntityLookup[guid]=nil
end
xianzhanController[arrname]=nil
end

function xianzhanController:createRoleEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,scale,pos,offset,small,showShadow)
local guid=isometricMapSystem:createRoleEntity(otype,mapId,cfgId,modelId,slots,sortingLayer,scale,pos,offset,small)
if showShadow then
_MapManager.ShowShadow(guid,true)
end
return guid
end



function xianzhanController:createWaiter(isclear)
local lp=xianzhanController.waiterEntityLookup
if lp~=nil and not isclear then
return
else
if lp~=nil then
xianzhanController:clearXianZhanEnityByArr('waiterEntityLookup')
end
if isclear then
return
end
end

lp={}
xianzhanController.waiterEntityLookup=lp
local allwaitercfgs=cfg_xianzhanwaiterconfig()
for i,cfg in ipairs(allwaitercfgs)do
local bornPos=cfg.bornPos
local modelParams=npcModel:getImageInfoOutSide(cfg.npcid)
local scale=modelParams.scale*3
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)

local entity={}
entity.talklist=cfg.talk
entity.manType=xianzhanmanType.eWaiter
entity.guid=guid
local dzId=FMT.fmt('xz_waiter_{0}',i)
entity.dzId=dzId
entity.bt=xianzhanController.setRandomMoveAI(xianzhanmanType.eWaiter,dzId,guid,pos,4)
lp[guid]=entity
xianzhanController.aiEntityLookup[guid]=entity
end
end





function xianzhanController:createDiner(isclear)
local isrebuild=false
if not isclear then
local createTime=xianzhanController.dinerEntityCreateTime
if createTime~=nil then
local refreshtimer=cfgHelper.getdef1(cfg_xianzhandinerconfig,'refreshtimer')
local lerp=gameUtilityModel.getServerShortTime()-createTime
if lerp>=refreshtimer then
isrebuild=true
end
else
isrebuild=true
end
end

local lp=xianzhanController.dinerEntityLookup
if lp~=nil and not isrebuild and not isclear then
return
else
if lp~=nil then
xianzhanController:clearXianZhanEnityByArr('dinerEntityLookup')
end
if not isrebuild and isclear then
return
end
end

xianzhanController.dinerEntityCreateTime=gameUtilityModel.getServerShortTime()
lp={}
xianzhanController.dinerEntityLookup=lp
local refreshnumrange=cfgHelper.getdef1(cfg_xianzhandinerconfig,'refreshnumrange')
local seatingcfgs=cfg_xianzhanseatingconfig()
local seatingArr={}
for i,cfg in ipairs(seatingcfgs)do
seatingArr[i]=cfg
end
local randomCnt=math.random(refreshnumrange[1],refreshnumrange[2])
local dinerLookup={}

for i=1,randomCnt do
local rSeatIndex=math.random(1,#seatingArr)
local seatcfg=table.remove(seatingArr,rSeatIndex)
local rDinerId=math.random(1,#seatcfg.dinerList)
local dinercfg=cfgHelper.get1(cfg_xianzhandinerconfig_get,seatcfg.dinerList[rDinerId])

local bornPos=seatcfg.pos
local modelParams=npcModel:getImageInfoOutSide(dinercfg.npcid)



local scale=modelParams.scale*dinercfg.scale
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local offset=nil
if seatcfg.offsetpos then
offset=Vector3(seatcfg.offsetpos[1],seatcfg.offsetpos[2],0)
end
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,offset,nil,nil,true)
local isflip=seatcfg.flip
if isflip==nil then isflip=false end
isometricMapSystem:setflip(guid,isflip)
local entity={}
entity.talklist=dinercfg.talk
entity.manType=xianzhanmanType.eDiner
entity.guid=guid
local dzId=FMT.fmt('xz_diner_{0}',i)
entity.dzId=dzId
entity.bt=xianzhanController.setRandomTalkAI(xianzhanmanType.eDiner,dzId,guid)
lp[guid]=entity
xianzhanController.aiEntityLookup[guid]=entity
end
end





function xianzhanController:createZhiKe(isclear)
local lp=xianzhanController.zhikeEntityLookup
if lp~=nil and not isclear then
return
else
if lp~=nil then
xianzhanController:clearXianZhanEnityByArr('zhikeEntityLookup')
end
if isclear then
return
end
end
lp={}
xianzhanController.zhikeEntityLookup=lp

local entity={}
local zhikeInfo=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'zhikeInfo')
local zhiketalk=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'zhiketalk')
local modelParams=npcModel:getImageInfoOutSide(zhikeInfo[1])
local bornPos=zhikeInfo[2]
local scale=modelParams.scale*3
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)

entity.talklist=zhiketalk
entity.manType=xianzhanmanType.eZhiKe
entity.guid=guid
local dzId='xz_zhike'
entity.dzId=dzId
lp[1]=entity
xianzhanController.aiEntityLookup[guid]=entity

xianzhanController:refreshZhiKeAI()
end

function xianzhanController:refreshZhiKeAI()
if xianzhanController.isInitEnity==nil then
return
end
if xianzhanController.isInXianZhan==nil then
return
end
local entity=xianzhanController:findXianZhanEnity(xianzhanmanType.eZhiKe)
if entity==nil then return end

local hasyb=xianzhanModel:hasYingBinRoom()
if hasyb then
if entity.bt~=nil then

behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
else
if entity.bt==nil then
entity.bt=xianzhanController.setRandomTalkAI(xianzhanmanType.eZhiKe,entity.dzId,entity.guid)
end
end
end

function xianzhanController:excuteYBAI()
if xianzhanController.isInitEnity==nil then
return
end
if xianzhanController.isInXianZhan==nil then
return
end
local entity=xianzhanController:findXianZhanEnity(xianzhanmanType.eZhiKe)
if entity==nil then return end

UIManager:invokeUIMethod('UIXianZhanMapWin','removeZhiKeHud')

if entity.bt~=nil then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end

local guid=entity.guid
local offset=_MapManager.GetObjectHeadOffset(guid)
local hudId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,guid,offset,true,true,function(hudId)
local widget=hudControl:getHUDWidget(hudId)
local zhikeybtalk=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'zhikeybtalk')
local talkstr=table.randomIndex(zhikeybtalk)
widget:SetChildText(0,talkstr)
end)

local func=function()
hudControl:removeHUD(hudId)
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshZhiKeHud')
xianzhanController:refreshZhiKeAI()
end
timeEventController.delayDo(3,func)

local roomsDatas=xianzhanModel:getRoomsData()
for k,data in pairs(roomsDatas)do
if xianzhanModel:checkRoomNeedYB(data)then
local roomId=data.roomId
local fkenity=xianzhanController:getFangKeEntity(roomId)
if fkenity.bt~=nil then
behaviorManager:removeBehaviorTree(fkenity.bt)
fkenity.bt=nil
end
local bornPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'npcPos')
fkenity.bt=xianzhanController.setYBGoRoomAI(fkenity.dzId,fkenity.guid,roomId,bornPos)
fkenity.doingyb=true
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomNPC',roomId)
end
end
end





function xianzhanController:initFangKeEntitys()
local lp=xianzhanController.fangkeEntityLookup
if lp~=nil then
xianzhanController:refreshAllFangKeEntitys()
return
end

xianzhanController.fangkeEntityLookup={}
xianzhanController.fangkeEntityRoomLookup={}

local roomsData=xianzhanModel:getRoomsData()
for k,data in pairs(roomsData)do
local customerId=data.customerId
if customerId>0 then
xianzhanController:createFangKeEntity(data.roomId)
end
end
end

function xianzhanController:getFangKeEntity(roomId)
return xianzhanController.fangkeEntityRoomLookup[roomId]
end


function xianzhanController:createFangKeEntity(roomId)
local lp=xianzhanController.fangkeEntityLookup
local roomlp=xianzhanController.fangkeEntityRoomLookup

local data=xianzhanModel:getRoomDataByRoomId(roomId)
local customerId=data.customerId
local fkconfig=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,customerId)
local modelParams=xianzhanModel:getCustomerOutSideModelInfo(fkconfig)
local bornPos
local talklist
if data.ybFlag==0 then
bornPos=cfgHelper.get3(cfg_xianzhanbaseconfig_get,1,'fangkestandpos',roomId)
talklist=fkconfig.standtalk
else
bornPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'npcPos')
talklist=fkconfig.randomMoveSpeak
end
local scale=modelParams.scale*3
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eFangKe,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)
local entity={}
entity.talklist=talklist
entity.roomId=roomId
entity.customerId=customerId
entity.manType=xianzhanmanType.eFangKe
entity.guid=guid
local dzId=FMT.fmt('xz_fangke_{0}',roomId)
entity.dzId=dzId
if data.ybFlag==0 then
entity.bt=xianzhanController.setRandomTalkAI(xianzhanmanType.eFangKe,entity.dzId,entity.guid)
isometricMapSystem:setflip(guid,true)
else
entity.bt=xianzhanController.setRandomMoveAI(xianzhanmanType.eFangKe,entity.dzId,entity.guid,pos)
end
lp[guid]=entity
roomlp[roomId]=entity
xianzhanController.aiEntityLookup[guid]=entity
end

function xianzhanController:refreshAllFangKeEntitys()
local roomsData=xianzhanModel:getRoomsData()
for k,data in pairs(roomsData)do
xianzhanController:refreshFangKeEntity(data.roomId)
end
end

function xianzhanController:refreshFangKeEntity(roomId)
if xianzhanController.isInitEnity==nil then
return
end
if xianzhanController.isInXianZhan==nil then
return
end
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local entity=xianzhanController:getFangKeEntity(roomId)
local customerId=data.customerId
if customerId>0 then
if entity==nil then
xianzhanController:createFangKeEntity(roomId)
elseif customerId~=entity.customerId then
xianzhanController:clearFangKeEntity(roomId)
xianzhanController:createFangKeEntity(roomId)
else

if entity.bt~=nil then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
entity.doingyb=nil
entity.leaveType=nil

local fkconfig=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,customerId)
local bornPos
local talklist
if data.ybFlag==0 then
bornPos=cfgHelper.get3(cfg_xianzhanbaseconfig_get,1,'fangkestandpos',roomId)
talklist=fkconfig.standtalk
else
bornPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'npcPos')
talklist=fkconfig.randomMoveSpeak
end
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
_MapManager.SetPosition(entity.guid,pos)
entity.talklist=talklist
if data.ybFlag==0 then
entity.bt=xianzhanController.setRandomTalkAI(xianzhanmanType.eFangKe,entity.dzId,entity.guid)
isometricMapSystem:setflip(entity.guid,true)
else
entity.bt=xianzhanController.setRandomMoveAI(xianzhanmanType.eFangKe,entity.dzId,entity.guid,pos)
end
end
else
if entity~=nil then
xianzhanController:clearFangKeEntity(roomId)
end
end
end

function xianzhanController:clearFangKeEntity(roomId)
local entity=xianzhanController:getFangKeEntity(roomId)
if entity~=nil then
local guid=entity.guid
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if guid then
_MapManager.RemoveTilemapObject(guid)
end
xianzhanController.aiEntityLookup[guid]=nil
xianzhanController.fangkeEntityLookup[guid]=nil
xianzhanController.fangkeEntityRoomLookup[roomId]=nil
entity=nil
end
end

function xianzhanController:deleteAllFangKeEntitysEx()
local lp=xianzhanController.fangkeEntityLookup
if lp==nil then return end
for guid,entity in pairs(lp)do
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if entity.guid then
_MapManager.RemoveTilemapObject(entity.guid)
end
xianzhanController.aiEntityLookup[guid]=nil
end
xianzhanController.fangkeEntityLookup=nil
xianzhanController.fangkeEntityRoomLookup=nil
end


function xianzhanController:fangkeLeaveRoom_test(roomId,leaveType)
UIManager:invokeUIMethod('UIXianZhanMapWin','removeRoomNpcEx',roomId)
local func=function()
xianzhanController:fangkeLeaveRoom(roomId,leaveType)
end
UIManager:invokeUIMethod('UIXianZhanInteractWin','fkOutSpeak',func)
end



function xianzhanController:fangkeLeaveRoom(roomId,leaveType)
if xianzhanController.isInitEnity==nil then
return
end
if xianzhanController.isInXianZhan==nil then
return
end
local fkenity=xianzhanController:getFangKeEntity(roomId)
if fkenity~=nil then
if fkenity.bt then
behaviorManager:removeBehaviorTree(fkenity.bt)
fkenity.bt=nil
end
local bornPosList=cfgHelper.getdef1(cfg_xianzhanpasserbytriggerconfig,'bornPosList')
local targetPos=table.randomIndex(bornPosList)
local customerId=fkenity.customerId
if leaveType==2 then
fkenity.talklist=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'leavetalk')
fkenity.bt=xianzhanController.setFangKeLeaveRoom2(fkenity.dzId,fkenity.guid,roomId,targetPos)
else
fkenity.bt=xianzhanController.setFangKeLeaveRoom1(fkenity.dzId,fkenity.guid,roomId,targetPos)
end
fkenity.leaveType=leaveType
end
end


function xianzhanController:fangkeLeaveBack(roomId)
xianzhanController:clearFangKeEntity(roomId)
end


function xianzhanController:fangKeGoRoomBack(roomId)
local fkenity=xianzhanController:getFangKeEntity(roomId)
if fkenity==nil then return end
if fkenity.bt~=nil then
behaviorManager:removeBehaviorTree(fkenity.bt)
fkenity.bt=nil
end
fkenity.doingyb=nil
local bornPos=cfgHelper.get2(cfg_xianzhanroomconfig_get,roomId,'npcPos')
local pos=_MapManager.ToVector3Int(bornPos[1],bornPos[2],0)
local customerId=fkenity.customerId
fkenity.talklist=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'randomMoveSpeak')
fkenity.bt=xianzhanController.setRandomMoveAI(xianzhanmanType.eFangKe,fkenity.dzId,fkenity.guid,pos)
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomNPC',roomId)
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshRoomHudTime',nil,roomId)
end






function xianzhanController:createPasserbyOnce(isclear)
if webGLHelper:isRunWebGL()then
return
end
local lp=xianzhanController.passerbyOnceEntityLookup
if lp~=nil and not isclear then
return
else
if lp~=nil then
xianzhanController:clearXianZhanEnityByArr('passerbyOnceEntityLookup')
end
if isclear then
return
end
end

lp={}
xianzhanController.passerbyOnceEntityLookup=lp
local bornPosList=cfgHelper.getdef1(cfg_xianzhanpasserbytriggerconfig,'bornPosList')
local randomPosList=cfgHelper.getdef1(cfg_xianzhanpasserbytriggerconfig,'randomPosList')
local passerbycfgs=cfg_xianzhanpasserbyconfig()
local triggercfgs=cfg_xianzhanpasserbytriggerconfig()
local index=1
for i,cfg in ipairs(triggercfgs)do
if cfg.tType==2 then
local bornPos=randomPosList[cfg.bronPosIndx]
local passerbycfg=table.randomIndex(passerbycfgs)
local modelParams=npcModel:getImageInfoOutSide(passerbycfg.npcid)
local scale=modelParams.scale*3
local startPos={bornPos[1],bornPos[2]}
local pos=_MapManager.ToVector3Int(startPos[1],startPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)

local randomTargetPos=table.randomIndex(bornPosList)
local entity={}
entity.passerbyIndex=index
entity.createTime=gameUtilityModel.getServerShortTime()
entity.startPos=startPos
entity.targetPos={randomTargetPos[1],randomTargetPos[2]}
entity.passerbycfg=passerbycfg
entity.manType=xianzhanmanType.ePasserby
entity.guid=guid
local dzId=FMT.fmt('xz_passerby_once_{0}',index)
entity.dzId=dzId
entity.bt=xianzhanController.setPasserbyGotoAI(dzId,guid,entity.targetPos,passerbycfg.speed,
passerbycfg.walkanim)
entity.aiType=1
entity.needBroke=true
lp[guid]=entity
xianzhanController.aiEntityLookup[guid]=entity
index=index+1
end
end
end




function xianzhanController:createPasserbyCreateTrigger(isclear)
if webGLHelper:isRunWebGL()then
return
end
local lp=xianzhanController.passerbyTriggerLookup
if lp~=nil and not isclear then
return
else
if lp~=nil then
for i,trigger in ipairs(lp)do
if trigger.checkTimer then
trigger.checkTimer:cancel()
trigger.checkTimer=nil
end
if trigger.entityList~=nil then
for i2,entity in ipairs(trigger.entityList)do
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
_MapManager.RemoveTilemapObject(entity.guid)
xianzhanController.aiEntityLookup[entity.guid]=nil
end
trigger.entityList=nil
end
end
xianzhanController.passerbyTriggerLookup=nil
end
if isclear then
return
end
end

lp={}
xianzhanController.passerbyTriggerLookup=lp
local triggercfgs=cfg_xianzhanpasserbytriggerconfig()
for i,cfg in ipairs(triggercfgs)do
if cfg.tType==1 then
local trigger={}
local index=#lp
index=index+1
trigger.cfg=cfg
local checkTimer=timer.new()
local func=function()
xianzhanController:onPasserbyCreateTrigger(index)
end
checkTimer:start(cfg.interval,func,-1)
trigger.checkTimer=checkTimer
trigger.index=index
lp[index]=trigger

xianzhanController:onPasserbyCreateTrigger(index)
end
end
end

function xianzhanController:onPasserbyCreateTrigger(index)
if xianzhanController.enityStopModel then return end

local trigger=xianzhanController.passerbyTriggerLookup[index]
local cfg=trigger.cfg
if trigger.entityList==nil then
trigger.entityList={}
end
if#trigger.entityList>=cfg.maxnum then
return
end

local passerbycfgs=cfg_xianzhanpasserbyconfig()
local bornPosList=cfgHelper.getdef1(cfg_xianzhanpasserbytriggerconfig,'bornPosList')
local bornPos=bornPosList[cfg.bronPosIndx]
local passerbycfg=table.randomIndex(passerbycfgs)
local modelParams=npcModel:getImageInfoOutSide(passerbycfg.npcid)
local scale=modelParams.scale*3
local startPos={bornPos[1],bornPos[2]}
local pos=_MapManager.ToVector3Int(startPos[1],startPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)

local randomTargetPos=table.randomIndex(bornPosList,cfg.bronPosIndx)
local entity={}
entity.triggerIndex=trigger.index
entity.createTime=gameUtilityModel.getServerShortTime()
entity.startPos=startPos
entity.targetPos={randomTargetPos[1],randomTargetPos[2]}
entity.passerbycfg=passerbycfg
entity.manType=xianzhanmanType.ePasserby
entity.guid=guid
local dzId=FMT.fmt('xz_passerby_{0}',guid)
entity.dzId=dzId
entity.bt=xianzhanController.setPasserbyGotoAI(dzId,guid,entity.targetPos,passerbycfg.speed,passerbycfg.walkanim)
entity.aiType=1
entity.needBroke=true
table.insert(trigger.entityList,entity)
xianzhanController.aiEntityLookup[guid]=entity
end


function xianzhanController:onPasserbyEvent(entity)
local passerbycfg=entity.passerbycfg
local needStay=passerbycfg.stay~=nil
if needStay then
local curStayNum=entity.curStayNum or 0
local maxStayNum=passerbycfg.staynum or 1
if curStayNum>=maxStayNum then
needStay=false
end
end
if needStay then
local thinkPass=false
local checkTime=nil
local stayThinkData=entity.stayThinkData
if stayThinkData==nil then
checkTime=entity.createTime
else

if stayThinkData[2]~=nil then
checkTime=stayThinkData[2]
end
end
if checkTime~=nil then
local lerp=gameUtilityModel.getServerShortTime()-checkTime
if lerp>=passerbycfg.stay[1]then
local ishit=helper.randomHitNumberRate(passerbycfg.stay[2])
if ishit then
thinkPass=true
end
end
end
if thinkPass then
stayThinkData={}
stayThinkData[1]=gameUtilityModel.getServerShortTime()
entity.stayThinkData=stayThinkData

local lifeTime=passerbycfg.stay[3]
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
local pos=_MapManager.GetTilemapObjectPosition(entity.guid)
entity.bt=xianzhanController.setPasserbyRelaxAI(entity.dzId,entity.guid,pos,lifeTime)
entity.aiType=2

local curStayNum=entity.curStayNum or 0
curStayNum=curStayNum+1
entity.curStayNum=curStayNum
end
end
end


function xianzhanController:passerbyGotoBack(guid)
local entity=xianzhanController:findXianZhanEnityEx(guid)
if entity==nil then return end

if entity.triggerIndex~=nil then
local trigger=xianzhanController.passerbyTriggerLookup[entity.triggerIndex]
if trigger.entityList~=nil then
for i,entity_ in ipairs(trigger.entityList)do
if entity_.guid==entity.guid then
table.remove(trigger.entityList,i)
break
end
end
end
else
local lp=xianzhanController.passerbyOnceEntityLookup
lp[entity.guid]=nil
end

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
_MapManager.RemoveTilemapObject(entity.guid)
xianzhanController.aiEntityLookup[entity.guid]=nil
end


function xianzhanController:passerbyRelaxBack(guid)
local entity=xianzhanController:findXianZhanEnityEx(guid)
if entity==nil then return end
entity.stayThinkData[2]=gameUtilityModel.getServerShortTime()

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end
local passerbycfg=entity.passerbycfg
entity.bt=xianzhanController.setPasserbyGotoAI(entity.dzId,entity.guid,entity.targetPos,
passerbycfg.speed,passerbycfg.walkanim)
entity.aiType=1
end




function xianzhanController:initKeShangEntitys()
local lp=xianzhanController.keShangEntityLookup
if lp~=nil and next(lp)then
xianzhanController:refreshAllKeShangEntitys()
return
end

xianzhanController.keShangEntityLookup={}
xianzhanController.keShangEntityPosLookup={}
xianzhanController.keShangEntityStartPosLookup={}

local ksList=xianzhanModel:getKeShangList()
if ksList and next(ksList)then
for k,data in pairs(ksList)do
xianzhanController:createKeShangEntity(data.npcid,true)
end
end
end

function xianzhanController:refreshAllKeShangEntitys()
local lp=xianzhanController.keShangEntityLookup
for k,entity in pairs(lp)do
if not entity.isLeave then
xianzhanController:refreshKeShangEntity(entity)
end
end
end

function xianzhanController:refreshKeShangEntity(entity)

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end


local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local waitPosList=baseCfg.ksWaitPos
local waitPosIdx=entity.posIdx
local waitPos=waitPosList[waitPosIdx]
local pos=_MapManager.ToVector3Int(waitPos[1],waitPos[2],0)
_MapManager.SetPosition(entity.guid,pos)
local isflip=waitPos[3]==1
isometricMapSystem:setflip(entity.guid,isflip)


UIManager:invokeUIMethod('UIXianZhanMapWin','refreshKeShangHud',waitPosIdx)
end

function xianzhanController:checkAllKeShangHud()
local lp=xianzhanController.keShangEntityLookup
if lp and next(lp)then
for k,entity in pairs(lp)do
local waitPosIdx=entity.posIdx

UIManager:invokeUIMethod('UIXianZhanMapWin','refreshKeShangHud',waitPosIdx)
end
end
end

function xianzhanController:createKeShangEntity(npcId,isInit)
if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.xianzhan)then

return
end

local lp=xianzhanController.keShangEntityLookup
local posLp=xianzhanController.keShangEntityPosLookup
local startPosLp=xianzhanController.keShangEntityStartPosLookup
local npcIdPosLp=xianzhanController.keShangEntityNpcIdPosLookup

local data=xianzhanModel:getKeShangData(npcId)
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
if data and ksCfg then
local npcImageId=ksCfg.npcShowId














local modelParams=npcModel:getImageInfoOutSide(npcImageId)
local scale=modelParams.scale*3
local startPosIdx,waitPosIdx=self:getFreeKeShangPos(npcId)
if not isInit and startPosIdx and waitPosIdx then
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local startPosList=baseCfg.ksStartPos
local startPos=startPosList[startPosIdx]

local pos=_MapManager.ToVector3Int(startPos[1],startPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)
local entity={}
local dzId=FMT.fmt('xz_keshang_{0}',data.id)
entity.dzId=dzId
entity.manType=xianzhanmanType.eKeShang
entity.guid=guid
entity.targetPosIndex=1
local waitPosList=baseCfg.ksWaitPos
local waitPos=waitPosList[waitPosIdx]
entity.targetPosList={{waitPos[1],waitPos[2],waitPos[3]}}
entity.enterTimeStamp=data.rzTime
local leaveTime=data.rzTime+ksCfg.ksTime
entity.leaveTimeStamp=leaveTime
entity.posIdx=waitPosIdx
entity.startPosIdx=startPosIdx
entity.bt=xianzhanController.setKeShangGotoAI(dzId,guid,entity.targetPosList[entity.targetPosIndex],6,"run")
entity.isMoving=true
entity.id=npcId

lp[guid]=entity
posLp[waitPosIdx]=entity
startPosLp[startPosIdx]=true
npcIdPosLp[tostring(npcId)]={posIdx=waitPosIdx,leaveTime=leaveTime}
xianzhanController.aiEntityLookup[guid]=entity
elseif waitPosIdx then

local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local waitPosList=baseCfg.ksWaitPos
local waitPos=waitPosList[waitPosIdx]


local pos=_MapManager.ToVector3Int(waitPos[1],waitPos[2],0)
local guid=xianzhanController:createRoleEntity(objectType.eRole,mapIdType.xianzhan,
0,modelParams.body,modelParams.componets,
SortingLayers.ITBuilding,scale,pos,nil,nil,true)
local entity={}
local dzId=FMT.fmt('xz_keshang_{0}',data.id)
entity.dzId=dzId
entity.manType=xianzhanmanType.eKeShang
entity.guid=guid
entity.targetPosIndex=1
entity.targetPosList={{waitPos[1],waitPos[2],waitPos[3]}}
entity.enterTimeStamp=data.rzTime
local leaveTime=data.rzTime+ksCfg.ksTime
entity.leaveTimeStamp=leaveTime
entity.posIdx=waitPosIdx
entity.startPosIdx=nil
entity.bt=nil
entity.isMoving=false
entity.id=npcId

lp[guid]=entity
posLp[waitPosIdx]=entity
npcIdPosLp[tostring(npcId)]={posIdx=waitPosIdx,leaveTime=leaveTime}
xianzhanController.aiEntityLookup[guid]=entity


UIManager:invokeUIMethod('UIXianZhanMapWin','refreshKeShangHud',waitPosIdx)
end
end
end

function xianzhanController:getKeShangEntityByNpcId(npcId)
local lp=xianzhanController.keShangEntityLookup
if lp==nil then return end
for guid,entity in pairs(lp)do
if npcId==entity.id then
return entity
end
end
end

function xianzhanController:findKeShangPosIndexByNpcId(npcId)
local entity=xianzhanController:getKeShangEntityByNpcId(npcId)
if entity then
local posIndex=entity.posIdx
return posIndex
end
end

function xianzhanController:getFreeKeShangPos(npcId)

local posLp=xianzhanController.keShangEntityPosLookup
local startPosLp=xianzhanController.keShangEntityStartPosLookup
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local startPosList=baseCfg.ksStartPos
local freeStartPosIndexList={}
for i=1,#startPosList do
if not startPosLp[i]then
freeStartPosIndexList[#freeStartPosIndexList+1]=i
end
end
local startPosIdx
local freeStartPosCount=#freeStartPosIndexList
if freeStartPosCount<=0 then

return
elseif freeStartPosCount==1 then
startPosIdx=freeStartPosIndexList[1]
else
local rand=math.random(1,freeStartPosCount)
startPosIdx=freeStartPosIndexList[rand]
end


local npcIdPosLp=xianzhanController.keShangEntityNpcIdPosLookup
local npcIdStr=tostring(npcId)
if npcIdPosLp[npcIdStr]then

local nowTime=timeHelper.getServerShortTime()
local leaveTime=npcIdPosLp[npcIdStr].leaveTime
if nowTime>=leaveTime then
npcIdPosLp[npcIdStr]=nil
else
local waitPosIdx=npcIdPosLp[npcIdStr].posIdx
return startPosIdx,waitPosIdx
end
end


local waitPosList=baseCfg.ksWaitPos
local freeWaitPosIndexList={}
for i=1,#waitPosList do
if not posLp[i]then
freeWaitPosIndexList[#freeWaitPosIndexList+1]=i
end
end
local waitPosIdx
local freeWaitPosCount=#freeWaitPosIndexList
if freeWaitPosCount<=0 then

return
elseif freeWaitPosCount==1 then
waitPosIdx=freeWaitPosIndexList[1]
else
local rand=math.random(1,freeWaitPosCount)
waitPosIdx=freeWaitPosIndexList[rand]
end

return startPosIdx,waitPosIdx
end

function xianzhanController:keShangEntityLeaveByNpcId(npcId,hasSpeak)
local entity=xianzhanController:getKeShangEntityByNpcId(npcId)
if entity and entity.posIdx then
local posIndex=entity.posIdx
xianzhanController:keShangEntityLeave(posIndex,hasSpeak)
end
end

function xianzhanController:keShangEntityLeave(posIndex,hasSpeak)
local entity=xianzhanController:findXianZhanKeShangEnityByPosIndex(posIndex)
if not entity then
return
end


UIManager:invokeUIMethod('UIXianZhanMapWin','removeKeShangHud',posIndex)

if not mainControl:isSceneType(eSceneType.eZongmen)or not zongmenControl:isMountid(mapIdType.xianzhan)then

local guid=entity.guid
xianzhanController:deleteKeShangEntitysByGuid(guid)
return
end

entity.isLeave=true
if hasSpeak then


local npcId=entity.id
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
local speakLibCfg=ksCfg.npcSpeakLib_Finish
local talklist=table.deepCopy(speakLibCfg)
entity.talklist=talklist
end

entity.targetPosIndex=1
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local leavePos=baseCfg.ksLeavePos
entity.targetPosList={{leavePos[1],leavePos[2]}}
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end

local posLp=xianzhanController.keShangEntityPosLookup
if posIndex then
posLp[posIndex]=nil
end

local startPosIdx=entity.startPosIdx
if startPosIdx then
xianzhanController.keShangEntityStartPosLookup[startPosIdx]=nil
end

local npcId=entity.id
xianzhanController.keShangEntityNpcIdPosLookup[tostring(npcId)]=nil

local hasSpeakFlag=hasSpeak and 1 or nil

entity.bt=xianzhanController.setKeShangGotoAI(entity.dzId,entity.guid,entity.targetPosList[entity.targetPosIndex],6,"run",hasSpeakFlag,true)
entity.isMoving=true
end


function xianzhanController:keShangGotoBack(guid)
local entity=xianzhanController:findXianZhanEnityEx(guid)
if entity==nil then return end

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
entity.targetPosIndex=entity.targetPosIndex+1
if entity.targetPosList[entity.targetPosIndex]then

entity.bt=xianzhanController.setKeShangGotoAI(entity.dzId,guid,entity.targetPosList[entity.targetPosIndex],6,"run")
return
else
local isflip=entity.targetPosList[#entity.targetPosList][3]==1
isometricMapSystem:setflip(guid,isflip)
end
end

entity.isMoving=false
local isLeave=entity.isLeave
local posIndex=entity.posIdx
if isLeave then

xianzhanController:deleteKeShangEntitysByGuid(guid,true)
else
local startPosIdx=entity.startPosIdx
if startPosIdx then
xianzhanController.keShangEntityStartPosLookup[startPosIdx]=nil
end

UIManager:invokeUIMethod('UIXianZhanMapWin','refreshKeShangHud',posIndex)
end
end



function xianzhanController:deleteKeShangEntitysByGuid(guid,ignorePosData)
local entity=xianzhanController:findXianZhanEnityEx(guid)
if entity==nil then return end

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if guid then
_MapManager.RemoveTilemapObject(guid)
end
xianzhanController.aiEntityLookup[guid]=nil
local lp=xianzhanController.keShangEntityLookup
lp[guid]=nil

if not ignorePosData then
local posIndex=entity.posIdx
local posLp=xianzhanController.keShangEntityPosLookup
if posIndex then
posLp[posIndex]=nil
end

local startPosIdx=entity.startPosIdx
if startPosIdx then
xianzhanController.keShangEntityStartPosLookup[startPosIdx]=nil
end

local npcId=entity.id
xianzhanController.keShangEntityNpcIdPosLookup[tostring(npcId)]=nil
end
end

function xianzhanController:deleteAllKeShangEntitysEx()
local lp=xianzhanController.keShangEntityLookup
if lp==nil then return end
for guid,entity in pairs(lp)do
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if entity.guid then
_MapManager.RemoveTilemapObject(entity.guid)
end
xianzhanController.aiEntityLookup[guid]=nil
end
xianzhanController.keShangEntityLookup=nil
xianzhanController.keShangEntityPosLookup=nil
end


function xianzhanController:loadKeShangEntityNpcIdPosLookup()
xianzhanController.keShangEntityNpcIdPosLookup=userActorSetting.get('keShangEntityNpcIdPosLookup',{})
end

function xianzhanController:saveKeShangEntityNpcIdPosLookup()
userActorSetting.set('keShangEntityNpcIdPosLookup',xianzhanController.keShangEntityNpcIdPosLookup)
userActorSetting.flush()
end


function xianzhanController:test_clearKeShangEntityNpcIdPosLookup()
xianzhanController.keShangEntityNpcIdPosLookup={}
userActorSetting.set('keShangEntityNpcIdPosLookup',nil)
userActorSetting.flush()
end





function xianzhanController.setRandomMoveAI(manType,dzId,guid,pos,cId)
cId=cId or 2
local args={dzId=dzId,stId=guid}
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,cId)
local initData={
speakrate=cfg.speakrate,
moverate=cfg.moverate,
mov_min_time=cfg.mov_min_time,
mov_max_time=cfg.mov_max_time,
spk_min_time=cfg.spk_min_time,
spk_max_time=cfg.spk_max_time,
range=cfg.range,
cId=cId,
cfgId=-1,
manType=manType,
entityGuid=guid,
startpos=pos,
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}

local bt=behaviorManager:addBehaviorTree('ai_dz_range_random_move',args,false,initData)
return bt
end


function xianzhanController.setRandomTalkAI(manType,dzId,guid)
local args={dzId=dzId,stId=guid}
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,2)
local initData={
speakrate=cfg.speakrate,
spk_min_time=cfg.spk_min_time,
spk_max_time=cfg.spk_max_time,
cId=cfg.id,
cfgId=-1,
manType=manType,
entityGuid=guid,
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
local bt=behaviorManager:addBehaviorTree('ai_dz_random_talk',args,false,initData)
return bt
end


function xianzhanController.setYBGoRoomAI(dzId,guid,roomId,targetPos)
local args={dzId=dzId,stId=guid}
local initData={
cfgId=-1,
roomId=roomId,
targetPos={targetPos[1],targetPos[2],0},
}
local bt=behaviorManager:addBehaviorTree('ai_xianzhan_yb_go_room',args,false,initData)
return bt
end


function xianzhanController.setFangKeLeaveRoom1(dzId,guid,roomId,targetPos)
local args={dzId=dzId,stId=guid}
local initData={
roomId=roomId,
targetPos={targetPos[1],targetPos[2],0},
entityGuid=guid,
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
local bt=behaviorManager:addBehaviorTree('ai_xianzhan_fangke_leave_1',args,false,initData)
return bt
end


function xianzhanController.setFangKeLeaveRoom2(dzId,guid,roomId,targetPos)
local args={dzId=dzId,stId=guid}
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,3)
local initData={
speakrate=cfg.speakrate,
spk_min_time=cfg.spk_min_time,
spk_max_time=cfg.spk_max_time,
cId=cfg.id,
roomId=roomId,
targetPos={targetPos[1],targetPos[2],0},
entityGuid=guid,
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
local bt=behaviorManager:addBehaviorTree('ai_xianzhan_fangke_leave_2',args,false,initData)
return bt
end


function xianzhanController.setPasserbyGotoAI(dzId,guid,targetPos,moveSpeed,moveAnimName)
local args={dzId=dzId,stId=guid}
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,3)
local initData={
speakrate=cfg.speakrate,
spk_min_time=cfg.spk_min_time,
spk_max_time=cfg.spk_max_time,
cId=cfg.id,
cfgId=-1,
entityGuid=guid,
moveSpeed=moveSpeed,
moveAnimName=moveAnimName,
targetPos={targetPos[1],targetPos[2],0},
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
local bt=behaviorManager:addBehaviorTree('ai_xianzhan_passerby_goto',args,false,initData)
return bt
end


function xianzhanController.setPasserbyRelaxAI(dzId,guid,pos,lifeTime)
local args={dzId=dzId,stId=guid}
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,3)
local initData={
speakrate=cfg.speakrate,
moverate=cfg.moverate,
mov_min_time=cfg.mov_min_time,
mov_max_time=cfg.mov_max_time,
spk_min_time=cfg.spk_min_time,
spk_max_time=cfg.spk_max_time,
range=cfg.range,
cId=cfg.id,
cfgId=-1,
entityGuid=guid,
startpos=pos,
lifeTime=lifeTime,
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
local bt=behaviorManager:addBehaviorTree('ai_xianzhan_passerby_relax',args,false,initData)
return bt
end


function xianzhanController.setKeShangGotoAI(dzId,guid,targetPos,moveSpeed,moveAnimName,hasSpeak,isLeave)
local args={dzId=dzId,stId=guid}
local initData={
cfgId=-1,
entityGuid=guid,
moveSpeed=moveSpeed,
moveAnimName=moveAnimName,
targetPos={targetPos[1],targetPos[2],0},
funcObj='xianzhanController',
getTalkFunc='getXianZhanEnitySpeakText',
}
if hasSpeak then
initData.hasSpeak=1
else
initData.hasSpeak=0
end
if isLeave then
initData.isLeave=1
else
initData.isLeave=0
end

local bt=behaviorManager:addBehaviorTree('ai_xianzhan_keshang_goto',args,false,initData)
return bt
end




function xianzhanController:getXianZhanEnitySpeakText(cmdType,bt,tkey,entityGuid)
local guid=entityGuid
local entity=xianzhanController:findXianZhanEnityEx(guid)
local txt=nil
if entity~=nil then
local manType=entity.manType
local talklist
if manType==xianzhanmanType.ePasserby then
if entity.aiType==1 then
talklist=entity.passerbycfg.talk
else
talklist=entity.passerbycfg.staytalk
end
elseif manType==xianzhanmanType.eFangKe then
if entity.leaveType~=nil and entity.leaveType==1 then
local customerId=entity.customerId
local bp=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'extrudeBiaoQing')
txt=chatEmotHelper.getSmallEmotMesg(bp)
bt:setSharedVar(tkey,txt)
return
else
talklist=entity.talklist
end
else
talklist=entity.talklist
end
txt=talklist[math.random(1,#talklist)]
else
txt='我的身体找不到了'
end
bt:setSharedVar(tkey,txt)
end



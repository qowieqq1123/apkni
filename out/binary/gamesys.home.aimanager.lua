


aiManager=gameState.addListener({})

ai_cmd_list='cmd_list'

ai_interrupt_cmd='interrupt_cmd'

ai_wait_broke='wait_broke'
ai_special_move='special_move'
ai_span_map='span_map'

ai_reset_body_logic='reset_body_logic'

ai_move_cmd='move_cmd'
ai_speak_cmd='speak_cmd'

ai_stop_move='stop_move'
ai_stop_speak='stop_speak'

ai_current_cmd_bt='current_cmd_bt'
ai_cmd_mode='cmd_mode'
ai_allow_interrupt='allow_interrupt'

eAIMoveState={
eMoving=1,
eChange=2,
eStop=3,
}

eAICMDMode={
eIdle=1,
eWork=2,
}

eAIType={
eIdle=0,
eRangeMove=1,
eMieHuo=2,
eWork=3,
eSeller=4,
eBuyer=5,
eVisit=6,
eVisitPos=7,
eSundrise=8,
eJuqing1=9,
eJuqing2=10,
eBaiShan=11,
eAvoid=12,
eJuqingShanmen=13,
eAllocateToMap=14,
eFeeding=15,
eFightMonster=16,
}

eAIDZType={
eDefault=1,
eXianChong=2,
eXianZhan=3,
eVisitDiZi=4,
eXianMeng=5,
eFort=6,
}

eAIMoveType={
eDefault=1,
eWalk=2,
eFly=3,
}








aiDefineData={
[eAIType.eIdle]={
name='ai_dz_idle',
jumpInLine=false,
interrupt=false,
allowInterrupt=true,
},
[eAIType.eRangeMove]={
name='ai_dz_range_move',
jumpInLine=false,
interrupt=false,
allowInterrupt=true,
},
[eAIType.eMieHuo]={
name='ai_dz_miehuo',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eSundrise]={

name='ai_clear_sundrise_2',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eWork]={
name='ai_dz_work',
jumpInLine=true,
interrupt=true,
allowInterrupt=true,
isWorkType=true,
},
[eAIType.eSeller]={
name='ai_dz_seller',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
isWorkType=true,
},
[eAIType.eBuyer]={
name='ai_dz_buyer',
jumpInLine=true,
interrupt=true,
allowInterrupt=true,
},
[eAIType.eVisit]={
name='ai_dz_visit_building',
jumpInLine=false,
interrupt=false,
allowInterrupt=true,
},
[eAIType.eVisitPos]={
name='ai_dz_visit_location',
jumpInLine=false,
interrupt=false,
allowInterrupt=true,
},
[eAIType.eJuqing1]={
name='ai_dz_juqing_1',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eJuqing2]={
name='ai_dz_juqing_2',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eBaiShan]={
name='ai_dz_baishan_success',
jumpInLine=false,
interrupt=false,
allowInterrupt=true,
},
[eAIType.eAvoid]={
name='ai_dz_avoid',
jumpInLine=true,
interrupt=true,
allowInterrupt=true,
},
[eAIType.eJuqingShanmen]={
name='ai_dz_shanmen_1',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eAllocateToMap]={
name='ai_dz_allocate_to_map',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
[eAIType.eFeeding]={
name='ai_dz_feeding',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
isWorkType=true,
},
[eAIType.eFightMonster]={
name='ai_clear_monster',
jumpInLine=true,
interrupt=true,
allowInterrupt=false,
},
}

function aiManager:onAppStart()

end

function aiManager:onEnterState(isReconnect)
if isReconnect then
return
end



self.mapBirthPointDatas={}
self.aiMapIDRecord={}
self.discipleBTList={}
self.defaultCMDList={}
for k,v in pairs(eAIDZType)do
self.defaultCMDList[v]={}
end
self.defaultIdleCMD={
[eAIDZType.eDefault]={type=eAIType.eRangeMove},
[eAIDZType.eXianChong]={type=eAIType.eRangeMove},
[eAIDZType.eXianZhan]={type=eAIType.eIdle},
[eAIDZType.eVisitDiZi]={type=eAIType.eRangeMove},
[eAIDZType.eXianMeng]={type=eAIType.eRangeMove},
[eAIDZType.eFort]={type=eAIType.eRangeMove},
}

self:addDiscipleDefaultCMD(eAIDZType.eDefault,{type=eAIType.eVisit})
self:addDiscipleDefaultCMD(eAIDZType.eDefault,{type=eAIType.eVisitPos})
self:addDiscipleDefaultCMD(eAIDZType.eXianChong,{type=eAIType.eVisit})
self:addDiscipleDefaultCMD(eAIDZType.eXianChong,{type=eAIType.eVisitPos})
self:addDiscipleDefaultCMD(eAIDZType.eVisitDiZi,{type=eAIType.eVisitPos})
self:addDiscipleDefaultCMD(eAIDZType.eXianMeng,{type=eAIType.eVisitPos})
self:addDiscipleDefaultCMD(eAIDZType.eFort,{type=eAIType.eVisit})
self:addDiscipleDefaultCMD(eAIDZType.eFort,{type=eAIType.eVisitPos})
end

function aiManager:onLeaveState(isReconnect)
if isReconnect then
return
end

self:closeZongmenAI()
end

function aiManager:onEnterHome()
self.isInHome=true

self:startZongmenAI()
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end

function aiManager:onLeaveHome()
self.isInHome=false
self:closeZongmenAI()

notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end

function aiManager:canUseZongMengAI()
return self.isInHome
end

function aiManager:getAutoToFlyFlag()
return 1
end

function aiManager.onDiscipleStateChange(discipleguid,stateType,old,cur)
local chuiwei=stateType==DISCIPLE_STATE_TYPE.eChuiWei
aiManager:setDZDying(discipleguid,chuiwei)






end

function aiManager:checkAndExpelDZ(bdData)
local dzState=UIDiscipleModel:getDiscipleState(bdData.dizi_id)
if dzState==DISCIPLE_STATE_TYPE.eChuiWei then
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
self:expelDZ(mapId,bdData.un_build_id)
end
end

function aiManager:expelDZ(mapId,ubdId)
zongmenControl:reqChangeBuildingManager(mapId,ubdId,int64.new('0'))
end

function aiManager:startZongmenAI()





if not self.zmAIInit then
self.zmAIInit=true
self.discipleBTList={}
self.aiDZTypeRecord={}
self.aiDZCount=0
end
end

function aiManager:closeZongmenAI()






if self.zmAIInit then
self.zmAIInit=false
self:clearDiscipleAI()
self.aiDZTypeRecord=nil
self.aiDZCount=nil
end
end

function aiManager:getAIDZType(dzId)
return self.aiDZTypeRecord[tostring(dzId)]
end

function aiManager:startWorldAI()
if not self.worldBT then
self.worldBT=behaviorManager:addBehaviorTree('ai_world',nil,true)
end
end

function aiManager:closeWorldAI()
if self.worldBT then
behaviorManager:removeBehaviorTree(self.worldBT)
self.worldBT=nil
end
end

function aiManager:getAIMapID(stId)
return self.aiMapIDRecord[stId]
end

function aiManager:refreshAIMapID(stId)
local mapId=_MapManager.GetObjectMapID(stId)
self.aiMapIDRecord[stId]=mapId
end

function aiManager:setAIMapID(stId,mapId)
self.aiMapIDRecord[stId]=mapId
end

function aiManager:getAIMapIDByDZID(dzId)
local stId=discipleStateManager:getDiscipleEntity(dzId)
return self:getAIMapID(stId)
end

function aiManager:addDiscipleAI(dzId,stId,dzType)
local dzIdStr=tostring(dzId)
if self.discipleBTList[dzIdStr]then
logErr('弟子AI已存在,请勿重复创建')
return nil
end
self:refreshAIMapID(stId)
local bt=behaviorManager:addBehaviorTree('ai_disciple',{dzId=dzId,stId=stId},true)







self.aiDZTypeRecord[dzIdStr]=dzType
bt.dzId=dzId
bt.stId=stId
bt.dzType=dzType
if dzType==eAIDZType.eDefault then
local dzState=UIDiscipleModel:getDiscipleState(dzId)
bt.dying=dzState==DISCIPLE_STATE_TYPE.eChuiWei
end
self.discipleBTList[dzIdStr]=bt
aiStateManager:addAIStateData(dzId)
self.aiDZCount=self.aiDZCount+1
return bt
end

function aiManager:removeDiscipleAI(dzId)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
behaviorManager:removeBehaviorTree(bt)
self.discipleBTList[dzIdStr]=nil





aiStateManager:removeAIStateData(dzId)
self.aiDZCount=self.aiDZCount-1
end

function aiManager:hasDiscipleBT(dzId)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
return bt~=nil
end

function aiManager:getAIDZCount()
return self.aiDZCount
end

function aiManager:getDiscipleAIBT(dzId)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
return bt
end

function aiManager:getAIEntityID(dzId)
local bt=self:getDiscipleAIBT(dzId)
if bt==nil then return end
local args=bt:getArgs()
return args.stId
end

function aiManager:clearDiscipleAI()
for k,v in pairs(self.discipleBTList)do
behaviorManager:removeBehaviorTree(v)
end
self.discipleBTList=nil
end

















































function aiManager:addCommandToDisciple(dzId,cmdData)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
if not bt then
loggerUtil.debugErrFMT('弟子行为树对象不存在，弟子ID:{0} 指令类型:{1}',tostring(dzId),cmdData.type)
return
end
local cmdList=bt:getSharedVar(ai_cmd_list)
local aiData=aiDefineData[cmdData.type]
if aiData.jumpInLine then
table.insert(cmdList,1,cmdData)
if aiData.interrupt then
bt:setSharedVar(ai_interrupt_cmd,true)
end
else
table.insert(cmdList,cmdData)
end


bt:quicklyTick()
end

function aiManager:addDiscipleDefaultCMD(dzType,cmdData)
local list=self.defaultCMDList[dzType]
table.insert(list,cmdData)
end

function aiManager:setMoveCMDToDisciple(dzId,pos,speed,animId,callback,cfgId,moveType)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
bt:setSharedVar(ai_move_cmd,{pos=pos,speed=speed,animId=animId,callback=callback,cfgId=cfgId or-1,moveType=moveType})

bt:quicklyTick()
end

function aiManager:setSpeakCMDToDisciple(dzId,content,duration,skin,container,callback)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
bt:setSharedVar(ai_speak_cmd,{content=content,duration=duration,callback=callback,skin=skin,container=container})

bt:quicklyTick()
end

function aiManager:setDiscipleBTSharedVal(dzId,key,val)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
bt:setSharedVar(key,val);
end

function aiManager:getDiscipleBTSharedVal(dzId,key)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
return bt:getSharedVar(key);
end

function aiManager:getDiscipleDefaultCMD(dzType)
return self.defaultCMDList[dzType]
end

function aiManager:getDefaultIdleCMD(dzType)
return self.defaultIdleCMD[dzType]
end

function aiManager:getDiscipleBTList()
return self.discipleBTList
end


function aiManager:isCanInterruptCMD(bt)
local move_check_1=bt:getSharedVar(ai_special_move)
local move_check_2=bt:getSharedVar(ai_span_map)
local check=move_check_1 or move_check_2
return not check
end


function aiManager:getDiscipleCurrentCMDBT(dzId)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
if bt then
local cbt=bt:getSharedVar(ai_current_cmd_bt)
if cbt and not cbt:isRemove()then
return cbt
end
end
return nil
end

function aiManager:getDiscipleCMDMode(dzId)
local dzIdStr=tostring(dzId)
local bt=self.discipleBTList[dzIdStr]
return bt:getSharedVar(ai_cmd_mode)
end

function aiManager:randomADiscipleByMode(mode,dzType)
local list={}
for k,v in pairs(self.discipleBTList)do
if v.dzType==dzType and not v.dying then
local bm=v:getSharedVar(ai_cmd_mode)
if bm==mode then
table.insert(list,k)
end
end
end
local len=#list
if len>0 then
return list[math.random(1,len)]
end
return nil
end

function aiManager:getSomeDiscipleByMode(mode,dzType,percent)
local list={}
for k,v in pairs(self.discipleBTList)do
if v.dzType==dzType and not v.dying then
local bm=v:getSharedVar(ai_cmd_mode)
if bm==mode then
table.insert(list,k)
end
end
end
local len=#list
local rlist={}
local check=len*percent
for i=1,check do
table.insert(rlist,list[i])
end
return rlist
end

function aiManager:randomADiscipleCanInterrupt(dzType)
local list={}
for k,v in pairs(self.discipleBTList)do
if v.dzType==dzType and not v.dying then
local allow=v:getSharedVar(ai_allow_interrupt)
if allow and self:isCanInterruptCMD(v)then
table.insert(list,k)
end
end
end
local len=#list
if len>0 then
return list[math.random(1,len)]
end
return nil
end

function aiManager:getNearbyDisciple(mapId,pos,dzType)
local list={}
for k,v in pairs(self.discipleBTList)do
if v.dzType==dzType and not v.dying then
local allow=v:getSharedVar(ai_allow_interrupt)
if allow and self:isCanInterruptCMD(v)then
table.insert(list,v:getArgs().stId)
end
end
end
local stId=_MapManager.GetNearestEntity(mapId,pos,list)
local dzId=discipleStateManager:entityIdToDiscipleId(stId)
if not dzId then
dzId=aiManager:createPerpareDisciple(mapId)
end
return dzId
end

function aiManager:createPerpareDisciple(mapId)
local selectDZ
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
local netData=v.netData.net
local dzId=netData.discipleguid
if not self.discipleBTList[tostring(dzId)]then
selectDZ=dzId
break
end
end
if selectDZ then
discipleStateManager:createRole(selectDZ,mapId)
end
return selectDZ
end

function aiManager:getAIDiscipleList(dzType)
local list={}
for k,v in pairs(self.discipleBTList)do
if v.dzType==dzType and not v.dying then
table.insert(list,k)
end
end
return list
end

function aiManager:isDZDying(dzId)
local dzStr=tostring(dzId)
local bt=self.discipleBTList[dzStr]
return bt and bt.dying or false
end

function aiManager:setDZDying(dzId,state)
local dzStr=tostring(dzId)
local bt=self.discipleBTList[dzStr]
if bt then
bt.dying=state
end
end

function aiManager:checkIdleCMDCondition(cmdType,bt,cId)
if cmdType==eAIType.eVisit then
local cfg=cfgHelper.get1(cfg_aifangwenjianzhuconfig_get,cId)
if cfg.condition==1 then
local args=bt:getArgs()
local dzId=args.dzId
local dzType=self:getAIDZType(dzId)
if dzType==eAIDZType.eDefault then
local dzData=UIDiscipleModel:getDiscipleData(dzId)
return dzData:check_in()
end
end
end
return true
end

function aiManager:findABuildingByType(btype,mapId)
local list={}
for k,v in pairs(mapIdType)do
if mapId<1 or v==mapId then
local datas=zongmenModel:getBuildingDataByBdId(v,btype)
for ii,vv in ipairs(datas)do
if vv.flag==0 then
table.insert(list,vv)
end
end
end
end

local bdData=list[math.random(1,#list)]
return bdData
end

function aiManager:getVisitPosList(dzType)
local maps={}
if dzType==eAIDZType.eDefault then
maps[mapIdType.zhufeng]=true
maps[mapIdType.lingshoudao]=true
elseif dzType==eAIDZType.eXianChong then
maps[mapIdType.zhufeng]=true
elseif dzType==eAIDZType.eVisitDiZi then
maps[mapIdType.zhufeng]=true
elseif dzType==eAIDZType.eXianMeng then
maps[mapIdType.xianmeng]=true
elseif dzType==eAIDZType.eFort then
maps[mapIdType.fort]=true
end
local mlist={}
for k,v in pairs(mapIdType)do
local loaded=mountainControl:isLoaded(v)
mlist[v]=loaded and maps[v]
end
local cfgs=cfg_aifangwendidianconfig()
local rlist={}
for i,v in ipairs(cfgs)do
if mlist[v.mapId]then
table.insert(rlist,v)
end
end
return rlist
end

function aiManager:getIdleCMDData(cmdType,bt)
if cmdType==eAIType.eRangeMove then
local cfg=cfgHelper.get1(cfg_aiidlewalkconfig_get,1)
local data={}
data.waitTime=math.random(cfg.minTime,cfg.maxTime)
data.speakrate=cfg.speakrate
data.moverate=cfg.moverate
data.mov_min_time=cfg.mov_min_time
data.mov_max_time=cfg.mov_max_time
data.spk_min_time=cfg.spk_min_time
data.spk_max_time=cfg.spk_max_time
data.range=cfg.range
data.cId=cfg.id
data.cfgId=bt.dying and 3 or-1
local args=bt:getArgs()
data.cpos=_MapManager.GetTilemapObjectPosition(args.stId)
return data
elseif cmdType==eAIType.eVisit then
local args=bt:getArgs()
local dzType=self:getAIDZType(args.dzId)

local exmap=dzType==eAIDZType.eXianChong and mapIdType.zhufeng or 0

local cfg
if dzType==eAIDZType.eFort then
local cfgs=cfg_aifangwenbaoleijianzhuconfig()
cfg=cfgs[math.random(1,#cfgs)]
exmap=mapIdType.fort
else
local cfgs=cfg_aifangwenjianzhuconfig()
cfg=cfgs[math.random(1,#cfgs)]
end

local bdData=aiManager:findABuildingByType(cfg.building,exmap)
if not bdData then


return nil
end
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
local data={}
data.vtime=cfg.time
data.bdType=cfg.building
data.speakrate=cfg.speakrate
data.cId=cfg.id
data.targetPos=isometricMapSystem:getDoorWayPos(bdData)
data.targetId=bdData.un_build_id
data.mapId=mapId
return data
elseif cmdType==eAIType.eVisitPos then
local args=bt:getArgs()
local dzType=self:getAIDZType(args.dzId)

local clist=aiManager:getVisitPosList(dzType)
local cfg=clist[math.random(1,#clist)]
if not cfg then
return nil
end
local spos=_MapManager.ToVector3Int(cfg.pos[1],cfg.pos[2],0)
local mapId=dzType==eAIDZType.eVisitDiZi and visitControl:getVisitMapId(cfg.mapId)or cfg.mapId
if not _MapManager.IsCanMove(mapId,spos,5)then
return nil
end
local tpos=_MapManager.RandomANearbyPosition(mapId,spos,cfg.radius)
local data={}
data.targetPos=tpos
data.speakrate=cfg.speakrate
data.cId=cfg.id
data.mapId=mapId
return data
end
return nil
end

function aiManager:getIdleCMDSpeakText(cmdType,bt,tkey,arg1,arg2)
local args=bt:getArgs()
local dzId=args.dzId

local dzType=self:getAIDZType(dzId)
if dzType==eAIDZType.eXianChong then
local data=xianChongControl:getXianChongData(dzId)
local cfg=cfgHelper.get1(cfg_xianchongspeakconfig_get,data.id)
if cmdType==eAIType.eRangeMove then
local txt=cfg.idlewalk[math.random(1,#cfg.idlewalk)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisit then
local datas
if arg2==1 then
datas=cfg.visitbuilding1[arg1]
else
datas=cfg.visitbuilding2[arg1]
end
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisitPos then
local datas=cfg.visitlocation[arg1]
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else
logErr('弟子访问地点冒泡对话未配置',arg1)
bt:setSharedVar(tkey,'......')
end
end
return
end

if dzType==eAIDZType.eVisitDiZi then
local mapId=visitControl:getVisitDiZiInMapId(dzId)
local cfg=cfgHelper.get1(cfg_visitmapdizispeakconfig_get,mapId)
if cmdType==eAIType.eRangeMove then
local txt=cfg.idlewalk[math.random(1,#cfg.idlewalk)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisit then
elseif cmdType==eAIType.eVisitPos then
local datas=cfg.visitlocation[arg1]
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else
logErr('弟子访问地点冒泡对话未配置',arg1)
bt:setSharedVar(tkey,'......')
end
end
return
end

if dzType==eAIDZType.eXianMeng then
local mapId=mapIdType.xianmeng
local cfg=cfgHelper.get1(cfg_visitmapdizispeakconfig_get,mapId)
if cmdType==eAIType.eRangeMove then
local txt=cfg.idlewalk[math.random(1,#cfg.idlewalk)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisit then
elseif cmdType==eAIType.eVisitPos then
local datas=cfg.visitlocation[arg1]
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else
logErr('弟子访问地点冒泡对话未配置',arg1)
bt:setSharedVar(tkey,'......')
end
end
return
end

if dzType==eAIDZType.eFort then
local mapId=mapIdType.fort
local cfg=cfgHelper.get1(cfg_visitmapdizispeakconfig_get,mapId)
if cmdType==eAIType.eRangeMove then
local txt=cfg.idlewalk[math.random(1,#cfg.idlewalk)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisit then
local datas
if arg2==1 then
datas=cfg.visitbuilding1[arg1]
else
datas=cfg.visitbuilding2[arg1]
end
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else

bt:setSharedVar(tkey,'......')
end
elseif cmdType==eAIType.eVisitPos then
local datas=cfg.visitlocation[arg1]
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else

bt:setSharedVar(tkey,'......')
end
end
return
end

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
local job=imageInfo.job
local cfg=cfgHelper.get1(cfg_disciplevocationbuildspeakconfig_get,job)
if cmdType==eAIType.eRangeMove then
if self:isDZDying(dzId)then
local txts=cfg.dyingidlewalk[imageInfo.sex]





local txt=txts[math.random(1,#txts)]
bt:setSharedVar(tkey,txt)
else
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData:check_in()then

local isEmergencies=emergenciesModel:isInEventTime()
local isNaoGui=false
if isEmergencies then
local type=emergenciesModel:getCurrentEventType()
isNaoGui=type==emergenciesType.eYouHunRaoLuan
end

if not isNaoGui then

local txt=cfg.idlewalk[math.random(1,#cfg.idlewalk)]
bt:setSharedVar(tkey,txt)
else

local txt=cfg.naogui_speak[math.random(1,#cfg.naogui_speak)]
bt:setSharedVar(tkey,txt)
end
else
local txt=cfg.homeless[math.random(1,#cfg.homeless)]
bt:setSharedVar(tkey,txt)
end
end
elseif cmdType==eAIType.eVisit then
local datas
if arg2==1 then
datas=cfg.visitbuilding1[arg1]
else
datas=cfg.visitbuilding2[arg1]
end
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
elseif cmdType==eAIType.eVisitPos then
local datas=cfg.visitlocation[arg1]
if datas then
local txt=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,txt)
else
logErr('弟子访问地点冒泡对话未配置',arg1)
bt:setSharedVar(tkey,'......')
end
end
end

function aiManager:beginWorkAI(dzId,bdId)
if not self.isInHome then
return
end
if not aiManager:hasDiscipleBT(dzId)then
return
end
if self:isDZDying(dzId)then
return
end

if isometricMapSystem:getDesignMode()then

return
end

local mapId=zongmenModel:getBuildingLocationMapId(bdId)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local workRate=0
local bdData=zongmenModel:getBuildingData(bdId)
if bdData.build_id==SLG_SYSTEM_TYPE.eYaoPu or bdData.build_id==SLG_SYSTEM_TYPE.eLinChang then
workRate=cfg.work_rate
end
local cd1=cfg.cd1
local cd2=cfg.cd2
if webGLHelper:isRunWebGL()then
local scale=cfgHelper.get2(cfg_discipleaiconfig_get,1,'time_scale_webgl')
cd1=cd1*scale
cd2=cd2*scale
end
local cmdData={
type=eAIType.eWork,
initData={
speakrate=cfg.speakrate,
rate=cfg.rate,
cd1=cd1,
cd2=cd2,
work=1,
bdId=bdId,
bdSTId=bdData.entityId,
ckType=SLG_SYSTEM_TYPE.eCangKu,
mapId=mapId,
workRate=workRate,
}
}
self:addCommandToDisciple(dzId,cmdData)
end

function aiManager:endWorkAI(dzId)
if not self.isInHome then
return
end
if not aiManager:hasDiscipleBT(dzId)then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eWork then
bt:setSharedVar('work',-1)
bt:reset()
end
end

function aiManager:getWOrkSpeakText(bt,tkey,stype)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local speaks=cfg[string.format('speak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,txt)
end

function aiManager:getLTWOrkSpeakText(bt,tkey,stype)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local speaks=cfg[string.format('lt_speak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,txt)
end

function aiManager:getLTWorkEffect(bt,aKey,sKey,eKey,ptime)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local datas=cfg.lt_effect
local data=datas[math.random(1,#datas)]
bt:setSharedVar(aKey,data[1])
bt:setSharedVar(sKey,data[2])
bt:setSharedVar(eKey,data[3])
bt:setSharedVar(ptime,data[4])
end

function aiManager:isCanPlayWorkEffect()
if isometricMapSystem:isInNormalMode()then
return true
end
return false
end

function aiManager:beginSellerAI(dzId,bdId)
if not self.isInHome then
return
end
if not aiManager:hasDiscipleBT(dzId)then
return
end
if self:isDZDying(dzId)then
return
end
if isometricMapSystem:getDesignMode()then

return
end
local cfg=cfgHelper.get1(cfg_selleraiconfig_get,1)
local cmdData={
type=eAIType.eSeller,
initData={
work=1,
speakrate=cfg.speakrate,
moverate=cfg.moverate,
movecd=cfg.movecd,
speakcd=cfg.speakcd,
checkcd=cfg.checkcd,
pickupcd=cfg.pickupcd,
replenmentcd=cfg.replenmentcd,
bdId=bdId,
ckType=SLG_SYSTEM_TYPE.eCangKu,
}
}
self:addCommandToDisciple(dzId,cmdData)
end

function aiManager:endSellerAI(dzId)
if not self.isInHome then
return
end
if not aiManager:hasDiscipleBT(dzId)then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eSeller then
bt:setSharedVar('work',-1)
bt:reset()
end
end

function aiManager:getSellerSpeak(bt,ubdId,tkey,stype)
local args=UIShopControl:getSellArgsInShop(ubdId)
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,args[1])
local speaks=cfg[string.format('s_speak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
local rstr=FMT.fmt(txt,args[2])
bt:setSharedVar(tkey,rstr)
end

function aiManager:beginBuyerAI(dzId,state,bdId,ubdId)
if not self.isInHome then
return
end
if not aiManager:hasDiscipleBT(dzId)then
discipleStateManager:createRole(dzId,mapIdType.zhufeng)
end

if self:isDZDying(dzId)then
return
end

if isometricMapSystem:getDesignMode()then

return
end

local cmdData={
type=eAIType.eBuyer,
initData={
speakrate=0.5,
buyer=state,
bdId=bdId,
ubdId=ubdId,
},
restorePreviousAI=true,
}
self:addCommandToDisciple(dzId,cmdData)
end

function aiManager:endBuyerAI(dzId)
if not self.isInHome then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eBuyer then
bt:setSharedVar('buyer',-1)
bt:reset()
end

if not discipleStateManager:isMustCreate(dzId)then
if aiManager:hasDiscipleBT(dzId)then
discipleStateManager:removeRole(dzId)
end
end
end

function aiManager:getBuyerSpeak(bt,ubdId,tkey,stype)
local args=UIShopControl:getSellArgsInShop(ubdId)
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,args[1])
local speaks=cfg[string.format('b_speak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
local rstr=FMT.fmt(txt,args[2])
bt:setSharedVar(tkey,rstr)
end

function aiManager:beginFeedingAI(dzId,bdId)
if not self.isInHome then
return
end



if isometricMapSystem:getDesignMode()then

return
end
local mapId=zongmenModel:getBuildingLocationMapId(bdId)
local cfg=cfgHelper.get1(cfg_feedingaiconfig_get,1)
local cmdData={
type=eAIType.eFeeding,
initData={
movecd=cfg.move_cd,
moverate=cfg.move_rate,
speakcd=cfg.speak_cd,
speakrate=cfg.speak_rate,
work=1,
bdId=bdId,
mapId=mapId,
}
}
self:addCommandToDisciple(dzId,cmdData)

local bdData=zongmenModel:getBuildingData(bdId)
local tpos
local plist=_MapManager.GetPlaceObjectNearbySpace(bdData.entityId,1,-1)
if plist and plist.Count>0 then
tpos=plist[math.random(0,plist.Count-1)]
else
tpos=_MapManager.GetTilemapObjectPosition(bdData.entityId)
end
self:allocateToMap(dzId,mapIdType.lingshoudao,tpos,-1)
end

function aiManager:finishFeedingAI(dzId,bdId)
if not self.isInHome then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eFeeding then
bt:broke()
bt:setSharedVar('work',4)
bt:reset()
end
end

function aiManager:endFeedingAI(dzId,bdId)
if not self.isInHome then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eFeeding then
bt:broke()
bt:setSharedVar('work',-1)
bt:reset()
end


local bdData=zongmenModel:getBuildingData(bdId)
local eId=discipleStateManager:getDiscipleEntity(dzId)
local pos=_MapManager.GetTilemapObjectPosition(eId)
if feedingSystem:isInBuildingArea(bdData,pos)then









local tpos,dpos=isometricMapSystem:getDoorWayPos(bdData)
_MapManager.SetPosition(eId,tpos)
_MapManager.SetSortingLayer(eId,SortingLayers.ITBuilding)
end
end

function aiManager:resetFeedingAI(dzId)
if not self.isInHome then
return
end
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eFeeding then
bt:broke()
bt:reset()
end
end

function aiManager:getFeedingSpeakText(bt,tkey,bdId)
local curr=UIShouLanModel:getMonsterVolume(bdId)
local aicfg=cfgHelper.get1(cfg_feedingaiconfig_get,1)
local txts=curr>0 and aicfg.speak_1 or aicfg.speak_2
local str=txts[math.random(1,#txts)]
bt:setSharedVar(tkey,str)
end

function aiManager:getBirthPointList(mapId)
local birthPoints=self.mapBirthPointDatas[mapId]
if birthPoints then
return birthPoints
end
local aicfg=cfgHelper.get1(cfg_discipleaiconfig_get,1)
birthPoints={}
for i,v in ipairs(aicfg.birthPoint[mapId])do
local pos=_MapManager.ToVector3Int(v[1],v[2],0)
local areaId=_MapManager.GetAreaID(mapId,pos)
if zongmenModel:isAreaUnlock(areaId)then
table.insert(birthPoints,v)
end
end

self.mapBirthPointDatas[mapId]=birthPoints
return birthPoints
end

function aiManager:getTeleportPos(mapId,plist)
local list={}
for i,v in ipairs(plist)do
local tpos11=_MapManager.ToVector3Int(v[1][1],v[1][2],0)
local areaId=_MapManager.GetAreaID(mapId,tpos11)
if zongmenModel:isAreaUnlock(areaId)then
table.insert(list,v)
end
end
local len=#list
if len>0 then
return list[math.random(1,len)]
end
return plist[1]
end

function aiManager:createTeleportBT(args,smap,dmap,dpos)
local tpData=cfgHelper.get2(cfg_discipleaiconfig_get,1,'teleport')
local tpos1=self:getTeleportPos(smap,tpData[smap])
local tpos11=_MapManager.ToVector3Int(tpos1[1][1],tpos1[1][2],0)
local tpos12=_MapManager.ToVector3Int(tpos1[2][1],tpos1[2][2],0)
local tpos2=self:getTeleportPos(dmap,tpData[dmap])
local tpos21=_MapManager.ToVector3Int(tpos2[1][1],tpos2[1][2],0)
local tpos22=_MapManager.ToVector3Int(tpos2[2][1],tpos2[2][2],0)
local initData={
tpos11=tpos11,
tpos12=tpos12,
tpos21=tpos21,
tpos22=tpos22,
speed1=tpos1[3],
speed2=tpos2[3],
dmap=dmap,
dpos=dpos,
dzId=args.dzId,
stId=args.stId,
}
local bt=behaviorManager:addBehaviorTree('ai_dz_to_next_map',args,true,initData)
return bt
end

function aiManager:createTeleportBT2(args,smap,dmap,dpos)
local tpData=cfgHelper.get2(cfg_discipleaiconfig_get,1,'teleport')
local tpos2=self:getTeleportPos(dmap,tpData[dmap])
local tpos21=_MapManager.ToVector3Int(tpos2[1][1],tpos2[1][2],0)
local tpos22=_MapManager.ToVector3Int(tpos2[2][1],tpos2[2][2],0)
local initData={
tpos=tpos21,
dmap=dmap,
dpos=dpos,
dzId=args.dzId,
stId=args.stId,
}
local bt=behaviorManager:addBehaviorTree('ai_dz_teleport_to_map',args,true,initData)
return bt
end


function aiManager:teleportToMap(stId,mapId,pos)
_MapManager.SetObjectMapID(stId,mapId)
aiManager:setAIMapID(stId,mapId)
_MapManager.SetPosition(stId,pos)
end

function aiManager:allocateToMap(dzId,mapId,toPos,cfgId)
local cmdData={
type=eAIType.eAllocateToMap,
initData={
mapId=mapId,
cfgId=cfgId,
toPos=toPos,
},
}
self:addCommandToDisciple(dzId,cmdData)
end

function aiManager:allocateDZToMap(stId,mapId,toPos,cfgId)
if not toPos then
local posList=self:getBirthPointList(mapId)
local bp=posList[math.random(1,#posList)]
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)
toPos=_MapManager.RandomANearbyPosition(mapId,spos,bp[3],cfgId or-1)
end
self:teleportToMap(stId,mapId,toPos)
end


function aiManager:getCommonTalkText(cmdType,bt,tkey,funcObj,getTalkFunc,...)
if funcObj~=nil and getTalkFunc~=nil then
local object=_G[funcObj]
if object then
object[getTalkFunc](object,cmdType,bt,tkey,...)
end
end
end

function aiManager:summonDzLingShou(stId,dzId,waitTime)
local mapId=_MapManager.GetObjectMapID(stId)
local pos=_MapManager.GetTilemapObjectPosition(stId)
local nearPos=_MapManager.RandomANearbyPosition(mapId,pos,1,5)

discipleStateManager:addFollowRoleLingShou(dzId,stId,nearPos,mapId,waitTime)
end




function aiManager:test_setDiscipleDefaultCMD(dzType,aiType)
self.defaultCMDList[dzType]={{type=aiType}}
end

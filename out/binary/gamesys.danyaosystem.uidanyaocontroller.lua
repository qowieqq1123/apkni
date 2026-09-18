






UIDanYaoController=gameState.addListener({})

function UIDanYaoController:onAppStart()
socketManager:register_receiver(3,131,UIDanYaoController.recv_3_131)
socketManager:register_receiver(3,132,UIDanYaoController.recv_3_132)
socketManager:register_receiver(3,133,UIDanYaoController.recv_3_133)
socketManager:register_receiver(3,134,UIDanYaoController.recv_3_134)
socketManager:register_receiver(3,135,UIDanYaoController.recv_3_135)
socketManager:register_receiver(3,136,UIDanYaoController.recv_3_136)
socketManager:register_receiver(3,137,UIDanYaoController.recv_3_137)
socketManager:register_receiver(3,138,UIDanYaoController.recv_3_138)
socketManager:register_receiver(3,139,UIDanYaoController.recv_3_139)
end

function UIDanYaoController:onEnterState()
UIDanYaoModel:on_enter_state()
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

notifySystem:listenNotify(notifyConfig.building_event,self.building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)

UIDanYaoModel.initNeecCheckCanGetList()
UIDanYaoModel.initCanGetHudTigger()
end

function UIDanYaoController:onPlayerCreate(...)

end

function UIDanYaoController:onLeaveState()
UIDanYaoModel:on_leave_state()
self.rcReward=nil
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

notifySystem:removelistener(notifyConfig.building_event,self.building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:removelistener(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIDanYaoController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIDanYaoController:onEnterHome()
end
end

function UIDanYaoController:onEnterHome()

local bdDatas=zongmenModel:getBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLianDanFang)
for index,bdData in ipairs(bdDatas)do
local check,least=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)

if check then
self:showZhaLuPerformance(bdData)
end
end
end

function UIDanYaoController:isDingDanSystemOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eDangFangBatch)
end

function UIDanYaoController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eLianDang then
UIDanYaoController:setRecordReward(prizelist)
end
end

function UIDanYaoController.building_event(eventType,sfId,ubdId)

if eventType==buildingEvent.buildComplete or eventType==buildingEvent.levelUpComplete then
local data=zongmenModel:getBuildingData(ubdId)
UIDanYaoModel.checkFreshHud(2,data.build_id,ubdId)
end
end

function UIDanYaoController.on_system_open(sysID)
if zongmenModel:getMountainId()~=mapIdType.zhufeng then return end

UIDanYaoModel.checkFreshHud(1,sysID)
end

function UIDanYaoController.onXianMengChange(flag)
if zongmenModel:getMountainId()~=mapIdType.zhufeng then return end

UIDanYaoModel.checkFreshHud(3)
end

function UIDanYaoController.onXianMengLevelChange(oldlv,guildlevel,oldexp,guildexp)
if zongmenModel:getMountainId()~=mapIdType.zhufeng then return end

if oldlv~=guildlevel then
UIDanYaoModel.checkFreshHud(3)
end
end

function UIDanYaoController.on_money_changed(mtype)
UIDanYaoModel.checkFreshHud(4,mtype)
end

function UIDanYaoController.onShowDiscipleChanged(effectType,temp,effectData)
if effectType==ePrizeType.eLianDang then
local data=temp[4]or{}
local dzId,datas=next(data)
if datas then
local expdata=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local exp=0
for i,v in ipairs(datas)do
if v[3]==v[2]then
exp=exp+v[5]-v[4]
else
for ii=v[2],v[3]-1 do
exp=exp+expdata[v[2]]
end
exp=exp-v[4]+v[5]
end
end
UIDanYaoController:setRecordAddExp(exp)
else
UIDanYaoController:setRecordAddExp(0)
end
end
end

function UIDanYaoController:setRecordAddExp(exp)
self.rcExp=exp
end

function UIDanYaoController:getRecordAddExp()
return self.rcExp
end

function UIDanYaoController:setRecordReward(prizelist)
self.rcReward=prizelist
end

function UIDanYaoController:getRecordReward()
return self.rcReward
end

function UIDanYaoController:isFirstUseDingDan()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLianDan,'FIRST_USE_DING_DAN',0)
return flag==0
end

function UIDanYaoController:recordFirstUseDingDan()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLianDan,'FIRST_USE_DING_DAN',1)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLianDan)
end



function UIDanYaoController:req_data()
socketManager:send_3_131()
end


function UIDanYaoController:req_unlock_df(dfId)
socketManager:send_3_132(dfId)
end


function UIDanYaoController:req_lianzhi(sfId,ubdId,dfId,cnt,fangan)
fangan=fangan or 0
socketManager:send_3_133(sfId,ubdId,dfId,cnt,fangan)
end


function UIDanYaoController:req_danYao_reward(sfId,ubdId,over)
if UIDanYaoController:isDingDanSystemOpen()then
local data=UIDanYaoModel:getBatchData(ubdId)
socketManager:send_3_139(sfId,ubdId,data.currIndex,over or 0)
else
socketManager:send_3_134(sfId,ubdId)
end
end

function UIDanYaoController:req_lianzhi_batch(sfId,ubdId,len,arr)
socketManager:send_3_138(sfId,ubdId,len,arr)
end


function UIDanYaoController:reqOneKeyPrize()
local args=UIDanYaoModel:getOneKeyPrizeData()
if args==nil then return end
local len=#args
if len<=0 then return end

socketManager:send_3_100(len,args)
end


function UIDanYaoController.recv_3_131(datas)
local dfLen=datas[1]
local dfList=datas[2]
local len=datas[3]
local array=datas[4]
local blen=datas[5]
local bArr=datas[6]
UIDanYaoModel:init_danFang_data(dfLen,dfList)
UIDanYaoModel:clear_data()
if len>0 then
for i,v in ipairs(array)do
local sfId=v.sf_id
local ubdId=v.un_build_id

local cnt=v.cnt
UIDanYaoModel:init_data(ubdId,v)
local check=UIDanYaoModel:checkZhaLu(ubdId,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
local bdData=zongmenModel:getBuildingData(ubdId)
UIDanYaoController:showZhaLuPerformance(bdData)
end
if cnt>0 then
UIDanYaoModel:startLianDan(ubdId)

hudControl:refreshBuildingStatusHUD(ubdId)
end
end
end
if blen>0 then
UIDanYaoModel:init_batch_data(bArr)
end
end


function UIDanYaoController.recv_3_132(dfId)
UIManager.info('丹方激活成功')
UIDanYaoModel:addDFUnLock(dfId)
UIDanYaoModel:setDanFangNewFlag(dfId)
UIManager:callWindowFunc('UIDanFangWin','onActive',dfId)
UIDanYaoModel.initCanGetHudTigger()
UIDanYaoController:refreshAllLianDanFangHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eDanFangNew)
notifySystem:postNotify(notifyConfig.onDanFangUnlock,dfId)
end





function UIDanYaoController.recv_3_133(array)
local sfId=array[1]
local ubdId=array[2]
local dfId=array[3]
local cnt=array[4]
local begintime=array[5]
UIDanYaoModel:lianzhi_update_data(array)
UIDanYaoModel:startLianDan(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.liandanStart,sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
local win=UIManager:findActiveWindow('UIDanYaoWin')
if win then
win:flushLianZhiZhong()

AudioManager.playAudio(447)
end
local bdData=zongmenModel:getBuildingData(ubdId)
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eLianDanZhong)
aiManager:beginWorkAI(bdData.dizi_id,ubdId)
end

function UIDanYaoController.recv_3_134(sf_id,un_build_id,curr_cnt,begintime,totaltimes)
UIDanYaoController.recv_3_134_imp({sf_id,un_build_id,curr_cnt,begintime,totaltimes},false)
end



function UIDanYaoController.recv_3_134_imp(array,batch)
local sfId=array[1]
local ubdId=array[2]
local remainCnt=array[3]
local beginTime=array[4]
local passTime=array[5]



local rewards=UIDanYaoController:getRecordReward()or{}
local len=#rewards
UIDanYaoController:setRecordReward(nil)

local bdData=zongmenModel:getBuildingData(ubdId)

local lastDyData=UIDanYaoModel:get_danYaodata(ubdId)

local lastCnt=lastDyData.cnt

local isZhaLu=false

local cddata=buildingCDControl:getCDData(buildingCDType.liandan,ubdId,true)
if cddata then
cddata.rCount=cddata.dyCount-remainCnt
end

if not batch and len>0 then
UIManager:invokeUIMethod('UIFastManagerWin','addDanYaoRewards',ubdId,rewards)
end

UIDanYaoModel:reward_updata_data(array)

local complete
if UIDanYaoController:isDingDanSystemOpen()then
complete=UIDanYaoModel:isDingDanNoProduction(ubdId)
else
complete=remainCnt<=0
end
if complete then
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eLianDanZhong)
UIDanYaoModel:endLianDan(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.liandanComplete,sfId,ubdId)
else
buildingCDControl:resetCDData(buildingCDType.liandan,ubdId)
end
hudControl:closeProgress(ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)

local win=UIManager:findActiveWindow('UIDanYaoWin')
if win then
win:checkAndCallFunc(ubdId,'stopLianZhiTimer')
if not complete then
if beginTime==0 then
win:checkAndCallFunc(ubdId,'flushLianZhiPause')
else
win:checkAndCallFunc(ubdId,'flushLianZhiZhong')
end
else
win:checkAndCallFunc(ubdId,'flushNotHaveDanFang')
end
end


if not batch and len>0 then
















if isZhaLu then
UIManager.info('出现丹劫')
UIDanYaoController:playDanJieEffect(bdData,zl_endTime)
if fullScreenUI.checkFull(UIFullLianDanFangControl)then
UIFullLianDanFangControl:closeUI()
end
else
if not UIManager:findActiveWindow('UIFastManagerWin')then
local func=function(...)
UIManager:closeWindow('UIDanYaoGetExpWin')
end
showPrizeControl.showWindowNow(rewards,func)
local completeCnt=lastCnt-remainCnt
UIManager:showWindow('UIDanYaoGetExpWin',{lastDyData.dfId,bdData,completeCnt})
end
end
end

local list=aiManager:getDiscipleBTList()
if list[tostring(bdData.dizi_id)]then
aiManager:endWorkAI(bdData.dizi_id)
end

end

function UIDanYaoController.recv_3_135(sfId,ubdId,begintime,passTime)
UIDanYaoModel:update_data_time(sfId,ubdId,begintime,passTime)
local win=UIManager:findActiveWindow('UIDanYaoWin')
if win then
if begintime==0 then
win:checkAndCallFunc(ubdId,'flushLianZhiPause')
else
win:checkAndCallFunc(ubdId,'flushLianZhiZhong')
end
win:checkAndCallFunc(ubdId,'refreshDzPanel')
end
hudControl:refreshBuildingStatusHUD(ubdId)
end


function UIDanYaoController.recv_3_136(array)
local sf_id=array.sf_id
local un_build_id=array.un_build_id
UIDanYaoModel:refresh_data(un_build_id,array)

local bdData=zongmenModel:getBuildingData(un_build_id)
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eLianDanZhong)
hudControl:refreshBuildingStatusHUD(un_build_id)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.liandanBreak,sf_id,un_build_id)
end


function UIDanYaoController.recv_3_137(sf_id,un_build_id,zlTime,zlType)

local oCheck,oLeast,oType=UIDanYaoModel:get_zhalu_time(un_build_id)
UIDanYaoModel:set_zhalu_time(un_build_id,zlTime,zlType)

local nCheck,nLeast,nType=UIDanYaoModel:get_zhalu_time(un_build_id)
local bdData=zongmenModel:getBuildingData(un_build_id)

if oCheck then
if oType==DANYAO_ZHALU_SEASON.eBuildingFire then

if UIDanYaoModel:getLianDanFlag(un_build_id)then

buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eLianDanZhong)
end

hudControl:refreshBuildingStatusHUD(un_build_id)


elseif oType==DANYAO_ZHALU_SEASON.eDiscipleSpecial then
UIDanYaoController:hideZhaLuPerformance(bdData)
end
end

if nCheck then
if nType==DANYAO_ZHALU_SEASON.eBuildingFire then

buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eLianDanZhong)

hudControl:refreshBuildingStatusHUD(un_build_id)


elseif nType==DANYAO_ZHALU_SEASON.eDiscipleSpecial then
UIDanYaoController:showZhaLuPerformance(bdData)
end
end
end

function UIDanYaoController.recv_3_138(sfId,ubdId,beginTime,len,list)
local check=UIDanYaoModel:isDingDanNoProduction(ubdId)
UIDanYaoModel:addBatchData(sfId,ubdId,beginTime,len,list)
if check then
local data=UIDanYaoModel:getBatchData(ubdId)
local cIndex=data.currIndex
local dd=data.ddList[cIndex]
if dd then
local arr={
data.sfId,
data.ubdId,
dd.dfId,
dd.cnt,
data.beginTime,
dd.cnt_list_len,
dd.cntList,
}
UIDanYaoController.recv_3_133(arr)
end
else
UIManager:callWindowFunc('UIDanYaoWin','setDingDanList')
end

local data=UIDanYaoModel:getBatchData(ubdId)
local maxDDNum=cfgHelper.getdef1(cfg_danfangconfig,'queueMaxCnt')
local curr=data and#data.ddList or 0
if curr>=maxDDNum then
UIManager:closeWindow('UIDanFangWin')
else
UIManager:callWindowFunc('UIDanFangWin','checkAndRefresh')
end
UIManager.info(FMT.fmt('炼丹订单添加成功（{0}/{1}）',curr,maxDDNum))
end

function UIDanYaoController.recv_3_139(datas,batch)
local sfId=datas[1]
local ubdId=datas[2]
local beginTime=datas[3]
UIDanYaoModel:updateDingDan(datas)
local data=UIDanYaoModel:getBatchData(ubdId)
local dd=data and data.ddList[data.currIndex]
local resiude=dd and dd.cnt or 0
local arr={
sfId,
ubdId,
resiude,
beginTime,
0,
}
UIDanYaoController.recv_3_134_imp(arr,batch)
end

function UIDanYaoController:playDanJieEffect(bdData,zlendTime)









end

function UIDanYaoController:stopDanJieTimer(bdData)





end

function UIDanYaoController:getNomalDanYaoBuild(entityIds)
if entityIds==nil or#entityIds==0 then return end
local sfId=mapIdType.zhufeng
local entityId
local bdData
for _,_entityId in ipairs(entityIds)do
local _bdData=zongmenModel:findBuildingByEntityId(_entityId)
local hasdizi=tostring(_bdData.dizi_id)~='0'
if not UIDanYaoModel:getLianDanFlag(_bdData.un_build_id)and(hasdizi or entityId==nil)then
entityId=_entityId
bdData=_bdData
if hasdizi then
break
end
end
end
return entityId,bdData
end

function UIDanYaoController:jumpDanFangWindow(args)
args=args or{}
local entityId=args.entityId
local dzid
if entityId then
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingByEntityId(entityId)
if isometricMapSystem:checkBuildState(sfId,bdData)then
return false
end
dzid=bdData.dizi_id
else
local entityIds=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eLianDanFang,true,true)
local _entityId,bdData=UIDanYaoController:getNomalDanYaoBuild(entityIds)
if _entityId==nil then
entityId=entityIds and entityIds[1]or nil
else
entityId=_entityId
dzid=bdData.dizi_id
end
end

local args_local=table.weakCopy(args)
if entityId==nil then
return false
else
args_local.entityId=entityId
end
UIFullLianDanFangControl:showProductionWindow(args_local)
if dzid and tostring(dzid)~='0'then
local danFangId=args_local.danFangId
local page=args_local.page
UIFullLianDanFangControl:showWindow('UIDanFangWin',{entityId=entityId,danFangId=danFangId,dzId=dzid,page=page})
end
return true
end


function UIDanYaoController:jumpDanFangWindow2(args)
args=args or{}
local entityId=args.entityId
local dzid

local findhighdz=args.findhighlvdz
if entityId then
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingByEntityId(entityId)

dzid=bdData.dizi_id
else
local buildInfoList=zongmenModel:getBuildingDataByBdId(mapIdType.zhufeng,6)or{}
local buildInfo=buildInfoList[1]
if buildInfo==nil then

return
end
if findhighdz then
local nowlv=0
for k,v in ipairs(buildInfoList)do
local proType=DISCIPLE_PROSKILL_TYPE.eDanDao
if v.dizi_id and tostring(v.dizi_id)~='0'then
local proLevel=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,proType)
if proLevel>=nowlv then
nowlv=proLevel
buildInfo=v
end
end
end
end

entityId=buildInfo.entityId
dzid=buildInfo.dizi_id
end

local args_local=table.weakCopy(args)
if entityId==nil then
return false
else
args_local.entityId=entityId
end

UIFullLianDanFangControl:showProductionWindow(args_local)
if dzid and tostring(dzid)~='0'then
local danFangId=args_local.danFangId
local page=args_local.page
UIFullLianDanFangControl:showWindow('UIDanFangWin',{entityId=entityId,danFangId=danFangId,dzId=dzid,page=page})
end
return true
end


function UIDanYaoController.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
local dfId=UIDanYaoModel:checkIsDanFangUnlockItem(itemid)
if dfId then
local unLock=UIDanYaoModel:isUnLock(dfId)
if not unLock then
UIDanYaoController:req_unlock_df(dfId)
end
end
end

function UIDanYaoController:refreshAllLianDanFangHud()
local allData=UIDanYaoModel:get_all_danyaodata()
for k,v in pairs(allData)do
if v.sfId==mapIdType.zhufeng then
hudControl:refreshBuildingStatusHUD(v.ubdId)
end
end
end

function UIDanYaoController:refreshBuildEffct(bdData)
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
if dyData then
local sfId=dyData.sfId
local ubdId=dyData.ubdId
local zl_endTime=dyData.zlTime
local cnt=dyData.cnt
local serTime=timeHelper.getServerShortTime()
if zl_endTime>serTime then
UIDanYaoController:playDanJieEffect(bdData,zl_endTime)
end
if cnt>0 then
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eLianDanZhong)
end
end
end


function UIDanYaoController.onPrizeDanYaoList(sfId,ubdId,remainCnt,beginTime,totaltimes)
local array={}
array[1]=sfId
array[2]=ubdId
array[3]=remainCnt
array[4]=beginTime
array[5]=totaltimes
UIDanYaoController.recv_3_134_imp(array,true)
end

function UIDanYaoController.onPrizeBatchDanYaoList(sfId,ubdId,beginTime,idx,remove_cnt,curr_cnt,over)
local array={}
array[1]=sfId
array[2]=ubdId
array[3]=beginTime
array[4]=idx
array[5]=remove_cnt
array[6]=curr_cnt
array[7]=over
UIDanYaoController.recv_3_139(array,true)
end

function UIDanYaoController:showZhaLuPerformance(bdData)
local check=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check and bdData.entityId then
buildingCDControl:addCDData(buildingCDType.zhalu,bdData)
_MapManager.SetFadeToColor(bdData.entityId,Color.New(0.65,0.65,0.65,1),1,nil)
local mdata=isometricMapSystem:getModelByData(bdData)
local effectScale=1/mdata.scale
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eMaoYan,nil,nil,effectScale)
end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

function UIDanYaoController:hideZhaLuPerformance(bdData)
buildingCDControl:removeCDData(buildingCDType.zhalu,bdData.un_build_id)
if not emergenciesModel:isInRepairTime(bdData.un_build_id)and not jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)then
_MapManager.SetFadeToColor(bdData.entityId,Color.New(1,1,1,1),1,nil)
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eMaoYan)
end
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

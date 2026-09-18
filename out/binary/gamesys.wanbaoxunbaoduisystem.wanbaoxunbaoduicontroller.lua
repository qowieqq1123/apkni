








wanBaoXunBaoDuiController=gameState.addListener({})



wanBaoXunBaoDuiController.data={}

function wanBaoXunBaoDuiController:onAppStart()

wanBaoXunBaoDuiModel:onAppStart()



socketManager:register_receiver(31,1,self.recv_31_1)
socketManager:register_receiver(31,2,self.recv_31_2)
socketManager:register_receiver(31,3,self.recv_31_3)
socketManager:register_receiver(31,4,self.recv_31_4)
socketManager:register_receiver(31,5,self.recv_31_5)
socketManager:register_receiver(31,6,self.recv_31_6)
socketManager:register_receiver(31,7,self.recv_31_7)
socketManager:register_receiver(31,8,self.recv_31_8)
socketManager:register_receiver(31,9,self.recv_31_9)
socketManager:register_receiver(31,10,self.recv_31_10)
socketManager:register_receiver(31,11,self.recv_31_11)
socketManager:register_receiver(31,12,self.recv_31_12)
socketManager:register_receiver(31,13,self.recv_31_13)
socketManager:register_receiver(31,14,self.recv_31_14)
socketManager:register_receiver(31,15,self.recv_31_15)
socketManager:register_receiver(31,16,self.recv_31_16)
socketManager:register_receiver(31,17,self.recv_31_17)
socketManager:register_receiver(31,18,self.recv_31_18)
socketManager:register_receiver(31,19,self.recv_31_19)
socketManager:register_receiver(31,20,self.recv_31_20)
socketManager:register_receiver(31,21,self.recv_31_21)
socketManager:register_receiver(31,23,self.recv_31_23)
socketManager:register_receiver(31,24,self.recv_31_24)
socketManager:register_receiver(31,25,self.recv_31_25)





wanBaoXunBaoDuiController:onAppStart_entity()
end


function wanBaoXunBaoDuiController:onEnterState(isReconnect)
wanBaoXunBaoDuiModel:onEnterState()
wanBaoXunBaoDuiController:onEnterState_xzs(isReconnect)


notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.on_mystery_quit_finish,self.on_mystery_quit_finish)


notifySystem:listenNotify(notifyConfig.closeUI,self.onCloseUI)

notifySystem:listenNotify(notifyConfig.onWanBaoXunBaoDuiGoAdventure,self.onWanBaoXunBaoDuiGoAdventure)

notifySystem:listenNotify(notifyConfig.onWanBaoXunBaoDuiAdventureReturn,self.onWanBaoXunBaoDuiAdventureReturn)

self.isEnterHome=false
wanBaoXunBaoDuiController:onEnterState_entity()

end


function wanBaoXunBaoDuiController:onProtocolReq(isReconnect)
if isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
wanBaoXunBaoDuiController:onEnterHome()
end
end
end


function wanBaoXunBaoDuiController:onLeaveState(isReconnect)
wanBaoXunBaoDuiModel:onLeaveState(isReconnect)
wanBaoXunBaoDuiController:onLeaveState_xzs(isReconnect)

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.on_mystery_quit_finish,self.on_mystery_quit_finish)

notifySystem:removelistener(notifyConfig.closeUI,self.onCloseUI)
notifySystem:removelistener(notifyConfig.onWanBaoXunBaoDuiGoAdventure,self.onWanBaoXunBaoDuiGoAdventure)
notifySystem:removelistener(notifyConfig.onWanBaoXunBaoDuiAdventureReturn,self.onWanBaoXunBaoDuiAdventureReturn)


wanBaoXunBaoDuiController:onLeaveState_entity()
self.data={}
end


function wanBaoXunBaoDuiController:onLostConnection()
wanBaoXunBaoDuiController:stopCreateCatWorker()
wanBaoXunBaoDuiController:clearAllShip()
end


function wanBaoXunBaoDuiController:onReConnection(isInitPro)

end

function wanBaoXunBaoDuiController.onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eWanBaoXunBaodui_task then





wanBaoXunBaoDuiModel:setAdventurePrize(rewards)
elseif prizeType==ePrizeType.eWanBaoXunBaodui_build then
table.sort(rewards,function(a,b)
return a.sortWeight>b.sortWeight
end)
wanBaoXunBaoDuiController.showWindow(rewards)
end
end

function wanBaoXunBaoDuiController.showPrizeWindow(prizelist,callback,args)
if#prizelist<=0 then return end
local argstable={list=prizelist,callback=callback}
if args then
for k,v in pairs(args)do
argstable[k]=v
end
end
UIManager:showWindow('UIWanBaoXunBaoDui_ShowPrizeWin',argstable)
end

function wanBaoXunBaoDuiController:onEnterHome()
self.isEnterHome=true

if wanBaoXunBaoDuiController:checkWBXBDBuild()then

if wanBaoXunBaoDuiController:checkWBXBDFinishBuild()then

wanBaoXunBaoDuiController:startCreateCatWorkerTimer()
wanBaoXunBaoDuiController:initChannelEntity()
end
return
else

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then

wanBaoXunBaoDuiModel:setWBXBDIsBuild(true)

return
else
local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then

return
end
end


wanBaoXunBaoDuiController.repairWanBaoXunBaoDui()
end
end



end

function wanBaoXunBaoDuiController:onLeaveHome()
self.isEnterHome=false

wanBaoXunBaoDuiController:stopCreateCatWorker()
end


function wanBaoXunBaoDuiController:checkWBXBDBuild()
local isBuild=wanBaoXunBaoDuiModel:getWBXBDsBuild()
if isBuild~=nil then
return isBuild
else
isBuild=false
end

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then
isBuild=true
end
end

wanBaoXunBaoDuiModel:setWBXBDIsBuild(isBuild)
return isBuild

end


function wanBaoXunBaoDuiController:checkWBXBDFinishBuild()
local isFinish=wanBaoXunBaoDuiModel:getWBXBDIsFinishBuild()
if isFinish~=nil then
return isFinish
else
isFinish=false
end

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args)
if data then
isFinish=true
end
end


wanBaoXunBaoDuiModel:setWBXBDIsFinishBuild(isFinish)
return isFinish
end


function wanBaoXunBaoDuiController.recv_31_1(...)
local args={...}
args=args[1]

local cat_num=args[1]
local catList=args[2]
local channel_num=args[3]
local channelOpenList=args[4]
local channel_num2=args[5]
local channelList=args[6]
local qiyu_num=args[7]
local qiyuList=args[8]
local tili_start_time=args[9]
local task_num=args[10]
local taskList=args[11]
local zp_lv=args[12]
local zp_start_time=args[13]
local yp_num=args[14]
local ypCatList=args[15]

wanBaoXunBaoDuiModel:setCatData(cat_num,catList)

wanBaoXunBaoDuiModel:setChannelData(channel_num,channelOpenList)

wanBaoXunBaoDuiModel:setDispatchingChannel(channel_num2,channelList)

wanBaoXunBaoDuiModel:setQiyuEvent(qiyu_num,qiyuList)

wanBaoXunBaoDuiModel:setAdventurePointData(task_num,taskList)

wanBaoXunBaoDuiModel:setRecruitInfo(zp_lv,zp_start_time,yp_num,ypCatList)

wanBaoXunBaoDuiModel:setUpdateEmoployeeTiliTimer(tili_start_time)

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatInit)
end

function wanBaoXunBaoDuiController.recv_31_2(num,tasklist)
wanBaoXunBaoDuiModel:setAdventurePointData(num,tasklist)
end

function wanBaoXunBaoDuiController.recv_31_3(channel_id)
UIManager.info('开启成功')
wanBaoXunBaoDuiModel:addChannel(channel_id)
end

function wanBaoXunBaoDuiController.recv_31_4(taskid,channelid)
wanBaoXunBaoDuiModel:addDispatchChannel(taskid,channelid)
end

function wanBaoXunBaoDuiController.recv_31_5(channel_id,channelInfo)
wanBaoXunBaoDuiModel:addDispatchingChannel(channel_id,channelInfo)
end

function wanBaoXunBaoDuiController.recv_31_6(num,datalist)
wanBaoXunBaoDuiModel:changeEmployeeData(num,datalist)
end

function wanBaoXunBaoDuiController.recv_31_7(channel_id,channelInfo)
wanBaoXunBaoDuiModel:dealChannelReturn(channel_id,channelInfo)
end

function wanBaoXunBaoDuiController.recv_31_8(len,list)
wanBaoXunBaoDuiModel:dealChannelReturnResult(len,list)
end

function wanBaoXunBaoDuiController.recv_31_9(lv,start_time,num,catList)
wanBaoXunBaoDuiModel:setRecruitInfo(lv,start_time,num,catList)
end

function wanBaoXunBaoDuiController.recv_31_10(lv,start_time)
wanBaoXunBaoDuiModel:changeRecruitInfoToTime(lv,start_time)
end

function wanBaoXunBaoDuiController.recv_31_11()
wanBaoXunBaoDuiModel:dealStopRecruitInfo()
end

function wanBaoXunBaoDuiController.recv_31_12(catInfo,start_time)
wanBaoXunBaoDuiModel:changeRecruitInfoToSaveInfo(catInfo,start_time)
end

function wanBaoXunBaoDuiController.recv_31_13(index,type)
wanBaoXunBaoDuiModel:dealRecruitInfo(index,type)
end

function wanBaoXunBaoDuiController.recv_31_14(guid)
wanBaoXunBaoDuiModel:dismissEmoployeeList(guid)
end

function wanBaoXunBaoDuiController.recv_31_15()
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EquipWin","resetLeftBuild")
end

function wanBaoXunBaoDuiController.recv_31_16(catguid,equipguid,lv,exp)
local equip=wanBaoXunBaoDuiModel:getEquipDataByGuid(equipguid)
local olv=equip.itemData.jl_lv
equip.itemData.jl_lv=lv
equip.itemData.jl_exp=exp

if catguid>0 then
local catinfo=wanBaoXunBaoDuiModel:getCatData(catguid)
wanBaoXunBaoDuiModel:updateEmployeeAttrToEquip(catinfo,equip,olv,lv)
end

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_EquipWin","recvRefineEquip")
if olv~=lv then
notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiCatEquipLevelChange,equipguid,lv,olv)
end
end

function wanBaoXunBaoDuiController.recv_31_17(cguid,pos,equip_guid)
wanBaoXunBaoDuiModel:changeEmoployeeEquip(cguid,pos,equip_guid)
end

function wanBaoXunBaoDuiController.recv_31_18(start_time,add_tili)
wanBaoXunBaoDuiModel:changeEmployeeTili(start_time,add_tili)
end

function wanBaoXunBaoDuiController.recv_31_19(catInfo)
wanBaoXunBaoDuiModel:addEmployee(catInfo)
end

function wanBaoXunBaoDuiController.recv_31_20(start_time)
wanBaoXunBaoDuiModel:setUpdateEmoployeeTiliTimer(start_time)
end

function wanBaoXunBaoDuiController.recv_31_21(num,upList)
wanBaoXunBaoDuiModel:setUpRandomAttr(num,upList)
end

function wanBaoXunBaoDuiController.recv_31_23(channelid)
wanBaoXunBaoDuiModel:giveUpAdventure(channelid)
end

function wanBaoXunBaoDuiController.recv_31_24(channelid)
wanBaoXunBaoDuiModel:initPrizeData()
end

function wanBaoXunBaoDuiController.recv_31_25(catListLen,catList)
wanBaoXunBaoDuiModel:addEmployeeList(catList)
end


function wanBaoXunBaoDuiController:reqXunBaoDuiAllData()
socketManager:send_31_1()
end


function wanBaoXunBaoDuiController:reqAdventureMapInfo()
socketManager:send_31_2()
end



function wanBaoXunBaoDuiController:reqUnlockChannel(channel_id)
socketManager:send_31_3(channel_id)
end




function wanBaoXunBaoDuiController:reqTakeAdventureTask(id,channel_id)
socketManager:send_31_4(id,channel_id)
end






function wanBaoXunBaoDuiController:reqGoAdventure(channel_id,num,catlist)
socketManager:send_31_5(channel_id,num,catlist)
end





function wanBaoXunBaoDuiController:reqFeedCat(type,itemguid,catguid)
socketManager:send_31_6(type,itemguid,catguid)
end



function wanBaoXunBaoDuiController:reqEarlyReturn(channel_id,type,item_guid)
item_guid=item_guid or Int64_0
socketManager:send_31_7(channel_id,type,item_guid)
end



function wanBaoXunBaoDuiController:reqFinishReturn(channel_ids,if_assistant)

if_assistant=if_assistant or 0
local len=#channel_ids
if len>0 then
wanBaoXunBaoDuiController:setXZSReceiveFlag(if_assistant)
socketManager:send_31_8(len,channel_ids,if_assistant)
end
end


function wanBaoXunBaoDuiController:reqRecruitInfo()
socketManager:send_31_9()
end



function wanBaoXunBaoDuiController:reqStartRecruit(lv)
socketManager:send_31_10(lv)
end


function wanBaoXunBaoDuiController:reqCancelRecruit()
socketManager:send_31_11()
end


function wanBaoXunBaoDuiController:reqOneRecruiter()
socketManager:send_31_12()
end




function wanBaoXunBaoDuiController:reqRecruiterResult(catguid,operation)
socketManager:send_31_13(catguid,operation)
end



function wanBaoXunBaoDuiController:reqDismissCat(catguid)
socketManager:send_31_14(catguid)
end





function wanBaoXunBaoDuiController:reqBuildEquipment(color,num,guidList)
socketManager:send_31_15(color,num,guidList)
end





function wanBaoXunBaoDuiController:reqRefineEquipment(catguid,equipguid,num,guidList)
socketManager:send_31_16(catguid,equipguid,num,guidList)
end





function wanBaoXunBaoDuiController:reqRemoveEquipment(catguid,pos,guid)
socketManager:send_31_17(catguid,pos,guid)
end





function wanBaoXunBaoDuiController:reqUpdateEmployeeTili()
socketManager:send_31_18()
end

function wanBaoXunBaoDuiController:reqRecoverCatTiliByUseMoney(num,catlist,noAudio)

if not noAudio then
AudioManager.playAudio(631)
end

socketManager:send_31_22(num,catlist)
end

function wanBaoXunBaoDuiController:reqGiveUpAdventure(channelid)
socketManager:send_31_23(channelid)
end





function wanBaoXunBaoDuiController.repairWanBaoXunBaoDui()
local mapId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eTanXianDui
local repairData=isometricMapSystem:getRepairDataByID(mapId,bdId)

repairData=isometricMapSystem:getRepairDataByID(mapId,bdId)
if repairData then

zongmenControl:reqBuild(mapId,repairData.id,repairData.x,repairData.y,repairData.orientation)
end
end











function wanBaoXunBaoDuiController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
wanBaoXunBaoDuiController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
wanBaoXunBaoDuiController:onLeaveHome()
end
end

function wanBaoXunBaoDuiController.onNewDay()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then
wanBaoXunBaoDuiModel:setWBXBDIsBuild(true)
end
end
end

function wanBaoXunBaoDuiController.onNewDay5am()
wanBaoXunBaoDuiModel:setLocalMapPoint({})
wanBaoXunBaoDuiController:reqAdventureMapInfo()
end

function wanBaoXunBaoDuiController.on_building_event(etype,sfId,ubdId,args)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type

if buildType==SLG_SYSTEM_TYPE.eTanXianDui then
wanBaoXunBaoDuiModel:setWBXBDIsBuild(true)
wanBaoXunBaoDuiModel:setWBXBDIsFinishBuild(true)
wanBaoXunBaoDuiController:initChannelEntity()
wanBaoXunBaoDuiController:startCreateCatWorkerTimer()
end
elseif etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eLevelUp)
end
end

function wanBaoXunBaoDuiController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen and wanBaoXunBaoDuiController.isEnterHome==true then
wanBaoXunBaoDuiController.repairWanBaoXunBaoDui()
end
end

function wanBaoXunBaoDuiController.onBehaviorTreeError(uid,filename)
if filename==btType.story_21_WanBaoShangHui_1 then
local bdData=zongmenModel:findBuildingDataByID(1,SLG_SYSTEM_TYPE.eTanXianDui)
if bdData then
isometricMapSystem:changeBuildingModelVisible(bdData,true)
end
end
end

function wanBaoXunBaoDuiController:getMaomaoEquipBagDataInBag(type,quality)
quality=quality or 1
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaoMao}},
[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{quality}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)
return items
end

function wanBaoXunBaoDuiController:getMaomaoMetarialsBagDataInBag(quality)
quality=quality or 1
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaterials}},
[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,{quality}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)
return items
end

function wanBaoXunBaoDuiController:getMaomaoMetarialsDataByGuid(guid)
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaterials}},
[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eEquals,{guid}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter,true)
return items
end

function wanBaoXunBaoDuiController:getMaomaoEquipDataByGuid(guid)
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaoMao}},
[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eEquals,{guid}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter,true)
return items
end

function wanBaoXunBaoDuiController:getMaomaoUpLevelItemInBag()
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eMaoMao}},
[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{2}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaoMaoBag,filter)
return items
end

function wanBaoXunBaoDuiController:getMaomaoTiliItemInBag()
local constConf=wanBaoXunBaoDuiModel:getConstDef()
local filter={
[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,constConf.up_tili_item_list},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
return items[1]
end

function wanBaoXunBaoDuiController:getQuickFinishItemInBag()
local constConf=wanBaoXunBaoDuiModel:getConstDef()
local filter={
[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,{constConf.finish_tx_item}},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
return items[1]
end

function wanBaoXunBaoDuiController:doQiYuEvent()
local qiyuList=wanBaoXunBaoDuiModel:getQiyuEvent()
if#qiyuList>0 then
local eventdata=MysteryEventListModel:get_event_by_guid(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen,self.qiyuList[1][2])

if eventdata then
MysteryEventSystem.event_start(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen,eventdata.eventGroupId,nil,nil)
else
error("not receive qiyu eventdata")
end
table.remove(qiyuList,1)
end
end

function wanBaoXunBaoDuiController:refreshMTBuildHud()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eTanXianDui)
if bdDatas and bdDatas[1]then
hudControl:refreshBuildingStatusHUD(bdDatas[1].un_build_id)
end
end

function wanBaoXunBaoDuiController:showTQCatInfoWin(funcparam)
local catCfg=cfgHelper.get1(cfg_catconfig_get,funcparam.tqcatid)
local speInfo=catCfg.speInfo
local catinfo={}
catinfo.guid=-1
catinfo.wx_id=catCfg.show[1][1]
catinfo.color=speInfo[1]
catinfo.propList=speInfo[2]
catinfo.prop_num=#speInfo[2]
catinfo.txList=speInfo[3]
catinfo.texing_num=#speInfo[3]
catinfo.equip_num=0
catinfo.tili=0
catinfo.name_id=funcparam.tqcatid
catinfo.lv=1

local temp=table.deepCopy(catinfo)
wanBaoXunBaoDuiModel:updateEmployee(temp)

UIManager:showWindow('UIWanBaoXunBaoDui_RecruitmentWin',{type=WBXBD_ReCruitment_TYPE.info,catdata={temp}})
end


function wanBaoXunBaoDuiController:setCatMiJinState(mjid)
self.data.catmijing_id=mjid
end
function wanBaoXunBaoDuiController:getCatMiJinState()
return self.data.catmijing_id or false
end


function wanBaoXunBaoDuiController:checkCatMijinReddot()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mjId=cfg_mj.id
local mj_sever_data=severlist[mjId]
local rwFlag
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
rwFlag=mj_sever_data.rwFlag
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
if rwFlag then
if rwFlag==0 and sever_jindu>=100 and sever_ismj==1 then
return true
end
end
end
return false
end


function wanBaoXunBaoDuiController:checkCatMijinTanShuo()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local tempnum=0
local maxnum=3
local num=MysteryModel:getWanBaoXunBaoDuiTXNum()



for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
if sever_jindu<100 or sever_ismj==0 then
table.insert(list,v)
tempnum=tempnum+1
end
else

local isopen=true
local openLimit=cfg_mj.openLimit

if openLimit[1]then
local day_=timeHelper.getServerOpenDay()
if day_<openLimit[1]then
isopen=false
end
end

if openLimit[2]then
local level=zongmenModel:getLevel()
if level<openLimit[2]then
isopen=false
end
end

if openLimit[3]then
local oldVal=playerModel:getActorFightValue()
if oldVal<openLimit[3]then
isopen=false
end
end
if isopen then
table.insert(list,v)
tempnum=tempnum+1
end
end
if tempnum>=maxnum then
break
end
end




local newlist={}

















local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})

for k,v in ipairs(mijindata)do
for i,j in ipairs(list)do
if v==j then
newlist[#newlist+1]=j
end
end
end


if#newlist>0 then
return true
else
return false
end
end


function wanBaoXunBaoDuiController:checkCatMijinTanShuoRuKou()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local tempnum=0
local maxnum=3
local num=MysteryModel:getWanBaoXunBaoDuiTXNum()
for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
if sever_jindu<100 or sever_ismj==0 then
table.insert(list,v)
tempnum=tempnum+1
end
else

local isopen=true
local openLimit=cfg_mj.openLimit

if openLimit[1]then
local day_=timeHelper.getServerOpenDay()
if day_<openLimit[1]then
isopen=false
end
end

if openLimit[2]then
local level=zongmenModel:getLevel()
if level<openLimit[2]then
isopen=false
end
end

if openLimit[3]then
local oldVal=playerModel:getActorFightValue()
if oldVal<openLimit[3]then
isopen=false
end
end
if isopen then
table.insert(list,v)
tempnum=tempnum+1
end
end
if tempnum>=maxnum then
break
end
end


local newlist={}
local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
for k,v in ipairs(mijindata)do
for i,j in ipairs(list)do
if v==j then
newlist[#newlist+1]=j
end
end
end

if#newlist>0 or#severdata>0 then
return true
else
return false
end
end


function wanBaoXunBaoDuiController:jumpCatMijin()


jumpManager:jump({id=JUMP_TYPE.eWBXBDCatMiJin,args={}})

end


function wanBaoXunBaoDuiController:getNewCatMiJin()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local tempnum=0
local maxnum=3
local num=MysteryModel:getWanBaoXunBaoDuiTXNum()



for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end
if sever_jindu<100 or sever_ismj==0 then
table.insert(list,v)
tempnum=tempnum+1
end
else

local isopen=true
local openLimit=cfg_mj.openLimit

if openLimit[1]then
local day_=timeHelper.getServerOpenDay()
if day_<openLimit[1]then
isopen=false
end
end

if openLimit[2]then
local level=zongmenModel:getLevel()
if level<openLimit[2]then
isopen=false
end
end

if openLimit[3]then
local oldVal=playerModel:getActorFightValue()
if oldVal<openLimit[3]then
isopen=false
end
end
if isopen then
table.insert(list,v)
tempnum=tempnum+1
end
end
if tempnum>=maxnum then
break
end
end



local newlist={}

if num>0 then
if num<maxnum then
for i=1,num do
if list[i]then
newlist[i]=list[i]
end
end
else
for i=1,maxnum do
if list[i]then
newlist[i]=list[i]
end
end
end
end











return newlist
end


function wanBaoXunBaoDuiController.on_mystery_quit_finish(fbid,finishType)
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing

if systemModel.isOpen(cat_sysid)then
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
for k,v in ipairs(cfg_mj)do
local cfg_mj=cfg_catcatmijingconfig_get(v)
local mjId=cfg_mj.id
if mjId==fbid then
MysteryController.send_4_81()
local delayClose=function(...)
wanBaoXunBaoDuiController.delayCloseTimer=nil
wanBaoXunBaoDuiController:jumpCatMijin()
end
wanBaoXunBaoDuiController.delayCloseTimer=timer.new()
wanBaoXunBaoDuiController.delayCloseTimer:start(1,delayClose,1)
end
end
end
end

function wanBaoXunBaoDuiController.isCanShowSystem(isWarning)
isWarning=isWarning or false
local state=false
local info=""
if systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)then
local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data.flag==bdFlagType.undefine then
state=true
else
info='探险队建筑还在建造中，请稍等'
end
else
if state then
info='探险队码头未建造'
else
state=true
end
end
if isWarning then
UIManager.info(info)
end
return state
end


function wanBaoXunBaoDuiController.quickReceiveAllChannel()
local allChannelDatas=wanBaoXunBaoDuiModel:getChannelDatas()

local rlist={}

for index,channelData in pairs(allChannelDatas)do
if channelData.channel_state==WBXBD_Channel_STATE.finish then
rlist[#rlist+1]=channelData.channel_Id
end
end

if#rlist>0 then
table.sort(rlist)

local fid=next(rlist)
local catList=allChannelDatas[fid].employeeList

UIManager:showWindow("UIWanBaoXunBaoDui_ReceiveTransitionWin",{channel_ids=rlist,catList=catList})
else
logErr("没有可领取的航道 但是可通过建筑hud进行触发一键获取")
end
end

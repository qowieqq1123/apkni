






local _MODULENAME="xianzhanController"


gameState.addListener(def_table(_MODULENAME))
xianzhanController.name=_MODULENAME








XianZhanInteractType={
eTalk=1,
eTransaction=2,
eEntrust=3,
}

local isInit=nil

function xianzhanController:onAppStart()

xianzhanModel:onAppStart()






socketManager:register_receiver(6,33,xianzhanController.recv_6_33)
socketManager:register_receiver(6,34,xianzhanController.recv_6_34)
socketManager:register_receiver(6,35,xianzhanController.recv_6_35)
socketManager:register_receiver(6,36,xianzhanController.recv_6_36)
socketManager:register_receiver(6,37,xianzhanController.recv_6_37)
socketManager:register_receiver(6,39,xianzhanController.recv_6_39)
socketManager:register_receiver(6,40,xianzhanController.recv_6_40)
socketManager:register_receiver(6,41,xianzhanController.recv_6_41)
socketManager:register_receiver(6,42,xianzhanController.recv_6_42)
socketManager:register_receiver(6,43,xianzhanController.recv_6_43)
socketManager:register_receiver(6,44,xianzhanController.recv_6_44)
socketManager:register_receiver(6,45,xianzhanController.recv_6_45)
socketManager:register_receiver(6,46,xianzhanController.recv_6_46)
socketManager:register_receiver(6,47,xianzhanController.recv_6_47)
socketManager:register_receiver(6,48,xianzhanController.recv_6_48)
socketManager:register_receiver(6,49,xianzhanController.recv_6_49)

socketManager:register_receiver(6,106,xianzhanController.recv_6_106)
socketManager:register_receiver(6,107,xianzhanController.recv_6_107)
socketManager:register_receiver(6,108,xianzhanController.recv_6_108)
socketManager:register_receiver(6,109,xianzhanController.recv_6_109)
socketManager:register_receiver(6,110,xianzhanController.recv_6_110)
socketManager:register_receiver(6,111,xianzhanController.recv_6_111)




xianzhanController:onAppStart_entity()
end

function xianzhanController:checkInit()
return isInit==true
end


function xianzhanController:onEnterState(isReconnet)

if isReconnet then return end

isInit=nil
xianzhanModel:onEnterState()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.home_event,self.home_event)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
xianzhanController:onEnterState_entity()
end


function xianzhanController:onServerDataInitFinish()
xianzhanModel:onServerDataInitFinish()
end


function xianzhanController:onLeaveState(isReconnet)

if isReconnet then return end

isInit=nil
xianzhanModel:onLeaveState()
xianzhanController:clearKeShangLeaveTimer()
xianzhanController:clearKeShangAddTimer()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:removelistener(notifyConfig.home_event,self.home_event)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
xianzhanController:onLeaveState_entity()
end


function xianzhanController:onLostConnection()

xianzhanController:clearKeShangLeaveTimer()
xianzhanController:clearKeShangAddTimer()
end

function xianzhanController:onTouchUp(fingerIndex,touchCount,screenPoint,guid)
local win=UIManager:findActiveWindow('UIXianZhanMapWin')
if win then
win:onTouchUp(fingerIndex,touchCount,screenPoint,guid)
end
end

function xianzhanController:onTouchUpList(fingerIndex,touchCount,screenPoint,guidList)
local guid=guidList[1]or-1
return xianzhanController:onTouchUp(fingerIndex,touchCount,screenPoint,guid)
end

function xianzhanController:onProtocolReq(isReconnet)
local bdData=xianzhanController:getXianZhanBuild()
if bdData then
xianzhanController:reqXianZhanData()
if not isReconnet then
timeEventController.addNormalTimerHandler(1,'xianzhanController',xianzhanController)
xianzhanController:initXianZhanEnity()
else

xianzhanController:refreshZhiKeAI()
xianzhanController:refreshAllFangKeEntitys()
xianzhanController:refreshAllRoomModel()
end
end
if isReconnet then
UIManager:invokeUIMethod('UIXianZhanMapWin','reconnetRefresh')
end
end

function xianzhanController:getXianZhanBuild()
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if bdData and zongmenModel:checkBuildCanUse(bdData)then
return bdData
end
return nil
end

function xianzhanController:onNormalUpdate(delay)
if not initProControl.isDone()then return end
local updateList=xianzhanModel:getRoomUpdateList()
if#updateList>0 then
for i,v in ipairs(updateList)do
self:req_update_room(v)
end
end
end

function xianzhanController.on_building_event(etype,sfId,ubdId)
if etype==buildingEvent.levelUpComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eXianZhan then
if zongmenModel:checkBuildCanUse(bdData)then
xianzhanController:reqXianZhanData()
timeEventController.addNormalTimerHandler(1,'xianzhanController',xianzhanController)
xianzhanController:initXianZhanEnity()
end
end
end
end

function xianzhanController.onMountainChange(old_sfId,sfId)
if old_sfId==sfId then return end
if old_sfId==mapIdType.xianzhan then
xianzhanController:leaveXianZhan_entity()
notifySystem:removelistener(notifyConfig.on_item_changed,xianzhanController.on_item_changed)
elseif sfId==mapIdType.xianzhan then
xianzhanController:enterXianZhan_entity()
notifySystem:listenNotify(notifyConfig.on_item_changed,xianzhanController.on_item_changed)
end
end

function xianzhanController.home_event(eventType)
if eventType==homeEvent.eLeaveHome then
xianzhanController:leaveSceneClearEntity()
elseif eventType==homeEvent.eEnterHome then
end
end

function xianzhanController.onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eXZKSFinishOrder then
UIManager:showWindow('UIXianZhanKsPrizeWin',{list=temp})
end
end


function xianzhanController.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if changeType~=CHANGE_TYPE.eDelete and newcount>oldcount then
xianzhanModel:autoUnlockZXEx(itemid)
end
end


function xianzhanController.onSendTaskGetReward(taskid)
local roomDatas=xianzhanModel:getRoomsData()
if roomDatas==nil then return end
for roomId,roomData in pairs(roomDatas)do
if roomData.wtTaskId>0 and roomData.wtJieFlag==1 and roomData.wtTaskStaus==0 then
local wtcfg=cfgHelper.get1(cfg_xianzhanweituoconfig_get,roomData.wtTaskId)
if wtcfg and wtcfg.wtType==XIANZHAN_ENTRUST_TYPE.eFightMonster and wtcfg.taskId==taskid then
xianzhanController:req_complete_entrust(roomId)
end
end
end
end

function xianzhanController:reqXianZhanData()
if not xianzhanController:checkInit()then
xianzhanController:req_xianzhan_data()
xianzhanController:req_check_reward()
xianzhanController:req_shop_data()
end
end


function xianzhanController:moveCameraToYB(callback)
local sfcfg=cfgHelper.get1(cfg_monijysfconfig_get,mapIdType.xianzhan)
local camera_pos=cfgHelper.get3(cfg_xianzhanbaseconfig_get,1,'zhikeInfo',3)
local def_orthographic_size=sfcfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
def_orthographic_size=sfcfg.def_orthographic_size_webgl
end
local cameraPos=_MapManager.GetCameraPosition()
local movepos=Vector3(camera_pos[1],camera_pos[2],cameraPos.z)
isometricMapSystem:setCameraOrthoSize(def_orthographic_size[1],0.7,callback,nil)
isometricMapSystem:moveCameraToPosition(movepos,true,nil,0.7)
end



function xianzhanController:enterXianZhanMap(argstable,callback)
local ret,errType=downAssetManager:needDownLoadResGroup(ASSET_GROUP_TYPE.eXianZhan,'仙栈')
if ret then return end

local bdData=xianzhanController:getXianZhanBuild()
if bdData then
local callback_
if callback then
callback_=function(flag,...)
if not flag then
return
end
callback(flag,...)
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianzhan},nil,callback_)
end
end

function xianzhanController:leaveXianZhanMap(callback)
local callback_
if callback then
callback_=function(flag,...)
if not flag then
return
end
callback(flag,...)
end
end
local func=function()
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},nil,callback_)
end
local win=UIManager:findActiveWindow('UIXianZhanMapWin')
if win then
local camera_pos=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'camera_pos')
local cameraPos=_MapManager.GetCameraPosition()
local sfcfg=cfgHelper.get1(cfg_monijysfconfig_get,mapIdType.xianzhan)
local def_orthographic_size=sfcfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
def_orthographic_size=sfcfg.def_orthographic_size_webgl
end
local movepos=Vector3(camera_pos[1],camera_pos[2],cameraPos.z)
local max=def_orthographic_size[3]+3
local cur=_MapManager.GetCameraOrthographicSize()+3
isometricMapSystem:setchangeCameraOrthoSize_max(max)
isometricMapSystem:setCameraOrthoSize(cur,0.5,nil,nil)
isometricMapSystem:moveCameraToPosition(movepos,true,nil,0.5)
func()

else
func()
end
end


function xianzhanController:openXianZhanMainWin(argstable)
return UIManager:showWindow('UIXianZhanMapWin',argstable)
end

function xianzhanController:closeXianZhanMainWin()
UIManager:closeWindow('UIXianZhanMapWin')
end


function xianzhanController:showInteractWin(argstable)
UIManager:showWindow('UIXianZhanInteractWin',argstable)
end


function xianzhanController:showEntrustWin(argstable)
jumpManager:jump({type=0,id=1001,args={type=SLG_SYSTEM_TYPE.eXianZhan}})
local datas=xianzhanModel:getRoomsData()
for i,v in pairs(datas)do
local weituoId=v.wtTaskId
local taskid=cfgHelper.get2(cfg_xianzhanweituoconfig_get,weituoId,'taskId')
if taskid and taskid==argstable.taskid then
xianzhanController:showInteractWin({v.roomId,XianZhanInteractType.eEntrust})
break
end
end
end

function xianzhanController:closeInteractWin()
UIManager:invokeUIMethod('UIXianZhanInteractWin','onCloseBtn')
end

function xianzhanController:resetInreractSpeak()
UIManager:invokeUIMethod('UIXianZhanInteractWin','restChatSpeak')
end

function xianzhanController:closeInteractAttachWin(argstable)
UIManager:invokeUIMethod('UIXianZhanInteractWin','closeWin',argstable)
end

function xianzhanController:interactStartTalk(speakList,callback,breakback)
UIManager:invokeUIMethod('UIXianZhanInteractWin','startTalk',speakList,callback,breakback)
end

function xianzhanController.showhgdChange(hgd)

local str
if hgd>0 then
str=FMT.fmt('亲密度提升{0}点',hgd)
else
str=FMT.fmt('亲密度降低{0}点',-hgd)
end
UIManager.info(str)
end






function xianzhanController:req_xianzhan_data()
socketManager:send_6_33()
end


function xianzhanController:req_unlock_room(roomId)
socketManager:send_6_34(roomId)
end


function xianzhanController:req_complete_entrust(roomId)
local rewards=xianzhanModel:getWTRewardByRoomID(roomId)
local num=#rewards
for i=1,num do
local reward=rewards[i]
if reward then
local itemid=reward[1]
local bagType=itemsConfig.getBagType(itemid)
if bagType then
if bagHelper.checkBagFull(bagType)then

return
end
end
end
end

socketManager:send_6_35(roomId)
end


function xianzhanController:req_room_rebuild(roomId,roomtype)
socketManager:send_6_36(roomId,roomtype)
end


function xianzhanController:req_xianzhan_reward(assistant)


socketManager:send_6_37(assistant or 0)
end








function xianzhanController:req_shop_Transaction(array)
socketManager:send_6_39(unpack(array))
end


function xianzhanController:req_accept_entrust(roomId,taskid)
socketManager:send_6_40(roomId,taskid)
end


function xianzhanController:req_fk_out(roomId)
socketManager:send_6_41(roomId)
end


function xianzhanController:req_shop_data()
socketManager:send_6_42()
end


function xianzhanController:req_shop_buy(itemid,count)
socketManager:send_6_43(itemid,count)
end


function xianzhanController:req_update_room(roomId)
socketManager:send_6_44(roomId)
end


function xianzhanController:req_check_reward()
socketManager:send_6_45()
end


function xianzhanController:req_customer_talk(roomId)
socketManager:send_6_46(roomId)
end


function xianzhanController:req_unlock_zx(zxTypeId)

socketManager:send_6_47(zxTypeId)
end

function xianzhanController:req_yingbin(roomIDList,assistant)

socketManager:send_6_49(#roomIDList,roomIDList,assistant or 0)
end

function xianzhanController:req_get_keshang_data()
socketManager:send_6_106()
end

function xianzhanController:req_kickout_keshang(npcId)
socketManager:send_6_107(npcId)
end

function xianzhanController:req_finish_keshang_order(npcId,rwIndex)
socketManager:send_6_108(npcId,rwIndex)
end

function xianzhanController:req_start_keshang_jishi()
socketManager:send_6_109()
end

function xianzhanController:req_add_new_keshang()
socketManager:send_6_110()
end

function xianzhanController:req_overtime_leave_keshang(npcId)
xianzhanModel:setFastLeaveKeShangData(nil)

socketManager:send_6_111(npcId)
end



function xianzhanController.recv_6_33(roomListLen,roomList)























if not isInit then
isInit=true
xianzhanModel:init_data(roomListLen,roomList,true)
else
xianzhanModel:init_data(roomListLen,roomList,false)
end
notifySystem:postNotify(notifyConfig.onXianZhanRoomChange)
end


function xianzhanController.recv_6_34(roomData)
local roomId=roomData.roomId
xianzhanModel:update_room_data(roomData)
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_unlockRoom',roomId)
UIManager:closeWindow('UIXianZhanUnLockWin')

xianzhanController:refreshFangKeEntity(roomId)
xianzhanController:refreshZhiKeAI()
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshZhiKeHud')

notifySystem:postNotify(notifyConfig.onXianZhanRoomChange)
end


function xianzhanController.recv_6_35(roomData)
local roomId=roomData.roomId
local oldRoomData=xianzhanModel:getRoomDataByRoomId(roomId)
local oldhgd=oldRoomData.haoGanDu
xianzhanModel:update_room_data(roomData)
local curhgd=roomData.haoGanDu
local hgd_change=false
if oldhgd~=curhgd then
hgd_change=true
local lerphgd=curhgd-oldhgd
xianzhanController.showhgdChange(lerphgd)
end

UIManager:invokeUIMethod('UIXianZhanEntrustWin','startRewardSpeak')
if hgd_change then
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshHaoGanDu',roomId,true)
end
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshWeiTuoBtn',roomData.roomId)
end


function xianzhanController.recv_6_36(roomId,roomType)
xianzhanModel:update_room_type(roomId,roomType)
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_rebuildRoom',roomId)
UIManager:invokeUIMethod('UIXianZhanReBuildWin','rec_rebuildRoom',roomId)
end


function xianzhanController.recv_6_37(itemListLen,itemList,assistant)

if assistant==0 and itemListLen>0 then
local conf={}
for k,v in ipairs(itemList)do
local itemid=v.param_1
local itemConfig=itemsConfig.getConfig(itemid)
table.insert(conf,{itemid=itemid,num=v.param_2,color=itemConfig.color})
end
table.sort(conf,function(a,b)return a.color>b.color end)

showPrizeControl.showWindowNow(conf)
end

xianzhanModel:setTuiFangReward(false)
xianzhanController:refreshXianZhanBuildHud()
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_tuifangReward')
notifySystem:postNotify(notifyConfig.onXianZhanTuiFangReward,itemListLen,itemList,assistant)
end




function xianzhanController.recv_6_39(roomData,exchType,result)
local roomId=roomData.roomId
local oldRoomData=xianzhanModel:getRoomDataByRoomId(roomId)
local oldGoodLookup=xianzhanController.getFangKeGoodsLookup(oldRoomData.exchList)
local oldhgd=oldRoomData.haoGanDu
xianzhanModel:update_room_data(roomData)
local newGoodLookup=xianzhanController.getFangKeGoodsLookup(roomData.exchList)
local curhgd=roomData.haoGanDu
local hgd_change=false
if oldhgd~=curhgd then
hgd_change=true
local lerphgd=curhgd-oldhgd
xianzhanController.showhgdChange(lerphgd)
end

local goodlist={}
if exchType~=3 then
for itemId,itemNum in pairs(oldGoodLookup)do
if newGoodLookup[itemId]==nil then
showPrizeControl.insertTemp(goodlist,nil,itemId,itemNum)
elseif newGoodLookup[itemId]~=itemNum then
local num=itemNum-newGoodLookup[itemId]
if num>0 then
showPrizeControl.insertTemp(goodlist,nil,itemId,num)
end
end
end
end
UIManager:invokeUIMethod('UIXianZhanTransactionWin','rec_jiaoyi',roomData,exchType,result,goodlist)
if hgd_change then
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshHaoGanDu',roomId,true)
end
end
function xianzhanController.getFangKeGoodsLookup(list)
local lookup={}
if list then
for i,v in ipairs(list)do
if lookup[v.itemId]==nil then
lookup[v.itemId]=v.itemNum
else
lookup[v.itemId]=lookup[v.itemId]+v.itemNum
end
end
end
return lookup
end


function xianzhanController.recv_6_40(roomId,wtId)
local roomData=xianzhanModel:getRoomDataByRoomId(roomId)
if roomData==nil then return end
roomData.wtJieFlag=1

UIManager.info('已接取委托')
UIManager:invokeUIMethod('UIXianZhanEntrustWin','rec_acceptWT',roomId,wtId)
end


function xianzhanController.recv_6_41(roomData)
local roomId=roomData.roomId
local oldRoomData=xianzhanModel:getRoomDataByRoomId(roomId)
xianzhanModel:markNote(oldRoomData,2)

xianzhanModel:update_room_data(roomData)

local data=xianzhanModel:getBeforeKickOutData()
local customerId=data.customerId
local old_hgd=data.haoGanDu
local level=npcModel.getHaoGanDuLevel(old_hgd)
local deValue=xianzhanModel:getKickoutFKHanGanDu(customerId,level)
local nowHgd=npcModel:getNewHaoGanDu(old_hgd,-deValue)
xianzhanController.showhgdChange(-deValue)

UIManager:invokeUIMethod('UIXianZhanInteractWin','kickOutRefreshHaoGanDu',old_hgd,nowHgd)

local func=function()
xianzhanController:fangkeLeaveRoom(roomId,1)
end
UIManager:invokeUIMethod('UIXianZhanInteractWin','fkOutSpeak',func)
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_kickoutNpc',roomId)

npcModel:customerLevel(customerId)
xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_42(itemListLen,itemList)
xianzhanModel:init_shopdata(itemListLen,itemList)

UIManager:invokeUIMethod('UIXianZhan_ShopWin','updateView')
end





function xianzhanController.recv_6_43(shopItem)
xianzhanModel:update_shopdata(shopItem)

UIManager:invokeUIMethod('UIXianZhan_ShopWin','refreshGoodItemByItemid',shopItem.itemId)
end


function xianzhanController.recv_6_44(errCode,roomData)

if errCode>0 then





if roomData then

local roomId_=roomData.roomId
local roomData_=xianzhanModel:getRoomDataByRoomId(roomId_)
if roomData_ then
roomData_.lockUpdata=true
end
end
return
end

local old_yb=false
local roomId=roomData.roomId
local oldRoomData=xianzhanModel:getRoomDataByRoomId(roomId)
local old_customerId=nil
local oldhgd=nil
if oldRoomData then
old_customerId=oldRoomData.customerId
old_yb=xianzhanModel:checkRoomNeedYB(oldRoomData)
if old_customerId>0 then
oldhgd=oldRoomData.haoGanDu
end
end
local curhgd=nil
if roomData.customerId>0 then
curhgd=roomData.haoGanDu
end
xianzhanModel:update_room_data(roomData)
local cur_yb=xianzhanModel:checkRoomNeedYB(roomData)

local isleave=false
local isenter=false
if roomData.customerId<=0 and old_customerId~=nil and old_customerId>0 then
isleave=true
xianzhanController:req_check_reward()
xianzhanController:closeInteractWin()
if mainControl:isInScene(eSceneType.eZongmen)then
local name=xianzhanModel.getFangKeName(old_customerId)
UIManager.info(FMT.fmt('{0}因居住期限已到离开了仙栈',name))
end
elseif roomData.customerId~=old_customerId and roomData.customerId>0 then
isenter=true
end
if isleave then
xianzhanController:fangkeLeaveRoom(roomId,2)
xianzhanModel:markNote(oldRoomData,1)
else
if(old_yb~=cur_yb)or(roomData.customerId>0 and roomData.customerId~=old_customerId)then
xianzhanController:refreshFangKeEntity(roomId)
end
end
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_updataRoom',roomId)

local hgd_change=false
if oldhgd~=nil and curhgd~=nil and oldhgd~=curhgd then
hgd_change=true
if mainControl:isInScene(eSceneType.eZongmen)then
local lerphgd=curhgd-oldhgd
xianzhanController.showhgdChange(lerphgd)
end
end


if not old_yb and cur_yb then
xianzhanController:refreshZhiKeAI()
UIManager:invokeUIMethod('UIXianZhanMapWin','refreshZhiKeHud')
end
if hgd_change then
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshHaoGanDu',roomId,true)
end

local chatMsg_fmt
local chatName
if isenter then
chatMsg_fmt=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'ruzhuMsg')
chatName=xianzhanModel.getFangKeName(roomData.customerId)
npcModel:customer2NPC(roomData)
xianzhanController:refreshXianZhanBuildHud()
elseif isleave then
chatMsg_fmt=cfgHelper.get2(cfg_xianzhanbaseconfig_get,1,'tuizhuMsg')
chatName=xianzhanModel.getFangKeName(old_customerId)
npcModel:customerLevel(old_customerId)
xianzhanController:refreshXianZhanBuildHud()
end
if chatMsg_fmt then
local chatMsg=FMT.fmt(chatMsg_fmt,gameUtilityModel.getGameYear(),chatName)
chatControl.onRecvSystemMesg(CHAT_MSG_TYPE.eNoFitler,chatConfig.getSystemPosValue({CHAT_CHANNNEL.eSystem}),chatMsg)
end
end



function xianzhanController.recv_6_45(haveFlag)
xianzhanModel:setTuiFangReward(haveFlag)
UIManager:invokeUIMethod('UIXianZhanMapWin','rec_tuifangReward')
xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_46(roomId,hgdVal,dayTalkNum)
local oldRoomData=xianzhanModel:getRoomDataByRoomId(roomId)
local oldhgd=oldRoomData.haoGanDu
local curhgd=hgdVal
local hgd_change=false
if oldhgd~=curhgd then
hgd_change=true
local lerphgd=curhgd-oldhgd
xianzhanController.showhgdChange(lerphgd)
end

xianzhanModel:update_room_talk(roomId,hgdVal,dayTalkNum)
if hgd_change then
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshHaoGanDu',roomId,true)
end
end


function xianzhanController.recv_6_47(result,zxTypeId)


if result==0 then
xianzhanModel:unlockZX(zxTypeId)

local cfg=cfgHelper.get1(cfg_xianzhanzhuangxiuconfig_get,zxTypeId)
UIManager.info(FMT.fmt('已激活{0}房间类型',cfg.name))
end
end


function xianzhanController.recv_6_48(listLen,zxTypeIdList)

xianzhanModel:init_zxData(listLen,zxTypeIdList)
end


function xianzhanController.recv_6_49(len,roomList,assistant)


if len>0 then
xianzhanController:excuteYBAI()

xianzhanModel:init_data(len,roomList,false)
xianzhanController:refreshXianZhanBuildHud()
end
notifySystem:postNotify(notifyConfig.onXianZhanYingBin,len,roomList,assistant)
end


function xianzhanController.recv_6_106(len,xzksList,nextTime,nextNpcId)
xianzhanModel:setKeShangList(len,xzksList)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()


UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_107(npcId,nextTime,nextNpcId)
xianzhanModel:removeKeShangData(npcId)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)

xianzhanController:keShangEntityLeaveByNpcId(npcId)


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()


UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_108(npcId,nextTime,nextNpcId)
xianzhanModel:removeKeShangData(npcId)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)

xianzhanController:keShangEntityLeaveByNpcId(npcId,true)


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()


UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_109(len,addKsList,nextTime,nextNpcId)

xianzhanModel:addKeShangData(len,addKsList)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)

if len>0 then
for i,v in ipairs(addKsList)do
local npcId=v.npcid

xianzhanController:createKeShangEntity(npcId)
end
end


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()

UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_110(len,addKsList,nextTime,nextNpcId)
xianzhanModel:addKeShangData(len,addKsList)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)
if len>0 then
for i,v in ipairs(addKsList)do
local npcId=v.npcid

xianzhanController:createKeShangEntity(npcId)
end
end


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()


UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end


function xianzhanController.recv_6_111(npcId,nextTime,nextNpcId)
xianzhanModel:removeKeShangData(npcId)
xianzhanModel:setKeShangNextTime(nextTime)
xianzhanModel:setKeShangNextNpcId(nextNpcId)

xianzhanController:keShangEntityLeaveByNpcId(npcId)


xianzhanController:checkKeShangFastLeaveTime()

xianzhanController:setKeShangAddTimer()


UIManager:invokeUIMethod("UIXianZhanMapWin","refreshKeShangPanel")

xianzhanController:refreshXianZhanBuildHud()
end



function xianzhanController:refreshXianZhanBuildHud()
local msgShow=xianzhanModel:hasYingBinRoom()
UIManager:invokeUIMethod("UIBuildingMsgWin","showMsgSpe",3,msgShow)

local bdData=xianzhanController:getXianZhanBuild()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
return true
end
return false
end

function xianzhanController:xianzhanTaskJump(taskid,wtConfig)
if wtConfig==nil then
wtConfig=xianzhanModel:getWTConfigByTaskid(taskid)
end
local errorCode=-1
if wtConfig then
local wtParam=wtConfig.wtParam
local typo=wtParam[1]
local taskConfig=taskModel:getTaskConfig(taskid)
local params=taskConfig.params
local check=true
if typo==2 then

local checkBlock=xianzhanModel:checkWorldBlockNeedUnlock(taskConfig,wtConfig,true)
if checkBlock then
check=false
end
end
if check then

local screenParams=table.deepCopy(wtConfig.screenParams)
local targetParams=table.deepCopy(wtConfig.targetParams)
if screenParams and targetParams then
errorCode=0
if typo==2 then
local pos=worldResPointDataModel:findTaskPosition(taskid)
if pos~=nil then
if targetParams[1]==cameraMoveTargetType.eWorld_pos then
targetParams[2]={pos.x,pos.y,pos.z}
end
else
errorCode=-2
logErr(FMT.fmt('委托id:{0}，任务id：{1}，获取跳转坐标失败',wtConfig.id,taskid))
end
end
if errorCode==0 then
cameraMoveController:Begin(screenParams,targetParams)
end
else
logErr(FMT.fmt('委托id:{0}未配置跳转参数',wtConfig.id))
end
end
else
logErr(FMT.fmt('委托表没找到此任务id：{0}',taskid))
end
return errorCode==0
end


function xianzhanController:checkKeShangFastLeaveTime()
self:clearKeShangLeaveTimer()
local ksList=xianzhanModel:getKeShangList()
local fastLeaveKsData=xianzhanModel:getFastLeaveKeShangData()
local lastFastLeaveTime=fastLeaveKsData and fastLeaveKsData.leaveTime
local newFastLeaveData
local newFastLeaveTime
if ksList and next(ksList)then
for i,v in pairs(ksList)do
local npcId=v.npcid
local npcCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
local leaveTime=v.rzTime+npcCfg.ksTime
if not lastFastLeaveTime or leaveTime<lastFastLeaveTime then
if not newFastLeaveTime or leaveTime<newFastLeaveTime then
newFastLeaveData=v
newFastLeaveTime=leaveTime
end
end
end
end

if newFastLeaveData or fastLeaveKsData then
if newFastLeaveData then
xianzhanModel:setFastLeaveKeShangData(newFastLeaveData)
end

local func=function()
local leaveKsData=xianzhanModel:getFastLeaveKeShangData()
if leaveKsData then
local nowTime=timeHelper.getServerShortTime()
local npcId=leaveKsData.npcId
local lerp=leaveKsData.leaveTime-nowTime

if nowTime>=leaveKsData.leaveTime then

return xianzhanController:req_overtime_leave_keshang(npcId)
end

else

return xianzhanController:clearKeShangLeaveTimer()
end
end

self.ksLeaveTimer=timer.new()
self.ksLeaveTimer:start(1,func)

func()
end
end


function xianzhanController:clearKeShangLeaveTimer()
if self.ksLeaveTimer then
self.ksLeaveTimer:cancel()
self.ksLeaveTimer=nil
end
end


function xianzhanController:setKeShangAddTimer()
self:clearKeShangAddTimer()

local func=function()
local nextTime=xianzhanModel:getKeShangNextTime()
if nextTime and nextTime>0 then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=nextTime then

xianzhanController:refreshXianZhanBuildHud()

return xianzhanController:clearKeShangAddTimer()
end
else

return xianzhanController:clearKeShangAddTimer()
end
end

self.ksAddTimer=timer.new()
self.ksAddTimer:start(1,func)

func()
end


function xianzhanController:clearKeShangAddTimer()
if self.ksAddTimer then
self.ksAddTimer:cancel()
self.ksAddTimer=nil
end
end


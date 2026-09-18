


UIPrisonControl=gameState.addListener(fullScreenUI.create())

local initData
local skipDropShow={}

function UIPrisonControl:onAppStart()
socketManager:register_receiver(6,14,self.recv_6_14)
socketManager:register_receiver(6,15,self.recv_6_15)
socketManager:register_receiver(6,16,self.recv_6_16)
socketManager:register_receiver(6,17,self.recv_6_17)
socketManager:register_receiver(6,18,self.recv_6_18)
socketManager:register_receiver(6,19,self.recv_6_19)
socketManager:register_receiver(6,20,self.recv_6_20)
socketManager:register_receiver(6,21,self.recv_6_21)
socketManager:register_receiver(6,22,self.recv_6_22)
socketManager:register_receiver(6,23,self.recv_6_23)
socketManager:register_receiver(6,24,self.recv_6_24)
socketManager:register_receiver(6,25,self.recv_6_25)
socketManager:register_receiver(6,26,self.recv_6_26)
socketManager:register_receiver(6,27,self.recv_6_27)
socketManager:register_receiver(6,57,self.recv_6_57)
socketManager:register_receiver(6,58,self.recv_6_58)
socketManager:register_receiver(6,59,self.recv_6_59)
socketManager:register_receiver(6,99,self.recv_6_99)

local args=
{
fullType=FULL_TYPE.eLaoYu,
skinType=fullScreenSkinType.eSkin1,
}
self:initUI(args)
end

function UIPrisonControl:onEnterState(...)
UIPrisonModel:onEnterState(...)




notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIPrisonControl:onLeaveState(...)
UIPrisonModel:onLeaveState(...)
initData=nil
skipDropShow={}
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UIPrisonControl:onProtocolReq()
if initData then
UIPrisonControl.recv_6_25(initData[1],initData[2])
initData=nil
end

self:check_item_changed()
end

function UIPrisonControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIPrisonControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIPrisonControl:onLeaveHome()
end
end

function UIPrisonControl.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.zongmenLevelUp then
UIPrisonControl:refreshHUD()
end
end

function UIPrisonControl.on_money_changed()
UIPrisonControl:refreshHUD()
end

function UIPrisonControl.on_item_list_changed(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
if changeType~=CHANGE_TYPE.eDelete then
if itemsLookup:checkItemFuncType(itemid,item_funtion_type.eMoWuDrop)then
UIPrisonControl:check_item_changed()
return
end
end
end
end

function UIPrisonControl:check_item_changed()
local list=itemsLookup:getItemsByBag(item_funtion_type.eMoWuDrop)
local reqList={}

if list and#list>0 then
for k,v in ipairs(list)do
local itemId=v.id
local count=itemsModel.getCount(itemId)
local temp={itemId,count}
table.insert(reqList,temp)
end

local len=#reqList
if len>0 then
UIPrisonControl:reqUseItem(len,reqList)
end
end
end

function UIPrisonControl:onEnterHome()
timeEventController.addNormalTimerHandler(1,'UIPrisonControl',self)
end

function UIPrisonControl:onLeaveHome()
timeEventController.removeNormalTimerHandler(1,'UIPrisonControl')
end

function UIPrisonControl:onNormalUpdate(delay)
local stime=gameUtilityModel.getServerShortTime()
local cells=UIPrisonModel:getAllPrisonData()
if cells then
for k,v in pairs(cells)do
if v.yyTime>0 and stime>=v.yyTime then
self:reqYueyu(v.lfConfId)
v.yyTime=0
end
if not v.swFinish and v.swEndTime>0 then
if stime>=v.swEndTime then
self:refreshHUD()
v.swFinish=true
end
end
end
end
end

function UIPrisonControl:showPrisonWindow(argstable)

local args=
{

showBg=false,
showFg=false,
viewNames={'UIPrisonWin'},
viewArgs={['UIPrisonWin']=argstable},
}
self:showUI(args)
end

function UIPrisonControl:refreshHUD()
local ldatas=zongmenModel:getBuildingDataByBdType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eLaoYu)
if#ldatas>0 then
hudControl:refreshBuildingStatusHUD(ldatas[1].un_build_id)
end
end



function UIPrisonControl:reqPrisonData()
socketManager:send_6_14()
end

function UIPrisonControl:reqUnlockMoYu()
socketManager:send_6_15()
end

function UIPrisonControl:reqUnlockCell(lfId)
socketManager:send_6_16(lfId)
end

function UIPrisonControl:reqHandInCaptive(lfId,flag)
local tag=flag
if not tag then tag=0 end
socketManager:send_6_17(lfId,tag)
end

function UIPrisonControl:reqInterrogate(lfId,guid)
socketManager:send_6_18(lfId,guid)
end

function UIPrisonControl:reqRecruit(lfId,guid)
socketManager:send_6_19(lfId,guid)
end

function UIPrisonControl:reqFreed(lfId)
socketManager:send_6_20(lfId)
end

function UIPrisonControl:reqSuppress(lfId)
socketManager:send_6_21(lfId)
end

function UIPrisonControl:reqLog()
socketManager:send_6_22()
end

function UIPrisonControl:reqYueyu(lfId)
socketManager:send_6_23(lfId)
end

function UIPrisonControl:reqFinishInterrogate(lfId,flag)
socketManager:send_6_24(lfId,flag)
end

function UIPrisonControl:reqFuluData()
socketManager:send_6_25()
end

function UIPrisonControl:reqUseItem(len,list)
socketManager:send_6_59(len,list)
end



function UIPrisonControl.recv_6_14(len,arr,moyuUnlockFlag,jyCount)
UIPrisonModel:setPrisonData(arr)
UIPrisonModel:setMoYuLockState(moyuUnlockFlag)

local index=UIPrisonModel:getInfoIndex()
if index then
if arr[index]and arr[index].yyTime==0 then
UIManager:invokeUIMethod('UIPrisonWin','hideInfoPanel')
end
end

UIManager:invokeUIMethod('UIPrisonWin','refreshAllCell')

UIPrisonModel:setJyCount(jyCount,true)
end

function UIPrisonControl.recv_6_15(moyuUnlockFlag)
UIPrisonModel:setMoYuLockState(moyuUnlockFlag)
UIManager:invokeUIMethod('UIPrisonWin','refreshMoyuState')
UIManager:invokeUIMethod('UIPrisonWin','setSelectLayer',2)
UIManager:invokeUIMethod('UIPrisonWin','refreshSelectLayer')
UIManager:invokeUIMethod('UIPrisonWin','refreshAllCell')
UIManager:invokeUIMethod('UIPrisonWin','playNewBie')
UIPrisonControl:refreshHUD()

UIManager.info('魔狱已成功解锁')
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eLaoYuMoYuJieSuo)
end

function UIPrisonControl.recv_6_16(lfId)
UIPrisonModel:unlockCell(lfId)
UIManager:invokeUIMethod('UIPrisonWin','refreshAllCell',{lfId=lfId})
UIManager.info('牢房已修复')
if lfId>4 then
taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eLaoYuMoYuRoomNum)
end
end


function UIPrisonControl.recv_6_17(lfId,jyCount,flag,len,list)

UIManager:invokeUIMethod('UIPrisonWin','playJiuYou',lfId)
UIPrisonModel:setJyCount(jyCount,true)

if flag==1 then
UIPrisonModel:setHandInCaptive(lfId)
notifySystem:postNotify(notifyConfig.onJiuYouPrizeChange,len,list)
end
end


function UIPrisonControl.recv_6_18(lfId,guid,time)
UIManager.info('审问开始')
UIPrisonModel:setInterrogate(lfId,guid,time)
UIManager:invokeUIMethod('UIPrisonWin','setSWState',lfId,1)
UIManager:invokeUIMethod('UIPrisonWin','refreshCellById',lfId)
end


function UIPrisonControl.recv_6_19(lfId,guid)
local success=tostring(guid)~='0'
UIPrisonModel:setRecruit(lfId,success)
UIManager:invokeUIMethod('UIPrisonWin','playRecruit',lfId,success,guid)
if success then
if not UIManager:isActive('UIPrisonWin')then
local giftFunc=nil
local word=UIPrisonModel:randomLanguage(3)
local prizeList=systemZongMenModel:getTempRewards()or{}
local outgoer=UIDiscipleModel:getDiscipleData(guid)
giftFunc=function()
local args={
discipledata=outgoer.discipledata,
discipleimage=outgoer.discipleimage,
disciplename=outgoer.disciplename,
talkcontent=word,
callback=function()
showPrizeControl.showWindow(prizeList,function()
self:refreshCellById(lfId)
end)
UIManager:closeWindow("UISystemZongMenDiscipleTalkWin")
end,
}
UIManager:showWindow("UISystemZongMenDiscipleTalkWin",args)
end

local viewArgs={disciple=guid,callback=giftFunc,isFullOpen=false,}
UIPrisonControl:showRecruitDiscipleWindow(viewArgs)
end
end

if UIManager:isActive('UIPrisonWin')then
UIManager:invokeUIMethod('UIPrisonWin','set_isShow',lfId,false)
end



local type=addSpeType.item
local data=UIDiscipleModel:getDiscipleData(guid)
if data and data.discipleInfo then
TeZhiTuJianModel:checkIsHaveSpeCanActive(data.discipleInfo,type,1,guid)
end
end


function UIPrisonControl.recv_6_20(lfId)
UIPrisonModel:setFreed(lfId)
UIManager:invokeUIMethod('UIPrisonWin','playFreed',lfId)
end


function UIPrisonControl.recv_6_21(lfId)
UIPrisonModel:setSuppress(lfId)
UIManager:invokeUIMethod('UIPrisonWin','onZhenYaRet',lfId)
end


function UIPrisonControl.recv_6_22(len,arr)
UIPrisonModel:setLogs(arr)
UIManager:showWindow('UIPrisonLogWin')
end


function UIPrisonControl.recv_6_23(lfId)
UIPrisonControl:playYueyuAnim(lfId)
UIPrisonModel:setYueyu(lfId)
UIManager:invokeUIMethod('UIPrisonWin','refreshCellById',lfId)
end


function UIPrisonControl.recv_6_24(lfId,flag,len,list)
UIPrisonModel:finishInterrogate(lfId)

UIManager:invokeUIMethod('UIPrisonWin','refreshCellById',lfId)
UIPrisonControl:refreshHUD()

notifySystem:postNotify(notifyConfig.onShenWenPrizeChange,len,list)

















end

function UIPrisonControl.recv_6_25(len,arr)
if initProControl.isDone()then
if arr then
for i,v in ipairs(arr)do
UIDiscipleModel:addDiscipleDataTemp(v)
end
end
else
initData={len,arr}
end
end

function UIPrisonControl.recv_6_26(data)
UIDiscipleModel:addDiscipleDataTemp(data)
end

function UIPrisonControl.recv_6_27(len,arr)
if len>0 then
local show={}
for i,v in ipairs(arr)do
local guidStr=tostring(v.discipleguid)
local serial=skipDropShow[guidStr]
if serial==nil then
table.insert(show,v)
else

local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_ArrestDisciple")
local infoData=systemZongMenModel:getInfoData(serial)
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx),v.disciplename)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)

skipDropShow[guidStr]=nil
end
end
if#show>0 then
UIManager:showWindow('UICaptureWin',{list=show})
end
end
UIPrisonControl:reqPrisonData()
end

function UIPrisonControl.recv_6_57(len,data)
local show={}
for i,v in ipairs(data)do
table.insert(show,v)
UIPrisonModel:setOnePrisonData(v)
end

if#show>0 then
UIManager:showWindow('UICaptureWin',{list=show,isMonster=true})
end
UIManager:invokeUIMethod('UIPrisonWin','refreshAllCell')
end

function UIPrisonControl.recv_6_58(flId,jyCount)











UIManager.info('牢狱已满，俘虏已自动上交九渊获得奖励')
UIPrisonModel:setJyCount(jyCount)
end


function UIPrisonControl.recv_6_59(data)

end

function UIPrisonControl.recv_6_99(data,jyCount)










UIManager.info('牢狱已满，俘虏已自动上交九渊获得奖励')
UIPrisonModel:setJyCount(jyCount)
end


function UIPrisonControl:playYueyuAnim(lfId)
local sfId=mapIdType.zhufeng
local datas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.eLaoYu)
local data=datas[1]
if not data then
return
end

local lfdata=UIPrisonModel:getPrisonData(lfId)
if lfId<5 then
local dzId=lfdata.fuluGuid

local pos=_MapManager.GetTilemapObjectPosition(data.entityId)
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId)
local scale=isometricMapSystem:getModelScale(info.body)
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,sfId,0,info.body,info.componets,SortingLayers.ITBuilding,scale,pos)
_MapManager.RunAnimator(guid,eAnimationID.stand)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,0),0,nil)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,1),1,function()
_MapManager.RunAnimator(guid,eAnimationID.run)
local offset=_MapManager.GetObjectHeadOffset(guid)
hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,guid,offset,true,true,function(hudId)
local widget=hudControl:getHUDWidget(hudId)
widget:SetChildText(0,'溜了溜了~')
local targetPos=_MapManager.ToVector3Int(-8,-39,0)
_MapManager.MoveToPosition(guid,targetPos,function()
hudControl:removeHUD(hudId)
_MapManager.RunAnimator(guid,eAnimationID.stand)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,0),1,function()
_MapManager.RemoveTilemapObject(guid)
end)
end,nil,1.5)
end)
end)
end
end

function UIPrisonControl:showRecruitDiscipleWindow(args)
local win=UIManager:findActiveWindow('UIItemRecruitDiscipleWin')
if win then
win:onRoot()
end
UIRecruitControl:showItemRecruitDiscipleWindow(nil,args.disciple,args.callback,args.isFullOpen)
end

function UIPrisonControl:addSkipDropShow(discipleguid,serial)
local str=tostring(discipleguid)
skipDropShow[str]=serial
end
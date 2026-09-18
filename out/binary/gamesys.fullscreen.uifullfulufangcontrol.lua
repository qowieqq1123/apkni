




UIFullFuLuFangControl=gameState.addListener(fullScreenUI.create())

function UIFullFuLuFangControl:onAppStart()



socketManager:register_receiver(2,62,self.recv_2_62)
socketManager:register_receiver(2,63,self.recv_2_63)
socketManager:register_receiver(2,64,self.recv_2_64)






socketManager:register_receiver(3,164,self.recv_3_164)
socketManager:register_receiver(3,165,self.recv_3_165)
socketManager:register_receiver(3,166,self.recv_3_166)
socketManager:register_receiver(3,167,self.recv_3_167)
socketManager:register_receiver(3,168,self.recv_3_168)
socketManager:register_receiver(3,169,self.recv_3_169)
socketManager:register_receiver(3,170,self.recv_3_170)

local function _showProductionWindow(...)self:showProductionWindow(...)end

local function _showFuLuWin(...)self:showFuLuWin(...)end

local function _initSendProductionPro(...)self:initSendProductionPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_fulufang,callback=_showProductionWindow,sendCallback=_initSendProductionPro},

{tabType=FULL_TAB_TYPE.eProduction_fulu,callback=_showFuLuWin,sendCallback=_initSendProductionPro,reddotType=REDDIT_SUB_TYPE.sFuLuReward},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eFuLuFang,
attachName={'entityId'}
}
self:initUI(args)
end





function UIFullFuLuFangControl:onEnterState(isReconnect)

UIFuLuFangModel:onEnterState(isReconnect)
if isReconnect then
return
end
notifySystem:listenNotify(notifyConfig.onShowPrize,UIFullFuLuFangControl.onShowPrize)
notifySystem:listenNotify(notifyConfig.on_item_changed,UIFullFuLuFangControl.on_item_changed)
end

function UIFullFuLuFangControl:onLeaveState(isReconnect)
UIFuLuFangModel:onLeaveState(isReconnect)
if isReconnect then
return
end
notifySystem:removelistener(notifyConfig.onShowPrize,UIFullFuLuFangControl.onShowPrize)
notifySystem:removelistener(notifyConfig.on_item_changed,UIFullFuLuFangControl.on_item_changed)
end

function UIFullFuLuFangControl.on_item_changed(changeType,guid,itemId)
if changeType==CHANGE_TYPE.eAdd then
local itemDict=UIFuLuFangModel:getUnlockItemDict()
local data=itemDict[itemId]
if data then
local count=bagModel.getItemCountById(itemId)
if count>=data.needNum then
UIFullFuLuFangControl:reqUnlockFuLu(data.flType,data.id)
itemDict[itemId]=nil
end
end
end
end

function UIFullFuLuFangControl:checkAndUnlock()
local itemDict=UIFuLuFangModel:getUnlockItemDict()
for k,v in pairs(itemDict)do
if v.flType==1 then
if UIFuLuFangModel:isYuFuUnlock(v.id)then
itemDict[k]=nil
end
local count=bagModel.getItemCountById(k)
if count>=v.needNum then
UIFullFuLuFangControl:reqUnlockFuLu(v.flType,v.id)
itemDict[k]=nil
end
elseif v.flType==2 then
if UIFuLuFangModel:isFuLuUnlock(v.id)then
itemDict[k]=nil
end
local count=bagModel.getItemCountById(k)
if count>=v.needNum then
UIFullFuLuFangControl:reqUnlockFuLu(v.flType,v.id)
itemDict[k]=nil
end
end
end
end

function UIFullFuLuFangControl:setArgs(args)
if args then
self.args=args
return args
else
return self.args
end
end

function UIFullFuLuFangControl:openFuLuSystemWin(argstable)
local tabType=FULL_TAB_TYPE.eProduction_fulufang
if argstable.args~=nil and argstable.args.tabType~=nil then
tabType=argstable.args.tabType
end
if tabType==FULL_TAB_TYPE.eProduction_fulu then
if not systemModel.isOpen(SYSTEM_DEFINE.eFuLuHuiZhi)then
tabType=FULL_TAB_TYPE.eProduction_fulufang
end
end
if tabType==FULL_TAB_TYPE.eProduction_fulufang then
self:showProductionWindow(argstable.data)
elseif tabType==FULL_TAB_TYPE.eProduction_fulu then
argstable.entityId=argstable.data.entityId
self:showFuLuWin(argstable)
end
end

function UIFullFuLuFangControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_fulufang
local winArgs=self:setArgs(argstable)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=winArgs},
}
self:showUI(args)
return true
end

function UIFullFuLuFangControl:showFuBaoWin(argstable)
local tabType=FULL_TAB_TYPE.eProduction_fubao
local winArgs=self:setArgs(argstable)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIFuBaoWin'},
viewArgs={['UIFuBaoWin']=winArgs},
}
self:showUI(args)
end

function UIFullFuLuFangControl:showFuLuWin(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eFuLuHuiZhi)then
UIManager.error('符箓系统未开启')
return false
end
local tabType=FULL_TAB_TYPE.eProduction_fulu
local winArgs=self:setArgs(argstable)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIFuLuMixWin'},
viewArgs={['UIFuLuMixWin']=winArgs},
}
self:showUI(args)
return true
end

function UIFullFuLuFangControl:initSendProductionPro()

end

function UIFullFuLuFangControl:initSendFabaoPro()

end

function UIFullFuLuFangControl:showFuBaoFJWin(argstable)
local tabType=FULL_TAB_TYPE.eProduction_fulu
local winArgs=self:setArgs(argstable)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIFuLuMixWin','UIFuLuFJWin'},
viewArgs={['UIFuLuMixWin']=winArgs},
}
self:showUI(args)
return true
end




function UIFullFuLuFangControl:reqLockFuBao(itemguid,discipleguid)

end

function UIFullFuLuFangControl:reqEquipFuBao(dzId,guid,pos)
socketManager:send_2_62(dzId,guid,pos)
end

function UIFullFuLuFangControl:reqUnEquipFuBao(dzId,pos)
socketManager:send_2_63(dzId,pos)
end

function UIFullFuLuFangControl:reqDecomposeFuBao(len,arr)
socketManager:send_2_64(len,arr)
end













function UIFullFuLuFangControl:reqUnlockFuLu(ftype,id)
socketManager:send_3_166(ftype,id)
end

function UIFullFuLuFangControl:reqMakeYuFu(sfId,ubdId,yfId,spItemId,count)
socketManager:send_3_167(sfId,ubdId,yfId,spItemId,count)
end

function UIFullFuLuFangControl:reqMakeFuLu(sfId,ubdId,flId,level,count)
socketManager:send_3_168(sfId,ubdId,flId,level,count)
end

function UIFullFuLuFangControl:reqReceiveFLLevelReward(id,level)
socketManager:send_3_169(id,level)
end

function UIFullFuLuFangControl:reqReceiveYuFu(sfId,ubdId,count)
socketManager:send_3_170(sfId,ubdId,count)
end



function UIFullFuLuFangControl.recv_2_61(itemguid,discipleguid)
local item=UIFuLuFangModel:getItem(itemguid)
local flag=item.itemData.lock_flag
item.itemData.lock_flag=flag==0 and 1 or 0
local newFlag=item.itemData.lock_flag
tipsManager.freshTips()
local isUnlock=newFlag==0
if isUnlock then
UIManager.info('解锁成功')
else
UIManager.info('已锁定，分解时不会自动选中')
end
notifySystem:postNotify(notifyConfig.on_fubao_lock_changed,itemguid,discipleguid,isUnlock)
end

function UIFullFuLuFangControl.recv_2_62(dzId,guid,pos)


local item=fubaoBagModel:getItem(guid)


UIFuLuFangModel:changeFuBaoData(dzId,pos,item)

local lingzhenData=UIYuFuLingZhenControl:getLingZhenData(guid)
if lingzhenData and lingzhenData.kongList then
UIYuFuLingZhenControl:calcLingZhenEquipedByKongList(lingzhenData.kongList,true)
notifySystem:postNotify(notifyConfig.onLingZhenEquip)
end

equipsModel.setAllEquipedAttrsDirty(dzId)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzId,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(dzId,false)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(dzId,false)


equipsControl.freshWindow('onChangeFubao',pos)
UIManager.info('装备成功')

AudioManager.playAudio(632)
end

function UIFullFuLuFangControl.recv_2_63(dzId,pos)


local itemdata=UIFuLuFangModel:getFubaoData(dzId,pos)
if itemdata and itemdata.itemData and itemdata.itemData.lzItem then
if itemdata.itemData.lzItem.len>0 then
for ii,v in ipairs(itemdata.itemData.lzItem.kongList)do
if v.itemId>0 then
UIYuFuLingZhenControl:calcLingZhenEquipedNum(-1)
local lv=UIYuFuLingZhenControl:getItemLevel(v.itemId)
UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(lv,-1)
end
end
end
notifySystem:postNotify(notifyConfig.onLingZhenEquip)
end



UIFuLuFangModel:changeFuBaoData(dzId,pos)

equipsModel.setAllEquipedAttrsDirty(dzId)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzId,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,false)
UIDiscipleModel:setSkillLvPlusLookupDirty(dzId,false)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(dzId,false)

equipsControl.freshWindow('onChangeFubao',pos)
end

function UIFullFuLuFangControl.recv_2_64(len,arr)
UIManager:invokeUIMethod('UIFuLuFJWin','flyIcon')
UIManager:invokeUIMethod('UIFuLuFJWin','refreshArgRecv')
end

































































function UIFullFuLuFangControl.recv_3_164(sfId,ubdId,isStop,stopTime)
local data=UIFuLuFangModel:getProduceData(ubdId)
data.stop_time=stopTime or 0
data.is_stop=isStop
if data.is_stop==0 then
data.begin_time=0
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.zhiFuBreak,sfId,ubdId)
else
data.begin_time=gameUtilityModel.getServerShortTime()
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.zhiFuStart,sfId,ubdId)
end
hudControl:refreshBuildingStatusHUD(ubdId)
UIManager:callWindowFunc('UIFuLuMixWin','refreshMainPanel')
end

function UIFullFuLuFangControl.recv_3_165(datas)
UIFuLuFangModel:setDatas(datas)
UIFullFuLuFangControl:checkAndUnlock()
end

function UIFullFuLuFangControl.recv_3_166(ftype,id)
UIFuLuFangModel:unlockFuLu(ftype,id)
UIFullFuLuFangControl:refreshAllFuluBuildHud()
end

function UIFullFuLuFangControl.recv_3_167(datas)
local sfId=datas[1]
local ubdId=datas[2]
local data={}
data.sf_id=sfId
data.un_build_id=ubdId
data.begin_time=datas[6]
data.rec_cnt=0
data.all_cnt=datas[5]
data.yufu_id=datas[3]
data.item_id=datas[4]
data.stop_time=0
data.is_stop=1
UIFuLuFangModel:setProduceData(ubdId,data)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.zhiFuStart,sfId,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)

UIManager:callWindowFunc('UIFuLuMixWin','refreshMainPanel')
end

function UIFullFuLuFangControl.recv_3_168(sfId,ubdId,flId,level,count)
UIFuLuFangModel:setFuLuLevel(flId,level)

UIManager:callWindowFunc('UIFuLuMixWin','refreshMainPanel')
UIManager:invokeUIMethod('UIFuLuMixWin','refreshHandBookRoddot')

reddotControl.on_change_catch_type(CATCH_TYPE.eFuluReward)
UIFullFuLuFangControl:refreshAllFuluBuildHud()

local rewards=UIFuLuFangModel:getRecordReward()
if count==1 then
UIManager:showWindow('UIFuLuShowPrizeWin',{level,flId,rewards,ubdId})
else
showPrizeControl.showWindow(rewards)
end
end

function UIFullFuLuFangControl.recv_3_169(id,level,flag)
UIFuLuFangModel:updateFuLuData(id,level,flag)

UIManager:invokeUIMethod('UIFuLuMixWin','refreshHandBookRoddot')
UIManager:invokeUIMethod('UIFuBaoHBWin','refreshFuBaoList')
UIManager:invokeUIMethod('UIFuBaoPingJiRewardWin','refreshRewardsList')
reddotControl.on_change_catch_type(CATCH_TYPE.eFuluReward)

UIFullFuLuFangControl:refreshAllFuluBuildHud()
end

function UIFullFuLuFangControl.recv_3_170(sfId,ubdId,count)
local data=UIFuLuFangModel:getProduceData(ubdId)
data.rec_cnt=count+data.rec_cnt
local isComplete=data.rec_cnt>=data.all_cnt
if isComplete then

UIFuLuFangModel:setProduceData(ubdId)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.zhiFuComplete,sfId,ubdId)
end
hudControl:refreshBuildingStatusHUD(ubdId)

UIManager:callWindowFunc('UIFuLuMixWin','refreshMainPanel')
end



function UIFullFuLuFangControl:receiveYuFu(ubdId)
local pdata=UIFuLuFangModel:getProduceData(ubdId)
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,ubdId)
local count=cddata.currStep-pdata.rec_cnt
UIFullFuLuFangControl:reqReceiveYuFu(mapIdType.zhufeng,ubdId,count)
end


function UIFullFuLuFangControl.reqOneKeyPrizeYuFu()
local args=UIFuLuFangModel:getOneKeyPrizeData()
if args==nil then return end
local len=#args
if len<=0 then return end
socketManager:send_3_100(len,args)
end

function UIFullFuLuFangControl.onShowPrize(prizeType,prizelist)
if prizeType==ePrizeType.eFuLu then
local item=prizelist[1]
if item then
if itemsConfig.isFubao(item.itemid)then
showPrizeControl.showWindow(prizelist)
else
UIFuLuFangModel:recordReward(prizelist)
end
end
end
end

function UIFullFuLuFangControl:refreshAllFuluBuildHud()
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eFuLuFang)
if#datas>0 then
for i,v in ipairs(datas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end

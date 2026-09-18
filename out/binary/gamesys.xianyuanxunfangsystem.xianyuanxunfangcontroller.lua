












xianyuanxunfangController=gameState.addListener({})

function xianyuanxunfangController:onAppStart()
socketManager:register_receiver(41,1,xianyuanxunfangController.recv_41_1)
socketManager:register_receiver(41,2,xianyuanxunfangController.recv_41_2)
socketManager:register_receiver(41,3,xianyuanxunfangController.recv_41_3)
socketManager:register_receiver(41,5,xianyuanxunfangController.recv_41_5)
socketManager:register_receiver(41,6,xianyuanxunfangController.recv_41_6)
end

function xianyuanxunfangController:onEnterState(isReconnet)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function xianyuanxunfangController:onLeaveState(isReconnet)
notifySystem:removelistener(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
if xianyuanxunfangModel:checkInit()and xianyuanxunfangModel:hasLockDZ()then
notifySystem:removelistener(notifyConfig.onNewDay,xianyuanxunfangController.onNewDay)
end
xianyuanxunfangModel:clearData()
xianyuanxunfangController:refreshEnter(false)
end

function xianyuanxunfangController:onProtocolReq(isReconnet)
if xianyuanxunfangModel:checkInit()then
xianyuanxunfangController:refreshEnter(true)
end
end

function xianyuanxunfangController.onNewDay()
local changed=xianyuanxunfangModel:refreshDZLookup()
if changed==true then

end
if not xianyuanxunfangModel:hasLockDZ()then
notifySystem:removelistener(notifyConfig.onNewDay,xianyuanxunfangController.onNewDay)
end
end

function xianyuanxunfangController.onNewWeek5am()
xianyuanxunfangModel:setFree(0)
end

function xianyuanxunfangController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eLottery then
if not xianyuanxunfangController:hasEnter()then
xianyuanxunfangController:refreshEnter(true)
end
end
end

function xianyuanxunfangController:refreshEnter(flag)
if flag then
if systemModel.isOpen(SYSTEM_DEFINE.eLottery)and xianyuanxunfangController:checkClientSystemOpen()then
if self.enterguid==nil then
local guid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eXianYuanXunFang,
getReddotFun=function()
return xianyuanxunfangController:checkReddot()
end})
self.enterguid=guid





end
end
else
if self.enterguid~=nil then
enterManager:removeEnter(self.enterguid)
self.enterguid=nil
end
end
end

function xianyuanxunfangController:hasEnter()
return self.enterguid~=nil
end

function xianyuanxunfangController:checkReddot()
if xianyuanxunfangModel:checkInit()and xianyuanxunfangModel:checkChouKaWithAct()then
return xianyuanxunfangModel:checkFreeReddot()or xianyuanxunfangModel:checkAnyDZNew()
end
return false
end

function xianyuanxunfangController:jumpWin(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eLottery)then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eLottery)
UIManager.error(tips)
return false
end
if not xianyuanxunfangController:checkClientSystemOpen()then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eLottery)
UIManager.error(tips)
return false
end
UIFullCommonControl:showCommonWindow('UIXianYuanXunFangWin',{isFull=true},true,1,false,fullScreenSkinType.eSkin5,true)
return true
end

function xianyuanxunfangController:jumpWin2(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eLottery)then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eLottery)
UIManager.error(tips)
return false
end
if not xianyuanxunfangController:checkClientSystemOpen()then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eLottery)
UIManager.error(tips)
return false
end
if not xianyuanxunfangModel:checkInit()then
UIManager.error('数据异常')
return false
end
UIFullCommonControl:showCommonWindow('UIXianYuanXunFang2Win',{isFull=true},true,1,false,fullScreenSkinType.eSkin5,true)
return true
end




function xianyuanxunfangController:reqSelectUp(idx)

socketManager:send_41_2(idx)
end


function xianyuanxunfangController:reqChouKa(lottery_type)

socketManager:send_41_3(lottery_type)
end


function xianyuanxunfangController:reqSelectDZ(selectList)

socketManager:send_41_5(#selectList,selectList)
end


function xianyuanxunfangController:reqSelectEquip(equip_idx)

socketManager:send_41_6(equip_idx)
end






function xianyuanxunfangController.recv_41_1(args)









local isInit=xianyuanxunfangModel:checkInit()
local data={}
data.itemid=args[1]
data.round=args[2]
data.times=args[3]
data.total=args[4]
data.free=args[5]
data.len=args[6]
data.items=args[7]or{}
data.equip_idx=args[8]
xianyuanxunfangModel:initData(data)
xianyuanxunfangModel:initDZLookup()
if not isInit and xianyuanxunfangModel:hasLockDZ()then
notifySystem:listenNotify(notifyConfig.onNewDay,xianyuanxunfangController.onNewDay)
end
if not xianyuanxunfangController:hasEnter()then
xianyuanxunfangController:refreshEnter(true)
end
end


function xianyuanxunfangController.recv_41_2(idx)


local data=xianyuanxunfangModel:getData()
if data==nil then return end

data.itemid=idx
UIManager:invokeUIMethod('UIXianYuanXunFangWin','rec_selectUp')
UIManager:invokeUIMethod('UIXianYuanXunFangInfoWin','rec_selectUp')
UIManager:invokeUIMethod('UIXianYuanXunFangSelectWin','rec_selectUp')
end


function xianyuanxunfangController.recv_41_3(round,times,total,free)





local data=xianyuanxunfangModel:getData()
if data==nil then return end

data.round=round
data.times=times
data.total=total
data.free=free
UIManager:invokeUIMethod('UIXianYuanXunFangWin','rec_chouka')
UIManager:invokeUIMethod('UIXianYuanXunFang2Win','rec_chouka')
UIManager:invokeUIMethod('UIXianYuanXunFangRewardWin','rec_chouka')
end


function xianyuanxunfangController.recv_41_5(len,selectList)



local data=xianyuanxunfangModel:getData()
if data==nil then return end

data.len=len
data.items=selectList or{}

data.itemid=1
xianyuanxunfangModel:handData()
UIManager:invokeUIMethod('UIXianYuanXunFangWin','rec_selectDZ')
UIManager:invokeUIMethod('UIXianYuanXunFang2Win','rec_selectDZ')
UIManager:invokeUIMethod('UIXianYuanXunFangInfoWin','rec_selectDZ')
UIManager:invokeUIMethod('UIXianYuanXunFangSelectWin','rec_selectDZ')
UIManager:invokeUIMethod('UIXianYuanXunFangSelect2Win','rec_selectDZ')
end


function xianyuanxunfangController.recv_41_6(equip_idx)


local data=xianyuanxunfangModel:getData()
if data==nil then return end

data.equip_idx=equip_idx
UIManager:invokeUIMethod('UIXianYuanXunFang2Win','rec_selectEquip')
UIManager.info("选择装备成功")
end



function xianyuanxunfangController:convertLoveEquip(configs)
local list={}
local temp={}
for i,v in ipairs(configs)do
local pieceId=v[1]
local openDay=v[3]
temp[pieceId]={index=i,openDay=openDay}
end
local mergeCfg=cfg_lianqigeconfig()
local openServer=timeHelper.getServerOpenZeroShortStamp()
for i,v in pairs(mergeCfg)do
local info=temp[v.itemid]
if info then
local itemId=v.cost[1][1]
list[info.index]={itemId,info.openDay}
end
end







return list
end


function xianyuanxunfangController:checkClientSystemOpen()
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eLottery)
if isCan then
return true
else
return false
end
end

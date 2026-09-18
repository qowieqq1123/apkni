






local _MODULENAME="xianzhanModel"




def_table(_MODULENAME)
xianzhanModel.name=_MODULENAME


xianzhanModel.data={}
xianzhanModel.showItemid=17003


XIANZHAN_ENTRUST_TYPE=
{
eHandItem=1,
eFightMonster=2,
eLittleGame=3,
}


local _lookwtconfig


function xianzhanModel:onAppStart()

end


function xianzhanModel:onEnterState()
self.data.roomsData={}
self.data.zxTypeIdList={}
self.data.shopDatas={}
xianzhanModel:dealRooms()
xianzhanModel:initRoomUnlockItemLookup()
_lookwtconfig={}
xianzhanModel:initQuickLookWTConfigByTaskid()
end


function xianzhanModel:onLeaveState()

self.data={}
self.shopRefreshTime=nil
_lookwtconfig={}
self.roomUnlockItemLookup=nil
end


function xianzhanModel:onServerDataInitFinish()

end





function xianzhanModel:dealRooms()
local areas={}
self.data.roomAreaData=areas
local configs=cfg_xianzhanroomconfig()
for i,v in ipairs(configs)do
areas[v.areaID]=v.id
end
end

function xianzhanModel:initRoomUnlockItemLookup()
local lp={}
self.roomUnlockItemLookup=lp
local configs=cfg_xianzhanzhuangxiuconfig()
for k,config in pairs(configs)do
local zxTypeId=config.id
if config.unlock then
for i2,v2 in ipairs(config.unlock)do
local itemid=v2[1]
if lp[itemid]==nil then lp[itemid]={}end
table.insert(lp[itemid],zxTypeId)
end
end
end
end

function xianzhanModel:checkRoomUnlockItem(itemId)
return self.roomUnlockItemLookup[itemId]
end

function xianzhanModel:getRoomsList()
local list={}
local configs=cfg_xianzhanzhuangxiuconfig()
for k,config in pairs(configs)do
local t=list[config.dangciType]
if t==nil then
t={}
list[config.dangciType]=t
end
local roomType=config.id
local isunlock=xianzhanModel:isZXUnLock(roomType)
local weight=isunlock and 10000 or 0
weight=weight+(1000-roomType)
table.insert(t,{cfg=config,weight=weight})
end
for k,d in pairs(list)do
table.sort(d,function(a,b)
return a.weight>b.weight
end)
end
return list
end


function xianzhanModel:init_data(roomListLen,roomList,isInit)
if roomListLen>0 then
local refreshHud=isInit
for i,room in ipairs(roomList)do
local roomId=room.roomId
self.data.roomsData[roomId]=room






npcModel:customer2NPC(room)
end
if refreshHud then
xianzhanController:refreshXianZhanBuildHud()
end
end
end

function xianzhanModel:getShopRefreshTime()
local curTime=gameUtilityModel.getServerLongTime()
if self.shopRefreshTime==nil or curTime>self.shopRefreshTime then

local y_,m_,d_=timeHelper.getDateNumber(curTime)
local r_time=timeHelper.timeServer(y_,m_,d_,5,0,0)
local w=timeHelper.getWeakDateEx2(curTime)
if w>0 then
if curTime>r_time then
r_time=r_time+(7-w+1)*86400
end
else
r_time=r_time+86400
end
self.shopRefreshTime=r_time
end
return self.shopRefreshTime
end

function xianzhanModel:checkRoomRefresh(oldroom,newroom)
local isNew=false
if oldroom~=nil and newroom~=nil and oldroom.roomId==newroom.roomId then
local roomId=newroom.roomId
if newroom.customerId>0 and oldroom.customerId~=newroom.customerId then
isNew=true
xianzhanModel:setRefreshRoomFlag(newroom,true)
elseif newroom.customerId<=0 and oldroom.customerId>0 then
isNew=true
xianzhanModel:setRefreshRoomFlag(newroom,nil)
elseif newroom.customerId~=oldroom.customerId and oldroom.leaveTime~=newroom.leaveTime then
isNew=true
xianzhanModel:setRefreshRoomFlag(newroom,true)
end
end
return isNew
end


function xianzhanModel:hasYingBinRoom()
local roomsData=xianzhanModel:getRoomsData()
for k,data in pairs(roomsData)do
if xianzhanModel:checkRoomNeedYB(data)then
return true
end
end
return false
end

function xianzhanModel:getYingBinRoomIDs()
local list={}
local roomsData=xianzhanModel:getRoomsData()
for k,data in pairs(roomsData)do
if xianzhanModel:checkRoomNeedYB(data)then
table.insert(list,data.roomId)
end
end
return list
end

function xianzhanModel:getRoomCount()
local cnt=0
local bdData=xianzhanController:getXianZhanBuild()
if bdData then
local roomsData=xianzhanModel:getRoomsData()
if roomsData then
for k,data in pairs(roomsData)do

if data.unlockStatus==1 then
cnt=cnt+1
end
end
end
end
return cnt
end

function xianzhanModel:checkRoomNeedYB(data)
return data.customerId>0 and data.ybFlag==0
end


function xianzhanModel:hasTaskRoom()
local roomsData=xianzhanModel:getRoomsData()
for k,data in pairs(roomsData)do
if data.customerId>0 and data.wtTaskId>0 and data.wtTaskStaus==0 then
if not xianzhanModel:checkRoomNeedYB(data)then
return true,data.roomId
end
end
end
return false
end

function xianzhanModel:isFirstIn()
return not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.FirstTimeXianZhanLuaFunc)
end



function xianzhanModel:init_zxData(listLen,zxTypeIdList)
if listLen>0 then
for i,v in ipairs(zxTypeIdList)do
self.data.zxTypeIdList[v]=true
end
end
end

function xianzhanModel:unlockZX(zxTypeId)
self.data.zxTypeIdList[zxTypeId]=true
end

function xianzhanModel:isZXUnLock(zxTypeId)
if self.data.zxTypeIdList[zxTypeId]==true then
return true
else
local unlock=cfgHelper.get2(cfg_xianzhanzhuangxiuconfig_get,zxTypeId,'unlock')
if unlock==nil then
return true
end
end
return false
end

function xianzhanModel:checkUnLockCond(zxTypeId)
local unlock=cfgHelper.get2(cfg_xianzhanzhuangxiuconfig_get,zxTypeId,'unlock')
if unlock then
for i,cost in ipairs(unlock)do
local itemid=cost[1]
local count=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<count then
return false,itemid,count
end
end
end
return true,nil
end

function xianzhanModel:autoUnlockZX()
local configs=cfg_xianzhanzhuangxiuconfig()
for k,config in pairs(configs)do
local zxTypeId=config.id
if not xianzhanModel:isZXUnLock(zxTypeId)then
if xianzhanModel:checkUnLockCond(zxTypeId)then
xianzhanController:req_unlock_zx(zxTypeId)
end
end
end
end

function xianzhanModel:autoUnlockZXEx(itemId)
local zxlist=xianzhanModel:checkRoomUnlockItem(itemId)
if zxlist~=nil then
for i,zxTypeId in ipairs(zxlist)do
if not xianzhanModel:isZXUnLock(zxTypeId)then
if xianzhanModel:checkUnLockCond(zxTypeId)then
xianzhanController:req_unlock_zx(zxTypeId)
end
end
end
end
end




function xianzhanModel:getRoomsData()
return self.data.roomsData
end

function xianzhanModel:getCustomerHanGanDu(npcid)
local customerId=npcid
if self.data and self.data.roomsData then
for roomId,data in pairs(self.data.roomsData)do
if data.customerId==customerId then
return data.haoGanDu
end
end
end
end

function xianzhanModel:getNPCInRoom(npcid)
local customerId=npcid
if self.data and self.data.roomsData then
for roomId,roomData in pairs(self.data.roomsData)do
if roomData.customerId==customerId then
return roomId
end
end
end
return nil
end

function xianzhanModel:getRoomDataByRoomId(roomId)
return self.data.roomsData[roomId]
end


function xianzhanModel:roomCustomerGoods2NPC(roomId)
if self.data and self.data.roomsData then
local roomData=self.data.roomsData[roomId]
if roomData then
if roomData.exchList then
local bagList={}
for i,v in ipairs(roomData.exchList)do
local good={}
good.itemguid=int64.new('0')
good.itemid=v.itemId
good.itemcount=v.itemNum
table.insert(bagList,good)
end
return bagList
end
end
end
return nil
end


function xianzhanModel:update_room_data(roomData)
local roomId=roomData.roomId
local oldroom=self.data.roomsData[roomId]
self.data.roomsData[roomId]=roomData




end


function xianzhanModel:update_room_type(roomId,roomType)
local data=self:getRoomDataByRoomId(roomId)
data.zhuangxiuTypeId=roomType
self.data.roomsData[roomId]=data
end


function xianzhanModel:update_room_talk(roomId,hgdVal,dayTalkNum)
local data=self:getRoomDataByRoomId(roomId)
data.haoGanDu=hgdVal
data.dayTalkNum=dayTalkNum
self.data.roomsData[roomId]=data
end


function xianzhanModel:getRoomUpdateList()
local serTime=timeHelper.getServerShortTime()
local datas=self:getRoomsData()
local updateList={}
for k,v in pairs(datas)do

if v.unlockStatus==1 then
if v.customerId>0 then
local leaveTime=v.leaveTime
if leaveTime>0 and serTime>=leaveTime and v.ybFlag==1 then

table.insert(updateList,v.roomId)
end
else
local ruzhuTime=v.ruzhuTime
if ruzhuTime>0 and serTime>=ruzhuTime then

if v.lockUpdata==nil then
table.insert(updateList,v.roomId)
end
end
end
end
end
return updateList
end


function xianzhanModel:setTuiFangReward(haveFlag)
self.data.tuifangReward=haveFlag
end

function xianzhanModel:checkTuiFangReward()
return self.data.tuifangReward==1
end


function xianzhanModel:checkWorldBlockNeedUnlock(taskConfig,config,useWarning)
local world
local block
local tasktype=taskConfig.tasktype
if tasktype==102 or tasktype==17 then

local worldblock=config.mjworldblock
if worldblock then
world=worldblock[1]
block=worldblock[2]
else
logErr(FMT.fmt('未配置秘境生成世界区块字段，任务id：{0}，委托或者秘闻id：{1}',taskConfig.id,config.id))
end
elseif tasktype==103 then

local params=taskConfig.params
world=params[1]
block=params[2]
end
if world and block then
local open=worldBlockModel:checkBlockState(world,block,worldBlockModel.BLOCKSTATE.OPEN)
if not open then
local worldName=cfgHelper.get2(cfg_worldconfig_get,world,'name')
local qukuaiName=cfgHelper.get3(cfg_worldblockconfig_get,world,block,'name')
local limitStr=FMT.fmt('需要解锁{0}的{1}',worldName,qukuaiName)
if useWarning then
UIManager.error(limitStr)
end
return true,limitStr
end
end
return false
end


function xianzhanModel:getShopGoodsList()
local datas={}
local config=cfg_xianzhanshopconfig()
local zmlv=zongmenModel:getLevel()
for k,cfg in pairs(config)do
if funcShopModel:check_item_unlock_xianzhan(cfg.hide)then
local t=datas[cfg.pageTab]
if t==nil then
t={}
datas[cfg.pageTab]=t
end
local sellout=xianzhanModel:checkGoodSellOut(cfg.id)
local sortWeight=sellout and 0 or 10000
sortWeight=sortWeight+(1000-cfg.sortid)
local isUnlock=true
if cfg.zmLevel then
isUnlock=zmlv>=cfg.zmLevel
end
if not isUnlock then
sortWeight=sortWeight-10000
end
table.insert(t,{cfg,sortWeight,isUnlock})
end
end
for k,v in pairs(datas)do
table.sort(v,function(a,b)return a[2]>b[2]end)
end
return datas
end


function xianzhanModel:init_shopdata(itemListLen,itemList)
self.data.shopDatas={}
if itemListLen>0 then
for i,v in ipairs(itemList)do
self.data.shopDatas[v.itemId]=v
end
end
end

function xianzhanModel:update_shopdata(shopItem)
local itemId=shopItem.itemId
self.data.shopDatas[itemId]=shopItem
end

function xianzhanModel:getShopDataByItemid(itemId)
return self.data.shopDatas[itemId]
end

function xianzhanModel:checkGoodSellOut(itemId)
local data=self:getShopDataByItemid(itemId)
if data then
local config=cfgHelper.get1(cfg_xianzhanshopconfig_get,itemId)
local totalNum=data.buyTotal
local totalMax=config.zsLimit
local weekNum=data.zhouBuyNum
local weekMax=config.zhouLimit
if weekMax then
if weekNum>=weekMax then
return true
end
elseif totalMax then
if totalNum>=totalMax then
return true
end
else
return false
end
end
return false
end

function xianzhanModel:checkGoodSellNumMax(itemId)
local config=cfgHelper.get1(cfg_xianzhanshopconfig_get,itemId)
local totalMax=config.zsLimit
local weekMax=config.zhouLimit
local totalNum
local weekNum
local data=self:getShopDataByItemid(itemId)
if data then
totalNum=data.buyTotal
weekNum=data.zhouBuyNum
else
totalNum=0
weekNum=0
end
if weekMax then
if weekNum>=weekMax then
return 0
else
return weekMax-weekNum
end
elseif totalMax then
if totalNum>=totalMax then
return 0
else
return totalMax-totalNum
end
else
return 99
end
end




function xianzhanModel:setRebuildRoomType(roomType)
local old=self.data.rebuildRoomType
self.data.rebuildRoomType=roomType
if xianzhanModel:isBuildingModel()then
xianzhanController:refreshAllRoomSelect()
notifySystem:postNotify(notifyConfig.onXianZhanBuildRoomChange,old,roomType)
end
end

function xianzhanModel:getRebbuildRoomType()
return self.data.rebuildRoomType
end

function xianzhanModel:setBuildingModel(flag)
self.data.buildingModel=flag
xianzhanController:refreshAllRoomSelect()
notifySystem:postNotify(notifyConfig.onXianZhanBuildModelChange,flag)
end

function xianzhanModel:isBuildingModel()
return self.data.buildingModel==true
end

function xianzhanModel:setRebuilding(roomId,flag)
if self.data.rebuilding==nil then
self.data.rebuilding={}
end
self.data.rebuilding[roomId]=flag
end

function xianzhanModel:clearRebuilding()
self.data.rebuilding=nil
end

function xianzhanModel:getRoomRebuilding(roomId)
if self.data.rebuilding then
return self.data.rebuilding[roomId]==true
end
return false
end

function xianzhanModel:getRebuilding()
if self.data.rebuilding then
for k,v in pairs(self.data.rebuilding)do
if v==true then
return true
end
end
end
return false
end

function xianzhanModel:setRefreshRoomFlag(room,flag)
if room==nil then return end
local roomId=room.roomId
local n=flag==true and 1 or 0
local key='refreshXZRoomFlagMark'
local flagMark=userActorSetting.get(key,0)
if n==1 then
flagMark=mathHelper.setbit(flagMark,roomId-1)
else
flagMark=mathHelper.clrbit(flagMark,roomId-1)
end
userActorSetting.set(key,flagMark)

local roomIdStr=tostring(roomId)
local key2='XZRoomDataMark'
local markRoomList=userActorSetting.get(key2,{})
local markRoom=xianzhanModel:getRoomDataMark(roomId)
local change=false
if markRoom.customerId~=room.customerId then
change=true
markRoom.customerId=room.customerId or 0
end
if markRoom.leaveTime~=room.leaveTime then
change=true
markRoom.leaveTime=room.leaveTime or 0
end
if change then
markRoomList[roomIdStr]=markRoom
userActorSetting.set(key2,markRoomList)
end

userActorSetting.flush()
end

function xianzhanModel:getRefreshRoomFlag(roomId)
local key='refreshXZRoomFlagMark'
local flagMark=userActorSetting.get(key,0)
local flag=mathHelper.getBitValue(flagMark,roomId-1)
return flag
end

function xianzhanModel:getRoomDataMark(roomId)
local roomIdStr=tostring(roomId)
local key2='XZRoomDataMark'
local markRoomList=userActorSetting.get(key2,{})
local markRoom=markRoomList[roomIdStr]or{}
markRoom.roomId=markRoom.roomId or roomId
markRoom.customerId=markRoom.customerId or 0
markRoom.leaveTime=markRoom.leaveTime or 0
return markRoom
end

function xianzhanModel:checkXianZhanReddot()
if xianzhanModel:checkTuiFangReward()then
return true,1
end
local roomsDataList=xianzhanModel:getRoomsData()
for roomId,roomData in pairs(roomsDataList)do
if xianzhanModel:checkRoomNeedYB(roomData)then
return true,2
end




end
for roomId,roomData in pairs(roomsDataList)do
if roomData.customerId>0 then
local npcid=roomData.customerId
if npcModel:checkIntimacyReward(npcid)~=nil then
return true,3
end
end
end

local isHasNewKeShang=xianzhanModel:checkHasNewKeShang()
if isHasNewKeShang then
return true,4
end
return false,nil
end

function xianzhanModel:getNPCRoom(npcid)
local customerId=npcid
local roomsDataList=xianzhanModel:getRoomsData()
for roomId,roomData in pairs(roomsDataList)do
if roomData.customerId==npcid then
return roomData.roomId
end
end
end

function xianzhanModel:getFreshXianZhanHudFlag()
local flag=self.refreshHudFlag
self.refreshHudFlag=nil
return flag
end

function xianzhanModel:recordEnterCameraSize(size)
self.enterCameraSize=size
end

function xianzhanModel:getRecordEnterCameraSize()
return self.enterCameraSize
end

function xianzhanModel:setBeforeKickOutData(data)
self.beforeKickOutData=data
end

function xianzhanModel:getBeforeKickOutData()
return self.beforeKickOutData
end

function xianzhanModel:initQuickLookWTConfigByTaskid()
local config=cfg_xianzhanweituoconfig()
for k,v in pairs(config)do
if v.taskId then
_lookwtconfig[v.taskId]=v
end
end
end

function xianzhanModel:getWTConfigByTaskid(taskid)
return _lookwtconfig[taskid]
end

function xianzhanModel:isXianZhanTask(taskid)
return xianzhanModel:getWTConfigByTaskid(taskid)~=nil
end

function xianzhanModel:getWTRewardByRoomID(roomId)
local roomsData=xianzhanModel:getRoomDataByRoomId(roomId)
local entrustId=roomsData.wtTaskId
local cfg=cfgHelper.get1(cfg_xianzhanweituoconfig_get,entrustId)
local rewards
if cfg.taskId then
local taskcfg=taskModel:getTaskConfig(cfg.taskId)
rewards=taskcfg.taskReward
else
local cfg_reward=cfg.reward or{}
rewards=cfg_reward
end

return rewards or{}
end

function xianzhanModel:getRoomIDByArea(areaID)
return self.data.roomAreaData[areaID]
end

function xianzhanModel.checkRebuildCondition(config,isWarning,showGain)
local costs=config.useItems
if costs then
for i=1,#costs do
local cost=costs[i]
local itemid=cost[1]
local count=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<count then
if isWarning then
UIManager.error('消耗不足')
end
if showGain then
gainControl:showGainWin(itemid)
end
return false
end
end
end
return true
end

function xianzhanModel:getTalkContent(customerId)
local npcid=customerId
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local talkContent=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'talkContent')
if npclv>#talkContent then
npclv=#talkContent
end
return talkContent[npclv]
end



function xianzhanModel:getFangKeCostRate()
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
local bdData=list[1]
local dizi_id=bdData.dizi_id
if tostring(dizi_id)~='0'then
local joblv=UIDiscipleModel:getDiscipleJobLevel(dizi_id,DISCIPLE_PROSKILL_TYPE.eShangDao)
local cfgs=cfg_xianzhanshangdaozengyiconfig()
for i,cfg in ipairs(cfgs)do
if joblv>=cfg.range[1]and joblv<=cfg.range[2]then
return cfg.lingshiZengYi
end
end
end
return 0
end

function xianzhanModel:getFangKeManYiDuRate()
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
local bdData=list[1]
local dizi_id=bdData.dizi_id
if tostring(dizi_id)~='0'then
local val=UIDiscipleModel:getDiscipleBaseAttr(dizi_id,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
local cfgs=cfg_xianzhanconghuizengyiconfig()
for i,cfg in ipairs(cfgs)do
if val>=cfg.conghuiRange[1]and val<=cfg.conghuiRange[2]then
return cfg.mydZengYi
end
end
end
return 0
end

function xianzhanModel:getFangKeHaoGanDuRate()
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
local bdData=list[1]
local dizi_id=bdData.dizi_id
if tostring(dizi_id)~='0'then
local val=UIDiscipleModel:getDiscipleBaseAttr(dizi_id,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local cfgs=cfg_xianzhanmeilizhizengyiconfig()
for i,cfg in ipairs(cfgs)do
if val>=cfg.mlzRange[1]and val<=cfg.mlzRange[2]then
return cfg.hgdZengYi
end
end
end
return 0
end

function xianzhanModel:getKickoutFKHanGanDu(customerId,level)
local quzhuDec=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'quzhuDec')
local hgd=quzhuDec[level]
if hgd==nil then
hgd=quzhuDec[#quzhuDec]
end
return hgd
end


function xianzhanModel:getZuJin(lsnum)
local rate=gubaoModel:getGBSkil_MoneyUpRate(2,eMoneyType.mtLingShi)
if rate>0 then
lsnum=math.floor(lsnum*(1+rate/100))
end
return lsnum
end

function xianzhanModel:markNote(roomData,noteId)
local zxcfg=cfgHelper.get1(cfg_xianzhanzhuangxiuconfig_get,roomData.zhuangxiuTypeId)
local haogandu
local manyidu
local year
if noteId==1 then
haogandu=xianzhanModel:getFangKeHaoGanDuRate()
local manyidurate=xianzhanModel:getFangKeManYiDuRate()
manyidu=math.floor(zxcfg.getManYiDu*(1+manyidurate))
year=gameUtilityModel.calculateGameYear(roomData.leaveTime-roomData.ruzhuTime)
else
local hgd=roomData.haoGanDu
local level=npcModel.getHaoGanDuLevel(hgd)
haogandu=xianzhanModel:getKickoutFKHanGanDu(roomData.customerId,level)
haogandu=-haogandu
manyidu=0
year=gameUtilityModel.calculateGameYear(gameUtilityModel.getServerShortTime()-roomData.ruzhuTime)
end


local costrate=xianzhanModel:getFangKeCostRate()
local cost=math.floor(zxcfg.getLingShi*year*(1+costrate))
cost=xianzhanModel:getZuJin(cost)

xianzhanModel:setNote(roomData.customerId,noteId,cost,haogandu,manyidu)
end

function xianzhanModel:setNote(customerId,noteId,cost,haogandu,manyidu)
local key='xianzhannotes'
local datalist=userActorSetting.get(key,{})
if#datalist>=20 then
table.remove(datalist,1)
end
local data={}
data.customerId=customerId
data.noteId=noteId
data.cost=cost
data.haogandu=haogandu
data.manyidu=manyidu
data.time=gameUtilityModel.getServerShortTime()
datalist[#datalist+1]=data
userActorSetting.set(key,datalist)
userActorSetting.flush()
end

function xianzhanModel:getNotes()
local key='xianzhannotes'
return userActorSetting.get(key,{})
end






function xianzhanModel:getCustomerInSideModelInfo(config)
local imagecfg=npcModel:getNPCImageCfg(config.id)
local image=imagecfg.image
local imageInfo={}
imageInfo.skeleton=image[1]
imageInfo.sex=imagecfg.sex
local components=image[2]
imageInfo.hair=components[1]
imageInfo.face=components[2]
imageInfo.body=components[3]
imageInfo.accessory=components[4]
local result=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
return result
end


function xianzhanModel:getCustomerOutSideModelInfo(config)
local imagecfg=npcModel:getNPCImageCfg(config.id)
local image=imagecfg.image
local imageInfo={}
imageInfo.body=image[1]
local components=image[2]
imageInfo.hair=components[1]
imageInfo.face=components[2]
imageInfo.body=components[3]
imageInfo.accessory=components[4]
local result=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
return result
end

function xianzhanModel.getFangKeName(customerId)
local npcid=customerId
local imagecfg=npcModel:getNPCImageCfg(npcid)
return imagecfg.name
end




function xianzhanModel:setKeShangList(len,xzksList)
if not self.data.keShangData then
self.data.keShangData={}
end
local keShangList={}
if len>0 then
for i,v in ipairs(xzksList)do
local npcId=v.npcid
keShangList[npcId]=v
end
end
self.data.keShangData.keShangList=keShangList
end

function xianzhanModel:getKeShangList()
if not self.data.keShangData then
return
end

return self.data.keShangData.keShangList
end

function xianzhanModel:setKeShangNextTime(nextTime)
if not self.data.keShangData then
self.data.keShangData={}
end
self.data.keShangData.nextTime=nextTime
end

function xianzhanModel:getKeShangNextTime()
if not self.data.keShangData then
return
end
return self.data.keShangData.nextTime
end

function xianzhanModel:setKeShangNextNpcId(nextNpcid)
if not self.data.keShangData then
self.data.keShangData={}
end
self.data.keShangData.nextNpcId=nextNpcid
end

function xianzhanModel:getKeShangNextNpcId()
if not self.data.keShangData then
return
end
return self.data.keShangData.nextNpcId
end

function xianzhanModel:addKeShangData(len,addKeShangList)
if not self.data.keShangData then
self.data.keShangData={}
end
if not self.data.keShangData.keShangList then
self.data.keShangData.keShangList={}
end

if len>0 then
for i,v in ipairs(addKeShangList)do

local npcId=v.npcid
self.data.keShangData.keShangList[npcId]=v
end
end
end

function xianzhanModel:removeKeShangData(removeNpcId)
if not self.data.keShangData then
self.data.keShangData={}
end
if self.data.keShangData.keShangList and next(self.data.keShangData.keShangList)then







if self.data.keShangData.keShangList[removeNpcId]then
self.data.keShangData.keShangList[removeNpcId]=nil
end
end
end

function xianzhanModel:getKeShangData(npcId)
if not self.data.keShangData then
return
end
if self.data.keShangData.keShangList and next(self.data.keShangData.keShangList)then







return self.data.keShangData.keShangList[npcId]
end
return nil
end

function xianzhanModel:setFastLeaveKeShangData(data)
if not self.data.keShangData then
self.data.keShangData={}
end
if data then
local rzTime=data.rzTime
local npcId=data.npcid
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
if ksCfg then
local leaveTime=rzTime+ksCfg.ksTime
self.data.keShangData.fastLeaveData={
npcId=npcId,
rzTime=rzTime,
leaveTime=leaveTime,
}
end
else
self.data.keShangData.fastLeaveData=nil
end

end

function xianzhanModel:getFastLeaveKeShangData()
if not self.data.keShangData then
return
end
return self.data.keShangData.fastLeaveData
end


function xianzhanModel:checkHasNewKeShang()
local nextTime=xianzhanModel:getKeShangNextTime()
if nextTime and nextTime>0 then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=nextTime then
return true
end
end
return false
end


function xianzhanModel:checkKeShangOrderReddot(npcId)
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
if not ksCfg then
return false
end

local orderNeedList=ksCfg.sgddList or{}
local keShangData=xianzhanModel:getKeShangData(npcId)
if not keShangData then
return false
end
for i=1,#orderNeedList do
local itemParam=orderNeedList[i]
local itemId=itemParam[1]
local itemNum=itemParam[2]
local hasItemNum=itemsModel.getCount(itemId)
if hasItemNum<itemNum then
return false
end
end
return true
end

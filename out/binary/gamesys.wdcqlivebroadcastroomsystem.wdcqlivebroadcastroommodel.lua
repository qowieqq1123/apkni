






local _MODULENAME="wdcqLiveBroadcastRoomModel"


def_table(_MODULENAME)
wdcqLiveBroadcastRoomModel.name=_MODULENAME

eWDCQLiveRoomMatchStageEnum=
{
eWaitStrart=0,
eSelectDisciple=1,
eBanDisciple=2,
eAdjustTeam=3,
eWaitFight=4,
eWatchFight=5,
eFightFinish=6,
}


function wdcqLiveBroadcastRoomModel:onAppStart()
self.giftQueue={}
end


function wdcqLiveBroadcastRoomModel:onEnterState(isReconnect)

end


function wdcqLiveBroadcastRoomModel:onProtocolReq()

end


function wdcqLiveBroadcastRoomModel:onLeaveState(isReconnect)
self:clearPoolNum()
self:clearRoomData()
self:clearAllShopData()
self:clearHotRank()
self:clearOwnHot()
self:clearGiftInfo()
self:clearTotalHot()
self:clearAllGiftData()
end



function wdcqLiveBroadcastRoomModel:setPoolNum(num)
self.poolNum=num
end

function wdcqLiveBroadcastRoomModel:getPoolNum()
return self.poolNum or 0
end

function wdcqLiveBroadcastRoomModel:clearPoolNum()
self.poolNum=nil
end

function wdcqLiveBroadcastRoomModel:setTotalHot(flag,num)
if self.totalHot==nil then
self.totalHot={}
end
self.totalHot.flag=flag
self.totalHot.num=num

local currGoal,nextGoal=self:calculateTotalHotGoal(self.totalHot.num)
self.totalHot.currGoal=currGoal
self.totalHot.nextGoal=nextGoal
end

function wdcqLiveBroadcastRoomModel:calculateTotalHotGoal(num)
local config=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdGoalReward")
local nextNum=nil
local currNum=0
for goal,list in pairsBySortKey(config)do
if num<goal then
nextNum=goal
break
else
currNum=goal
end
end
return currNum,nextNum
end

function wdcqLiveBroadcastRoomModel:getTotalHot()
return self.totalHot
end

function wdcqLiveBroadcastRoomModel:addTotalHot(num)
if self.totalHot then
self.totalHot.num=self.totalHot.num+num

local currGoal,nextGoal=self:calculateTotalHotGoal(self.totalHot.num)
self.totalHot.currGoal=currGoal
self.totalHot.nextGoal=nextGoal
end
end

function wdcqLiveBroadcastRoomModel:setTotalHotFlag(flag)
if self.totalHot then
self.totalHot.flag=flag
end
end

function wdcqLiveBroadcastRoomModel:clearTotalHot()
self.totalHot=nil
end

function wdcqLiveBroadcastRoomModel:getTotalHotReddot()
local tHot=self:getTotalHot()
return tHot.flag<tHot.currGoal
end

function wdcqLiveBroadcastRoomModel:setRoomData(args)
if self.roomData==nil then
self.roomData={}
end
self.roomData.group=args[1]
self.roomData.phase=args[2]
self.roomData.order=args[3]
self.roomData.people=args[5]
self.roomData.hot=args[6]
self.roomData.draw=args[7]
self.roomData.draw2=args[10]
end

function wdcqLiveBroadcastRoomModel:getRoomData()
return self.roomData
end

function wdcqLiveBroadcastRoomModel:clearRoomData(info)
if info then
if self:isSameRoom(info.group,info.phase,info.order)then
self.roomData=nil
return true
end
else
self.roomData=nil
return true
end
return false
end

function wdcqLiveBroadcastRoomModel:isInRoom()
return self.roomData~=nil
end

function wdcqLiveBroadcastRoomModel:isSameRoom(group,phase,order)
if self:isInRoom()then
local roomData=self:getRoomData()
return roomData.group==group and roomData.phase==phase and roomData.order==order
end
return false
end

function wdcqLiveBroadcastRoomModel:getRoomDraw()
if self.roomData then
return self.roomData.draw
end
end

function wdcqLiveBroadcastRoomModel:getRoomDraw2()
if self.roomData then
return self.roomData.draw2
end
end

function wdcqLiveBroadcastRoomModel:getRoomPeople()
if self.roomData then
return self.roomData.people
end
end

function wdcqLiveBroadcastRoomModel:getRoomHot()
if self.roomData then
return self.roomData.hot
end
end

function wdcqLiveBroadcastRoomModel:getRoomGroup()
if self.roomData then
return self.roomData.group
end
end

function wdcqLiveBroadcastRoomModel:setRoomDraw(draw,info,draw2)
if info then
if self:isSameRoom(info.group,info.phase,info.order)then
local roomData=self:getRoomData()
roomData.draw=draw
roomData.draw2=draw2 or roomData.draw2
end
else
if self:isInRoom()then
local roomData=self:getRoomData()
roomData.draw=draw
roomData.draw2=draw2 or roomData.draw2
end
end
end

function wdcqLiveBroadcastRoomModel:setRoomHot(hot,info)
if info then
if self:isSameRoom(info.group,info.phase,info.order)then
local roomData=self:getRoomData()
roomData.hot=hot
end
else
if self:isInRoom()then
local roomData=self:getRoomData()
roomData.hot=hot
end
end
end

function wdcqLiveBroadcastRoomModel:setRoomPeople(people,info)
if info then
if self:isSameRoom(info.group,info.phase,info.order)then
local roomData=self:getRoomData()
roomData.people=people
end
else
if self:isInRoom()then
local roomData=self:getRoomData()
roomData.people=people
end
end
end

function wdcqLiveBroadcastRoomModel:setShopData(phase,shopData)
if self.shopData==nil then
self.shopData={}
end
table.checkCreateSubTable(self.shopData,{phase})
local list=self.shopData[phase]
table.clear(list)
shopData=shopData or{}
for i,v in pairs(shopData)do
list[v.param_1]=v.param_2
end
end

function wdcqLiveBroadcastRoomModel:setShopBuyed(phase,shopId,shopNum)
local list=self:getShopData(phase)
if list then
list[shopId]=shopNum
end
end

function wdcqLiveBroadcastRoomModel:getShopData(phase)
if self.shopData and self.shopData[phase]then
return self.shopData[phase]
end
end

function wdcqLiveBroadcastRoomModel:getShopBuyed(phase,shopId)
local list=self:getShopData(phase)
if list then
return list[shopId]or 0
end
end

function wdcqLiveBroadcastRoomModel:clearAllShopData()
self.shopData=nil
end

function wdcqLiveBroadcastRoomModel:clearShopData(phase)
if self.shopData then
table.clear(self.shopData[phase])
end
end

function wdcqLiveBroadcastRoomModel:haveShopData(phase)
return self:getShopData(phase)~=nil
end

function wdcqLiveBroadcastRoomModel:setHotRank(rankData)
if self.hotRank==nil then
self.hotRank={}
else
table.clear(self.hotRank)
end
rankData=rankData or{}
for i,v in pairs(rankData)do
self.hotRank[v.rank]={
actorId=v.actorId,
serverId=v.serverId,
actorName=v.name,
headIcon=v.icon,
hot=v.reDu,
rank=v.rank,
discipledata=v.discipledata,
discipleimage=v.discipleimage,
}
end
end

function wdcqLiveBroadcastRoomModel:getHotRank()
return self.hotRank
end

function wdcqLiveBroadcastRoomModel:clearHotRank()
self.hotRank=nil
end

function wdcqLiveBroadcastRoomModel:setOwnHot(hot)
self.ownHot=hot
end

function wdcqLiveBroadcastRoomModel:getOwnHot()
return self.ownHot
end

function wdcqLiveBroadcastRoomModel:clearOwnHot()
self.ownHot=nil
end

function wdcqLiveBroadcastRoomModel:pushGiftInfo(gift)
table.insert(self.giftQueue,gift)
end

function wdcqLiveBroadcastRoomModel:popGiftInfo()
local gift=table.remove(self.giftQueue,1)
return gift
end

function wdcqLiveBroadcastRoomModel:backGiftInfo(gift)
table.insert(self.giftQueue,gift,1)
end

function wdcqLiveBroadcastRoomModel:countGiftInfo()
return#self.giftQueue
end

function wdcqLiveBroadcastRoomModel:haveGiftInfo()
local count=self:countGiftInfo()
return count>0
end

function wdcqLiveBroadcastRoomModel:clearGiftInfo()
table.clear(self.giftQueue)
end

function wdcqLiveBroadcastRoomModel:setGiftData(phase,giftData)
if self.giftData==nil then
self.giftData={}
end
table.checkCreateSubTable(self.giftData,{phase})
local list=self.giftData[phase]
table.clear(list)
giftData=giftData or{}
for i,v in pairs(giftData)do
list[v.param_1]=v.param_2
end
end

function wdcqLiveBroadcastRoomModel:setGiftBuyed(phase,giftId,giftNum)
local list=self:getGiftData(phase)
if list then
list[giftId]=giftNum
end
end

function wdcqLiveBroadcastRoomModel:getGiftData(phase)
if self.giftData and self.giftData[phase]then
return self.giftData[phase]
end
end

function wdcqLiveBroadcastRoomModel:getGiftBuyed(phase,giftId)
local list=self:getGiftData(phase)
if list then
return list[giftId]or 0
end
end

function wdcqLiveBroadcastRoomModel:clearAllGiftData()
self.giftData=nil
end

function wdcqLiveBroadcastRoomModel:clearGiftData(phase)
if self.giftData then
self.giftData[phase]=nil
end
end

function wdcqLiveBroadcastRoomModel:haveGiftData(phase)
return self:getGiftData(phase)~=nil
end
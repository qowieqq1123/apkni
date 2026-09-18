






xianmengdigongModel={}

xmdgRoomType=
{
eNormal=1,
eZS=2,
}
xmdgEventState={
eHide=0,
eIdle=1,
eDoing=2,
eReward=3,
eFinish=4,
eFailed=5,
}
xmdgEventType={
eCommon=1,
eLimit=2,
}

local roomEventPosConfigs
local bossRankRefreshTime=2

local _fightDifficulty=nil
local _fightDifficultyKey="XMDG_FightDifficulty"
local _exploreTimesKeyPrefix="XMDG_ExploreTimes_"

local getID=function(x,y)
return FMT.fmt('{0}_{1}',x,y)
end

function xianmengdigongModel:getID(x,y)
return getID(x,y)
end

function xianmengdigongModel:getFightDifficulty()
if not _fightDifficulty then
_fightDifficulty=userActorSetting.get(_fightDifficultyKey,1)
end
return _fightDifficulty
end

function xianmengdigongModel:setFightDifficulty(difficulty)
_fightDifficulty=difficulty
userActorSetting.flushVal(_fightDifficultyKey,_fightDifficulty,1)
end

function xianmengdigongModel:setExploreTimes(eventId,times)
if not eventId then return end
times=times or 0
local key=_exploreTimesKeyPrefix..tostring(eventId)
userActorSetting.flushVal(key,times,1)
end

function xianmengdigongModel:getExploreTimes(eventId)
if not eventId then return 0 end
local key=_exploreTimesKeyPrefix..tostring(eventId)
return userActorSetting.get(key,0)
end

function xianmengdigongModel:clearExploreTimes(eventId)
if not eventId then return end
local key=_exploreTimesKeyPrefix..tostring(eventId)
userActorSetting.flushVal(key,0,1)
end

function xianmengdigongModel:get_mapOffsetY()
return self.mapOffsetY
end

function xianmengdigongModel:intLookup()
self.mapConfigs=require('lua.gamesys.xianmeng.act.xianmengdigong.guilddigongmapconfig')
roomEventPosConfigs=require('lua.gamesys.xianmeng.act.xianmengdigong.roomEventPosConfigs')
xianmengdigongModel:initMapData_none()
end

function xianmengdigongModel:checkInit()
return self.data~=nil
end

function xianmengdigongModel:checkInitEx()
if self.data~=nil then
if self.data.oldDataMark~=nil then
if Time.realtimeSinceStartup-self.data.oldDataMark>=10 then
return true
end
else
return true
end
end
return false
end

function xianmengdigongModel:markOldData()

if self.data then
self.data.oldDataMark=Time.realtimeSinceStartup
end
end

function xianmengdigongModel:clearData()
self.mapConfigs=nil
self.data=nil
self.mapOffsetY=nil
self.data_none=nil
self.mapOffsetY_none=nil
self.isModel=nil
self.openDay=nil
self.nowXDL=nil
self.buyXDLCount=nil
self.unlockRoomID=nil
self.bossRankRefreshTimer=nil
self.bossRankLookup=nil
self.sequenceList=nil
self.startTimeLock=nil
self.secondsLock=nil
end

function xianmengdigongModel:isPosVail(id,isWarning)
local flag=false
if self.data and self.data.mapGridLookup then
flag=self.data.mapGridLookup[id]~=nil
end








return flag
end

function xianmengdigongModel:initOpenDay(openDay)
self.openDay=openDay
end

function xianmengdigongModel:getOpenDay()

return self.openDay
end

function xianmengdigongModel:initMapData(mapID,roomList,speRoom)
self.data={}
self.data.mapID=mapID
local mapcfg=self.mapConfigs[mapID]
self.data.mapcfg=mapcfg

local half_r=math.floor(mapcfg.roomRow/2)
local half_c=math.floor(mapcfg.roomCol/2)
local roomWidth=mapcfg.roomWidth
local roomHeight=mapcfg.roomHeight
local mapSkinCfg=xianmengdigongModel:get_mapSkinCfg(mapcfg.mapSkinID)
local lerpH=(mapSkinCfg.topHeight+mapSkinCfg.mapTopSide)-(mapSkinCfg.bottomHeight+mapSkinCfg.mapBottomSide)
if lerpH~=0 then
self.mapOffsetY=-lerpH/2
else
self.mapOffsetY=0
end


self.data.enterID=getID(mapcfg.enter[1],mapcfg.enter[2])
local e_pos={mapcfg.enter[1],mapcfg.enter[2]}
self.data.enterPos=e_pos
self.data.enterLocalPos={e_pos[1]*roomWidth,e_pos[2]*roomHeight}

local mapGridLookup={}
for c=-half_c,half_c do
for r=half_r,-half_r,-1 do
local id=getID(c,r)
mapGridLookup[id]=true
end
end
self.data.mapGridLookup=mapGridLookup

local mapZSGridLookup={}
if mapcfg.zs and#mapcfg.zs>0 then
for i,v in ipairs(mapcfg.zs)do
local x=v[1]
local y=v[2]
local id=getID(x,y)
if xianmengdigongModel:isPosVail(id,true)then
local g={id=id,x=x,y=y,width=roomWidth,height=roomHeight,posx=x*roomWidth,posy=y*roomHeight+self.mapOffsetY}
xianmengdigongModel:initGrid(g,v)
mapZSGridLookup[id]=g
end
end
end
self.data.mapZSGridLookup=mapZSGridLookup

local baseRoomsLookup={}
if mapcfg.rooms then
for i,v in ipairs(mapcfg.rooms)do
local id=getID(v.x,v.y)
if xianmengdigongModel:isPosVail(id,true)then
local room=table.deepCopy(v)
room.id=id
xianmengdigongModel:initBaseRoom(room)
baseRoomsLookup[id]=room
end
end
end

local zsroomsLookup={}
if mapcfg.zsrooms then
for i,v in ipairs(mapcfg.zsrooms)do
local id=getID(v.x,v.y)
if xianmengdigongModel:isPosVail(id,true)then
local room=table.deepCopy(v)
room.id=id
xianmengdigongModel:initBaseRoom(room)
baseRoomsLookup[id]=room
local zsroom={base=room}
zsroom.typo=xmdgRoomType.eZS
xianmengdigongModel:initRoom(zsroom)
zsroomsLookup[id]=zsroom
end
end
end
self.data.zsroomsLookup=zsroomsLookup
self.data.baseRoomsLookup=baseRoomsLookup

local roomsLookup={}
if roomList then
for i,v in ipairs(roomList)do
local id=getID(v.x,v.y)
if xianmengdigongModel:isPosVail(id,true)then
local base=baseRoomsLookup[id]
if base then
local room={base=base,ysConfId=v.ysConfId,unlockJinDu=v.unlockJinDu,speed=v.speed,
startTime=v.startTime,roomConfId=v.roomConfId,buffId=v.bossFZId,buffLv=v.bossFZLevel,
unlockFlag=v.unlockFlag,rankRewardFlag=v.rankRewardFlag,
fastFlag=v.kstzFlag,bossMaxHurt=v.bossMaxHurt}
room.typo=xmdgRoomType.eNormal
xianmengdigongModel:initRoom(room)

local eventLookup={}
local eventPosList={}
local eventList=v.eventList or{}
local eventNum=#eventList
if eventNum>0 then
local eventPosPrefab=cfgHelper.get2(cfg_guilddigongroomconfig_get,room.roomConfId,'eventPosPrefab')
local roompos=roomEventPosConfigs[eventPosPrefab]
for i2,event in ipairs(eventList)do
xianmengdigongModel:initEvent(event)
local pos
if roompos then
pos=roompos[event.eventPos]
end
event:initPos(pos)
eventLookup[event.eventPos]=event
table.insert(eventPosList,event.eventPos)
end
end
room.eventList=eventList
room.eventNum=eventNum
room.eventLookup=eventLookup
room.eventPosList=eventPosList

roomsLookup[id]=room
else



end
end
end
end
self.data.roomsLookup=roomsLookup

end

function xianmengdigongModel:initData(dzList,buffLayer,buyXDLCount)
self.data.buffLayer=buffLayer
self.buyXDLCount=buyXDLCount

local dzDataLookup={}
if dzList then
for i,v in ipairs(dzList)do
local data={guid=v.guid,hp=v.hp,time=gameUtilityModel.getServerLongTime()}
local guid_str=tostring(v.guid)
dzDataLookup[guid_str]=data
end
end
local all=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(all)do
local netData=v.netData.net
local guid_str=netData.discipleguidStr
local data=dzDataLookup[guid_str]
if data==nil then
data={guid=netData.discipleguid,hp=10000,time=gameUtilityModel.getServerLongTime()}
dzDataLookup[guid_str]=data
end
end
self.data.dzDataLookup=dzDataLookup
end

function xianmengdigongModel:initGL(glList,nameGL,timeGL)
local glid=nil
if glList then
glid=getID(glList[1],glList[2])
end
self.data.glid=glid
self.data.nameGL=nameGL
if timeGL>0 then
timeGL=gameUtilityModel.serverShortTimeToLong(timeGL)
end
self.data.timeGL=timeGL
end

function xianmengdigongModel:getXDL()
return moneyModel.getMoney(eMoneyType.mtDiGongXingDongLi)
end

function xianmengdigongModel:setXDLCount(v)
self.buyXDLCount=v
end

function xianmengdigongModel:getXDLCount()
return self.buyXDLCount or 0
end

function xianmengdigongModel:getMaxXDLCount()
local xdlcfg=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'xdli')
return xdlcfg[6]
end

function xianmengdigongModel:setGLID(x,y,nameGL,timeGL)
self.data.glid=getID(x,y)
self.data.nameGL=nameGL
if timeGL>0 then
timeGL=gameUtilityModel.serverShortTimeToLong(timeGL)
end
self.data.timeGL=timeGL
end

function xianmengdigongModel:clearGLID(nameGL,timeGL)
self.data.glid=nil
self.data.nameGL=nameGL
self.data.timeGL=timeGL
end

function xianmengdigongModel:getGLID()
return self.data.glid
end

function xianmengdigongModel:getGLName()
return self.data.nameGL
end

function xianmengdigongModel:getGLTime()
return self.data.timeGL
end

function xianmengdigongModel:setBufflv(v)
self.data.buffLayer=v
end

function xianmengdigongModel:getBufflv()
if self.data then
return self.data.buffLayer
end
return 0
end

function xianmengdigongModel:initPassFlag(flag)
self.data.passFlag=flag
end


function xianmengdigongModel:GetFlag()
if self.data then
return self.data.passFlag
end
return 0
end

function xianmengdigongModel:checkPassFlag(isWarning)
if self.data then
local flag=self.data.passFlag==1
if flag and isWarning then
UIManager.error('您已通关过地宫，需等待下轮活动')
end
return flag
end
return false
end

function xianmengdigongModel:getmapcfg()
return self.data.mapcfg
end

function xianmengdigongModel:isEnter(id)
local data=self.data
if data then
return data.enterID==id
end
return false
end



function xianmengdigongModel:initGrid(g,cfg)

if cfg[3]>2 then
g.skinID=cfg[3]
else
g.skinID=0
end

g.zs={cfg[4],cfg[5],cfg[6],cfg[7]}



g.checkShow=function(self_)
local room=xianmengdigongModel:checkInRoom(self_.id)
if room then
return not room:checkShow()
else
return true
end
end
end

function xianmengdigongModel:getmapGridListSort(pos)
local list={}
local data=self.data
if data then
if data.mapZSGridLookup then
pos=pos or data.enterPos
for id_,g in pairs(data.mapZSGridLookup)do
g.disAnySort=mathHelper.distance2(pos[1],pos[2],g.x,g.y)
table.insert(list,g)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.disAnySort<b.disAnySort
end)
end
return list
end





function xianmengdigongModel:initBaseRoom(base)

local round={}
for i=0,base.w-1 do
for j=0,base.h-1 do
local id=getID(base.x+i,base.y-j)
round[id]=true
end
end
base.round=round
base.checkInRound=function(self_,id)
return self_.round[id]==true
end
end

function xianmengdigongModel:initRoom(room)
local base=room.base

local mcfg=self.data.mapcfg
local roomWidth=mcfg.roomWidth
local roomHeight=mcfg.roomHeight
base.width=roomWidth*base.w
base.height=roomHeight*base.h
base.posx=(base.x+(base.w-1)/2.0)*roomWidth
base.posy=(base.y-(base.h-1)/2.0)*roomHeight+self.mapOffsetY



if room.typo==xmdgRoomType.eZS then

room.checkShow=function(self_)
return true
end
return
end



local enterID=nil
if base.hide then
enterID=getID(base.hide[1],base.hide[2])
end
room.enterID=enterID

room.isHideRoom=function(self_)
return self_.enterID~=nil
end

room.isHideRoomEnter=function(self_,roomid)
return self_.enterID~=nil and self_.enterID==roomid
end

local outRoundRooms={}
local nearEnter=false
if room.enterID==nil then

local r_id
for i=0,base.w-1 do
r_id=getID(base.x+i,base.y+1)
if xianmengdigongModel:isPosVail(r_id)then
local baseRoom=xianmengdigongModel:getBaseRoom(r_id)
if baseRoom~=nil and baseRoom.hide==nil then
table.insert(outRoundRooms,baseRoom.id)
end
end
if xianmengdigongModel:isEnter(r_id)then
nearEnter=true
end
r_id=getID(base.x+i,base.y-base.h)
if xianmengdigongModel:isPosVail(r_id)then
local baseRoom=xianmengdigongModel:getBaseRoom(r_id)
if baseRoom~=nil and baseRoom.hide==nil then
table.insert(outRoundRooms,baseRoom.id)
end
end
if xianmengdigongModel:isEnter(r_id)then
nearEnter=true
end
end
for j=0,base.h-1 do
r_id=getID(base.x-1,base.y-j)
if xianmengdigongModel:isPosVail(r_id)then
local baseRoom=xianmengdigongModel:getBaseRoom(r_id)
if baseRoom~=nil and baseRoom.hide==nil then
table.insert(outRoundRooms,baseRoom.id)
end
end
if xianmengdigongModel:isEnter(r_id)then
nearEnter=true
end
r_id=getID(base.x+base.w,base.y-j)
if xianmengdigongModel:isPosVail(r_id)then
local baseRoom=xianmengdigongModel:getBaseRoom(r_id)
if baseRoom~=nil and baseRoom.hide==nil then
table.insert(outRoundRooms,baseRoom.id)
end
end
if xianmengdigongModel:isEnter(r_id)then
nearEnter=true
end
end
end
room.outRoundRooms=outRoundRooms
room.nearEnter=nearEnter

local maxJinDu
if room.ysConfId>0 then
local monstercfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,room.ysConfId)
if monstercfg.gwtype==MONSTER_TYPE.eShouLing then
maxJinDu=10000
else
local progress=cfgHelper.get2(cfg_guilddigongroomconfig_get,room.roomConfId,'progress')
maxJinDu=progress or 1000
if progress==nil then



end
end
end
room.maxJinDu=maxJinDu
room.hasRank=function(self_)
if self_.ysConfId>0 then
local monstercfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,self_.ysConfId)
if monstercfg.gwtype==MONSTER_TYPE.eShouLing then
return true
end
end
return false
end

room.hasRankReward=function(self_)
if self_.ysConfId>0 and self_:checkunLock()then
return self_:hasRank()and self_:hasRankRewardEx()
end
return false
end
room.hasRankRewardEx=function(self_)
if xianmengdigongModel:checkPassFlag(false)then
return false
end
if self_.rankRewardFlag~=nil and self_.rankRewardFlag~=1 then
return true
end
return false
end

room.checkBattle=function(self_)

return self_:checkunLock()and self_.ysConfId>0
end

room.checkVisit=function(self_)
if self_.nearEnter then

return true
elseif self_:checkunLock()and not self_:isHideRoom()then

return true
else



if self_:isHideRoom()then
local e_room=xianmengdigongModel:getRoom(self_.enterID)
if e_room and e_room:checkunLock()then
return true
end
else

for i,r_id in ipairs(self_.outRoundRooms)do
local r_room=xianmengdigongModel:getRoom(r_id)
if r_room and r_room:checkunLock()then
return true
end
end
end
end


return false
end

room.checkunLock=function(self_)
if self_.ysConfId>0 then
if self_.unlockFlag~=1 then
local cfg=cfgHelper.get1(cfg_guilddigongyaoshouconfig_get,self_.ysConfId)
if cfg.gwtype==MONSTER_TYPE.eShouLing then
return self_.unlockJinDu<=0
else
return self_.unlockJinDu>=self_.maxJinDu
end
end
end
return true
end

room.checkCloud=function(self_)
return not self_:checkunLock()
end
room.getCloudSkin=function(self_)
if self_.base.w==1 then
return 100
else
return 101
end
end
room.getUnlockEffect=function(self_)
if self_.base.w==1 then
return 10307
else
return 10308
end
end

room.checkShow=function(self_)
if self_.enterID~=nil then
local enterRoom=xianmengdigongModel:getRoom(self_.enterID)
if enterRoom then
if enterRoom:checkunLock()then
return true
end
end
return false
end
return true
end

room.getEvent=function(self_,eventPos)
return self_.eventLookup[eventPos]
end
room.getEvents=function(self_)
return self_.eventList
end
room.getEventPosList=function(self_)
return self_.eventPosList
end
room.getEvents_doing_idle=function(self_)
local list={}
if self_.eventNum>0 then
for i,event in ipairs(self_.eventList)do
local state=event:getState()
if state==xmdgEventState.eIdle or state==xmdgEventState.eDoing then
table.insert(list,event)
end
end
end
return list
end
room.getEvents_limit_doing=function(self_)
local list={}
if self_.eventNum>0 then
for i,event in ipairs(self_.eventList)do
if event:isLimitEvent()then
local state=event:getState()
if state==xmdgEventState.eDoing then
table.insert(list,event)
end
end
end
end
return list
end
room.getEvents_reward=function(self_)
local list={}
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianMengDiGong)then return list end
if self_.eventNum>0 then
for i,event in ipairs(self_.eventList)do
local state=event:getState()
if state==xmdgEventState.eReward then
table.insert(list,event)
end
end
end
return list
end
room.getEvents_reward_num=function(self_)
local num=0
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianMengDiGong)then return 0 end
if self_.eventNum>0 then
for i,event in ipairs(self_.eventList)do
local state=event:getState()
if state==xmdgEventState.eReward then
num=num+1
end
end
end
return num
end

room.checkDZInRoom=function(self_,dzGuid)
if self_.eventNum>0 then
for i,event in ipairs(self_.eventList)do
if event:hasDZ(dzGuid)then
local state=event:getState()
if state==xmdgEventState.eDoing then
return true,event
end
end
end
end
return false
end
room.compare=function(self_,room_)
return self_.base.id==room_.base.id
end
room.compareEx=function(self_,roomid)
return self_.base.id==roomid
end

room.setFastFlag=function(self_,pos)
self_.fastFlag=self_.fastFlag or 0
self_.fastFlag=bitHelper.set_1(self_.fastFlag,pos-1)
end
room.getFastFlag=function(self_,pos)
return bitHelper.check_pos(self_.fastFlag or 0,pos-1)
end

room.setBossMaxHurt=function(self_,bossMaxHurt)
self_.bossMaxHurt=bossMaxHurt
end
room.getBossMaxHurt=function(self_)
return self_.bossMaxHurt or 0
end
end

function xianmengdigongModel:getBaseRoom(id)
local data=self.data
if data then
if data.baseRoomsLookup then
local baseRoom=data.baseRoomsLookup[id]
if baseRoom then
return baseRoom
end
for roomid,baseRoom_ in pairs(data.baseRoomsLookup)do
if baseRoom_:checkInRound(id)then
return baseRoom_
end
end
end
end
return nil
end

function xianmengdigongModel:getRoom(id)
local data=self.data
if data then
if data.roomsLookup then
return data.roomsLookup[id]
end
end
end

function xianmengdigongModel:getRoom2(x,y)
local data=self.data
if data then
if self:isSpeRoom(x,y)then
return self:getSpeRoomData()
else
if data.roomsLookup then
local id=getID(x,y)
return data.roomsLookup[id]
end
end
end
end

function xianmengdigongModel:checkInRoom(id)
local data=self.data
if data then
if data.roomsLookup then
for id_,room in pairs(data.roomsLookup)do
if room.base:checkInRound(id)then
return room
end
end
end
if data.zsroomsLookup then
for id_,room in pairs(data.zsroomsLookup)do
if room.base:checkInRound(id)then
return room
end
end
end

end
end

function xianmengdigongModel:getHideRoom(enterID)
local data=self.data
if data then
if data.roomsLookup then
for id_,room in pairs(data.roomsLookup)do
if room:isHideRoomEnter(enterID)then
return room
end
end
end
end
end

function xianmengdigongModel:getroomsListSort(pos)
local list={}
local data=self.data
if data then
if data.roomsLookup then
pos=pos or data.enterPos
for id_,room in pairs(data.roomsLookup)do
room.disAnySort=mathHelper.distance2(pos[1],pos[2],room.base.x,room.base.y)
table.insert(list,room)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.disAnySort<b.disAnySort
end)
end
return list
end

function xianmengdigongModel:getzsroomsListSort(pos)
local list={}
local data=self.data
if data then
if data.zsroomsLookup then
pos=pos or data.enterPos
for id_,room in pairs(data.zsroomsLookup)do
room.disAnySort=mathHelper.distance2(pos[1],pos[2],room.base.x,room.base.y)
table.insert(list,room)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.disAnySort<b.disAnySort
end)
end
return list
end

function xianmengdigongModel:checkDZInRoom(dzguid)
local data=self.data
if data then
if data.roomsLookup then
for id_,room in pairs(data.roomsLookup)do
local flag,event=room:checkDZInRoom(dzguid)
if flag then
return true,room,event
end
end
end
local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local flag,event=speRoom:checkDZInRoom(dzguid)
if flag then
return true,speRoom,event
end
end
end
return false
end


function xianmengdigongModel:getTargetRoomPos()
local data=self.data
if data then
return data.enterPos,data.enterLocalPos
end
return nil,nil
end

function xianmengdigongModel:getTargetRoomPos2()
local data=self.data
if data then
if data.roomsLookup then
local list={}
local list2={}
for id,room in pairs(data.roomsLookup)do
if room:checkVisit()then
if room:checkunLock()then
local events=room:getEvents_doing_idle()
if#events>0 then
table.insert(list2,{room.base.posx,room.base.posy})
end
else
table.insert(list,{room.base.posx,room.base.posy})
end
end
end
if#list>0 then
return list[1]
end
if#list2>0 then
return list2[1]
end
end
end
return nil
end



function xianmengdigongModel:setUnlockRoom(roomid)
self.unlockRoomID=roomid
end

function xianmengdigongModel:getUnlockRoom()
return self.unlockRoomID
end

function xianmengdigongModel:checkUnlockAnim(roomid)
return self.unlockRoomID==roomid
end

function xianmengdigongModel:getUnlockRoomNum()
local num=0
local all=0
local data=self.data
if data then

if data.roomsLookup then
for id,room in pairs(data.roomsLookup)do
if room:checkunLock()then
num=num+1
end
all=all+1
end
end
end
return num,all
end

function xianmengdigongModel:isUnlockAll()
local num,all=xianmengdigongModel:getUnlockRoomNum()
return num==all
end


function xianmengdigongModel:checkRoomUnlock(roomcfgids)
local data=self.data
if data and data.roomsLookup then
if roomcfgids then
local lp={}
for i,cfgid in ipairs(roomcfgids)do
lp[cfgid]=true
end
for id,room in pairs(data.roomsLookup)do
local cfgid=room.roomConfId
if lp[cfgid]and not room:checkunLock()then
return false
end
end
return true
end
end
return false
end




function xianmengdigongModel:initEvent(event)
local e_id=event.eventId
local cfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,e_id)
event.limitTime=cfg.eventTime
event.eventType=cfg.eventType

if event.eventType==xmdgEventType.eCommon then
event.maxman=cfg.cyNum
else
event.maxman=1
end
event.isLimitEvent=function(self_)
return self_.limitTime~=nil
end
event.refreshData=function(self_,data)
self_.myRewardFlag=data.myRewardFlag
self_.jinDu=data.jinDu
self_.speed=data.speed
self_.startTime=data.startTime
self_.dzList=data.dzList
self_:refreshDZ()
end
event.initPos=function(self_,pos)
if pos then
self_.posx=pos[1]
self_.posy=pos[2]
else
self_.posx=0
self_.posy=0
end
end
event.getDZName=function(self_,dzGuid)
if self_.curman>0 then
for i,v in ipairs(self_.dzList)do
if mathHelper.compareInt64(dzGuid,v.dzGuid)then
return v.dzName
end
end
end
return nil
end
event.refreshDZ=function(self_)
self_.dzList=self_.dzList or{}
self_.curman=#self_.dzList
local mydz=nil
if self_.curman>0 then
for i,v in ipairs(self_.dzList)do
local sortWeight=0
if UIDiscipleModel:getMyDiscipleData(v.dzGuid)then
mydz=v.dzGuid
sortWeight=1
end
v.sortWeight=sortWeight
end
if self_.curman>1 then
table.sort(self_.dzList,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
end
self_.mydz=mydz
end
event:refreshDZ()
event.hasDZ=function(self_,guid)
if self_.mydz~=nil then
return mathHelper.compareInt64(guid,self_.mydz)
end
return false
end
event.hasMyDZ=function(self_)
return self_.mydz~=nil
end
event.getMyDZ=function(self_)
return self_.mydz
end
event.isFullMan=function(self_)
return self_.curman>=self_.maxman
end

event.getState=function(self_)
if self_.startTime>0 then
if self_.myRewardFlag==0 then
if self_:isLimitEvent()then

local lerp=gameUtilityModel.getServerShortTime()-self_.startTime
if lerp>=self_.limitTime then
return xmdgEventState.eFailed
else
return xmdgEventState.eDoing,lerp,self_.limitTime,self_.limitTime-lerp
end
else

local isover=false
local cur=self_.jinDu
local lerp_t=0
if cur>=10000 then
isover=true
else
local space=cfgHelper.get3(cfg_guilddigongeventconfig_get,self_.eventId,'speed',1)
local lerptime=gameUtilityModel.getServerShortTime()-self_.startTime
local t=math.floor(lerptime/space)
cur=cur+self_.speed*t
if cur>=10000 then
isover=true
else
local endTime=self_.startTime+math.ceil((10000-self_.jinDu)/self_.speed)*space
lerp_t=endTime-gameUtilityModel.getServerShortTime()
end
end
if isover then
if self_:hasMyDZ()then
return xmdgEventState.eReward
else
return xmdgEventState.eFinish
end
else
return xmdgEventState.eDoing,cur,10000,lerp_t
end
end
else
return xmdgEventState.eFinish
end
else
if self_:isLimitEvent()then
return xmdgEventState.eHide
else
return xmdgEventState.eIdle
end
end
end

event.rewards=nil
event.setRewards=function(self_,rewards)
self_.rewards=rewards
end
event.checkReward=function(self_)
if self_.rewards then
if self_.rewards[1]~=nil and#self_.rewards[1]>0 then
return true
end
if self_.rewards[2]~=nil and#self_.rewards[2]>0 then
return true
end
if self_.rewards[3]~=nil and#self_.rewards[3]>0 then
return true
end
end
return false
end
event.flagReward=function(self_,flag)
self_.myRewardFlag=flag
end
end

function xianmengdigongModel:newEventMan(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local man={}
man.dzGuid=guid
man.discipledata=netData.discipledata
man.discipleimage=netData.discipleimage
man.dzName=netData.disciplename
return man
end

function xianmengdigongModel:checkFirstInEvent(eventId)
local eventId_str=tostring(eventId)
local eventLook=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'eventLook',nil)
if eventLook then
return eventLook[eventId_str]==nil
end
return true
end

function xianmengdigongModel:setFirstInEvent(eventId)
local eventId_str=tostring(eventId)
local eventLook=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'eventLook',nil)
if eventLook==nil then
eventLook={}
end
eventLook[eventId_str]=1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengDiGong,'eventLook',eventLook)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengDiGong)
end

function xianmengdigongModel:getAllHasRewardEvent()
local data=self.data
if data then
if data.roomsLookup then
local list={}
for id_,room in pairs(data.roomsLookup)do
local temp=room:getEvents_reward()
if#temp>0 then
for i,event in ipairs(temp)do
table.insert(list,{x=room.base.x,y=room.base.y,eventPos=event.eventPos,dzguid=event.mydz,rewards=event.rewards})
end
end
end

local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local temp=speRoom:getEvents_reward()
if#temp>0 then
for i,event in ipairs(temp)do
local times=xianmengdigongModel:getExploreTimes(event.eventId)or 1
for idx=1,times do
table.insert(list,{x=speRoom.base.x,y=speRoom.base.y,eventPos=event.eventPos,dzguid=event.mydz,rewards=event.rewards,eventId=event.eventId,times=times,timesIdx=idx})
end
end
end
end

return list
end
end
return nil
end

function xianmengdigongModel:getAllHasRewardEvent_num()
local num=0
local data=self.data
if data then
if data.roomsLookup then
local list={}
for id_,room in pairs(data.roomsLookup)do
local n=room:getEvents_reward_num()
if n>0 then
num=num+n
end
end
end

local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local n=speRoom:getEvents_reward_num()
if n>0 then
num=num+n
end
end
end
return num
end

function xianmengdigongModel:getAllEventSequenceList_doing_idle(refresh)
if not self.sequenceList or refresh then
self.sequenceList={}
local data=self.data
if data then
if data.roomsLookup then
for _,room in pairs(data.roomsLookup)do
if room:checkVisit()and room:checkunLock()then
local temp=room:getEvents_doing_idle()
local c=#temp
if c>0 then
table.insert(self.sequenceList,room.base.id)
end
end
end
end
end
end
return self.sequenceList
end

function xianmengdigongModel:getAllEventLookup_doing_idle()
local lp={}
local data=self.data
if data then
if data.roomsLookup then
local list={}
for id_,room in pairs(data.roomsLookup)do
local temp=room:getEvents_doing_idle()
local c=#temp
if c>0 then
lp[room.base.id]=c
end
end
end
local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local temp=speRoom:getEvents_doing_idle()
local c=#temp
if c>0 then
lp[speRoom.base.id]=c
end
end
end
return lp
end

function xianmengdigongModel:getAllHasRewardEventNum()
local actID=LIMIT_ACT_TYPE.eXianMengDiGong
if not limitActivitiesModel:checkActDoing(actID)then return 0 end
if not xianmengModel:hasXM()then return 0 end
return xianmengdigongModel:getAllHasRewardEvent_num()
end

function xianmengdigongModel:getAllHasRewardEventEx()
local data=self.data
if data then
if data.roomsLookup then
local list={}
for id_,room in pairs(data.roomsLookup)do
local temp=room:getEvents_reward()
if#temp>0 then
for i,event in ipairs(temp)do
if event.rewards then
table.insert(list,{x=room.base.x,y=room.base.y,eventPos=event.eventPos,dzguid=event.mydz,rewards=event.rewards})
end
end
end
end
local speRoom=xianmengdigongModel:getSpeRoomData()
if speRoom then
local temp=speRoom:getEvents_reward()
if#temp>0 then
for i,event in ipairs(temp)do
if event.rewards then
local times=xianmengdigongModel:getExploreTimes(event.eventId)or 1
times=tonumber(times)

if event.eventId==10001 and times>1 then
local splitted=xianmengdigongModel:splitRewardsEvenly(event.rewards,times)
for k=1,times do
table.insert(list,{x=speRoom.base.x,y=speRoom.base.y,eventPos=event.eventPos,dzguid=event.mydz,rewards=splitted[k]})
end
else
table.insert(list,{x=speRoom.base.x,y=speRoom.base.y,eventPos=event.eventPos,dzguid=event.mydz,rewards=event.rewards})
end
end
end
end
end
return list
end
end
return nil
end


function xianmengdigongModel:splitRewardsEvenly(rewards,times)
times=tonumber(times)or 1
if times<=1 or rewards==nil then
return{rewards}
end

local result={}
for i=1,times do
result[i]={[1]={},[2]={},[3]={},[4]={}}
end

local bucketTotals={}
for i=1,times do
bucketTotals[i]=0
end

local function addToBucket(bucketIdx,groupIdx,itemId,itemNum)
itemNum=tonumber(itemNum)or 0
if itemNum<=0 then return end
local list=result[bucketIdx][groupIdx]
for _,it in ipairs(list)do
if it.param_1==itemId then
it.param_2=(tonumber(it.param_2)or 0)+itemNum
bucketTotals[bucketIdx]=bucketTotals[bucketIdx]+itemNum
return
end
end
table.insert(list,{param_1=itemId,param_2=itemNum})
bucketTotals[bucketIdx]=bucketTotals[bucketIdx]+itemNum
end

local function pickMinBucket(mask)
local minIdx=nil
local minVal=nil
for i=1,times do
if mask==nil or mask[i]then
local v=bucketTotals[i]or 0
if minVal==nil or v<minVal then
minVal=v
minIdx=i
end
end
end
return minIdx or 1
end

for groupIdx=1,4 do
local group=rewards[groupIdx]
if group~=nil and#group>0 then
for _,v in ipairs(group)do
local itemId=v.param_1
local total=tonumber(v.param_2)or 0
if total>0 and itemId~=nil then
local base=math.floor(total/times)
local rem=total-base*times
if base>0 then
for i=1,times do
addToBucket(i,groupIdx,itemId,base)
end
end
if rem>0 then
local used={}
for i=1,times do used[i]=true end
for _=1,rem do
local idx=pickMinBucket(used)
addToBucket(idx,groupIdx,itemId,1)
used[idx]=false
end
end
end
end
end
end

return result
end





function xianmengdigongModel:initDGMembers(list)
local dgMembersList={}
if list then
for i,member in ipairs(list)do
local myActorid=playerModel:getActorID()
local isself=false
if mathHelper.compareInt64(myActorid,member.actorId)then
isself=true
end
member.isself=isself
table.insert(dgMembersList,member)
end
end
self.data.dgMembersList=dgMembersList
self.data.dgMemberTime=Time.realtimeSinceStartup
end

function xianmengdigongModel:getDGMembersSort()
local data=self.data
if data then
if data.dgMembersList then
table.sort(data.dgMembersList,function(a,b)
return a.gongXian>b.gongXian
end)
return data.dgMembersList
end
end
return nil
end

function xianmengdigongModel:checkOpenMember()
local data=self.data
if data~=nil then
local needNew=false
if data.dgMembersList==nil or data.dgMemberTime==nil or Time.realtimeSinceStartup-data.dgMemberTime>=10 then
needNew=true
xianmengdigongController:send_20_112()
end
return needNew
end
end





function xianmengdigongModel:addNewDZ(dzguid)
local data=self.data
if data~=nil and data.dzDataLookup~=nil then
local dzguidStr=tostring(dzguid)
local d=data.dzDataLookup[dzguidStr]
if d==nil then
d={guid=dzguid,hp=10000,time=gameUtilityModel.getServerLongTime()}
data.dzDataLookup[dzguidStr]=d
end
end
end

function xianmengdigongModel:getDZBlood(dzguid)
local data=self.data
if data~=nil and data.dzDataLookup~=nil then
local dzguidStr=tostring(dzguid)
local d=data.dzDataLookup[dzguidStr]
if d~=nil then
local curTime=gameUtilityModel.getServerLongTime()
if d.r_time==nil or not timeHelper.checkInSameDay(d.r_time,curTime)then
local y_,m_,d_=timeHelper.getDateNumber(curTime)
local r_time=timeHelper.timeServer(y_,m_,d_,5,0,0)
d.r_time=r_time
end

if d.time<d.r_time and curTime>=d.r_time then


d.hp=10000





d.time=curTime
end
return d.hp
end
end
return nil
end

function xianmengdigongModel:setDZBlood(dzguid,hp)
local data=self.data
if data~=nil and data.dzDataLookup~=nil then
local dzguidStr=tostring(dzguid)
if dzguidStr~='0'then
local d=data.dzDataLookup[dzguidStr]
if d==nil then
d={guid=dzguid,hp=hp,time=gameUtilityModel.getServerLongTime()}
data.dzDataLookup[dzguidStr]=d
else
d.hp=hp
d.time=gameUtilityModel.getServerLongTime()
end
return true
end
end
return false
end





function xianmengdigongModel:checkBossRankList(roomid)
local needRefresh=false
local lp=self.bossRankLookup
local timelp=self.bossRankRefreshTimer
if lp==nil or lp[roomid]==nil then
needRefresh=true
elseif timelp==nil or timelp[roomid]==nil
or Time.realtimeSinceStartup-timelp[roomid]>=bossRankRefreshTime then
needRefresh=true
end
if needRefresh then
if timelp==nil then
timelp={}
self.bossRankRefreshTimer=timelp
end
timelp[roomid]=Time.realtimeSinceStartup

end
return needRefresh
end

function xianmengdigongModel:getBossRankList(roomid)
local lp=self.bossRankLookup
if lp~=nil then
return lp[roomid]
end
end

function xianmengdigongModel:setBossRankList(roomid,list)
local lp=self.bossRankLookup
if lp==nil then
lp={}
self.bossRankLookup=lp
end
lp[roomid]=list
end

function xianmengdigongModel:checkRankReward()
local data=self.data
if data then
if data.roomsLookup then
for id_,room in pairs(data.roomsLookup)do
local temp=room:getEvents_reward()
if room:hasRankReward()then
return true
end
end
end
end
return nil
end

function xianmengdigongModel:checkRankReward_rooms()
local data=self.data
if data then
if data.roomsLookup then
local list={}
for id_,room in pairs(data.roomsLookup)do
local temp=room:getEvents_reward()
if room:hasRankReward()then
table.insert(list,room.base.id)
end
end
return list
end
end
return nil
end





function xianmengdigongModel:setSaveSortType(idx)
onlineDataSetting:setData('xmdgDZSelectSortType',idx)
end
function xianmengdigongModel:getSaveSortType()
return onlineDataSetting:getData('xmdgDZSelectSortType',eDiscipleSortType.eFightSort)
end
function xianmengdigongModel:setSaveSortCondition(sortCondition)
local saveSortCondition={}
for k,v in pairs(sortCondition)do
saveSortCondition[tostring(k)]=v
end
onlineDataSetting:setData('xmdgDZSelectSortCond',saveSortCondition)
end
function xianmengdigongModel:getSaveSortCondition()
local temp=onlineDataSetting:getData('xmdgDZSelectSortCond',{})
local temp_=table.deepCopy(temp)
local saveSortCondition={}
for k,v in pairs(temp_)do
saveSortCondition[tonumber(k)]=v
end
return saveSortCondition
end

function xianmengdigongModel:saveGLData(time,name)
local glData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'glData',{})
glData[1]=time
glData[2]=name
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengDiGong,'glData',glData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengDiGong)
end

function xianmengdigongModel:getGLData()
local glData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengDiGong,'glData',nil)
return glData
end

function xianmengdigongModel:is_in_xmdgModel()
return self.isModel==true
end

function xianmengdigongModel:set_xmdgModel(v)
self.isModel=v
end

local roomIconNameLookup={}
local roomBIconNameLookup={}
local hengliangIconNameLookup={}
local zhuziIconNameLookup={}
function xianmengdigongModel:getRoomIconName(skinID)
local icon=roomIconNameLookup[skinID]
if icon==nil then
icon=FMT.fmt('xmdgroom_{0}',skinID)
roomIconNameLookup[skinID]=icon
end
return icon
end
function xianmengdigongModel:getRoomBIconName(skinID)
local f=roomBIconNameLookup[skinID]
if f==nil then
local abname=FMT.fmt('ui/windows/xianmeng/act_xianmengdigong/sharedtextures/xmdgroom_b_{0}.ab',skinID)
local icon=FMT.fmt('xmdgroom_b_{0}',skinID)
f={abname,icon}
roomBIconNameLookup[skinID]=f
end
return f[1],f[2]
end
function xianmengdigongModel:getHLIconName(skinID)
local icon=hengliangIconNameLookup[skinID]
if icon==nil then
icon=FMT.fmt('hengliang_{0}',skinID)
hengliangIconNameLookup[skinID]=icon
end
return globalABLookup.xmdgzsicons,icon
end
function xianmengdigongModel:getZZIconName(skinID)
local icon=zhuziIconNameLookup[skinID]
if icon==nil then
icon=FMT.fmt('zhuzi_{0}',skinID)
zhuziIconNameLookup[skinID]=icon
end
return globalABLookup.xmdgzsicons,icon
end




function xianmengdigongModel:initSpeRoomData(roomData)
local eventLookup={}
local eventList=roomData.eventList or{}
local eventNum=#eventList
if eventNum>0 then


for i2,event in ipairs(eventList)do
xianmengdigongModel:initEvent(event)
local pos



event:initPos(pos)
eventLookup[event.eventPos]=event
end
else
local eventid=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'zytsEvent')
local event={}
event.eventPos=1
event.eventId=eventid
event.myRewardFlag=0
event.speed=1
event.startTime=0
xianmengdigongModel:initEvent(event)
event:initPos()
eventLookup[event.eventPos]=event
eventNum=1
table.insert(eventList,event)
end

roomData.eventList=eventList
roomData.eventNum=eventNum
roomData.eventLookup=eventLookup

roomData.getEvent=function(self_,eventPos)
return self_.eventLookup[eventPos]
end


local base={x=roomData.x,y=roomData.y,w=0,h=0,}
base.id=self:getID(base.x,base.y)
base.round={}
base.checkInRound=function(self_,id)
return self_.round[id]==true
end
roomData.base=base
xianmengdigongModel:initRoom(roomData)

self.data.zytsRoomData=roomData
end

function xianmengdigongModel:getSpeRoomData()
return self.data.zytsRoomData
end

function xianmengdigongModel:isSpeRoom(x,y)
return x==32767 and y==32767
end

function xianmengdigongModel:initSpeEvent(event)
local eventid=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'zytsEvent')
event.eventPos=1
event.eventId=eventid
event.myRewardFlag=0
event.speed=1
event.startTime=0
event.dzList={}
xianmengdigongModel:initEvent(event)
event:initPos()
end


function xianmengdigongModel:setSkipMonFightState(nandu,skip)
if not self.skipMonFightState then self.skipMonFightState={}end
self.skipMonFightState[nandu]=skip
end

function xianmengdigongModel:isSkipMonFight(nandu)
if not self.skipMonFightState then return false end
return self.skipMonFightState[nandu]==true
end


function xianmengdigongModel:setSkipFightState(skip)
self.skipFightState=skip
end

function xianmengdigongModel:isSkipFight()
return self.skipFightState==true
end

function xianmengdigongModel:setFastResultData(Data)
self.data.fstResultData=Data
end
function xianmengdigongModel:getFastResultData()
return self.data.fstResultData
end


function xianmengdigongModel:find_lastbossroom()
local roomcfg=cfg_guilddigongroomconfig()
local roomid={}
for k,v in pairs(roomcfg)do
if v.lastBaoKu then
roomid[#roomid+1]=v.id
end
end

return roomid
end

function xianmengdigongModel:jude_lastKillBoss()
local roomid=xianmengdigongModel:find_lastbossroom()

if next(roomid)then
local flag=xianmengdigongModel:checkRoomUnlock(roomid)
return flag
end
return false
end


function xianmengdigongModel:is_Showtips()

local flag=xianmengdigongModel:jude_lastKillBoss()
if xianmengdigongModel:GetFlag()==1 then
flag=true
end
return flag
end


function xianmengdigongModel:setLockRoomData(startTimeLock,secondsLock)
self.startTimeLock=startTimeLock
self.secondsLock=secondsLock
end

function xianmengdigongModel:getLockRoomData()
return self.startTimeLock,self.secondsLock
end

function xianmengdigongModel:getLockRoomHourMin()
if self.startTimeLock and self.startTimeLock>0 and self.secondsLock and self.secondsLock>0 then
local startLongStamp=timeHelper.convertLongStamp(self.startTimeLock)
local _,_,_,s_h,s_m=timeHelper.getDateNumber(startLongStamp)
local endLongStamp=startLongStamp+self.secondsLock
local _,_,_,e_h,e_m=timeHelper.getDateNumber(endLongStamp)
return s_h,s_m,e_h,e_m
end
return-1,-1,-1,-1
end

function xianmengdigongModel:checkIsInLockRoomTime()
if self.startTimeLock and self.startTimeLock>0 and self.secondsLock and self.secondsLock>0 then
local longStamp=timeHelper.convertLongStamp(self.startTimeLock)
local _,_,_,s_h,s_m=timeHelper.getDateNumber(longStamp)
local startStamp=timeHelper.getTodayXXStamp(s_h,s_m,0)
local endStamp=startStamp+self.secondsLock
local now=gameUtilityModel.getServerLongTime()
return now>=startStamp and now<=endStamp
end
return true
end

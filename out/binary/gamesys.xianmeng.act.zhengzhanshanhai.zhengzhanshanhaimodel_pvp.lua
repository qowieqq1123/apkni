







zhengzhanshanhaiModel.maxLingLi=100
zhengzhanshanhaiModel.pvpFigthtInterval=10
local selectTeamRefreshTime=30
local pvpAttackDataRefreshTime=10

function zhengzhanshanhaiModel:clearPvPData()
self.m_zrData=nil
self.selectTeamTime=nil
self.otherTeamLookup=nil
self.otherTeamTimeLookup=nil
self.pvpOrderLookup=nil
self.pvpOrder_timeOut=nil
self.joinFightFlag=nil
self.pvpAutoRever=nil
self.pvpMainOpenTeamFlag=nil
self.pvpTargetsLookup=nil
self.pvpTargetsLookup_timeOut=nil
self.pvpAttackDataLookup=nil

self.balanceData=nil
end

function zhengzhanshanhaiModel:setJoinFightFlag(flag)
self.joinFightFlag=flag
end

function zhengzhanshanhaiModel:checkJoinFightFlag()
return self.joinFightFlag==1
end

function zhengzhanshanhaiModel:setPvPAutoReverFlag(flag)
self.pvpAutoRever=flag
end

function zhengzhanshanhaiModel:checkPvPAutoReverFlag()
return self.pvpAutoRever==1
end

function zhengzhanshanhaiModel:setpvpMainOpenTeamFlag(flag)
self.pvpMainOpenTeamFlag=flag
end

function zhengzhanshanhaiModel:checkpvpMainOpenTeamFlag()
return self.pvpMainOpenTeamFlag==nil or self.pvpMainOpenTeamFlag==true
end




function zhengzhanshanhaiModel:checkOpenSelectTeamWin(flag,extraParams,isNew)
local needRefresh=false
if self.selectTeamTime==nil or gameUtilityModel.getServerShortTime()-self.selectTeamTime>=selectTeamRefreshTime then
needRefresh=true
end
if isNew or needRefresh then
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid then
zhengzhanshanhaiController:reqPvPTeam(my_guildid)
zhengzhanshanhaiController:setOpenSelectTeamMark({flag,extraParams})
end
else
zhengzhanshanhaiController:openSelectTeamWin({flag,extraParams})
end
end

function zhengzhanshanhaiModel:handleZRData(args)
local zrData={}
zrData.guildid=args[1]
zrData.guildid_str=tostring(args[1])

local ownerLookup={}
if args[2]>0 then
for i,v in ipairs(args[3])do
local actorid_str=tostring(v.actorid)
v.getOutlineStr=function(self_)
if self_.online>0 then
local curTime=gameUtilityModel.getServerShortTime()
local lerp=curTime-self_.online
if lerp>=timeSecLook.eTwoWeekSec then
return'14天未登陆'
elseif lerp>=timeSecLook.eSevenDaySec then
return'7天未登陆'
end
end
return nil
end

v.checkWillLost=function(self_)
if self_.online>0 then
local curTime=gameUtilityModel.getServerShortTime()
local lerp=curTime-self_.online
if lerp>=timeSecLook.eSevenDaySec then
return true
end
end
return false
end
v.checkSupport=function(self_)
return self_.support==1
end
v.getSignIcon=function(self_)
local signab,signIcon
if self_:checkSupport()then
signab=globalABLookup.zzshicons
signIcon='image_shyuan_1'
elseif playerModel:checkActorId(self_.actorid)then
signab=globalABLookup.global
signIcon='image_ziji_1'
end
return signab,signIcon
end
ownerLookup[actorid_str]=v
end
end
zrData.ownerLookup=ownerLookup

local detailLookup={}
if args[4]>0 then
for i,v in ipairs(args[5])do
local teamguid_str=tostring(v.teamguid)
local n=string.len(teamguid_str)
local actorid_str=string.sub(teamguid_str,1,n-1)
local idx_str=string.sub(teamguid_str,n,n)
local actorid=int64.new(actorid_str)
local idx=tonumber(idx_str)
v.actorid=actorid
v.ismy=playerModel:checkActorId(actorid)
v.idx=idx
v.actorid_str=actorid_str
v.teamguid_str=teamguid_str
v.teamfight_num=mathHelper.int64_to_number(v.teamfight)
v.actorData=ownerLookup[actorid_str]
local showDZ
local changeDZ=false
for i2,v2 in ipairs(v.discipleList)do
if v2.flag>0 then
if showDZ==nil or v2.jingjielv>showDZ.jingjielv then
showDZ=v2
end
else

if v.ismy then
local netData=zhengzhanshanhaiModel:getInDefTeamDZ(idx,i2)
if netData then
changeDZ=true
v2.flag=1
v2.discipleguid=netData.discipleguid
v2.disciplename=netData.disciplename
v2.discipledata=netData.discipledata
v2.discipleimage=netData.discipleimage
v2.jingjielv=netData.jingjielv
if showDZ==nil or v2.jingjielv>showDZ.jingjielv then
showDZ=v2
end
end
end
end
end
v.showDZ=showDZ

if v.ismy and(changeDZ or v.teamfight_num==0)then
local f=0
for i2,v2 in ipairs(v.discipleList)do
if v2.flag>0 then
local f_=UIDiscipleModel:getDiscipleFightValue(v2.discipleguid)
f=f+f_
end
end
v.teamfight_num=f
v.teamfight=int64.new(tostring(f))
end
v.getReverCost=function(self_)
local lerp=zhengzhanshanhaiModel.maxLingLi-self_.power
if lerp>0 then
return zhengzhanshanhaiModel:getReverLingLiCost(self_.teamfight_num,lerp)
else
return 0
end
end
detailLookup[teamguid_str]=v
end
end
zrData.detailLookup=detailLookup

local teamLookup={}
local allTamsLookup={}
if args[6]>0 then
for i,v in ipairs(args[7])do
local teamtype=v.teamtype
if teamLookup[teamtype]==nil then
teamLookup[teamtype]={}
end
if v.teamlistlen>0 then
for i2,v2 in ipairs(v.teamList)do
local teamguid_str=tostring(v2)
if detailLookup[teamguid_str]then
local d={}
d.teamguid=v2
d.teamguid_str=teamguid_str
d.teamtype=teamtype
table.insert(teamLookup[teamtype],d)
allTamsLookup[teamguid_str]=d
end
end
end
end
end
zrData.teamLookup=teamLookup
zrData.allTamsLookup=allTamsLookup
zrData.lock=args[8]
zrData.refreshTeamLookup=function(self_,teamlistlen,teamList)
local isChanged=false
if teamlistlen>0 then
for i,v in ipairs(teamList)do
local teamtype=v.teamtype
if self_.teamLookup[teamtype]==nil then
self_.teamLookup[teamtype]={}
else
local n=#self_.teamLookup[teamtype]
for i2=n,1,-1 do
local d=self_.teamLookup[teamtype][i2]
self_.teamLookup[teamtype][i2]=nil
if d then
self_.allTamsLookup[d.teamguid_str]=nil
end
end
end
if v.teamlistlen>0 then
for i2,v2 in ipairs(v.teamList)do
local teamguid_str=tostring(v2)
if self_.detailLookup[teamguid_str]then
local d={}
d.teamguid=v2
d.teamguid_str=teamguid_str
d.teamtype=teamtype
table.insert(self_.teamLookup[teamtype],d)
self_.allTamsLookup[teamguid_str]=d
else
isChanged=true
end
end
end
end
end
return isChanged
end
zrData.checkWillLost=function(self_)
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for i=0,max do
if self_.teamLookup[i]then
for i2,v2 in ipairs(self_.teamLookup[i])do
local team=self_.detailLookup[v2.teamguid_str]
if team then
local actorData=team.actorData
if actorData then
if actorData:checkWillLost()then
return true
end
end
end
end
end
end
return false
end
zrData.getShowDZ=function(self_,teamtype)
if self_.teamLookup[teamtype]then
if#self_.teamLookup[teamtype]>0 then
return self_.teamLookup[teamtype][1].showDZ
end
end
end
zrData.getAtkTeamNum=function(self_)
local num=0
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for i=1,max do
if self_.teamLookup[i]then
num=num+#self_.teamLookup[i]
end
end
return num
end
zrData.getAtkTeamNumEx=function(self_,teamtype)
if self_.teamLookup[teamtype]then
return#self_.teamLookup[teamtype]
end
return 0
end
zrData.getDefTeamNum=function(self_)
if self_.teamLookup[0]then
return#self_.teamLookup[0]
end
return 0
end
zrData.checkSelected=function(self_,teamguid_str)
return self_.allTamsLookup[teamguid_str]~=nil
end
zrData.getSelected=function(self_,teamguid_str)
return self_.allTamsLookup[teamguid_str]
end
zrData.getReverCost=function(self_,teamtype,flag)
local num=0
local list=nil
if flag then
list={}
end
if self_.teamLookup[teamtype]then
for i,d in ipairs(self_.teamLookup[teamtype])do
local data=self_.detailLookup[d.teamguid_str]
if data then
local n=data:getReverCost()
if n>0 then
num=num+n
if flag then
table.insert(list,d.teamguid)
end
end
end
end
end
return num,list
end
zrData.needSort=function(self_,teamtype)
local temp=self_.teamLookup[teamtype]
if temp then
local n=#temp
if n>1 then
local lp=self_.detailLookup
for i=1,n-1 do
local f1=lp[temp[i].teamguid_str].teamfight_num
for j=i+1,n do
local f2=lp[temp[j].teamguid_str].teamfight_num
if f1<f2 then
return true
end
end
end
end
end
return false
end
zrData.getInsertIndex=function(self_,teamtype,teamfight_num)
if self_.teamLookup[teamtype]then
for i,d in ipairs(self_.teamLookup[teamtype])do
local data=self_.detailLookup[d.teamguid_str]
if teamfight_num>data.teamfight_num then
return i
end
end
end

return 0
end
return zrData
end

function zhengzhanshanhaiModel:initMyPvPZhenRong(args)
self.m_zrData=zhengzhanshanhaiModel:handleZRData(args)
self.selectTeamTime=gameUtilityModel.getServerShortTime()
end

function zhengzhanshanhaiModel:setMyPvPZhenRongDirty()
self.selectTeamTime=nil
end

function zhengzhanshanhaiModel:getMyPvPZhenRong()
return self.m_zrData
end

function zhengzhanshanhaiModel:setMyPvPZhenRongLock(lock)
if self.m_zrData then
self.m_zrData.lock=lock
end
end

function zhengzhanshanhaiModel:checkMyPvPZhenRongLock()
if self.m_zrData then
return self.m_zrData.lock==1
end
end

function zhengzhanshanhaiModel:changeMyPvPZhenRong(teamguid,teamtype,teamidx)
local isChanged=false
local needRefresh=false
local zrData=self.m_zrData
if zrData then
local teamguid_str=tostring(teamguid)
if teamidx==-1 then

if zrData.allTamsLookup[teamguid_str]~=nil then
isChanged=true
zrData.allTamsLookup[teamguid_str]=nil
local f=nil
if zrData.teamLookup[teamtype]then
for i,d in ipairs(zrData.teamLookup[teamtype])do
if d.teamguid_str==teamguid_str then
f=i
break
end
end
end
if f then
table.remove(zrData.teamLookup[teamtype],f)
else
needRefresh=true
end
else
needRefresh=true
end
elseif teamidx>0 then
isChanged=true
local d_=zrData.allTamsLookup[teamguid_str]
if d_ then

local num=#zrData.teamLookup[teamtype]
local num2=num
local f=nil
if zrData.teamLookup[d_.teamtype]then
for i,d in ipairs(zrData.teamLookup[d_.teamtype])do
if d.teamguid_str==teamguid_str then
f=i
break
end
end
end
if f then
table.remove(zrData.teamLookup[d_.teamtype],f)
num2=num2-1
else
needRefresh=true
end
if teamidx>num then
table.insert(zrData.teamLookup[teamtype],d_)
if teamidx>num+1 then
needRefresh=true
end
else
if teamidx>num2 then
table.insert(zrData.teamLookup[teamtype],d_)
else
table.insert(zrData.teamLookup[teamtype],teamidx,d_)
end
end
else

if zrData.teamLookup[teamtype]==nil then
zrData.teamLookup[teamtype]={}
end
local d={}
d.teamguid=teamguid
d.teamguid_str=teamguid_str
d.teamtype=teamtype
local num=#zrData.teamLookup[teamtype]
if teamidx>num then
table.insert(zrData.teamLookup[teamtype],d)
if teamidx>num+1 then
needRefresh=true
end
else
table.insert(zrData.teamLookup[teamtype],teamidx,d)
end
zrData.allTamsLookup[teamguid_str]=d
end
end
end
return isChanged,needRefresh
end

function zhengzhanshanhaiModel:changeMyPvPZhenRong2(teamtype,guidlistlen,guidList)
local isChanged=false
local needRefresh=false
local zrData=self.m_zrData
if zrData then
if zrData.teamLookup[teamtype]then
isChanged=true
local oldnum=#zrData.teamLookup[teamtype]
local temp={}
if guidlistlen>0 then
for i,v in ipairs(guidList)do
local teamguid_str=tostring(v)
local d=zrData.allTamsLookup[teamguid_str]
if d then
table.insert(temp,d)
else
needRefresh=true
end
end
end
zrData.teamLookup[teamtype]=temp
if oldnum~=guidlistlen then
needRefresh=true
end
else
needRefresh=true
end
end
return isChanged,needRefresh
end

function zhengzhanshanhaiModel:setMyPvPZhenRongLingLi(lp)
if self.m_zrData then
local lp2=self.m_zrData.detailLookup
for teamguid_str,v in pairs(lp)do
if lp2[teamguid_str]then
lp2[teamguid_str].power=zhengzhanshanhaiModel.maxLingLi
end
end
end
end






function zhengzhanshanhaiModel:checkOpenOtherTeamWin(guildid,flag,teamtype)
local needRefresh=false





local guildid_str=tostring(guildid)
if self.otherTeamTimeLookup==nil or self.otherTeamTimeLookup[guildid_str]==nil
or gameUtilityModel.getServerShortTime()-self.otherTeamTimeLookup[guildid_str]>=selectTeamRefreshTime then
needRefresh=true
end
if needRefresh then
zhengzhanshanhaiController:reqPvPTeam(guildid)
zhengzhanshanhaiController:setOpenOtherTeamMark({guildid,flag,teamtype})
else
zhengzhanshanhaiController:openOtherTeamWin({guildid,flag,teamtype})
end
end

function zhengzhanshanhaiModel:initOtherPvPZhenRong(args)
local zrData=zhengzhanshanhaiModel:handleZRData(args)
if self.otherTeamLookup==nil then
self.otherTeamLookup={}
end
self.otherTeamLookup[zrData.guildid_str]=zrData
if self.otherTeamTimeLookup==nil then
self.otherTeamTimeLookup={}
end
self.otherTeamTimeLookup[zrData.guildid_str]=gameUtilityModel.getServerShortTime()
end

function zhengzhanshanhaiModel:getOtherPvPZhenRong(guildid)
if self.otherTeamLookup then
local guildid_str=tostring(guildid)
return self.otherTeamLookup[guildid_str]
end
end





function zhengzhanshanhaiModel:handlePvPOrder(teamtype,v,n)
local d={teamtype=teamtype}
d.refreshData=function(self_,v,n)
if n>0 then
self_.guildid=v.param_2
self_.guildid_str=tostring(v.param_2)
self_.domainid=nil
self_.targetid_str=self_.guildid_str
else
self_.guildid=nil
self_.domainid=-n
self_.targetid_str=tostring(n)
end
end
d.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end

d:refreshData(v,n)

d.getTargetPos=function(self_)
if self_.guildid then
local xmData=zhengzhanshanhaiModel:getXMData(self_.guildid)
if xmData~=nil then
return xmData.x,xmData.y
end
elseif self_.domainid then
return zhengzhanshanhaiModel:getLingDiGridPos(self_.domainid)
end
return nil,nil
end
d.getpvpTargetData=function(self_)
return zhengzhanshanhaiModel:getpvpTargetData(self_.targetid_str)
end
d.valid=function(self_,isWarning)
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x==nil then





return false
end
if self_.guildid then
local xmData=zhengzhanshanhaiModel:getXMData(self_.guildid)
if xmData==nil then





return false
end
elseif self_.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(self_.domainid)
if cfg==nil then





return false
end
else





return false
end
return true
end
return d
end

function zhengzhanshanhaiModel:initPvPOrderData(len,orderList)
local pvpOrderLookup=self.pvpOrderLookup
local isInit=false
if pvpOrderLookup==nil or self.pvpOrder_timeOut==true then
pvpOrderLookup={}
self.pvpOrderLookup=pvpOrderLookup
self.pvpOrder_timeOut=nil
isInit=true
end
if len>0 then
if isInit then
for i,v in ipairs(orderList)do
local teamtype=v.param_1
local n=mathHelper.int64_to_number(v.param_2)
if n~=0 then
local d=zhengzhanshanhaiModel:handlePvPOrder(teamtype,v,n)
pvpOrderLookup[teamtype]=d
else



end
end
UIManager:invokeUIMethod('UIXM_ZZSH_PvPMainWin','rec_myWaiPiaList')
else
for i,v in ipairs(orderList)do
local teamtype=v.param_1
local n=mathHelper.int64_to_number(v.param_2)
if n==0 then
local d=pvpOrderLookup[teamtype]
if d~=nil then
pvpOrderLookup[teamtype]=nil
notifySystem:postNotify(notifyConfig.onZZSHOrderChange,zhengzhanshanhaiModel.opType.eDel,d)
else



end
else
local d=pvpOrderLookup[teamtype]
if d==nil then
d=zhengzhanshanhaiModel:handlePvPOrder(teamtype,v,n)
pvpOrderLookup[teamtype]=d
notifySystem:postNotify(notifyConfig.onZZSHOrderChange,zhengzhanshanhaiModel.opType.eAdd,d)
else
d:refreshData(v,n)
notifySystem:postNotify(notifyConfig.onZZSHOrderChange,zhengzhanshanhaiModel.opType.eRefresh,d)
end
end
end
end
end
end

function zhengzhanshanhaiModel:timeOutPvPOrder()
self.pvpOrder_timeOut=true
end

function zhengzhanshanhaiModel:getAllPvPOrder(check)
if check then
if not self.pvpOrder_timeOut then
return self.pvpOrderLookup
end
else
return self.pvpOrderLookup
end
end

function zhengzhanshanhaiModel:checkHasOrder(guildid,domainid)
if guildid==nil and domainid==nil then
return nil
end
if self.pvpOrderLookup then
for teamtype,order in pairs(self.pvpOrderLookup)do
if guildid~=nil then
if mathHelper.compareInt64(guildid,order.guildid)then
return teamtype
end
elseif domainid~=nil then
if domainid==order.domainid then
return teamtype
end
end
end
end
return nil
end

function zhengzhanshanhaiModel:checkHasOrder2(guildid,domainid)
if guildid==nil and domainid==nil then
return nil
end
if self.pvpOrderLookup then
for teamtype,order in pairs(self.pvpOrderLookup)do
if guildid~=nil then
if mathHelper.compareInt64(guildid,order.guildid)then
return order
end
elseif domainid~=nil then
if domainid==order.domainid then
return order
end
end
end
end
return nil
end


function zhengzhanshanhaiModel:getOrderNum(typo)
local num=0
if self.pvpOrderLookup then
for teamtype,order in pairs(self.pvpOrderLookup)do
if typo==1 then
if order.guildid~=nil then
num=num+1
end
elseif typo==2 then
if order.domainid~=nil then
num=num+1
end
else
num=num+1
end
end
end
return num
end

function zhengzhanshanhaiModel:hasPvPOrder()
if self.pvpOrderLookup then
if next(self.pvpOrderLookup)then
return true
end
end
return false
end

function zhengzhanshanhaiModel:getOrder(teamtype)
if self.pvpOrderLookup then
return self.pvpOrderLookup[teamtype]
end
return nil
end

function zhengzhanshanhaiModel:clearpvpOrder()
self.pvpOrderLookup={}
end

function zhengzhanshanhaiModel:checkpvpOrderInit()
if zhengzhanshanhaiModel:getAllPvPOrder(true)~=nil then
return true
end
return false
end

function zhengzhanshanhaiModel:checkPvPOrder(guildid,domainid,isWarning)
local e_x,e_y,xmData
if guildid then
local flag=zhengzhanshanhaiModel:checkJoinFightFlag()
if not flag then
if isWarning then
UIManager.error('已放弃争夺，无法攻击其他盟')
end
return false
end
local xmData_=zhengzhanshanhaiModel:getXMData(guildid)
if xmData_~=nil then
xmData=xmData_
e_x=xmData.x
e_y=xmData.y
end
elseif domainid then
local flag=zhengzhanshanhaiModel:checkJoinFightFlag()
if not flag then
if isWarning then
UIManager.error('已放弃争夺，无法占领洞天福地')
end
return false
end
e_x,e_y=zhengzhanshanhaiModel:getLingDiGridPos(domainid)





end
if e_x then
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
local radius=zhengzhanshanhaiModel:getAttackRadius()
if not mathHelper.isInRadius(g_x,g_y,e_x,e_y,radius)then
if isWarning then
UIManager.error('目标不在堡垒攻击范围内')
end
return false
end
end
if xmData then
if xmData:checkFigthSign()then
if isWarning then
UIManager.error('该仙盟已放弃争夺，无法被攻击')
end
return false
end
end
return true
end





function zhengzhanshanhaiModel:handlePvPTargetData(targetData,stime,etime)
targetData.stime=stime
targetData.etime=etime
local team1={}
local teams2={}
targetData.teams2=teams2
targetData.team1=team1
targetData.findPreOne=function(self_,idx)
if idx>1 then
for i=idx-1,1,-1 do
local pvpTeamData=self_.teams2[i]
if pvpTeamData and pvpTeamData:valid()then
return pvpTeamData
end
end
end
end
if targetData.len>0 then

for i=1,targetData.len do
local pvpTeamData=zhengzhanshanhaiModel:handlePvPTeamData(targetData,i)
teams2[i]=pvpTeamData
local guildid_str=pvpTeamData.guildid_str
if team1[guildid_str]==nil then
team1[guildid_str]={}
end
team1[guildid_str][pvpTeamData.teamtype]=pvpTeamData
end
end
targetData.refreshData=function(self_,d)
local old=self_.attackidx
self_.attackidx=d.attackidx
local old_=self_.attackidx-1

local temp=self_.teams2[old_]
if temp then
if d.ret~=0 then
temp.ret=d.ret
end
end

for i=old,old_ do
local pvpTeamData=self_.teams2[i]
if pvpTeamData and pvpTeamData:valid()then
local cur=gameUtilityModel.getServerLongTime()
local lerp=cur-pvpTeamData.beginTime
if lerp>0 then
pvpTeamData.beginTime=pvpTeamData.beginTime+lerp
pvpTeamData.endTime=pvpTeamData.endTime+lerp
for i2=i+1,self_.len do
local pvpTeamData_=self_.teams2[i2]
if pvpTeamData_ and pvpTeamData_:valid()then
local pre=self_:findPreOne(i2)
if pre then
local lerp_=pvpTeamData_.beginTime-pre.endTime
if lerp_<0 then
lerp_=-lerp_
pvpTeamData_.beginTime=pvpTeamData_.beginTime+lerp_
pvpTeamData_.endTime=pvpTeamData_.endTime+lerp_
else
break
end
else
break
end
end
end
end

break
end
end
end
targetData.getPvPTeam=function(self_,idx)
return self_.teams2[idx]
end
targetData.getPvPTeam2=function(self_,guildid_str,teamtype)
if self_.team1[guildid_str]then
return self_.team1[guildid_str][teamtype]
end
return nil
end
targetData.checkXM=function(self_,guildid_str)
return self_.team1[guildid_str]~=nil
end
targetData.checkInFight=function(self_)
if self_.len>0 then
for i,teamData in ipairs(self_.teams2)do
if teamData:valid()then
local state=zhengzhanshanhaiModel:getPvPTeamState(teamData)
if state==3 then
return true,i
end
end
end
end
return false,nil
end
targetData.checkInStandby=function(self_)
if self_.len>0 then
for i,teamData in ipairs(self_.teams2)do
if teamData:valid()then

local state=zhengzhanshanhaiModel:getPvPTeamState(teamData)
if state<=2 then
return true,i
end
end
end
end
return false,nil
end
targetData.getShowIndex=function(self_)
if self_.len>0 then
for i,teamData in ipairs(self_.teams2)do
if teamData:valid()then

local state=zhengzhanshanhaiModel:getPvPTeamState(teamData)
if state==3 then
return i
elseif state<3 then
if i>1 then
return i-1
else
return nil
end
end
end
end
return self_.len
end
return nil
end
targetData.findWinner=function(self_)
if self_.len>0 then
local winner=nil
for i,teamData in ipairs(self_.teams2)do
if teamData:valid()then

local state=zhengzhanshanhaiModel:getPvPTeamState(teamData)
if state==4 then
if teamData.ret==1 then
winner=teamData.guildid
end
else
break
end
end
end
return winner
end
return nil
end
end

function zhengzhanshanhaiModel:initPvPTargetsData(len,targetList)

local temp={}
if len>0 then
for i,v in ipairs(targetList)do
local n=mathHelper.int64_to_number(v.targetid)
if n>0 then
local guildid=v.targetid
local xmData=zhengzhanshanhaiModel:getXMData(guildid)
if xmData then
v.guildid=guildid
v.guildid_str=tostring(guildid)
v.domainid=nil
v.targetid_str=tostring(v.targetid)
table.insert(temp,v)
else



end
else
local domainid=-n
local cfg=zhengzhanshanhaiModel:getLingDiCfg(domainid)
if cfg then
v.guildid=nil
v.domainid=domainid
v.targetid_str=tostring(v.targetid)
table.insert(temp,v)
else



end
end
end
end
local pvpTargetsLookup=self.pvpTargetsLookup
local isInit=false
if pvpTargetsLookup==nil or self.pvpTargetsLookup_timeOut==true then
pvpTargetsLookup={}
self.pvpTargetsLookup=pvpTargetsLookup
self.pvpTargetsLookup_timeOut=nil
isInit=true
end

if#temp>0 then
local stime,etime=zhengzhanshanhaiModel:getPvPFightTime()
if isInit then
for i,v in ipairs(temp)do
zhengzhanshanhaiModel:handlePvPTargetData(v,stime,etime)
pvpTargetsLookup[v.targetid_str]=v
end
notifySystem:postNotify(notifyConfig.onZZSHPvPTargetChange,zhengzhanshanhaiModel.opType.eInit)
else
for i,v in ipairs(temp)do
local d=pvpTargetsLookup[v.targetid_str]
if d==nil then

zhengzhanshanhaiModel:handlePvPTargetData(v,stime,etime)
pvpTargetsLookup[v.targetid_str]=v
notifySystem:postNotify(notifyConfig.onZZSHPvPTargetChange,zhengzhanshanhaiModel.opType.eAdd,v)
else

local old_idx=d.attackidx
local new_idx=v.attackidx
if old_idx~=new_idx then
if new_idx>old_idx then





d:refreshData(v)
notifySystem:postNotify(notifyConfig.onZZSHPvPTargetChange,zhengzhanshanhaiModel.opType.eRefresh,d,old_idx,new_idx)
else



end
else



end
end
end
end
end
end

function zhengzhanshanhaiModel:timeOutPvPTargets()
self.pvpTargetsLookup_timeOut=true
end

function zhengzhanshanhaiModel:getpvpTargetsLookup()
return self.pvpTargetsLookup
end

function zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if self.pvpTargetsLookup then
return self.pvpTargetsLookup[targetid_str]
end
end

function zhengzhanshanhaiModel:clearpvpTargetData()
self.pvpTargetsLookup={}
end

function zhengzhanshanhaiModel:jumpPvPTarget(targetData)
if targetData==nil then return end
if targetData.guildid then
local xmData=zhengzhanshanhaiModel:getXMData(targetData.guildid)
if xmData~=nil then
local e_x=xmData.x
local e_y=xmData.y
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',e_x,e_y,0,false,0,function()
zhengzhanshanhaiController:openXMDetailInfoWin(targetData.guildid)
end)
end
elseif targetData.domainid then
local ldData=zhengzhanshanhaiModel:getLDData(targetData.domainid)
if ldData~=nil then
local e_x,e_y=zhengzhanshanhaiModel:getLingDiGridPos(targetData.domainid)
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',e_x,e_y,0,false,0,function()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=targetData.domainid})
end)
end
end
end





function zhengzhanshanhaiModel:handlePvPTeamData(targetData,idx)
local pvpTeamData={}
pvpTeamData.parent=targetData
pvpTeamData.stime=targetData.stime
pvpTeamData.etime=targetData.etime
pvpTeamData.targetid=targetData.targetid
pvpTeamData.targetid_str=targetData.targetid_str
pvpTeamData.targetguildid=targetData.guildid
pvpTeamData.targetguildid_str=targetData.guildid_str
pvpTeamData.targetdomainid=targetData.domainid
pvpTeamData.idx=idx
local team=targetData.list[idx]
pvpTeamData.guildid=team.param_1
pvpTeamData.guildid_str=tostring(team.param_1)
pvpTeamData.teamNum=team.param_2
pvpTeamData.ret=team.param_3


pvpTeamData.teamtype=team.param_4 or 1

local wayTime=0
local arriveTime
local isValid
local beginTime
local endTime
local g_x,g_y,l_x,l_y,e_x,e_y,l_e_x,l_e_y
local xmData=zhengzhanshanhaiModel:getXMData(pvpTeamData.guildid)
if xmData then
g_x=xmData.x
g_y=xmData.y
l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
end
if pvpTeamData.targetguildid then
xmData=zhengzhanshanhaiModel:getXMData(pvpTeamData.targetguildid)
if xmData~=nil then
e_x=xmData.x
e_y=xmData.y
l_e_x,l_e_y=zhengzhanshanhaiModel:gridPos2localPos(e_x,e_y)
end
elseif pvpTeamData.targetdomainid then
e_x,e_y=zhengzhanshanhaiModel:getLingDiGridPos(pvpTeamData.targetdomainid)
if e_x then
l_e_x,l_e_y=zhengzhanshanhaiModel:gridPos2localPos(e_x,e_y)
end
end
isValid=pvpTeamData.stime~=nil and g_x~=nil and e_x~=nil
if isValid then
wayTime=zhengzhanshanhaiModel:calculateWayTime_pvp(g_x,g_y,e_x,e_y)
arriveTime=pvpTeamData.stime+wayTime
local lerp=0
local pre=targetData:findPreOne(idx)
if pre then
local lerp_=arriveTime-pre.endTime
if lerp_<0 then
lerp=-lerp_
end
end
beginTime=arriveTime+lerp
endTime=beginTime+zhengzhanshanhaiModel.pvpFigthtInterval
end
pvpTeamData.g_x=g_x
pvpTeamData.g_y=g_y
pvpTeamData.l_x=l_x
pvpTeamData.l_y=l_y
pvpTeamData.e_x=e_x
pvpTeamData.e_y=e_y
pvpTeamData.l_e_x=l_e_x
pvpTeamData.l_e_y=l_e_y
pvpTeamData.wayTime=wayTime
pvpTeamData.arriveTime=arriveTime
pvpTeamData.beginTime=beginTime
pvpTeamData.endTime=endTime
pvpTeamData.isValid=isValid
pvpTeamData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end
pvpTeamData.valid=function(self_)
return self_.isValid
end
pvpTeamData.getCurLocalPos=function(self_)
if not self_.isValid then
return 0,0,0,0,0
end

local dis,dx,dy=mathHelper.distanceEx(self_.l_x,self_.l_y,self_.l_e_x,self_.l_e_y)
if dis==0 then
return self_.l_e_x,self_.l_e_y,dis,0,0
end

local ux=dx/dis
local uy=dy/dis

local wayT=self_.wayTime
local cur=gameUtilityModel.getServerLongTime()
local costT
if cur>=self_.arriveTime then
costT=wayT
else
if cur>=self_.stime then
costT=cur-self_.stime
else
costT=0
end
end
local rate=costT/wayT
local lerp_time=wayT-costT
local move=dis*rate
local lerp_move=dis-move

local m_l_x=self_.l_x+move*ux
local m_l_y=self_.l_y+move*uy
return m_l_x,m_l_y,move,lerp_move,lerp_time
end
pvpTeamData.isMyXMTeam=function(self_)
local isMyXM=self_.isMyXM
if isMyXM==nil then
isMyXM=xianmengModel:isMyXM(self_.guildid)
end
return isMyXM==true
end
return pvpTeamData
end

function zhengzhanshanhaiModel:checkPvPTeamShowEntity(pvpTeamData)
local state=zhengzhanshanhaiModel:getPvPTeamState(pvpTeamData)
return state<=3
end

function zhengzhanshanhaiModel:getPvPTeam(targetid_str,idx)
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
return targetData:getPvPTeam(idx)
end
end


function zhengzhanshanhaiModel:getPvPTeamState(pvpTeamData,isName,isColor)
local state,name,time
local cur=gameUtilityModel.getServerLongTime()
if cur<pvpTeamData.arriveTime then
state=1
time=pvpTeamData.arriveTime-cur
if isName then
name='前往中'
if isColor then
name=toColorStringX('#549327',name)
end
end
else
local targetData=pvpTeamData.parent
if targetData.attackidx<pvpTeamData.idx then
state=2
if isName then
name='待战中'
if isColor then
name=toColorStringX('#65615f',name)
end
end
elseif targetData.attackidx==pvpTeamData.idx then
state=3
if isName then
name='战斗中'
if isColor then
name=toColorStringX('#c82c2c',name)
end
end
else
if cur<pvpTeamData.beginTime then
state=2
if isName then
name='待战中'
if isColor then
name=toColorStringX('#65615f',name)
end
end
elseif cur<pvpTeamData.endTime then
state=3
if isName then
name='战斗中'
if isColor then
name=toColorStringX('#c82c2c',name)
end
end
else

state=4
if isName then
name='已结束'
if isColor then
name=toColorStringX('#6833c0',name)
end
end
end
end
end
return state,name,time
end

function zhengzhanshanhaiModel:jumpPvPTeam(pvpTeamData)
if pvpTeamData==nil then return end
local c_x,c_y=pvpTeamData:getCurLocalPos()
local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(c_x,c_y)
if pvpTeamData.targetguildid then
local xmData=zhengzhanshanhaiModel:getXMData(pvpTeamData.targetguildid)
if xmData~=nil then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',g_x,g_y,0,false,0,function()
zhengzhanshanhaiController:openXMDetailInfoWin(pvpTeamData.targetguildid)
end)
end
elseif pvpTeamData.targetdomainid then
local ldData=zhengzhanshanhaiModel:getLDData(pvpTeamData.targetdomainid)
if ldData~=nil then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',g_x,g_y,0,false,0,function()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=pvpTeamData.targetdomainid})
end)
end
end
end

function zhengzhanshanhaiModel:jumpPvPTeam2(pvpTeamData)
if pvpTeamData==nil then return end
local e_x=pvpTeamData.e_x
local e_y=pvpTeamData.e_y
if pvpTeamData.targetguildid then
local xmData=zhengzhanshanhaiModel:getXMData(pvpTeamData.targetguildid)
if xmData~=nil then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',e_x,e_y,0,false,0,function()
zhengzhanshanhaiController:openXMDetailInfoWin(pvpTeamData.targetguildid)
end)
end
elseif pvpTeamData.targetdomainid then
local ldData=zhengzhanshanhaiModel:getLDData(pvpTeamData.targetdomainid)
if ldData~=nil then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',e_x,e_y,0,false,0,function()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=pvpTeamData.targetdomainid})
end)
end
end
end






function zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(targetid,idx)
if idx~=nil then
local needRefresh=false
local data=zhengzhanshanhaiModel:getPvPAttackData(targetid,idx)
if data==nil or(data.res==0 and gameUtilityModel.getServerShortTime()-data.time>=pvpAttackDataRefreshTime)then
needRefresh=true
end
if needRefresh then
zhengzhanshanhaiController:reqAttactDetail(targetid,idx)
zhengzhanshanhaiController:setOpenPvPAttackDataMark({targetid,idx})
else
zhengzhanshanhaiController:openPvPAttackDataWin({targetid,idx})
end
else
zhengzhanshanhaiController:openPvPAttackDataWin({targetid})
end
end

function zhengzhanshanhaiModel:initPvPAttackData(targetid,idx,attackInfo)
if self.pvpAttackDataLookup==nil then
self.pvpAttackDataLookup={}
end
local targetid_str=tostring(targetid)
if self.pvpAttackDataLookup[targetid_str]==nil then
self.pvpAttackDataLookup[targetid_str]={}
end
attackInfo.time=gameUtilityModel.getServerShortTime()
local n=mathHelper.int64_to_number(targetid)
if n>0 then
attackInfo.guildid=targetid
attackInfo.guildid_str=tostring(targetid)
attackInfo.domainid=nil
else
attackInfo.guildid=nil
attackInfo.domainid=-n
end
attackInfo.getDesc=function(self_)
local str
local xmData=zhengzhanshanhaiModel:getXMData(self_.attackguildid)
if xmData then
if self_.guildid then
local xmData_=zhengzhanshanhaiModel:getXMData(self_.guildid)
if xmData_ then
str=FMT.fmt('{0} 掠夺 {1}',xmData.guildname,xmData_.guildname)
end
elseif self_.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(self_.domainid)
if cfg then
str=FMT.fmt('{0} 占领 {1}',xmData.guildname,cfg.name)
end
end
end

return str
end
self.pvpAttackDataLookup[targetid_str][idx]=attackInfo
end

function zhengzhanshanhaiModel:getPvPAttackData(targetid,idx)
if self.pvpAttackDataLookup then
local targetid_str=tostring(targetid)
if self.pvpAttackDataLookup[targetid_str]then
return self.pvpAttackDataLookup[targetid_str][idx]
end
end
end





function zhengzhanshanhaiModel:getLookXMRecord(guildid)
local guildid_str=tostring(guildid)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.lookXM==nil then
record.lookXM={}
end
return record.lookXM[guildid_str]
end

function zhengzhanshanhaiModel:setLookXMRecord(guildid,data)
local guildid_str=tostring(guildid)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZhengZhanShanHai,{})
if record.lookXM==nil then
record.lookXM={}
end
record.lookXM[guildid_str]=data
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhengZhanShanHai)
end





function zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
return zhengzhanshanhaiController:getZZSHCfg('team',1)
end

function zhengzhanshanhaiModel:getAtkTeamMaxNum()
local num=zhengzhanshanhaiController:getZZSHCfg('team',3)
num=num+xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddPvPTeamNum)
return num
end

function zhengzhanshanhaiModel:getDefTeamMaxNum()
local num=zhengzhanshanhaiController:getZZSHCfg('team',4)
num=num+xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHAddPvPTeamNum)
return num
end

function zhengzhanshanhaiModel:getReverLingLiCost(teamfight_num,num)
local temp=zhengzhanshanhaiController:getZZSHCfg('power',5)
local val=temp[1]
local price=temp[2][1][2]
return math.ceil(num*teamfight_num*val*price)
end

function zhengzhanshanhaiModel:getReverLingLiCostType()
local temp=zhengzhanshanhaiController:getZZSHCfg('power',5)
return temp[2][1][1]
end

function zhengzhanshanhaiModel:getLingLiFaZe(num)
local temp=zhengzhanshanhaiController:getZZSHCfg('power',4)
for i,v in ipairs(temp)do
if num>v[1]then
return v
end
end
end

function zhengzhanshanhaiModel:getTeamZhenRongName(teamtype)
if teamtype>0 then
return FMT.fmt('仙阵{0}',teamtype)
else
return'防守'
end
end

function zhengzhanshanhaiModel:getTeamZhenRongName2(teamtype)
if teamtype>0 then
return FMT.fmt('攻击仙阵{0}',teamtype)
else
return'防守攻击'
end
end

function zhengzhanshanhaiModel:getAttackRadius()
return zhengzhanshanhaiController:getZZSHCfg('attack')
end

function zhengzhanshanhaiModel:calculateWayTime_pvp(x1,y1,x2,y2)
local dis=mathHelper.distance(x1,y1,x2,y2)
local step=zhengzhanshanhaiModel:getPvPMoveStep()
return math.max(1,math.ceil(dis/step))
end

function zhengzhanshanhaiModel:getPvPMoveStep()
return zhengzhanshanhaiController:getZZSHCfg('step',1)
end



function zhengzhanshanhaiModel:initBalanceData()
self.balanceData={}
self.balanceData.manorLen=0
self.balanceData.manorLenList={}
self.balanceData.plunderLen=0
self.balanceData.plunderLenList=nil
self.balanceData.winTimes=0
self.balanceData.winmomentum=0
self.balanceData.rankmomentum=0

local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
local config=cfgHelper.get1(cfg_zhengzhanshanhaidomainconfig_get,raceIndex)

for k,v in ipairs(config)do
if v then
self.balanceData.manorLenList[v.domain]={}
end
end
end


function zhengzhanshanhaiModel:setBalanceData(data)
self:initBalanceData()

self.balanceData.manorLen=data[1]
self.balanceData.plunderLen=data[3]
self.balanceData.winTimes=data[5]
self.balanceData.winmomentum=data[6]
self.balanceData.rankmomentum=data[7]

if self.balanceData.manorLen>0 then
for k,v in ipairs(data[2])do
if v then
self.balanceData.manorLenList[v.param_1]=v
end
end
end

if self.balanceData.plunderLen>0 then
self.balanceData.plunderLenList=data[4]
end

end

function zhengzhanshanhaiModel:getBalanceData()
return self.balanceData
end

function zhengzhanshanhaiModel:getPVPWarBalanceData()

local lastWeek
local lastIndex
local lastSession
local lastData=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eZzshPvpBalance,{})


local session=zhengzhanshanhaiModel:getRaceIndex()
local week=zhengzhanshanhaiModel:getRaceLunIndex()
local index=zhengzhanshanhaiModel:getPvPIndex()

if not lastData.session then
if index>0 then
self:showPVPBalanceWin(session,week,index)
end
else


lastSession=lastData.session
lastWeek=lastData.week
lastIndex=lastData.index

if lastSession==session then
if lastWeek==week then
if index>lastIndex then
self:showPVPBalanceWin(session,week,index)
end
else
if week>lastWeek then
if index>0 then
self:showPVPBalanceWin(session,week,index)
end
end
end
else
if session>lastSession then
if index>0 then
self:showPVPBalanceWin(session,week,index)
end
end
end
end
end

function zhengzhanshanhaiModel:showPVPBalanceWin(session,week,index)

local list={session=session,week=week,index=index}
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eZzshPvpBalance,list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZzshPvpBalance)

if not newbieControl.isInNewbie()then

local raceState=zhengzhanshanhaiModel:getLunState()
if raceState~=eZZSH_State.ePVPFight then
timeEventController.delayDo(2,function()
zhengzhanshanhaiController:reqBalanceData()
end)
end
end
end




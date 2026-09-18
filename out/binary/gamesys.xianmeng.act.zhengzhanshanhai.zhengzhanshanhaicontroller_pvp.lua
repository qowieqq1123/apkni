















local openSelectTeamMark=nil
local openOtherTeamMark=nil
local openPvPAttackDataMark=nil

function zhengzhanshanhaiController:onAppStart_pvp()
socketManager:register_receiver(20,186,self.recv_20_186)
socketManager:register_receiver(20,189,self.recv_20_189)
socketManager:register_receiver(20,190,self.recv_20_190)
socketManager:register_receiver(20,191,self.recv_20_191)
socketManager:register_receiver(20,192,self.recv_20_192)
socketManager:register_receiver(20,197,self.recv_20_197)
socketManager:register_receiver(20,193,self.recv_20_193)
socketManager:register_receiver(20,194,self.recv_20_194)
socketManager:register_receiver(20,198,self.recv_20_198)
socketManager:register_receiver(20,200,self.recv_20_200)
socketManager:register_receiver(20,201,self.recv_20_201)
socketManager:register_receiver(20,206,self.recv_20_206)
socketManager:register_receiver(20,207,self.recv_20_207)
socketManager:register_receiver(20,218,self.recv_20_218)
socketManager:register_receiver(20,219,self.recv_20_219)
socketManager:register_receiver(20,220,self.recv_20_220)


socketManager:register_receiver(44,186,self.recv_44_186)
socketManager:register_receiver(44,189,self.recv_44_189)
socketManager:register_receiver(44,190,self.recv_44_190)
socketManager:register_receiver(44,191,self.recv_44_191)
socketManager:register_receiver(44,192,self.recv_44_192)
socketManager:register_receiver(44,197,self.recv_44_197)
socketManager:register_receiver(44,193,self.recv_44_193)
socketManager:register_receiver(44,194,self.recv_44_194)
socketManager:register_receiver(44,198,self.recv_44_198)
socketManager:register_receiver(44,200,self.recv_44_200)
socketManager:register_receiver(44,201,self.recv_44_201)
socketManager:register_receiver(44,206,self.recv_44_206)
socketManager:register_receiver(44,207,self.recv_44_207)
socketManager:register_receiver(44,218,self.recv_44_218)
socketManager:register_receiver(44,219,self.recv_44_219)
socketManager:register_receiver(44,220,self.recv_44_220)
end

function zhengzhanshanhaiController:onEnterState_pvp(isReconnet)

end

function zhengzhanshanhaiController:onLeaveState_pvp(isReconnet)
openSelectTeamMark=nil
openOtherTeamMark=nil
openPvPAttackDataMark=nil
zhengzhanshanhaiModel:clearPvPData()
end

function zhengzhanshanhaiController:setOpenSelectTeamMark(flag)
openSelectTeamMark=flag
end

function zhengzhanshanhaiController:getOpenSelectTeamMark()
return openSelectTeamMark
end

function zhengzhanshanhaiController:openSelectTeamWin(flag)
if flag[1]==1 then
if UIManager:isActive('UIXM_ZZSH_selectTeamWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_data')
else
UIManager:showWindow('UIXM_ZZSH_selectTeamWin')
end
elseif flag[1]==2 then
if UIManager:isActive('UIXM_ZZSH_teamInfoThreeWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_data')
else
UIManager:showWindow('UIXM_ZZSH_teamInfoThreeWin',flag[2])
end
end
end

function zhengzhanshanhaiController:setOpenOtherTeamMark(flag)
openOtherTeamMark=flag
end

function zhengzhanshanhaiController:getOpenOtherTeamMark()
return openOtherTeamMark
end

function zhengzhanshanhaiController:openOtherTeamWin(flag)
if flag[2]==1 then
if not UIManager:isActive('UIXM_ZZSH_teamInfoTwoWin')then
UIManager:showWindow('UIXM_ZZSH_teamInfoTwoWin',{guildid=flag[1],teamtype=flag[3]})
end
end
end

function zhengzhanshanhaiController:setOpenPvPAttackDataMark(flag)
openPvPAttackDataMark=flag
end

function zhengzhanshanhaiController:getOpenPvPAttackDataMark()
return openPvPAttackDataMark
end

function zhengzhanshanhaiController:openPvPAttackDataWin(flag)
if flag then

if UIManager:isActive('UIXM_ZZSH_FightSituationWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_FightSituationWin','rec_data',flag[1],flag[2])
else
UIManager:showWindow('UIXM_ZZSH_FightSituationWin',{flag[1],flag[2]})
end
end
end


function zhengzhanshanhaiController.setupDefTeams()
local teamIndex=1
local allTeams=zhengzhanshanhaiModel:getAllDefTeam()
local multipleTeams={}
local lp={}
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamIdx=1,max do
local defTeam=allTeams[teamIdx]
multipleTeams[teamIdx]={}
if defTeam then
for posIdx=1,5 do
local dis_guid=defTeam.guidList[posIdx]
if mathHelper.validInt64(dis_guid)then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end
lp[teamIdx]=true
end
end
local dzCountLimit=5
local mapId=zhengzhanshanhaiModel:getMapID(1)
local singleFightDescStr=FMT.fmt('每个队伍最多可上阵{0}名弟子',dzCountLimit)
local winArgs=
{
enterTxt="山海阵容",
skipShouYuanCheck=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterFight=nil,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dzCountLimit=dzCountLimit,
singleFightDescStr=singleFightDescStr,
notNeedDealOverTime=true,
editorTeam=false,
needSaveTeam=false,
showZhenFa=false,
showDefTeamTips=true,
mapId=mapId,
defaultSelectTeamIndex=teamIndex,
multipleTeams=multipleTeams,
cancelCallBack=function()
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,openSelectTeam=true,not_showlogtips=true})
end,
enterCallBack=function(teamList,zfId)

local guidList={}
local lp2={}
for teamIdx,v in ipairs(teamList)do
local defTeam=allTeams[teamIdx]
if defTeam then
local check=false
local dd={}
for posIdx,vv in ipairs(v[2])do
local dis_guid=vv[2]
local dis_guid_=defTeam.guidList[posIdx]
if not mathHelper.compareInt64(dis_guid,dis_guid_)then
check=true
end
table.insert(dd,dis_guid)
end
if check then
table.insert(guidList,{teamIdx,#dd,dd})
lp2[teamIdx]=true
end
else
local check=false
local dd={}
for posIdx,vv in ipairs(v[2])do
local dis_guid=vv[2]
if mathHelper.validInt64(dis_guid)then
check=true
end
table.insert(dd,dis_guid)
end
if check then
table.insert(guidList,{teamIdx,#dd,dd})
lp2[teamIdx]=true
end
end
end

if#guidList>0 then
local add=false
for k,v in pairs(lp2)do
if lp[k]==nil then
add=true
end
end
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then

if not add then
UIManager.error('战争期无法修改队伍')
return
end
elseif raceState==eZZSH_State.ePVPStandby then


local idx=zhengzhanshanhaiModel:getPvPIndex2()
if not add and idx>0 then
UIManager.error('此次备战期无法修改队伍')
return
end
end
zhengzhanshanhaiController:reqSetTeam(guidList)
end
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,openSelectTeam=true,not_showlogtips=true})
end,
}
zhengzhanshanhaiController:setFigthReady(true)
fightController.showPrepareWin(fightPreSelectModel.fightType.zzshSetTeam,winArgs)
end

function zhengzhanshanhaiController:showOtherPlayerRivalInfo(actorid,idx,typo,serverid)
local callback=function(teamDzList_,other)
local idx_=other.idx
local list={}
for i=1,5 do
local cur=(idx_-1)*5+i
list[i]=teamDzList_[cur]
end
zhengzhanshanhaiController:showOtherPlayerRivalInfoBack(list,typo)
end
serverid=serverid or 0
local isZZSHSeason=serverid~=0
local send_args={serverid=serverid,idx=idx,isZZSHSeason=isZZSHSeason}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eZhengZhanShanHaiPvP,actorid,send_args,callback,false,true)
end


function zhengzhanshanhaiController:showOtherPlayerRivalInfoBack(teamDzList,typo)
local title
if typo==1 then
title='进攻阵容'
elseif typo==2 then
title='防守阵容'
elseif typo==3 then
title='玩家阵容'
end
local data={
teamList=teamDzList,
bgType=2,
title=title,
lookType=DOUFATAI_LOOK_TYPE.eZhengZhanShanHaiPvP,
}
UIManager:showWindow("UICommonLookRivalWin",data)
end

function zhengzhanshanhaiController:openLingLiTips(guildid,teamguid_str,typo,moveX,moveY,offsetX,offsetY)
local zrData
if guildid==nil then
zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
else
zrData=zhengzhanshanhaiModel:getOtherPvPZhenRong(guildid)
end
if zrData then
local args={zrData=zrData,teamguid_str=teamguid_str,typo=typo,moveX=moveX,moveY=moveY,offsetX=offsetX,offsetY=offsetY}
UIManager:showWindow('UIXM_ZZSH_lingliWin',args)
end
end




function zhengzhanshanhaiController:reqPvPTeam(guildid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_189(guildid)
else
socketManager:send_20_189(guildid)
end
end


function zhengzhanshanhaiController:reqLock(lock)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_190(lock)
else
socketManager:send_20_190(lock)
end
end


function zhengzhanshanhaiController:reqChangePvPTeam(teamguid,teamtype,teamidx)



local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_191(teamguid,teamtype,teamidx)
else
socketManager:send_20_191(teamguid,teamtype,teamidx)
end
end


function zhengzhanshanhaiController:reqChangeAllPvPTeam(teamtype)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_192(teamtype)
else
socketManager:send_20_192(teamtype)
end
end


function zhengzhanshanhaiController:reqChangeAllPvPTeamAuto()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_197()
else
socketManager:send_20_197()
end
end


function zhengzhanshanhaiController:reqCheckXM(guildid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_193(guildid)
else
socketManager:send_20_193(guildid)
end
end


function zhengzhanshanhaiController:reqSupportXM(guildid,teamguid)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_194(guildid,teamguid)
else
socketManager:send_20_194(guildid,teamguid)
end
end


function zhengzhanshanhaiController:reqOrder(teamtype,targetid,ordertype)



local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_198(teamtype,targetid,ordertype)
else
socketManager:send_20_198(teamtype,targetid,ordertype)
end
end

function zhengzhanshanhaiController:reqOrderEx(teamtype,guildid,domainid)
local targetid,ordertype
if guildid~=nil then
targetid=guildid
ordertype=2
elseif domainid~=nil then
local domainid_=-domainid
targetid=int64.new(tostring(domainid_))
ordertype=1
else
local order=zhengzhanshanhaiModel:getOrder(teamtype)
if order then
if order.guildid~=nil then
ordertype=2
elseif order.domainid~=nil then
ordertype=1
end
if ordertype then
targetid=int64.new('0')
end
end
end
if targetid==nil then return end
zhengzhanshanhaiController:reqOrder(teamtype,targetid,ordertype)
end


function zhengzhanshanhaiController:reqAttactDetail(targetid,idx)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_200(targetid,idx)
else
socketManager:send_20_200(targetid,idx)
end
end


function zhengzhanshanhaiController:reqLingLi(list)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_201(#list,list)
else
socketManager:send_20_201(#list,list)
end
end


function zhengzhanshanhaiController:reqBalanceData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_207()
else
socketManager:send_20_207()
end
end


function zhengzhanshanhaiController:reqAutoRever(auto)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_218(auto)
else
socketManager:send_20_218(auto)
end
end


function zhengzhanshanhaiController:reqLinDiReward(domainid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_219(domainid)
else
socketManager:send_20_219(domainid)
end
end


function zhengzhanshanhaiController:reqJoinFightChange(state)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_220(state)
else
socketManager:send_20_220(state)
end
end






function zhengzhanshanhaiController.recv_20_186(len,targetList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_PvPTargetsData(len,targetList)
end


function zhengzhanshanhaiController.recv_20_189(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPvPZhenRong(args)
end


function zhengzhanshanhaiController.recv_20_190(lock,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_PvPZhenRongLock(lock,actorid)
end


function zhengzhanshanhaiController.recv_20_191(teamguid,teamtype,teamidx,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_changePvPZhenRong(teamguid,teamtype,teamidx,actorid)
end


function zhengzhanshanhaiController.recv_20_192(teamtype,guidlistlen,guidList,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_changeMyPvPZhenRongSort(teamtype,guidlistlen,guidList,actorid)
end


function zhengzhanshanhaiController.recv_20_197(teamlistlen,teamList,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_autoChangePvPZhenRong(teamlistlen,teamList,actorid)
end


function zhengzhanshanhaiController.recv_20_193(guildid,moneylistlen,moneyList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_lookXMRecord(guildid,moneylistlen,moneyList)
end


function zhengzhanshanhaiController.recv_20_194(guildid,teamguid)



end


function zhengzhanshanhaiController.recv_20_198(teamtype,targetid,ordertype)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_useOrder(teamtype,targetid,ordertype)
end


function zhengzhanshanhaiController.recv_20_200(targetid,idx,attackInfo)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getPvPAttackData(targetid,idx,attackInfo)
end


function zhengzhanshanhaiController.recv_20_201(len,list)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_recoverPvPZhenRongLingLi(len,list)
end


function zhengzhanshanhaiController.recv_20_206(momentum)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_updateMomentum(momentum)
end

function zhengzhanshanhaiController.recv_20_207(data)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getBalanceData(data)
end


function zhengzhanshanhaiController.recv_20_218(auto,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_updatePvPAutoReverFlag(auto,actorid)
end


function zhengzhanshanhaiController.recv_20_219(domainid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_getLDDailyReward(domainid)
end


function zhengzhanshanhaiController.recv_20_220(state,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end

return zhengzhanshanhaiController.recv_updateJoinFightFlag(state,actorid)
end




function zhengzhanshanhaiController.recv_44_186(len,targetList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_PvPTargetsData(len,targetList)
end


function zhengzhanshanhaiController.recv_44_189(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPvPZhenRong(args)
end


function zhengzhanshanhaiController.recv_44_190(lock,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_PvPZhenRongLock(lock,actorid)
end


function zhengzhanshanhaiController.recv_44_191(teamguid,teamtype,teamidx,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changePvPZhenRong(teamguid,teamtype,teamidx,actorid)
end


function zhengzhanshanhaiController.recv_44_192(teamtype,guidlistlen,guidList,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_changeMyPvPZhenRongSort(teamtype,guidlistlen,guidList,actorid)
end


function zhengzhanshanhaiController.recv_44_197(teamlistlen,teamList,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_autoChangePvPZhenRong(teamlistlen,teamList,actorid)
end


function zhengzhanshanhaiController.recv_44_193(guildid,moneylistlen,moneyList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_lookXMRecord(guildid,moneylistlen,moneyList)
end


function zhengzhanshanhaiController.recv_44_194(guildid,teamguid)



end


function zhengzhanshanhaiController.recv_44_198(teamtype,targetid,ordertype)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_useOrder(teamtype,targetid,ordertype)
end


function zhengzhanshanhaiController.recv_44_200(targetid,idx,attackInfo)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getPvPAttackData(targetid,idx,attackInfo)
end


function zhengzhanshanhaiController.recv_44_201(len,list)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_recoverPvPZhenRongLingLi(len,list)
end


function zhengzhanshanhaiController.recv_44_206(momentum)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_updateMomentum(momentum)
end

function zhengzhanshanhaiController.recv_44_207(data)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getBalanceData(data)
end


function zhengzhanshanhaiController.recv_44_218(auto,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_updatePvPAutoReverFlag(auto,actorid)
end


function zhengzhanshanhaiController.recv_44_219(domainid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getLDDailyReward(domainid)
end


function zhengzhanshanhaiController.recv_44_220(state,actorid)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_updateJoinFightFlag(state,actorid)
end




function zhengzhanshanhaiController.recv_PvPTargetsData(len,targetList)












zhengzhanshanhaiModel:initPvPTargetsData(len,targetList)
end


function zhengzhanshanhaiController.recv_getPvPZhenRong(args)



























local flag,flag2
if xianmengModel:isMyXM(args[1])then
zhengzhanshanhaiModel:initMyPvPZhenRong(args)
zhengzhanshanhaiModel:initOtherPvPZhenRong(args)
flag=zhengzhanshanhaiController:getOpenSelectTeamMark()
if flag then
zhengzhanshanhaiController:openSelectTeamWin(flag)
else
if UIManager:isActive('UIXM_ZZSH_selectTeamWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_data')
end
if UIManager:isActive('UIXM_ZZSH_teamInfoOneWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoOneWin','rec_data')
end
if UIManager:isActive('UIXM_ZZSH_teamInfoThreeWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_data')
end
end
else
zhengzhanshanhaiModel:initOtherPvPZhenRong(args)
end

flag2=zhengzhanshanhaiController:getOpenOtherTeamMark()
if flag2 then
zhengzhanshanhaiController:openOtherTeamWin(flag2)
end

if flag then
zhengzhanshanhaiController:setOpenSelectTeamMark(nil)
end
if flag2 then
zhengzhanshanhaiController:setOpenOtherTeamMark(nil)
end
end


function zhengzhanshanhaiController.recv_PvPZhenRongLock(lock,actorid)


if playerModel:checkActorId(actorid)then
if lock==1 then
UIManager.info('阵容已锁定')
else
UIManager.info('阵容已解锁')
end
end
zhengzhanshanhaiModel:setMyPvPZhenRongLock(lock)
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','refreshLockBtn')
end


function zhengzhanshanhaiController.recv_changePvPZhenRong(teamguid,teamtype,teamidx,actorid)





if playerModel:checkActorId(actorid)then
UIManager.info('调整成功')
end
local isChanged,needRefresh=zhengzhanshanhaiModel:changeMyPvPZhenRong(teamguid,teamtype,teamidx)
if needRefresh then
if UIManager:isActive('UIXM_ZZSH_selectTeamWin')or UIManager:isActive('UIXM_ZZSH_teamInfoOneWin')
or UIManager:isActive('UIXM_ZZSH_teamInfoThreeWin')then
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid then
zhengzhanshanhaiController:reqPvPTeam(my_guildid)
end
else
zhengzhanshanhaiModel:setMyPvPZhenRongDirty()
end
elseif isChanged then
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_setup',teamguid,teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoOneWin','rec_setup',teamguid,teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_setup',teamguid,teamtype)
end
end


function zhengzhanshanhaiController.recv_changeMyPvPZhenRongSort(teamtype,guidlistlen,guidList,actorid)





if playerModel:checkActorId(actorid)then
UIManager.info('调整成功')
end
local isChanged,needRefresh=zhengzhanshanhaiModel:changeMyPvPZhenRong2(teamtype,guidlistlen,guidList)
if needRefresh then
if UIManager:isActive('UIXM_ZZSH_selectTeamWin')or UIManager:isActive('UIXM_ZZSH_teamInfoOneWin')
or UIManager:isActive('UIXM_ZZSH_teamInfoThreeWin')then
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid then
zhengzhanshanhaiController:reqPvPTeam(my_guildid)
end
else
zhengzhanshanhaiModel:setMyPvPZhenRongDirty()
end
elseif isChanged then
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_setup2',teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoOneWin','rec_setup2',teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_setup2',teamtype)
end
end


function zhengzhanshanhaiController.recv_autoChangePvPZhenRong(teamlistlen,teamList,actorid)




if teamlistlen>0 then
if playerModel:checkActorId(actorid)then
UIManager.info('调整成功')
end
local isChanged=false
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
if zrData then
isChanged=zrData:refreshTeamLookup(teamlistlen,teamList)
end
if not isChanged then
for i,v in ipairs(teamList)do
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_setup2',v.teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoOneWin','rec_setup2',v.teamtype)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_setup2',v.teamtype)
end
else
if UIManager:isActive('UIXM_ZZSH_selectTeamWin')or UIManager:isActive('UIXM_ZZSH_teamInfoOneWin')
or UIManager:isActive('UIXM_ZZSH_teamInfoThreeWin')then
local my_guildid=xianmengModel:myXMGuildID()
if my_guildid then
zhengzhanshanhaiController:reqPvPTeam(my_guildid)
end
else
zhengzhanshanhaiModel:setMyPvPZhenRongDirty()
end
end
end
end


function zhengzhanshanhaiController.recv_lookXMRecord(guildid,moneylistlen,moneyList)




UIManager.info('窥探成功')
local data={}
data.refreshTime=gameUtilityModel.getServerShortTime()
local moneys
if moneylistlen>0 then
moneys={}
for i,v in ipairs(moneyList)do
table.insert(moneys,{v.param_1,mathHelper.int64_to_number(v.param_2)})
end
end
data.moneys=moneys
zhengzhanshanhaiModel:setLookXMRecord(guildid,data)
UIManager:invokeUIMethod('UIXM_ZZSH_xmWin','rec_look',guildid)
end


function zhengzhanshanhaiController.recv_useOrder(teamtype,targetid,ordertype)




local n=mathHelper.int64_to_number(targetid)
if n~=0 then
if n>0 then
UIManager.info('发起掠夺指令成功')
else
UIManager.info('发起占领指令成功')
end
else
UIManager.info('撤销指令成功')
end
end


function zhengzhanshanhaiController.recv_getPvPAttackData(targetid,idx,attackInfo)



























zhengzhanshanhaiModel:initPvPAttackData(targetid,idx,attackInfo)
local flag=zhengzhanshanhaiController:getOpenPvPAttackDataMark()
if flag then
zhengzhanshanhaiController:openPvPAttackDataWin({targetid,idx})
zhengzhanshanhaiController:setOpenPvPAttackDataMark(nil)
else
UIManager:invokeUIMethod('UIXM_ZZSH_FightSituationWin','rec_data',targetid,idx)
end
end


function zhengzhanshanhaiController.recv_recoverPvPZhenRongLingLi(len,list)



if len>0 then
if len==1 then
UIManager.info('该队伍灵力已恢复')
else
UIManager.info('该阵容所有队伍灵力已恢复')
end
local lp={}
for i,teamguid in ipairs(list)do
local teamguid_str=tostring(teamguid)
lp[teamguid_str]=true
end
zhengzhanshanhaiModel:setMyPvPZhenRongLingLi(lp)
UIManager:invokeUIMethod('UIXM_ZZSH_selectTeamWin','rec_lingli',lp)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoOneWin','rec_lingli',lp)
UIManager:invokeUIMethod('UIXM_ZZSH_teamInfoThreeWin','rec_lingli',lp)
UIManager:invokeUIMethod('UIXM_ZZSH_lingliWin','rec_lingli',lp)
end
end


function zhengzhanshanhaiController.recv_updateMomentum(momentum)


zhengzhanshanhaiModel:setMomentNum(momentum)
UIManager:invokeUIMethod('UIXM_ZZSH_PvPMainWin','refreshQiShiBtn')
end

function zhengzhanshanhaiController.recv_getBalanceData(data)
zhengzhanshanhaiModel:setBalanceData(data)
if not data or data[1]==0 and data[3]==0 and data[5]==0 then

else
UIManager:showWindow('UIXM_ZZSH_balanceWin')
end
end


function zhengzhanshanhaiController.recv_updatePvPAutoReverFlag(auto,actorid)







zhengzhanshanhaiModel:setPvPAutoReverFlag(auto)
UIManager:invokeUIMethod('UIXM_ZZSH_settingWin','refreshPage3')
end


function zhengzhanshanhaiController.recv_getLDDailyReward(domainid)


UIManager.info('特产领取成功')
zhengzhanshanhaiModel:setLDDailyReward(1)
end


function zhengzhanshanhaiController.recv_updateJoinFightFlag(state,actorid)



local actorid_n=mathHelper.int64_to_number(actorid)
if actorid_n>0 then
if playerModel:checkActorId(actorid)then
if state==1 then
UIManager.info('参与争夺成功')
else
UIManager.info('放弃争夺成功')
end
end
zhengzhanshanhaiModel:setJoinFightFlag(state)

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','refreshFightModelBtn')
UIManager:closeWindow('UIXM_ZZSH_fightModelWin')
else
local err
if actorid_n==-1 then
err='已有领地归属'
end
if err then
UIManager.error(err)
end
end
end



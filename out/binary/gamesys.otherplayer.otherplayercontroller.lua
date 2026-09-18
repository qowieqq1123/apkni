







local _MODULENAME="otherPlayerController"
gameState.addListener(def_table(_MODULENAME))
otherPlayerController.name=_MODULENAME

local actorRefreshTime=600
local actorReqLockTime=2
local openOtherPlayerInfoWinMark=nil
local openOtherPlayerDZInfoWinMark=nil

otherPlayerController.eAttachType={
Rank=1,
}


otherPlayerInfoType={
ePlayerInfo1=1,
ePlayerInfo2=2,
eDouFaTaiDef1=3,
eDouFaTaiDef2=4,
eLunDaoDaHuiFight=5,
eZongMenDaBiDef1=6,
eZongMenDaBiDef2=7,
eDZInfoList=8,
eJiuCengYaoLouDef2=9,
eXianFaWenDao1=12,
eXianFaWenDao2=13,
eShiLianTa2=14,
eLingXuWenJianDef1=15,
eLingXuWenJianDef2=16,
eSDShouTong=17,
eZhengZhanShanHaiPvP=18,
eWenDingCangQiong=19,
eXianJieInfo=20,
eXianJieSearchLog=21,
eXingYu=22,
eTeamChangeInfo1=23,
eTeamChangeInfo2=24,
}

function otherPlayerController:onAppStart()


otherPlayerController:onAppStart_common()
end

function otherPlayerController:onEnterState()
otherPlayerModel:InitData()
otherPlayerController:onEnterState_common()
end

function otherPlayerController:onLeaveState()
otherPlayerModel:clearData()
openOtherPlayerInfoWinMark=nil
openOtherPlayerDZInfoWinMark=nil
otherPlayerController:onLeaveState_common()
end

function otherPlayerController:onPlayerCreate(...)

end

function otherPlayerController:onLostConnection()

end







function otherPlayerController:openOtherPlayerInfoWin(actorId,isNewData,fromType,attach)
local openNow=false
local serverid_
if not isNewData then
local actorData=otherPlayerModel:getActorData(actorId)
if actorData~=nil then
serverid_=actorData.serverid
local curTime=gameUtilityModel.getServerShortTime()
if(curTime-actorData.time)<actorRefreshTime then
openNow=true
end
end
end
if openNow then
openOtherPlayerInfoWinMark=nil

attach=attach or{}
if attach.serverid==nil then
attach.serverid=serverid_
end
UIManager:showWindow('UIOthePlayerInfoWin',{actorId=actorId,fromType=fromType,attach=attach})
else
local actorIdStr=tostring(actorId)
if openOtherPlayerInfoWinMark~=nil then
if actorIdStr==openOtherPlayerInfoWinMark[1]then
local curTime=Time.realtimeSinceStartup
if(curTime-openOtherPlayerInfoWinMark[2])<actorReqLockTime then
return
end
end
end
openOtherPlayerInfoWinMark={actorIdStr,Time.realtimeSinceStartup,fromType,attach}






otherPlayerController:reqOtherPlayerInfo(actorId,attach)
end
end


function otherPlayerController:openOtherPlayerDZInfoWin(actorId,curDZGuid,isNewData,isBack,attach,targetGuidList)
local openNow=false
if not isNewData then
local actorData=otherPlayerModel:getActorData(actorId)
if actorData~=nil then
if actorData.dzDataSet.datas~=nil then
local curTime=gameUtilityModel.getServerShortTime()
if(curTime-actorData.time)<actorRefreshTime then
openNow=true
end
end
end
end
if openNow then
openOtherPlayerDZInfoWinMark=nil
otherPlayerController:openOtherPlayerDZInfoWinEx(actorId,curDZGuid,isBack,attach)
else
local actorIdStr=tostring(actorId)
if openOtherPlayerDZInfoWinMark~=nil then
if actorIdStr==openOtherPlayerDZInfoWinMark[1]then
local curTime=Time.realtimeSinceStartup
if(curTime-openOtherPlayerDZInfoWinMark[2])<actorReqLockTime then
return
end
end
end

local actorData=otherPlayerModel:getActorData(actorId)
if actorData==nil and not targetGuidList then
openOtherPlayerDZInfoWinMark={actorIdStr,Time.realtimeSinceStartup,curDZGuid,isBack,attach}






otherPlayerController:reqOtherPlayerInfo(actorId,attach)
else
local guidList={}
if not targetGuidList then
local viewDatas=actorData.dzDataSet.viewDatas
if viewDatas~=nil then
for k,vData in pairs(viewDatas)do
table.insert(guidList,vData.discipleguid)
end
end
else
guidList=targetGuidList
end

local c=#guidList
if c>0 then
openOtherPlayerDZInfoWinMark={actorIdStr,Time.realtimeSinceStartup,curDZGuid,isBack,attach,targetGuidList}
local serverid
if attach then
serverid=attach.serverid
end
otherPlayerController:reqOtherPlayerDZList(actorId,c,guidList,serverid,attach)
else
UIManager.error('暂无弟子数据')
end
end
end
end

function otherPlayerController:openOtherPlayerDZInfoWinEx(actorId,curDZGuid,isBack,attach)
local actorData=otherPlayerModel:getActorData(actorId)
if actorData~=nil then
if actorData.dzDataSet.datas~=nil then
local guidList={}
for k,dzData in pairs(actorData.dzDataSet.datas)do
table.insert(guidList,dzData)
end
local c=#guidList
if c>0 then
if c>1 then
table.sort(guidList,function(a,b)
return a:fightValNum_get()>b:fightValNum_get()
end)
end

local args={}
args.dis_guid=curDZGuid
args.dislist=guidList
UIManager:showWindow('UIOtherDiscipleMainWin',args)
return true
end
end
end
return false
end


function otherPlayerController:openOtherPlayerDZInfoWinEXX(actorId,dzDataList,curDZGuid)
local guidList={}
for i,dzData in ipairs(dzDataList)do
local disguid=dzData.base.discipleguid
otherPlayerModel:addDZData(actorId,dzData)
local dzData_=otherPlayerModel:getDZData(disguid)
table.insert(guidList,dzData_)
end
local c=#guidList
if c>0 then
if c>1 then
table.sort(guidList,function(a,b)
return a:fightValNum_get()>b:fightValNum_get()
end)
end

local args={}
args.dis_guid=curDZGuid
args.dislist=guidList
UIManager:showWindow('UIOtherDiscipleMainWin',args)
return true
end
return false
end

function otherPlayerController:openOtherPlayerDZInfoWin2(curDZGuid,guidList)
local args={}
args.dis_guid=curDZGuid
args.dislist=guidList
UIManager:showWindow('UIOtherDiscipleMainWin',args)
end


function otherPlayerController:openSelfPlayerDZInfoWin(guid_list,curDZGuid)
if guid_list==nil or#guid_list<=0 then return end
local myActorid=playerModel:getActorID()

local dzDataList=otherPlayerModel.discipleStruct_to_discipleStruct3_list(guid_list)
if#dzDataList<=0 then return end
local list={}
for i,dzData in ipairs(dzDataList)do
local disguid=dzData.base.discipleguid
otherPlayerModel:addDZData(myActorid,dzData)
local dzData_=otherPlayerModel:getDZData(disguid)
table.insert(list,dzData_)
end
otherPlayerController:openOtherPlayerDZInfoWin2(curDZGuid,list)
end



function otherPlayerController:reqOtherPlayerInfo(actorid,args)




args=args or{}
args.serverid=args.serverid or 0









local callback=function(...)
otherPlayerController.rece_OtherPlayerInfo(...)
end


if systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)then
otherPlayerController:reqCommonInfo(actorid,otherPlayerInfoType.eTeamChangeInfo1,args,callback)
else
otherPlayerController:reqCommonInfo(actorid,otherPlayerInfoType.ePlayerInfo1,args,callback)
end
end


function otherPlayerController:reqOtherPlayerDZList(actorid,len,guidList,serverid,args_)

local args
if args_ then
args=table.weakCopy(args_)
else
args={}
end
args.serverid=serverid
args.guidList=guidList

local callback=function(...)
otherPlayerController.rece_OtherPlayerDZList(...)
end
otherPlayerController:reqCommonInfo(actorid,otherPlayerInfoType.eDZInfoList,args,callback)
end





function otherPlayerController.rece_OtherPlayerInfo(otherData)






















local actorId=otherData.actorid
local serverid=otherData.serverid
local isSuccess=true
local dzList=otherData.dzList or{}
for i=#dzList,1,-1 do
if mathHelper.compareInt64(dzList[i].discipleguid,int64.zero)then
table_remove(dzList,i)
end
end
local actorIdStr=tostring(actorId)
local checkMark1=false
local fromType
local attach1
if openOtherPlayerInfoWinMark~=nil then
if actorIdStr==openOtherPlayerInfoWinMark[1]then
fromType=openOtherPlayerInfoWinMark[3]
attach1=openOtherPlayerInfoWinMark[4]or{}
attach1.serverid=serverid
openOtherPlayerInfoWinMark=nil
checkMark1=true
end
end
local attach2
local checkMark2=false
if openOtherPlayerDZInfoWinMark~=nil then
if actorIdStr==openOtherPlayerDZInfoWinMark[1]then
checkMark2=true
attach2=openOtherPlayerDZInfoWinMark[5]or{}
attach2.serverid=serverid
end
end
if isSuccess then
local actorData={}
actorData.actorId=actorId
actorData.iconInfo=otherData.iconInfo
actorData.name=otherData.name
actorData.zmLevel=otherData.zmLevel
actorData.zmName=otherData.zmName
actorData.zmFight=otherData.zmFight
actorData.guildName=otherData.guildName
actorData.dftRank=otherData.dftRank
actorData.sltLayer=otherData.sltLayer
actorData.dzList=dzList
actorData.sex=otherData.sex
actorData.serverid=serverid
actorData.zmFight2=otherData.zmFight2
otherPlayerModel:addActorData(actorData)


else
UIManager.error('玩家不存在')
end

if checkMark1 then
if isSuccess then
UIManager:showWindow('UIOthePlayerInfoWin',{actorId=actorId,fromType=fromType,attach=attach1})
end
elseif checkMark2 then
if isSuccess then
local guidList={}
for i,v in ipairs(dzList)do
table.insert(guidList,v.discipleguid)
end
otherPlayerController:reqOtherPlayerDZList(actorId,#guidList,guidList,serverid)
else
UIManager.error('暂无弟子数据')
end
end
end


function otherPlayerController.rece_OtherPlayerDZList(otherData)









































local actorId=otherData.actorid
local serverid=otherData.serverid
local isSuccess=false
local actorIdStr=tostring(actorId)
local checkMark2=false
local curDZGuid=nil
local isBack=nil
local attach2=nil
local targetGuidList=nil
if openOtherPlayerDZInfoWinMark~=nil then
if actorIdStr==openOtherPlayerDZInfoWinMark[1]then
curDZGuid=openOtherPlayerDZInfoWinMark[3]
isBack=openOtherPlayerDZInfoWinMark[4]
attach2=openOtherPlayerDZInfoWinMark[5]
targetGuidList=openOtherPlayerDZInfoWinMark[6]
openOtherPlayerDZInfoWinMark=nil
checkMark2=true
end
end
local discipleList={}
if otherData.disciplelistlen>0 then
for i,baseData in ipairs(otherData.discipleList)do
if baseData.flag>0 then
isSuccess=true
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
table.insert(discipleList,dzData)
end
end
for i,dzData in ipairs(discipleList)do
otherPlayerModel:addDZData(actorId,dzData)
end
else
UIManager.error('弟子不存在')
end

if checkMark2 then
if isSuccess then
if not targetGuidList then
otherPlayerController:openOtherPlayerDZInfoWinEx(actorId,curDZGuid,isBack,attach2)
else
local list={}
for i,disguid in ipairs(targetGuidList)do
local dzData=otherPlayerModel:getDZData(disguid)
table.insert(list,dzData)
end
otherPlayerController:openOtherPlayerDZInfoWin2(curDZGuid,list)
end
end
else
if isSuccess then
local list={}
for i,v in ipairs(discipleList)do
local disguid=v.base.discipleguid
local dzData=otherPlayerModel:getDZData(disguid)
table.insert(list,dzData)
end
otherPlayerController:openOtherPlayerDZInfoWin2(nil,list)
end
end
end



function otherPlayerController:reqOtherZRInfo(actorid,typo,args,serverid,callback)
args=args or{}
local attachArgs=args.attachArgs or{}
if serverid then args.serverid=serverid end

local winArgs={}
for k,v in pairs(attachArgs)do
winArgs[k]=v
end
winArgs.bgType=winArgs.bgType or 2

local _callback=function(teamDzList)
if((not teamDzList)or next(teamDzList)==nil)then
UIManager.error("查看失败，阵容记录已过期")
else
winArgs.teamList=teamDzList
UIManager:showWindow("UICommonLookRivalWin",winArgs)
end
end
callback=callback or _callback
otherPlayerModel:reqActorDefTeams(typo,actorid,args,callback,false,true)
end

function otherPlayerController:reqSetActorShowcaseTeam(teamList)

end

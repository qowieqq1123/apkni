






local shoumolist={}
local yetinTeam={}
local yetinTeam_Boss={}
local shoumoBoss={}
local yetUseYunzhou_Boss={}
local recordSelectType={}
local recordrespointtable={}
local needmoney=0
local yetGongji={}
local yeteExploration={}
local peopleteam={}
local shoumonum=0
local autoflag=false
local isautoing=false
local shoumonumflag=false
function xianjieModel:onEnterState_ShouMo(isReconnet)
xianjieModel:initData_ShouMo()
notifySystem:listenNotify(notifyConfig.onXianJieResPointDataChange,xianjieModel.onXianJieResPointDataChange)

notifySystem:listenNotify(notifyConfig.onXianJieWaiPaiChange,xianjieModel.onXianJieWaiPaiChange)
notifySystem:listenNotify(notifyConfig.leaveXianJie,xianjieModel.onLeaveXianJie)
notifySystem:listenNotify(notifyConfig.enterXianJie,xianjieModel.onEnterXianJie)
end



function xianjieModel.onXianJieResPointDataChange(etype,guid,isInit,data)



if not isautoing then
return
end
if etype==xjResPointChangeEventType.eAdd then
local srctype=data.source.srctype
if xjResPointSourceType.eExploration==srctype then
local sceneidx=data.sceneidx
local func=function()



data:createEntity(true)
end
func()
local selectmonstertype=recordSelectType[1]
local select_min=recordSelectType[2]
local select_max=recordSelectType[3]
local cfg=data:getCfg()
if#recordrespointtable>=1 and isautoing then

if cfg and cfg.stage>=select_min and cfg.stage<=select_max then
if data.source.srctype==xjResPointSourceType.eExploration then

if not yeteExploration[recordrespointtable[1]][cfg.stage]then
yeteExploration[recordrespointtable[1]][cfg.stage]=true
xianjieModel:gotoBtn(data.rpGuid,recordrespointtable[1])
end
end
table.remove(recordrespointtable,1)
end
end

end
end
end


function xianjieModel.onXianJieWaiPaiChange(changeType,param,ischange)
if changeType==CHANGE_TYPE.eDelete and not ischange and isautoing then
timeEventController.delayDo(1,function()
xianjieModel:BeginBtn(true)
end)
end

end



function xianjieModel.onEnterXianJie()
if isautoing then
local logicScene=recordSelectType[6]
if logicScene~=nil then
local mlogicScene=xianjieController:transSceneIdxToLogicSceneType(xianjieModel:getSceneIndex())
if mlogicScene~=logicScene then
UIManager.info("自动战斗停止")
xianjieModel:SetAutoStage(false)
end
end
end
end

function xianjieModel.onLeaveXianJie()
if isautoing then
UIManager.info("已离开仙界，自动狩猎已终止")
xianjieModel:SetAutoStage(false)
end
end


function xianjieModel:onProtocol_ShouMo()
xianjieModel:haveShouMotask()
end

function xianjieModel:haveShouMotask()
shoumonumflag=taskModel:CheckShouMo()
if not shoumonumflag then
shoumonum=0
end
end

function xianjieModel:GetShouMonum()
if not shoumonum then
shoumonum=0
end
return shoumonum
end

function xianjieModel:initData_ShouMo()
shoumonumflag=false
shoumonum=0
needmoney=0
autoflag=false
isautoing=false
yetGongji={}
peopleteam={}
shoumolist={}
shoumoBoss={}
recordrespointtable={}
yeteExploration={}
xianjieModel:loadRecord_notboss()
xianjieModel:loadRecord_boss()
for i=1,4 do
if not shoumolist[i]then
shoumolist[i]={}
end
end
for i=1,4 do
if not shoumoBoss[i]then
shoumoBoss[i]={}
end
end
yetinTeam={}
yetinTeam_Boss={}
yetUseYunzhou_Boss={}
xianjieModel:SetDiZiShouMo_notboss()
xianjieModel:SetDiZiShouMo_boss()
xianjieModel:SetYunzhouShouMo_boss()
recordSelectType={}
end

function xianjieModel:ClearData_ShouMo()
shoumonumflag=false
shoumonum=0
autoflag=false
isautoing=false
needmoney=0
yetGongji={}
peopleteam={}
recordrespointtable={}
shoumolist={}
yetinTeam={}
yetinTeam_Boss={}
shoumoBoss={}
yetUseYunzhou_Boss={}
recordSelectType={}
yeteExploration={}
notifySystem:removelistener(notifyConfig.onXianJieResPointDataChange,xianjieModel.onXianJieResPointDataChange)

notifySystem:removelistener(notifyConfig.onXianJieWaiPaiChange,xianjieModel.onXianJieWaiPaiChange)
notifySystem:removelistener(notifyConfig.leaveXianJie,xianjieModel.onLeaveXianJie)
end



function xianjieModel:saveShouMolist(listid,selectList)
shoumolist[listid]=selectList
xianjieModel:SetSortTeam()
xianjieModel:SetDiZiShouMo_notboss()
xianjieModel:saveRecord_notboss()
end

function xianjieModel:getShouMolist(listid)
return shoumolist[listid]
end


function xianjieModel:saveRecord_notboss()
local recordtable={}
for k,v in ipairs(shoumolist)do
if next(v)then
local dizitable={}
for a,b in ipairs(v)do
dizitable[#dizitable+1]={b[1],tostring(b[2])}
end
recordtable[k]=dizitable
else
recordtable[k]={}
end
end
userActorSetting.set("xianjieShouMo_notBoss",recordtable)
userActorSetting.flush()
end
function xianjieModel:loadRecord_notboss()
local notBoss=userActorSetting.get("xianjieShouMo_notBoss",{})
for k,v in ipairs(notBoss)do
if next(v)then
local dizitable={}
for a,b in ipairs(v)do
dizitable[#dizitable+1]={b[1],int64.new(b[2])}
end
shoumolist[k]=dizitable
end
end
end


function xianjieModel:getShouMolistOnlyDiziGUID(listid)
local list={}
if shoumolist[listid]and next(shoumolist[listid])then
for k,v in ipairs(shoumolist[listid])do
table.insert(list,v[2])
end
end
return list
end


function xianjieModel:SetDiZiShouMo_notboss()
yetinTeam={}
for i=1,4 do
local selectList=xianjieModel:getShouMolist(i)
if selectList and next(selectList)then
for k,v in pairs(selectList)do
local guid=tostring(v[2])or 0
yetinTeam[guid]={i}
end
end
end
end
function xianjieModel:GetYetDizi_notboss(guid)
local guid_str=tostring(guid)
if not yetinTeam[guid_str]then
return 0
end
return yetinTeam[guid_str][1]
end


function xianjieModel:getShouMoteamData(listid)
local selectList=xianjieModel:getShouMolist(listid)
if not selectList or not next(selectList)then return end
local team={}
for i=1,5 do
local guid=selectList[i]and selectList[i][2]or 0
if guid then

local flag=xianjieModel:checkDzXJOccupy(guid)
if not flag then
team[i]=guid
else
team[i]=int64.zero
end
else
team[i]=int64.zero
end
end
return team
end


function xianjieModel:CheckHavedizi(listid,type)
if type==1 or type==2 then
local selectList=xianjieModel:getShouMolist(listid)
if not selectList or not next(selectList)then return 0 end
local havediziflag=0
for i=1,5 do
local guid=selectList[i]and selectList[i][2]or 0
if guid and not mathHelper.compareInt64(guid,Int64_0)then

local flag=xianjieModel:checkDzXJOccupy(guid)
if flag then
return-1
end
havediziflag=1
end
end
return havediziflag
elseif type==3 or type==16 then
local havediziflag=0
local team=xianjieModel:getShouMolist_boss(listid)
if not team or not next(team)then return 0 end
for i=1,5 do
local guid=team[1][i]or 0
if guid and not mathHelper.compareInt64(guid,Int64_0)then

local flag=xianjieModel:checkDzXJOccupy(guid)
if flag then
return-1
end
havediziflag=1
end
end
return havediziflag
end

end




function xianjieModel:saveRecord_boss()
local recordtable={}
for k,v in ipairs(shoumoBoss)do
if next(v)then
local dizitable={}
for a,b in ipairs(v[1])do
dizitable[#dizitable+1]=tostring(b)
end
recordtable[k]={dizitable,v[2],v[3]}
else
recordtable[k]={}
end
end
userActorSetting.set("xianjieShouMo_isBoss",recordtable)
userActorSetting.flush()
end
function xianjieModel:loadRecord_boss()
local Boss=userActorSetting.get("xianjieShouMo_isBoss",{})
for k,v in ipairs(Boss)do
if next(v)then
local dizitable={}
for a,b in pairs(v[1])do
dizitable[#dizitable+1]=int64.new(b)
end
shoumoBoss[k]={dizitable,v[2],v[3]}
end
end
end

function xianjieModel:saveShouMo_boss(listid,selectList,botid,selectMoneyList)
shoumoBoss[listid]={selectList,botid,selectMoneyList}
xianjieModel:SetSortTeamBoss()
xianjieModel:SetDiZiShouMo_boss()
xianjieModel:saveRecord_boss()
xianjieModel:SetYunzhouShouMo_boss()
end

function xianjieModel:getShouMolist_boss(listid)
return shoumoBoss[listid]
end


function xianjieModel:SetDiZiShouMo_boss()
yetinTeam_Boss={}
for i=1,4 do
local selectList=xianjieModel:getShouMolist_boss(i)
if selectList and next(selectList)then
for k,v in ipairs(selectList[1])do
local guid=tostring(v)or 0
yetinTeam_Boss[guid]={i}
end
end
end
end
function xianjieModel:GetYetDizi(guid)
local guid_str=tostring(guid)
if not yetinTeam_Boss[guid_str]then
return 0
end
return yetinTeam_Boss[guid_str][1]
end


function xianjieModel:SetYunzhouShouMo_boss()
yetUseYunzhou_Boss={}
for i=1,4 do
local selectList=xianjieModel:getShouMolist_boss(i)
if selectList and next(selectList)then
yetUseYunzhou_Boss[selectList[2]]=i
end
end
end

function xianjieModel:ClearYunzhouShouMo_bossByIndex(botid)
if yetUseYunzhou_Boss and next(yetUseYunzhou_Boss)then
yetUseYunzhou_Boss[botid]=0
end
end



function xianjieModel:GetYetYunzhou(botid)
if not yetUseYunzhou_Boss[botid]then
return 0
end
return yetUseYunzhou_Boss[botid]
end


function xianjieModel:GetXianJieOrder()
local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local shoulingOrder=order[16]
return shoulingOrder[1],shoulingOrder[2],shoulingOrder[3]
end





local _ShouMoDui_LastSelectType='ShouMoDui_LastSelectType'
function xianjieModel:recordlastSelectType(selectmonstertype,select_min,select_max,priSelect,moneyType,xm,logicScene)
recordSelectType={selectmonstertype,select_min,select_max,priSelect,moneyType,xm,logicScene}

userActorSetting.set(_ShouMoDui_LastSelectType,recordSelectType)
userActorSetting.flush()
end


function xianjieModel:GetrecordlastSelectType()
if not next(recordSelectType)then
recordSelectType=userActorSetting.get(_ShouMoDui_LastSelectType,{})
end

return recordSelectType
end


function xianjieModel:FindFirstDZ(listid,type)
if type==3 then

local selectList=xianjieModel:getShouMolist_boss(listid)
if selectList and next(selectList)and next(selectList[1])then
for k,v in ipairs(selectList[1])do
if not mathHelper.compareInt64(v,Int64_0)then
return v
end
end
end
else
local selectList=xianjieModel:getShouMolist(listid)
if selectList and next(selectList)then
for k,v in ipairs(selectList)do
if not mathHelper.compareInt64(v[2],Int64_0)then
return v[2]
end
end
end

end

end


function xianjieModel:SetSortTeam()
if isautoing then
return
end
local newtable={}
for k,v in ipairs(shoumolist)do
local listid=k

local flag=xianjieModel:CheckHavedizi(listid,1)
if flag==1 then
newtable[#newtable+1]={v,1000+#shoumolist-k}
elseif flag==-1 then
newtable[#newtable+1]={v,10+#shoumolist-k}
elseif flag==0 then
newtable[#newtable+1]={v,100+#shoumolist-k}
end
end
table.sort(newtable,function(a,b)
return a[2]>b[2]
end)
local newtable2={}
for k,v in ipairs(newtable)do
newtable2[#newtable2+1]=v[1]
end
shoumolist=newtable2
xianjieModel:SetDiZiShouMo_notboss()
end



function xianjieModel:SetSortTeamBoss()
if isautoing then
return
end

local newtable={}
for k,v in ipairs(shoumoBoss)do
local listid=k

local flag=xianjieModel:CheckHavedizi(listid,3)
if flag==1 then
newtable[#newtable+1]={v,1000+#shoumoBoss-k}
elseif flag==-1 then
newtable[#newtable+1]={v,10+#shoumoBoss-k}
elseif flag==0 then
newtable[#newtable+1]={v,100+#shoumoBoss-k}
end
end
table.sort(newtable,function(a,b)
return a[2]>b[2]
end)
local newtable2={}
for k,v in ipairs(newtable)do
newtable2[#newtable2+1]=v[1]
end
shoumoBoss=newtable2
xianjieModel:SetDiZiShouMo_boss()
end



local iswzsy=
{
[1]=true,
}

function xianjieModel:SetOpenAuto(flag)
autoflag=flag
end

function xianjieModel:GetOpenAuto()
return autoflag
end

function xianjieModel:SetAutoStage(flag)
isautoing=flag
UIManager:invokeUIMethod("UIXianJieMainWin",'refreshShouMoAuto')
end

function xianjieModel:GetAutoStage()
return isautoing
end

function xianjieModel:refreshNeedMoney()
local cangoteamnum=xianjieModel:getCanGoList()
local selectmonstertype=recordSelectType[1]
local priSelect=recordSelectType[4]
needmoney=0

if priSelect and selectmonstertype==1 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,10001)
local consume=cfg and cfg.consume
local cost=consume and consume[1][2]or 20
needmoney=cangoteamnum*cost
else
local cost=0
if selectmonstertype==1 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,1)
local consume=cfg and cfg.consume
cost=consume and consume[1][2]or 20
elseif selectmonstertype==2 then
local cfg=cfgHelper.get(cfg_fairylandmonsterresourceconfig_get,1)
local consume=cfg and cfg.costs
cost=consume and consume[2]or 20

elseif selectmonstertype==3 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig004_get,1)
local consume=cfg and cfg.consume
cost=consume and consume[1][2]or 30
elseif selectmonstertype==16 then
local cfg=cfgHelper.get(cfg_fairylandinfoconfig016_get,101)
local consume=cfg and cfg.consume
cost=consume and consume[1][2]or 25
end
needmoney=cangoteamnum*cost
end
return needmoney
end

function xianjieModel:getCanGoList()
local num=0
local selectmonstertype=recordSelectType[1]
for i=1,4 do
local havediziflag=xianjieModel:CheckHavedizi(i,selectmonstertype)
if havediziflag==1 then
num=num+1
end
end
return num
end



function xianjieModel:BeginBtn(notfirst)
if not notfirst then

yetGongji={}

recordrespointtable={}
peopleteam={}
yeteExploration={}
for i=1,4 do
yetGongji[i]={}
yeteExploration[i]={}
peopleteam[i]=true
end
end

local flag=false
local useRp=false
local haveteamCanGo=false
local haveteamGo=false
local selectmonstertype=recordSelectType[1]
local select_min=recordSelectType[2]
local select_max=recordSelectType[3]
local useMoneyId=recordSelectType[5]
local xm=recordSelectType[6]
local notshowtips=false

xianjieModel:refreshNeedMoney()

local moneyflag=moneySystem:useMoneys({{useMoneyId,needmoney}}
,function()
if flag then
return
end
flag=true
local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
local CangoMonster=xianjieModel:CheckMonster(selectmonstertype,select_min,select_max,xm)

local teamnum=0
local creatmontype=select_max


if selectmonstertype==1 then
for i=1,4 do
if peopleteam[i]then
local teamindex=i
local havediziflag=xianjieModel:CheckHavedizi(teamindex,1)
if havediziflag==1 then

local findflag=false

if#CangoMonster>=teamnum+1 then
teamnum=teamnum+1
if freeTeamCount<teamnum then
notshowtips=true
UIManager.info("行军队列不足")
return
end

for a=1,#CangoMonster do
local guid=CangoMonster[a][1]
if CangoMonster[a][3]==2 or CangoMonster[a][3]==1 then
local flag=xianjieModel:getWaiPaiByQBEntityData(guid)

if not flag then
local guid_str=tostring(guid)
if not yetGongji[i][tostring(guid)]then
local monsterData=xianjieModel:getMonsterDataEx(guid_str)
local flag_,g_list=monsterData:checkMovePathCondition()
if flag_==true then
xianjieModel:gotoBtn_Monster(guid,guid_str,i,g_list)
table.remove(CangoMonster,a)
haveteamGo=true
findflag=true
break
end
end
end
end
end
end

if not findflag then
local flagtype=xianjieModel:CheckCanGoMaxRp(creatmontype,teamindex)
if flagtype==1 then

useRp=true

haveteamGo=true
elseif flagtype==0 then
notshowtips=true
UIManager.info("宗门附近搜寻不到指定阶数的怪物")


peopleteam[i]=false

elseif flagtype==2 then

haveteamGo=true
elseif flagtype==-1 then
notshowtips=true

peopleteam[i]=false
end
creatmontype=creatmontype-1
end
elseif havediziflag==-1 then

if not notfirst then
peopleteam[i]=false
end
elseif havediziflag==0 then
peopleteam[i]=false
end
end
end

elseif selectmonstertype==2 then
for i=1,4 do
if peopleteam[i]then
local teamindex=i
local havediziflag=xianjieModel:CheckHavedizi(teamindex,2)
if havediziflag==1 then

local findflag=false

if#CangoMonster>=teamnum+1 then
teamnum=teamnum+1
if freeTeamCount<teamnum then
notshowtips=true
UIManager.info("行军队列不足")
return
end

for a=1,#CangoMonster do
local guid=CangoMonster[a][1]

local flag=xianjieModel:judeRpCanto(guid)
if flag then
if not yetGongji[teamindex][tostring(guid)]then
xianjieModel:gotoBtn(guid,teamindex)
table.remove(CangoMonster,a)
haveteamGo=true
findflag=true
break
end
end
end
end

if not findflag then
UIManager.info("宗门附近搜寻不到指定阶数的怪物")
peopleteam[i]=false
notshowtips=true
end
elseif havediziflag==-1 then

if not notfirst then
peopleteam[i]=false
end
elseif havediziflag==0 then
peopleteam[i]=false
end
end
end
elseif selectmonstertype==3 or selectmonstertype==16 then
local notneedshow=false
local soldierCountList_lookup,SoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)

for i=1,4 do
local teamindex=i
local havediziflag=xianjieModel:CheckHavedizi(teamindex,3)
if havediziflag==1 and peopleteam[i]then
local findflag=false


if#CangoMonster>=teamnum+1 then
teamnum=teamnum+1

if freeTeamCount<teamnum then
UIManager.info("行军队列不足")
return
end

for a=1,#CangoMonster do
local guid=CangoMonster[a][1]
local flag=xianjieModel:getWaiPaiByQBEntityData(guid)
if not flag then
local guid_str=tostring(guid)
if not yetGongji[i][guid_str]then
local monsterData=xianjieModel:getMonsterDataEx(guid_str)
local flag_,g_list=monsterData:checkMovePathCondition()
if flag_==true then
local needsold=xianjieModel:gotoBtn_Boss(guid,guid_str,i,SoldierCount,soldierCountList_lookup,g_list)
if not needsold or not next(needsold)then

peopleteam[i]=false
notneedshow=true
else
haveteamGo=true
for k,v in pairs(needsold)do
soldierCountList_lookup[k]=soldierCountList_lookup[k]-v
end

table.remove(CangoMonster,a)
findflag=true
end
break
end
end
end
end
end
if not findflag and not notneedshow then
notshowtips=true
UIManager.info("宗门附近搜寻不到指定阶数的怪物")

peopleteam[i]=false
end
elseif havediziflag==-1 then

if not notfirst then
peopleteam[i]=false
end
elseif havediziflag==0 then
peopleteam[i]=false
end
end
end
end,WARNING_TYPE.eWarning)
if shoumonumflag then
notifySystem:postNotify(notifyConfig.shoumolistNumChange)
end

flag=false
local enough=moneyModel.checkEnoughMoney(useMoneyId,needmoney)
if haveteamGo then
return haveteamGo
elseif not haveteamGo and enough then
if not notfirst and not notshowtips then
UIManager.info("没有空闲弟子可派遣")
end
end
if not enough then

xianjieModel:SetAutoStage(false)
return
end

local needcloseAuto=true
for k,v in ipairs(peopleteam)do
if v then

needcloseAuto=false
break
end
end
if needcloseAuto and isautoing then
UIManager.info("自动战斗停止")
xianjieModel:SetAutoStage(false)
end

end



function xianjieModel:CheckMonster(_monstertype,_minjjid,_maxjjid,xm)
local Raduis=xianjieModel:getFindDistanceRaduis(1)
local list=xianjieModel:findMonsterByDistance(Raduis)

local monstertype=_monstertype
local maxjjid=_maxjjid
local minjjid=_minjjid
local priSelect=recordSelectType[4]
local getlist={}
local tongjimaxnum=xianjieModel:getWantedMonsterTeamCount()
if monstertype==1 or monstertype==3 or monstertype==16 then
for i,infoguid in ipairs(list)do
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.infoid~=0 then

local flag=xianjieModel:getWaiPaiByQBEntityData(infoguid)
if not flag then
local cfg=monsterData:getCfg()
local type=cfg.type
local stage=cfg.stage
local dis=monsterData:getDistanc2ZongMen(true)
if not dis then
dis=-1
end
local isActive=true
local isCheckGate=true
local isPassSp=true
if monstertype==16 then
isActive=xianjieController:check_MoJieEntityHuJian_Unlock(monsterData.sceneidx,monsterData.gridX,monsterData.gridZ)
isCheckGate=xianjieController:check_MoJieEntityFight_Gate(monsterData.sceneidx,monsterData.gridX,monsterData.gridZ)

elseif monstertype==3 then

if xm and xm~=1 then
isPassSp=false
local xmType=xm-1
if cfg.xmFlag==xmType then
isPassSp=true
end
end
end

if((monstertype==type)or(monstertype==1 and(type==2 and priSelect)))and maxjjid>=stage and minjjid<=stage and isActive and isCheckGate and isPassSp then
table.insert(getlist,{infoguid,stage,type,dis})
end
end
end
end
elseif monstertype==2 then

local Pointlist=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMonster)
local zmData=xianjieModel:getMyZongMenData()
local sceneidx=zmData.sceneidx


for index,data in ipairs(Pointlist)do
if data.sceneidx==sceneidx then
local cango=xianjieModel:judeRpCanto(data.rpGuid)
local cfg=data:getCfg()
local shoumoStage=cfg.shoumoStage
local gridX_c=data.gridX_c
local gridZ_c=data.gridZ_c
local sceneidx=data.sceneidx
local dis=xianjieModel:getPointDistanc2ZongMen(sceneidx,gridX_c,gridZ_c,true)
if not dis then
dis=-1
end
local isActive=true
local isCheckGate=true
if xianjienSceneIndexType:isMoJie(sceneidx)then
isActive=xianjieController:check_MoJieEntityHuJian_Unlock(data.sceneidx,data.gridX,data.gridZ)
isCheckGate=xianjieController:check_MoJieEntityFight_Gate(data.sceneidx,data.gridX,data.gridZ)
end

local type=1.5
if shoumoStage and maxjjid>=shoumoStage and minjjid<=shoumoStage and cango and isActive and isCheckGate then
local rpGuid=data.rpGuid
table.insert(getlist,{rpGuid,shoumoStage,type,dis})
end
end
end
end

table.sort(getlist,function(a,b)
if priSelect then
if a[3]==2 and b[3]~=2 then
return true
elseif a[3]~=2 and b[3]==2 then
return false
end
end

if a[2]~=b[2]then
return a[2]>b[2]
else

if a[3]~=b[3]then
return a[3]>b[3]
else

if a[4]>0 and b[4]>0 then
return a[4]<b[4]
elseif a[4]>0 and b[4]<0 then
return true
else
return false
end
end

end
end)
local saichatable={}

if monstertype==1 and tongjimaxnum<4 then
for k,v in ipairs(getlist)do
local type=v[3]

if type==2 and tongjimaxnum>0 then
table.insert(saichatable,v)
tongjimaxnum=tongjimaxnum-1
elseif type~=2 then
table.insert(saichatable,v)
end
end
else
saichatable=getlist
end
return saichatable
end

function xianjieModel:getResPointIsVictor(rpGuid)
local data=xianjieModel:getResPointData(rpGuid)
local rpType=data.rpType
end



function xianjieModel:CheckCanGoMaxRp(creatmontype,teamindex)
local selectmonstertype=recordSelectType[1]
local select_min=recordSelectType[2]
local select_max=recordSelectType[3]
for i=creatmontype,select_min,-1 do

if iswzsy[selectmonstertype]then
local mysteryRPDatas=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMonster)
local zyishave=false
local zydata
for k,v in ipairs(mysteryRPDatas)do
local cfg=v:getCfg()
if v.source.srctype==3 then
if cfg.stage==i and cfg.type==selectmonstertype then
zyishave=true
zydata=v
break
end
end
end
if not zyishave then
local sceneidx=xianjieModel:getZongMenSceneidx()
if sceneidx then
local is_fairyland
if sceneidx==0 then
is_fairyland=1
elseif sceneidx>0 then
is_fairyland=2
end

recordrespointtable[#recordrespointtable+1]=teamindex
if not yeteExploration[teamindex][i]then
xianjieController:send_37_72(selectmonstertype,i,is_fairyland)
return 1
end
end
else
if zydata then
local flag=xianjieModel:judeRpCanto(zydata.rpGuid)
if flag then
if zydata.source.srctype==xjResPointSourceType.eExploration then
if not yeteExploration[teamindex][i]then
yeteExploration[teamindex][i]=true
if not yetGongji[teamindex][zydata.rpGuid]then
xianjieModel:gotoBtn(zydata.rpGuid,teamindex)
return 2
end
end
end
end
end
end
end
if i==select_min then
return-1
end
end
return 0
end


function xianjieModel:judeRpCanto(guid)
local rpData=xianjieModel:getResPointData(guid)
if not rpData then
return false
end
if rpData.deadTime then
return false
end
local wayTime=rpData:getBaseWayTime()
local nowTime=timeHelper.getServerShortTime()
if rpData.endTime>0 and rpData.endTime-nowTime<wayTime then
return false
else
if xianjieModel:haveResPointMarch(guid)then
return false
end
end
return true
end


function xianjieModel:gotoBtn_Monster(guid,guid_str,listid,g_list)
local selectList=xianjieModel:getShouMolistOnlyDiziGUID(listid)
local monsterData=xianjieModel:getMonsterDataEx(guid_str)
local cfg=monsterData:getCfg()
local monsterGroupId=cfg.monster[1]


local orderType=xjOrderType.eAttack
if monsterData.entitytype==xjServerEnityType.eMonsterHouse then
elseif monsterData.entitytype==xjServerEnityType.eBossMonster then
orderType=xjOrderType.eAttackBoss
end
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(orderType,true)
if not isChuZheng then
yetGongji[listid][guid_str]=true
if shoumonumflag then
shoumonum=shoumonum+1
end
xianjieController:reqOrder(int64.new(guid_str),orderType,selectList,{},nil,nil,nil,g_list)
UIManager.info(string.format("队伍已对%d阶魔物发起进攻",cfg.stage))
end
end


function xianjieModel:gotoBtn_Boss(guid,guid_str,listid,SoldierCount,soldierCountList_lookup,g_list)
local selectList=xianjieModel:getShouMolist_boss(listid)
local dizilist=selectList[1]
local boatId=selectList[2]
local selectMoneyList=selectList[3]
self:updateClientMoneyList(selectMoneyList,#dizilist)
local monsterData=xianjieModel:getMonsterDataEx(guid_str)

local cfg=monsterData:getCfg()
local flag=xianjieModel:checkXJYunZhouIsFree(boatId)
if not flag then
UIManager.info(FMT.fmt("队伍{0}云舟占用中",listid))
return nil
end
local needusebzidlist={}
for k,v in ipairs(selectMoneyList)do
local bzid=yunjiayingModel:getSoldierLevelByMoneyType(v[1])

if soldierCountList_lookup[bzid]<v[2]then
UIManager.info(FMT.fmt("队伍{0}中修士不足，无法出征",listid))
return nil
else
needusebzidlist[bzid]=v[2]
end
end

local orderType=xjOrderType.eAttackBoss
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(orderType,true)
if isChuZheng then
yetGongji[listid][guid_str]=true
if shoumonumflag then
shoumonum=shoumonum+1
end
xianjieController:reqOrder(int64.new(guid_str),orderType,dizilist,selectMoneyList,nil,boatId,nil,g_list)
UIManager.info(string.format("队伍已对%d阶魔物发起进攻",cfg.stage))
return needusebzidlist
end
end


function xianjieModel:gotoBtn(guid,listid)
local selectList=xianjieModel:getShouMolist(listid)
local rpData=xianjieModel:getResPointData(guid)
if not rpData then
UIManager.info("目标已不存在")
return
end

if rpData.deadTime then
UIManager.info("目标已死亡")
return
end
local wayTime=rpData:getBaseWayTime()
local nowTime=timeHelper.getServerShortTime()
local rpCfg=rpData:getCfg()
if rpData.endTime>0 and rpData.endTime-nowTime<wayTime then
UIManager.info("剩余时间不足以前往目标")
else
if not xianjieModel:haveResPointMarch(guid)then
yetGongji[listid][tostring(guid)]=true
if shoumonumflag then
shoumonum=shoumonum+1
end

xianjieController:doResPointMarchCreate(rpData,selectList)
UIManager.info(string.format("队伍已对%d阶魔物发起进攻",rpCfg.stage))
else
UIManager.info("已派遣队伍前往")
end
end
end

function xianjieModel:removeAutoTeam(etGuid)
if not isautoing then

xianjieModel:SetAutoStage(false)
return
end



local etGuidStr=tostring(etGuid)
for listid=1,4 do
local list=yetGongji[listid]
for guidStr,state in pairs(list)do
if etGuidStr==guidStr and peopleteam[listid]then

peopleteam[listid]=false
break
end
end
end
end

function xianjieModel:updateClientMoneyList(moneyList,dzCount)
if moneyList==nil or next(moneyList)==nil then
return
end

dzCount=dzCount or 1


if moneyList then
table.sort(moneyList,function(a,b)
if a and b then
return a[1]<b[1]
end
return false
end)

local jiJieAddCount=xianjieModel:getJiJieAddCount()*dzCount

local totalCount=0
for i=1,#moneyList do
local moneyType=moneyList[i][1]
local moneyCount=moneyList[i][2]
if moneyType and moneyCount then
totalCount=totalCount+moneyCount
end
end

local left=totalCount-jiJieAddCount
if left>0 then
for index=1,#moneyList do
if left>=moneyList[index][2]then
moneyList[index][2]=0
left=left-moneyList[index][2]
else
moneyList[index][2]=moneyList[index][2]-left
left=0
break
end
end
end
end
end

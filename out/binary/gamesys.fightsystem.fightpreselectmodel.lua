






local _MODULENAME="fightPreSelectModel"




gameState.addListener(def_table(_MODULENAME))
fightPreSelectModel.name=_MODULENAME
fightPreSelectModel.data={}

fightPreSelectModel.fightType={
zongmenMonster=1,
mystery=2,
worldMonster=3,
worldExperience=4,
worldExperienceBoss=5,
shilianta=6,

xiuZhenJiaZu=8,
wudaotang=9,
doufatai=10,
qiyuEvent=11,
monsterInvade=12,
test=13,
npcPK=14,
tuitu=15,
tianyuanshouchao=16,
worldLeader=17,
jiucengyaolou=18,
lundaodahui=19,
doufataidefense=20,
huanjing=21,
zongmendabi=22,
xianfawendao=23,
xianfawendaodefense=24,
xianmengdigong=25,
yunchengtanbao=26,
lingxuwenjian=27,
lieyaodui=28,
tianmoruqin_tm=29,
tianmoruqin_sj=30,
wuxingdian_gold=31,
wuxingdian_wood=32,
wuxingdian_water=33,
wuxingdian_fire=34,
wuxingdian_soil=35,
taigushilian=36,
yunyouMerchant=37,
fabaoshilian=38,
visitorChallenge=39,
zzshPvEMonster=40,
fuyaoshilian=41,
houshanzhenling=42,
zzshSetTeam=43,
longhuxiangyao=44,
systemZongMenAttack=45,
shanMenDaZhenDefense=44,
sifangpingyao=47,
dujiexiandan=48,
zhenyaoshilian=49,
tianmojie=50,
zzshPvEYPD=51,
xianjiePlotMonster=52,
xunbaoshilian=53,
wendingcangqiongteampre=54,
xianjieMonster=55,
wdcqxiweisaidefendteam=56,
wdcqxiweisaifightteam=57,
xianjieResPointMonster=58,
worldLeader2=59,
xianjiefumo=60,
xianjiefumo2=61,
xianguanwuxuan=62,
xingyupaiqian=63,
jiuyouta=64,
gubaoshilian=65,
yanfage=66,
lingShanZhengDuo=67,
setTeam=68,
xjCaravanEscortDefTeam=69,
xjCaravanEscortAtkTeam=70,
mingyuanzhusha=71,
}
eFightPreSelectType=fightPreSelectModel.fightType


fightPreSelectModel.teamEntityType={
empty=0,
dizi=1,
npc=2,
}
eTeamEntityType=fightPreSelectModel.teamEntityType


fightPreSelectModel.maxTeamNum=10

fightPreSelectModel.maxPosNum=5


function fightPreSelectModel.getNPCConfig(npcId)
return cfg_fightnpcconfig_get(npcId)
end

function fightPreSelectModel.getNPCMonster(npcId)
local id=tonumber(tostring(npcId))
local cfg=cfg_fightnpcconfig_get(id)
if cfg then
return cfg.monsterID
end
end


function fightPreSelectModel.getNPCOutSideModel(npcId)
local monsterid=fightPreSelectModel.getNPCMonster(npcId)
local cfg=cfg_monsterconfig_get(monsterid)
if cfg then
return cfg.modelid
end
end


function fightPreSelectModel.getNPCInSideModel(npcId)
local id=tonumber(tostring(npcId))
local cfg=cfg_fightnpcconfig_get(id)
if cfg then
local data={body=cfg.image[1]}
if cfg.image[2]then
data.componets={}
for i,v in ipairs(cfg.image[2])do
if v>0 then
table.insert(data.componets,v)
end
end
end
return data
end
end

function fightPreSelectModel.getNPCColor(npcId)
local id=tonumber(tostring(npcId))
local cfg=cfg_fightnpcconfig_get(id)
if cfg then
return cfg.color
end
end

function fightPreSelectModel.getNPCFightValue(npcId)
local id=tonumber(tostring(npcId))
local cfg=cfg_fightnpcconfig_get(id)
if cfg then
return cfg.fight
end
end

function fightPreSelectModel:getJobIconNameX(npcId)
local job=fightPreSelectModel.getNPCJob(npcId)
if job then
return UIDiscipleModel:getJobIconName(job)
end
end

function fightPreSelectModel.getNPCJob(npcId)
local id=tonumber(tostring(npcId))
local cfg=cfg_fightnpcconfig_get(id)
if cfg then
return cfg.job
end
end




function fightPreSelectModel:onAppStart()

end


function fightPreSelectModel:onEnterState()
self.checkMultiFightFlag=nil
self.data={}
self.data.teamPrefabData={}
self:initTeamData()
self.checkFightFlag={}
end


function fightPreSelectModel:onLeaveState()
self.checkMultiFightFlag=nil
if self.comfirmDialog then
local show_data=self.comfirmDialog
if show_data.dialog then
show_data.dialog:doClose()
else
show_data:deleteSelf()
end
end


self.data={}
end

function fightPreSelectModel:showProductiontips(name,okcallback,cancelback)


local productiontipsFlag=true

if not productiontipsFlag then


















local content=FMT.fmt("{0}目前正在生产中，确定派遣吗？\n（派遣结束后弟子自动恢复生产）",name or"")
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eFightPreSelectProduction,cancelback)
else
okcallback()
end
end

function fightPreSelectModel:showCheckFightTips(fightType,tips,okcallback,cancelback)

local enumName=FMT.fmt("fightcompare_{0}",fightType)
local checkFightFlag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,enumName)

if not checkFightFlag then


















UIDialogManager.getConfirmDialog3(nil,tips or'',okcallback,enumName,cancelback)
else
okcallback()
end
end

function fightPreSelectModel:showCheckMultiFightTips(tips,okcallback,cancelback)
local checkMultiFightFlag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eFightPreSelectMultiFight)

if not checkMultiFightFlag then


















UIDialogManager.getConfirmDialog3(nil,tips or'',okcallback,REPEAT_TYPE.eFightPreSelectMultiFight,cancelback)
else
okcallback()
end
end



function fightPreSelectModel:initTeamData()
self.data.teamData={}
self.data.zfData={}
local saveData=userActorSetting.get("FightTeamData",{})
if next(saveData)then
local fightType
local index
local guid
local zhenfaId
for _,data in ipairs(saveData)do
fightType=data[1]
index=data[2]
guid=int64.new(data[3])
self.data.teamData[fightType]=self.data.teamData[fightType]or{}
self.data.teamData[fightType].zhenfaId=zhenfaId
self.data.teamData[fightType][index]=guid
end
end
saveData=userActorSetting.get("FightZhenFaData",{})
if next(saveData)then
for _,data in ipairs(saveData)do
self.data.zfData[data[1]]=data[2]
end
end
end

function fightPreSelectModel:setTeamData(fightType,teamList,zhenfaId)
self.data.teamData=self.data.teamData or{}
self.data.teamData[fightType]=teamList
self.data.zfData[fightType]=zhenfaId
local saveData={}
if next(self.data.teamData)then
for fightType,data in pairs(self.data.teamData)do
if data then
for i,v in pairs(data)do
table.insert(saveData,{fightType,i,tostring(v)})
end
end
end
end
userActorSetting.flushVal("FightTeamData",saveData)

saveData={}
if next(self.data.zfData)then
for fightType,zhenfa in pairs(self.data.zfData)do
table.insert(saveData,{fightType,zhenfa})
end
end
userActorSetting.flushVal("FightZhenFaData",saveData)
end

function fightPreSelectModel:getTeamData(fightType)
self.data.teamData=self.data.teamData or{}
return self.data.teamData[fightType]
end

function fightPreSelectModel:getZhenFaData(fightType)
self.data.zfData=self.data.zfData or{}
return self.data.zfData[fightType]
end

function fightPreSelectModel:getTeamSendData(fightType)
local guidList=self:getTeamData(fightType)
if not guidList then
return
end
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end
return team
end

function fightPreSelectModel:clearMulTeamSaveData(fightType)
fightPreSelectModel:setMulTeamSaveData(fightType)
end

function fightPreSelectModel:setMulTeamSaveData(fightType,data,linggen)
if linggen then
fightPreSelectModel:setMulTeamSaveDataByLinggen(fightType,data,linggen)
return
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMulTeam,FMT.fmt("fightMulSelect_{0}_{1}",fightType,#data),data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMulTeam)
end

function fightPreSelectModel:getMulTeamSaveData(fightType,tNum)
local sdata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMulTeam,FMT.fmt("fightMulSelect_{0}_{1}",fightType,tNum),{})
local data={}
for i,v in ipairs(sdata)do
local pl={}
for k,vv in pairs(v)do
local ntype=eTeamEntityType.dizi
local guid=int64.new(k)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
pl[k]={vv,ntype,guid}
end
end
data[i]=pl
end

local len=#data
if len<tNum then
local dis=tNum-len
for i=1,dis do
table.insert(data,{})
end
elseif len>tNum then
for i=tNum+1,len do
data[i]=nil
end
end
return data
end

function fightPreSelectModel:setMulTeamSaveDataByLinggen(fightType,data,linggen)

userActorArraySetting.set(ACTOR_SETTING_TYPE.eMulTeam,FMT.fmt("fightMulSelect_{0}_linggen{1}",fightType,linggen),data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMulTeam)
end


function fightPreSelectModel:getMulTeamSaveDataByLinggen(fightType,linggen)
local sdata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMulTeam,FMT.fmt("fightMulSelect_{0}_linggen{1}",fightType,linggen),{})
local data={}
for i,v in ipairs(sdata)do
local pl={}
for k,vv in pairs(v)do
local ntype=eTeamEntityType.dizi
local guid=int64.new(k)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
pl[k]={vv,ntype,guid}
end
end
data[i]=pl
end
if#data<=0 then
table.insert(data,{})
end
return data
end

function fightPreSelectModel:getMulTeamSendData(fightType,tNum,mapId,zfId)
local guidList=self:getMulTeamSaveData(fightType,tNum)
if not guidList then
return
end
return self:getSendData(guidList,mapId,zfId)
end

function fightPreSelectModel:getSendData(guidList,mapId,zfId)
if not guidList then
return
end
local teamMul={}
local otherData={mapId or 0,zfId or 0}
local allNull=true
for i,v in ipairs(guidList)do
if allNull and next(v)then
allNull=false
end
local team={}
for i=1,fightPreSelectModel.maxPosNum do
team[i]={0,int64.zero}
end
for _,v2 in pairs(v)do
team[v2[1]]={v2[2],v2[3]}
end
teamMul[i]={#team,team,otherData}
end
if allNull then
return
end
return teamMul
end

function fightPreSelectModel:setTeamPrefab(index,teamName,teamList)
local team=self:getTeamPrefab(index)
if team then
if teamName then
team[1]=teamName
end
if teamList then
team[2]=teamList
end
end
end

function fightPreSelectModel:insertTeamPrefab(index,teamName,teamList)
self.data.teamPrefabData=self.data.teamPrefabData or{}
if index then
table.insert(self.data.teamPrefabData,index,{teamName,teamList})
else
table.insert(self.data.teamPrefabData,{teamName,teamList})
end
end

function fightPreSelectModel:removeTeamPrefab(index)
self.data.teamPrefabData=self.data.teamPrefabData or{}
table.remove(self.data.teamPrefabData,index)
end

function fightPreSelectModel:setTeamPrefabList(teamData)
self.data.teamPrefabData=teamData
end

function fightPreSelectModel:getTeamPrefabList()
return self.data.teamPrefabData or{}
end

function fightPreSelectModel:getTeamPrefab(index)
self.data.teamPrefabData=self.data.teamPrefabData or{}
return self.data.teamPrefabData[index]
end

function fightPreSelectModel:haveTeamPrefab(teamList)
local team
if self.data.teamPrefabData then
for i,v in ipairs(self.data.teamPrefabData)do
team=v[2]
if team then
if self.checkTeamArray(teamList,team)then
return i
end
end
end
end
end

function fightPreSelectModel.checkTeamArray(teamList1,teamList2)
if#teamList1~=#teamList2 then
return false
end
for i,v in ipairs(teamList1)do
if v~=teamList2[i]then
return false
end
end
return true
end


function fightPreSelectModel:saveTeamPrefabListData()
local nameData={}
local discipleData={}
local zfData={}
if self.data.teamPrefabData and next(self.data.teamPrefabData)then
for i,v in ipairs(self.data.teamPrefabData)do
table.insert(nameData,v[1])
table.insert(zfData,v[3]or 0)
for pos=1,5 do
if v[2][pos]then
table.insert(discipleData,v[2][pos])
else
table.insert(discipleData,int64.zero)
end
end

end
end
return nameData,discipleData,zfData
end


function fightPreSelectModel:loadTeamPrefabListData(nameData,discipleData,zfData)
self.data.teamPrefabData={}
local dataList={}
zfData=zfData or{}
if next(nameData)and next(discipleData)then
for i=1,#nameData do

dataList[i]={nameData[i],{},zfData[i]or 0}
end
local team={}
local index=1
local donthavedis=0
for i=1,#discipleData,5 do
if dataList[index]then
team={}
donthavedis=0
for ii=1,5 do
if UIDiscipleModel:getDiscipleData(discipleData[i+ii-1])then
table.insert(team,discipleData[i+ii-1])
else
donthavedis=donthavedis+1
table.insert(team,int64.zero)
end
end
if donthavedis<5 then
dataList[index][2]=team
else
dataList[index]=nil
end
end
index=index+1
end

for i,v in pairs(dataList)do
if v[2]then
table.insert(self.data.teamPrefabData,v)
end
end
end
end

function fightPreSelectModel.convertDisciple2FightStruct(disciples)
local list={}
for i,v in ipairs(disciples)do
if v>int64.zero then
table.insert(list,{1,v})
else
table.insert(list,{0,int64.zero})
end
end
return list
end

function fightPreSelectModel.convertDisciple2FightStruct2(disciples)
local list={}
for i,v in ipairs(disciples)do
if v>int64.zero then
table.insert(list,{unitType=1,unitId=v})
else
table.insert(list,{unitType=0,unitId=int64.zero})
end
end
return list
end

function fightPreSelectModel.convertFightStruct2Disciple(fightTeam)
local list={}
for i,v in ipairs(fightTeam)do
if v[1]==1 then
table.insert(list,v[2])
else
table.insert(list,int64.zero)
end
end
return list
end

function fightPreSelectModel.convertFightStruct2DiscipleMutli(fightTeam)

local list={}
for i,v in ipairs(fightTeam)do
for ii,vv in ipairs(v[2])do
if vv[1]==1 then
table.insert(list,vv[2])
else
table.insert(list,int64.zero)
end
end
end
return list
end

function fightPreSelectModel.getFightStructEmptyList(fightTeam,count)
local list={}
count=count or#fightTeam
for i=1,count do
local v=fightTeam[i]
if v then
local empty=true
for ii,vv in ipairs(v[2])do
if vv[1]~=eTeamEntityType.empty then
empty=false
break
end
end
if empty then
table.insert(list,i)
end
else
table.insert(list,i)
end
end
return list
end

function fightPreSelectModel:setTeamSeq(fightType,teamSeqList)
self.data.teamSeq=self.data.teamSeq or{}
self.data.teamSeq[fightType]=teamSeqList
local saveData={}
if next(self.data.teamSeq)then
for fightType,data in pairs(self.data.teamData)do
if data then
for i,v in ipairs(data)do
table.insert(saveData,{fightType,i,tostring(v)})
end
end
end
end
userActorSetting.flushVal("FightTeamData",saveData)
end















DISCIPLE_STATE_TYPE=
{
eFree=-1,
eOpenSF=0,
eOpenArea=1,
eCreateBuild=2,
eBuildUpLevel=3,
ePlantCreate=4,
edsDispatch=5,
dsDuJie=6,
eWuDao=7,
eShenWen=8,
eLianDan=9,
eChuiWei=10,
eStudying=11,
eInjuryChuiWei=12,
eShouYuanChuiWei=13,
eFanYan=14,
eQianRu=15,
eBeiBu=16,
eShangPu=17,
eWuDaoRuMo=18,
eFaBaoMake=19,
eYuFuMake=20,
eChuZheng=21,
eDuJieXianDan=22,
eMax=99,

getFreeName=function()
return'空闲'
end,
getName=function(self,v)
if v==self.eFree then
return self.getFreeName()
else
return cfgHelper.get2(cfg_disciplestateconfig_get,v,'name')
end
end,
isClientState=function(self,v)
return v>self.eMax
end,
}



DISCIPLE_CLIENT_STATE_TYPE=
{
eLowLoyalty=100,
ePlotDZ=101,
eSpecialDZ=102,
eDouFaTai=103,
eZongMenDaBi=104,
eHomeless=105,
eLunDaoDaHui=106,
eXMDGEvent=107,
eXianFaWenDao=108,
eLingXuWenJian=109,
eLingXuWenJian2=110,
eShopCtreate=111,
eZZSHDefTeam=112,
eLunDaoDaHuiLock=113,
eShanMenDaZhenTeam=114,
eWengDingCangQiong=115,
eWDCQXiWeiSai=116,
eXianJieYBD=117,
eXianJieDaZhen=118,
eXingYuTeamDz=119,
eShanHaiTeamDz=120,
eZaoWuGeDz=121,
eMXSLTeamDz=122,
}


eCheckDiscipleStateOpType=
{
eKickout=1,
eDispatch=2,
eProduce=3,
eWuDao=4,
eSelectWork=5,
eZuoHua=6,
eFireWork=7,
eYouLi=8,
eFeiSheng=9,
eQianRu=10,
eLianDan=11,
eLianQi=12,
eYuFu=13,
eDispatch2=14,
eLunDaoDispatch=15,
eFireHome=16,
eFireDaoLv=17,
}


DISCIPLE_CHUIWEI_TYPE=
{
eInjury=1,
eShouYuan=2,
}



local dzClientStateConfig={
[DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty]=
{
desc='忠诚度不足',
check=function(netData)
return UIDiscipleModel:checkLowLoyaltyByData(netData)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.ePlotDZ]={
check=function(netData)
return UIDiscipleModel:isPlotDiscipleByData(netData)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eSpecialDZ]={
check=function(netData)
local dzid=UIDiscipleModel:getDiscipleIDEx(netData)
local flag=cfgHelper.get2(cfg_discipleconfig_get,dzid,'flag')
return flag and bitHelper.check_pos(flag,0)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eDouFaTai]={
desc='防守阵容',
check=function(netData)
return douFaTaiModel:checkDiscipleInDefense(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eZongMenDaBi]={
desc='防守阵容',
check=function(netData)
return call_activitiesHandle_func('activitiesHandle_zongmendabi','checkInDefTeam',netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eHomeless]={
desc='暂无居所',
check=function(netData)
return not netData:check_in()
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHui]={
desc='论道大会阵容',
check=function(netData)
return lundaodahuiModel:isInTeam(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock]={
desc='弟子已锁定论道阵容，暂不可操作',
check=function(netData)
return lundaodahuiModel:isInTeam(netData.discipleguid)and
lundaodahuiModel:isPlayerInMatchMatchType()and lundaodahuiModel:checkMatchTimeBefore15Min()~=nil
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eXMDGEvent]={
desc='地宫事件中',
check=function(netData)
return xianmengdigongModel:checkDZInRoom(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eXianFaWenDao]={
desc='仙法问道阵容',
check=function(netData)
return UIXianFaWenDaoControl:isInTeamByStr(netData.discipleguidStr)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian]={
desc='防守阵容',
check=function(netData)
return lingxuwenjianModel:checkInDefTeam(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian2]={
desc='问剑阵容',
check=function(netData)
return lingxuwenjianModel:checkInDefTeam2(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eShopCtreate]={
desc='商铺生产中',
check=function(netData)
local bdData=zongmenModel:getDiscipleWorkroomByData(netData)
if not bdData then
return false
end
return UIShopControl:checkCreating(bdData)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eZZSHDefTeam]={
desc='征战山海阵容',
check=function(netData)
return zhengzhanshanhaiModel:checkInDefTeam(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eShanMenDaZhenTeam]={
desc='大阵驻守中',
check=function(netData)
return shanMenDaZhenModel:checkDzInDaZhenTeamByGuid(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eWengDingCangQiong]={
desc='问鼎苍穹阵容',
check=function(netData)
return WDCQController.checkSysDz(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eWDCQXiWeiSai]={
desc='席位赛阵容',
check=function(netData)
return XiWeiSaiController.checkSysDz(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eXianJieYBD]={
desc='仙界预备队中',
check=function(netData)
return xianjieModel:checkJiJieYBDData_dzIsInYBD(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eXianJieDaZhen]={
desc='仙界护山大阵中',
check=function(netData)
return tianshudazhenModel:isZhuShouDZ(netData.discipleguidStr)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eXingYuTeamDz]={
desc='星域派遣中',
check=function(netData)
return XingYuController.checkXingYuDz(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eShanHaiTeamDz]={
desc='山海预备队',
check=function(netData)
return zhengzhanshanhaiModel:checkIsZZSHYbd_DZ(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eZaoWuGeDz]={
desc2=function()
return zaoWuGeModel:getBuildingProgress_isWork()
end,
check=function(netData)
return zaoWuGeModel:checkisBuildDisciple(netData.discipleguid)
end,
},
[DISCIPLE_CLIENT_STATE_TYPE.eMXSLTeamDz]={
desc='护送队伍中',
check=function(netData)
return xianJieCaravanEscortModel:checkDZIsInPaiQian(netData.discipleguid)
end,
},
}





local dzStateOpTypeConfig={
[eCheckDiscipleStateOpType.eKickout]={
stateType=nil,
target='kickout',
extra={DISCIPLE_CLIENT_STATE_TYPE.ePlotDZ,DISCIPLE_CLIENT_STATE_TYPE.eSpecialDZ,
DISCIPLE_CLIENT_STATE_TYPE.eDouFaTai,DISCIPLE_CLIENT_STATE_TYPE.eZongMenDaBi,
DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHui,DISCIPLE_CLIENT_STATE_TYPE.eXMDGEvent,
DISCIPLE_CLIENT_STATE_TYPE.eXianFaWenDao,DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian,
DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian2,DISCIPLE_CLIENT_STATE_TYPE.eZZSHDefTeam,
DISCIPLE_CLIENT_STATE_TYPE.eShanMenDaZhenTeam,DISCIPLE_CLIENT_STATE_TYPE.eWengDingCangQiong,
DISCIPLE_CLIENT_STATE_TYPE.eWDCQXiWeiSai,DISCIPLE_CLIENT_STATE_TYPE.eXianJieYBD,DISCIPLE_CLIENT_STATE_TYPE.eXianJieDaZhen,
DISCIPLE_CLIENT_STATE_TYPE.eXingYuTeamDz,DISCIPLE_CLIENT_STATE_TYPE.eShanHaiTeamDz,
DISCIPLE_CLIENT_STATE_TYPE.eZaoWuGeDz,DISCIPLE_CLIENT_STATE_TYPE.eMXSLTeamDz,
},
},
[eCheckDiscipleStateOpType.eZuoHua]={
stateType=nil,
target='kickout',
extra={DISCIPLE_CLIENT_STATE_TYPE.ePlotDZ,DISCIPLE_CLIENT_STATE_TYPE.eSpecialDZ,
DISCIPLE_CLIENT_STATE_TYPE.eDouFaTai,DISCIPLE_CLIENT_STATE_TYPE.eZongMenDaBi,
DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHui,DISCIPLE_CLIENT_STATE_TYPE.eXMDGEvent,
DISCIPLE_CLIENT_STATE_TYPE.eXianFaWenDao,DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian,
DISCIPLE_CLIENT_STATE_TYPE.eLingXuWenJian2,DISCIPLE_CLIENT_STATE_TYPE.eZZSHDefTeam,
DISCIPLE_CLIENT_STATE_TYPE.eShanMenDaZhenTeam,DISCIPLE_CLIENT_STATE_TYPE.eWengDingCangQiong,
DISCIPLE_CLIENT_STATE_TYPE.eWDCQXiWeiSai,DISCIPLE_CLIENT_STATE_TYPE.eXianJieYBD,DISCIPLE_CLIENT_STATE_TYPE.eXianJieDaZhen,
DISCIPLE_CLIENT_STATE_TYPE.eXingYuTeamDz,DISCIPLE_CLIENT_STATE_TYPE.eMXSLTeamDz,
},
},
[eCheckDiscipleStateOpType.eWuDao]={
stateType=DISCIPLE_STATE_TYPE.eWuDao,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eSelectWork]={
stateType=nil,
target='manage',
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless,DISCIPLE_CLIENT_STATE_TYPE.eShopCtreate},
},
[eCheckDiscipleStateOpType.eFireWork]={
stateType=nil,
target='manage',
extra={DISCIPLE_CLIENT_STATE_TYPE.eShopCtreate},
},
[eCheckDiscipleStateOpType.eYouLi]={
stateType=DISCIPLE_STATE_TYPE.edsDispatch,
target=nil,
extra={DISCIPLE_STATE_TYPE.edsDispatch,DISCIPLE_CLIENT_STATE_TYPE.eHomeless,
DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty},
},
[eCheckDiscipleStateOpType.eFeiSheng]={
stateType=DISCIPLE_STATE_TYPE.dsDuJie,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eProduce]={
stateType=DISCIPLE_STATE_TYPE.ePlantCreate,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eQianRu]={
stateType=DISCIPLE_STATE_TYPE.eQianRu,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eDispatch]={
stateType=DISCIPLE_STATE_TYPE.edsDispatch,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eLianDan]={
stateType=DISCIPLE_STATE_TYPE.eLianDan,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eLianQi]={
stateType=DISCIPLE_STATE_TYPE.eFaBaoMake,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eYuFu]={
stateType=DISCIPLE_STATE_TYPE.eYuFuMake,
target=nil,
extra={DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eDispatch2]={
stateType=DISCIPLE_STATE_TYPE.edsDispatch,
target=nil,
extra={DISCIPLE_STATE_TYPE.edsDispatch,DISCIPLE_CLIENT_STATE_TYPE.eLowLoyalty,DISCIPLE_CLIENT_STATE_TYPE.eHomeless},
},
[eCheckDiscipleStateOpType.eFireHome]={
stateType=nil,
target='fire',
},
[eCheckDiscipleStateOpType.eFireDaoLv]={
stateType=nil,
target='firedl',
},

}

function UIDiscipleModel:checkDZStateToDoSomethingByData(netData,opType,isWarning)
if netData==nil then return false end

if self.stateConflicts==nil or self.stateConflicts[opType]==nil then
local cfg=dzStateOpTypeConfig[opType]
local conflicts={}
if cfg then

if cfg.stateType then
local temp=cfgHelper.get2(cfg_disciplestateconfig_get,cfg.stateType,'conflicts')
if temp then
for i,stateType_ in ipairs(temp)do

table.insert(conflicts,stateType_)
end
end
elseif cfg.target then
local temp=cfg_disciplestateconfig()
for k,v in pairs(temp)do
if v.id~=nil then
if v[cfg.target]==true then

table.insert(conflicts,v.id)
end
end
end
end
if cfg.extra then
for i,stateType_ in ipairs(cfg.extra)do

table.insert(conflicts,stateType_)
end
end



else



return false,nil
end
self.stateConflicts=self.stateConflicts or{}
self.stateConflicts[opType]=conflicts
end
if netData then
local conflicts=self.stateConflicts[opType]
if#conflicts>0 then
local flag,code=UIDiscipleModel:checkDiscipleState3(netData,conflicts,isWarning,opType)
if flag then
return false,code
end
end
return true,nil
end
return false,nil
end



function UIDiscipleModel:checkDZStateToDoSomething(guid,opType,isWarning)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:checkDZStateToDoSomethingByData(netData,opType,isWarning)
end


function UIDiscipleModel:getDiscipleState(guid)
return UIDiscipleModel:getDiscipleStateByStr(tostring(guid))
end

function UIDiscipleModel:getDiscipleStateByStr(strGuid)
local result=UIDiscipleModel:getDiscipleStateXByStr(strGuid)
if#result>0 then
return result[1]
end
return DISCIPLE_STATE_TYPE.eFree
end

function UIDiscipleModel:getDiscipleStateX(guid)
return UIDiscipleModel:getDiscipleStateXByStr(tostring(guid))
end

function UIDiscipleModel:getDiscipleStateXByStr(strGuid)
local netData=UIDiscipleModel:getDiscipleDataByStr(strGuid)
if netData~=nil then
local state=netData.state
local cfgs=cfg_disciplestateconfig()
local weight=-1
local weightlist={}
for k,v in pairs(cfgs)do
if mathHelper.getBitValue(state,v.id)then
if weightlist[v.priority_weight]==nil then
weightlist[v.priority_weight]={}
end
table_insert(weightlist[v.priority_weight],v.id)
if v.priority_weight>weight then
weight=v.priority_weight
end
end
end
if weight>=0 then
return weightlist[weight]
end
end
return{}
end


function UIDiscipleModel:getDiscipleStateDesc(guid,empty_str,free_str,nohome_str)
empty_str=empty_str or'　'
local state=UIDiscipleModel:getDiscipleState(guid)
if state~=DISCIPLE_STATE_TYPE.eFree then
local str=DISCIPLE_STATE_TYPE:getName(state)
if pfwindowslController.checkIsGameVersion_yuenan()then
if state==DISCIPLE_STATE_TYPE.ePlantCreate then
return str
end
end
local pre_str=UIDiscipleModel:getDisciplestateDescPrefixes(guid,state)
if pre_str~=nil then
str=FMT.fmt('{0}{1}{2}',pre_str,empty_str,str)
end
return str
end


local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then
local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if bd_cfg.func_type==4 then

return bd_cfg.name
else
local str=FMT.fmt('{0}{1}空闲',bd_cfg.name,empty_str)
return str
end
else
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData:check_in()then
local cszData=chuanSongZhenModel:findDiscipleData(guid)
if cszData~=nil then
return"游历中"
else
return free_str or DISCIPLE_STATE_TYPE.getFreeName()
end
else
return nohome_str or'暂无居所'
end
end
end

function UIDiscipleModel:getDiscipleStateDesc2(guid)
local state=UIDiscipleModel:getDiscipleState(guid)
local posStr=nil
if state==DISCIPLE_STATE_TYPE.edsDispatch then

local taskKey=worldTaskModel:findTaskKey_ByDiscipleGUID(guid)
local task=taskKey and worldTaskModel:getTask(taskKey)or nil
if task then
if task.target_type==eWorldUnitTpye.MYSTERY then

local fbId=task.target_id
local cfg_fb=cfg_secretscenefubenconfig_get(fbId)
posStr=FMT.fmt("正在　{0}　",cfg_fb.name)

elseif task.target_type==eWorldUnitTpye.TOURPOINT then



posStr="正在　传送阵　"
elseif task.target_type==eWorldUnitTpye.EXPERIENCE then

local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,task.target_id)
if fogCfg then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,fogCfg.world,fogCfg.block)
posStr=FMT.fmt("正在　{0}　",blockCfg.name)
end

elseif task.target_type==eWorldUnitTpye.MONSTER then

local monsterGuid=task.target_guid
local monsterData=worldMonsterModel:get_monster(monsterGuid)
if monsterData then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,monsterData.worldId,monsterData.blockId)
posStr=FMT.fmt("正在　{0}　",blockCfg.name)
else
local v3,blockId=worldPositionConfig:getPosition(task.world,{task.destination.x,task.destination.y})
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,task.world,blockId)
posStr=FMT.fmt("正在　{0}　",blockCfg.name)
end

elseif task.target_type==eWorldUnitTpye.RESPOINT or task.target_type==eWorldUnitTpye.FAMILY then

local v3,blockId=worldPositionConfig:getPosition(task.world,{task.destination.x,task.destination.y})
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,task.world,blockId)
posStr=FMT.fmt("正在　{0}　",blockCfg.name)
elseif task.target_type==eWorldUnitTpye.RESMYSTERY then

posStr=FMT.fmt("正在　派遣中　")
elseif task.target_type==eWorldUnitTpye.HUNTMONSTERTEAM then
posStr=FMT.fmt("正在　猎妖中　")
end
else

posStr=FMT.fmt("正在　派遣中　")
end

elseif state==DISCIPLE_STATE_TYPE.eQianRu or state==DISCIPLE_STATE_TYPE.eBeiBu then


local zmData=systemZongMenModel:findInfoDataByDisciple(guid)
if zmData then
local zmName=systemZongMenModel:getInfoDataName(zmData.serial)
posStr=FMT.fmt("正在　{0}　",zmName)
else
if state==DISCIPLE_STATE_TYPE.eQianRu then
posStr=FMT.fmt("正在　潜入中　")
elseif state==DISCIPLE_STATE_TYPE.eBeiBu then
posStr=FMT.fmt("正在　被捕中　")
end
end
elseif state==DISCIPLE_STATE_TYPE.eWuDao or state==DISCIPLE_STATE_TYPE.eWuDaoRuMo then
local bdId=SLG_SYSTEM_TYPE.eWuDaoTang
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
posStr=FMT.fmt("正在　{0}　",cfg.name)
else

local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then

local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
posStr=FMT.fmt("正在　{0}　",bd_cfg.name)
else

if state~=DISCIPLE_STATE_TYPE.eFree then
local str=DISCIPLE_STATE_TYPE:getName(state)
local pre_str=UIDiscipleModel:getDisciplestateDescPrefixes(guid,state)
if pfwindowslController:checkIsGameVersion_yuenan()then
if pre_str~=nil then
posStr=FMT.fmt('{0}{1}',pre_str,str)
else
posStr=FMT.fmt('{0}',str)
end
else
if pre_str~=nil then
posStr=FMT.fmt('{0}{1}{2}',pre_str,'　',str)
else
posStr=FMT.fmt('{0}{1}{2}','　',str,'　')
end
end
else
local cszData=chuanSongZhenModel:findDiscipleData(guid)
if cszData then
posStr="正在　游历中　"
else
posStr="　空闲　　"
end
end
end
end
return posStr
end

function UIDiscipleModel:getDisciplestateDescPrefixes(guid,stateType)
local pre=UIDiscipleModel:getDiscipleStateData(guid,stateType)
if pre~=nil then
if stateType==DISCIPLE_STATE_TYPE.ePlantCreate then
return cfgHelper.get2(cfg_monijybuildconfig_get,pre.buildingId,'name')
elseif stateType==DISCIPLE_STATE_TYPE.edsDispatch then
local n=worldModel.UNITTYPENAME[pre[1]]
if n~=nil then
return n
end
end
end
return nil
end


function UIDiscipleModel:setDiscipleStateData(guid,stateType,data)
assert(guid~=nil)
if stateType==nil then
return
end

UIDiscipleModel:init()

local k=tostring(guid)
assert(tonumber(k)>0)
local all=UIDiscipleModel:getAllDiscipleDataX()
local f=all[k]
if f==nil then
f={}
all[k]=f
end
if f.stateData==nil then
f.stateData={}
end
f.stateData[stateType]=data
end

function UIDiscipleModel:getDiscipleStateData(guid,stateType)
local data=UIDiscipleModel:getDiscipleDataX(guid)
if data and data.stateData then
return data.stateData[stateType]
end
return nil
end



function UIDiscipleModel:checkDiscipleState(guid,stateType)
return UIDiscipleModel:getDiscipleState(guid)==stateType
end


function UIDiscipleModel:checkDiscipleState2ByData(netData,stateType)
if netData~=nil then
local state=netData.state
local isFree=state==0
if isFree then
return stateType==DISCIPLE_STATE_TYPE.eFree
else
return mathHelper.getBitValue(state,stateType)
end
end
return false
end


function UIDiscipleModel:checkDiscipleState2(guid,stateType)
return UIDiscipleModel:checkDiscipleState2ByStr(tostring(guid),stateType)
end

function UIDiscipleModel:checkDiscipleState2ByStr(strGuid,stateType)
local netData=UIDiscipleModel:getDiscipleDataByStr(strGuid)
return UIDiscipleModel:checkDiscipleState2ByData(netData,stateType)
end


function UIDiscipleModel:checkDZClientStateByData(netData,stateType)
local lp=dzClientStateConfig[stateType]
if lp then
return lp.check(netData)
else



return false
end
end


function UIDiscipleModel:checkDZClientState(guid,stateType)
local lp=dzClientStateConfig[stateType]
if lp then
local netData=self:getDiscipleData(guid)
return lp.check(netData)
else



return false
end
end


function UIDiscipleModel:checkDZClientStateDesc(stateType)
local lp=dzClientStateConfig[stateType]
if lp then
if lp.desc2 then
return lp.desc2()
end
return lp.desc
else



return false
end
end


function UIDiscipleModel:checkDiscipleFightPriorityState(stateType)
if stateType==DISCIPLE_STATE_TYPE.eFree then
return true
end
local check=cfgHelper.get2(cfg_disciplestateconfig_get,stateType,'cantFightPriority')
return not check
end

function UIDiscipleModel:checkDiscipleFightPriorityStateEx(guid)
local state=UIDiscipleModel:getDiscipleState(guid)
return self:checkDiscipleFightPriorityState(state)
end




function UIDiscipleModel:checkDiscipleState3(netData,stateTypeList,isWarning,opType)
for i,stateType_ in ipairs(stateTypeList)do
local check=false
if DISCIPLE_STATE_TYPE:isClientState(stateType_)then
check=UIDiscipleModel:checkDZClientStateByData(netData,stateType_)
else
check=UIDiscipleModel:checkDiscipleState2ByData(netData,stateType_)
end
if check then
if isWarning==true and opType~=nil then
local tipstr=UIDiscipleModel:getStateTipsStr(netData.discipleguid,opType,stateType_)
if tipstr~=nil then
UIManager.error(tipstr)
end
end
return true,stateType_
end
end
return false,nil
end


function UIDiscipleModel:getStateTipsStr(guid,opType,stateType)
local cfg=cfgHelper.get1(cfg_disciplestatelangconfig_get,opType)
if cfg then
local statekey='state'..stateType
local statestr=cfg[statekey]
if statestr==nil then
local fmtstr=cfgHelper.getdef1(cfg_disciplestatelangconfig,'defaultstate')
if not DISCIPLE_STATE_TYPE:isClientState(stateType)then
statestr=FMT.fmt(fmtstr,DISCIPLE_STATE_TYPE:getName(stateType),cfg.name)
else
local name=cfgHelper.getdef1(cfg_disciplestatelangconfig,statekey)
statestr=FMT.fmt(fmtstr,name,cfg.name)
end
else
if string.find(statestr,'{0}')then
statestr=FMT.fmt(statestr,UIDiscipleModel:getDiscipleName(guid)or'未知弟子')
end
end
return statestr
end
return nil
end

function UIDiscipleModel:onDiscipleStateChange(guid,old,cur)
if old==cur then return end

local cfgs=cfg_disciplestateconfig()
for k,v in pairs(cfgs)do
local stateType=v.id
local o=mathHelper.getBitValue(old,stateType)
local c=mathHelper.getBitValue(cur,stateType)
if o~=c then
notifySystem:postNotify(notifyConfig.onDiscipleStateChange,guid,stateType,o,c)


local needFresh=stateType==DISCIPLE_STATE_TYPE.eChuiWei
if needFresh then
local bdData=zongmenModel:getRoomBuildDataByDzId(guid)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end
end
end


function UIDiscipleModel:checkInjuryFushangType(guid)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
return injury>0
end


function UIDiscipleModel:checkInjuryChuiWeiType(guid)
return UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eInjuryChuiWei)
end


function UIDiscipleModel:checkShouYuanChuiWeiType(guid)
return UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eShouYuanChuiWei)
end

function UIDiscipleModel:checkChuiWeiDiscipleType(guid)
local checkChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
if checkChuiwei then
local config=cfgHelper.get1(cfg_discipledyingconfig_get,1)
local injurySec=config.injury
local shouyuanSec=config.shouyuan
local chuiweiByShouyuan=UIDiscipleModel:checkShouYuanChuiWeiType(guid)
local chuiweiByInjury=UIDiscipleModel:checkInjuryChuiWeiType(guid)
local chuiweiType
local num=0
if chuiweiByShouyuan then
chuiweiType=DISCIPLE_CHUIWEI_TYPE.eShouYuan
num=num+1
end
if chuiweiByInjury then
if chuiweiType==nil then
chuiweiType=DISCIPLE_CHUIWEI_TYPE.eInjury
end
num=num+1
end
return chuiweiType,num
end
end


function UIDiscipleModel:getStateCnt(state)
local list=UIDiscipleModel:getAllDiscipleDataX()
if list then
local num=0
for _,v in pairs(list)do
local guid=v.netData.net.discipleguid
if UIDiscipleModel:checkDiscipleState2(guid,state)then
num=num+1
end
end
return num
end
return 0
end

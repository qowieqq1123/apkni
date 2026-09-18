




newbieConfig={}

local _idx=0
local _getIdx=function()
_idx=_idx+1
return _idx
end

NEW_BIE_TYPE=
{
eMain=1,
eBranch=2,
}

NEW_BIE_STATE=
{
eUnStart=_getIdx(),
eReady=_getIdx(),
eStart=_getIdx(),
eRun=_getIdx(),
eOk=_getIdx(),
eErr=_getIdx(),
eSkip=_getIdx(),
}

_idx=0

NEW_BIE_TRIGGER_TYPE=
{
eAuto=_getIdx(),
eClick=_getIdx(),
}

NEW_BIE_ACTION_TYPE=
{
eUI=_getIdx(),
eEntity=_getIdx(),
eWin=_getIdx(),
}

_idx=0

NEW_BIE_CND_TYPE=
{
eVip=_getIdx(),
eActiveSystem=_getIdx(),
eAcceptTask=_getIdx(),
eDoTask=_getIdx(),
eNotAcceptTask=_getIdx(),
eFinshTask=_getIdx(),
eLevel=_getIdx(),
eItem=_getIdx(),
eEnterScene=_getIdx(),
eLuaFun=_getIdx(),
eSuoyaotaBalance=_getIdx(),
eOpenWindow=_getIdx(),
eWorldBlock=_getIdx(),
eStartExperience=_getIdx(),
eMysteryEvent=_getIdx(),
eFinishNewbie=_getIdx(),
eEndExperience=_getIdx(),
eStoryTree=_getIdx(),
eZheXianLing=_getIdx(),
eNextNewbie=_getIdx(),
}

_idx=0
NEW_BIE_ENTITY_LUA_FUNC_TYPE=
{
eBuild=_getIdx(),
eMysteryGround=_getIdx(),
eFightPrepare=_getIdx(),
eSundrise=_getIdx(),
eXiufuBuild=_getIdx(),
eWorldEntityName=_getIdx(),
eHomeEntityByPosition=_getIdx(),
eWorldEntity=_getIdx(),
eAnyBuild=_getIdx(),
eZongMenVisitor=_getIdx(),
eYunYouMerchant=_getIdx(),
eXGSZ=_getIdx(),
eDanLing=_getIdx(),
eXianJiePos=_getIdx(),
eXianJieResPoint=_getIdx(),
eXianJieUnlockCloud=_getIdx(),
}

_idx=0
NEWBIE_SKIP_FUNC_TYPE=
{
eTask=_getIdx(),
eBuildNoDZ=_getIdx(),
eLimitAPILEVEL=_getIdx(),
eExistChuanSongZhenDisciple=_getIdx(),
eRaiseFish=_getIdx(),
eSetDefense=_getIdx(),
eWinHasDZ=_getIdx(),
eCanNotProduct=_getIdx(),
eCanNotLianZhiFaBao=_getIdx(),
eCanNotLianZhiFuLu=_getIdx(),
eFightPrepareNoDz=_getIdx(),
eFaBaoShiLian=_getIdx(),
elvfaAnPaiDZ=_getIdx(),
eDouFaTaiXiuXi=_getIdx(),
eHasAnyAnPaiDZ=_getIdx(),
eHasGuPiaoDAta=_getIdx(),
eBuildNum=_getIdx(),
}

_idx=0
NEWBIE_POSITIPN_TYPE=
{
eZongmen=_getIdx(),
eMystery=_getIdx(),
eWorld=_getIdx(),
}

local _actionDirectory='lua.gamesys/newbieSystem/newbieAction/'

function newbieConfig.loadAction(name)
local src=FMT.fmt('{0}{1}',_actionDirectory,name)
refSrcConfig[name]=src
require(src)
end

function newbieConfig.isBranchNewbieId(newbieId)
return newbieId>=500000
end

function newbieConfig.getNewbieConfig(newbieId)
if newbieConfig.isBranchNewbieId(newbieId)then
return cfg_newbiebranchconfig_get(newbieId)
end
return cfg_newbieconfig_get(newbieId)
end

function newbieConfig.getNewbieAction(actionid)
return cfg_newbieaction_get(actionid)
end

function newbieConfig.getNewbieActionListByIndex(newbieId,stepIdx)
local conf=newbieConfig.getNewbieConfig(newbieId)
return conf and conf.mActions and conf.mActions[stepIdx]
end

function newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
local list=newbieConfig.getNewbieActionListByIndex(newbieId,stepIdx)
return list and list[index]
end

function newbieConfig.getNewbieActionConfigByIndex(newbieId,stepIdx,index)
local actionid=newbieConfig.getNewbieActionIdByIndex(newbieId,stepIdx,index)
if actionid then
return newbieConfig.getNewbieAction(actionid)
end
end

function newbieConfig.getTaskNewBieType(taskstate)
local typo=nil
if taskstate==taskModel.taskAcceptState then
typo=NEW_BIE_CND_TYPE.eNotAcceptTask
elseif taskstate==taskModel.taskDoingState then
typo=NEW_BIE_CND_TYPE.eAcceptTask
elseif taskstate==taskModel.taskRewardState then
typo=NEW_BIE_CND_TYPE.eDoTask
else
typo=NEW_BIE_CND_TYPE.eFinshTask
end
return typo
end

function newbieConfig.getNextNewbie(newbieId)
local cfg=newbieConfig.getNewbieConfig(newbieId)
return cfg.nextid
end








newbieModel={}




local _data={}

local _config={}
_config.isInit=false
_config.isInitBranch=false
_config.levelConfig={}
_config.vipLevelConfig={}
_config.notaccpetTaskConfig={}
_config.accpetTaskConfig={}
_config.doingTaskConfig={}
_config.finishTaskConfig={}
_config.activeSystemConfig={}
_config.itemConfig={}
_config.suoyaotaBalanceConfig={}
_config.sceneConfig={}
_config.groupConfig={}
_config.openWindowConfig={}
_config.luaConfig={}
_config.worldBlockConfig={}
_config.startExperienceConfig={}
_config.endExperienceConfig={}
_config.mysteryEventConfig={}
_config.storyTreeEventConfig={}
_config.zxlConfig={}
_config.nextNewbieConfig={}

_config.finishNewbieConfig={}

_config.branchConfig={}
_config.branchConfig.notaccpetTaskConfig={}
_config.branchConfig.accpetTaskConfig={}
_config.branchConfig.doingTaskConfig={}
_config.branchConfig.finishTaskConfig={}
_config.branchConfig.luaConfig={}
_config.branchConfig.openWindowConfig={}
_config.branchConfig.zxlConfig={}
_config.branchConfig.levelConfig={}
_config.branchConfig.vipLevelConfig={}
_config.branchConfig.activeSystemConfig={}
_config.branchConfig.itemConfig={}
_config.branchConfig.suoyaotaBalanceConfig={}
_config.branchConfig.sceneConfig={}
_config.branchConfig.groupConfig={}
_config.branchConfig.worldBlockConfig={}
_config.branchConfig.startExperienceConfig={}
_config.branchConfig.endExperienceConfig={}
_config.branchConfig.mysteryEventConfig={}
_config.branchConfig.storyTreeEventConfig={}
_config.branchConfig.nextNewbieConfig={}

local _lookupWinName={}
local _openData=nil

local _skipAllNewBie=false


function newbieModel.initData()
_data={}
_data.isInit=false
_data.isInitBranch=false
_data.newbieId=0
_data.branchData={}
_data.branchLookup={}
_data.openWindowIds={}
newbieModel.loadOpenWindowData()
end

function newbieModel.initConfig()
_lookupWinName={}

_config.levelConfig={}
_config.vipLevelConfig={}
_config.notaccpetTaskConfig={}
_config.accpetTaskConfig={}
_config.doingTaskConfig={}
_config.finishTaskConfig={}
_config.activeSystemConfig={}
_config.itemConfig={}
_config.suoyaotaBalanceConfig={}
_config.sceneConfig={}
_config.groupConfig={}
_config.openWindowConfig={}
_config.luaConfig={}
_config.worldBlockConfig={}
_config.startExperienceConfig={}
_config.endExperienceConfig={}
_config.mysteryEventConfig={}
_config.storyTreeEventConfig={}
_config.zxlConfig={}
_config.nextNewbieConfig={}

local config=cfg_newbieconfig()
local enterConfig={}
for k,v in pairs(config)do
local typo
local info=v


if v.level then
local id=v.level
_config.levelConfig[id]=info
typo=NEW_BIE_CND_TYPE.eLevel
end


if v.vip then
local id=v.vip
_config.vipLevelConfig[id]=info
typo=NEW_BIE_CND_TYPE.eVip
end


if v.activeSystem then
local id=v.activeSystem
_config.activeSystemConfig[id]=info
typo=NEW_BIE_CND_TYPE.eActiveSystem
end


if v.quest then
local taskId=v.quest[1]
local state=v.quest[2]
local trigerType=v.quest[3]or 0
local id=taskId*100+state*10+trigerType
if state==0 then
_config.notaccpetTaskConfig[id]=info
typo=NEW_BIE_CND_TYPE.eNotAcceptTask
elseif state==1 then
_config.accpetTaskConfig[id]=info
typo=NEW_BIE_CND_TYPE.eAcceptTask
elseif state==2 then
_config.doingTaskConfig[id]=info
typo=NEW_BIE_CND_TYPE.eDoTask
else
_config.finishTaskConfig[id]=info
typo=NEW_BIE_CND_TYPE.eFinshTask
end
end

if v.newbieID then
_config.finishNewbieConfig[v.newbieID]=info
typo=NEW_BIE_CND_TYPE.eFinishNewbie
end


if v.item then
local item=v.item
for k,t in ipairs(item)do
_config.itemConfig[t]=info
end
typo=NEW_BIE_CND_TYPE.eItem
end


if v.banlance then
local id=v.banlance
_config.suoyaotaBalanceConfig[id]=info
typo=NEW_BIE_CND_TYPE.eSuoyaotaBalance
end


if v.enterScene then
local id=v.enterScene
_config.sceneConfig[id]=info
typo=NEW_BIE_CND_TYPE.eEnterScene
end


if v.openWindow then
local name=v.openWindow[1]
local num=v.openWindow[2]
local id=FMT.fmt('{0}_NUM_{1}',v.openWindow[1],num)
_config.openWindowConfig[id]=info
_lookupWinName[name]=true
typo=NEW_BIE_CND_TYPE.eOpenWindow
end


if v.block then
local block=v.block
local key=FMT.fmt("{0}_{1}",block[1],block[2])
_config.worldBlockConfig[key]=info
typo=NEW_BIE_CND_TYPE.eWorldBlock
end

if v.experienceStart then
_config.startExperienceConfig[v.experienceStart]=info
typo=NEW_BIE_CND_TYPE.eStartExperience
end

if v.experienceEnd then
_config.endExperienceConfig[v.experienceEnd]=info
typo=NEW_BIE_CND_TYPE.eEndExperience
end

if v.mysteryEvent then
local mysteryEvent=v.mysteryEvent
mysteryEvent[2]=mysteryEvent[2]or-1
local key=FMT.fmt("{0}_{1}",mysteryEvent[1],mysteryEvent[2])
_config.mysteryEventConfig[key]=info
typo=NEW_BIE_CND_TYPE.eMysteryEvent
end

if v.storyTree then
local storyTree=v.storyTree
local storyTreeId=storyTree[1]
local typo=storyTree[2]or 2
local key=FMT.fmt("{0}_{1}",storyTreeId,typo)
_config.storyTreeEventConfig[key]=info
typo=NEW_BIE_CND_TYPE.eStoryTree
end


if v.luaFunc then
local id=v.luaFunc
_config.luaConfig[id]=info
typo=NEW_BIE_CND_TYPE.eLuaFun
newbieTriggerControl.initLuaFunc(v.luaFunc)
end

if v.zxl then
local zxl=v.zxl
local id=zxl[1]*10000+(zxl[2]or 0)
_config.zxlConfig[id]=info
typo=NEW_BIE_CND_TYPE.eZheXianLing
end

if v.nextid then
local id=v.nextid
_config.nextNewbieConfig[id]=cfg_newbieconfig_get(id)
typo=NEW_BIE_CND_TYPE.eNextNewbie
end
end

local cfgs=cfg_newbiebranchconfig()
for k,v in pairs(cfgs)do
local typo
local info=v
if v.quest then
local taskId=v.quest[1]
local state=v.quest[2]
local trigerType=v.quest[3]or 0
local id=taskId*100+state*10+trigerType
local conf=_config.branchConfig
if state==0 then
conf.notaccpetTaskConfig[id]=info
elseif state==1 then
conf.accpetTaskConfig[id]=info
elseif state==2 then
conf.doingTaskConfig[id]=info
else
conf.finishTaskConfig[id]=info
end
end


if v.openWindow then
local name=v.openWindow[1]
local num=v.openWindow[2]
local id=FMT.fmt('{0}_NUM_{1}',v.openWindow[1],num)
_config.branchConfig.openWindowConfig[id]=info
_lookupWinName[name]=true
end

if v.luaFunc then
local id=v.luaFunc
_config.branchConfig.luaConfig[id]=info
end

if v.zxl then
local zxl=v.zxl
local id=zxl[1]*10000+(zxl[2]or 0)
_config.branchConfig.zxlConfig[id]=info
end


if v.level then
local id=v.level
_config.branchConfig.levelConfig[id]=info
typo=NEW_BIE_CND_TYPE.eLevel
end


if v.vip then
local id=v.vip
_config.branchConfig.vipLevelConfig[id]=info
typo=NEW_BIE_CND_TYPE.eVip
end


if v.activeSystem then
local id=v.activeSystem
_config.branchConfig.activeSystemConfig[id]=info
typo=NEW_BIE_CND_TYPE.eActiveSystem
end

if v.newbieID then
_config.branchConfig.finishNewbieConfig[v.newbieID]=info
typo=NEW_BIE_CND_TYPE.eFinishNewbie
end


if v.item then
local item=v.item
for k,t in ipairs(item)do
_config.branchConfig.itemConfig[t]=info
end
typo=NEW_BIE_CND_TYPE.eItem
end


if v.banlance then
local id=v.banlance
_config.branchConfig.suoyaotaBalanceConfig[id]=info
typo=NEW_BIE_CND_TYPE.eSuoyaotaBalance
end


if v.enterScene then
local id=v.enterScene
_config.branchConfig.sceneConfig[id]=info
typo=NEW_BIE_CND_TYPE.eEnterScene
end


if v.block then
local block=v.block
local key=FMT.fmt("{0}_{1}",block[1],block[2])
_config.branchConfig.worldBlockConfig[key]=info
typo=NEW_BIE_CND_TYPE.eWorldBlock
end

if v.experienceStart then
_config.branchConfig.startExperienceConfig[v.experienceStart]=info
typo=NEW_BIE_CND_TYPE.eStartExperience
end

if v.experienceEnd then
_config.branchConfig.endExperienceConfig[v.experienceEnd]=info
typo=NEW_BIE_CND_TYPE.eEndExperience
end

if v.mysteryEvent then
local mysteryEvent=v.mysteryEvent
mysteryEvent[2]=mysteryEvent[2]or-1
local key=FMT.fmt("{0}_{1}",mysteryEvent[1],mysteryEvent[2])
_config.branchConfig.mysteryEventConfig[key]=info
typo=NEW_BIE_CND_TYPE.eMysteryEvent
end

if v.storyTree then
local storyTree=v.storyTree
local storyTreeId=storyTree[1]
local typo=storyTree[2]or 2
local key=FMT.fmt("{0}_{1}",storyTreeId,typo)
_config.branchConfig.storyTreeEventConfig[key]=info
typo=NEW_BIE_CND_TYPE.eStoryTree
end

if v.nextid then
local nextid=v.nextid
_config.branchConfig.nextNewbieConfig[nextid]=cfg_newbiebranchconfig_get(nextid)
typo=NEW_BIE_CND_TYPE.eNextNewbie
end
end
end




local getLookupConfig=function(cfg,typo,id)
if typo==NEW_BIE_CND_TYPE.eVip then
return cfg.vipLevelConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eActiveSystem then
return cfg.activeSystemConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eNotAcceptTask then
return cfg.notaccpetTaskConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eAcceptTask then
return cfg.accpetTaskConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eDoTask then
return cfg.doingTaskConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eFinshTask then
return cfg.finishTaskConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eLevel then
return cfg.levelConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eItem then
return cfg.itemConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eEnterScene then
return cfg.sceneConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eLuaFun then
return cfg.luaConfig[tostring(id)]
elseif typo==NEW_BIE_CND_TYPE.eSuoyaotaBalance then
return cfg.suoyaotaBalanceConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eOpenWindow then
return cfg.openWindowConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eWorldBlock then
return cfg.worldBlockConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eStartExperience then
return cfg.startExperienceConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eEndExperience then
return cfg.endExperienceConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eMysteryEvent then
return cfg.mysteryEventConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eFinishNewbie then
return cfg.finishNewbieConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eStoryTree then
return cfg.storyTreeEventConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eZheXianLing then
return cfg.zxlConfig[id]
elseif typo==NEW_BIE_CND_TYPE.eNextNewbie then
return cfg.nextNewbieConfig[id]
end
end

function newbieModel.getLookupConfig(typo,id)
local maincfg=_config
local cfg=getLookupConfig(maincfg,typo,id)
if cfg then
return cfg,NEW_BIE_TYPE.eMain
else
local maincfg=_config.branchConfig
cfg=getLookupConfig(maincfg,typo,id)
if cfg then
return cfg,NEW_BIE_TYPE.eBranch
end
end
end


function newbieModel.hasOpenWindowCfg(name)
return _lookupWinName[name]==true
end

function newbieModel.loadOpenWindowData()
_openData=userActorSetting.get('newbieopenwin',{})



end

function newbieModel.getOpenWindowNum(name)
if _openData==nil then return 0 end
return _openData[name]or 0
end

function newbieModel.setOpenWindowNum(name,num)

if _openData==nil then return end
_openData[name]=num
userActorSetting.set('newbieopenwin',_openData)
userActorSetting.flush()
end


function newbieModel.initFinishData(length,tab)
_data.newbieId=0
if length>0 then
_data.newbieId=tab[1]or 0
end
_data.isInit=true
end

function newbieModel.initBranchFinishData(length,tab)
_data.branchData={}
_data.branchLookup={}
if length>0 then
_data.branchData=tab
for _,v in ipairs(tab)do
_data.branchLookup[v]=true
end
end
_data.isInitBranch=true
end

function newbieModel.getFinishMainNewbie()
return _data.newbieId
end

local isMainFinish=function(newbieId)
return _data.newbieId>=newbieId
end

local isBranchFinish=function(newbieId)
local branchconfig=cfg_newbiebranchconfig_get(newbieId)
if not branchconfig then
return true
end
local branchLookup=_data.branchLookup
local flagbit=branchconfig.flagbit
return branchLookup[flagbit]==true
end

function newbieModel.isFinish(newbieId)




if newbieConfig.isBranchNewbieId(newbieId)then
return isBranchFinish(newbieId)
else
return isMainFinish(newbieId)
end
end

local setMainFinish=function(newbieId)
if isMainFinish(newbieId)then return end
_data.newbieId=newbieId
newbieModel.storeMainServer()
end

local setBranchFinish=function(newbieId)
if isBranchFinish(newbieId)then return end
local branchconfig=cfg_newbiebranchconfig_get(newbieId)
local flagbit=branchconfig.flagbit
_data.branchLookup[flagbit]=true
local branchData=_data.branchData
branchData[#branchData+1]=flagbit

newbieModel.storeBranchServer()
end

function newbieModel.setFinish(newbieId)
if newbieConfig.isBranchNewbieId(newbieId)then
setBranchFinish(newbieId)
else
setMainFinish(newbieId)
end
end






















function newbieModel.isRecvData()
return _data.isInit and _data.isInitBranch or false
end


function newbieModel.storeMainServer()
local newbieId=_data.newbieId or 0
local info={newbieId}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.NEWBIE_DATA,#info,info)
end


function newbieModel.storeBranchServer()
local branchInfo=_data.branchData or{}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.NEWBIE_BRANCH_DATA,#branchInfo,branchInfo)
end


function newbieModel.storeServer()
newbieModel.storeMainServer()
newbieModel.storeBranchServer()
end


function newbieModel.storeServerOnFinishMainNewbie(newbieId)
if isMainFinish(newbieId)then return end
_data.newbieId=newbieId
newbieModel.storeMainServer()
end

function newbieModel.storeServerOnFinishBranchNewbie(newbieId)
if isBranchFinish(newbieId)then return end
setBranchFinish(newbieId)
newbieModel.storeBranchServer()
end

function newbieModel.storeServerOnFinish(newbieId)
if newbieConfig.isBranchNewbieId(newbieId)then
newbieModel.storeServerOnFinishMainNewbie(newbieId)
else
newbieModel.storeServerOnFinishBranchNewbie(newbieId)
end
end

function newbieModel:printConfig(configName)

end

function newbieModel:printBactchConfig(configName)

end

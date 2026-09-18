





mainConfig={}

local _groupBtnCfg={}

function mainConfig.initGroupBtnsConfig(sceneId,mapId,groupType,groupBtnList)
if _groupBtnCfg[sceneId]==nil then _groupBtnCfg[sceneId]={}end
if _groupBtnCfg[sceneId][mapId]==nil then _groupBtnCfg[sceneId][mapId]={}end
if _groupBtnCfg[sceneId][mapId][groupType]==nil then _groupBtnCfg[sceneId][mapId][groupType]={}end
local cfg=_groupBtnCfg[sceneId][mapId][groupType]

local groupBtnLook={}
local keylook={}
for _,v in ipairs(groupBtnList)do
groupBtnLook[v]=true
local key=mainBtnConfig.getBtnKey(v)
keylook[key]=groupType
end

cfg.list=groupBtnList
cfg.look=groupBtnLook
cfg.keylook=keylook
end

function mainConfig.getBottomGroupConfig()
return mainConfig.getGroupBtnListCfg(MAIN_ICON_GROUP_TYPE.eBottom)
end

function mainConfig.getRightGroupConfig()
return mainConfig.getGroupBtnListCfg(MAIN_ICON_GROUP_TYPE.eRight)
end


function mainConfig.getCurBtnCfg()
local sceneType=mainControl:getSceneType()
local mapId
if sceneType==eSceneType.eZongmen then
mapId=zongmenModel:getMountainId()
elseif sceneType==eSceneType.eWorld then
mapId=worldModel.world
elseif sceneType==eSceneType.eXianJie then
mapId=xianjieModel:getScenceType()
end
return _groupBtnCfg[sceneType][mapId]or _groupBtnCfg[sceneType][0]
end


function mainConfig.getBtnCfg(groupType)
local btnCfg=mainConfig.getCurBtnCfg()
return btnCfg and btnCfg[groupType]or nil
end


function mainConfig.getGroupBtnsConfig(groupType)
local groupBtnCfg=mainConfig.getBtnCfg(groupType)
if groupBtnCfg==nil then
return{},{}
end
local btnsCfg={}
local btnlook=groupBtnCfg.look
local btnlist=groupBtnCfg.list
local allCfgs=mainBtnConfig.getAllBtnCfg()
for i,btnType in ipairs(btnlist)do
local v=allCfgs[btnType]
if btnlook[btnType]==true and
mainBtnConfig.isActive(btnType)then
btnsCfg[#btnsCfg+1]=v
end
end
return btnsCfg,groupBtnCfg
end


function mainConfig.getGroupBtnListCfg(groupType)
local list,cfgs=mainConfig.getGroupBtnsConfig(groupType)
return list,cfgs
end


function mainConfig.getGroupIconTypeList(groupType)
local btnCfg=mainConfig.getBtnCfg(groupType)
if btnCfg==nil then return{}end
local btnlist=btnCfg.list
return mainBtnConfig.getIconTypeList(btnlist)
end

function mainConfig.getBundleName()
return globalABLookup.mainwin
end

function mainConfig.getIconGroupType(key)
local cfgs=mainConfig.getCurBtnCfg()
for group,cfg in pairs(cfgs)do
if cfg.keylook[key]then
return cfg.keylook[key]
end
end
end

function mainConfig.getGroupReddot(groupType)
local btnCfglist=mainConfig.getGroupBtnsConfig(groupType)
return mainBtnConfig.getReddotByCfgList(btnCfglist)
end
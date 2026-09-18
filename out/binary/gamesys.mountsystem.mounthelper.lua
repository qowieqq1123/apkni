mountHelper={}

function mountHelper.getMount(itemguid)
return mountBagModel:getItem(itemguid)or
mountModel:getMount(itemguid)or
watchModel.getItem(itemguid)or
auctionModel:getItem(itemguid)or
mailModel:getItem(itemguid)
end



function mountHelper.getFight(itemid)
local attrlist=mountHelper.getAttrsLookupByItemguid(itemid)or{}
local fight=0
for k,v in pairs(attrlist)do
local config=cfg_attributesconfig_get(k)
if config==nil then
loggerUtil.logErrFMT('属性类型{0}没有找到',k)
return 0
end
fight=fight+config.unitVal*v
end
return math.floor(fight)
end


function mountHelper.getAttrsLookupByItemguid(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local baseAttrList=mountHelper.getBaseAttrsList(itemCfg)

return attrListHelper.tramsformToLookup(baseAttrList)
end



function mountHelper.getBaseAttrsList(itemCfg)
return itemCfg.static
end


function mountHelper.isCanDress(dzguid,itemid,warning)
return mountHelper.isCanDressByDZ(dzguid,warning)
end

function mountHelper.isCanDressByDZ(dzguid,warning)
if not systemModel.isOpen(SYSTEM_DEFINE.eMount)then
if warning then
UIManager.error(systemModel.getOpenTips(SYSTEM_DEFINE.eMount))
end
return false
end
return mountHelper.isCanDressByJingjie(dzguid,warning)
end


function mountHelper.isCanDressByJingjie(dzguid,warning)
local needjingjie=cfgHelper.get2(cfg_disciplemountconfig_get,1,'jingjie')
local dizData=UIDiscipleModel:getDiscipleData(dzguid)
local jingJieLv=dizData.jingjielv
local ret=jingJieLv>=needjingjie
if not ret and warning then
local jjname=UIDiscipleModel:getJJName3(needjingjie)
UIManager.error(FMT.fmt('弟子"{0}"可装备坐骑',jjname))
end
return ret
end

function mountHelper.getMountModelParams(dzguid)
if not mountHelper.isCanDressByJingjie(dzguid)then return end

local itemid=mountModel:getMountIdByDZ(dzguid)
if itemid then
local itemsCfg=itemsConfig.getConfig(itemid)
return itemsCfg.model
end
end

function mountHelper.getMountNode(dzguid)
local itemid=mountModel:getMountIdByDZ(dzguid)
if itemid then
local itemsCfg=itemsConfig.getConfig(itemid)
return itemsCfg.node or'zuoqidian'
end
return'root'
end

function mountHelper.getFlyMountId(dzguid)
local itemid=mountModel:getMountIdByDZ(dzguid)
if itemid then
local itemsCfg=itemsConfig.getConfig(itemid)
local flyId=mountHelper.getMountAniByDZ(dzguid)
if itemsCfg.flymount then
return itemsCfg.flymount[flyId]
end
end
end

function mountHelper.getMountAni(dzguid,anim)
if mountModel:getMountIdByDZ(dzguid)then
return mountHelper.getMountAniByDZ(dzguid,anim)
end
return anim or eAnimationID.stand
end

function mountHelper.getMountAniByDZ(dzguid,anim)
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid)
return mountHelper.getMountAniByBody(info.body,anim)
end

function mountHelper.getMountAniByBody(body,anim)
anim=anim or eAnimationID.stand
local cfg=cfgHelper.get1(cfg_dbbodyconfig_get,body)
if cfg then
return cfg.mountAni or anim
else
return anim
end
end

function mountHelper.findDizi(warring,checkNotDress)

local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,{},eSortOrder.eDown)or{}
if next(discipleList)then
if not checkNotDress then
local netData=discipleList[1].netData
if mountHelper.isCanDressByDZ(netData.net.discipleguid)then
return netData.net.discipleguid
end
end
end
if warring then
UIManager.error(systemModel.getOpenTips(SYSTEM_DEFINE.eMount))
end

end

function mountHelper.setRoleMoveMount(guid,dzguid)
if api_Available_SetRoleMoveArgs()then
local post=isometricMapSystem:checkAndGetFlyData(dzguid,guid,nil,nil,true)or 7
local flag=aiManager:getAutoToFlyFlag()
_MapManager.SetRoleMoveArgs(guid,{1,post,0,flag})
end
end

function mountHelper.freshRoleMoveMount(dzguid)
local guid=discipleStateManager:getDiscipleEntity(dzguid)
if guid==nil then return end
mountHelper.setRoleMoveMount(guid,dzguid)
end
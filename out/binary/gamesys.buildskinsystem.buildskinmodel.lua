









buildSkinModel={}


buildSkinModel.data={}

function buildSkinModel:onAppStart()

end


function buildSkinModel:onEnterState(isReconnect)
buildSkinModel:initBuildSkinBindBuildId()
end


function buildSkinModel:onProtocolReq()

end


function buildSkinModel:onLeaveState(isReconnect)

self.data={}
end



function buildSkinModel:initBuildSkinBindBuildId()

self.data.buildSkinBindBdIdList_lookup={}
local bdcfgs=cfg_monijybuildconfig()
for k,cfg in pairs(bdcfgs)do
local bdId=cfg.id
local skinList=cfg.showSkinList
if skinList and next(skinList)then
for _,skinId in ipairs(skinList)do
self.data.buildSkinBindBdIdList_lookup[skinId]=bdId
end
end
end
end


function buildSkinModel:initNeedListenUnLockItemList()
self.data.needListenUnLockItemList_lookup={}

local allSkinCfg=cfg_monijybuildappearanceconfig()
for _,cfg in pairs(allSkinCfg)do
local skinId=cfg.id
local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
if not isUnLock and cfg.unlock_condition and next(cfg.unlock_condition)then
local lockType=cfg.unlock_condition[1]
local lockParam=cfg.unlock_condition[2]
if lockType==1 then

local itemId=lockParam[1]
if not self.data.needListenUnLockItemList_lookup[itemId]then
self.data.needListenUnLockItemList_lookup[itemId]={}
end
self.data.needListenUnLockItemList_lookup[itemId][skinId]=true
end
end
end
end

function buildSkinModel:addNeedListenUnLockItemList(skinId)
if not self.data.needListenUnLockItemList_lookup then
self.data.needListenUnLockItemList_lookup={}
end

local itemId
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if skinCfg.unlock_condition then
local lockType=skinCfg.unlock_condition[1]
local lockParam=skinCfg.unlock_condition[2]
if lockType==1 then
itemId=lockParam[1]
end
end

if itemId then
if not self.data.needListenUnLockItemList_lookup[itemId]then
self.data.needListenUnLockItemList_lookup[itemId]={}
end

self.data.needListenUnLockItemList_lookup[itemId][skinId]=true
end
end

function buildSkinModel:removeNeedListenUnLockItemList(skinId)
if not self.data.needListenUnLockItemList_lookup then
return
end

local itemId
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if skinCfg.unlock_condition then
local lockType=skinCfg.unlock_condition[1]
local lockParam=skinCfg.unlock_condition[2]
if lockType==1 then
itemId=lockParam[1]
end
end

if itemId then
if not self.data.needListenUnLockItemList_lookup[itemId]then
return
end

self.data.needListenUnLockItemList_lookup[itemId][skinId]=nil
if not next(self.data.needListenUnLockItemList_lookup[itemId])then
self.data.needListenUnLockItemList_lookup[itemId]=nil
end
end
end

function buildSkinModel:getNeedListenUnLockSkinListByItemId(itemId)
if not self.data.needListenUnLockItemList_lookup then
return
end

if not self.data.needListenUnLockItemList_lookup[itemId]then
return
end

if next(self.data.needListenUnLockItemList_lookup[itemId])then
local skinIdList={}
for skinId,_ in pairs(self.data.needListenUnLockItemList_lookup[itemId])do
table.insert(skinIdList,skinId)
end
return skinIdList
end
end

function buildSkinModel:getBuildSkinBindBuildIdBySkinId(skinId)
if self.data.buildSkinBindBdIdList_lookup and self.data.buildSkinBindBdIdList_lookup[skinId]then
return self.data.buildSkinBindBdIdList_lookup[skinId]
end
end

function buildSkinModel:checkBuildCanChangeSkin(buildId)
if not systemModel.isOpen(SYSTEM_DEFINE.eBuildAppearance)then
return false
end

local showSkinIdList=buildSkinModel:getBuildSkinIdList(buildId)

if showSkinIdList and next(showSkinIdList)then
return true
end
return false
end

function buildSkinModel:checkBuildSkinUnLock(skinId)
if skinId==0 then

return true
end
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if not skinCfg.unlock_condition then
return true
end

if self.data.buildUnLockSkinData then
return self.data.buildUnLockSkinData[skinId]or false
end

return false
end

function buildSkinModel:checkBuildSkinCanUnLock(skinId,isWarning)
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
if skinCfg.unlock_condition then
local lockType=skinCfg.unlock_condition[1]
local lockParam=skinCfg.unlock_condition[2]
if lockType==1 then

local itemId=lockParam[1]
local itemNeedCount=lockParam[2]
local itemHasCount=itemsModel.getCount(itemId)
if itemHasCount<itemNeedCount then
if isWarning then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showCommonGainWin_item(itemId)
end
return false,lockType,lockParam
end
end
end

return true
end

function buildSkinModel:checkBuildSkinUnLockReddotByBuildId(buildId,needUpdate)
if not buildSkinModel:checkBuildCanChangeSkin(buildId)then
return false
end

if not self.data.buildUnLockReddotList then
self.data.buildUnLockReddotList={}
end

if not needUpdate and self.data.buildUnLockReddotList[buildId]~=nil then
return self.data.buildUnLockReddotList[buildId]
end

local showSkinCfgList=cfgHelper.get2(cfg_monijybuildconfig_get,buildId,'showSkinList')
for _,skinId in ipairs(showSkinCfgList)do
local isUnLock=buildSkinModel:checkBuildSkinUnLock(skinId)
if not isUnLock then
local isCanUnLock=buildSkinModel:checkBuildSkinCanUnLock(skinId)
if isCanUnLock then
self.data.buildUnLockReddotList[buildId]=true
return true
end
end
end
self.data.buildUnLockReddotList[buildId]=false
return false
end

function buildSkinModel:getBuildSkinIdList(buildId)
local showSkinCfgList=cfgHelper.get2(cfg_monijybuildconfig_get,buildId,'showSkinList')
if not showSkinCfgList or not next(showSkinCfgList)then
return nil
end

local defaultSkinId=0

local skinList={}
for i,skinId in ipairs(showSkinCfgList)do
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
local isShow=true
if skinCfg.isUnlockShow then

local isUnlock=buildSkinModel:checkBuildSkinUnLock(skinId)
if not isUnlock then

local isCanUnlock=buildSkinModel:checkBuildSkinCanUnLock(skinId)
if not isCanUnlock then

isShow=false
end
end
end

if isShow then
table.insert(skinList,skinId)
end
end

if skinList and next(skinList)then
table.insert(skinList,1,defaultSkinId)
end
return skinList
end

function buildSkinModel:setBuildUnLockSkinData(len,unLockSkinData)
self.data.buildUnLockSkinData={}
if len and len>0 then
for i,skinId in ipairs(unLockSkinData)do
self.data.buildUnLockSkinData[skinId]=true
end
end
end

function buildSkinModel:setBuildUnLockSkinDataBySkinId(skinId)
if skinId==0 then
return
end

if not self.data.buildUnLockSkinData then
self.data.buildUnLockSkinData={}
end

self.data.buildUnLockSkinData[skinId]=true
end

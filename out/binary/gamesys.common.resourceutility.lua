

resourceUtility={}



function resourceUtility.enableReleasePool(enable)
if api_Available_EnableSpineReleasePool()then
CS.ResourceHelper.EnableSpineReleasePool(enable)
CS.ResourceHelper.EnableDragonBoneReleasePool(enable)
end
end



function resourceUtility.setReleasePoolTime(releaseTime)
if api_Available_SetDragonBoneReleasePoolTime()then
CS.ResourceHelper.SetDragonBoneReleasePoolTime(releaseTime)
CS.ResourceHelper.SetSpineReleasePoolTime(releaseTime)
end
end


function resourceUtility.releaseAll()
if api_Available_ReleaseSpinePool()then
CS.ResourceHelper.ReleaseSpinePool()
CS.ResourceHelper.ReleaseDragonBonePool()
end
end


function resourceUtility.releaseUIModelCache()
if api_Available_ReleaseUIModelCache()then
CS.ResourceHelper.ReleaseUIModelCache()
end
end


function resourceUtility.clearAllCache(clearAll)
CS.AssetCacheManager.Clear(false,clearAll)
end



local _delayClearPoolTimer

function resourceUtility.stopDelayClearPoolTimer()
if _delayClearPoolTimer then
_delayClearPoolTimer:cancel()
end
_delayClearPoolTimer=nil
end

function resourceUtility.clearDelayPoolCache(delay)
if api_Available_ClearAssetPoolCache()then
resourceUtility.stopDelayClearPoolTimer()
delay=delay or 1
_delayClearPoolTimer=timer.new()
_delayClearPoolTimer:start(delay,resourceUtility.clearPoolCache,1)
end
end



function resourceUtility.clearPoolCache()
if api_Available_ClearAssetPoolCache()then
resourceUtility.stopDelayClearPoolTimer()
CS.GameInterface.ClearAssetPoolCache()
end
end



function resourceUtility.clearPoolCacheWithAsset(unloadAsset)
if api_Available_ClearAssetPoolCache()then
resourceUtility.stopDelayClearPoolTimer()
CS.GameInterface.ClearAssetPoolCache(unloadAsset)
end
end
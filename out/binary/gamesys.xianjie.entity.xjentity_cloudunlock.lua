









local xjEntity_cloudUnLock={}


function xjEntity_cloudUnLock:onInit()
local data=self.data
self.cloudid=data[1]
self.deleyTime=data[2]or 1.5
self:initData()
end

function xjEntity_cloudUnLock:initData()
local cloudData=xianjieModel:getCloudData(self.cloudid)
if cloudData then
local cloudEntData=cloudData.CloudUnLockData
if cloudEntData then
self.pos=cloudEntData:getWorldPos()
self.size=cloudEntData:getWorldSize()
end
end
end

function xjEntity_cloudUnLock:refreshInfo()
self:invokeEntityHudFunc('refreshIcon')
end


function xjEntity_cloudUnLock:onCreateWidget(widget)

self.widget=widget
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local modelid=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'UnlockCloudModelID')


local cfg=cfg_dbbodyconfig_get(modelid)
local scales=cfg.scales or{3,3}
widget:SetChildSceneEntityCreateModel(0,modelid,{},'Entity',entCfg.sortOrder+1,scales[1],nil,false)
widget:SetChildScale(0,Vector3(1,1,1))
widget:SetChildLocalPosition(0,Vector3(0,2,-2))
local boxParams=self:handleBoxParams()

widget:SetChildSceneEntityAddBoxCollider(0,Vector2.New(5,2),Vector2.zero,boxParams,helper.LAYER_ACTOR)
end


function xjEntity_cloudUnLock:onMyClick(boxParams)
local cloudData=xianjieModel:getCloudData(self.cloudid)

if cloudData:canUnlock()then

xianjieController:reqSearchCloudIdx(self.cloudid,cloudData.idx+1)
end
end

function xjEntity_cloudUnLock:runAnim()
local func=function()

local cloudData=xianjieModel:getCloudData(self.cloudid)
cloudData:clearCloudUnLockEntity()
end

self.widget:SetChildSceneEntityPlayAnimation(0,2051,1,func)


end


function xjEntity_cloudUnLock:onDelete()

end


function xjEntity_cloudUnLock:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

return xjEntity_cloudUnLock

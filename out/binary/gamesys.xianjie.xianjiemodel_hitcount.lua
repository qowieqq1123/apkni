







function xianjieModel:onEnterState_HitCount(isReconnet)
self.hitCountLookUp={}
end

function xianjieModel:onLeaveState_HitCount(isReconnet)
end


function xianjieModel:setActorHitCountLookUp(type,actorID,count)
if self.hitCountLookUp==nil then return end

local hitCountTypeLookUp=self.hitCountLookUp[type]or{}
self.hitCountLookUp[type]=hitCountTypeLookUp

hitCountTypeLookUp[tostring(actorID)]=count
end



function xianjieModel:getHitCountTypeBySceneIdx(sceneIdx)
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
return 1
elseif xianjienSceneIndexType:isMoJie(sceneIdx)then
return 0
else
return 2
end
end

function xianjieModel:getActorHitCount(actorID,sceneIdx)
if self.hitCountLookUp==nil then return 0 end

local type=xianjieModel:getHitCountTypeBySceneIdx(sceneIdx)
if type==0 then return 0 end

if self.hitCountLookUp[type]==nil then return 0 end

return self.hitCountLookUp[type][tostring(actorID)]or 0
end

function xianjieModel:getHitCountSpineBg(hitCount)
local hitCountSpineBgRangeList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hitCountSpineBgRangeList')

local spineid=0

for index,range in ipairs(hitCountSpineBgRangeList)do
if hitCount>=range[1]and hitCount<=range[2]then
spineid=range[3]
else
break
end
end

return spineid
end
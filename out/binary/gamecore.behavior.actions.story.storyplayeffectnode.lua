







storyPlayEffectNode=simple_class(baseNode)

local _HexMapManager=CS.HexagonMapManagerInterface
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int

function storyPlayEffectNode:start()
self.deltaTime=0
end

function storyPlayEffectNode:reset()
storyPlayEffectNode._base.reset(self)
self.deltaTime=0
end

function storyPlayEffectNode:broke()
if self.effectId then
_stopEffect(self.effectId)
end
end

function storyPlayEffectNode:update(interval)
local duration=self:getData('duration')or 0

if duration==0 then
self:playEffect(duration)
local key=self:getData('effectName')
if key then
self:setSharedVar(key,self.effectId)
end
return nodeState.success
end
if self.deltaTime>=duration then
local destroy=self:getData('destroy')
if destroy==nil or destroy==1 then
local fadeout=self:getData('fadeout')or 0
if fadeout==1 then
_sleepEffect(self.effectId,false)
else
_stopEffect(self.effectId)
end
else
local key=self:getData('effectName')
if key==''or key==nil then
loggerUtil.logErrFMT('没有设置不销毁特效的参数名称')
end
self:setSharedVar(key,self.effectId)
end
return nodeState.success
end
self.deltaTime=self.deltaTime+interval
if self.isPlaying then
return nodeState.running
end
self.isPlaying=true
local state=self:playEffect(duration)
return state
end

function storyPlayEffectNode:playEffect(duration)
local effectid=self:getData('effectid')
local pos=self:getData('pos')or{0,0}
local usezmpos=self:getData('usezmpos')

pos=Vector3(pos[1],pos[2],0)
if usezmpos then
local mapId=zongmenModel:getMountainId()
pos=_MapManager.GetCellCenterLocal(mapId,Vector3ToVector3Int(pos),mapLayer.Data)
end
self.effectId=_MapManager.PlayEffectByPos(pos,effectid)
if duration==0 then
local effectList=storyAIManager:getStoryBTBlackBoard('effectidList')
if effectList then
table.insert(effectList,self.effectId)
else
effectList={self.effectId}
end
storyAIManager:setStoryBTBlackBoard('effectidList',effectList)
end
return nodeState.running
end
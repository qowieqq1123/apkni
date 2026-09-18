


registry_pool_class(fBTNodeTypo.ShowPlotBoard,'fBTShowPlotBoardNode',fBTBaseNode)

function fBTShowPlotBoardNode:__init(guid)
self.typo=fBTNodeTypo.ShowPlotBoard
end

function fBTShowPlotBoardNode:parser(rawData)
self.groupID=rawData[1]
self.showFullScreen=rawData[2]
self.waitEnd=rawData[3]
end



function fBTShowPlotBoardNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

end




function fBTShowPlotBoardNode:start()
self.onDialogueBroadcast=function(name,castType,param1)

if self.flowObjID~=nil then
self.entity:stopText(self.flowObjID)
self.flowObjID=nil
end
self.flowObjID=self.entity:flowText(flowObjTypo.tip,{strPara="......",stayTime=12})
end
notifySystem:listenNotify(notifyConfig.onDialogueBroadcast,self.onDialogueBroadcast)


if self.waitEnd then
local onFinish=function()

self.state=fBTNodeState.success
end
gameplotController:showPlotBoard2({groupid=self.groupID,callback=onFinish,useUnscaledDeltaTime=true})
self.state=fBTNodeState.running
else
gameplotController:showPlotBoard2({groupid=self.groupID,useUnscaledDeltaTime=true})
self.state=fBTNodeState.success
end

end

function fBTShowPlotBoardNode:onComplete()
if self.onDialogueBroadcast~=nil then
notifySystem:removelistener(notifyConfig.onDialogueBroadcast,self.onDialogueBroadcast)
self.onDialogueBroadcast=nil

if self.flowObjID~=nil then
self.entity:stopText(self.flowObjID)
self.flowObjID=nil
end
end
end

function fBTShowPlotBoardNode:update(delta)

return self.state
end


function fBTShowPlotBoardNode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end


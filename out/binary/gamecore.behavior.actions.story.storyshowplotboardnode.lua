







storyShowPlotBoardNode=simple_class(baseNode)

function storyShowPlotBoardNode:broke()
if self.winName then
UIFullStoryBoardControl:closeWindow(self.winName)
end
end

function storyShowPlotBoardNode:reset()
storyShowPlotBoardNode._base.reset(self)
self.isPloting=false
self.isCompletePlot=false
end

function storyShowPlotBoardNode:update(interval)
local groupid=self:getData('groupid')
local key=self:getData('key')
local value=self:getData('value')
local deskey=self:getData('deskey')
local rewards=self:getData('rewards')
local rewardBtnStr=self:getData('rewardBtnStr')

if self.isPloting then
return nodeState.running
end
if self.isCompletePlot then
return nodeState.success
end
self.isPloting=true
self.isCompletePlot=false
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,groupid)
local skin=groupcfg.skin or 1
self.winName=UIFullStoryBoardControl:getPlotBoardWinName(skin)
local func=function(index)
if key and value then
self:setSharedVar(key,value)
end
if index~=nil and deskey then
self:setSharedVar(deskey,index)
end
self.isPloting=false
self.isCompletePlot=true
return nodeState.success
end
local args={
groupid=groupid,
rewards=rewards,
rewardBtnStr=rewardBtnStr,
rewardBtnClickGray=true,
callback=func,
isFullOpen=false,
}
gameplotController:showPlotBoard(args)
return nodeState.running
end

function storyShowPlotBoardNode:skip()
UIFullStoryBoardControl:closeWindow(self.winName)
return nodeState.success
end
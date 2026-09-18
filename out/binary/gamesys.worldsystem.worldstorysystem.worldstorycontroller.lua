






local _MODULENAME="worldStoryController"




gameState.addListener(def_table(_MODULENAME))
worldStoryController.name=_MODULENAME


worldStoryController.data={}

local _story_handle={
[worldStoryModel.STORYTYPE.DIALOG]="showDialog",
[worldStoryModel.STORYTYPE.COMIC]="showComic",
[worldStoryModel.STORYTYPE.VIDEO]="showVideo",
[worldStoryModel.STORYTYPE.DISCIPLE]="showDisciple",
[worldStoryModel.STORYTYPE.ACTION]="showAction",
[worldStoryModel.STORYTYPE.CREATEROLE]="showCreateRole",
[worldStoryModel.STORYTYPE.ANIMTREE]="showAnimTree",
[worldStoryModel.STORYTYPE.NPCTask]="showNPCTaskDialog",
[worldStoryModel.STORYTYPE.NPCTaskFinish]="showNPCTaskFinishDialog",
}


function worldStoryController:onAppStart()

worldStoryModel:onAppStart()











end


function worldStoryController:onEnterState()
worldStoryModel:onEnterState()
end


function worldStoryController:onServerDataInitFinish()
worldStoryModel:onServerDataInitFinish()
end


function worldStoryController:onLeaveState()
worldStoryModel:onLeaveState()

self.data={}
end


function worldStoryController:onLostConnection()

end































function worldStoryController:showStoryTree(treeId,callback,extraStage,...)

worldStoryModel:startTree(treeId,callback,{...},extraStage)
self:showStoryTreeItem()
end

function worldStoryController:showStoryTreeItem(option)
local data=worldStoryModel:getTree()
local info=worldStoryModel:getInfo(data[1],data[2])

if info then

self:showStory(info[1],info[2],function(option)
return self:afterStoryTreeItem(option)
end,data[5],unpack(data[4]))
else

worldStoryModel:clearTree()
if data[3]then
data[3](option)
end
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eStoryTree,data[1],2)
end
end

function worldStoryController:afterStoryTreeItem(option)

if not worldStoryModel:existTree()then

return
end

worldStoryModel:setOption(option)

local data=worldStoryModel:getTree()
local info=worldStoryModel:getInfo(data[1],data[2])
self:showStoryTreeItem(option)
return info and info[1]or nil
end

function worldStoryController:showStory(type,id,callback,stage,...)


self[_story_handle[type]](self,id,callback,stage,...)
end

function worldStoryController:showDialog(id,callback,stage,disciple,optionArgs)
local args={groupid=id,callback=callback,dis_guid=disciple,extraStage=stage}
if optionArgs then
for key,v in pairs(optionArgs)do
args[key]=v
end
end
gameplotController:showPlotBoard(args)
end

function worldStoryController:showComic(id,callback,stage)
gameplotController:showManHua({groupid=id,callback=callback,extraStage=stage})
end

function worldStoryController:showVideo(id,callback,stage)
gameplotController:showMovie({movieid=id,callback=callback,extraStage=stage})
end

function worldStoryController:showDisciple(scr,callback)

local discipleData=UIDiscipleModel:findSrcTypeDisciple(scr)
if discipleData then
local winArgs={
disciple=discipleData.discipleguid,
callback=callback
}

UIFullStoryBoardControl:showDiscipleWindow(winArgs)
else
loggerUtil.logErrFMT("没有数据源{0}的弟子显示",scr)
end
end

function worldStoryController:showDiscipleByItemId(itemid,isFullOpen,callback)
local discipleData=UIDiscipleModel:findSrcTypeDisciple(itemid)
if discipleData then
UIRecruitControl:showItemRecruitDiscipleWindow(itemid,discipleData.discipleguidStr,callback,isFullOpen)
else
loggerUtil.logErrFMT("没有数据源为道具id{0}的弟子显示",itemid)
end
end

function worldStoryController:showAction(id,callback,stage)

gameplotController:showAction({groupid=id,callback=callback,extraStage=stage})
end

function worldStoryController:showCreateRole(id,callback)
if playerModel:checkActorNameDefault()then
UIFullStoryBoardControl:showCreateRoleWindow({callback=callback})
else
callback()
end
end

function worldStoryController:showAnimTree(id,callback)

storyAIManager:startStoryBehavior(id,nil,callback)
end



function worldStoryController:showNPCTaskDialog(id,callback,stage,disciple,optionArgs)
local args={groupid=id,callback=callback,dis_guid=disciple,extraStage=stage}
if optionArgs then
for key,v in pairs(optionArgs)do
args[key]=v
end
end
taskModel:SetAcceptFlag(true)
gameplotController:showPlotBoard(args)
end


function worldStoryController:showNPCTaskFinishDialog(id,callback,stage,disciple,optionArgs)
local args={groupid=id,callback=callback,dis_guid=disciple,extraStage=stage}
if optionArgs then
for key,v in pairs(optionArgs)do
args[key]=v
end
end
taskModel:SetFinishFlag(true)
gameplotController:showPlotBoard(args)
end













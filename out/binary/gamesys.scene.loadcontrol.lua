loadControl={}





local _loadID=0
local _loadList={}
local _modelList={}
local _loadInfo={}
local _timer
local _outTime=15
local _closeTag=false
local _loadNum=0
local _loadMax=0
local _manualTriggle=false


function loadControl:onAppStart()

end

function loadControl:onEnterState()
_loadList={}
_loadID=0
_loadInfo=nil
_timer=nil
_modelList={}
_closeTag=false
_loadNum=0
_loadMax=0
_manualTriggle=false
end

function loadControl:onLeaveState()
_loadList={}
_loadID=0
_loadInfo=nil
if _timer then
_timer:cancel()
end
_timer=nil
_modelList={}
_loadNum=0
_loadMax=0
_manualTriggle=false
end


function loadControl.startLoadScene(loadInfo)
_loadInfo=loadInfo or{}
_loadList={}
_loadNum=0
_loadMax=0
loadControl.stoptimer()
_manualTriggle=false
end

function loadControl.onLoadedScene(name)
loadControl.startTimer()

end

function loadControl.LoadObjFinish(loadID)
_loadList[loadID]=nil
_loadNum=_loadNum+1
loadControl.postProgress()
loadControl.tryCloseLoading()
end

function loadControl.setCloseTag(flag)
_closeTag=flag
end

function loadControl.postProgress()
notifySystem:postNotify(notifyConfig.loadingObj,_loadNum,_loadMax)

end



function loadControl.markLoadObj(modelId)
_loadID=_loadID+1
_loadMax=_loadMax+1
_loadList[_loadID]=true
_modelList[_loadID]=modelId

return _loadID
end

function loadControl.tryCloseLoading()
if _closeTag and loadControl.isLoadFinsh()then
_closeTag=false
if _loadInfo.closeLoading~=false and not _manualTriggle then
sceneControl:closeLoading(0)
end
notifySystem:postNotify(notifyConfig.needLoadFinish)
_loadInfo=nil
loadControl.stoptimer()
return true
end
return false
end

function loadControl.isLoadFinsh()
if _loadInfo and next(_loadList)==nil then
return true
end
return false
end

local outTimeCall=function()






_loadList={}
_closeTag=true
_loadNum=0
_loadMax=0
loadControl.tryCloseLoading()
_manualTriggle=false
end

function loadControl.startTimer()
loadControl.stoptimer()
if UIManager:isActive('UILoading',true)then
_timer=timer.new()
if webGLHelper:isRunWebGL()then
_timer:start(webGLHelper:getLoadOutTime(),outTimeCall,1)
else
_timer:start(_outTime,outTimeCall,1)
end
end
end

function loadControl.stoptimer()
if _timer then
_timer:cancel()
end
_timer=nil
end

function loadControl.triggerTimeOut()
_manualTriggle=true
if _loadInfo and _loadInfo.closeLoading~=false then
sceneControl:closeLoading(0)
end
end

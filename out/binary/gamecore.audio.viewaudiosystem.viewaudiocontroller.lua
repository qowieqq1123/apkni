






local _MODULENAME="ViewAudioController"




gameState.addListener(def_table(_MODULENAME))
ViewAudioController.name=_MODULENAME

ViewAudioController.data={}

function ViewAudioController:onAppStart()

ViewAudioModel:onAppStart()








notifySystem:listenNotify(notifyConfig.showUI,self.showUI)
notifySystem:listenNotify(notifyConfig.closeUI,self.closeUI)
notifySystem:listenNotify(notifyConfig.hideUI,self.closeUI)


end


function ViewAudioController:onEnterState()
ViewAudioModel:onEnterState()
end


function ViewAudioController:onServerDataInitFinish()
ViewAudioModel:onServerDataInitFinish()
end


function ViewAudioController:onLeaveState()
ViewAudioModel:onLeaveState()

self.data={}
end


function ViewAudioController:onLostConnection()

end


function ViewAudioController.showUI(viewName)
local audioId=ViewAudioModel:get_view_open_audio(viewName)
if audioId then
local handleId=AudioManager.playAudio(audioId)
ViewAudioModel:setViewOpenAudioHandleIdList(viewName,handleId)
end
end


function ViewAudioController.closeUI(viewName)
local audioId=ViewAudioModel:get_view_close_audio(viewName)
if audioId then
AudioManager.playAudio(audioId)
end

local stopParam=ViewAudioModel:get_view_stop_audio_param(viewName)
local isNeedStopOpenSound=stopParam and stopParam[1]==1 or false
if isNeedStopOpenSound then

local audioHandleId=ViewAudioModel:getViewOpenAudioHandleIdList(viewName)
if audioHandleId then
local fadeTime=stopParam[2]or 1
if fadeTime and fadeTime>0 then
AudioManager.fadeOutStopAudioById(audioHandleId,fadeTime,false)
else
AudioManager.stopAudioById(audioHandleId)
end
end
end

ViewAudioModel:setViewOpenAudioHandleIdList(viewName,nil)
end


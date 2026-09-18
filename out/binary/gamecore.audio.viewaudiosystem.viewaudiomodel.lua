






local _MODULENAME="ViewAudioModel"




def_table(_MODULENAME)
ViewAudioModel.name=_MODULENAME
ViewAudioModel.data={}

function ViewAudioModel:onAppStart()

end


function ViewAudioModel:onEnterState()

end


function ViewAudioModel:onLeaveState()

self.data={}
end


function ViewAudioModel:onServerDataInitFinish()

end

function ViewAudioModel:get_view_open_audio(viewName)
local audioCfg=cfg_viewsoundconfig_get(viewName,false)
if audioCfg then
return audioCfg.openSoundID
end
end

function ViewAudioModel:get_view_close_audio(viewName)
local audioCfg=cfg_viewsoundconfig_get(viewName,false)
if audioCfg then
return audioCfg.closeSoundID
end
end

function ViewAudioModel:get_view_stop_audio_param(viewName)
local audioCfg=cfg_viewsoundconfig_get(viewName,false)
if audioCfg then
return audioCfg.stopSoundParam
end
end

function ViewAudioModel:setViewOpenAudioHandleIdList(viewName,handleId)
if not self.data.viewOpenAudioHandleIdList then self.data.viewOpenAudioHandleIdList={}end
self.data.viewOpenAudioHandleIdList[viewName]=handleId
end

function ViewAudioModel:getViewOpenAudioHandleIdList(viewName)
if self.data.viewOpenAudioHandleIdList and self.data.viewOpenAudioHandleIdList[viewName]then
return self.data.viewOpenAudioHandleIdList[viewName]
end
end
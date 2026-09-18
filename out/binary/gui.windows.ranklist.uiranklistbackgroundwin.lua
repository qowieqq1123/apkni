







def_class("UIRankListBackgroundWin",UIWindowBase)







local cshelper=CS.UIHelper

function UIRankListBackgroundWin:auto_bind()
end

















function UIRankListBackgroundWin:onLoaded(...)

end


function UIRankListBackgroundWin:__delete()
self:stopBgAudioSound()

end




function UIRankListBackgroundWin:onShow(argtable,afterOnloaded)
self:stopBgAudioSound()
self.bgAudioHandleId=nil




end


function UIRankListBackgroundWin:onHide()
self:stopBgAudioSound()
end


function UIRankListBackgroundWin:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end


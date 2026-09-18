







def_class("UITianMoJieNextStageWin",UIWindowBase)









function UITianMoJieNextStageWin:bindComponents()

self.background=UIButton.get(self,0)
self.content=UIText.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.title=UIText.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UITianMoJieNextStageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UITianMoJieNextStageWin:onLoaded(...)
self:bindComponents()
end


function UITianMoJieNextStageWin:__delete()
self:unbindComponents()
end




function UITianMoJieNextStageWin:onShow(argtable,afterOnloaded)
local stage=tianMoJieModel:getStage()
local config=cfgHelper.get1(cfg_tianmojiestageconfig_get,stage)
if config and config.tips then
self.title:setText(config.tips[1])
self.content:setText(config.tips[2])
else
self:onBackground()
end
tianMoJieModel:finishAnimData()
end


function UITianMoJieNextStageWin:onHide()

end



function UITianMoJieNextStageWin:onBackground()
self:closeSelf()
end

function UITianMoJieNextStageWin:onJumpBtn()
self:onBackground()
tianMoJieController:locateMinHPMonster(mapIdType.zhufeng,true)
end
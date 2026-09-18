systemTipsManager=gameState.addListener({})

function systemTipsManager:onAppStart()

end

function systemTipsManager:showWindow()
if self.win then return end
local name='SystemMsgTip'
UIManager.PreloadCtor(name)
local current_win_info=UIManager.get_window_config(name)
local widget=CS.GameInterface.GetSystemMsgWidget()
local win=current_win_info.ctor(widget,name)
win:onLoaded()
self.win=win
end
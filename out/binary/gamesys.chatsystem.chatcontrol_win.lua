function chatControl:onAppStart_win()
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
end

function chatControl:onEnterState_win()
end

function chatControl:onLeaveState_win()
end

function chatControl.freshMain(funcName,...)
UIManager:callWindowFunc('UIMain',funcName,...)
UIManager:callWindowFunc('UIXM_ZZSH_MapWin',funcName,...)
UIManager:callWindowFunc('UIXianJieMainWin',funcName,...)
end

function chatControl.freshChatMain(funcName,...)
UIManager:callWindowFunc('UIChatWin',funcName,...)
end

function chatControl.freshWorldChatMain(funcName,...)
UIManager:callWindowFunc('UIWorldWin',funcName,...)
end

function chatControl.onXianMengChange(flag)
if not flag then
local channelId=CHAT_CHANNNEL.eXianmeng
chatControl.clearChannelMesg(channelId)
UIManager:callWindowFunc('UIFightMainTop','onRecvMessage')
UIManager:callWindowFunc('UIWorldWin','onRecvMessage')
UIManager:callWindowFunc('UIMain','onRecvMessage')
UIManager:callWindowFunc('UIChatWin','freshBtnReddot',channelId)
UIManager:callWindowFunc('UIChatWin','freshChannel',channelId)
UIManager:callWindowFunc('UIXM_ZZSH_MapWin','onRecvMessage')
UIManager:callWindowFunc('UIXianJieMainWin','onRecvMessage')
end
end









UIFullCourtroomControl=gameState.addListener(fullScreenUI.create())

function UIFullCourtroomControl:onAppStart()
local args={

fullType=FULL_TYPE.eCourtroom,
defaultTabType=FULL_TAB_TYPE.eCourtroom,
}
self:initUI(args)
end

function UIFullCourtroomControl:showFullWindow(argstable)
local args={
showBg=true,
viewNames={'UICourtroomMainWin'},
viewArgs={['UICourtroomMainWin']=argstable
},
}
self:showUI(args)
end
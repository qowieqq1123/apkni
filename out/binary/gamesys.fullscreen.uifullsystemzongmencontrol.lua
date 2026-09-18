








UIFullSystemZongMenControl=gameState.addListener(fullScreenUI.create())

function UIFullSystemZongMenControl:onAppStart()
local args={
fullType=FULL_TYPE.eSystemZongMen,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullSystemZongMenControl:showMainWindow(argstable)
local args={
showBg=true,
viewNames={'UISystemZongMenFrameWin'},
viewArgs={['UISystemZongMenFrameWin']=argstable},
}
self:showUI(args)
end

function UIFullSystemZongMenControl:showOtherDiscipleWin(guid,dzList)
local args={}
args.dis_guid=guid
args.dislist=dzList
UIManager:showWindow('UIOtherDiscipleMainWin_SystemZongMen',args)
end








UIFullMysteryEventControl=gameState.addListener(fullScreenUI.create())

function UIFullMysteryEventControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eMysteryEvent,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end



function UIFullMysteryEventControl:showEventWindow(argstable,isNotFullOpen)
if not isNotFullOpen then
local args=
{
showBg=false,
viewNames={'UIMysteryEventWin',"UIMysteryEventInfoWin"},
viewArgs={['UIMysteryEventWin']=argstable},
}
self:showUI(args)
else
UIManager:showWindow("UIMysteryEventWin",argstable)
UIManager:showWindow("UIMysteryEventInfoWin")
end
self.isNotFullOpen=isNotFullOpen
end

function UIFullMysteryEventControl:closeUIEX(openMain,closeBtn)
if self.isNotFullOpen then
UIManager:closeWindow("UIMysteryEventWin")
UIManager:closeWindow("UIMysteryEventInfoWin")
UIManager:closeWindow("UIMysteryEventOutResultWin")
UIManager:closeWindow("UIMysteryEventDice2Win")
UIManager:closeWindow("UIMysteryEventMaskWin")
self.isNotFullOpen=nil
else
self:closeUI(openMain,closeBtn)
end
end
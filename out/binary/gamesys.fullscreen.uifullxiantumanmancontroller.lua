
UIFullXianTuManManController=gameState.addListener(fullScreenUI.create())

function UIFullXianTuManManController:onAppStart()








local args=
{

skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eXianTuManMan,
}
self:initUI(args)
end

function UIFullXianTuManManController:showWindowXianTuManMan(argstable)

local args=
{



viewNames={'UIXianTuManManWin'},
viewArgs={['UIXianTuManManWin']=argstable},

}
self:showUI(args)
return true
end

function UIFullXianTuManManController:showMainUI(args)
self:showWindowXianTuManMan(args)
end
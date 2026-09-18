




UIFullYuLingZhaiControl=gameState.addListener(fullScreenUI.create())

function UIFullYuLingZhaiControl:onAppStart()

local args=
{
fullType=FULL_TYPE.eYuLingZhai,
skinType=fullScreenSkinType.eSkin26,
}
self:initUI(args)
end


function UIFullYuLingZhaiControl:showMainWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eYuLingZhai
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIYuLingZhaiWin'},
viewArgs={['UIYuLingZhaiWin']=argstable},
}


self:showUI(args)
return true
end
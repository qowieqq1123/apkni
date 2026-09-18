




UIFullAutoBuildingControl=gameState.addListener(fullScreenUI.create())

function UIFullAutoBuildingControl:onAppStart()




local menulist=
{


}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eAutoBuilding,
skinType=fullScreenSkinType.eSkin1,

}
self:initUI(args)
end


function UIFullAutoBuildingControl:showAutoBuildingWindow(argstable)
if AutoBuildController:checkIsOpen()then
local tabType=FULL_TAB_TYPE.eAutoBuilding
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIAutoBuildingWin'},
viewArgs={['UIAutoBuildingWin']=argstable},
}
self:showUI(args)
return true
else
UIManager.info('系统未开启')
return false
end
end
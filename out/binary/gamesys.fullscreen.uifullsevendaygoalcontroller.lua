








UIFullSevenDayGoalController=gameState.addListener(fullScreenUI.create())

function UIFullSevenDayGoalController:onAppStart()

local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eSevenDayGoal,
}
self:initUI(args)
end



function UIFullSevenDayGoalController:showWindowDayInfo(argstable)
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UISevenDayGoalWin'},
viewArgs={['UISevenDayGoalWin']=argstable or{}},
}
self:showUI(args)
return true
end


function UIFullSevenDayGoalController:showMainUI(dayIndex,goalTypeIndex)
local args={}
args.dayIndex=dayIndex
args.goalTypeIndex=goalTypeIndex
self:showWindowDayInfo(args)
end

function UIFullSevenDayGoalController:showWindowLibaoBuyDialog(argstable)
self:showWindow("UISevenDayLibaoBuyDialogWin",argstable)
end
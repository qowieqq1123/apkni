







UIFullNongYuControl=gameState.addListener(fullScreenUI.create())

function UIFullNongYuControl:onAppStart()
local menulist={

{tabType=FULL_TAB_TYPE.eProduction_nongYu,callback=function(...)self:showNatureWindow(...)end},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eNongYu,
}
self:initUI(args)
end

function UIFullNongYuControl:showNatureWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_nongYu
local args={
tabType=tabType,
showBg=true,
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end


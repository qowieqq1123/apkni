







UIFullXingRangControl=gameState.addListener(fullScreenUI.create())

function UIFullXingRangControl:onAppStart()
local menulist={

{tabType=FULL_TAB_TYPE.eProduction_xingRang,callback=function(...)self:showNatureWindow(...)end},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eXingRang,
}
self:initUI(args)
end

function UIFullXingRangControl:showNatureWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_xingRang
local args={
tabType=tabType,
showBg=true,
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end
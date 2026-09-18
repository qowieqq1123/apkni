







UIFullXingYunControl=gameState.addListener(fullScreenUI.create())

function UIFullXingYunControl:onAppStart()
local menulist={

{tabType=FULL_TAB_TYPE.eProduction_xingYun,callback=function(...)self:showNatureWindow(...)end},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eXingYun,
}
self:initUI(args)
end

function UIFullXingYunControl:showNatureWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_xingYun
local args={
tabType=tabType,
showBg=true,
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end


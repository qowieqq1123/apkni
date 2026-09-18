







UIFullDianXingControl=gameState.addListener(fullScreenUI.create())

function UIFullDianXingControl:onAppStart()
local menulist={

{tabType=FULL_TAB_TYPE.eProduction_dianxing,callback=function(...)self:showNatureWindow(...)end},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eDianXing,
}
self:initUI(args)
end

function UIFullDianXingControl:showNatureWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_dianxing
local args={
tabType=tabType,
showBg=true,
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end


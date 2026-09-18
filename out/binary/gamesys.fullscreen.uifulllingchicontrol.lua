







UIFullLingChiControl=gameState.addListener(fullScreenUI.create())

function UIFullLingChiControl:onAppStart()
local menulist={

{tabType=FULL_TAB_TYPE.eProduction_lingchi,callback=function(...)self:showNatureWindow(...)end},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eLingChi,
}
self:initUI(args)
end

function UIFullLingChiControl:showNatureWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_lingchi
local args={
tabType=tabType,
showBg=true,
viewNames={'UINaturalWin'},
viewArgs={['UINaturalWin']=argstable},
}
self:showUI(args)
end
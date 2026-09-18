




UIFullLittleWorldControl=gameState.addListener(fullScreenUI.create())

function UIFullLittleWorldControl:onAppStart()

local args=
{
fullType=FULL_TYPE.eLittleWorld,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullLittleWorldControl:isOpenPlanent()
return self.openPlanentFlag
end

function UIFullLittleWorldControl:setOpenPlanent(flag)
self.openPlanentFlag=flag
end

function UIFullLittleWorldControl:showTabWindow(argstable)
argstable=argstable or{}
local args=argstable.args or{}
if args.args and args.args.tab then
local tab=args.args.tab
if tab==1 then
UIFullLittleWorldControl:showMainWindow(args)
elseif tab==2 then
args.playOpen=true
UIFullLittleWorldControl:showZhenWuMainWindow(args)
elseif tab==3 then
args.playOpen=true
UIFullLittleWorldControl:showXingChenMainWindow(args)
end
else
UIFullLittleWorldControl:showMainWindow(args)
end
end


function UIFullLittleWorldControl:showMainWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldInfoWin'},
viewArgs={
['UIXJLittleWorldInfoWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld},
},
}


self:showUI(args)
return true
end

function UIFullLittleWorldControl:showZhenWuMainWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorldZW)then
return
end

argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_ZhenWu
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldZhenWuWin','UILittleWorldZhenWuSlotWin'},
viewArgs={
['UIXJLittleWorldZhenWuWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_ZhenWu},
},
}


self:showUI(args)
return true
end

function UIFullLittleWorldControl:showZhenWuBagWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_ZhenWu
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldZhenWuBagWin','UILittleWorldZhenWuSlotWin'},
viewArgs={
['UIXJLittleWorldZhenWuBagWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_ZhenWu},
},
}
self:showUI(args)
return true
end

function UIFullLittleWorldControl:showXingChenMainWindow(argstable)

if not xingChenHelper.isXingChenOpen()then
return
end

argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_XingChen
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldXingChenWin'},
viewArgs={
['UIXJLittleWorldXingChenWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_XingChen},
},
}

self:showUI(args)
return true
end

function UIFullLittleWorldControl:showXingChenBagWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_XingChen
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldXingChenBagWin'},
viewArgs={
['UIXJLittleWorldXingChenBagWin']=argstable,
['UIPlanent']={},
},
}
self:showUI(args)
return true
end


function UIFullLittleWorldControl:showXingChenIncreaseWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_XingChenUp
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldXingChenUpWin'},
viewArgs={
['UIXJLittleWorldXingChenUpWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_XingChenUp},
},
}
self:showUI(args)
return true
end


function UIFullLittleWorldControl:showXingChenRongHeWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_XingChenRongHe
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldXingChenRongHeWin'},
viewArgs={
['UIXJLittleWorldXingChenRongHeWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_XingChenRongHe},
},
}
self:showUI(args)
return true
end


function UIFullLittleWorldControl:showXingChenFenJieWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLittleWorld_XingChenFenJie
local args=
{
tabType=tabType,
showBg=false,
viewNames={'UIPlanent','UIXJLittleWorldXingChenFenJieWin'},
viewArgs={
['UIXJLittleWorldXingChenFenJieWin']=argstable,
['UIPlanent']={tabType=FULL_TAB_TYPE.eLittleWorld_XingChenFenJie},
},
}
self:showUI(args)
return true
end
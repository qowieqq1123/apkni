








UIFullDiscipleSelectControl=gameState.addListener(fullScreenUI.create())
function UIFullDiscipleSelectControl:onAppStart()
local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _showDiscipleSelectWindow(...)self:showDiscipleSelectWindow(...)end
local function _showLingShouSelectWindow(...)self:showLingShouSelectWindow(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eDiscipleSelect,callback=_showDiscipleSelectWindow,sendCallback=_initSendPro1,
reddotType=REDDIT_SUB_TYPE.sDiscipleBase,titleNames="弟子列表"},

{tabType=FULL_TAB_TYPE.eLingShouSelect,callback=_showLingShouSelectWindow,sendCallback=_initSendPro2,
reddotType=REDDIT_SUB_TYPE.sLingShouEnter,titleNames="灵兽列表"},
}


local args=
{
menulist=menulist,
fullType=FULL_TYPE.eDiscipleSelect,
skinType=fullScreenSkinType.eSkin3,
}
self:initUI(args)
end


function UIFullDiscipleSelectControl:showDiscipleSelectWindow(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleSelect
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleSelectWin'},
viewArgs={['UIDiscipleSelectWin']=argstable or{}},
}
self:showUI(args)
return true
end


function UIFullDiscipleSelectControl:showLingShouSelectWindow(argstable)
local tabType=FULL_TAB_TYPE.eLingShouSelect
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouListSelectWin'},
viewArgs={['UILingShouListSelectWin']=argstable or{}},
}
self:showUI(args)
return true
end


function UIFullDiscipleSelectControl:initSendPro1()

end

function UIFullDiscipleSelectControl:initSendPro2()

end
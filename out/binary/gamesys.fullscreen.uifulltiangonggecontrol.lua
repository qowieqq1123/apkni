




UIFullTianGongGeControl=gameState.addListener(fullScreenUI.create())

function UIFullTianGongGeControl:onAppStart()
local function _showProductionWindow(...)self:showProductionWindow(...)end
local function _ShowZhenFaWindow(...)self:showZhenFaWindow(...)end
local function _ShowLingZhenDiaoKeWindow(...)self:showLingZhenDiaoKeWindow(...)end

local function _initSendProductionPro(...)self:initSendProductionPro(...)end
local function _initSendZhenFaPro(...)self:initSendZhenFaPro(...)end

local function _checkOpen(...)return LZDiaoKeController.checkOpen()end
local menulist=
{

{tabType=FULL_TAB_TYPE.eProduction_tiangongge,callback=_showProductionWindow,sendCallback=_initSendProductionPro},

{tabType=FULL_TAB_TYPE.eZhenFa,callback=_ShowZhenFaWindow,sendCallback=_initSendZhenFaPro,reddotType=REDDIT_SUB_TYPE.sZhenFa},

{tabType=FULL_TAB_TYPE.eZhenTuYanJiu,callback=function(...)self:showZhenTuYanJiuWindow(...)end,reddotType=REDDIT_TYPE.eLingZhenYanJiu,},

{tabType=FULL_TAB_TYPE.eLingZhenDiaoKe,callback=_ShowLingZhenDiaoKeWindow,reddotType=REDDIT_SUB_TYPE.slingZhenDiaoke,checkOpen=_checkOpen},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eTianGongGe,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullTianGongGeControl:showTGGWin(sArgs)
if sArgs.args then
local tabType=sArgs.args.tabType
if tabType==FULL_TAB_TYPE.eProduction_tiangongge then
self:showProductionWindow(sArgs.data)
elseif tabType==FULL_TAB_TYPE.eZhenFa then
self:showZhenFaWindow(sArgs.data)
elseif tabType==FULL_TAB_TYPE.eZhenTuYanJiu then
self:showZhenTuYanJiuWindow(sArgs)
elseif tabType==FULL_TAB_TYPE.eLingZhenDiaoKe then
self:showLingZhenDiaoKeWindow(sArgs)
else
self:showProductionWindow(sArgs.data)
end
else
self:showProductionWindow(sArgs.data)
end
end

function UIFullTianGongGeControl:showProductionWindow(argstable)
local tabType=FULL_TAB_TYPE.eProduction_tiangongge
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIManufactureWin'},
viewArgs={['UIManufactureWin']=argstable},
}
self:initReddotConfig(args)
self:showUI(args)
end

function UIFullTianGongGeControl:initSendProductionPro()

end

function UIFullTianGongGeControl:initSendFabaoPro()

end

function UIFullTianGongGeControl:showZhenFaWindow(argstable)
local tabType=FULL_TAB_TYPE.eZhenFa
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIZhenFaStudyWin'},
viewArgs={['UIZhenFaStudyWin']=argstable},
}
self:initReddotConfig(args)
self:showUI(args)
end

function UIFullTianGongGeControl:initSendZhenFaPro()

end

function UIFullTianGongGeControl:initReddotConfig(args)
local attach=self:tryGetAttachArgs(args)
local entityId=attach.entityId
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingByEntityId(entityId)
local ubdId=bdData.un_build_id
local key=zhenfaSheetReddot.addConfig(ubdId)
self:reviseSubMenuValue(FULL_TAB_TYPE.eZhenFa,'reddotType',key)
local key2=lingzhenDiaokeSheetReddot.addConfig(ubdId)
self:reviseSubMenuValue(FULL_TAB_TYPE.eLingZhenDiaoKe,'reddotType',key2)
end

function UIFullTianGongGeControl:showZhenTuYanJiuWindow(argstable)
local tabType=FULL_TAB_TYPE.eZhenTuYanJiu

argstable.entityId=argstable.data and argstable.data.entityId or argstable.entityId
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIZhenTuYanJiuWin'},
viewArgs={['UIZhenTuYanJiuWin']=argstable},
}

self:showUI(args)
end


function UIFullTianGongGeControl:showLingZhenDiaoKeWindow(argstable)
if not LZDiaoKeController.checkOpen()then
UIManager.error("灵阵雕刻未开启")
return
end
local tabType=FULL_TAB_TYPE.eLingZhenDiaoKe
argstable.showPage=self:getTabIdx(tabType)
argstable.entityId=argstable.data and argstable.data.entityId or argstable.entityId
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILZDKMainWin'},
viewArgs={['UILZDKMainWin']=argstable},
}
self:initReddotConfig(args)
self:showUI(args)
end

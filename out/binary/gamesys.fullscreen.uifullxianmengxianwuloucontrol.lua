







UIFullXianMengXianWuLouControl=gameState.addListener(fullScreenUI.create())

function UIFullXianMengXianWuLouControl:onAppStart()
local function _showInfoWindow(...)self:showInfoWindow(...)end
local function _showFXZYWindow(...)self:showFXZYWindow(...)end
local function _showKuFangWindow(...)self:showKuFangWindow(...)end
local function _showZengliWindow(...)self:showZengliWindow(...)end

local function _checkKuFangOpen(attach)return self:check_showWindowKuFang(attach,false)end
local function _checkZengLiOpen(attach)return self:check_showWindowZengLi()end

local menulist=
{
{tabType=FULL_TAB_TYPE.eXianWuLou,callback=_showInfoWindow},
{tabType=FULL_TAB_TYPE.eXianMengFenXiangZiYuan,callback=_showFXZYWindow,reddotType=REDDIT_SUB_TYPE.sXWLFenXiangZiYuan},
{tabType=FULL_TAB_TYPE.eXianMengKuFang,callback=_showKuFangWindow,checkOpen=_checkKuFangOpen},
{tabType=FULL_TAB_TYPE.eXMZengLi,callback=_showZengliWindow,reddotType=REDDIT_SUB_TYPE.sXianMengZengLi,checkOpen=_checkZengLiOpen},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eXMXianWuLou,
attachName={},
}
self:initUI(args)
end

function UIFullXianMengXianWuLouControl:showMyWindow(tabType,argstable)
tabType=tabType or FULL_TAB_TYPE.eXianWuLou
if tabType==FULL_TAB_TYPE.eXianWuLou then
self:showInfoWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eXianMengFenXiangZiYuan then
self:showFXZYWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eXianMengKuFang then
self:showKuFangWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eXMZengLi then
self:showZengliWindow(argstable)
end
end

function UIFullXianMengXianWuLouControl:showInfoWindow(argstable)
local tabType=FULL_TAB_TYPE.eXianWuLou
local args={
showBg=true,
tabType=tabType,
viewNames={'UIXMXianWuLouWin','UIXMXianWuLouModelWin'},
viewArgs={
['UIXMXianWuLouWin']=argstable,
['UIXMXianWuLouModelWin']={},
},
}
self:showUI(args)
local tabCfg=fullScreenModel.getFullTabConfig(tabType)
local title=tabCfg.titleName
self:setTitle(title)
end

function UIFullXianMengXianWuLouControl:showFXZYWindow(argstable)




local tabType=FULL_TAB_TYPE.eXianMengFenXiangZiYuan
local args={
showBg=true,
tabType=tabType,
viewNames={'UIXMFXZYWin','UIXMXianWuLouModelWin'},
viewArgs={
['UIXMFXZYWin']=argstable,
['UIXMXianWuLouModelWin']={},
},
}
self:showUI(args)
local tabCfg=fullScreenModel.getFullTabConfig(tabType)
local title=tabCfg.titleName
self:setTitle(title)
end


function UIFullXianMengXianWuLouControl:showKuFangWindow(argstable)
local tabType=FULL_TAB_TYPE.eXianMengKuFang
argstable=argstable or{}
argstable.tabIndex=argstable.tabIndex or 1
local args={
showBg=true,
tabType=tabType,
viewNames={'UIXMKuFangTabWin','UIXMXianWuLouModelWin'},
viewArgs={
['UIXMKuFangTabWin']=argstable,
['UIXMXianWuLouModelWin']={},
},
}
self:showUI(args)
local tabCfg=fullScreenModel.getFullTabConfig(tabType)
local title=tabCfg.titleName
self:setTitle(title)
end


function UIFullXianMengXianWuLouControl:showZengliWindow(argstable)
local tabType=FULL_TAB_TYPE.eXMZengLi
argstable=argstable or{}
argstable.tabIndex=argstable.tabIndex or 1
local args={
showBg=true,
tabType=tabType,
viewNames={'UIXMZengLiTabWin','UIXMXianWuLouModelWin'},
viewArgs={
['UIXMZengLiTabWin']=argstable,
['UIXMXianWuLouModelWin']={},
},
}
self:showUI(args)
local tabCfg=fullScreenModel.getFullTabConfig(tabType)
local title=tabCfg.titleName
self:setTitle(title)
end


function UIFullXianMengXianWuLouControl:touchBuild()
local data=zongmenModel:findBuildingDataByID(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
if data then
isometricMapSystem:openBuildingWin(data)
local pos=_MapManager.GetObjectAreaC(data.entityId)
isometricMapSystem:moveCameraToPosition(pos,true)
end
end


function UIFullXianMengXianWuLouControl:check_showWindowKuFang(attach,isWarning)
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eZhengZhanShanHai)and systemModel.isOpen(SYSTEM_DEFINE.eXMKFkuCunJuanXian)
end


function UIFullXianMengXianWuLouControl:check_showWindowZengLi()
return systemModel.isOpen(SYSTEM_DEFINE.eGuildBox)
end
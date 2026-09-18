







UIFullCangJingGeXinFaControl=gameState.addListener(fullScreenUI.create())

function UIFullCangJingGeXinFaControl:onAppStart()
local function _showWindowXianShu(...)self:showWindowXianShu(...)end
local function _showWindowMoGong(...)self:showWindowMoGong(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eCangJingGeXianShu,callback=_showWindowXianShu,sendCallback=_initSendPro1,reddotType=REDDIT_SUB_TYPE.sCangJingGeXianShu},

{tabType=FULL_TAB_TYPE.eCangJingGeMoGong,callback=_showWindowMoGong,sendCallback=_initSendPro2,reddotType=REDDIT_SUB_TYPE.sCangJingGeMoGong},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eCangJingGeXinFa,
skinType=fullScreenSkinType.eSkin1,
attachName={'entityID'},
}
self:initUI(args)
end

function UIFullCangJingGeXinFaControl:showXinFaWindow(tabType,args,nextFunc)
tabType=tabType or FULL_TAB_TYPE.eCangJingGeXianShu
args=args or{}
if args.data and args.data.entityId then
args.entityID=args.data.entityId
else
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)
args.entityID=bdData and bdData.entityId
end

if tabType==FULL_TAB_TYPE.eCangJingGeXianShu then
UIFullCangJingGeXinFaControl:showWindowXianShu(args)
elseif tabType==FULL_TAB_TYPE.eCangJingGeMoGong then
UIFullCangJingGeXinFaControl:showWindowMoGong(args)
end
if nextFunc then
local func=function()
nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullCangJingGeXinFaControl:showWindowXianShu(argstable)
local tabType=FULL_TAB_TYPE.eCangJingGeXianShu
argstable.type=1
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXinFaMainWin'},
viewArgs={['UIXinFaMainWin']=argstable},
}
self:showUI(args)
end

function UIFullCangJingGeXinFaControl:showWindowMoGong(argstable)
local tabType=FULL_TAB_TYPE.eCangJingGeMoGong
argstable.type=2
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXinFaMainWin'},
viewArgs={['UIXinFaMainWin']=argstable},
}
self:showUI(args)
end

function UIFullCangJingGeXinFaControl:initSendPro1()

end

function UIFullCangJingGeXinFaControl:initSendPro2()

end
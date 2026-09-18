







UIFullQianJiGeControl=gameState.addListener(fullScreenUI.create())

function UIFullQianJiGeControl:onAppStart()
local function _showTanSuoJiNeng(...)self:showFullQianJiGeWindow(...)end

local function _showWindowFaZeBaoDian(...)self:showWindowFaZeBaoDian(...)end


local menulist=
{
{tabType=FULL_TAB_TYPE.eTanSuoJiNeng,callback=_showTanSuoJiNeng},



{tabType=FULL_TAB_TYPE.eFaZeBaoDian,reddotType=REDDIT_TYPE.eFaZeBaoDian,callback=_showWindowFaZeBaoDian},
}

local args={
menulist=menulist,
fullType=FULL_TYPE.eQianJiGe,
}



self:initUI(args)
end

function UIFullQianJiGeControl:showMyWindowByBuild(args)
local tabType=FULL_TAB_TYPE.eTanSuoJiNeng
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end

if tabType==FULL_TAB_TYPE.eTanSuoJiNeng then
self:showFullQianJiGeWindow(args.data)
elseif tabType==FULL_TAB_TYPE.eShangGuXianDi then

UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eQJXSRewards})
elseif tabType==FULL_TAB_TYPE.eFaZeBaoDian then
self:showWindowFaZeBaoDian(args.data)
end
end

function UIFullQianJiGeControl:showFullQianJiGeWindow(argstable)
local tabType=FULL_TAB_TYPE.eTanSuoJiNeng
local args={
tabType=tabType,
showBg=true,
viewNames={'UIQianJiGeWin','UIQianJiGeUpWin'},
viewArgs={['UIQianJiGeWin']=argstable,
['UIQianJiGeUpWin']=argstable},
}
return self:showUI(args)
end













function UIFullQianJiGeControl:showWindowFaZeBaoDian(argstable)
local tabType=FULL_TAB_TYPE.eFaZeBaoDian
local args={
tabType=tabType,
showBg=true,
viewNames={'UIQianJiGeTuJianWin','UIQianJiGeUpWin'},
viewArgs={['UIQianJiGeTuJianWin']=argstable,
['UIQianJiGeUpWin']=argstable},
}
return self:showUI(args)
end









UIFullGuBaoControl=gameState.addListener(fullScreenUI.create())

function UIFullGuBaoControl:onAppStart()
local function _showWindowCollect(...)self:showWindowCollect(...)end
local function _showWindowDaoBing(...)self:showWindowDaoBing(...)end
local function _showWindowXianBao(...)self:showWindowXianBao(...)end

local function _checkOpenXianBao(...)return self:checkOpenXianBao(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eGuBaoCollect,callback=_showWindowCollect,reddotType=REDDIT_TYPE.eGuBaoCollect},

{tabType=FULL_TAB_TYPE.eDaoBing,callback=_showWindowDaoBing,reddotType=REDDIT_TYPE.eDaoBing},

{tabType=FULL_TAB_TYPE.eXianBao,callback=_showWindowXianBao,reddotType=REDDIT_TYPE.eXianBao,checkOpen=_checkOpenXianBao},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eGuBao,
skinType=fullScreenSkinType.eSkin3,
}
self:initUI(args)
end

function UIFullGuBaoControl:showWindowCollect(argstable)
local tabType=FULL_TAB_TYPE.eGuBaoCollect
argstable=argstable or{}
argstable.btnType=argstable.btnType or 1
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGuBaoMainWin'},
viewArgs={['UIGuBaoMainWin']=argstable or{}},
}
self:showUI(args)
return true
end


function UIFullGuBaoControl:showWindowBag(argstable)
argstable=argstable or{}
argstable.btnType=argstable.btnType or 2
return UIFullGuBaoControl:showWindowCollect(argstable)
end

function UIFullGuBaoControl:showWindowDaoBing(argstable)
local tabType=FULL_TAB_TYPE.eDaoBing
argstable=argstable or{}
argstable.btnType=argstable.btnType or 1
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDaoBingMainWin'},
viewArgs={['UIDaoBingMainWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullGuBaoControl:showWindowDaoBingCollect(argstable)
argstable=argstable or{}
argstable.btnType=argstable.btnType or 1
return UIFullGuBaoControl:showWindowDaoBing(argstable)
end


function UIFullGuBaoControl:showWindowDaoBingBag(argstable)
argstable=argstable or{}
argstable.btnType=argstable.btnType or 2
return UIFullGuBaoControl:showWindowDaoBing(argstable)
end



function UIFullGuBaoControl:onCheckReddotCollect()
return gubaoModel:checkCollectPageReddot()
end


function UIFullGuBaoControl:showWindowXianBao(argstable)
local tabType=FULL_TAB_TYPE.eXianBao
argstable=argstable or{}
argstable.btnType=argstable.btnType or 1
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIXianBaoTabWin'},
viewArgs={['UIXianBaoTabWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullGuBaoControl:checkOpenXianBao()
return xianbaoController:checkOpenXianBao()
end

function UIFullGuBaoControl:showWindowXianBaoTuJian(argstable)
argstable=argstable or{}
argstable.btnType=argstable.btnType or 1
return UIFullGuBaoControl:showWindowXianBao(argstable)
end

function UIFullGuBaoControl:showWindowXianBaoBag(argstable)
argstable=argstable or{}
argstable.btnType=argstable.btnType or 2
return UIFullGuBaoControl:showWindowXianBao(argstable)
end

function UIFullGuBaoControl:showWindowMainWin(argstable)

local nextCanShowFun
for i,v in ipairs(self.subMenu)do
local isOpen=true
if v.checkOpen~=nil then
isOpen=v.checkOpen()
end
if isOpen then
local reddotType=v.reddotType
local showFunc=v.callback
if reddotType then
local isreddot=reddotClassManager.get_reddot(reddotType)
if isreddot and showFunc then
return showFunc(argstable)
end
end
if not nextCanShowFun then
nextCanShowFun=showFunc
end
end
end

if nextCanShowFun then
return nextCanShowFun(argstable)
end
end



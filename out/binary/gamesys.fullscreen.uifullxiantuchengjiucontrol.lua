







UIFullXianTuChengJiuControl=gameState.addListener(fullScreenUI.create())

local _popUpWin={}

function UIFullXianTuChengJiuControl:onAppStart()

local function _showWindow_ZongMenXianTu(...)self:showWindow_ZongMenXianTu(...)end
local function _showWindow_XianTuChengJiu(...)self:showWindow_XianTuChengJiu(...)end
local function _showWindow_FeiShengDaoTu(...)self:showWindow_FeiShengDaoTu(...)end
local function _showWindow_XianZhi(...)self:showWindow_XianZhi(...)end


local function _checkOpen_XianZhi(...)return self:checkOpen_XianZhi(...)end
local function _checkOpen_ZongMenXianTu(...)return self:checkOpen_ZongMenXianTu(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eXianZhi,callback=_showWindow_XianZhi,reddotType=REDDIT_TYPE.eXianZhi,checkopen=_checkOpen_XianZhi},

{tabType=FULL_TAB_TYPE.eZongMenXianTu,callback=_showWindow_ZongMenXianTu,reddotType=REDDIT_TYPE.eXianTuChengJiu_ZongMenXianTu,checkopen=_checkOpen_ZongMenXianTu},

{tabType=FULL_TAB_TYPE.eXianTuChengJiu,callback=_showWindow_XianTuChengJiu,reddotType=REDDIT_TYPE.eXianTuChengJiu_XianTuChengJiu},

{tabType=FULL_TAB_TYPE.eFeiShengDaoTu,callback=_showWindow_FeiShengDaoTu,reddotType=REDDIT_TYPE.eXianTuChengJiu_FeiShengDaoTu},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXianTuChengJiu,
skinType=fullScreenSkinType.eSkin17,
}
self:initUI(args)

notifySystem:listenNotify(notifyConfig.closeUI,self.onClosePopUp)
end


function UIFullXianTuChengJiuControl:showWindow_ZongMenXianTu(argstable)
local tabType=FULL_TAB_TYPE.eZongMenXianTu
local args=
{
tabType=tabType,
showBlur=false,
showTopMask=true,
viewNames={'UIZongMenXianTuWin'},
viewArgs={['UIZongMenXianTuWin']=argstable or{}},
}
self:showUI(args)
local closeCallback=function()
xianzhiModel:setReturnToZMXTFlag(false)
return false
end
fullScreenUI.setNextActiveUICallback(closeCallback)
return true
end

function UIFullXianTuChengJiuControl:showWindow_XianTuChengJiu(argstable)
local tabType=FULL_TAB_TYPE.eXianTuChengJiu
local args=
{
tabType=tabType,
showBlur=false,
showTopMask=true,
viewNames={'UIXianTuChengJiuWin'},
viewArgs={['UIXianTuChengJiuWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullXianTuChengJiuControl:showWindow_FeiShengDaoTu(argstable)
local tabType=FULL_TAB_TYPE.eFeiShengDaoTu
local args=
{
tabType=tabType,
showBlur=false,
showTopMask=true,
viewNames={'UIFeiShengDaoTuWin'},
viewArgs={['UIFeiShengDaoTuWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullXianTuChengJiuControl:showWindow_XianZhi(argstable)

if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then return false end

local tabType=FULL_TAB_TYPE.eXianZhi
local args=
{
tabType=tabType,
showBlur=false,
showTopMask=true,
viewNames={'UIXianZhiWin'},
viewArgs={['UIXianZhiWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullXianTuChengJiuControl:checkOpen_XianZhi()
if xianzhiModel:checkOpenXianZhi()then
if not xianzhiModel:getReturnToZMXTFlag()then
return true
end
end
return false
end

function UIFullXianTuChengJiuControl:checkOpen_ZongMenXianTu()
if systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then

if xianzhiModel:checkFirstOpenXianZhi()then
return true
end


if xianzhiModel:getReturnToZMXTFlag()then
return true
end

return false
else
return true
end
end


function UIFullXianTuChengJiuControl:showWindowByCloud(callback,endCallBack)
local startCallback=function()
callback()

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallBack})
end



function UIFullXianTuChengJiuControl:showGuBaoLvUpWin(gbid,oldlv,newlv)
UIManager:showWindow("UIXianTuChengJiuGuBaoLevelUpWin",{id=gbid,oldlv=oldlv,newlv=newlv,})
end

function UIFullXianTuChengJiuControl:showMainWindow(tab,param)
local index=tab

local defaultTabIndex=eXianTuChengJiuScreneTabType.ZongMenXianTu

if xianzhiModel:checkOpenXianZhi()then
defaultTabIndex=eXianTuChengJiuScreneTabType.XianZhi
end

if xianzhiModel:checkFirstOpenXianZhi()then
index=eXianTuChengJiuScreneTabType.ZongMenXianTu
end

if not index then
for i,v in ipairs(self.subMenu)do
local reddot=reddotClassManager.get_reddot(v.reddotType)
if reddot then
index=i
break
end
end
end

index=index or defaultTabIndex

self.subMenu[index].callback(param)
end

function UIFullXianTuChengJiuControl:showWindow_Guide(argstable)
local bts=behaviorManager:getBehaviorTreeByFile("story_24_XianTu_1")
self:showWindow("UIStoryDesWin",{stime=0,ctime=0.5,bt=bts[1]})
end

function UIFullXianTuChengJiuControl:addPopUpWin(winName,winArgs)
table.insert(_popUpWin,{winName,winArgs})
end

function UIFullXianTuChengJiuControl:showPopUpWin()
local popUp=_popUpWin[1]
if popUp then
UIManager:showWindow(popUp[1],popUp[2])
end
end

function UIFullXianTuChengJiuControl.onClosePopUp(winName,isClose)
local popUp=_popUpWin[1]
if popUp and winName==popUp[1]then
table.remove(_popUpWin,1)
UIFullXianTuChengJiuControl:showPopUpWin()
end
end

function UIFullXianTuChengJiuControl.showTipsWin()
UIManager:showWindow("UIXianTuChengJiuTipsWin")
end

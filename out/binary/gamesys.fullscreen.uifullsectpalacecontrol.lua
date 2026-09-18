







UIFullSectPalaceControl=gameState.addListener(fullScreenUI.create())

function UIFullSectPalaceControl:onAppStart()
local function _showWindowGuildOrder(...)self:showWindowGuildOrder(...)end
local function _showWindowPost(...)self:showWindowPost(...)end
local function _showWindowInfo(...)self:showWindowInfo(...)end
local function _showWindowNPC(...)self:showWindowNPC(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end
local function _initSendPro4(...)self:initSendPro4(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eSectPalaceInfo,callback=_showWindowInfo,sendCallback=_initSendPro3,reddotType=REDDIT_SUB_TYPE.sSectPalaceInfo},

{tabType=FULL_TAB_TYPE.eSectPalacePost,callback=_showWindowPost,sendCallback=_initSendPro2},

{tabType=FULL_TAB_TYPE.eNPC,callback=_showWindowNPC,sendCallback=_initSendPro4},

{tabType=FULL_TAB_TYPE.eGuildOrder,callback=_showWindowGuildOrder,reddotType=REDDIT_SUB_TYPE.sGuildOrder,
sendCallback=_initSendPro1},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eSectPalace,
skinType=fullScreenSkinType.eSkin3,
attachName={'entityID'},
}
self:initUI(args)
end

function UIFullSectPalaceControl:showMyWindow(tabType,args,nextFunc)
if tabType==FULL_TAB_TYPE.eGuildOrder then
UIFullSectPalaceControl:showWindowGuildOrder(args)
elseif tabType==FULL_TAB_TYPE.eSectPalacePost then
UIFullSectPalaceControl:showWindowPost(args)
elseif tabType==FULL_TAB_TYPE.eSectPalaceInfo then
UIFullSectPalaceControl:showWindowInfo(args)
elseif tabType==FULL_TAB_TYPE.eNPC then
UIFullSectPalaceControl:showWindowNPC(args)
end
if nextFunc then
local func=function()
nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullSectPalaceControl:showMyWindowEx(tabType,nextFunc)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eZongMen)then
return false
end
local bdData=UISectPalaceController:getBuildData()
UIFullSectPalaceControl:showMyWindow(tabType,{entityID=bdData.entityId},nextFunc)
return true
end

function UIFullSectPalaceControl:showMyWindowByBuild(args,nextFunc)
local tabType=FULL_TAB_TYPE.eSectPalaceInfo
local params
if args.args~=nil then
params=args.args
end
if params~=nil and params.tabType~=nil then
tabType=params.tabType
else
local reddot,state=UISectPalaceModel:checkReddot()
local reddot=UISectPalaceModel:checkReddot()
if reddot then
if state==1 then
tabType=FULL_TAB_TYPE.eSectPalacePost
elseif state==2 then
tabType=FULL_TAB_TYPE.eGuildOrder
elseif state==3 then
tabType=FULL_TAB_TYPE.eSectPalaceInfo
end
end
end
UIFullSectPalaceControl:showMyWindow(tabType,{entityID=args.data.entityId,params=params},nextFunc)
end

function UIFullSectPalaceControl:showWindowGuildOrder(argstable)
local tabType=FULL_TAB_TYPE.eGuildOrder
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGuildOrderWin'},
viewArgs={['UIGuildOrderWin']=argstable},
}
self:showUI(args)
end


function UIFullSectPalaceControl:showWindowPost(argstable)
local tabType=FULL_TAB_TYPE.eSectPalacePost
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UISectPalacePostWin'},
viewArgs={['UISectPalacePostWin']=argstable},
}
self:showUI(args)
end

function UIFullSectPalaceControl:showWindowInfo(argstable)
local tabType=FULL_TAB_TYPE.eSectPalaceInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UISectPalaceInfoWin'},
viewArgs={['UISectPalaceInfoWin']=argstable},
}
self:showUI(args)
end

function UIFullSectPalaceControl:showWindowNPC(argstable)
local tabType=FULL_TAB_TYPE.eNPC
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UINPCSelectWin'},
viewArgs={['UINPCSelectWin']=argstable},
}
self:showUI(args)
end

function UIFullSectPalaceControl:initSendPro1()

end

function UIFullSectPalaceControl:initSendPro2()

end

function UIFullSectPalaceControl:initSendPro3()

end

function UIFullSectPalaceControl:initSendPro4()

end

function UIFullSectPalaceControl:showSectPalacePostInfo(postType,dis_guid,check)
if not UIDiscipleModel.checkDisciplePostOpen(postType,true)then
return
end
if check~=false then
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eZongMen)then
return
end
end
UIManager:showWindow('UISectPalacePostInfoWin',{postType=postType,dis_guid=dis_guid})
end
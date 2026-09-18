







UIFullDiscipleMainControl=gameState.addListener(fullScreenUI.create())

function UIFullDiscipleMainControl:onAppStart()
local function _showWindowInfo(...)self:showWindowInfo(...)end
local function _showWindowAttr(...)self:showWindowAttr(...)end
local function _showWindowEquip(...)self:showWindowEquip(...)end
local function _showWindowSkill(...)self:showWindowSkill(...)end
local function _showWindowTianMing(...)self:showWindowTianMing(...)end
local function _showWindowLingGen(...)self:showWindowLingGen(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end
local function _initSendPro4(...)self:initSendPro4(...)end
local function _initSendPro5(...)self:initSendPro5(...)end
local function _initSendPro6(...)self:initSendPro6(...)end

local function _checkTianMingOpen(attach)return self:check_showWindowTianMing(attach,false)end
local function _checkLingGenOpen(attach)return self:check_showWindowLingGen(attach,false)end
local function _checkLinggenGray(attach)return self:check_GrayLingGen(attach,false)end

local function _checkClick(attach)return self:check_ClickLingGen(attach,false)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eDiscipleInfo,callback=_showWindowInfo,sendCallback=_initSendPro1,
reddotType=REDDIT_SUB_TYPE.sDiscipleInfo},

{tabType=FULL_TAB_TYPE.eDiscipleAttr,callback=_showWindowAttr,sendCallback=_initSendPro2},

{tabType=FULL_TAB_TYPE.eDiscipleEquip,callback=_showWindowEquip,sendCallback=_initSendPro3,
reddotType=REDDIT_SUB_TYPE.sDiscipleInfo_Equip},

{tabType=FULL_TAB_TYPE.eDiscipleSkill,callback=_showWindowSkill,sendCallback=_initSendPro4,
reddotType=REDDIT_SUB_TYPE.sDiscipleInfo_Skill},

{tabType=FULL_TAB_TYPE.eDiscipleTianMing,callback=_showWindowTianMing,checkOpen=_checkTianMingOpen,
reddotType=REDDIT_SUB_TYPE.sDiscipleTianMing,sendCallback=_initSendPro5},

{tabType=FULL_TAB_TYPE.eDiscipleLingGen,callback=_showWindowLingGen,checkOpen=_checkLingGenOpen,checkGray=_checkLinggenGray,
clickCond=_checkClick,reddotType=REDDIT_SUB_TYPE.sDiscipleLingGen,sendCallback=_initSendPro6},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eDiscipleMain,
skinType=fullScreenSkinType.eSkin3,
attachName={'dis_guid','showPage'},
}
self:initUI(args)
end

function UIFullDiscipleMainControl:myShowWindow(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eDiscipleInfo
if tabType==FULL_TAB_TYPE.eDiscipleInfo then
self:showWindowInfo(argstable)
elseif tabType==FULL_TAB_TYPE.eDiscipleAttr then
self:showWindowAttr(argstable)
elseif tabType==FULL_TAB_TYPE.eDiscipleEquip then
self:showWindowEquip(argstable)
elseif tabType==FULL_TAB_TYPE.eDiscipleSkill then
self:showWindowSkill(argstable)
elseif tabType==FULL_TAB_TYPE.eDiscipleTianMing then
local attach={}
self:copyAttach(attach,argstable)
if not self:check_showWindowTianMing(attach,true)then
return
end
self:showWindowTianMing(argstable)
elseif tabType==FULL_TAB_TYPE.eDiscipleLingGen then
self:showWindowLingGen(argstable)
end
end

function UIFullDiscipleMainControl:showWindowInfo(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleInfo
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end


function UIFullDiscipleMainControl:showWindowAttr(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleAttr
argstable.showPage=self:getTabIdx(tabType)
argstable.tabType=tabType
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleMainControl:showWindowEquip(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleEquip
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleMainControl:showWindowSkill(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleSkill
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleMainControl:check_showWindowTianMing(attach,isWarning)
local netData=UIDiscipleModel:getDiscipleData(attach.dis_guid)
return UIDiscipleModel:checkOponTianMing(netData)
end

function UIFullDiscipleMainControl:check_showWindowLingGen(attach,isWarning)
local netData=UIDiscipleModel:getDiscipleData(attach.dis_guid)
if UIDiscipleModel:isShuWuDisciple(netData.id)then
return false
end
return true
end

function UIFullDiscipleMainControl:check_GrayLingGen(attach,isWarning)
return not systemModel.isOpen(SYSTEM_DEFINE.eSpiritRootStrengthen)
end

function UIFullDiscipleMainControl:check_ClickLingGen(attach,isWarning)
if systemModel.isOpen(SYSTEM_DEFINE.eSpiritRootStrengthen)then
return true
else
UIManager.info("灵根强化未开启")
local showdata=
{
type='UIDialouge',
title='提示',
content='通关五行殿20层后解锁灵根强化，\n是否前往五行殿？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
if UIFullWuXingDianControl:checkEnter(true)then
jumpManager:jump({
id=JUMP_TYPE.eWuXingDian,
})
end
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()

return false
end
end

function UIFullDiscipleMainControl:showWindowTianMing(argstable)
local tabType=FULL_TAB_TYPE.eDiscipleTianMing
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleMainControl:showWindowLingGen(argstable)
if not self:check_ClickLingGen(argstable,true)then return true end

local tabType=FULL_TAB_TYPE.eDiscipleLingGen
argstable.showPage=self:getTabIdx(tabType)
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIDiscipleMainWin'},
viewArgs={['UIDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleMainControl:initSendPro1()

end

function UIFullDiscipleMainControl:initSendPro2()

end

function UIFullDiscipleMainControl:initSendPro3()

end

function UIFullDiscipleMainControl:initSendPro4()

end

function UIFullDiscipleMainControl:initSendPro5()

end

function UIFullDiscipleMainControl:initSendPro6()

end


function UIFullDiscipleMainControl:checkLinkRoadToOpenBuilding(sfId,ubdId,param)
if self.timer then
self.timer:cancel()
end

self.timer=timer.new()

local func=function()
local bdData=zongmenModel:getBuildingData(ubdId)



self:stopTimer()


if not isometricMapSystem:checkBuildState(sfId,bdData)then

local args=param or{}
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eShouLan1 or buildType==SLG_SYSTEM_TYPE.eShouLan2 then


args.isOpenFeedingWin=true
end

isometricMapSystem:openBuildingWin(bdData,args)
end

end

self.timer:start(0.2,func)
func()
end

function UIFullDiscipleMainControl:stopTimer()
if self.timer then
self.timer:cancel()
end
self.timer=nil
end

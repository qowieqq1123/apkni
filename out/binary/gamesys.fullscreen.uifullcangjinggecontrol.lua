







UIFullCangJingGeControl=gameState.addListener(fullScreenUI.create())

local enterList_lookup={
{
fullType=FULL_TYPE.eCangJingGe,
clickFunc=function(args)
UIFullCangJingGeControl:showMyWindowByBuild(args,nil)
end,
reddotFunc=function()
return UIGongFaModel:chackAllGongFaState()>0 or UIGongFaModel:checkGongFaRecycleReddot()
end,
abName="ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",
assetName="button_gongfa_1",
},
{
fullType=FULL_TYPE.eCangJingGeXinFa,
clickFunc=function(args)
UIFullCangJingGeXinFaControl:showXinFaWindow(nil,args)
end,
reddotFunc=function()
return UIDiscipleModel:checkXinFaActiveReddot()or UIDiscipleModel:checkXinFaBranchActiveReddot()
end,
unlockFunc=function()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eXinFaXiuLian)
return isOpenSys
end,
abName="ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",
assetName="button_xinfa_1",
},
}

function UIFullCangJingGeControl:onAppStart()
local function _showWindowSelect(...)self:showWindowSelect(...)end
local function _showWindowLearn(...)self:showWindowLearn(...)end
local function _showWindowInfo(...)self:showWindowInfo(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end

local function _showWindowLearnCheck(...)return self:showWindowLearnCheck(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eGongFaSelect,callback=_showWindowSelect,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eGongFaLearn,callback=_showWindowLearn,sendCallback=_initSendPro2,clickCond=_showWindowLearnCheck},

{tabType=FULL_TAB_TYPE.eGongFaInfo,callback=_showWindowInfo,sendCallback=_initSendPro3},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eCangJingGe,
skinType=fullScreenSkinType.eSkin1,
attachName={'showPage','entityID'},
}
self:initUI(args)
end

function UIFullCangJingGeControl:showEnterSelectWindow(argstable)

local args=argstable.args or{}
if args.isjump then
return self:showMyWindowByBuild(argstable,nil)
else
local enterSelectList={}
local cfgs={}
for _,v in ipairs(enterList_lookup)do
local enterCfg=v
local unlockFunc=enterCfg.unlockFunc
local isUnlock=true
if unlockFunc then
isUnlock=unlockFunc()
end
if isUnlock then
cfgs[#cfgs+1]=enterCfg
end
end
enterSelectList.args=argstable
enterSelectList.cfgs=cfgs
if#cfgs>1 then

self:showWindow('UICommonEnterDisplayWin',enterSelectList)
else
local clickFunc=cfgs[1].clickFunc
clickFunc(argstable)
end
end
end

function UIFullCangJingGeControl:showMyWindow(tabType,args,nextFunc)
if tabType==FULL_TAB_TYPE.eGongFaSelect then
UIFullCangJingGeControl:showWindowSelect(args)
elseif tabType==FULL_TAB_TYPE.eGongFaLearn then
UIFullCangJingGeControl:showWindowLearn(args)
elseif tabType==FULL_TAB_TYPE.eGongFaInfo then
UIFullCangJingGeControl:showWindowInfo(args)
end
if nextFunc then
local func=function()
nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIFullCangJingGeControl:showMyWindowEx(tabType,dis_guid,nextFunc)
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eCangJingGe)then
return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)
UIFullCangJingGeControl:showMyWindow(tabType,{dis_guid=dis_guid,entityID=data[1].entityId},nextFunc)
return true
end

function UIFullCangJingGeControl:showMyWindowByBuild(args,nextFunc)
local tabType=FULL_TAB_TYPE.eGongFaSelect
if args.args~=nil and args.args.tabType~=nil then
tabType=args.args.tabType
end
local params=args.args or{}
params.entityID=args.data.entityId
UIFullCangJingGeControl:showMyWindow(tabType,params,nextFunc)
end

function UIFullCangJingGeControl:showWindowSelect(argstable)
local tabType=FULL_TAB_TYPE.eGongFaSelect
argstable.showPage=self:getTabIdx(tabType)

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGongFaMainWin'},
viewArgs={['UIGongFaMainWin']=argstable},
}
self:showUI(args)
end

function UIFullCangJingGeControl:showWindowLearn(argstable)
if argstable.clickMenu~=true then
if not self:showWindowLearnCheck()then
return
end
end
local tabType=FULL_TAB_TYPE.eGongFaLearn
argstable.showPage=self:getTabIdx(tabType)

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGongFaMainWin'},
viewArgs={['UIGongFaMainWin']=argstable},
}
self:showUI(args)
end
function UIFullCangJingGeControl:showWindowLearnCheck(iswarning)
local c=UIDiscipleModel:checkDiscipleCount()
if c<=0 then
if iswarning==nil or iswarning==true then
UIManager.error('宗门尚无弟子')
end
return false
end
return true
end

function UIFullCangJingGeControl:showWindowInfo(argstable)
local tabType=FULL_TAB_TYPE.eGongFaInfo
argstable.showPage=self:getTabIdx(tabType)

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGongFaMainWin'},
viewArgs={['UIGongFaMainWin']=argstable},
}
self:showUI(args)
end

function UIFullCangJingGeControl:initSendPro1()

end

function UIFullCangJingGeControl:initSendPro2()

end

function UIFullCangJingGeControl:initSendPro3()

end
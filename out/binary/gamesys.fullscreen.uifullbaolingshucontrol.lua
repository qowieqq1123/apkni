







UIFullBaoLingShuControl=gameState.addListener(fullScreenUI.create())
local enterList_lookup={
[FULL_TAB_TYPE.eBaoLingShu]={
jump={id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eBaoLingShu,tabType=FULL_TAB_TYPE.eBaoLingShu}},
tabType=FULL_TAB_TYPE.eBaoLingShu,
reddotFunc=function()
return baoLingShuModel:checkBaolingshuEnterReddot()
end,
abName="ui/windows/xunbaoshilian/xbslsprite_pak.ab",
assetName="button_baolingshu_1",
},
[FULL_TAB_TYPE.eQiYuanShu]={
jump={id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eBaoLingShu,tabType=FULL_TAB_TYPE.eQiYuanShu}},
tabType=FULL_TAB_TYPE.eQiYuanShu,
reddotFunc=function()
return qiYuanShuModel:checkQiYuanShuEnterReddot()
end,
unlockFunc=function()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eWishTree)
return isOpenSys
end,
abName="ui/windows/xunbaoshilian/xbslsprite_pak.ab",
assetName="button_qiyuanshu_1",
typo=2,
},
[FULL_TAB_TYPE.eXunBaoShiLian]={
jump={id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eBaoLingShu,tabType=FULL_TAB_TYPE.eXunBaoShiLian}},
tabType=FULL_TAB_TYPE.eXunBaoShiLian,
unlockFunc=function()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eTreasureTrainning)
return isOpenSys
end,
reddotFunc=function()
return xunBaoShiLianModel:checkXBSLEnterReddot()
end,
abName="ui/windows/xunbaoshilian/xbslsprite_pak.ab",
assetName="button_xunbaoshilian_1",
typo=2,
},
}
function UIFullBaoLingShuControl:onAppStart()
local function _showBaoLingShuWindow(...)self:showBaoLingShuWindow(...)end
local function _showQiYuanShuWindow(...)self:showQiYuanShuWindow(...)end
local function _showXunBaoShiLianWindow(...)self:showXunBaoShiLianWindow(...)end

local function _initSendBaoLingShuPro(...)self:initSendBaoLingShuPro(...)end
local function _initSendXunBaoShiLianPro(...)self:initSendXunBaoShiLianPro(...)end
local function _initSendQiYuanShuPro(...)self:initSendQiYuanShuPro(...)end
local menulist=
{
{tabType=FULL_TAB_TYPE.eBaoLingShu,callback=_showBaoLingShuWindow,sendCallback=_initSendBaoLingShuPro,reddotType=REDDIT_SUB_TYPE.sBaoLingShu},
{tabType=FULL_TAB_TYPE.eQiYuanShu,callback=_showQiYuanShuWindow,sendCallback=_initSendQiYuanShuPro,reddotType=REDDIT_SUB_TYPE.sQiYuanShu,
hideFunc=function()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eWishTree)
return not isOpenSys
end,},
{tabType=FULL_TAB_TYPE.eXunBaoShiLian,callback=_showXunBaoShiLianWindow,sendCallback=_initSendXunBaoShiLianPro,reddotType=REDDIT_SUB_TYPE.sXunBaoShiLian,
hideFunc=function()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eTreasureTrainning)
return not isOpenSys
end,},
}
local args={
stage=true,
skinType=fullScreenSkinType.eSkin23,
menulist=menulist,
fullType=FULL_TYPE.eBaoLingShu,
isShowUnActiveWin=true,
}
self:initUI(args)
end

function UIFullBaoLingShuControl:showBaoLingShuWindow(argstable)
local func=function(argstable)
local isLoaded=argstable.isLoaded
if isLoaded then
if(not argstable.args or not argstable.args.needOpenPickUpPage)and UIManager:isActive('UICommonActForeGroundTwoWin')then

UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
UIManager:closeWindow('UICommonPageWin')
else
UIManager.info('当前已经在宝灵树了!')
end
return
end
UIFullBaoLingShuControl:showBaoLingShuWindowEx(argstable)
end

local stageId=101
if baoLingShuController.fightStage and baoLingShuController.fightStage.stageID~=stageId then


if baoLingShuController.fightStage.stageID==106 then

UIManager:invokeUIMethod("UIQiYuanShuWin","closeStage")
end


end

fightStage:create(stageId,func,argstable,nil,nil,nil,function()
baoLingShuController.fightStage=nil
end)
end

function UIFullBaoLingShuControl:showBaoLingShuWindowEx(argstable)
local tabType=FULL_TAB_TYPE.eBaoLingShu
local args={
tabType=tabType,
showBg=false,

showTopMask=true,
viewNames={'UIBaoLingShuWin'},
viewArgs={['UIBaoLingShuWin']=argstable},
}
baoLingShuController.fightStage=argstable.fightStage
self:showUI(args)
end

function UIFullBaoLingShuControl:showXunBaoShiLianWindow(argstable)
self:closeFightStage()
local tabType=FULL_TAB_TYPE.eXunBaoShiLian
local args={
tabType=tabType,
showTopMask=true,
viewNames={'UIXBSL_mainWin'},
viewArgs={['UIXBSL_mainWin']=argstable},
}
self:showUI(args)
end

function UIFullBaoLingShuControl:showQiYuanShuWindow(argstable)
local func=function(argstable)
local isLoaded=argstable.isLoaded

if isLoaded then
if(not argstable.args or not argstable.args.needOpenPickUpPage)and UIManager:isActive('UICommonActForeGroundWin')then

UIFullBaoLingShuControl:closeQiYuanShuPickUpWindow()
UIManager:closeWindow('UICommonPageWin')
else
UIManager.info('当前已经在祈愿树了!')
end
return
end
UIFullBaoLingShuControl:showQiYuanShuWindowEx(argstable)
end

local stageId=106
if baoLingShuController.fightStage and baoLingShuController.fightStage.stageID~=stageId then


if baoLingShuController.fightStage.stageID==101 then

UIManager:invokeUIMethod("UIBaoLingShuWin","closeStage")
end

end

fightStage:create(stageId,func,argstable,nil,nil,nil,function()
baoLingShuController.fightStage=nil
end)
end

function UIFullBaoLingShuControl:showQiYuanShuWindowEx(argstable)
local tabType=FULL_TAB_TYPE.eQiYuanShu
local args={
tabType=tabType,
showBg=false,
showTopMask=true,
viewNames={'UIQiYuanShuWin'},
viewArgs={['UIQiYuanShuWin']=argstable},
}
baoLingShuController.fightStage=argstable.fightStage
self:showUI(args)
end

function UIFullBaoLingShuControl:showMainWindow(argstable)

local args=argstable.args or{}
if args.isjump then
local tabType=args.tabType
return self:showWindowByTabType(argstable,tabType)
else
local enterSelectList={}
local menuList=self.subMenu
local cfgs={}
for _,v in ipairs(menuList)do
local tabType=v.tabType
if enterList_lookup[tabType]then
local enterCfg=enterList_lookup[tabType]
local unlockFunc=enterCfg.unlockFunc
local isUnlock=true
if unlockFunc then
isUnlock=unlockFunc()
end

if isUnlock then
cfgs[#cfgs+1]=enterCfg
end
end
end
enterSelectList.args=argstable
enterSelectList.cfgs=cfgs
if#cfgs>1 then

self:showWindow('UICommonEnterDisplayWin',enterSelectList)
else
local tabType=cfgs[1].tabType
return self:showWindowByTabType(argstable,tabType)
end




end
end

function UIFullBaoLingShuControl:showWindowByTabType(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eBaoLingShu
if not fullScreenModel.checkTabEnoughCND(tabType,true)then
return false
end
if tabType==FULL_TAB_TYPE.eBaoLingShu then
return self:showBaoLingShuWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eQiYuanShu then
return self:showQiYuanShuWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eXunBaoShiLian then
return self:showXunBaoShiLianWindow(argstable)
end
end

function UIFullBaoLingShuControl:showXBSL_targetWindow(argstable)
self:showWindow('UIXBSL_targetWin')
end

function UIFullBaoLingShuControl:showXBSL_xuanShangWindow(argstable)
self:showWindow('UIXBSL_xuanShangWin')
end

function UIFullBaoLingShuControl:initSendBaoLingShuPro()

end

function UIFullBaoLingShuControl:initSendQiYuanShuPro()

end

function UIFullBaoLingShuControl:showBaoLingShuPickUpWindow(argstable)
local pageCfg
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
local openPageIndex

if isInPickUpNow then
pageCfg={
[1]={
win='UIBaoLingShuPickUp_TargetWin',
tabType=FULL_TAB_TYPE.eBLS_XuYuanTarget,
reddotType=REDDIT_SUB_TYPE.sBLSPickUpTarget,
},
[2]={
win='UIBaoLingShuPickUp_LiBaoWin',
tabType=FULL_TAB_TYPE.eBLS_XuYuanLiBao,
reddotType=REDDIT_SUB_TYPE.sBLSPickUpLiBao,
},
[3]={
win='UIBaoLingShuPickUp_ShopWin',
tabType=FULL_TAB_TYPE.eBLS_XuYuanShop,
reddotType=REDDIT_SUB_TYPE.sBLSPickUpShop,
},
}
openPageIndex=3
else
pageCfg={
[1]={
win='UIBaoLingShuPickUp_ShopWin',
tabType=FULL_TAB_TYPE.eBLS_XuYuanShop,
reddotType=REDDIT_SUB_TYPE.sBLSPickUpShop,
},
}
end
if argstable and argstable.openPageIndex then
openPageIndex=argstable.openPageIndex
end
local isJump=argstable and argstable.isJump
UIFullCommonControl:showCommonActTwoWindow_notFull(pageCfg,openPageIndex,isJump)
end

function UIFullBaoLingShuControl:closeBaoLingShuPickUpWindow()
UIManager:invokeUIMethod("UICommonActForeGroundTwoWin","onBtnClose")
end

function UIFullBaoLingShuControl:showQiYuanShuPickUpWindow(argstable)
local pageCfg
local openPageIndex
pageCfg={
[1]={
win='UIQiYuanShu_SelectWin',
tabType=FULL_TAB_TYPE.eQYS_XingYuanGuBao,
checkOpen=function()
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
return isInQiYuanNow
end
},
[2]={
win='UIQiYuanShu_ShopWin',
tabType=FULL_TAB_TYPE.eQYS_QiYuanShop,
reddotType=REDDIT_SUB_TYPE.sQiYuanShop,
},
}

local defaultOpenTabType=FULL_TAB_TYPE.eQYS_QiYuanShop
local openTabType
if argstable and argstable.openTabType then
openTabType=argstable.openTabType
else
openTabType=defaultOpenTabType
end
openPageIndex=2


local activePageList={}
for i,v in ipairs(pageCfg)do
local tabType=v.tabType
if fullScreenModel.isTabActive(tabType,v.checkOpen)then
local index=#activePageList+1
activePageList[index]=v
if openTabType and openTabType==tabType then
openPageIndex=index
end
end
end

if argstable and argstable.openPageIndex then
openPageIndex=argstable.openPageIndex
end
local isJump=argstable and argstable.isJump
UIFullCommonControl:showCommonActTwoWindow_notFull(activePageList,openPageIndex,isJump)
end

function UIFullBaoLingShuControl:closeQiYuanShuPickUpWindow()
UIManager:invokeUIMethod("UICommonActForeGroundTwoWin","onBtnClose")
end


function UIFullBaoLingShuControl:closeFightStage()
if baoLingShuController.fightStage then

if baoLingShuController.fightStage.stageID==101 then

UIManager:invokeUIMethod("UIBaoLingShuWin","closeStage",true)
elseif baoLingShuController.fightStage.stageID==106 then

UIManager:invokeUIMethod("UIQiYuanShuWin","closeStage",true)
end

if baoLingShuController.fightStage then

baoLingShuController.fightStage:close()
end
end
end









UIFullCommonControl=gameState.addListener(fullScreenUI.create())

function UIFullCommonControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eCommon,
skinType=fullScreenSkinType.eSkin5,
attachName={},
}
self:initUI(args)
end


function UIFullCommonControl:showCommonWindow(winName,params,showBlur,id,showBg,skinType,showTopMask)
if showBlur==nil then showBlur=false end
if showBg==nil then showBg=false end
if skinType==nil then skinType=fullScreenSkinType.eSkin5 end
local isFull=params.isFull
if isFull then
local viewNames
local viewArgs={}
if type(winName)=='table'then
viewNames=winName
for i,v in ipairs(viewNames)do
viewArgs[v]=params or{}
end
else
viewNames={winName}
viewArgs[winName]=params or{}
end
local args=
{
skinType=skinType,
showBg=showBg,
showTopMask=showTopMask,
subFullType=fullScreenUI.getSubFullType(winName,id),
showBlur=showBlur,
moneyWinType=params.moneyWinType,
moneyArgs=params.moneytypes,
viewNames=viewNames,
viewArgs=viewArgs,
}
self:showUI(args)
else
UIManager:showWindow(winName,params)
end
end



function UIFullCommonControl:showDuJieWindow(goFunc,argstable,dis_guid,isAfterTianXian)
self:getDiscipleBackArgs(dis_guid)
local func=function()
self:showWindow_BackDiscipleMainEx(goFunc)
end

local stageId=isAfterTianXian and 890017 or 100
fightStage:create(stageId,func,argstable)
end

function UIFullCommonControl:showDuJieWindowEx(params)
params=params or{}
params.isFull=true
UIFullCommonControl:showCommonWindow('UIDiscipleJingJieBrokeWin',params)
end

function UIFullCommonControl:showDuJieWindowEx_AfterTianXian(params)
params=params or{}
params.isFull=true
UIFullCommonControl:showCommonWindow('UIDiscipleJingJieBrokeWin_afterTX',params)
end



local dzbackargs=nil
function UIFullCommonControl:getDiscipleBackArgs(dis_guid)
dzbackargs=nil
if dis_guid==nil then return end
local win=UIManager:findActiveWindow('UIDiscipleMainWin')
if win==nil then return end

local dislist=win:getDiscipleList()
local showPage=win:getShowPage()
local backfunc=fullScreenUI.getNextActiveUICallback()
dzbackargs={disguid=dis_guid,dislist=dislist,backfunc=backfunc,showPage=showPage}
end
function UIFullCommonControl:showWindow_BackDiscipleMain(goFunc,dis_guid)
self:getDiscipleBackArgs(dis_guid)
self:showWindow_BackDiscipleMainEx(goFunc)
end
function UIFullCommonControl:showWindow_BackDiscipleMainEx(goFunc)
if goFunc then
local flag=goFunc()
local check=flag==nil or flag==true
if check and dzbackargs~=nil then
local func2=function()
if dzbackargs.dislist~=nil then
local showPage=dzbackargs.showPage or 1
local tabType=UIFullDiscipleMainControl:getTabType(showPage)
UIFullDiscipleMainControl:myShowWindow({dis_guid=dzbackargs.disguid,disciplelist=dzbackargs.dislist},tabType)

if dzbackargs.backfunc~=nil then
local func3=function()
local func4=function(args)
UIFullDiscipleSelectControl:showDiscipleSelectWindow(args)
end
fullScreenUI.setNextActiveUICallback(func4,dzbackargs.backfunc[2])
end
timeEventController.delayDo(0.1,func3)
end
end
end
fullScreenUI.setNextActiveUICallback(func2)
end
end
end



function UIFullCommonControl:jumpDiscipleMain(dis_guid,tabType,closeCallback,subArgs)
tabType=tabType or FULL_TAB_TYPE.eDiscipleInfo
UIFullDiscipleMainControl:myShowWindow({dis_guid=dis_guid,subArgs=subArgs},tabType)
local func=function()
UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
if closeCallback then
fullScreenUI.setNextActiveUICallback(closeCallback)
else
fullScreenUI.setNextActiveUICallback(func)
end
return true
end



function UIFullCommonControl:jumpLingShouMain(ls_guid,tabType,closeCallback,subArgs)
tabType=tabType or FULL_TAB_TYPE.eLingShouInfo
UIFullLingShouMainControl:myShowWindow({ls_guid=ls_guid,subArgs=subArgs},tabType)
local func=function()
UIFullDiscipleSelectControl:showLingShouSelectWindow()
end
if closeCallback then
fullScreenUI.setNextActiveUICallback(closeCallback)
else
fullScreenUI.setNextActiveUICallback(func)
end
return true
end



local lsbackargs=nil
function UIFullCommonControl:getLingShouBackArgs(ls_guid)
lsbackargs=nil
if ls_guid==nil then return end
local win=UIManager:findActiveWindow('UILingShouMainWin')
if win==nil then return end

local lslist=win:getLingShouList()
local showPage=win:getShowPage()
local backfunc=fullScreenUI.getNextActiveUICallback()
lsbackargs={ls_guid=ls_guid,lslist=lslist,backfunc=backfunc,showPage=showPage}
end

function UIFullCommonControl:showWindow_BackLingShouMain(goFunc,ls_guid)
self:getLingShouBackArgs(ls_guid)
self:showWindow_BackLingShouMainEx(goFunc)
end

function UIFullCommonControl:showWindow_BackLingShouMainEx(goFunc)
if goFunc then
local flag=goFunc()
local check=flag==nil or flag==true
if check and lsbackargs~=nil then
local func2=function()
if lsbackargs.lslist~=nil then
local showPage=lsbackargs.showPage or 1
local tabType=UIFullLingShouMainControl:getTabType(showPage)
UIFullLingShouMainControl:myShowWindow({ls_guid=lsbackargs.ls_guid,lslist=lsbackargs.lslist},tabType)

if lsbackargs.backfunc~=nil then
local func3=function()
local func4=function(args)
UIFullDiscipleSelectControl:showLingShouSelectWindow(args)
end
fullScreenUI.setNextActiveUICallback(func4,lsbackargs.backfunc[2])
end
timeEventController.delayDo(0.1,func3)
end
end
end
fullScreenUI.setNextActiveUICallback(func2)
end
end
end



function UIFullCommonControl:showCommonActWindow_notFull(pageCfg,openPageIndex,isJump)
local panelparams={}
panelparams.isFull=false
panelparams.pageCfg=pageCfg
panelparams.pageIndex=openPageIndex or 1
panelparams.isJump=isJump
UIFullCommonControl:showCommonWindow("UICommonActForeGroundWin",panelparams)
end


function UIFullCommonControl:showCommonActTwoWindow_notFull(pageCfg,openPageIndex,isJump)
local panelparams={}
panelparams.isFull=false
panelparams.pageCfg=pageCfg
panelparams.pageIndex=openPageIndex or 1
panelparams.isJump=isJump
UIFullCommonControl:showCommonWindow("UICommonActForeGroundTwoWin",panelparams)
end


function UIFullCommonControl:openZhiShengItemUseWin(args)
local disciplesList=discipleLookup:getSortDiscipleList()
if#disciplesList<=0 then
UIManager.info('当前没有弟子')
return false
end
local itemid=args.itemid
if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam then



local limit=funcparam.limit
local isUse=false
for k,v in ipairs(disciplesList)do
local netdata=v.netData

local jingjielv=netdata.net.jingjielv
if limit[1]<=jingjielv and jingjielv<=limit[2]then
isUse=true
break
end
end
if isUse then
local func=function()

args.isFull=true
UIFullCommonControl:showCommonWindow('UIZhiShengItemWin',args)
end
fightStage:create(100,func,args)
end
end
else
return false,'参数不正确'
end
return true
end










fullScreenUI={}


fullScreenSkinType=
{
eSkin1=1,
eSkin2=2,
eSkin3=3,
eSkin4=4,
eSkin5=5,
eSkin6=6,
eSkin7=7,
eSkin8=8,
eSkin9=9,
eSkin10=10,
eSkin11=11,
eSkin12=12,
eSkin13=13,
eSkin14=14,
eSkin15=15,
eSkin16=16,
eSkin17=17,
eSkin18=18,
eSkin19=19,
eSkin20=20,
eSkin21=21,
eSkin22=22,
eSkin23=23,
eSkin24=24,
eSkin25=25,
eSkin26=26,
eSkin27=27,
eSkin28=28,
eSkin29=29,
}


fullTopMoneyType=
{
eSkin1=1,
eSkin2=2,
}


local fullScreenSkinConfig={
[fullScreenSkinType.eSkin1]={

foreGroundWin='UIForeGroundWin',
bottomMaskWin='UIBottomMaskWin',
topMaskWin='UITopMaskWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin2]={

foreGroundWin='UIForeGroundWin',
bottomMaskWin='UIBottomMaskTwoWin',
},
[fullScreenSkinType.eSkin3]={
bottomMaskWin='UIBottomMaskThreeWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin4]={
bottomMaskWin='UIShopBottomWin',
foreGroundWin='UIForeGroundWin',
},
[fullScreenSkinType.eSkin5]={
bottomMaskWin='UIBottomMaskEmptyWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin6]={
bottomMaskWin='UIBottomMaskFourthWin',
},
[fullScreenSkinType.eSkin7]={
bottomMaskWin='UIBottomMaskFifthWin',
},
[fullScreenSkinType.eSkin8]={
bottomMaskWin='UIBottomMaskSixthWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin9]={
bottomMaskWin='UIBottomMaskSeventhWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin10]={
bottomMaskWin='UIBottomMaskEighthWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin11]={
bottomMaskWin='UIBottomMaskEmpty_blackWin',
foreGroundWin='UIForeGroundTwoWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin12]={
bottomMaskWin='UIBottomMaskWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin13]={
bottomMaskWin='UIBottomMaskHJWin',
fadeInData={0.15,0.5},
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin14]={
bottomMaskWin='UIBottomMaskEmptyWin',
foreGroundWin='UIForeGroundTwoWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin15]={
bottomMaskWin='UIBottomMaskEmpty_black2Win',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin16]={
bottomMaskWin='UIXFWDBottomWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin17]={
bottomMaskWin="UIXTCJForeGroundWin",
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin18]={
foreGroundWin="UIWanBaoXunBaoDui_MenuWin",
bottomMaskWin="UIBottomMaskEmptyWin",
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin19]={
bottomMaskWin="UIBottomMaskEmpty_blackYYHYWin",
},
[fullScreenSkinType.eSkin20]={


bottomMaskWin='UIBottomMaskYYHYWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin21]={
bottomMaskWin='UIBottomMaskNinethWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin22]={
bottomMaskWin='UIBottomMaskEmpty_blackWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin23]={
bottomMaskWin='UIBottomMaskEmpty_blackWin',
foreGroundWin='UIForeGroundThreeWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin24]={

foreGroundWin='UIXianJieForeGroundWin',
bottomMaskWin='UIXianJieBottomMaskWin',
topMaskWin='UITopMaskWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin25]={
bottomMaskWin='UIWDCQBottomWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin26]={
bottomMaskWin='UIXianJieBottomMaskWin',
foreGroundWin='UIXianJieForeGroundWin',
topMaskWin='UITopMaskWin',
fadeInData={0.15,0.5},
},
[fullScreenSkinType.eSkin27]={
bottomMaskWin='UIBottomMaskEmptyExWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin28]={
bottomMaskWin='UIBlueDiamondBottomMaskWin',
topMaskWin='UITopMaskWin',
},
[fullScreenSkinType.eSkin29]={
foreGroundWin='UIForeGroundShouLanWin',
bottomMaskWin='UIBottomMaskShouLanWin',
topMaskWin='UITopMaskWin',
},
}



local fullTopMoneyConfig=
{
[fullTopMoneyType.eSkin1]="UITopMoneyWin",
[fullTopMoneyType.eSkin2]="UITopMoneyWin2",
}

function fullScreenUI.create(t)
t=t or{}
for k,v in pairs(fullScreenUI)do
t[k]=v
end
return t
end


local _lastLen=20

fullScreenUI.activeUI=nil
fullScreenUI.commonWins={}



function fullScreenUI:showUI(showParam,isJumpBack)
if showParam.tabType then
if not fullScreenModel.isTabOpen(showParam.tabType,true)then
return false
end
end

if showParam.skinType then
self.skinType=showParam.skinType
end


local lastUI=fullScreenUI.activeUI

self:handleParams(showParam)





local isFullChanged=true

if lastUI then
isFullChanged=lastUI.fullType~=self.fullType
end
if isFullChanged then
if(lastUI~=nil and lastUI.fullType==FULL_TYPE.eDiscipleMain)or self.fullType==FULL_TYPE.eDiscipleMain then
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleChangeTab)
end
end







if not isJumpBack and lastUI and lastUI.fullType~=BASE_FULL_TYPE then
fullScreenUI.setBackUI(lastUI,lastUI.showParam)
jumpManager:setNextArgs(self)
end

self.showParam=showParam


fullScreenUI.activeUI=self




self:freshUI(lastUI)

if isFullChanged and lastUI then
lastUI:resetData()
end
baseFullScreenUI:openMain(false)

fullScreenUI.enableSceneSound(false)
sceneAudioModel:setAudioShieldState(true)

return true
end

function fullScreenUI:handleParams(showParam)
showParam=showParam or{}



local fullType=self.fullType




local tabIdxsLookup=self.tabIdxsLookup

local tabTypesLookup=self.tabTypesLookup

local subMenu=self.subMenu

local tabType=showParam.tabType or self.defaultTabType
self.tabType=tabType
if tabType and tabIdxsLookup then
local subIndex=tabIdxsLookup[tabType]
self.subIndex=subIndex
self.showTabTypeList[tabType]=true
end

local activeSubMenu=showParam.activeSubMenu
if activeSubMenu==nil and subMenu then
local attach_={}
self:copyAttachEx(attach_,showParam)
local oldActiveSubMenu=self.activeSubMenu
self.activeSubMenu=fullScreenModel.getActiveTablist(subMenu,attach_)
self.oldActiveSubMenu=oldActiveSubMenu
for i,v in ipairs(self.activeSubMenu)do
if v.tabType==tabType then
self.activeMenuIndex=i
break
end
end
end


self.subFullType=showParam.subFullType
self.showBg=showParam.showBg==nil and true or showParam.showBg
self.showFg=showParam.showFg==nil and true or showParam.showFg
self.showTopMask=showParam.showTopMask
self.showBlur=self.showBg
if showParam.showBlur~=nil then self.showBlur=showParam.showBlur end
self.blurParams=showParam.blurParams

self.viewNames=showParam.viewNames or{}

self.viewArgs=showParam.viewArgs or{}

self.clickMenu=false
for _,t in pairs(self.viewArgs)do
if t.clickMenu then
self.clickMenu=t.clickMenu
break
end
end

self:handleArgs(showParam)

self.moneyArgs=showParam.moneyArgs

if self.moneyArgs==nil and tabType then
self.moneyArgs=fullScreenModel.getFullTabMoneyByConfig(tabType)
end


if self.replaceTitleName==nil then
local name=self.viewNames[1]
if name~=nil and self.viewArgs[name]then
self.replaceTitleName=self.viewArgs[name].titleNames
end
end
if self.defaultTitleName==nil then
local config=cfgHelper.get1(cfg_fullsystemconfig_get,fullType)
if config~=nil then
self.defaultTitleName=config.name
end
end
end




function fullScreenUI:freshUI(lastUI)
self:closeAllLastWindow(lastUI)

self:showBottomMaskWin(self.showBg,self.clickMenu)

self:showTopMaskWin(self.showTopMask)

self:showMoneyTopWin(self.moneyArgs)

self:showRawMaskWin(self.showBlur,self.blurParams)



self:showForeGroundWin(self.showFg)

local sameSkinType=false
if lastUI~=nil then
sameSkinType=lastUI.skinType==self.skinType
end
local skincfg=fullScreenSkinConfig[self.skinType]
for _,name in ipairs(self.viewNames)do
local argstable=self.viewArgs[name]
if argstable then
if skincfg.fadeInData~=nil and not sameSkinType then
argstable.fadeInData=skincfg.fadeInData
else
argstable.fadeInData=nil
end
end
self:showActiveView(name,argstable)
end
end


function fullScreenUI:closeAllLastWindow(lastUI)
if lastUI==nil then return end
if lastUI==baseFullScreenUI then
baseFullScreenUI:close()
else

local sameUI=lastUI.fullType==self.fullType
local activeNames=table.deepCopy(lastUI.activeNames)
if not sameUI then
for name,flag in pairs(activeNames)do
self:closeLastWindow(name)
end
else
for name,flag in pairs(activeNames)do
self:hideLastWindow(name)
end
end


local activeNames=table.deepCopy(baseFullScreenUI.activeNames)
for name,_ in pairs(activeNames)do
self:closeLastWindow(name)
end

if self.skinType~=lastUI.skinType then
lastUI:showBottomMaskWin(false)

lastUI:showForeGroundWin(false)
end
end
end

function fullScreenUI:closeLastWindow(name)
if name==nil then return false end
for _,viewname in ipairs(self.viewNames)do
if viewname==name then
return false
end
end
self:closeWindow(name)
end

function fullScreenUI:hideLastWindow(name)
if name==nil then return false end
for _,viewname in ipairs(self.viewNames)do
if viewname==name then
return false
end
end
self:hideWindow(name)
end

local _closeUI=function(activeUI,openMain)
if activeUI==nil then return end
local self=activeUI
if self.fullType==nil then return end

self:closeAllWindow()
self:showTopMaskWin(false)
self:showBottomMaskWin(false)
self:showMoneyTopWin(false)
self:showRawMaskWin(false)

self:showForeGroundWin(false)
self:resetData()
if not fullScreenUI.isActiveBaseFull()then
if baseFullScreenUI:isBaseFull()then
fullScreenUI.activeUI=baseFullScreenUI
else
fullScreenUI.activeUI=nil
end
end
if openMain==true or openMain==nil then
baseFullScreenUI:openMain(true)
end

fullScreenUI.enableSceneSound(true)
sceneAudioModel:setAudioShieldState(false)
end



function fullScreenUI:closeUI(openMain,closeBtn)
if closeBtn==nil then closeBtn=false end
local activeUI=self
if activeUI==nil then return false end
if fullScreenUI.activeUI~=activeUI then return false end
if closeBtn==false then
_closeUI(activeUI,openMain)
return true
end

local cbData2=fullScreenUI.nextActiveUICallback2
if cbData2~=nil then
fullScreenUI.clearCallback2()
end
if fullScreenUI.nextActiveUICallback~=nil then
local cb=fullScreenUI.nextActiveUICallback[1]
local args=fullScreenUI.nextActiveUICallback[2]
if cb(args)==false then
_closeUI(activeUI,openMain)
end
fullScreenUI.clearCallback()
else
if not jumpManager:jumpBack(self)then
_closeUI(activeUI,openMain)
end
end
if cbData2~=nil then
local cb=cbData2[1]
local args=cbData2[2]
cb(args)
end
return true
end


function fullScreenUI.closeActiveUI(closeBtn,openMain)
fullScreenUI.closeUI(fullScreenUI.activeUI,openMain,closeBtn)
end

function fullScreenUI.closeCommonUI(activeNames)
local commonWins=table.deepCopy(fullScreenUI.commonWins)
for name,flag in pairs(commonWins)do
if flag then
if not activeNames[name]then
UIManager:hideWindowImp(name)
fullScreenUI.commonWins[name]=false
end
end
end
end



function fullScreenUI.isActiveFull()
if fullScreenUI.activeUI and fullScreenUI.activeUI.fullType and fullScreenUI.activeUI.fullType~=BASE_FULL_TYPE then
return true
end
return false
end

function fullScreenUI.isActiveFullEx(fType,vName)
if fullScreenUI.activeUI and fullScreenUI.activeUI.fullType and fullScreenUI.activeUI.fullType==fType then
if vName~=nil then
if fullScreenUI.activeUI.viewNames[1]==vName then
return true
end
else
return true
end
end
return false
end
function fullScreenUI.isActiveBaseFull()
if fullScreenUI.activeUI and fullScreenUI.activeUI.fullType and fullScreenUI.activeUI.fullType==BASE_FULL_TYPE then
return true
end
return false
end

function fullScreenUI.checkFull(fullScreen)
if fullScreen==nil then return false end
if fullScreenUI.activeUI and fullScreenUI.activeUI.fullType and fullScreenUI.activeUI.fullType==fullScreen.fullType then
return true
end
return false
end

function fullScreenUI:showMoneyTopWin(visible)
local topMoneyWin=fullTopMoneyConfig[self.moneyWinType]
if visible and self.moneyArgs then
UIManager:showWindowImp(topMoneyWin,self.moneyArgs)
fullScreenUI.commonWins[topMoneyWin]=true
else
UIManager:hideWindowImp(topMoneyWin)
fullScreenUI.commonWins[topMoneyWin]=false
end
end

function fullScreenUI:setTitle(title)
local bottomMaskWin=fullScreenSkinConfig[self.skinType].bottomMaskWin
UIManager:invokeUIMethod(bottomMaskWin,'setTitle',title)
end

function fullScreenUI:showRightMenuWin(visible)
local rightMenuWin=fullScreenSkinConfig[self.skinType].rightMenuWin
if visible then
UIManager:showWindowImp(rightMenuWin)
fullScreenUI.commonWins[rightMenuWin]=true
else
UIManager:hideWindowImp(rightMenuWin)
fullScreenUI.commonWins[rightMenuWin]=false
end
end

function fullScreenUI:showForeGroundWin(visible)
local foreGroundWin=fullScreenSkinConfig[self.skinType].foreGroundWin
if foreGroundWin~=nil then
if visible then
UIManager:showWindowImp(foreGroundWin,self.skinType)
fullScreenUI.commonWins[foreGroundWin]=true
else
UIManager:hideWindowImp(foreGroundWin)
fullScreenUI.commonWins[foreGroundWin]=false
end
end
end

function fullScreenUI:showBottomMaskWin(visible,clickMenu)
local bottomMaskWin=fullScreenSkinConfig[self.skinType].bottomMaskWin
if visible then
UIManager:showWindowImp(bottomMaskWin,{clickMenu=clickMenu})
fullScreenUI.commonWins[bottomMaskWin]=true
else
UIManager:hideWindowImp(bottomMaskWin)
fullScreenUI.commonWins[bottomMaskWin]=false
end
end

function fullScreenUI:showTopMaskWin(visible)
if not resolutionUtility.enableMinAspect then
return
end
local topMaskWin=fullScreenSkinConfig[self.skinType].topMaskWin
if topMaskWin==nil then
topMaskWin="UITopMaskWin"
end
if visible then
UIManager:showWindowImp(topMaskWin)
fullScreenUI.commonWins[topMaskWin]=true
else
UIManager:hideWindowImp(topMaskWin)
fullScreenUI.commonWins[topMaskWin]=false
end
end

function fullScreenUI:showRawMaskWin(visible,args)
local rawImageBackWin='UIRawImageBackWin'
if visible then
UIManager:showWindowImp(rawImageBackWin,args)
fullScreenUI.commonWins[rawImageBackWin]=true
else
UIManager:hideWindowImp(rawImageBackWin)
fullScreenUI.commonWins[rawImageBackWin]=false
end
end

function fullScreenUI.destroyAllWindow()
fullScreenUI.clearAllCallback()
if fullScreenUI.activeUI then
fullScreenUI.closeUI(fullScreenUI.activeUI,false)
end
local commonWins=table.deepCopy(fullScreenUI.commonWins)
fullScreenUI.commonWins={}
for k,v in pairs(commonWins)do
UIManager:closeWindowImp(k)
end
end


function fullScreenUI.setNextActiveUICallback(callback,argstable)
if callback==nil then
return
end
fullScreenUI.nextActiveUICallback={callback,argstable}
end

function fullScreenUI.clearCallback()
fullScreenUI.nextActiveUICallback=nil
end

function fullScreenUI.clearAllCallback()
fullScreenUI.clearCallback()
fullScreenUI.clearCallback2()
end

function fullScreenUI.getNextActiveUICallback()
return fullScreenUI.nextActiveUICallback
end

function fullScreenUI.setNextActiveUICallback2(callback,argstable)
if callback==nil then
return
end
fullScreenUI.nextActiveUICallback2={callback,argstable}
end

function fullScreenUI.clearCallback2()
fullScreenUI.nextActiveUICallback2=nil
end


function fullScreenUI:resetData()
self.viewNames={}
self.subIndex=nil
self.tabType=nil
self.activeNames={}
self.activeSubMenu=nil
self.oldActiveSubMenu=nil
self.showBg=nil
self.showTopMask=nil
self.activeMenuIndex=nil
self.showTabTypeList={}
self.attach=nil
self.subFullType=nil
end






function fullScreenUI:showWindow(name,argtable)
if name==nil or name==''then



return
end
UIManager:showWindowImp(name,argtable)
self.activeNames[name]=true
self:addOrder(name)

end

function fullScreenUI:hideWindow(name)
if name==nil or name==''then



return
end
UIManager:hideWindowImp(name)
self.activeNames[name]=false
end

function fullScreenUI:closeWindow(name,forceClose)
if name==nil or name==''then



return
end
UIManager:closeWindowImp(name,forceClose)
self:removeOrder(name)
self.activeNames[name]=nil
end

function fullScreenUI:freshWindowArgs(name,args)
self.activeNames[name]=args
end

function fullScreenUI:closeAllWindow()
if self.activeNames==nil then return end
local activeNames=table.deepCopy(self.activeNames)
self.activeNames={}
for k,v in pairs(activeNames)do
self:closeWindow(k)
end
end

function fullScreenUI:addOrder(name)
if self.order==nil then self.order=0 end
if self.namesOrder==nil then self.namesOrder={}end
if self.namesOrder[name]==nil then
self.order=self.order+1
self.namesOrder[name]=self.order
end
end

function fullScreenUI:removeOrder(name)
if self.namesOrder and self.namesOrder[name]then
self.namesOrder[name]=nil
end
end




function fullScreenUI:showActiveView(activeViewName,argtable)
if self.activeNames[activeViewName]~=nil then
local win=UIManager:findActiveWindow(activeViewName)
if win then
win:setVisible(true)
if win.onShowArgRecv~=nil then
win:onShowArgRecv(argtable)
end
return
end
end
self:showWindow(activeViewName,argtable)
self.activeNames[activeViewName]=true
end





function fullScreenUI:initUI(params)
local fullType=params.fullType
if fullType==nil then
logErr('fullType 不能为空')
return
end
local menulist=params.menulist
local tabType=params.defaultTabType
self.attachName=params.attachName
self.hasStage=params.stage or false

self.skinType=params.skinType or fullScreenSkinType.eSkin1

self.moneyWinType=params.moneyWinType or fullTopMoneyType.eSkin1
self.isShowUnActiveWin=params.isShowUnActiveWin or false

self:resetData()
self.tabIdxsLookup=nil
self.tabTypesLookup=nil
self.subMenu=nil

self.backActiveNames={}
self.backOrder={}
self.namesOrder={}
self:setFullType(fullType)
self:addSubMenuList(menulist)
self.defaultTabType=tabType
self.menuLookup={}
for i,v in ipairs(menulist or{})do
self.menuLookup[v.tabType]=i
end
end

function fullScreenUI:getTabIdx(tabType)
return self.menuLookup[tabType]
end

function fullScreenUI:getTabType(menuIdx)
return self.tabTypesLookup[menuIdx]
end

function fullScreenUI:getCurTabType()
return self.tabType
end

function fullScreenUI:setFullType(fullType)
self.fullType=fullType
end

function fullScreenUI:addSubMenuList(menulist)
if menulist==nil then return end
for i,v in ipairs(menulist)do
self:addSubMenu(v)
end
end

function fullScreenUI:addSubMenu(menu)
if menu==nil then return end
local tabType=menu.tabType

if self.subMenu==nil then self.subMenu={}end
self.subMenu[#self.subMenu+1]=menu

local idx=#self.subMenu

if self.tabIdxsLookup==nil then self.tabIdxsLookup={}end
self.tabIdxsLookup[tabType]=idx

if self.tabTypesLookup==nil then self.tabTypesLookup={}end
self.tabTypesLookup[idx]=tabType
end

function fullScreenUI:reviseSubMenu(menu)
local tabType=menu.tabType
for i,v in ipairs(self.subMenu)do
if v.tabType==tabType then
self.subMenu[i]=menu
break
end
end
end

function fullScreenUI:reviseSubMenuValue(tabType,key,val)
for i,v in ipairs(self.subMenu)do
if v.tabType==tabType then
v[key]=val
break
end
end
end

function fullScreenUI:setAttach(attach)
local attachName=self.attachName
if attachName==nil then return true end
if attach==nil then
loggerUtil.logErrFMT('本全屏已定义透传参数配置attachName，当前方法没有传递')
return false
end
for _,name in ipairs(attachName)do
if attach[name]==nil then
loggerUtil.logErrFMT('本全屏已定义透传具名参数{0}，当前方法没有传递',name)
return
end
if type(attach[name])=='table'then
loggerUtil.logErrFMT('本全屏透传具名参数{0}类型不能是table',name)
return
end
end
self.attach=attach
return true
end

function fullScreenUI:copyAttach(res,t)
local attachName=self.attachName
if attachName==nil then return end
for _,name in ipairs(attachName)do
res[name]=t[name]
end
end

function fullScreenUI:copyAttach2(res)
local attach=self.attach
if attach==nil then return end
self:copyAttach(res,self.attach)
end

function fullScreenUI:copyAttachEx(res,showParam)
local viewArgs=showParam.viewArgs
if viewArgs==nil then return end
local attachName=self.attachName
if attachName==nil then return end
for _,argstable in pairs(viewArgs)do
for _,name in ipairs(attachName)do
if argstable[name]and res[name]==nil then
res[name]=argstable[name]
end
end
end
end

function fullScreenUI:tryGetAttachArgs(showParam)
local viewArgs=showParam.viewArgs
if viewArgs==nil then return end
local attachName=self.attachName
local tabType=self.tabType
if attachName==nil then return end
local attach={}
for _,argstable in pairs(viewArgs)do
for _,name in ipairs(attachName)do
if argstable[name]~=nil and attach[name]==nil then
attach[name]=argstable[name]
end
end
argstable.tabType=tabType
end

attach.tabType=tabType
return attach
end

function fullScreenUI:handleArgs(showParam)
local attach=self:tryGetAttachArgs(showParam)
self:setAttach(attach)
end

function fullScreenUI:checkTabChange()
return fullScreenUI.isTabChange(self.oldActiveSubMenu,self.activeSubMenu)
end

function fullScreenUI.isTabChange(oldSubMenu,newSubMenu)
if oldSubMenu==nil and newSubMenu~=nil then return true end
if newSubMenu==nil and oldSubMenu~=nil then return true end
if#oldSubMenu~=#newSubMenu then return true end
for i,v in ipairs(oldSubMenu)do
local oldtabType=v.tabType
local newtabType=newSubMenu[i].tabType
if oldtabType~=newtabType then return true end
end
return false
end

function fullScreenUI:changeAttachValue(name,value)
local attachName=self.attachName
if attachName==nil then return end
if self.attach==nil then return end
if self.attach[name]==nil then return end
self.attach[name]=value
end


function fullScreenUI:refreshMenu()
local changeSelect=false
local isRedirect=false

local showParam=self.showParam
local subMenu=self.subMenu
local activeSubMenu=showParam.activeSubMenu
if subMenu then
local attach_={}
self:copyAttach(attach_,self.attach)
activeSubMenu=fullScreenModel.getActiveTablist(subMenu,attach_)
end
local oldMenuNun=0
if self.activeSubMenu then
oldMenuNun=#self.activeSubMenu
end
local menuNun=0
if activeSubMenu then
menuNun=#activeSubMenu
end
self.oldActiveSubMenu=self.activeSubMenu
local changeMenu=fullScreenUI.isTabChange(self.activeSubMenu,activeSubMenu)
if changeMenu then
self.activeSubMenu=activeSubMenu


local tabType=self.tabType
local oldSelectIndex=self.activeMenuIndex
local newSelectIndex=oldSelectIndex

if menuNun>0 then
local f=nil
for i,v in ipairs(activeSubMenu)do
if v.tabType==tabType then
f=i
break
end
end
if f then
newSelectIndex=f
isRedirect=true
else

newSelectIndex=1
tabType=activeSubMenu[newSelectIndex].tabType
self.tabType=tabType
self.attach.tabType=tabType
end
end
changeSelect=newSelectIndex~=oldSelectIndex



local skincfg=fullScreenSkinConfig[self.skinType]
local menuWinName=skincfg.bottomMaskWin






if changeSelect then
self.activeMenuIndex=newSelectIndex
UIManager:invokeUIMethod(menuWinName,'rebuildMenu')
UIManager:invokeUIMethod(menuWinName,'reSelectMenu',newSelectIndex)
else
UIManager:invokeUIMethod(menuWinName,'rebuildMenu')
end
end
return changeMenu,changeSelect,isRedirect
end


function fullScreenUI:freshFunc(func)
local argstable=nil
if self.attach then
argstable=self.attach
end
if func==nil then func='onShowArgRecv'end
for name,flag in pairs(self.activeNames)do
UIManager:callWindowFunc(name,func,argstable)
end
end





function fullScreenUI.clearLastUI()
fullScreenUI.lastInfo=nil
fullScreenUI.clearAllCallback()
end

function fullScreenUI.showAllWindow(activeUI)
if activeUI==nil then return end
local self=activeUI
local temp={}
local lookup={}
local backActiveNames=table.deepCopy(self.backActiveNames)
for name,_ in pairs(backActiveNames)do
if not self.activeNames[name]and lookup[name]==nil then
temp[#temp+1]=name
lookup[name]=true
end
end
lookup=nil

if#temp>=2 then
table.sort(temp,function(a,b)
local order_a=self.backOrder[a]
local order_b=self.backOrder[b]
if order_a==nil or order_b==nil then
loggerUtil.logErrFMT('返回时排序错误 fullType:{0} a：{1} b:{2}',self.fullType,a,b)
return true
end
return order_a<order_b
end)
end

for _,name in ipairs(temp)do
if not jumpManager:isSkipBack(name)then
local args=UIManager:getBackArgs(name)
self:showWindow(name,args)
end
end
temp=nil
self.backActiveNames={}
self.backOrder={}
end

function fullScreenUI:clearBackInfo()
self.backActiveNames={}
self.backOrder={}

end


function fullScreenUI.setBackUI(lastUI,showParam)
if lastUI.jump==true then
local lastInfo={}
lastInfo.activeUI=lastUI
lastInfo.showParam=showParam
fullScreenUI.lastInfo=lastInfo
end
end

function fullScreenUI.isSubFullChanged()
if fullScreenUI.lastInfo then
local lastInfo=fullScreenUI.lastInfo
local showParam=lastInfo.showParam or{}
local subFullType=showParam.subFullType
local activeUI=fullScreenUI.activeUI
return activeUI.subFullType~=subFullType
end
end

function fullScreenUI.showBackWindow()
if fullScreenUI.lastInfo then
local lastInfo=fullScreenUI.lastInfo
if lastInfo.activeUI and lastInfo.activeUI.jump then
lastInfo.activeUI.jump=false
fullScreenUI.showUI(lastInfo.activeUI,lastInfo.showParam,true)
fullScreenUI.showAllWindow(lastInfo.activeUI)
end
end
fullScreenUI.lastInfo=nil
end


function fullScreenUI.getSubFullType(viewName,id)
return FMT.fmt('{0}_{1}',viewName,id)
end


function fullScreenUI:beginJumpOut(jumpCfg)
self.backActiveNames={}
for name,flag in pairs(self.activeNames)do
if flag==true then
self.backActiveNames[name]=true
UIManager:freshBackArgs(name)
end
end

for k,v in pairs(self.namesOrder)do
self.backOrder[k]=v
end
end


function fullScreenUI:endJumpOut(jumpCfg,hasBack)
if hasBack then
if self.hasStage then return end

fullScreenUI.setNextActiveUICallback(function()
local activeUI=fullScreenUI.activeUI
if activeUI.fullType~=BASE_FULL_TYPE then
local sameUI=activeUI.fullType==self.fullType
if sameUI then
local canBackSame=fullScreenUI.isSubFullChanged()
if not canBackSame then return false end
_closeUI(activeUI,false)
end
fullScreenUI.showBackWindow()
baseFullScreenUI:showBackWindow()
else
fullScreenUI.clearAllCallback()
return false
end
end)
end
end

function fullScreenUI:beginJumpIn()

end


function fullScreenUI.enableSceneSound(flag)
AudioManager.setGroupMute(SOUND_GROUP_TYPE.scene3d,flag)
end

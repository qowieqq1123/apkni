






local _MODULENAME="oneTabScreenController"





gameState.addListener(def_table(_MODULENAME))
oneTabScreenController.name=_MODULENAME







local _panels={}


























local _data=nil
local opData=nil
local _args=nil
local _closePanels={}

function oneTabScreenController:onAppStart()
end

function oneTabScreenController:onEnterState()
end

function oneTabScreenController:onLeaveState(isReconnet)
if isReconnet then return end
_panels={}
_data=nil
opData=nil
_args=nil
_closePanels={}
end

function oneTabScreenController:onPlayerCreate(...)
end

function oneTabScreenController:onLostConnection()
end


function oneTabScreenController:openUI(eType,winArgs)
local config=oneTabScreenConfig:getScreenConfig(eType)
if config then
self:showUIImp(config,winArgs)


else
loggerUtil.logErrFMT('未定义右侧单列表二级窗体类型 {0}',eType)

end
end


function oneTabScreenController:openTabUI(tabType,winArgs,onlyTab)
local eType=oneTabScreenConfig:getScreenLookupMain(tabType)
local config=oneTabScreenConfig:getScreenConfig(eType)
if config then
return self:showUIImp(config,winArgs,tabType,nil,onlyTab)


else
loggerUtil.logErrFMT('未定义右侧单列表二级窗体  子类型',tabType)

return false
end
end


function oneTabScreenController:showUIImp(config,winArgs,tabType,isJump,onlyTab)

self:markCleanPanels()

local data={}
local panels={}
local skinData=oneTabScreenConfig:getSkinConfig(config.skin)
for i,v in pairs(skinData)do
panels[i]=v
end

local tabName={}
local indexs={}
local tabTypes={}
local views={}
local titles={}
local titleImgCfgs={}
local reddotSubTypes={}
local idx=0
local curidx
local openNum=0
local firstTabType=nil
for i,v in ipairs(config.children)do
local luaCfg=tabScreenConfig:getTabScreenConfig(v)
local tabCfg=tabScreenConfig:getTabConfig(v)
local isOpen=tabScreenConfig.isTabActive(v,luaCfg,winArgs)
local show=isOpen and(not onlyTab or onlyTab and tabType==v)
if show then
idx=idx+1
table.insert(tabName,tabCfg.name)
table.insert(views,luaCfg.views)
table.insert(indexs,i)
table.insert(tabTypes,v)
if luaCfg.reddotSubType then
reddotSubTypes[i]=luaCfg.reddotSubType
elseif luaCfg.reddotSubTypeFunc then
reddotSubTypes[i]=luaCfg.reddotSubTypeFunc(winArgs)
end
titles[idx]=tabCfg.title
titleImgCfgs[idx]=tabCfg.titleImgCfg
end
if firstTabType==nil then firstTabType=v end
if show then openNum=openNum+1 end
if tabType==v and show then
curidx=idx
end
end


if tabType==nil then
if openNum==0 then
oneTabScreenController:showTabActiveTips(firstTabType,winArgs)
return false
else
curidx=1
end
else
if curidx==nil then
oneTabScreenController:showTabActiveTips(tabType,winArgs)
return false
end
end

panels[eOneTabScreenNode.childViews]=views
data.oType=tabType
data.panels=panels
data.titles=titles
data.titleImgCfgs=titleImgCfgs
data.indexs=indexs
data.config=config
data.commonArgs=self:checkArgs(config.commonArgs or{},winArgs)
data.winArgs=winArgs
if _data and _data.selected then

local selected=_data.selected
local dels={}
for i,v in pairs(selected)do
if indexs[i]==nil then
table.insert(dels,i)
end
end
if#dels>0 then
for i,v in ipairs(dels)do
selected[v]=nil
end
end
data.selected=selected
else
data.selected={}
end

_data=data

local title_name=titles[curidx]
local title_Img=titleImgCfgs[curidx]
local bgParam={
title=title_name,
titleImg=title_Img,
close=function()
self:closeUI()


if config.closeWinFunc then
config.closeWinFunc()
end
end,
}
local name=panels[eOneTabScreenNode.bgPanel]
_panels[name]=true
_closePanels[name]=nil
UIManager:showWindow(name,bgParam)

local listParam={
names=tabName,
init=curidx,
click=function(index)
self:selectTabView(index)
end,
tabTypes=tabTypes,
reddotSubTypes=reddotSubTypes,
indexs=indexs,
}
local name=panels[eOneTabScreenNode.tabList]
_panels[name]=true
_closePanels[name]=nil
UIManager:showWindow(name,listParam)
opData={}
return true
end

function oneTabScreenController:closeUI()
if self:isActiveUI()then
for i,v in pairs(_panels)do

UIManager:closeWindow(i)
end
_panels={}
_data=nil
opData=nil
_closePanels={}
end
end

function oneTabScreenController:isActiveUI()
return _data~=nil
end


function oneTabScreenController:selectTabView(index,refreshTabList)
if not self:isActiveUI()then
return
end
local waitHide={}
local childPanels=_data.panels[eOneTabScreenNode.childViews]
for i,v in pairs(_data.selected)do
if v then
for _,w in ipairs(childPanels[i])do


waitHide[w]=true
end
_data.selected[i]=false
end
end

if not childPanels[index]then
return
end
local cfgidx=_data.indexs[index]
local tabType=_data.config.children[cfgidx]

if refreshTabList then
local luaCfg=tabScreenConfig:getTabScreenConfig(tabType)
local isOpen=tabScreenConfig.isTabActive(tabType,luaCfg,_data.winArgs)
local selectTabType
if isOpen then
selectTabType=tabType
else
selectTabType=nil
end
return oneTabScreenController:showUIImp(_data.config,_data.winArgs,selectTabType)
end

for i,v in ipairs(childPanels[index])do
local args
if _data.oType then
args=tabType==_data.oType and _data.winArgs or _data.commonArgs
else

args=_data.winArgs
end


local menuPageIndex=_data.indexs[index]
args.menuPageIndex=menuPageIndex

args.pageIndex=index

args.opData=opData
_panels[v]=true
waitHide[v]=nil

_closePanels[v]=nil
local win=UIManager:findActiveWindow(v)
if win then
win:setVisible(true)
if win.onShowArgRecv~=nil then
win:onShowArgRecv(args)
elseif win.onShow~=nil then

win:onShow(args)
end
else
UIManager:showWindow(v,args)
end
end
local title=_data.titles[index]
local titleImg=_data.titleImgCfgs[index]
local bgPanel=_data.panels[eOneTabScreenNode.bgPanel]
UIManager:invokeUIMethod(bgPanel,"setTitle",title)
if titleImg then
UIManager:callWindowFunc(bgPanel,"setTitleImg",titleImg)
end

for i,v in pairs(waitHide)do

UIManager:hideWindow(i)
_panels[i]=false
end









_data.selected[index]=true
oneTabScreenController:closeLastPanels()
end

function oneTabScreenController:checkArgs(commonArgs,args)
local temp={}
for i,v in ipairs(commonArgs)do
local param=args[v]
if param then
if type(param)~="table"then
temp[v]=param
else
loggerUtil.logErrFMT("oneTabScreen参数{0}不应该是table类型",v)
end
else
loggerUtil.logErrFMT("oneTabScreen缺少参数{0}",v)
end
end
return temp
end

function oneTabScreenController:changeArgs(args,isChangeCommonArgs)

if not self:isActiveUI()then
return
end

local config=_data.config
local commonArgs=config.commonArgs
local winArgs=_data.winArgs
local commonArgsData=_data.commonArgs
for i,v in ipairs(commonArgs)do
local param=args[v]
if param then
if type(param)~="table"then
winArgs[v]=param
if isChangeCommonArgs then
commonArgsData[v]=param
end
else
loggerUtil.logErrFMT("oneTabScreen参数{0}不应该是table类型",v)
end
end
end
end

function oneTabScreenController:showTabActiveTips(tabType,winArgs)
local luaCfg=tabScreenConfig:getTabScreenConfig(tabType)
local tabCfg=tabScreenConfig:getTabConfig(tabType)
local isOpen=tabScreenConfig.isTabActive(tabType,luaCfg,winArgs,true)
return isOpen
end

function oneTabScreenController:markCleanPanels()
for i,v in pairs(_panels)do
if v then
_closePanels[i]=true
end
end
end
















function oneTabScreenController:closeLastPanels()
for name,v in pairs(_closePanels)do
UIManager:closeWindow(name)
_panels[name]=nil
end
_closePanels={}
end

function oneTabScreenController:printCurrentData()

end

function oneTabScreenController:printCurrentPanels()

end

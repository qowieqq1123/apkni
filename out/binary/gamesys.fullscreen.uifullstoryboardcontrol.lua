








UIFullStoryBoardControl=gameState.addListener(fullScreenUI.create())

local plotBoardSkinWinName={
[1]='UIPlotBoardWin',
[2]='UIPlotBoardFourthWin',
[3]='UIPlotComicWin',
}

function UIFullStoryBoardControl:getPlotBoardWinName(skin)
return plotBoardSkinWinName[skin]
end

function UIFullStoryBoardControl:isPlotBoardWinName(winName)
return table.containsValue(plotBoardSkinWinName,winName)
end

function UIFullStoryBoardControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eStoryBoard,
skinType=fullScreenSkinType.eSkin5,
attachName={},
}
self:initUI(args)
end


function UIFullStoryBoardControl:showStoryBoardWindow(argstable)
local isFullOpen=argstable.isFullOpen
if isFullOpen==nil then
isFullOpen=true
argstable.isFullOpen=isFullOpen
end
if isFullOpen then
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIStoryBoardWin'},
viewArgs={['UIStoryBoardWin']=argstable},
}
self:showUI(args)
else
UIManager:showWindow('UIStoryBoardWin',argstable)
end
end


function UIFullStoryBoardControl:showPlotBoardWindow(argstable,isFullOpen)
local showblack=argstable.showblack

local groupid=argstable.groupid
local skin
if groupid~=nil then
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,groupid)
if groupcfg==nil then



return
end
skin=groupcfg.skin
showblack=groupcfg.blackBack and true or false

end
skin=skin or 1
local winName=UIFullStoryBoardControl:getPlotBoardWinName(skin)
argstable.winName=winName

argstable.showblack=showblack==true and true or false
if argstable.showblack then
gameplotController:showPlotBlack({alpha=argstable.blackAlpha})
else
gameplotController:closePlotBlack()
end

if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={winName},
viewArgs={[winName]=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow(winName,argstable)
end
end


function UIFullStoryBoardControl:showPlotBoardWindow2(argstable,isFullOpen)
if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotBoardTwoWin'},
viewArgs={['UIPlotBoardTwoWin']=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow('UIPlotBoardTwoWin',argstable)
end
end


function UIFullStoryBoardControl:showPlotBoardWindow3(argstable,isFullOpen)
local showblack=argstable.showblack
if argstable.groupid~=nil then
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,argstable.groupid)
if groupcfg==nil then



return
end
showblack=groupcfg.blackBack
end

argstable.showblack=showblack==true and true or false
if argstable.showblack then
gameplotController:showPlotBlack({alpha=argstable.blackAlpha})
else
gameplotController:closePlotBlack()
end

if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotBoardThreeWin'},
viewArgs={['UIPlotBoardThreeWin']=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow('UIPlotBoardThreeWin',argstable)
end
end


function UIFullStoryBoardControl:showPlotBoardWindow5(argstable,isFullOpen)
argstable.showblack=argstable.showblack==true and true or false
if argstable.showblack then
gameplotController:showPlotBlack({alpha=argstable.blackAlpha})
else
gameplotController:closePlotBlack()
end

if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotBoardFiveWin'},
viewArgs={['UIPlotBoardFiveWin']=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow('UIPlotBoardFiveWin',argstable)
end
end

function UIFullStoryBoardControl:showPlotBoardWindow6(argstable,isFullOpen)
argstable.showblack=argstable.showblack==true and true or false
if argstable.showblack then
gameplotController:showPlotBlack({alpha=argstable.blackAlpha})
else
gameplotController:closePlotBlack()
end

if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotBoardSixWin'},
viewArgs={['UIPlotBoardSixWin']=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow('UIPlotBoardSixWin',argstable)
end
end

function UIFullStoryBoardControl:showManHuaWindow(argstable,isFullOpen)
if isFullOpen==nil then
isFullOpen=true
end
argstable.isFullOpen=isFullOpen
if isFullOpen then
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIManHuaWin'},
viewArgs={['UIManHuaWin']=argstable or{}},
}
self:showUI(args)
else
UIManager:showWindow('UIManHuaWin',argstable)
end
end

function UIFullStoryBoardControl:showDiscipleWindow(argstable)
local args=
{
showBg=true,
viewNames={'UIWorldShowDiscipleWin'},
viewArgs={['UIWorldShowDiscipleWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullStoryBoardControl:showDiscipleAwakeWindow(argstable)
local args=
{
showBg=true,
viewNames={'UIDiscipleAwakeResultWin'},
viewArgs={['UIDiscipleAwakeResultWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullStoryBoardControl:showDiscipleAwakeWindowEx(id,bt,key)

local temp=gameplotModel:popDiscipleChange(id)






if temp then
local args={
oldData=temp[1],
newData=temp[2],
btParam={bt,key},
}
self:showDiscipleAwakeWindow(args)
else
loggerUtil.logErrFMT("没有对应弟子id的觉醒记录：{0}",id)
if bt and key then
bt:setSharedVar(key,true)
end
end
end

function UIFullStoryBoardControl:showCreateRoleWindow(argstable)
gameplotController:closePlotBlack()

local args=
{
showBg=true,
showBlur=false,
viewNames={'UICreateRoleWin'},
viewArgs={['UICreateRoleWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullStoryBoardControl:showActionWindow(argstable,isFullOpen)
if isFullOpen then
argstable.isFullOpen=true
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotActionWin'},
viewArgs={['UIPlotActionWin']=argstable or{}},
}
self:showUI(args)
else
argstable.isFullOpen=false
UIManager:showWindow('UIPlotActionWin',argstable)
end

end

function UIFullStoryBoardControl:showMovieWindow(argstable)
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIMovieWin'},
viewArgs={['UIMovieWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullStoryBoardControl:showPlotComicWindow(argstable)

if argstable.groupid~=nil then
local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,argstable.groupid)
if groupcfg==nil then



return
end
local args=
{
showBg=true,
showBlur=false,
viewNames={'UIPlotComicWin'},
viewArgs={['UIPlotComicWin']=argstable or{}},
}
self:showUI(args)
else



end
end

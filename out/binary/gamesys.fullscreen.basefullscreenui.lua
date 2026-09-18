




baseFullScreenUI=gameState.addListener(fullScreenUI.create())
BASE_FULL_TYPE=-1




function baseFullScreenUI:onAppStart()
local args=
{
fullType=BASE_FULL_TYPE,
}
self.activeNames={}
self.lastBaseActiveNames={}
self:initUI(args)
end

function baseFullScreenUI:hasActiveUI()
for _,flag in pairs(self.activeNames)do
if flag then return true end
end
return false
end

function baseFullScreenUI:showWindow(name,argtable)
if name==nil or name==''then



return false
end
fullScreenUI.showWindow(self,name,argtable)
if fullScreenUI.activeUI==nil then fullScreenUI.activeUI=self end
return true
end

function baseFullScreenUI:closeWindow(name,forceClose)
if name==nil or name==''then



return false
end
fullScreenUI.closeWindow(self,name,forceClose)
if self.needShowBackWindow and self.checkJumpOpenWindow then
if self.checkJumpOpenWindow[name]then
self.checkJumpOpenWindow[name]=nil
end
if not next(self.checkJumpOpenWindow)then
baseFullScreenUI:showJumpBackBaseFullWindow()
end
end
end

function baseFullScreenUI:hideWindow(name)
if name==nil or name==''then



return false
end
fullScreenUI.hideWindow(self,name)
end


function baseFullScreenUI:showBackWindow()
local temp={}
local lookup={}
local backActiveNames=table.deepCopy(self.backActiveNames)
self.backActiveNames={}
for name,_ in pairs(backActiveNames)do
if not UIManager:isActive(name,true)and lookup[name]==nil then
temp[#temp+1]=name
lookup[name]=true
end
end
lookup=nil

if#temp>=2 then
local t={}
local len=#temp
for i=1,len do
for j=1,len-i do
local name1=temp[j]
local name2=temp[j+1]
local order_a=self.backOrder[name1]or 0
local order_b=self.backOrder[name2]or 0
if order_a>order_b then
local val=temp[j+1]
temp[j+1]=temp[j]
temp[j]=val
end
end
end
end

for _,name in ipairs(temp)do
if not jumpManager:isSkipBack(name)then
local args=UIManager:getBackArgs(name)
self:showWindow(name,args)
end
end
temp=nil
self.jump=false
end


function baseFullScreenUI:showJumpBackBaseFullWindow()
local temp={}
local lookup={}
local backActiveNames=table.deepCopy(self.jumpBackBaseFullActiveNames)
baseFullScreenUI:clearNeedShowBackWindow()
self.jumpBackBaseFullActiveNames={}
for name,_ in pairs(backActiveNames)do
if not UIManager:isActive(name,true)and lookup[name]==nil then
temp[#temp+1]=name
lookup[name]=true
end
end
lookup=nil

if#temp>=2 then
local t={}
local len=#temp
for i=1,len do
for j=1,len-i do
local name1=temp[j]
local name2=temp[j+1]
local order_a=self.jumpBackBaseFullOrder[name1]or 0
local order_b=self.jumpBackBaseFullOrder[name2]or 0
if order_a>order_b then
local val=temp[j+1]
temp[j+1]=temp[j]
temp[j]=val
end
end
end
end

for _,name in ipairs(temp)do
if not jumpManager:isSkipBack(name)then
local args=UIManager:getBackArgs(name)
self:showWindow(name,args)
end
end
temp=nil
self.jump=false
end


function baseFullScreenUI:beginJumpIn(jumpCfg,isBaseJumpOut)
if isBaseJumpOut then
self.jumpBackBaseFullActiveNames={}
self.jumpBackBaseFullOrder={}
for name,v in pairs(self.activeNames)do
if UIManager:isActive(name,true)and not jumpManager:isSkipBack(name)then
self.jumpBackBaseFullActiveNames[name]=v
UIManager:freshBackArgs(name)
end
end

for name,v in pairs(self.namesOrder)do
self.jumpBackBaseFullOrder[name]=v
end
end

self.lastBaseActiveNames={}
local activeNames=table.deepCopy(self.activeNames)
self.activeNames={}
for k,v in pairs(activeNames)do
self.lastBaseActiveNames[k]=v
end
end


function baseFullScreenUI:endJumpIn(ret,jump_config,lastControl)
if ret then

if lastControl and lastControl~=self then

local activeNames=table.deepCopy(lastControl.activeNames or{})


local lastBaseActiveNames=self.lastBaseActiveNames
for name,_ in pairs(lastBaseActiveNames)do
if activeNames[name]==nil then
activeNames[name]=true
end
end


for name,_ in pairs(activeNames)do
if not self.activeNames[name]then
UIManager:closeWindowWithLoading(name,true)
end
end
lastControl:resetData()
fullScreenUI.clearAllCallback()

fullScreenUI.closeCommonUI(self.activeNames)

elseif lastControl==self then
local activeNames=table.deepCopy(self.lastBaseActiveNames)

for name,_ in pairs(activeNames)do
if not self.activeNames[name]then
UIManager:closeWindowWithLoading(name,true)
end
end

if self.needShowBackWindow then

self.checkJumpOpenWindow=table.deepCopy(self.activeNames)
end
end
self.lastBaseActiveNames={}
fullScreenUI.activeUI=nil
self:openMain(jump_config.addMain)
fullScreenUI.activeUI=self
end
end

function baseFullScreenUI:revertActiveNamesList()

if self.lastBaseActiveNames then
for k,v in pairs(self.lastBaseActiveNames)do
self.activeNames[k]=v
end
self.lastBaseActiveNames={}
end
end

function baseFullScreenUI:beginJumpOut(jumpCfg)
self.backActiveNames={}
for name,v in pairs(self.activeNames)do
if UIManager:isActive(name,true)then
self.backActiveNames[name]=v
UIManager:freshBackArgs(name)
end
end

for name,v in pairs(self.namesOrder)do
self.backOrder[name]=v
end
end

function baseFullScreenUI:endJumpOut(jumpCfg,hasBack)
if hasBack then
fullScreenUI.setNextActiveUICallback(function()
fullScreenUI.activeUI=nil
baseFullScreenUI:showBackWindow()
return false
end)
end
end

function baseFullScreenUI:isBaseFull()
local activeNames=self.activeNames
for name,v in pairs(activeNames)do
if UIManager:isActive(name,true)then
return true
end
end
return false
end

function baseFullScreenUI:clearNeedShowBackWindow()
self.needShowBackWindow=nil
self.checkJumpOpenWindow=nil
end

function baseFullScreenUI:setNeedShowBackWindow(flag)
self.needShowBackWindow=flag
end


function baseFullScreenUI:close()
local activeNames=table.deepCopy(self.activeNames)

local list={}
for name,_ in pairs(activeNames)do
list[name]=true
UIManager:closeWindowWithLoading(name,true)
end

local activeNames=table.deepCopy(self.lastBaseActiveNames)
for name,_ in pairs(activeNames)do
if list[name]==nil then
UIManager:closeWindowWithLoading(name,true)
end

if self.needShowBackWindow and self.checkJumpOpenWindow and self.checkJumpOpenWindow[name]then
self.checkJumpOpenWindow[name]=nil
end
end
list=nil
self.lastBaseActiveNames={}
self.activeNames={}

if self.needShowBackWindow and self.checkJumpOpenWindow and not next(self.checkJumpOpenWindow)then
baseFullScreenUI:showJumpBackBaseFullWindow()
end
end

function baseFullScreenUI:openMain(flag)
xpcall(function()
mainViewsControl:changeMain(flag)
end,function(err)
logErr('openMain:',err)
end)
end


function baseFullScreenUI:closeAllActiveWindow()
jumpManager:clearJump()
fullScreenUI.clearAllCallback()
fullScreenUI.closeActiveUI(false,false)
baseFullScreenUI:openMain(false)
end


function baseFullScreenUI:openWindowOnEnterScene()
if sceneControl.enterUICall then
sceneControl.enterUICall()
sceneControl.enterUICall=nil
else
baseFullScreenUI:openMain(true)
end
end

function baseFullScreenUI:goBackEx()
if newbieControl.isInNewbie()then

platformHelper:onEscape()
return
end

if MysteryModel:is_in_mystery()then

platformHelper:onEscape()
return
end

if fightModel:haveBattleShow()then

platformHelper:onEscape()
return
end

if storyAICommonManager:isPlayingStory()then

platformHelper:onEscape()
return
end


if worldController:isInWorld()and fullScreenUI.isActiveBaseFull()and not worldController:getCameraControl()then

platformHelper:onEscape()
return
end
if baseFullScreenUI:hasActiveUI()or UIDialogManager.hasActive()then
jumpManager:clearJump()
fullScreenUI.clearAllCallback()
for name,_ in pairs(baseFullScreenUI.activeNames)do
UIManager:closeWindowWithLoading(name,true)
end
UIDialogManager.closeAll()
elseif fullScreenUI.isActiveFull()then
jumpManager:clearJump()
fullScreenUI.clearAllCallback()
fullScreenUI.closeActiveUI(false,true)
else

platformHelper:onEscape()
end
end

function baseFullScreenUI:goBack()
if not api_Available_SimulationClickOneButton()then return end

if newbieControl.isInNewbie()then
platformHelper:onEscape()
return
end

if MysteryModel:is_in_mystery()then
platformHelper:onEscape()
return
end

if fightModel:haveBattleShow()then
platformHelper:onEscape()
return
end

if storyAICommonManager:isPlayingStory()then
platformHelper:onEscape()
return
end


if worldController:isInWorld()and
fullScreenUI.isActiveBaseFull()and
not worldController:getCameraControl()then
platformHelper:onEscape()
return
end

baseFullScreenUI:doBack()
end

function baseFullScreenUI:doBack()
if not CS.GameInterface.SimulationClickOneButton(1)then
if worldController:isInWorld()then
jumpManager:jump({id=JUMP_TYPE.eMain})
else
platformHelper:onEscape()
end
end
end

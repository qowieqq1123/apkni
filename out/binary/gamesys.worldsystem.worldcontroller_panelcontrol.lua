









local _this=worldController


local defaultViews={
left=nil,
right="UIWorldFunctionButtonWin",
}

local views={
left=nil,
right=nil,
lParam={},
rParam={},
}
local needPanels={"UIWorldHUDWin","UIWorldWin","UIWorldSymbolWin"}
local checkPanels={}
local _blackBlur={2}

function worldController:listenNeedPanels()
for i,v in ipairs(needPanels)do
local check=UIManager:listenWindowAwake(v,self.onWindowAwake)

end
end

function worldController.onWindowAwake(win,argstable,firstShow)
if firstShow then
_this:markCheckPanel(win.__name)

if _this:checkNeedPanels()then
local ticktimer=timer.new()
ticktimer:start(0.5,function()
_this:onEnterReadyPanel()
end,1)
end
end
end

function worldController:checkNeedPanels()
for i,v in pairs(needPanels)do
if not checkPanels[v]then
return false
end
end
return true
end

function worldController:openNeedPanel()
for i,v in pairs(needPanels)do
UIManager:showWindow(v)
end
end

function worldController:markCheckPanel(winName)
checkPanels[winName]=true
end

function worldController:clearCheckPanel()
checkPanels={}
end

function worldController:initView()
views.left=defaultViews.left
views.right=defaultViews.right
views.lParam={}
views.rParam={}
worldHUDModel:clearAllHUD()
end


function worldController:openPanel()

if initProControl.isDone()then

if not worldExperienceModel:checkScene()then
self:openDefaultPanel()
else
worldController:openExperiencePanel()
end
end
end

function worldController:openDefaultPanel()
UIManager:showWindow("UIWorldWin")

worldController:displayHUD(true)
worldController:displayUI(true)
worldController:displaySymbol(true)

if views.left then
UIManager:showWindow(views.left,unpack(views.lParam))
else
self:resetLeftView()
end

if views.right then
UIManager:showWindow(views.right,unpack(views.rParam))
else
self:resetRightView()
end
end

function worldController:openExperiencePanel()
UIManager:showWindow("UIWorldWin")
UIManager:showWindow("UIWorldExperienceWin")

worldController:displayHUD(true)
worldController:displayUI(false)
worldController:displaySymbol(false)
worldController:hideView()
end


function worldController:hidePanel()
UIManager:hideWindow("UIWorldSymbolWin")
UIManager:hideWindow("UIWorldHUDWin")
UIManager:hideWindow("UIWorldWin")

if worldExperienceModel:checkScene()then
UIManager:hideWindow("UIWorldExperienceWin")
end

UIManager:hideWindow("UITaskListWin")

self:hideView()
end


function worldController:hideView()
if views.left then
UIManager:closeWindow(views.left)
end
if views.right then
UIManager:closeWindow(views.right)
end
views.left=defaultViews.left
views.right=defaultViews.right
views.lParam={}
views.rParam={}
end


function worldController:showPanel()

UIManager:showWindow("UIWorldSymbolWin")
UIManager:showWindow("UIWorldHUDWin")
UIManager:showWindow("UIWorldWin")
worldController:displayUI(true)


if taskController.showTaskListConditon()then
UIManager:showWindow("UITaskListWin")
end
self:showView()
end


function worldController:showView()
if views.left then
UIManager:showWindow(views.left,unpack(views.lParam))
end
if views.right then
UIManager:showWindow(views.right,unpack(views.rParam))
end
end




function worldController:changeLeftView(view,...)
if views.left~=view then
if views.left then
UIManager:hideWindow(views.left)
end

views.left=view
views.lParam={...}
if views.left then
UIManager:showWindow(views.left,...)
end
else

if views.left and not UIManager:isActive(view)then
views.lParam={...}
UIManager:showWindow(views.left,...)
end
end
end




function worldController:changeRightView(view,...)
if views.right~=view then
if views.right then
UIManager:hideWindow(views.right)
end

views.right=view
views.rParam={...}
if views.right then
UIManager:showWindow(views.right,...)
end
else

if views.right and not UIManager:isActive(view)then
views.rParam={...}
UIManager:showWindow(views.right,...)
end
end
end

function worldController:resetLeftView()
self:changeLeftView(defaultViews.left)
end

function worldController:resetRightView()
if MysteryModel:is_in_mystery()then
return
end
self:changeRightView(defaultViews.right)
end

function worldController:isCurrentLeftView(viewName)
return views.left==viewName
end

function worldController:isCurrentRightView(viewName)
return views.right==viewName
end

function worldController:getCurrentLeftView()
return views.left
end

function worldController:getCurrentRightView()
return views.right
end



function worldController:displayHUD(visible)
if visible then
UIManager:showWindow("UIWorldHUDWin")
else
UIManager:hideWindow("UIWorldHUDWin")
end
if visible and self:isInWorld()then
self:markCameraViewChange()
end
end



function worldController:displayUI(visible)

UIManager:invokeUIMethod("UIWorldWin","showUI",visible)
end



function worldController:displaySymbol(visible)

if visible then
UIManager:showWindow("UIWorldSymbolWin")
else
UIManager:hideWindow("UIWorldSymbolWin")
end
if visible and self:isInWorld()then
self:markCameraViewChange()
end
end











function worldController:checkBlackBlur()
return table.containsValue(_blackBlur,worldModel.world)
end
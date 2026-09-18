







def_class("UITaskGMlWin",UIWindowBase)









function UITaskGMlWin:bindComponents()

self.taskGrid=UIObject.get(self,0)



end


function UITaskGMlWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.taskGrid);self.taskGrid=nil;
end

















function UITaskGMlWin:onLoaded(...)
self:bindComponents()
end


function UITaskGMlWin:__delete()
self:unbindComponents()
end


function UITaskGMlWin:onHide()

end




function UITaskGMlWin:onShow(argtable,afterOnloaded)
self:refreshWin()
end

function UITaskGMlWin:refreshWin()
self.tasklist=taskModel:getTaskList_test()
local num=#self.tasklist
if num>0 then
self.taskGrid:setChildLayoutGroupCreateItems(num)
local grids=self.taskGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local taskdata=self.tasklist[i]
item:SetChildText(0,FMT.fmt('({0}-{1})',taskdata.taskid,taskdata.cfg.name))
item:SetChildButtonClick(1,function()
self:onItemClick(i)
end)
end
end
end

function UITaskGMlWin:onItemClick(idx)
local taskdata=self.tasklist[idx]
local taskid=taskdata.taskid


taskController:doAcceptTask(taskid)
self:closeSelf()
end



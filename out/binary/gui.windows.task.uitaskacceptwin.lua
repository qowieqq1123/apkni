







def_class("UITaskAcceptWin",UIWindowBase)









function UITaskAcceptWin:bindComponents()

self.taskName=UIText.get(self,0)
self.taskDesc=UIText.get(self,1)
self.goodGrid=UIObject.get(self,2)



end


function UITaskAcceptWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.taskName);self.taskName=nil;
_UIObject_release(self.taskDesc);self.taskDesc=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
end

















function UITaskAcceptWin:onLoaded(...)
self:bindComponents()
end


function UITaskAcceptWin:__delete()
self:unbindComponents()
end


function UITaskAcceptWin:onHide()

end




function UITaskAcceptWin:onShow(argtable,afterOnloaded)
self.taskid=argtable.taskid

self:refreshWin()
end

function UITaskAcceptWin:refreshWin()
local taskid=self.taskid
local taskCfg=taskModel:getTaskConfig(taskid)
self.taskName:setText(taskCfg.name)
self.taskDesc:setText(taskCfg.taskdesc)

local rewardlist=taskModel:getTaskRewardList(taskid)
local grid=self.goodGrid:getChildCommonLayoutGroupWidgetList()
for i=1,5 do
local data=rewardlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=''
if num>0 then
str=tostring(num)
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end
end

function UITaskAcceptWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UITaskAcceptWin:onAcceptClick()
taskController:doAcceptTask(self.taskid)
self:closeSelf()
end
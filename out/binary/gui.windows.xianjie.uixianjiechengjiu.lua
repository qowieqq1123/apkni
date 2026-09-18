







def_class("UIXianJieChengJiu",UIWindowBase)









function UIXianJieChengJiu:bindComponents()

self.Content=UIObject.get(self,0)
self.itemScroller=UILoopListView.new(self,1)
self.title=UIText.get(self,2)

self.itemScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXianJieChengJiu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
self.itemScroller:deleteSelf();self.itemScroller=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIXianJieChengJiu:onLoaded(...)
self:bindComponents()
end


function UIXianJieChengJiu:__delete()
self:unbindComponents()
end
local itemcmp=
{
taskname=0,
yetfinish=1,
itemgoods=2,
getButton=3,

}



function UIXianJieChengJiu:onShow(argtable,afterOnloaded)
self:refreshWin()
end


function UIXianJieChengJiu:onHide()

end


function UIXianJieChengJiu:refreshWin()

self:getDataList()
local createCount=#self.datalist+#self.finishlist
local createList={}
for i=1,createCount do
createList[#createList+1]=i
end
self.itemScroller:initData('XJchengjiuItem',createList)

end

function UIXianJieChengJiu:onFreshAction(i,widget,data)
local taskdata=self.datalist[i]
local t_taskstate=nil
local taskprogress=0
local cfg=nil
if taskdata then
t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
taskprogress=taskdata.taskprogress
cfg=taskdata.cfg
else
local taskdata=self.finishlist[i-#self.datalist]
t_taskstate=taskModel.taskFinishState

cfg=taskModel:getTaskConfig(taskdata)
taskprogress=cfg.aimnum

end

local desc=cfg.taskaimdesc
local str=FMT.fmt("{0}<color=#549327>（{1}/{2}）</color>",desc,taskprogress,cfg.aimnum)
if taskprogress<cfg.aimnum then
str=FMT.fmt("{0}<color=#c82c2c>（{1}/{2}）</color>",desc,taskprogress,cfg.aimnum)
end


widget:SetChildText(itemcmp.taskname,str)
widget:SetChildActive(itemcmp.yetfinish,t_taskstate==taskModel.taskFinishState)
widget:SetChildActive(itemcmp.getButton,t_taskstate==taskModel.taskRewardState)
widget:SetChildButtonClick(itemcmp.getButton,function()
taskController:reqTaskReward(cfg.id,0)
end)

local item=widget:GetChildWidgetBase(itemcmp.itemgoods)
local reward=cfg.taskReward[1]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

function UIXianJieChengJiu:onStartAction()

end

function UIXianJieChengJiu:getDataList()

self.datalist,self.finishlist=taskModel:GetAllChengjiu()
self:SortDataList()
end
function UIXianJieChengJiu:SortDataList()

for k,v in ipairs(self.datalist)do
local taskstate=taskModel:getTaskState_transfromstate(v)
self.datalist[k].sort=taskstate*1000
end
table.sort(self.datalist,function(a,b)
if a.sort==b.sort then
return a.taskline<b.taskline
else
return a.sort>b.sort
end
end)
table.sort(self.finishlist,function(a,b)
return a>b
end)
end
function UIXianJieChengJiu:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})

end

function UIXianJieChengJiu:onClickClose()

self:closeSelf()
end



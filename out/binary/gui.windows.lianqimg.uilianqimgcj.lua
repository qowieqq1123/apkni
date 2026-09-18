







def_class("UILianQiMGCJ",UIWindowBase)









function UILianQiMGCJ:bindComponents()

self.root=UIObject.get(self,0)
self.scrollView=UIObject.get(self,1)
self.time=UIText.get(self,2)



end


function UILianQiMGCJ:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.time);self.time=nil;
end
















local _itemIndex={
desc=0,
count=1,
gotoBtn=2,
receiveBtn=3,
flag=4,
rwItems={5,6}
}




function UILianQiMGCJ:onLoaded(...)
self:bindComponents()

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)

self.scrollView:setChildScrollViewInit(0,true,nil,nil)
end


function UILianQiMGCJ:__delete()
self:unbindComponents()
end




function UILianQiMGCJ:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId

self:refresh()
self:setEndTimeTips()
end


function UILianQiMGCJ:onHide()

end

function UILianQiMGCJ:setEndTimeTips()
if not self.nTimer then
local time=gameUtilityModel.getServerShortTime()
local etime=(math.floor(time/86400)+1)*86400


local tick=function()
time=gameUtilityModel.getServerShortTime()
local dt=etime-time
if dt<0 then


etime=(math.floor(time/86400)+1)*86400
else
self.time:setText(FMT.fmt('炼器成就重置倒计时：<color=#c82c2c>{0}</color>',timeHelper.format_time_stamp11(dt,true)))
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
end

function UILianQiMGCJ:getDatas()
local info=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
local taskData=info.taskData
local list={}
for k,v in pairs(taskData)do
local data={}
data.data=v
if v.flag==2 then
data.sv=10000
elseif v.flag<2 then
data.sv=1000
else
data.sv=100
end
table.insert(list,data)
end
table.sort(list,function(a,b)
if a.sv>b.sv then
return true
elseif a.sv==b.sv then
return a.data.taskId<b.data.taskId
else
return false
end
end)
return list
end

function UILianQiMGCJ:refresh()
local taskData=self:getDatas()
local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,self.subId)
local tasks=cfg.tasks
local len=#taskData
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tdata=taskData[i].data
local data=tasks[tdata.taskId]
local desc=data[6]
local progress=tdata and tdata.progress or 0
local flag=tdata and tdata.flag or 1
item:SetChildText(_itemIndex.desc,desc)
local color=progress>=data[1]and'#549327'or'#c82c2c'
local countText=FMT.fmt('<color={2}>({0}/{1})</color>',progress,data[1],color)
item:SetChildText(_itemIndex.count,countText)
local check1=flag<2
local check2=flag==2
local check3=flag==3
item:SetChildActive(_itemIndex.gotoBtn,check1)
item:SetChildActive(_itemIndex.receiveBtn,check2)
item:SetChildActive(_itemIndex.flag,check3)
local rewards=data[2]
for j=1,2 do
local index=_itemIndex.rwItems[j]
local rd=rewards[j]
if rd then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,rd)
else
item:SetChildActive(index,false)
end
end
if check1 then
item:SetChildButtonClick(_itemIndex.gotoBtn,function()
self:onCloseClick()
end)
end
if check2 then
item:SetChildButtonClick(_itemIndex.receiveBtn,function()
self:receiveAll(taskData)
end)
end
end
end

function UILianQiMGCJ:receiveAll(taskData)
local list={}
for k,v in pairs(taskData)do
if v.data.flag==2 then
table.insert(list,v.data.taskId)
end
end
if#list>0 then
self:callActivityFunc('reqReceive',list)
end
end

function UILianQiMGCJ:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_lianqidahui',fname,self.actId,self.subId,...)
end




function UILianQiMGCJ:onCloseClick()
self:closeSelf()
end
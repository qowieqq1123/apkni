







def_class("UIXianjieXSselectWin",UIWindowBase)









function UIXianjieXSselectWin:bindComponents()

self.root=UIObject.get(self,0)
self.sureBtn=UIButton.get(self,1)
self.taskScrollerView=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianjieXSselectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.taskScrollerView);self.taskScrollerView=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this
local abname="ui/windows/xuanshang/xianjiexuanshang_atlas_pak.ab"
local taskitem=
{
selfitem=0,
root=1,
icon=2,
name=3,
btn=4,
rwscrollview=5,
select=6,

rwScrollView=11,
rwScrollView2=12,
rwItemlist={13,14,15},
backimg=16,
}



function UIXianjieXSselectWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectid=0
self.selecttaskid=0
end


function UIXianjieXSselectWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianjieXSselectWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.taskIndex=argtable.taskIndex
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5728,1,nil,eAnimationID.stand)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.oldtaskId=nil
local old=XianjieXuanShangModel:getTaskDataSinglebyIndex(self.taskIndex)
if old and old.taskId then
self.oldtaskId=old.taskId
end
self.defaultVersionId=pfwindowslController:getGameVersion()
self.pfid=loginModel:getPfid()
self:initinfo()
end


function UIXianjieXSselectWin:onHide()

end


function UIXianjieXSselectWin:oncloseClick()
self:closeSelf()
end
function UIXianjieXSselectWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eCenter})
end
end


function UIXianjieXSselectWin:onSureBtn()
if self.selecttaskid==0 then
UIManager.info("请先选择一个任务")
return
end
self:showWindow('UIXianjieXSzongmenWin',{parentWin=self.parentWin,taskIndex=self.taskIndex,taskId=self.selecttaskid})
end

function UIXianjieXSselectWin:onChooseBtn(index,taskid,_tdflag)
if _tdflag then
UIManager.info("该任务今日已完成")
return
end
if self.selectid==index then
return
end
local oldselect=self.selectid
self.selectid=index
self.selecttaskid=taskid
local grids=self.taskScrollerView:getChildScrollViewItemWidgets()
if grids then
if oldselect>0 then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(taskitem.select,false)
end
end
local newitem=grids[self.selectid-1]
if newitem then
newitem:SetChildActive(taskitem.select,true)
end
end
end


function UIXianjieXSselectWin:getTaskList()
local list={}
local taskcfg=cfg_xianjiexuanshangtaskconfig()
local checktype=XianjieXuanShangController:getTaskTypeDoing()
local checkid=XianjieXuanShangController:getTaskidDoing()
for k,v in pairs(taskcfg)do
if not checktype[v.taskType]then
if self.oldtaskId and self.oldtaskId==v.id then
table.insert(list,v.id)
else
if not checkid[v.id]then
table.insert(list,v.id)
end
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a<b
end)
end
return list
end


function UIXianjieXSselectWin:initinfo()
local littlelvl=LittleWorldModel:getLittleWorldLevel()
local taskids=self:getTaskList()
local len=#taskids
self.taskScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.taskScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local taskid=taskids[i]
local cfg_task=cfg_xianjiexuanshangtaskconfig_get(taskid)
item:SetChildText(taskitem.name,cfg_task.name)
item:SetChildCSImageSprite(taskitem.icon,abname,cfg_task.icon)

local _tdflag=XianjieXuanShangModel:checkDoneToday(taskid)

if _tdflag then
item:SetChildActive(taskitem.backimg,true)
else
item:SetChildActive(taskitem.backimg,false)
if self.selectid==0 then
self.selectid=i
end
end

item:SetChildActive(taskitem.select,self.selectid==i)
if self.selectid==i then
self.selecttaskid=taskid
end


local _rewardList=XianjieXuanShangController:checkOrderPT(cfg_task.rewardList,self.defaultVersionId,self.pfid)
local flag=_rewardList[littlelvl][1][1]
if flag==2 then
item:SetChildActive(taskitem.rwScrollView,false)
item:SetChildActive(taskitem.rwScrollView2,false)
elseif flag==1 then
item:SetChildActive(taskitem.rwScrollView,false)
item:SetChildActive(taskitem.rwScrollView2,false)


local rwlist=_rewardList[littlelvl][1][2]
local len2=#rwlist
if len2>3 then
item:SetChildActive(taskitem.rwScrollView,true)
for idx=1,len2 do
local index=6+idx
item:SetChildActive(index,true)
local data=rwlist[idx]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(index,prop)
item:SetBaseItemClickEvent(index,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
else
item:SetChildActive(taskitem.rwScrollView2,true)
for idx=1,len2 do
local widget=item:GetChildWidgetBase(taskitem.rwItemlist[idx])
local data=rwlist[idx]
if data then
widget:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(1,prop)
widget:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
end
end
end

item:SetChildButtonClick(taskitem.btn,function()
if _this==nil then return end
self:onChooseBtn(i,taskid,_tdflag)
end)
end
end
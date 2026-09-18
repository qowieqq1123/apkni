







def_class("UIGuanZhuActWin",UIWindowBase)









function UIGuanZhuActWin:bindComponents()

self.Root=UIObject.get(self,0)
self.taskroot=UIObject.get(self,1)
self.tasklist=UIScrollView.get(self,2)
self.biaoyu=UIImage.get(self,3)
self.bgspine=UIObject.get(self,4)



end


function UIGuanZhuActWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.taskroot);self.taskroot=nil;
_UIObject_release(self.tasklist);self.tasklist=nil;
_UIObject_release(self.biaoyu);self.biaoyu=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
end
















local _this

local CmpTaskItemIndex={
bg=0,
title=1,
rewardlist=2,
btn=3,
btntxt=4,
reddot=5,
receiveimg=6,
}

local subPanel={
'UIGaunZhuWechatGuideWin'
}




function UIGuanZhuActWin:onLoaded(...)
self:bindComponents()
_this=self

local bindFunc=function(...)
self:bindTaskWidget(...)
end
self.tasklist:bindScrollWidget(bindFunc)
end


function UIGuanZhuActWin:__delete()
self:unbindComponents()
end




function UIGuanZhuActWin:onShow(argtable,afterOnloaded)
self:initData()
self:initUI()







welfareModel:setOneGuanZhuReddot()
end


function UIGuanZhuActWin:onHide()

end

function UIGuanZhuActWin:onShowArgRecv(args)
self:initUI()
end


function UIGuanZhuActWin:initData()
local gameVersion=pfwindowslController:getGameVersion()
self.config=cfgHelper.get(cfg_guanzhuactconfig_get,gameVersion)
self.lihuiAB=self.config.ab
self.lihuiName=self.lihuiname

self.taskDatas={}
self.taskLen=#(self.config.tasks or{})
self.localGuanZhuList=welfareModel:getLocalGuanZhuVisitList()

for index,taskcfg in ipairs(self.config.tasks or{})do
local taskData={}

taskData.taskId=taskcfg[1]
taskData.tasktitile=taskcfg[2]
taskData.taskGiftId=taskcfg[3]
taskData.taskWebURL=taskcfg[4]
taskData.finishBtnTxt=taskcfg[5]

taskData.state=0


local isCanGetGift=FreeGiftController.GetFreeGift(taskData.taskGiftId,nil)

local isVisit=(self.localGuanZhuList[taskData.taskId]or 0)==1

if not isCanGetGift and isVisit then
taskData.state=2
elseif isVisit then
taskData.state=1
end
self.taskDatas[index]=taskData
end
end

function UIGuanZhuActWin:initUI()

self.biaoyu:setCSImageSprite(self.config.slogan[1],self.config.slogan[2])


self.tasklist:freshGridsNum(self.taskLen,self.taskLen,1,not self.taskListZero)
self.taskListZero=true

self.tasklist:setChildScrollRectEnable(self.taskLen>3)
end

function UIGuanZhuActWin:bindTaskWidget(index,item)
self:freshSingleTaskItem(index,item)
end

function UIGuanZhuActWin:freshSingleTaskItem(index,item)
local taskData=self.taskDatas[index]


item:SetChildActive(-1,taskData~=nil)

if taskData~=nil then

local title=string.replaceSpace(taskData.tasktitile)
item:SetChildText(CmpTaskItemIndex.title,title)


local btntxt='前往关注'
if taskData.state==1 then
btntxt='领取'
elseif taskData.state==2 then
btntxt=taskData.finishBtnTxt
end
item:SetChildText(CmpTaskItemIndex.btntxt,btntxt)
item:SetChildButtonClick(CmpTaskItemIndex.btn,function()
if taskData.state==1 then

FreeGiftController.SendFreeGift(taskData.taskGiftId,nil,function()
_this:refreshSingleTaskItem(index,item,2)
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end)
else

local stateFunc=function()
_this:setVisitState(index,item,1)
if taskData.state==0 then
_this:refreshSingleTaskItem(index,item,1)
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end
if type(taskData.taskWebURL)=='string'then

LuaApplication.GetApplication().OpenURL(taskData.taskWebURL)
stateFunc()
else
local subWinName=subPanel[taskData.taskWebURL]
_this:showWindow(subWinName,{callback=stateFunc})
end

end
end)


local gray=taskData.state==2 and 1 or 0
local rewards=cfgHelper.get2(cfg_freegiftconfig_get,taskData.taskGiftId,'rewards')

local propDatas={}
for k,v in ipairs(rewards)do
local itemid=v[1]
local itemcount=v[2]
local propData=itemsComponentHelper.getCommonFillData({itemid=itemid,itemcount=itemcount},{showname=false,nomalname=false,showcount=itemcount>1,showCountBG=itemcount>1,gray=gray})
table.insert(propDatas,propData)
end
item:SetChildUIBaseScrollClickAction(CmpTaskItemIndex.rewardlist,itemsComponentHelper.onItemClick)
item:SetChildUIBaseScrollGridsByNum(CmpTaskItemIndex.rewardlist,#rewards,1,#rewards,false)
item:SetChildUIBaseScrollPropData(CmpTaskItemIndex.rewardlist,propDatas)


local isShowReddot=taskData.state==1
item:SetChildActive(CmpTaskItemIndex.reddot,isShowReddot)
item:SetChildActive(CmpTaskItemIndex.receiveimg,taskData.state==2)
end
end

function UIGuanZhuActWin:refreshSingleTaskItem(index,item,state)
self.taskDatas[index].state=state
self:freshSingleTaskItem(index,item)
end

function UIGuanZhuActWin:setVisitState(index,item,state)
local data=self.taskDatas[index]
if(self.localGuanZhuList[data.taskId]or 0)~=state then
self.localGuanZhuList[data.taskId]=state
welfareModel:setLocalGuanZhuVisitList(self.localGuanZhuList)
end
end


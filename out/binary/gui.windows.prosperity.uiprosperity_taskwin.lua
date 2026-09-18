







def_class("UIProsperity_TaskWin",UIWindowBase)









function UIProsperity_TaskWin:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.taskScrollView=UIScrollView.get(self,2)
self.closeBtn=UIButton.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIProsperity_TaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local _this

local CmpTaskItemIndex={
name=0,
rewardBtn=1,
rewardText=2,
gotFlag=3,
itemList=4,
}




function UIProsperity_TaskWin:onLoaded(...)
self:bindComponents()

_this=self

self.taskScrollView:bindScrollWidget(function(...)self:bindLevelTaskItem(...)end)

self:addNotify(notifyConfig.onProsperityLevelChange,function(...)self:onProsperityLevelChange(...)end)
end


function UIProsperity_TaskWin:__delete()
self:unbindComponents()

_this=nil
end




function UIProsperity_TaskWin:onShow(argtable,afterOnloaded)
self:initData()
self:initUI()
end


function UIProsperity_TaskWin:onHide()

end

function UIProsperity_TaskWin:initData()
self.taskList={}

local allTaskCfg=cfg_guildabundancelvconfig()

self.jumpid=1

for index,taskCfg in ipairs(allTaskCfg)do

local isCanReceive,isReceived=prosperityModel:checkLevelTaskReceiveState(taskCfg.id)
table.insert(self.taskList,{cfg=taskCfg,isCanReceive=isCanReceive,isReceived=isReceived})

if isReceived then
self.jumpid=index+1
end
end
end

function UIProsperity_TaskWin:initUI()
local len=#self.taskList
self.taskScrollView:freshGridsNum(len,len,1,not self.taskScrollViewZero)
self.taskScrollViewZero=true

if self.jumpid~=1 then
self.taskScrollView:jumpToLockX(self.jumpid)
end
end

function UIProsperity_TaskWin:bindLevelTaskItem(index,item)
local data=self.taskList[index]
local curFrdValue=prosperityModel:getTotalFRValue()

local nameStr=FMT.fmt("繁荣等级达到{0}级",data.cfg.id)



item:SetChildText(CmpTaskItemIndex.name,nameStr)

local dataPropList={}
for k,reward in ipairs(data.cfg.rewards)do

local conf={
itemid=reward[1],
itemcount=reward[2]>1 and reward[2]or'',
showCountBG=reward[2]>1,
showname=false
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(dataPropList,prop)
end

item:SetChildLayoutGroupCreateItems(CmpTaskItemIndex.itemList,#dataPropList,function(rindex)
local ritem=item:GetChildLayoutGroupGridItem(CmpTaskItemIndex.itemList,rindex-1)

local propData=dataPropList[rindex]
ritem:SetChildPropData(0,propData)
ritem:SetChildScale(0,Vector3(0.8,0.8,0.8))
ritem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)

local btnStr='未达成'
local btnState=true
local clickFunc=nil
if data.isCanReceive then
btnStr='领取'

clickFunc=function()

end
end

if data.isReceived then
btnState=false
end

item:SetChildActive(CmpTaskItemIndex.rewardBtn,not data.isReceived)
item:SetChildActive(CmpTaskItemIndex.gotFlag,data.isReceived)
item:SetChildText(CmpTaskItemIndex.rewardText,btnStr)
item:SetChildButtonClick(CmpTaskItemIndex.rewardBtn,clickFunc,true)
item:SetChildButtonEnable(CmpTaskItemIndex.rewardBtn,true,not data.isCanReceive)
end


function UIProsperity_TaskWin:onProsperityLevelChange(level)
self:initData()
self:initUI()
end




function UIProsperity_TaskWin:onCloseBtn()
self:closeSelf()
end


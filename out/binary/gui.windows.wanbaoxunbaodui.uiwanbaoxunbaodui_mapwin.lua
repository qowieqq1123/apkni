







def_class("UIWanBaoXunBaoDui_MapWin",UIWindowBase)









function UIWanBaoXunBaoDui_MapWin:bindComponents()

self.Root=UIObject.get(self,0)
self.leftroot=UIObject.get(self,1)
self.advContent=UIObject.get(self,2)
self.countdown=UIText.get(self,3)
self.rightroot=UIObject.get(self,4)
self.conditionContent=UIObject.get(self,5)
self.rewardroot=UIObject.get(self,6)
self.rewardlist=UIScrollView.get(self,7)
self.rewardContent=UIObject.get(self,8)
self.receivebtn=UIButton.get(self,9)
self.closebtn=UIButton.get(self,10)
self.notip=UIText.get(self,11)
self.bgspine=UIObject.get(self,12)

self.receivebtn:setButtonClick(function()self:onReceivebtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIWanBaoXunBaoDui_MapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.leftroot);self.leftroot=nil;
_UIObject_release(self.advContent);self.advContent=nil;
_UIObject_release(self.countdown);self.countdown=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.conditionContent);self.conditionContent=nil;
_UIObject_release(self.rewardroot);self.rewardroot=nil;
_UIObject_release(self.rewardlist);self.rewardlist=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.receivebtn);self.receivebtn=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.notip);self.notip=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
end

















local CmpSlotMapItemIndex={
self=0,
quality=1,
type=2,
}

local CmpSlotConditionItemIndex={
self=0,
titleinfo=1,
conditions=2,
}

local CmpSlotConditionAttrItemIndex={
self=0,
name=1,
info=2,
}

local SlotMapItemAB=""

local SlotConditionAttrHeight=50
local SlotConditionHeightOffset=50

local tanhaolist={
'image_mmtxmapui_2',
'image_mmtxmapui_6'
}




function UIWanBaoXunBaoDui_MapWin:onLoaded(...)
self:bindComponents()
self.mapSelectId=1
self.rewardlist:setClickAction(itemsComponentHelper.onItemClick)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiTakeTask,function(...)self:onWanBaoXunBaoDuiTakeTask(...)end)
self.dwList={}
end


function UIWanBaoXunBaoDui_MapWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_MapWin:onShow(argtable,afterOnloaded)
self.channelId=argtable.channelId
self.Root:setChildCanvasGroupAlpha(0)
self:initUI()
self.bgspine:setChildSpineAnimation(eAnimationID.enter,1,nil)
self:delayDo(0.3,function()
self.Root:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end


function UIWanBaoXunBaoDui_MapWin:onHide()

end





function UIWanBaoXunBaoDui_MapWin:initUI()
self:freshLeftPart()
self:freshRightPart()
end








function UIWanBaoXunBaoDui_MapWin:freshLeftPart()

local advpoints=wanBaoXunBaoDuiModel:getAdvPoints()

if#advpoints>0 then
self.advContent:setChildLayoutGroupCreateItems(#advpoints,function(index)

local advpoint=advpoints[index]

local cfg=cfgHelper.get1(cfg_catmapconfig_get,advpoint.id)

local item=self.advContent:getChildLayoutGroupGridItem(index-1)

local tanhaoIconName=tanhaolist[cfg.tanhaotype]
item:SetChildCSImageSprite(0,globalABLookup.wanbaoxunbaodui,tanhaoIconName)
local randomPoints=cfgHelper.get2(cfg_catmappointconfig_get,cfg.dimao,'pointgroup')
local mapPoint=randomPoints[advpoint.mapPoint]

item:SetBaseItemClickEvent(-1,function()
local preIndex=self.mapSelectId
local preSelectItem=self.advContent:getChildLayoutGroupGridItem(self.mapSelectId-1)

self.mapSelectId=index

preSelectItem:SetChildActive(0,true)
preSelectItem:SetChildActive(1,false)

item:SetChildActive(0,self.mapSelectId~=index)
item:SetChildActive(1,self.mapSelectId==index)
self:startAnimation(preIndex,preSelectItem,true)
self:startAnimation(index,item,true)
self:freshRightPart()
end)

item:SetChildLocalPosition(-1,Vector3(mapPoint[1],mapPoint[2],0))
item:SetChildActive(-1,true)
item:SetChildActive(0,self.mapSelectId~=index)
item:SetChildActive(1,self.mapSelectId==index)

item:SetChildActive(2,deviceHelper.isRunNoneOrEditor())
if deviceHelper.isRunNoneOrEditor()then
item:SetChildText(2,advpoint.id)
end

self:startAnimation(index,item,true)
end)
end


self:freshAdventurePointFreshTime()
end

function UIWanBaoXunBaoDui_MapWin:freshAdventurePointFreshTime()

local lefttime=wanBaoXunBaoDuiModel:getAdventurePointFreshLeftTime()

self.stamp=os.time()+lefttime

self:stopSelfTimer()

local func=function()
if self==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.countdown:setText(FMT.fmt("{0}",timeHelper.format_time_stamp3(left)))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIWanBaoXunBaoDui_MapWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end











function UIWanBaoXunBaoDui_MapWin:freshRightPart()


local advpoints=wanBaoXunBaoDuiModel:getAdvPoints()
local mapPoint=advpoints[self.mapSelectId]
local conditionDatas=wanBaoXunBaoDuiModel:getMapConditionDatasById(mapPoint)





self.conditionContent:setActive(#advpoints>0)
self.rewardroot:setActive(#advpoints>0)
self.notip:setActive(#advpoints==0)
local state=#advpoints>0

if#conditionDatas>0 then
self.conditionContent:setChildLayoutGroupCreateItems(#conditionDatas,function(index)

local conditionData=conditionDatas[index]

local item=self.conditionContent:getChildLayoutGroupGridItem(index-1)

item:SetChildText(CmpSlotConditionItemIndex.titleinfo,conditionData.title)

item:SetChildLayoutGroupCreateItems(CmpSlotConditionItemIndex.conditions,#conditionData.conditions,function(index)

local condition=conditionData.conditions[index]

local citem=item:GetChildLayoutGroupGridItem(CmpSlotConditionItemIndex.conditions,index-1)

citem:SetChildText(CmpSlotConditionAttrItemIndex.name,FMT.fmt("{0}：",condition.name))

citem:SetChildText(CmpSlotConditionAttrItemIndex.info,condition.info)
end)
end)
end

if conditionDatas.state then
local rewardData,rlist=wanBaoXunBaoDuiModel:getAdventurePointReward(mapPoint)
self.rewardContent:setChildLayoutGroupCreateItems(#rewardData,function(index)
local itemReward=self.rewardContent:getChildLayoutGroupGridItem(index-1)
itemReward:SetChildPropData(0,rewardData[index])
itemReward:SetChildActive(1,rlist[index])
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
end
self.receivebtn:setButtonEnable(state,not state)


end

function UIWanBaoXunBaoDui_MapWin:onWanBaoXunBaoDuiTakeTask(channel_id,task_id)
self:onClosebtn()
end




function UIWanBaoXunBaoDui_MapWin:onReceivebtn()
local advpoints=wanBaoXunBaoDuiModel:getAdvPoints()
local mapPoint=advpoints[self.mapSelectId]
wanBaoXunBaoDuiController:reqTakeAdventureTask(mapPoint.id,self.channelId)



end



function UIWanBaoXunBaoDui_MapWin:onClosebtn()

UIFullWanBaoXunBaoDuiController:closeWindow('UIWanBaoXunBaoDui_MapWin')
end

function UIWanBaoXunBaoDui_MapWin:startAnimation(index,item,state)
if self.dwList[index]then
self.dwList[index]:Complete()
self.dwList[index]:Kill()
self.dwList[index]=nil
end
if state then
if index==self.mapSelectId then

item:SetChildRotation(-1,0,0,0)
self.dwList[index]=item:SetChildDOPunchRotation(1,Vector3(0,0,15),2,2,1,function()

end)
else

item:SetChildScale(-1,Vector3.New(0.9,0.9,0.9))
self.dwList[index]=item:SetChildDOScale(0,1.1,1,function()

end)
end
self.dwList[index]:SetEase(_Ease.Linear)
self.dwList[index]:SetLoops(-1,_LoopType.Yoyo)
end
end








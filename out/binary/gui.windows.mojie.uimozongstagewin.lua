







def_class("UIMoZongStageWin",UIWindowBase)









function UIMoZongStageWin:bindComponents()

self.layout=UIObject.get(self,0)
self.mask=UIButton.get(self,1)
self.curValue=UIText.get(self,2)
self.LoopScrollView=UILoopListView.new(self,3)
self.wayTipsItem_1=UIObject.get(self,4)
self.wayTipsItem_2=UIObject.get(self,5)
self.wayTipsItem_3=UIObject.get(self,6)

self.mask:setButtonClick(function()self:onMask()end)

self.LoopScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)self.wayTipsItem={
self.wayTipsItem_1,
self.wayTipsItem_2,
self.wayTipsItem_3,
}



end


function UIMoZongStageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.curValue);self.curValue=nil;
self.LoopScrollView:deleteSelf();self.LoopScrollView=nil;
_UIObject_release(self.wayTipsItem_1);self.wayTipsItem_1=nil;
_UIObject_release(self.wayTipsItem_2);self.wayTipsItem_2=nil;
_UIObject_release(self.wayTipsItem_3);self.wayTipsItem_3=nil;
self.wayTipsItem=nil;
end


















local ItemType={
eIntervalItem=1,
eTitleItem=2,
eWayTipsItem=3,
eStageItem=4,
}

local ItemName={
[ItemType.eIntervalItem]="IntervalItem",
[ItemType.eTitleItem]="titleItem",
[ItemType.eWayTipsItem]="wayTipsItem",
[ItemType.eStageItem]="stageItem",
}

local this

function UIMoZongStageWin:onLoaded(...)
this=self
self:bindComponents()
self.stage=seasonModel:findFirstDoingStage(seasonStageType.eMZHD)
self:addNotify(notifyConfig.onSeasonChange,self.checkRefrshWin)
self:addNotify(notifyConfig.onSeasonStageChange,self.checkRefrshWin)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.checkRefrshWin)
end


function UIMoZongStageWin:__delete()
self:unbindComponents()
this=nil
end




function UIMoZongStageWin:onShow(argtable,afterOnloaded)

if not self.stage then
logErr("找不到魔宗活动 stage")
return
end
local isInit=argtable and argtable.isInit or false
self:initLoopScrollView()
if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
else

self:showHomeBuffPanel()
end
end


function UIMoZongStageWin:onHide()

end

function UIMoZongStageWin:initLoopScrollView()
local curValue=self.stage.score
self.curValue:setText(FMT.fmt("当前决战积分：<color=#549327>{0}</color>",curValue))

local datalist={}
local prefabnameList={}
local cfg=self.stage:getConfig()
local getScoreWayDescList=cfg.getScoreWayDescList
local score=cfg.score
















for i,v in ipairs(self.wayTipsItem)do
if getScoreWayDescList[i]then
v:setActive(true)
local wigdet=v:getWidgetBase()
wigdet:SetChildText(1,getScoreWayDescList[i])
else
v:setActive(false)
end
end

for i,v in ipairs(score[3])do

local stageItemTemp={}
stageItemTemp.itemType=ItemType.eStageItem
stageItemTemp.targetScore=v[1]
stageItemTemp.dropId=v[2]
stageItemTemp.index=i
table.insert(prefabnameList,ItemName[ItemType.eStageItem])
table.insert(datalist,stageItemTemp)
end
self.datalist=datalist
if#datalist>0 then
self.LoopScrollView:initDataEx(prefabnameList,datalist)
else
self.LoopScrollView:initData(nil,nil,0)
end
end
function UIMoZongStageWin:onFreshAction(index,widget,data)
local itemType=data.itemType
if itemType==ItemType.eTitleItem then
widget:SetChildText(1,data.title)
elseif itemType==ItemType.eWayTipsItem then
widget:SetChildText(1,data.tips)
elseif itemType==ItemType.eStageItem then
local curScore=self.stage.score
local over=curScore>=data.targetScore
local cCode=over and"549327"or"F1161F"
widget:SetChildText(1,FMT.fmt("累计获得{0}决战积分 （<color=#{1}>{2}/{3}</color>）",data.targetScore,cCode,curScore,data.targetScore))
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,data.dropId)
local rewards=rwcfg.showItems or{}
self:SetChildLayoutGroup(widget,rewards,2)
local state=self.stage:getMZStageRewardState(data.index,data.targetScore)
widget:SetChildActive(3,state==RewardTempState.eRecved)
widget:SetChildActive(4,state==RewardTempState.eRecv)
if state==RewardTempState.eRecv then
widget:SetChildButtonClick(4,function()
local handle=self.stage.handle
seasonController:send_39_2(handle.id,self.stage.index,3,data.index)
end)
end
end
end

function UIMoZongStageWin:SetChildLayoutGroup(widget,list,cmpIndex)
widget:SetChildLayoutGroupCreateItems(cmpIndex,#list>4 and 4 or#list,function(index)
local item=widget:GetChildLayoutGroupGridItem(cmpIndex,index-1)
local rewardData=list[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)






end)
end

function UIMoZongStageWin:onStartAction()
end

function UIMoZongStageWin:showHomeBuffPanel()
self:clearShowPanelTweener()
local endVal=0
self.winlua:SetChildLocalPosX(self.layout:getID(),-500)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
UIManager:invokeUIMethod("UIXianJieMainWin","hideChatRoot",true)
end


function UIMoZongStageWin:hideHomeBuffPanel()
self:clearShowPanelTweener()
local endVal=-500
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,function()
UIManager:closeWindow("UIMoZongStageWin")
end)
UIManager:invokeUIMethod("UIXianJieMainWin","hideChatRoot",false)
end

function UIMoZongStageWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end

function UIMoZongStageWin.checkRefrshWin()

local stage=seasonModel:findFirstDoingStage(seasonStageType.eMZHD)
if not stage then
this:hideHomeBuffPanel()
else
if stage~=this.stage then

this.stage=stage
this:initLoopScrollView()
else
this:RefrshScrollView()
end
end
end

function UIMoZongStageWin:RefrshScrollView()
local cnt=self.LoopScrollView:getListViewItemShowCount()
for showIndex=1,cnt do
local showItem=self.LoopScrollView:getListViewItemByItemIdx(showIndex)
local dataIndex=showItem.ItemIndex+1

local data=self.datalist[dataIndex]
if data then
self:onFreshAction(showIndex,showItem.Widget,data)
end

end
end






function UIMoZongStageWin:onMask()
self:hideHomeBuffPanel()
end











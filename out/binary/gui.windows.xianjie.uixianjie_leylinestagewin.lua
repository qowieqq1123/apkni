







def_class("UIXianJie_LeyLineStageWin",UIWindowBase)









function UIXianJie_LeyLineStageWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.item_1=UIObject.get(self,2)
self.item_2=UIObject.get(self,3)
self.leftArrow=UIButton.get(self,4)
self.leftArrowImg=UIObject.get(self,5)
self.rightArrow=UIButton.get(self,6)
self.rightArrowImg=UIObject.get(self,7)
self.speakBg=UIObject.get(self,8)
self.speakBtn=UIButton.get(self,9)
self.speakTx=UIText.get(self,10)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.speakBtn:setButtonClick(function()self:onSpeakBtn()end)
self.item={
self.item_1,
self.item_2,
}



end


function UIXianJie_LeyLineStageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.speakBg);self.speakBg=nil;
_UIObject_release(self.speakBtn);self.speakBtn=nil;
_UIObject_release(self.speakTx);self.speakTx=nil;
self.item=nil;
end















local _this=nil
local _itemCmp={
desc=0,
rewards=1,
stage=2,
effect=3
}



function UIXianJie_LeyLineStageWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function UIXianJie_LeyLineStageWin:__delete()
self:unbindComponents()
_this=nil
self:killSpeakTween()
end




function UIXianJie_LeyLineStageWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.entityID=xjClientBuildType.flcbXianYuLingMai
self.config=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.entityID)
self.maxIdx=#self.config.param.fixed_build_conf

local leftIdx=argtable.stage~=nil and argtable.stage>0 and argtable.stage or 1
local rightIdx=leftIdx+1
if leftIdx>=self.maxIdx then
leftIdx=self.maxIdx-1
rightIdx=self.maxIdx
end

self.indexes={leftIdx,rightIdx}

self:refreshArrow()
self:refreshView()
self:doSpeak()
end


function UIXianJie_LeyLineStageWin:onHide()

end




function UIXianJie_LeyLineStageWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_LeyLineStageWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianJie_LeyLineStageWin:onLeftArrow()
if self.indexes[1]>1 then
for i,v in ipairs(self.indexes)do
self.indexes[i]=Mathf.Clamp(v-2,i,self.maxIdx-2+i)
end
self:refreshView()
self:refreshArrow()
self:doSpeak()
self:switchEffect()
end
end


function UIXianJie_LeyLineStageWin:onRightArrow()
if self.indexes[2]<self.maxIdx then
for i,v in ipairs(self.indexes)do
self.indexes[i]=Mathf.Clamp(v+2,i,self.maxIdx-2+i)
end
self:refreshView()
self:refreshArrow()
self:doSpeak()
self:switchEffect()
end
end

function UIXianJie_LeyLineStageWin:onSpeakBtn()
self:doSpeak()
end

function UIXianJie_LeyLineStageWin:onClickItem(stage,itemid,index,guid,attach)
local rStage=xianjieModel:getLeyLineRepairStage()
local rFlag=xianjieModel:getLeyLineRepairFlagEx()
local isFinish=xianjieModel:isLeyLineRepairFinish()
local getted=rFlag>=stage
local canGet=isFinish or rStage>stage
local check,names=xianjieModel:checkLeyLineSeasonStageOpen()
if canGet and not getted and check then
xianjieController:send_35_92(self.entityID)
else
itemsComponentHelper.onItemClickEx(itemid,index,guid,attach)
end
end

function UIXianJie_LeyLineStageWin:refreshArrow()
self.leftArrow:setActive(self.indexes[1]>1)
self.rightArrow:setActive(self.indexes[2]<self.maxIdx)
end

function UIXianJie_LeyLineStageWin:refreshView()
local rStage=xianjieModel:getLeyLineRepairStage()
local rFlag=xianjieModel:getLeyLineRepairFlagEx()
local isFinish=xianjieModel:isLeyLineRepairFinish()
local name=self.config.name
local check,names=xianjieModel:checkLeyLineSeasonStageOpen()

for i,v in ipairs(self.item)do
local widget=v:getChildWidgetBase()
local stage=self.indexes[i]

widget:SetChildText(_itemCmp.desc,FMT.fmt("完成【{0}】\n阶段{1}修复可获得",name,stage))
widget:SetChildText(_itemCmp.stage,FMT.fmt("阶段{0}",stage))

local rewardDatas=self.config.param.fixed_build_conf[stage][3]
local getted=rFlag>=stage
local canGet=isFinish or rStage>stage

widget:SetChildLayoutGroupCreateItems(_itemCmp.rewards,#rewardDatas,function(index)
local item=widget:GetChildLayoutGroupGridItem(_itemCmp.rewards,index-1)
local data=rewardDatas[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(itemid,index,guid,attach)
self:onClickItem(stage,itemid,index,guid,attach)
end)
item:SetChildActive(1,check and canGet and not getted)
item:SetChildActive(2,getted)
end)
end
end

function UIXianJie_LeyLineStageWin:refreshViewFlag()
local rStage=xianjieModel:getLeyLineRepairStage()
local rFlag=xianjieModel:getLeyLineRepairFlagEx()
local isFinish=xianjieModel:isLeyLineRepairFinish()
local check,names=xianjieModel:checkLeyLineSeasonStageOpen()

for i,v in ipairs(self.item)do
local widget=v:getChildWidgetBase()
local stage=self.indexes[i]
local getted=rFlag>=stage
local canGet=isFinish or rStage>stage

local rewardItems=widget:GetChildLayoutGroupGridList(_itemCmp.rewards)
for i=1,rewardItems.Count do
local item=widget:GetChildLayoutGroupGridItem(_itemCmp.rewards,i-1)
item:SetChildActive(1,check and canGet and not getted)
item:SetChildActive(2,getted)
end
end
end

function UIXianJie_LeyLineStageWin:doSpeak()
self:killSpeakTween()

local lib=self.config.clientParam.stageSpeak
local str=lib[math.random(1,#lib)]

self.speakTx:setChildTrendsTextPlay(str,30,nil)
self.speakBg:setScale(Vector3.zero)
self.winlua:ForceLayoutRect(self.speakBg:getID())

self.speakTween=Lua.SequenceProxy.New()
self.speakTween:AppendInterval(0.2)
self.speakTween:Append(self.speakBg:setChildDOScale(1.2,0.2))
self.speakTween:Append(self.speakBg:setChildDOScale(0.9,0.1))
self.speakTween:AppendInterval(8)
self.speakTween:AppendCallback(function()
self.speakBg:setScale(Vector3.zero)
self.speakTween=nil
end)
end

function UIXianJie_LeyLineStageWin:killSpeakTween()
if self.speakTween and self.speakTween:IsActive()then
self.speakTween:Kill()
self.speakTween=nil
end
end

function UIXianJie_LeyLineStageWin:switchEffect()
for i,v in ipairs(self.item)do
local widget=v:getChildWidgetBase()
widget:SetChildShowEffect(_itemCmp.effect,10413,true)
local rewards=widget:GetChildLayoutGroupGridList(_itemCmp.rewards)
for i=1,rewards.Count do
local rewardItem=rewards[i-1]
rewardItem:SetChildShowEffect(3,10413,true)
end
end
end

function UIXianJie_LeyLineStageWin.onSeasonStageDataChange(season_id,chapter_idx)
if xianjieModel:isLeyLineSeasonStage(season_id,chapter_idx)then
_this:refreshViewFlag()
end
end

function UIXianJie_LeyLineStageWin.onSeasonStageChange(season_id,chapter_idx)
if xianjieModel:isLeyLineSeasonStage(season_id,chapter_idx)then
_this:refreshViewFlag()
end
end
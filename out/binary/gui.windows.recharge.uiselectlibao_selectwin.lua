







def_class("UISelectLiBao_selectWin",UIWindowBase)









function UISelectLiBao_selectWin:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.selectRewardGroup=UIObject.get(self,3)
self.rewardGroup=UIObject.get(self,4)
self.submitBtn=UIButton.get(self,5)
self.cancelBtn=UIButton.get(self,6)
self.npcModel=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.speakText=UIText.get(self,9)
self.bgModel=UIObject.get(self,10)
self.selectTipsText=UIText.get(self,11)
self.root=UIObject.get(self,12)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.submitBtn:setButtonClick(function()self:onSubmitBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISelectLiBao_selectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.selectRewardGroup);self.selectRewardGroup=nil;
_UIObject_release(self.rewardGroup);self.rewardGroup=nil;
_UIObject_release(self.submitBtn);self.submitBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.selectTipsText);self.selectTipsText=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this




function UISelectLiBao_selectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISelectLiBao_selectWin:__delete()
_this=nil
if self.needRefreshLiBao then

local libaoId=self.libaoId
UIManager:invokeUIMethod("UISelectLiBaoWin","refreshLiBaoItemByLibaoId",libaoId)

reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end
self:clearSpeakTimer()
self:unbindComponents()
end




function UISelectLiBao_selectWin:onShow(argtable,afterOnloaded)
self.libaoId=argtable.libaoId
local selectItemId=argtable.selectItemId
local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(self.libaoId)
self.defaultRewardCount=#defaultReward
self.selectRewardCount=#canSelectReward-self.defaultRewardCount
self.selectReward=selectReward
self.canSelectReward=canSelectReward
self.needRefreshLiBao=false

if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5475,1,{},eAnimationID.enter)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
if not _this then
return
end
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end

self.selectIdx=argtable and argtable.selectIdx or 1

local cfg=cfgHelper.get(cfg_customizedgiftconfig_get,self.libaoId)
local name=cfg.name
self.title:setText(name)

if selectItemId then
local tmpIndex=self.defaultRewardCount+self.selectIdx
for i,item in pairs(self.canSelectReward[tmpIndex])do
if item.itemId==selectItemId then
self.selectReward[self.selectIdx]=item
break
end
end
end

self:refreshSelectRewardList()


self:refreshCanSelectRewardList()


self:refreshNPCModel()
end


function UISelectLiBao_selectWin:onHide()
self:clearSpeakTimer()
end


function UISelectLiBao_selectWin:refreshSelectRewardList()
self.selectRewardGroup:setChildLayoutGroupCreateItems(self.selectRewardCount,function(index)
local item=self.selectRewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=self.selectReward[index]
item:SetChildActive(-1,true)
local isSelect=self.selectIdx==index
item:SetChildActive(5,isSelect)
if reward then
local itemid=reward.itemId
local itemcount=reward.itemCount
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildActive(0,true)
item:SetChildActive(2,false)

else
item:SetChildActive(0,false)
item:SetChildActive(2,true)

end
item:SetChildButtonClick(3,function()
self:selectItemGrid(index)
end,true)
end)

local selectCount=0
for i=1,self.selectRewardCount do
local reward=self.selectReward[i]
if reward then
selectCount=selectCount+1
end
end

self.selectTipsText:setText(FMT.fmt("点击选择心仪的奖励（{0}/{1}）",selectCount,self.selectRewardCount))
end

function UISelectLiBao_selectWin:refreshCanSelectRewardList()
local gridIndex=self.selectIdx
local tmpIndex=self.defaultRewardCount+self.selectIdx
local canSelectRewardList=self.canSelectReward[tmpIndex]
local canSelectRewardCount=#canSelectRewardList
local originalList_lookup=rechargeModel:getSelectLiBaoCanSelectRewardsData(self.libaoId,tmpIndex)
local hasOriginal=originalList_lookup~=nil and next(originalList_lookup)~=nil
local isEmptyGrid=self.selectReward[gridIndex]==nil
local selectRewardItem=self.selectReward[gridIndex]


rechargeModel:setSelectLiBaoCanSelectRewardsData(self.libaoId,tmpIndex,canSelectRewardList)
self.rewardGroup:setChildLayoutGroupCreateItems(canSelectRewardCount,function(index)
local item=self.rewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=canSelectRewardList[index]
local itemid=reward.itemId
local isSelect=not isEmptyGrid and selectRewardItem.itemId==itemid or false
local itemcount=reward.itemCount
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isSelect
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onSelectReward(gridIndex,index)
end)


item:SetBaseItemLongTouchEvent(0,function(...)
self:onClickRewardItem(...)
end)

local isNew=false
if not isEmptyGrid and hasOriginal then
if not originalList_lookup[itemid]then
isNew=true
else
local originalItem=originalList_lookup[itemid]
if originalItem.itemCount~=itemcount then
isNew=true
end
end
end
if isNew then
self.needRefreshLiBao=true
end
item:SetChildActive(2,isNew)

item:SetChildActive(3,isSelect)
end)
end

function UISelectLiBao_selectWin:selectItemGrid(index)
if self.selectIdx==index then
return
end

self.selectIdx=index

self:refreshSelectRewardList()


self:refreshCanSelectRewardList()
end

function UISelectLiBao_selectWin:onSelectReward(gridIndex,index)
local tmpIndex=self.defaultRewardCount+gridIndex
local canSelectRewardList=self.canSelectReward[tmpIndex]
local item=canSelectRewardList[index]
self.selectReward[gridIndex]=item

local emptyGridIndex=self:getNextEmptyGridIndex()
if emptyGridIndex then

self:selectItemGrid(emptyGridIndex)
else

self:refreshSelectRewardList()

self:refreshCanSelectRewardList()
end
end

function UISelectLiBao_selectWin:getNextEmptyGridIndex()
local nowIndex=self.selectIdx
local maxIndex=self.selectRewardCount
if nowIndex<maxIndex then

for i=nowIndex+1,maxIndex do
if not self.selectReward[i]then
return i
end
end
end


for i=1,nowIndex do
if not self.selectReward[i]then
return i
end
end
end


function UISelectLiBao_selectWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
local cfg=cfgHelper.get1(cfg_customizedgiftshowconfig_get,1)
self.speakContent=cfg.npcTalkLib
local npcModelParms=cfg.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=cfg.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=cfg.npcTalkTime
self.npcTalkShowTime=cfg.npcTalkShowTime


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UISelectLiBao_selectWin:doSpeaking()
self:clearSpeakTimer()
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)

self:doTalkAnim()
end


function UISelectLiBao_selectWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end


function UISelectLiBao_selectWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)


self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end




function UISelectLiBao_selectWin:onMask()
self:onCloseBtn()
end



function UISelectLiBao_selectWin:onCloseBtn()
self:closeSelf()
end

function UISelectLiBao_selectWin:onSubmitBtn()

local libaoId=self.libaoId
for gridIndex,item in pairs(self.selectReward)do
rechargeModel:setSelectLiBaoSelectReward(libaoId,gridIndex,item)
end
self.needRefreshLiBao=true

self:onCloseBtn()
end

function UISelectLiBao_selectWin:onCancelBtn()
self:onCloseBtn()
end


function UISelectLiBao_selectWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISelectLiBao_selectWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end
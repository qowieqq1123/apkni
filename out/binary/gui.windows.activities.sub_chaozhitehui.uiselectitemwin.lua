







def_class("UISelectItemWin",UIWindowBase)









function UISelectItemWin:bindComponents()

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
self.topScrollView=UIObject.get(self,13)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.submitBtn:setButtonClick(function()self:onSubmitBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISelectItemWin:unbindComponents()
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
_UIObject_release(self.topScrollView);self.topScrollView=nil;
end
















local _this




function UISelectItemWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISelectItemWin:__delete()
_this=nil
self:clearSpeakTimer()
self:unbindComponents()
end




function UISelectItemWin:onShow(argtable,afterOnloaded)

















self.submitCallFunc=argtable.submitCallFunc
self.extraParams=argtable.extraParams
self.allSelectList=argtable.allSelectList
self.selectedIndexList=argtable.selectedIndexList
self.selectCnt=#self.allSelectList
if#self.selectedIndexList~=self.selectCnt then
logErr("UISelectItemWin 参数格式不对")
return
end


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


local name=argtable.name
self.title:setText(name)



self:refreshSelectRewardList()


self:refreshCanSelectRewardList()


self:refreshNPCModel()
end


function UISelectItemWin:onHide()
self:clearSpeakTimer()
end


function UISelectItemWin:refreshSelectRewardList()
self.selectRewardGroup:setChildLayoutGroupCreateItems(self.selectCnt,function(index)
local item=self.selectRewardGroup:getChildLayoutGroupGridItem(index-1)
local selectIndex=self.selectedIndexList[index]
local selectItemList=self.allSelectList[index]
local reward=selectItemList[selectIndex]

item:SetChildActive(-1,true)
local isSelect=self.selectIdx==index
item:SetChildActive(5,isSelect)
if reward then
local itemid=reward[1]
local itemcount=reward[2]
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
for i=1,self.selectCnt do
local selectIndex=self.selectedIndexList[i]
if selectIndex>0 then
selectCount=selectCount+1
end
end

self.selectTipsText:setText(FMT.fmt("点击选择心仪的奖励（{0}/{1}）",selectCount,self.selectCnt))
end

function UISelectItemWin:refreshCanSelectRewardList()

local gridIndex=self.selectIdx
local selectItemList=self.allSelectList[gridIndex]
local selectIndex=self.selectedIndexList[gridIndex]
local isEmptyGrid=selectIndex==0


self.rewardGroup:setChildLayoutGroupCreateItems(#selectItemList,function(index)
local item=self.rewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=selectItemList[index]
local itemid=reward[1]
local isSelect=not isEmptyGrid and selectIndex==index or false
local itemcount=reward[2]
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

item:SetChildActive(2,isNew)

item:SetChildActive(3,isSelect)
end)
end

function UISelectItemWin:selectItemGrid(index)
if self.selectIdx==index then
return
end

self.selectIdx=index

self:refreshSelectRewardList()


self:refreshCanSelectRewardList()
end

function UISelectItemWin:onSelectReward(gridIndex,index)

self.selectedIndexList[gridIndex]=index

local emptyGridIndex=self:getNextEmptyGridIndex()
if emptyGridIndex then


self:selectItemGrid(emptyGridIndex)
else

self:refreshSelectRewardList()

self:refreshCanSelectRewardList()
end
end

function UISelectItemWin:getNextEmptyGridIndex()
local nowIndex=self.selectIdx
local maxIndex=self.selectCnt
if nowIndex<maxIndex then

for i=nowIndex+1,maxIndex do
if self.selectedIndexList[i]==0 then
return i
end
end
end


for i=1,nowIndex do
if self.selectedIndexList[i]==0 then
return i
end
end
end


function UISelectItemWin:refreshNPCModel(isInit)
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


function UISelectItemWin:doSpeaking()
self:clearSpeakTimer()
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)

self:doTalkAnim()
end


function UISelectItemWin:doTalkAnim()
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


function UISelectItemWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)


self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end




function UISelectItemWin:onMask()
self:onCloseBtn()
end



function UISelectItemWin:onCloseBtn()
self:closeSelf()
end

function UISelectItemWin:onSubmitBtn()

if self.submitCallFunc then
self.submitCallFunc(self.allSelectList,self.selectedIndexList,self.extraParams)
end
self:onCloseBtn()
end

function UISelectItemWin:onCancelBtn()
self:onCloseBtn()
end


function UISelectItemWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISelectItemWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end
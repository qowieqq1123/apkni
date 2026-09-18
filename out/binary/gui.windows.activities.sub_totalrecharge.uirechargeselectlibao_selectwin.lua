







def_class("UIRechargeSelectLiBao_selectWin",UIWindowBase)









function UIRechargeSelectLiBao_selectWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.cancelBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.mask=UIButton.get(self,3)
self.npcModel=UIObject.get(self,4)
self.rewardGroup=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.selectRewardGroup=UIObject.get(self,7)
self.selectTipsText=UIText.get(self,8)
self.speakObj=UIObject.get(self,9)
self.speakText=UIText.get(self,10)
self.submitBtn=UIButton.get(self,11)
self.title=UIText.get(self,12)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.submitBtn:setButtonClick(function()self:onSubmitBtn()end)



end


function UIRechargeSelectLiBao_selectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.rewardGroup);self.rewardGroup=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectRewardGroup);self.selectRewardGroup=nil;
_UIObject_release(self.selectTipsText);self.selectTipsText=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.submitBtn);self.submitBtn=nil;
_UIObject_release(self.title);self.title=nil;
end


















local _this


function UIRechargeSelectLiBao_selectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIRechargeSelectLiBao_selectWin:__delete()
self:unbindComponents()
end




function UIRechargeSelectLiBao_selectWin:onShow(argtable,afterOnloaded)

self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id

self.taskIndex=argtable.taskIndex
self.defaultSelect=argtable and argtable.defaultSelect or 1
self.selectIdx=self.defaultSelect
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

local reward=self.config.recharge[self.taskIndex]
self.rewardList=reward[3]


self.canSelectIdxList={}
local selectData=self.activityData:getSelectDataByTaskIndex(self.taskIndex)or{}
for i,v in ipairs(self.rewardList)do
if selectData[i]then
table.insert(self.canSelectIdxList,i,selectData[i])
else
table.insert(self.canSelectIdxList,i,0)
end
end


self.selectCall=argtable.selectCall

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


self.title:setText(self.config.sub_name)


self:refreshSelectRewardList()


self:refreshCanSelectRewardList()


self:refreshNPCModel()
end


function UIRechargeSelectLiBao_selectWin:onHide()

end


function UIRechargeSelectLiBao_selectWin:refreshSelectRewardList()

self.selectRewardGroup:setChildLayoutGroupCreateItems(#self.rewardList,function(index)
local item=self.selectRewardGroup:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardList[index]
local selectIndex=self.canSelectIdxList[index]

local isEmptyGrid=selectIndex==0

if not isEmptyGrid then
local id=reward[1]
local cfg=cfgHelper.get(cfg_rechargeact1selectconfig_get,id,"selectlist")
reward=cfg[selectIndex]
end

item:SetChildActive(-1,true)
local isSelect=self.selectIdx==index
item:SetChildActive(5,isSelect)
if not isEmptyGrid then
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
for i=1,#self.canSelectIdxList do
if self.canSelectIdxList[i]>0 then
selectCount=selectCount+1
end
end

self.selectTipsText:setText(FMT.fmt("点击选择心仪的奖励（{0}/{1}）",selectCount,#self.canSelectIdxList))
end

function UIRechargeSelectLiBao_selectWin:refreshCanSelectRewardList()

local rewardCfg=self.rewardList[self.selectIdx]
local rewardList=cfgHelper.get(cfg_rechargeact1selectconfig_get,rewardCfg[1],"selectlist")


self.rewardGroup:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardGroup:getChildLayoutGroupGridItem(index-1)

local reward=rewardList[index]

local itemid=reward[1]
local isSelect=self.canSelectIdxList[self.selectIdx]==index
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
self:onSelectReward(index)
end)


item:SetBaseItemLongTouchEvent(0,function(...)
self:onClickRewardItem(...)
end)



item:SetChildActive(3,isSelect)
end)
end

function UIRechargeSelectLiBao_selectWin:selectItemGrid(index)
self.selectIdx=index


self:refreshSelectRewardList()


self:refreshCanSelectRewardList()
end

function UIRechargeSelectLiBao_selectWin:onSelectReward(index)

if self.canSelectIdxList[self.selectIdx]==index then
return
end
self.canSelectIdxList[self.selectIdx]=index


local emptyGridIndex=self:getNextEmptyGridIndex()
if emptyGridIndex then

self:selectItemGrid(emptyGridIndex)
else

self:refreshSelectRewardList()

self:refreshCanSelectRewardList()
end
end

function UIRechargeSelectLiBao_selectWin:getNextEmptyGridIndex()
for i,v in ipairs(self.canSelectIdxList)do
if v==0 then
return i
end
end
end


function UIRechargeSelectLiBao_selectWin:refreshNPCModel(isInit)
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


function UIRechargeSelectLiBao_selectWin:doSpeaking()
self:clearSpeakTimer()
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)

self:doTalkAnim()
end


function UIRechargeSelectLiBao_selectWin:doTalkAnim()
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


function UIRechargeSelectLiBao_selectWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)


self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end

function UIRechargeSelectLiBao_selectWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end




function UIRechargeSelectLiBao_selectWin:onCancelBtn()
self:onCloseBtn()
end



function UIRechargeSelectLiBao_selectWin:onCloseBtn()
self:closeSelf()
end



function UIRechargeSelectLiBao_selectWin:onMask()
self:onCloseBtn()
end



function UIRechargeSelectLiBao_selectWin:onSubmitBtn()

if self.selectCall then
self.selectCall(self.canSelectIdxList)
end

self:onCloseBtn()
end


function UIRechargeSelectLiBao_selectWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

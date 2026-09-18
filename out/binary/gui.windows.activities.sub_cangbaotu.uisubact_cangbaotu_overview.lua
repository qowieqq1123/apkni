







def_class("UISubAct_CangBaoTu_OverView",UIWindowBase)









function UISubAct_CangBaoTu_OverView:bindComponents()

self.itemList=UIObject.get(self,0)
self.rewardBg=UIImage.get(self,1)
self.rewardList=UIObject.get(self,2)
self.rewardTx=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.ruleBg=UIImage.get(self,5)
self.ruleDesc=UIText.get(self,6)
self.ruleTips=UIText.get(self,7)
self.spineBg=UIObject.get(self,8)
self.spineBgList=UIObject.get(self,9)
self.spineEffect=UIObject.get(self,10)
self.timeBg=UIImage.get(self,11)
self.timeTx=UIText.get(self,12)
self.titleImg=UIImage.get(self,13)
self.titleImg2=UIImage.get(self,14)
self.titleImg3=UIImage.get(self,15)



end


function UISubAct_CangBaoTu_OverView:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.rewardBg);self.rewardBg=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardTx);self.rewardTx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBg);self.ruleBg=nil;
_UIObject_release(self.ruleDesc);self.ruleDesc=nil;
_UIObject_release(self.ruleTips);self.ruleTips=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.spineBgList);self.spineBgList=nil;
_UIObject_release(self.spineEffect);self.spineEffect=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.titleImg2);self.titleImg2=nil;
_UIObject_release(self.titleImg3);self.titleImg3=nil;
end















local _this=nil
local _itemKid={
root=-1,
button=0,
effect=1,
text=2,
image=3,
}



function UISubAct_CangBaoTu_OverView:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UISubAct_CangBaoTu_OverView:__delete()
if self.youkeList then
for i,v in ipairs(self.youkeList)do

_InstantiateManager.RemoveInstance(self.youkeList[i])
behaviorManager:removeBehaviorTree(self.youkeBt[i])
self.youkeBt[i]=nil
end
end
self:unbindComponents()
_this=nil
self:stopCDTick()

end




function UISubAct_CangBaoTu_OverView:onShow(argtable,afterOnloaded)
self.spineEffect:setActive(true)

if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
if not old then

self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end
if not self.initAiState then
self:initAi()
self.initAiState=true
end
end
end


function UISubAct_CangBaoTu_OverView:onHide()
self.spineEffect:setActive(false)

end

function UISubAct_CangBaoTu_OverView.onSubActivityStateChange(actId,subType,subId,actState)
local enters=_this.argtable.enters
for index,enterInfo in ipairs(enters)do
local actInfo=enterInfo.actInfo
if actInfo and actInfo.actId==actId and actInfo.subType==subType and actInfo.subId==subId then
local item=_this.itemList:getChildLayoutGroupGridItem(index-1)
local gray=actState~=activitiesModel.activityDoingState
item:SetChildGraphicGray(_itemKid.button,gray)
end
end
end



function UISubAct_CangBaoTu_OverView:refreshView()

local bgSpine=self.argtable.bgSpine
if bgSpine then
self.spineBg:setChildUIModelEnableInitUISpinePara(false,true)
self.spineBg:setChildUIModelShowTarget(bgSpine[1],bgSpine[5]or 1,{},bgSpine[2]or 0,false,false,0)
self.winlua:SetChildAnchoredPos(self.spineBg:getID(),bgSpine[3]or 0,bgSpine[4]or 0)
end
local bgSpineList=self.argtable.bgSpineList or{}
self.spineBgList:setChildLayoutGroupCreateItems(#bgSpineList,function(index)
local spineBgItem=self.spineBgList:getChildLayoutGroupGridItem(index-1)
local bgSpine=bgSpineList[index]
spineBgItem:SetChildUIModelEnableInitUISpinePara(0,false,true)
spineBgItem:SetChildUIModelShowTarget(0,bgSpine[1],bgSpine[5]or 1,{},bgSpine[2]or 0,false,false,0)
spineBgItem:SetChildAnchoredPos(0,bgSpine[3]or 0,bgSpine[4]or 0)
end)

local bgSpineEffect=self.argtable.bgSpineEffect
if bgSpineEffect then
self.spineEffect:setChildShowEffect(bgSpineEffect[1]or-1,true)
self.winlua:SetChildAnchoredPos(self.spineEffect:getID(),bgSpineEffect[2]or 0,bgSpineEffect[3]or 0)
self.spineEffect:setScale(Vector3.New(bgSpineEffect[4]or 1,bgSpineEffect[5]or 1,bgSpineEffect[6]or 1))
end

local titleName=self.argtable.title.name
local titleAb="ui/windows/activities/sub_cangbaotu/cangbaotu_title_atlas_pak.ab"
local titlePos=self.argtable.title.pos
self.titleImg:setCSImageSprite(titleAb,titleName)
self.winlua:SetChildAnchoredPos(self.titleImg:getID(),titlePos[1],titlePos[2])

if self.argtable.title2 then
self.titleImg2:setActive(true)
local titleName=self.argtable.title2.name
local titleAb="ui/windows/activities/sub_cangbaotu/cangbaotu_title_atlas_pak.ab"
local titlePos=self.argtable.title2.pos
self.titleImg2:setCSImageSprite(titleAb,titleName)
self.winlua:SetChildAnchoredPos(self.titleImg2:getID(),titlePos[1],titlePos[2])
else
self.titleImg2:setActive(false)
end

if self.argtable.title3 then
self.titleImg3:setActive(true)
local titleName=self.argtable.title3.name
local titleAb="ui/windows/activities/sub_cangbaotu/cangbaotu_title_atlas_pak.ab"
local titlePos=self.argtable.title3.pos
self.titleImg3:setCSImageSprite(titleAb,titleName)
self.winlua:SetChildAnchoredPos(self.titleImg3:getID(),titlePos[1],titlePos[2])
else
self.titleImg3:setActive(false)
end

local ruleInfo=self.argtable.rule
self.ruleBg:setActive(ruleInfo~=nil)

if ruleInfo then
if ruleInfo.image then
self.ruleBg:setSprite(ruleInfo.image[1],ruleInfo.image[2])
end
self.ruleBg:setChildAnchoredPos(ruleInfo.pos[1],ruleInfo.pos[2])
self.ruleBg:setChildSizeDelta(ruleInfo.size[1],ruleInfo.size[2])

self.ruleTips:setText(ruleInfo.title or"活动说明")
self.ruleTips:setChildAnchoredPos(ruleInfo.titlePos[1],ruleInfo.titlePos[2])
self.winlua:SetChildOutlineEnabled(self.ruleTips:getID(),ruleInfo.titleOutline==1)

self.ruleDesc:setText(ruleInfo.content or"")
self.ruleDesc:setChildAnchoredPos(ruleInfo.contentPos[1],ruleInfo.contentPos[2])
self.ruleDesc:setChildSizeDelta(ruleInfo.contentSize[1],ruleInfo.contentSize[2])
end

local entersAlign=self.argtable.entersAlign or 1
local anchorsParam
if entersAlign==1 then

anchorsParam={0.5,0.5,0.5,0.5}
elseif entersAlign==2 then

anchorsParam={0,0.5,0.5,0.5}
elseif entersAlign==3 then

anchorsParam={1,0.5,0.5,0.5}
end


local enters=self.argtable.enters
self.waitShowEnters={}
self.itemList:setChildLayoutGroupCreateItems(#enters,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local enterInfo=enters[index]
item:SetChildAnchors(_itemKid.root,anchorsParam[1],anchorsParam[2],anchorsParam[3],anchorsParam[4])
item:SetChildAnchoredPos(_itemKid.root,enterInfo.pos[1],enterInfo.pos[2])
item:SetChildButtonClick(_itemKid.button,function()
self:onClickEnter(index)
end)
item:SetChildCSImageSprite(_itemKid.button,enterInfo.image[1],enterInfo.image[2])

if enterInfo.effect then
item:SetChildShowEffect(_itemKid.effect,enterInfo.effect,true)
else
item:SetChildShowEffect(_itemKid.effect,-1,false)
end

item:SetChildText(_itemKid.text,enterInfo.text or"")
item:SetChildOutlineEnabled(_itemKid.text,enterInfo.textOutline==1)
if enterInfo.textPos then
item:SetChildAnchoredPos(_itemKid.text,enterInfo.textPos[1],enterInfo.textPos[2])
else
item:SetChildAnchoredPos(_itemKid.text,0,0)
end
if api_Available_SetChildOutlineColor()then
local color=enterInfo.textOutlineColor
color=color and Color.New(color[1]/255,color[2]/255,color[3]/255,color[4]/255)or Color.black
item:SetChildOutlineColor(_itemKid.text,color)
end
if api_Available_SetTextLineSpacing()then
item:SetTextLineSpacing(_itemKid.text,enterInfo.textLineSpacing or 1)
end

if enterInfo.textImage then
item:SetChildCSImageSprite(_itemKid.image,enterInfo.textImage[1],enterInfo.textImage[2])
else
item:SetChildCSImageIcon(_itemKid.image,"",false)
end
local textImagePos=enterInfo.textImagePos or defaultT
item:SetChildAnchoredPos(_itemKid.image,textImagePos[1]or 0,textImagePos[2]or 0)

if enterInfo.show and not self:checkEnterShow(enterInfo.show)then
self.waitShowEnters[index]=enterInfo.show
item:SetChildActive(_itemKid.root,false)
return
end
item:SetChildActive(_itemKid.root,true)
end)
self:refreshEnterGray()

local rewardInfo=self.argtable.reward

if rewardInfo then
self.rewardList:setChildAnchoredPos(rewardInfo.pos[1],rewardInfo.pos[2])
self.rewardList:setChildLayoutGroupCreateItems(#rewardInfo.list,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardId=rewardInfo.list[index]
local conf={itemid=rewardId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildAnchoredPos(-1,(index-1)*90,0)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end)
self.winlua:ForceLayoutRect(self.rewardList:getID())
self.rewardBg:setSprite(rewardInfo.bgImage[1],rewardInfo.bgImage[2])
self.rewardBg:setChildAnchoredPos(rewardInfo.bgPos[1],rewardInfo.bgPos[2])
self.rewardTx:setText(rewardInfo.tipStr or"")
if rewardInfo.tipsPos then
self.rewardTx:setChildAnchoredPos(rewardInfo.tipsPos[1]or 0,rewardInfo.tipsPos[2]or 0)
end
end

local cdInfo=self.argtable.cd

if cdInfo then
self.timeBg:setChildAnchoredPos(cdInfo.pos[1],cdInfo.pos[2])
self.winlua:SetChildOutlineEnabled(self.timeTx:getID(),cdInfo.txOutline==1)
self:startCDTick()
if cdInfo.image then
self.timeBg:setSprite(cdInfo.image[1],cdInfo.image[2])
end
else
self:stopCDTick()
self.timeBg:setActive(false)
end
end

function UISubAct_CangBaoTu_OverView:onClickEnter(index)
local enters=self.argtable.enters
local enterInfo=enters[index]
local actInfo=enterInfo.actInfo
if actInfo then
local subInfo=activitiesModel:getSubActInfo(actInfo.actId,actInfo.subType,actInfo.subId)
if subInfo then
local state=subInfo:getState()
if state==activitiesModel.activityIdleState then
local todayStamp=timeHelper.getTodayZeroStamp()
local startStamp=subInfo.start_time_l
local deltaStamp=startStamp-todayStamp
local deltaDay=deltaStamp/86400
if deltaDay>1 then
UIManager.error(FMT.fmt("{0}天后开启",deltaDay))
return
else
UIManager.error("明天开启")
return
end
elseif state==activitiesModel.activityFinishState then
UIManager.error("活动已结束")
return
end
else
UIManager.error("活动不存在")
return
end
end

if enterInfo.jump then
jumpManager:jump(enterInfo.jump)
end
end

function UISubAct_CangBaoTu_OverView:refreshEnterGray()
local enters=self.argtable.enters
for index,enterInfo in ipairs(enters)do
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local actInfo=enterInfo.actInfo
local gray=false
if actInfo then
local subInfo=activitiesModel:getSubActInfo(actInfo.actId,actInfo.subType,actInfo.subId)
if subInfo then
gray=not subInfo:checkDoing()
else
gray=true
end
end
item:SetChildGraphicGray(_itemKid.button,gray)
end
end

function UISubAct_CangBaoTu_OverView:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_CangBaoTu_OverView:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_CangBaoTu_OverView:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt(self.argtable.cd.str,timeHelper.format_time_stamp3(time)))

if next(self.waitShowEnters)~=nil then
for i,v in ipairs(self.waitShowEnters)do
local item=self.itemList:getChildLayoutGroupGridItem(i-1)
if self:checkEnterShow(v)then
item:SetChildActive(_itemKid.root,true)
self.waitShowEnters[i]=nil
end
end
end
end

function UISubAct_CangBaoTu_OverView:checkEnterShow(shows)
for i,v in ipairs(shows)do
if v[1]==1 then
local nowTime=timeHelper.getServerShortTime()
local params=v[2]
local check=true
for j,w in ipairs(params[1])do
local subActInfo=activitiesModel:getSubActInfo(w[1],w[2],w[3])
if subActInfo then
local passTime=nowTime-subActInfo.start_time
if passTime>=params[2]and(params[3]==nil or params[3]<0 or passTime<params[3])then
check=true
break
else
check=false
end
end
end
if not check then
return false
end
end
end
return true
end




function UISubAct_CangBaoTu_OverView:initAi()
local tran=self.root:getCommonComponent('Transform')
local otherData={
order=2102,
scale=1,
}
if self.sub_actcfg.modelAi then
self.youkeList={}
self.youkeBt={}
for i,v in ipairs(self.sub_actcfg.modelAi)do
local initData=v.args
local pos=v.initpos
local vpos=Vector2.New(pos[1],pos[2])
local btName=v.bt
local bodyid=v.modelid
if v.scale then
otherData.scale=v.scale
end
self.youkeList[i]=uiAIManager:createUIObject('UISubAct_CangBaoTu_OverView',btName,INSTANCE_TYPE.eUIDisciple,bodyid,
tran,vpos,initData,otherData,function(bt)
self.youkeBt[i]=bt

end)
end
end


end

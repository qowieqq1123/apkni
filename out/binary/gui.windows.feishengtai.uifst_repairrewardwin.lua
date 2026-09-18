







def_class("UIFST_repairRewardWin",UIWindowBase)









function UIFST_repairRewardWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.bgmodelb=UIObject.get(self,1)
self.btnClose=UIButton.get(self,2)
self.desc1=UIText.get(self,3)
self.desc2=UIText.get(self,4)
self.desc3=UIText.get(self,5)
self.desc4=UIText.get(self,6)
self.dotweenRoot=UIObject.get(self,7)
self.layout1=UIObject.get(self,8)
self.layout2=UIObject.get(self,9)
self.leftArrow=UIButton.get(self,10)
self.leftArrowImg=UIObject.get(self,11)
self.lefteffect=UIObject.get(self,12)
self.leftjieduan=UIText.get(self,13)
self.npcClicker=UIButton.get(self,14)
self.npcModel=UIObject.get(self,15)
self.rightArrow=UIButton.get(self,16)
self.rightArrowImg=UIObject.get(self,17)
self.righteffect=UIObject.get(self,18)
self.rightjieduan=UIText.get(self,19)
self.root=UIObject.get(self,20)
self.shoper=UIObject.get(self,21)
self.speakObj=UIObject.get(self,22)
self.speakText=UIText.get(self,23)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)



end


function UIFST_repairRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.bgmodelb);self.bgmodelb=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.desc3);self.desc3=nil;
_UIObject_release(self.desc4);self.desc4=nil;
_UIObject_release(self.dotweenRoot);self.dotweenRoot=nil;
_UIObject_release(self.layout1);self.layout1=nil;
_UIObject_release(self.layout2);self.layout2=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.lefteffect);self.lefteffect=nil;
_UIObject_release(self.leftjieduan);self.leftjieduan=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.righteffect);self.righteffect=nil;
_UIObject_release(self.rightjieduan);self.rightjieduan=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shoper);self.shoper=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end


















local _this

function UIFST_repairRewardWin:onLoaded(...)
self:bindComponents()
_this=self
self.bgmodel:setChildUIModelShowTarget(5498,1,nil,eAnimationID.enter)
self.bgmodelb:setChildUIModelShowTarget(5499,1,nil,eAnimationID.enter)
end


function UIFST_repairRewardWin:__delete()
self:unbindComponents()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this=nil
FeiShengTaiModel:refreshFSTHUD()
end




function UIFST_repairRewardWin:onShow(argtable,afterOnloaded)

self.dotweenRoot:setChildCanvasGroupAlpha(0)
self.shoper:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
self.dotweenRoot:setChildCanvasGroupDOFade(1,0.25)
self.shoper:setChildCanvasGroupAlpha(1,0.25)
end)

self.cfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)

self.openflag=true

self.selectindex=1
self.yetid=FeiShengTaiModel:Getyetid()
if self:judeNowReward(self.selectindex)==1 and self:judeNowReward(self.selectindex+1)==1 then
self.selectindex=3
end
self:refreshReward()

local cfg_npcmodelid=2113025
_this.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,0.6,{},eAnimationID.stand,false,true)
self:doSpeaking_player()
self:checkAndShowArrowBtn()
end


function UIFST_repairRewardWin:onHide()

end



function UIFST_repairRewardWin:refreshReward()
local nametexttb=
{
'仙台筑基',
'玉宇耸起',
'篆刻阵纹',
'入神开光',
}
self.yetid=FeiShengTaiModel:Getyetid()
self.FSTstage=FeiShengTaiModel:GetFSTRepair()
local repair_rewards=self.cfg.repair_rewards
local grids=self.layout1:getChildCommonLayoutGroupWidgetList()
local rewardlist=repair_rewards[self.selectindex]
self:Setreward(grids,rewardlist,self.selectindex)
self.desc1:setText("完成【飞升台】")
self.desc2:setText(string.format("修筑阶段<color=#f1ce78>%s</color>可领取",nametexttb[self.selectindex]))
self.leftjieduan:setText(self.selectindex)
self:SetEffectwin(10413,self.lefteffect)

local grids2=self.layout2:getChildCommonLayoutGroupWidgetList()
local rewardlist2=repair_rewards[self.selectindex+1]
self:Setreward(grids2,rewardlist2,self.selectindex+1)
self.desc3:setText("完成【飞升台】")
self.desc4:setText(string.format("修筑阶段<color=#f1ce78>%s</color>可领取",nametexttb[self.selectindex+1]))
self.rightjieduan:setText(self.selectindex+1)
self:SetEffectwin(10413,self.righteffect)
end

function UIFST_repairRewardWin:SetEffectwin(effectid,item,index)
if self.openflag then

else
if index then
item:SetChildShowEffect(index,effectid,true)
else
item:setChildShowEffect(effectid,true)
end
end

end


function UIFST_repairRewardWin:judeNowReward(index)
if self.yetid and self.yetid>=index then

return 1
elseif self.FSTstage and self.FSTstage>=index then

return 2
end

return 3
end
function UIFST_repairRewardWin:Setreward(grids,rewardlist,index)
if not rewardlist then
logErr(string.format("飞升台没有配置阶段%d的奖励",self.selectindex+1))
return
end

local flag=self:judeNowReward(index)
for i=1,grids.Count do
local widget=grids[i-1]
local reward=rewardlist[i]
if reward then
widget:SetChildActive(-1,true)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetChildActive(2,flag==1)
widget:SetChildActive(3,flag==2)
self:SetEffectwin(10413,widget,4)
widget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItemitem(itemid,1,flag)
end)
else
widget:SetChildActive(-1,false)
end
end

end

function UIFST_repairRewardWin:onClickItemitem(itemId,reward_idx,flag)

if flag==2 then
FeiShengTaiController:Send34_47()
else
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
end
end




function UIFST_repairRewardWin:onBtnClose()
self:closeSelf()
end



function UIFST_repairRewardWin:onLeftArrow()
if self.selectindex<=2 then
return
end
self.openflag=false
self.selectindex=self.selectindex-2
self:refreshReward()
self:checkAndShowArrowBtn()
end



function UIFST_repairRewardWin:onNpcClicker()

end



function UIFST_repairRewardWin:onRightArrow()
if self.selectindex>=2 then
return
end
self.openflag=false
self.selectindex=self.selectindex+2
self:refreshReward()
self:checkAndShowArrowBtn()
end


function UIFST_repairRewardWin:checkAndShowArrowBtn()


self.leftArrow:setActive(self.selectindex>2)
self.rightArrow:setActive(self.selectindex<3)
if self.selectindex>2 and not self.showArrowAnim_left then
self.showArrowAnim_left=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
end
if self.selectindex<3 and not self.showArrowAnim_right then
self.showArrowAnim_right=true
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end


function UIFST_repairRewardWin:doSpeaking_player()


local speakList=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'rewardNPC_txt')
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim_player()
end


function UIFST_repairRewardWin:doTalkAnim_player()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween2=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UIFST_repairRewardWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(8,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end
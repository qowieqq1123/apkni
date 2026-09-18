







def_class("UIHuanJingWin",UIWindowBase)









function UIHuanJingWin:bindComponents()

self.clickMask=UIObject.get(self,0)
self.topEffect=UIObject.get(self,1)
self.effectEnterPos=UIObject.get(self,2)
self.mapRoot=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.mask=UIObject.get(self,5)
self.unlockTips=UIText.get(self,6)
self.rwName=UIText.get(self,7)
self.rwLevel=UIText.get(self,8)
self.rwIcon=UIObject.get(self,9)
self.tanhao=UIObject.get(self,10)
self.tanhao1=UIObject.get(self,11)
self.tzValue=UIText.get(self,12)
self.tanhao2=UIObject.get(self,13)
self.map=UIObject.get(self,14)
self.touziBG=UIObject.get(self,15)
self.touZiBtn=UIButton.get(self,16)
self.unlockTipsRoot=UIObject.get(self,17)
self.btnEffect=UIObject.get(self,18)
self.gotoBtnText=UIText.get(self,19)
self.rwBtnBG=UIButton.get(self,20)
self.rewardBtn=UIButton.get(self,21)
self.root=UIObject.get(self,22)
self.helpBtn=UIButton.get(self,23)
self.rwBtnRoot=UIObject.get(self,24)
self.touZiRoot=UIObject.get(self,25)
self.gotoBtn=UIButton.get(self,26)

self.touZiBtn:setButtonClick(function()self:onTouZiBtn()end)

self.rwBtnBG:setButtonClick(function()self:onRwBtnBG()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIHuanJingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.topEffect);self.topEffect=nil;
_UIObject_release(self.effectEnterPos);self.effectEnterPos=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.rwName);self.rwName=nil;
_UIObject_release(self.rwLevel);self.rwLevel=nil;
_UIObject_release(self.rwIcon);self.rwIcon=nil;
_UIObject_release(self.tanhao);self.tanhao=nil;
_UIObject_release(self.tanhao1);self.tanhao1=nil;
_UIObject_release(self.tzValue);self.tzValue=nil;
_UIObject_release(self.tanhao2);self.tanhao2=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.touziBG);self.touziBG=nil;
_UIObject_release(self.touZiBtn);self.touZiBtn=nil;
_UIObject_release(self.unlockTipsRoot);self.unlockTipsRoot=nil;
_UIObject_release(self.btnEffect);self.btnEffect=nil;
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
_UIObject_release(self.rwBtnBG);self.rwBtnBG=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.rwBtnRoot);self.rwBtnRoot=nil;
_UIObject_release(self.touZiRoot);self.touZiRoot=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
end
















local _this

local _level_index={
root=0,
head_bg=1,
head_icon=2,
level_bg=3,
level=4,
model=5,
effect=6,
flag=7,
battle=8,
model_bg=9,
model_bg2=10,
arrow=11,
}




function UIHuanJingWin:onLoaded(...)
self:bindComponents()

self.loadingST={}

self.effectIds={}
self.effectTweeners={}

self.clickMask:setActive(false)

self.topEffect:setChildShowEffect(10200,true)

_this=self
end


function UIHuanJingWin:__delete()
self:unbindComponents()

_this=nil

for k,v in pairs(self.effectIds)do
_InstantiateManager.RemoveInstance(k)
end
self.effectIds=nil
for k,v in pairs(self.effectTweeners)do
v:Kill()
end
self.effectTweeners=nil

UIManager:closeWindow('UIMonsterInfoWin')
end




function UIHuanJingWin:onShow(argtable,afterOnloaded)
self:init()
end

function UIHuanJingWin:refresh()
self:init()
end

function UIHuanJingWin:onShowArgRecv(argtable)
self:setShowEffect(true)
end





































function UIHuanJingWin.on_level_click(id)
local nextLevel=UIHuanJingControl:getNextLevel()

if id<nextLevel then
UIManager.info('关卡已完成')
return
end

local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
local mId=cfg.mon_ids[1][1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local skills=mcfg.showSkills
local rwList=_this:getRewards(cfg.rewards)
local title=UIHuanJingControl:getLevelName('试炼 ',id)






local args={
groupId=mId,
title=title,
name=mcfg.name,
level=_this:getJingJie(mcfg.level),
skills=skills,
rewards=rwList,
desc=mcfg.desc,
active_bg_click=false,
}

if nextLevel==id then
local state=UIHuanJingControl:getLevelReceiveState(nextLevel)
if state==-1 or nextLevel>_this.currLevel then
local isUnlock,tips=UIHuanJingControl:checkAndGetUnlockArgs(id)
if isUnlock then
args.callback=function()
UIHuanJingControl:openFighting(id,0)
end
else
args.challenge_tips=tips
end
else
args.challenge_tips='关卡已挑战'
end
else
if id>nextLevel then
args.challenge_tips='需要完成前置关卡挑战'
else
args.challenge_tips='关卡已挑战'
end
end
UIManager:showWindow('UIMonsterInfoWin',args)
end

function UIHuanJingWin:isMaxLevel()
local nextCfg=cfgHelper.get1(cfg_guanqianewconfig_get,self.currLevel+1)
return not nextCfg
end

function UIHuanJingWin:setGoToBtn()
if self:isMaxLevel()then
self.gotoBtn:setActive(true)
self.helpBtn:setActive(false)
self.gotoBtn:setChildGraphicGray(true,true)
self.gotoBtnText:setText('<size=30>已达</size>\n最高层')
self.btnEffect:setChildShowEffect(10485,false)
return
end
local nextChapter=UIHuanJingControl:getNextChapter()
if nextChapter>self.chapter then
self.gotoBtn:setActive(true)
self.helpBtn:setActive(false)
self.gotoBtnText:setText('<size=30>挑战</size>\n下一层')

self.btnEffect:setChildShowEffect(10485,true)
else
self.gotoBtn:setActive(false)
self.helpBtn:setActive(true)
self.btnEffect:setChildShowEffect(10485,false)
end
end

function UIHuanJingWin:init()
self.chapter=UIHuanJingControl:getChapter()
self.currLevel=UIHuanJingControl:getCurrentLevel()

local isNext=self:setRewardText(self.currLevel)

self.title:setText(FMT.fmt('第{0}层',self.chapter))

local showTZ=systemModel.isOpen(SYSTEM_DEFINE.eGuanQiaInvest)and not self:checkTZFinish()
self.touZiRoot:setActive(showTZ)
if showTZ then
local count,mtype=self:countTZValue()
local investData=UIHuanJingControl:getInvestData()
self.tzValueBG:setActive(count>0 and not investData.paid)
self.tzValue:setText(FMT.fmt('累计可领取<color=#ca631d>{0}{1}</color>',count,moneyModel.getMoneyName(mtype)))
end

local ccfg=cfgHelper.get1(cfg_chapternewconfig_get,self.chapter)
self.winlua:SetChildLoadUIMapDataById(self.map:getID(),self.chapter,-1,self.on_level_click,function(id)
self:initMap(ccfg)
end)

self:refreshRewardReddot(isNext)
self:refreshTZReddot()

self:setGoToBtn()
end

function UIHuanJingWin:countTZValue()
local investData=UIHuanJingControl:getInvestData()
local levelRewards=UIHuanJingControl:getTZRewardList(investData.rechargeId)
local lcfg=cfgHelper.get1(cfg_guanqianewinvestconfig_get,investData.rechargeId)
local currLevel=UIHuanJingControl:getCurrentLevel()
local mtype=lcfg.rw_value[1]
local count=0
for i,v in ipairs(levelRewards)do
if v.level<=currLevel then
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,v.rwId)
local rewards=rwcfg.showItems
for ii,vv in ipairs(rewards)do
if vv[1]==mtype then
count=count+vv[2]
end
end
end
end
return count,mtype
end

function UIHuanJingWin:initMap(ccfg)
local flevel=UIHuanJingControl:getChapterFirstLevel(self.chapter)
for i,v in ipairs(ccfg.guanqia_ids)do
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,v)
local mtype=cfg.mtype or 1
local model=cfg.model and cfg.model[1]
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),v)
local nextId=self.currLevel+1
local showModel=mtype>1
if v<=nextId then
widget:SetChildNewBieComponentId(-1,FMT.fmt('UIHuanJingWin.node.{0}_{1}',self.chapter,v-flevel+1))
widget:SetChildActive(_level_index.root,true)
widget:SetChildText(_level_index.level,FMT.fmt('{0}-{1}',self.chapter,v-flevel+1))
widget:SetChildActive(_level_index.head_bg,mtype==1)
widget:SetChildActive(_level_index.model_bg,mtype==2)
widget:SetChildActive(_level_index.model_bg2,mtype==3)
widget:SetChildActive(_level_index.model,showModel)
local showBattle=showModel and v==nextId
widget:SetChildActive(_level_index.battle,showBattle)
if showBattle then
widget:SetChildUIModelShowTarget(_level_index.battle,4045,1,nil,eAnimationID.stand)
end
local showArrow=not showModel and v==nextId
widget:SetChildActive(_level_index.arrow,showArrow)
if showArrow then
local tween=widget:SetChildDOAnchorPosY(_level_index.arrow,110,1,nil)
tween:SetEase(_Ease.InOutSine)
tween:SetLoops(-1,_LoopType.Yoyo)
end
widget:SetChildActive(_level_index.flag,v<nextId)
if showModel then
local scale=isometricMapSystem:getModelScale(model,true)
local mcfg=cfgHelper.get1(cfg_dbbodyconfig_get,model)
local scaleData=mcfg and mcfg.scales2 and mcfg.scales2[5]

if scaleData then
scale=scale*scaleData[1]
widget:SetChildLocalPos(_level_index.model,scaleData[2],scaleData[3],0)
end
local cmps=cfg.model[2]
widget:SetChildUIModelShowTarget(_level_index.model,model,scale,cmps,eAnimationID.stand)
else

comHelper.setChildModelRawImage_monsterGroup(widget,cfg.mon_ids[1][1],_level_index.head_icon,0,eHeadCenterType.eHead)
end
widget:SetChildShowEffect(_level_index.effect,10059,false)
else
widget:SetChildNewBieComponentId(-1,'')
widget:SetChildActive(_level_index.root,false)
widget:SetChildShowEffect(_level_index.effect,10059,mtype==3)
end
end
self:checkAndPlayEnterAnim()
end

function UIHuanJingWin:checkAndPlayEnterAnim()
local nextId=self.currLevel+1
local level=UIHuanJingControl:getCurrentPlayAnimLevel()
if level==nextId then
return
end
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,nextId)
if not cfg or cfg.chapter_id~=self.chapter then
return
end
UIHuanJingControl:setCurrentPlayAnimLevel(nextId)
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),nextId)
widget:SetChildScale(-1,Vector3.New(0,0,1))
local mtype=cfg.mtype or 1

self:setPlayingState(true)
self:playEnterEffect(nextId,mtype==3,function()

self:setPlayingState(false)
end)
end


function UIHuanJingWin:onHide()
self:setShowEffect(false)
end

function UIHuanJingWin:setShowEffect(bShow)
self.topEffect:setChildShowEffect(10200,bShow)
local nextId=self.currLevel+1
local ccfg=cfgHelper.get1(cfg_chapternewconfig_get,self.chapter)
for i,v in ipairs(ccfg.guanqia_ids)do
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,v)
local mtype=cfg.mtype or 1
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),v)
if v>nextId then
if mtype==3 then
widget:SetChildShowEffect(_level_index.effect,10059,bShow)
end
end
end
end

function UIHuanJingWin:setRewardText(level)
local cfgs=cfg_guanqianewconfig()
local count=0
local itemId
local chapter
for i=level+1,#cfgs do
local cfg=cfgs[i]
count=count+1
if cfg.extra_rewards then
itemId=cfg.show_item
chapter=cfg.chapter_id
break
end
end
if not itemId then
self.rwBtnBG:setActive(false)
self.rewardBtn:setSprite(globalABLookup.global,'button_tyjianglitp_1')
return false
end
self.rwBtnBG:setActive(true)








if chapter~=self.chapter then
self.rwLevel:setText('下一层可领取')
else
self.rwLevel:setText(FMT.fmt('{0}关后可领取',count))
end
local cfg=itemsConfig.getConfig(itemId)
self.rwName:setText(cfg.name)
local icon=iconHelper.getIconName(itemId)
self.rewardBtn:setIcon(icon,true)
return true
end

function UIHuanJingWin:getRewards(drops)
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,drops)
return rwcfg.showItems
end

function UIHuanJingWin:getJingJie(level)
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
return jj_str
end













function UIHuanJingWin:refreshRewardReddot(isNext)
local showRD=UIHuanJingControl:isShowRewardReddot()
local tanhao
if isNext then
tanhao=self.tanhao
self.tanhao:setActive(showRD)
self.tanhao1:setActive(false)
else
tanhao=self.tanhao1
self.tanhao:setActive(false)
self.tanhao1:setActive(showRD)
end
if showRD then
local tweener=self.winlua:SetChildDOPunchRotation(tanhao:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
end

function UIHuanJingWin:refreshTZReddot()
local showRD2=UIHuanJingControl:isShowTouZiReddot()
self.tanhao2:setActive(showRD2)
end



function UIHuanJingWin:playEnterEffect(id,isBoss,callback)
local mtran=self.mapRoot:getCommonComponent('Transform')
local lId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIEffect,mtran,function(eId)
local cmp=_InstantiateManager.GetComponent(eId,'CSGUIWidgetBase')
local spos=self.effectEnterPos:getChildPosition()
cmp:SetChildPosition(-1,spos)
cmp:SetChildShowEffect(0,10203,true)
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),id)
local tpos=widget:GetChildPosition(-1)
local rx=math.random()*4-2
local ry=-2
local tran=_InstantiateManager.GetComponent(eId,'Transform')
self:delayDo(0.5,function()

AudioManager.playAudio(563)
end)
local tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3.New(spos.x+rx,spos.y+ry,0),tpos},1,_pathType.CubicBezier)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()
local lId2=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIEffect,mtran,function(eId2)
cmp:SetChildShowEffect(0,10203,false)
local cmp2=_InstantiateManager.GetComponent(eId2,'CSGUIWidgetBase')
cmp2:SetChildPosition(-1,tpos)
cmp2:SetChildShowEffect(0,isBoss and 10201 or 10202,true)
widget:SetChildDOScale(-1,1,1,nil)
self:delayDo(isBoss and 2 or 1,function()
_InstantiateManager.RemoveInstance(eId)
_InstantiateManager.RemoveInstance(eId2)
end)
if callback then
callback()
end
end)
self.effectIds[lId2]=true
end)
self.effectTweeners[eId]=tweener
end)
self.effectIds[lId]=true
end

function UIHuanJingWin:playChangeChapter(callback)
local cfg=cfgHelper.get1(cfg_chapternewconfig_get,self.chapter)
local len=#cfg.guanqia_ids
local count=len
self:delayDo(0.5,function()

AudioManager.playAudio(562)
end)
self:setTimer(0.5,len,function()
local id=cfg.guanqia_ids[count]
count=count-1
local cb=count==0 and callback
self:playLeaveEffect(id,cb)
end)
end

function UIHuanJingWin:playLeaveEffect(id,callback)
local mtran=self.mapRoot:getCommonComponent('Transform')
local lId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIEffect,mtran,function(eId)
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),id)
local spos=widget:GetChildPosition(-1)
local cmp=_InstantiateManager.GetComponent(eId,'CSGUIWidgetBase')
cmp:SetChildPosition(-1,spos)
cmp:SetChildShowEffect(0,10202,true)
widget:SetChildDOScale(-1,0,0.5,nil)
self:delayDo(1,function()
local lId2=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIEffect,mtran,function(eId2)
local cmp2=_InstantiateManager.GetComponent(eId2,'CSGUIWidgetBase')
cmp2:SetChildPosition(-1,spos)
cmp2:SetChildShowEffect(0,10203,true)
local tpos=self.effectEnterPos:getChildPosition()
local rx=math.random()*4-2
local ry=2
local tran=_InstantiateManager.GetComponent(eId2,'Transform')
local tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3.New(spos.x+rx,spos.y+ry,0),tpos},1.5,_pathType.CubicBezier)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()
self:delayDo(1,function()
_InstantiateManager.RemoveInstance(eId)
_InstantiateManager.RemoveInstance(eId2)
if callback then
callback()
end
end)
end)
self.effectTweeners[eId]=tweener
end)
self.effectIds[lId2]=true
end)
end)
self.effectIds[lId]=true
end




function UIHuanJingWin:onGotoBtn()
if self:isMaxLevel()then
UIManager.error('已达最高层')
return
end
local nextChapter=UIHuanJingControl:getNextChapter()
if nextChapter>self.chapter then
local tween=self.gotoBtn:setChildDOScale(0,0.5,nil)
tween:SetEase(_Ease.InBack)

self:setPlayingState(true)
self:playChangeChapter(function()
UIHuanJingControl:setChapter(nextChapter)
self:init()

self:setPlayingState(false)
self.gotoBtn:setScale(Vector3.New(1,1,1))
end)
end
end

function UIHuanJingWin:setPlayingState(bPlaying)
self.isPlaying=bPlaying
self.clickMask:setActive(bPlaying)
end

function UIHuanJingWin:getPlayingState()
return self.isPlaying
end

function UIHuanJingWin:onTouZiBtn()
UIManager:showWindow('UIHuanJingTouZiWin')
end

function UIHuanJingWin:onRewardBtn()
UIManager:showWindow('UIHuanJingRewardWin')
end

function UIHuanJingWin:onRwBtnBG()
UIManager:showWindow('UIHuanJingRewardWin')
end

function UIHuanJingWin:onHelpBtn()
UIManager:showWindow('UIHuanJingHelpWin')
end

function UIHuanJingWin:onCloseClick()

UIHuanJingControl:closeUI(true,true)
end
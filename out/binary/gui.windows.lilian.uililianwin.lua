







def_class("UILiLianWin",UIWindowBase)









function UILiLianWin:bindComponents()

self.yun=UIObject.get(self,0)
self.mapRoot=UIObject.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.rwTextRoot=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.touZiBtn=UIButton.get(self,5)
self.hardBtn=UIButton.get(self,6)
self.normalBtn=UIButton.get(self,7)
self.gotoBtn=UIButton.get(self,8)
self.mask=UIObject.get(self,9)
self.rwText=UIText.get(self,10)
self.rwIcon=UIObject.get(self,11)
self.tanhao=UIObject.get(self,12)
self.gotoBtnText=UIText.get(self,13)
self.unlockTipsRoot=UIObject.get(self,14)
self.tzValueBG=UIObject.get(self,15)
self.tanhao2=UIObject.get(self,16)
self.unlockTips=UIText.get(self,17)
self.map=UIObject.get(self,18)
self.tzValue=UIText.get(self,19)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.touZiBtn:setButtonClick(function()self:onTouZiBtn()end)

self.hardBtn:setButtonClick(function()self:onHardBtn()end)

self.normalBtn:setButtonClick(function()self:onNormalBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)


self.sprite_button_lilianqianwang_2=0
self.sprite_button_lilianqianwang_1=1

end


function UILiLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.yun);self.yun=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rwTextRoot);self.rwTextRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.touZiBtn);self.touZiBtn=nil;
_UIObject_release(self.hardBtn);self.hardBtn=nil;
_UIObject_release(self.normalBtn);self.normalBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.rwText);self.rwText=nil;
_UIObject_release(self.rwIcon);self.rwIcon=nil;
_UIObject_release(self.tanhao);self.tanhao=nil;
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
_UIObject_release(self.unlockTipsRoot);self.unlockTipsRoot=nil;
_UIObject_release(self.tzValueBG);self.tzValueBG=nil;
_UIObject_release(self.tanhao2);self.tanhao2=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.tzValue);self.tzValue=nil;
end
















local _pathType=DG.Tweening.PathType

local _this




function UILiLianWin:onLoaded(...)
self:bindComponents()

_this=self

self.levelSTID={}


end


function UILiLianWin:__delete()
self:unbindComponents()

self:clearAll()

_this=nil
end

function UILiLianWin:clearAll()
self:clearMonster()

if self.moveTweener then
self.moveTweener:Kill()
self.moveTweener=nil
end

if self.mapTweener then
self.mapTweener:Kill()
self.mapTweener=nil
end

if self.thTweener then
self.thTweener:Kill()
self.thTweener=nil
end

if self.thTweener2 then
self.thTweener2:Kill()
self.thTweener2=nil
end

if self.infoHUD then
_InstantiateManager.RemoveInstance(self.infoHUD)
self.infoHUD=nil
end

uiAIManager:clearUIWinData('UILiLianWin')
end




function UILiLianWin:onShow(argtable,afterOnloaded)
self.fastLocateToLevel=true
self:init(argtable)
end

function UILiLianWin:init(argtable)
local args=argtable or{}

self.autoToNext=args.autoToNext
if self.autoToNext then
self.clickGoTO=true
end

self.chapter=UILiLianControl:getChapter()
self.currLevel=UILiLianControl:getCurrentLevel()

self.standLevel=self.currLevel





local ccfg=cfgHelper.get1(cfg_chapterconfig_get,self.chapter)

if self.currLevel<=0 then
self.standChapter=0
else
self.standChapter=UILiLianControl:getChapterById(self.currLevel)
end






if args.standLevel then
self.standLevel=args.standLevel
self.standChapter=UILiLianControl:getChapterById(self.standLevel)
self.clickGoTO=true
end

self.title:setText(FMT.fmt('第{0}章 {1}',self.chapter,ccfg.title))

local bgType=INSTANCE_TYPE[ccfg.bg_type]
self.winlua:SetChildLoadUIMapDataById(self.map:getID(),self.chapter,bgType,self.on_level_click,function(id)
self:initMap(ccfg)
end)

local showTZ=systemModel.isOpen(SYSTEM_DEFINE.eGuanQiaInvest)and not self:checkTZFinish()
self.touZiBtn:setActive(showTZ)
if showTZ then
local count,mtype=self:countTZValue()
local investData=UILiLianControl:getInvestData()
self.tzValueBG:setActive(count>0 and not investData.paid)
self.tzValue:setText(FMT.fmt('累计可领取<color=#ca631d>{0}{1}</color>',count,moneyModel.getMoneyName(mtype)))
end

self:refreshRewardReddot()
self:refreshTZReddot()

self:setRewardText(self.currLevel)
self:setGoTOBtn()
end

function UILiLianWin:initMap(ccfg)

local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),ccfg.st_level-1)
widget:SetChildActive(-1,false)

self:locateToLevel(self.currLevel)

self:createAllMonster()

self:initPlayer()
end

function UILiLianWin:refreshRewardReddot()
local showRD=UILiLianControl:isShowRewardReddot()
self.tanhao:setActive(showRD)







end

function UILiLianWin:refreshTZReddot()
local showRD2=UILiLianControl:isShowTouZiReddot()
self.tanhao2:setActive(showRD2)







end

function UILiLianWin:checkTZFinish()
local investData=UILiLianControl:getInvestData()
local unlock=investData.paid
if not unlock then
return false
end
local levelRewards=UILiLianControl:getTZRewardList(investData.rechargeId)
for i,v in ipairs(levelRewards)do
local complete=UILiLianControl:isLevelComplete(v.level)
if complete then
if not v.receive then
return false
end
else
return false
end
end
return true
end

function UILiLianWin:refresh()
self:clearAll()
self:init()
end

function UILiLianWin:setLevelInfo(hudWidget)
if self.standLevel>0 then
hudWidget:SetChildText(2,UILiLianControl:getLevelName('',self.standLevel))
end
end


function UILiLianWin:onHide()

end

function UILiLianWin:initPlayer()
local dzData=UIDiscipleModel:getPlotDiscipleByIndex(1)
self:createPlayer(dzData.discipleguid,{0,0},function(bt)
self.playerBT=bt
local pos=self.winlua:GetChildUIMapNodeLPositionById(self.map:getID(),self.standLevel)
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildAnchors(index,Vector2.New(0,0.5),Vector2.New(0,0.5))
widget:SetChildAnchoredPosition3D(index,pos)
widget:SetChildActive(2,false)
widget:SetChildUIRoleFlip(index,true)

local head=widget:GetCommonComponent(1,'Transform')
self.infoHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eSimpleInfoHUD,head,function(id)
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
self:setLevelInfo(hudWidget)
hudWidget:SetChildActive(0,self.standChapter==self.chapter)

self:finishCreatePlayer()
end)
end)
end

function UILiLianWin:finishCreatePlayer()
if self.clickGoTO then
self:onGotoBtn()
end
end

function UILiLianWin:createAllMonster()
local tran=self.map:getCommonComponent('Transform')
local cfgs=cfg_guanqiaconfig()
for i,v in ipairs(cfgs)do
if v.chapter_id==self.chapter and v.model then
local state=UILiLianControl:getLevelReceiveState(i)
if state==-1 then
local pos=self.winlua:GetChildUIMapNodeLPositionById(self.map:getID(),i)
self:addAMonster(i,v.model,tran,pos)
local widget=self.winlua:GetChildUIMapNodeIconWidget(self.map:getID(),i)
widget:SetChildActive(-1,false)
end
end
end
end

function UILiLianWin:clearMonster()
for k,v in pairs(self.levelSTID)do
_InstantiateManager.RemoveInstance(v.stId)
if v.hud then
_InstantiateManager.RemoveInstance(v.hud)
end
end
self.levelSTID={}
end

function UILiLianWin:addAMonster(lId,model,parent,pos)
local md={}
md.stId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchors(0,Vector2.New(0,0.5),Vector2.New(0,0.5))
stWidget:SetChildAnchoredPosition3D(0,pos)
local scale=isometricMapSystem:getModelScale(model,true)
scale=scale*0.3
stWidget:SetChildUIModelShowTarget(0,model,scale,nil,eAnimationID.stand)

stWidget:SetChildButtonClick(2,function()
self.on_level_click(lId)
end)

local head=stWidget:GetCommonComponent(1,'Transform')
md.hud=_InstantiateManager.AddInstance(INSTANCE_TYPE.eCommonFlagHUD,head,function(hud)
local hudWidget=_InstantiateManager.GetComponent(hud,'CSGUIWidgetBase')
hudWidget:SetChildButtonClick(1,function()
self.on_level_click(lId)
end)
end)
end)
self.levelSTID[lId]=md
end

function UILiLianWin:setGoTOBtn()
local nextId=UILiLianControl:getNextLevel()
if nextId>self.standLevel then
local isUnlock,tips=self:checkAndGetUnlockArgs(nextId)
local nextChapter=cfgHelper.get2(cfg_guanqiaconfig_get,nextId,'chapter_id')
if nextChapter>self.chapter then
self.gotoBtnText:setText('开启\n下一章')
else
self.gotoBtnText:setText(UILiLianControl:getLevelName('前往\n',nextId))
end
local spIndex=isUnlock and self.sprite_button_lilianqianwang_1 or self.sprite_button_lilianqianwang_2
self.gotoBtn:setImageSprite(spIndex,true)
self.unlockTipsRoot:setActive(not isUnlock)
if not isUnlock then
self.unlockTips:setText(tips)
end
else
local state=UILiLianControl:getLevelReceiveState(nextId)
local spIndex=state==-1 and self.sprite_button_lilianqianwang_1 or self.sprite_button_lilianqianwang_2
self.gotoBtn:setImageSprite(spIndex,true)
self.gotoBtnText:setText('挑战关卡')
self.unlockTipsRoot:setActive(false)
end
end

function UILiLianWin:setRewardText(level)
local cfgs=cfg_guanqiaconfig()
local count=0
local name
local chapter
for i=level+1,#cfgs do
local cfg=cfgs[i]
count=count+1
if cfg.extra_rewards then
name=cfg.rw_name
chapter=cfg.chapter_id
break
end
end
if not name then
self.rwTextRoot:setActive(false)
return
end
self.rwTextRoot:setActive(true)
local rwtext
if chapter~=self.chapter then
rwtext=FMT.fmt('下一章可领取<color=#ca631d>{0}</color>',name)
else
rwtext=FMT.fmt('{0}关后可领取<color=#ca631d>{1}</color>',count,name)
end
self.rwText:setText(rwtext)
end

function UILiLianWin:getJingJie(level)
local n,p,pN=UIDiscipleModel:getJJNameX(level)
local jj_str
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
return jj_str
end

function UILiLianWin:getRewards(drops)
local list={}
for i,v in ipairs(drops)do
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,v)
for ii,vv in ipairs(rwcfg.showItems)do
local c=list[vv[1]]or 0
list[vv[1]]=c+vv[2]
end
end
local rlist={}
for k,v in pairs(list)do
table_insert(rlist,{k,v})
end
return rlist
end

function UILiLianWin:checkAndGetUnlockArgs(id)
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,id)
local ccfg=cfgHelper.get1(cfg_chapterconfig_get,cfg.chapter_id)
for i,v in ipairs(ccfg.conditions)do
if v[1]==1 then
local check=worldBlockModel:checkBlockState(v[2],v[3],eWorldBlockState.OPEN)
if not check then
local name1=cfgHelper.get2(cfg_worldconfig_get,v[2],'name')
local name2=cfgHelper.get3(cfg_worldblockconfig_get,v[2],v[3],'name')
local tips=FMT.fmt('解封<color=#ffbb28>{0}·{1}</color>后开启',name1,name2)
return false,tips
end
end
end
for i,v in ipairs(cfg.conditions)do
if v[1]==1 then
local zmLevel=zongmenModel:getLevel()
if zmLevel<v[2]then
local tips=FMT.fmt('宗门达到{0}级可挑战',v[2])
return false,tips
end
end
end
return true
end

function UILiLianWin.on_level_click(id)
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,id)
local mId=cfg.mon_ids[1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mId)
local skills=mcfg.showSkills
local rwList=_this:getRewards(cfg.rewards)
local title=UILiLianControl:getLevelName('历练 ',id)

if _this.autoToNext then
_this:openFighting(title,mcfg.mapId,mId,mcfg.monList,id)
return
end

local args={
groupId=mId,
title=title,
name=mcfg.name,
level=_this:getJingJie(mcfg.level),
skills=skills,
rewards=rwList,
desc=mcfg.desc,
active_bg_click=true,
}
local nextLevel=UILiLianControl:getNextLevel()
if nextLevel==id then
local state=UILiLianControl:getLevelReceiveState(nextLevel)
if state==-1 then
local isUnlock,tips=_this:checkAndGetUnlockArgs(id)
if isUnlock then
args.callback=function()
_this:openFighting(title,mcfg.mapId,mId,mcfg.monList,id)
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

function UILiLianWin:openFighting(title,mapId,groupId,monList,level)
if self.autoToNext then
local guidList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.tuitu)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end
local zfId=UILiLianControl:getZFID()
fightLaunchController:sendFight(eBattleLaunch.tuitu,team,mapId or 0,zfId,{level})
self:onCloseClick()
return
end
local cfg=cfgHelper.get1(cfg_guanqiaconfig_get,level)
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,cfg.rewards[1])
local standLevel=self.standLevel
fightController.showPrepareWin(fightPreSelectModel.fightType.tuitu,{
enterTxt=title,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isHomeBattle=true,
monsterList=monList,
groupId=groupId,
showRewards=rwcfg.showItems,
enterCallBack=function(guidList,zfId)
UILiLianControl:recordZFID(zfId)
fightLaunchController:sendFight(eBattleLaunch.tuitu,guidList,mapId or 0,zfId,{level})
end,
cancelCallBack=function()
UILiLianControl:showLiLianWindow({standLevel=standLevel})
end,
})
end

function UILiLianWin:createPlayer(dzId,pos,callback)
local initData={
}
local tran=self.map:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local otherData={
scale=0.5,
instanceType=INSTANCE_TYPE.eUIRole,
}
uiAIManager:createUIDisciple('UILiLianWin','bt_ui_lilian_player',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UILiLianWin:locateToLevel(id)
self.winlua:SetChildScrollRectStopMovement(self.mask:getID())
local pos=self.winlua:GetChildUIMapNodeLPositionById(self.map:getID(),id)
if self.fastLocateToLevel then
self.map:setChildAnchoredPosition3D(Vector3.New(-pos.x+612,0,0))
else
self.mapTweener=self.map:setChildDOAnchorPos3D(Vector3.New(-pos.x+612,0,0),0.5,nil)
end
end

function UILiLianWin:movePlayerTo(toLevel,callback)
local widget=self.playerBT:getSharedVar('dzWidget')
local index=self.playerBT:getSharedVar('dzIndex')
local target=widget:GetCommonComponent(index,'Transform')
local path=self.winlua:GetChildUIMapPathDataToNode(self.map:getID(),self.standLevel,toLevel)
widget:SetChildUIRoleFreshToward(index,true)
widget:SetChildModelAnimationState(index,eAnimationID.run)
local length=self.winlua:GetChildUIMapPathLengthByData(self.map:getID(),self.standLevel,path,30)
local time=length/300
self.isMoveing=true
local hudWidget=_InstantiateManager.GetComponent(self.infoHUD,'CSGUIWidgetBase')
hudWidget:SetChildActive(0,false)
self.moveTweener=_DOTweenProxy.DoLocalPath(target,path,time,_pathType.CubicBezier)
self.moveTweener:SetEase(_Ease.Linear)
self.moveTweener:OnComplete(function()
widget:SetChildUIRoleFreshToward(index,false)
widget:SetChildModelAnimationState(index,eAnimationID.stand)
self.standLevel=toLevel
self.isMoveing=false
hudWidget:SetChildActive(0,true)
self:setLevelInfo(hudWidget)
self:setGoTOBtn()
callback()
end)
end

function UILiLianWin:playChangeChapter()


local nextId=UILiLianControl:getNextLevel()
local nextChapter=cfgHelper.get2(cfg_guanqiaconfig_get,nextId,'chapter_id')
local autoToNext=self.autoToNext
local args={
currId=self.chapter,
nextId=nextChapter,
callback=function()
self.autoToNext=autoToNext
self:enter()
end
}
UIManager:showWindow('UILiLianWorldMapWin',args)

self:leave()
end

function UILiLianWin:leave()
local time=0.5
self.mapRoot:setChildDOScale(0.75,time,nil)
self.mapRoot:setChildCanvasGroupDOFade(0,time,nil)
end

function UILiLianWin:enter()
local time=0.5
self.mapRoot:setChildDOScale(1,time,nil)
self.mapRoot:setChildCanvasGroupDOFade(1,time,function()
if self.autoToNext then
self:onGotoBtn()
end
end)
end

function UILiLianWin:countTZValue()
local investData=UILiLianControl:getInvestData()
local levelRewards=UILiLianControl:getTZRewardList(investData.rechargeId)
local lcfg=cfgHelper.get1(cfg_guanqiainvestconfig_get,investData.rechargeId)
local currLevel=UILiLianControl:getCurrentLevel()
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





function UILiLianWin:onGotoBtn()
self.clickGoTO=nil
if self.isMoveing then
return
end
local nextId=UILiLianControl:getNextLevel()

local isUnlock,tips=self:checkAndGetUnlockArgs(nextId)
if isUnlock then
if nextId>self.standLevel then
local nextChapter=cfgHelper.get2(cfg_guanqiaconfig_get,nextId,'chapter_id')
if nextChapter>self.chapter then
self:playChangeChapter()
else
self:locateToLevel(nextId)
self:movePlayerTo(nextId,function()
self.on_level_click(nextId)
end)
end
else
local state=UILiLianControl:getLevelReceiveState(nextId)
if state==-1 then
self.on_level_click(nextId)
else
local nId=cfgHelper.get2(cfg_guanqiaconfig_get,self.standLevel,'next_id')
if nId then
UIManager.error('关卡已挑战')
else
UIManager.error('已通关所有章节')
end
end
end
else
UIManager.error(tips)
end
end

function UILiLianWin:onRewardBtn()
UIManager:showWindow('UILiLianRewardWin')
end

function UILiLianWin:onTouZiBtn()
UIManager:showWindow('UILiLianTouZiWin')
end

function UILiLianWin:onCloseClick()

UILiLianControl:closeUI(true,true)
end
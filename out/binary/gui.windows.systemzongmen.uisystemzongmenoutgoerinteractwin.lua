







def_class("UISystemZongMenOutgoerInteractWin",UIWindowBase)









function UISystemZongMenOutgoerInteractWin:bindComponents()

self.root=UIObject.get(self,0)
self.scenePanel=UIObject.get(self,1)
self.blockMask=UIObject.get(self,2)
self.npcPanel=UIObject.get(self,3)
self.dzPanel=UIObject.get(self,4)
self.colorSignbtn=UIButton.get(self,5)
self.loveList=UIObject.get(self,6)
self.btnClose=UIButton.get(self,7)
self.loveTx=UIText.get(self,8)
self.colorSign=UIImage.get(self,9)
self.loyaltyTx=UIText.get(self,10)
self.infoBtn=UIButton.get(self,11)
self.jobIcon=UIImage.get(self,12)
self.changeDZBtn=UIButton.get(self,13)
self.loyaltyReduce=UIObject.get(self,14)
self.loyaltyReduceValue=UIText.get(self,15)
self.rightTalk_2=UIObject.get(self,16)
self.rightTalk_1=UIObject.get(self,17)
self.leftTalk_3=UIObject.get(self,18)
self.rightTalk_3=UIObject.get(self,19)
self.leftTalk_2=UIObject.get(self,20)
self.leftTalk_1=UIObject.get(self,21)
self.leftTalkDesc_3=UIText.get(self,22)
self.modelRoot=UIObject.get(self,23)
self.thinkProgress=UIProgressBarAni.get(self,24)
self.arrestBtn=UIButton.get(self,25)
self.inciteBtn=UIButton.get(self,26)
self.giftBtn=UIButton.get(self,27)
self.rightTalkDesc_1=UIText.get(self,28)
self.nameTx=UIText.get(self,29)
self.rightTalkDesc_2=UIText.get(self,30)
self.jingjieTx=UIText.get(self,31)
self.zmNameTx=UIText.get(self,32)
self.leftTalkDesc_2=UIText.get(self,33)
self.leftTalkDesc_1=UIText.get(self,34)
self.rightTalkDesc_3=UIText.get(self,35)

self.colorSignbtn:setButtonClick(function()self:onColorSignbtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.changeDZBtn:setButtonClick(function()self:onChangeDZBtn()end)

self.arrestBtn:setButtonClick(function()self:onArrestBtn()end)

self.inciteBtn:setButtonClick(function()self:onInciteBtn()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)
self.rightTalk={
self.rightTalk_1,
self.rightTalk_2,
self.rightTalk_3,
}
self.leftTalk={
self.leftTalk_1,
self.leftTalk_2,
self.leftTalk_3,
}
self.leftTalkDesc={
self.leftTalkDesc_1,
self.leftTalkDesc_2,
self.leftTalkDesc_3,
}
self.rightTalkDesc={
self.rightTalkDesc_1,
self.rightTalkDesc_2,
self.rightTalkDesc_3,
}



end


function UISystemZongMenOutgoerInteractWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scenePanel);self.scenePanel=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
_UIObject_release(self.dzPanel);self.dzPanel=nil;
_UIObject_release(self.colorSignbtn);self.colorSignbtn=nil;
_UIObject_release(self.loveList);self.loveList=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.loveTx);self.loveTx=nil;
_UIObject_release(self.colorSign);self.colorSign=nil;
_UIObject_release(self.loyaltyTx);self.loyaltyTx=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.changeDZBtn);self.changeDZBtn=nil;
_UIObject_release(self.loyaltyReduce);self.loyaltyReduce=nil;
_UIObject_release(self.loyaltyReduceValue);self.loyaltyReduceValue=nil;
_UIObject_release(self.rightTalk_2);self.rightTalk_2=nil;
_UIObject_release(self.rightTalk_1);self.rightTalk_1=nil;
_UIObject_release(self.leftTalk_3);self.leftTalk_3=nil;
_UIObject_release(self.rightTalk_3);self.rightTalk_3=nil;
_UIObject_release(self.leftTalk_2);self.leftTalk_2=nil;
_UIObject_release(self.leftTalk_1);self.leftTalk_1=nil;
_UIObject_release(self.leftTalkDesc_3);self.leftTalkDesc_3=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.thinkProgress);self.thinkProgress=nil;
_UIObject_release(self.arrestBtn);self.arrestBtn=nil;
_UIObject_release(self.inciteBtn);self.inciteBtn=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.rightTalkDesc_1);self.rightTalkDesc_1=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.rightTalkDesc_2);self.rightTalkDesc_2=nil;
_UIObject_release(self.jingjieTx);self.jingjieTx=nil;
_UIObject_release(self.zmNameTx);self.zmNameTx=nil;
_UIObject_release(self.leftTalkDesc_2);self.leftTalkDesc_2=nil;
_UIObject_release(self.leftTalkDesc_1);self.leftTalkDesc_1=nil;
_UIObject_release(self.rightTalkDesc_3);self.rightTalkDesc_3=nil;
self.rightTalk=nil;
self.leftTalk=nil;
self.leftTalkDesc=nil;
self.rightTalkDesc=nil;
end















local _this=nil
local _funcButtonFlag={
[1]=function(funcData)
return funcData.gift_num<cfgHelper.get3(cfg_syssectbaseconfig_get,1,"yl_disciple","zl_num")
end,
[2]=function(funcData)
return funcData.incite_num<cfgHelper.get3(cfg_syssectbaseconfig_get,1,"yl_disciple","cf_num")
end,
[3]=function(funcData)
return funcData.arrest_num<cfgHelper.get3(cfg_syssectbaseconfig_get,1,"yl_disciple","zb_num")
end,
}
local _funcButtonOpen={
[1]=function(config)
return config.zlid~=nil and cfgHelper.get1(cfg_syssectzlconfig_get,config.zlid)~=nil
end,
[2]=function(config)
return config.cfid~=nil and cfgHelper.get1(cfg_syssectcfconfig_get,config.cfid)~=nil
end,
[3]=function(config)
return config.zbid~=nil and cfgHelper.get1(cfg_syssectzbconfig_get,config.zbid)~=nil
end,
}



function UISystemZongMenOutgoerInteractWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
notifySystem:listenNotify(notifyConfig.onSystemZMOutgoerDataInfo,self.onSystemZMOutgoerDataInfo)
notifySystem:listenNotify(notifyConfig.onSystemZMOutgoerSceneChangeVisitor,self.onSystemZMOutgoerSceneChangeVisitor)
notifySystem:listenNotify(notifyConfig.onSystemZMOutgoerFuncDataLoyalty,self.onSystemZMOutgoerFuncDataLoyalty)
notifySystem:listenNotify(notifyConfig.onSystemZMOutgoerFuncDataTimes,self.onSystemZMOutgoerFuncDataTimes)
notifySystem:listenNotify(notifyConfig.onSystemZMOutgoerDataRefresh,self.onSystemZMOutgoerDataRefresh)

self.buttons={self.giftBtn,self.inciteBtn,self.arrestBtn}
self.thinkProgress:setFinishAction(function(...)
self:onThinkFinish()
end)
end


function UISystemZongMenOutgoerInteractWin:__delete()
self:breakThink()

if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill()
end
if self.leaveTween and self.leaveTween:IsActive()then
self.leaveTween:Kill()
end

self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
notifySystem:removelistener(notifyConfig.onSystemZMOutgoerDataInfo,self.onSystemZMOutgoerDataInfo)
notifySystem:removelistener(notifyConfig.onSystemZMOutgoerSceneChangeVisitor,self.onSystemZMOutgoerSceneChangeVisitor)
notifySystem:removelistener(notifyConfig.onSystemZMOutgoerFuncDataLoyalty,self.onSystemZMOutgoerFuncDataLoyalty)
notifySystem:removelistener(notifyConfig.onSystemZMOutgoerFuncDataTimes,self.onSystemZMOutgoerFuncDataTimes)
notifySystem:removelistener(notifyConfig.onSystemZMOutgoerDataRefresh,self.onSystemZMOutgoerDataRefresh)

systemZongMenController:closeOutgoerScene()
end




function UISystemZongMenOutgoerInteractWin:onShow(argtable,afterOnloaded)
if not systemZongMenController:getOutgoerSceneInfo()then
self:closeSelf()
return
end

self.data=systemZongMenController:getOutgoerSceneInfo_OutgoerData()
self.visit=systemZongMenController:getOutgoerSceneInfo_VisitorData()
self.funcData=systemZongMenModel:getOutgoerFuncData()
self.change=nil

local zmData=systemZongMenModel:getInfoData(self.data.serial)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,zmData.id)

self:setDiscipleInfo()
self:setDiscipleData()
self:refreshAllBtn()
self:refreshSceneDz()
self:playEnterAnim()

self:resetTalk()
self:resetThink()
end


function UISystemZongMenOutgoerInteractWin:onHide()
self:breakThink()
self:resetTalk()
systemZongMenController:closeOutgoerScene()
end





function UISystemZongMenOutgoerInteractWin:onBtnClose()
if _this==nil or _this.isClose then return end
if self.leaveFlag then
return
end
if systemZongMenController:haveOutgoerSceneDoResult()then return end
systemZongMenController:exitOutgoerScene(true)
end



function UISystemZongMenOutgoerInteractWin:onInfoBtn()
if self.leaveFlag then
return
end
systemZongMenController:req_outgoer_detailInfo(self.data.serial,self.data.discipleguid)
end

function UISystemZongMenOutgoerInteractWin:onColorSignbtn()

end



function UISystemZongMenOutgoerInteractWin:onArrestBtn()
if self.funcData==nil or not _funcButtonOpen[3](self.zmCfg)then
return
end

if systemZongMenController:isOutgoerSceneDoing()then
return
end

if self.leaveFlag then
return
end

if not _funcButtonFlag[3](self.funcData)then
UIManager.error("今日次数不足")
return
end

if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eLaoYu)then
UIManager.error('需要修复宗门建筑——牢狱')
return
end

if not UIPrisonModel:existEmptyRoom(ePrisonRoomType.eDisciple)then
UIManager.error("没有空的牢房")
return
end

local closeFunc=function()
self:closeWindow("UISystemZongMenOutgoerArrestWin")
end
local args={
arrestCallback=function(guids)
systemZongMenController:req_outgoer_arrest(self.data.serial,guids,self.data.discipleguid)
closeFunc()
end,
closeCallback=closeFunc,
}
self:showWindow("UISystemZongMenOutgoerArrestWin",args)
end



function UISystemZongMenOutgoerInteractWin:onGiftBtn()
if self.funcData==nil or not _funcButtonOpen[1](self.zmCfg)then
return
end

if systemZongMenController:isOutgoerSceneDoing()then
return
end

if self.leaveFlag then
return
end

if not _funcButtonFlag[1](self.funcData)then
UIManager.error("今日已对该弟子赠送过礼物")
return
end

local args={
loveList=self.funcData.likeList,
selectChangeFunc=function(item)
self:setLoyaltyChange(item)
end,
selectCallback=function(item)
local content=FMT.fmt("确认将以下物品赠与<{0}>吗？",self.data.disciplename)
local onOK=function()
systemZongMenController:req_outgoer_gift(self.data.serial,self.visit.discipleguid,self.data.discipleguid,item.itemguid)
self:setLoyaltyChange()
self:closeWindow("UISystemZongMenOutgoerGiftWin")
end
local _args={
title='提示',
desc1=content,
desc2=nil,
rewards={{item.itemid,1}},
rewardTitle=-1,
showCancel=true,
cancelName='容我三思',
commitName='确认赠予',
cancelCB=nil,
commitCB=onOK,
}
UIManager:showWindow('UIDialougeRewardWin',_args)
end,
closeCallback=function()
self:setLoyaltyChange()
self:closeWindow("UISystemZongMenOutgoerGiftWin")
end,
}
self:showWindow("UISystemZongMenOutgoerGiftWin",args)
end



function UISystemZongMenOutgoerInteractWin:onInciteBtn()
if self.funcData==nil or not _funcButtonOpen[2](self.zmCfg)then
return
end

if systemZongMenController:isOutgoerSceneDoing()then
return
end

if self.leaveFlag then
return
end

if not _funcButtonFlag[2](self.funcData)then
UIManager.error("今日已对该弟子进行过策反")
return
end

local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
UIManager.error("宗门弟子人数已满")
return
end

local closeFunc=function()
self:closeWindow("UISystemZongMenOutgoerInciteWin")
end
local inciteFunc=function(guid)
systemZongMenController:req_outgoer_incite(self.data.serial,self.visit.discipleguid,self.data.discipleguid)
closeFunc()
end
local args={
inciteCallback=inciteFunc,
closeCallback=closeFunc,
}
self:showWindow("UISystemZongMenOutgoerInciteWin",args)
end

function UISystemZongMenOutgoerInteractWin.on_swipe()
if _this==nil or _this.isClose then return end
if systemZongMenController:haveOutgoerSceneDoResult()then return end
systemZongMenController:exitOutgoerScene(true)
end

function UISystemZongMenOutgoerInteractWin.onClickEmptyInWorld()
if _this==nil or _this.isClose then return end
if systemZongMenController:haveOutgoerSceneDoResult()then return end
systemZongMenController:exitOutgoerScene(true)
end

function UISystemZongMenOutgoerInteractWin:setDiscipleInfo()
local imageInfo=UIDiscipleModel.calculationDiscipleImage(self.data.discipledata,self.data.discipleimage)

self.modelRoot:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildInSideModelEx(self.modelRoot,modelParams,0.75,eAnimationID.stand,0,0,false,true)

local jobicon=UIDiscipleModel:getJobIconName(imageInfo.job)
self.jobIcon:setSprite(globalABLookup.global,jobicon)

local color_icon=FMT.fmt('image_pinjishibie_{0}',imageInfo.color)
self.colorSign:setSprite(globalABLookup.global,color_icon)

self.nameTx:setText(self.data.disciplename)

local jjlv=self.data.jingjie
local jjname=UIDiscipleModel:getJJName3(jjlv)
local jjStr=jjname



self.jingjieTx:setText(jjStr)

local zmName=systemZongMenModel:getInfoDataName(self.data.serial)
local zmNameStr=FMT.fmt("所属宗门：{0}",zmName)
self.zmNameTx:setText(zmNameStr)
end

function UISystemZongMenOutgoerInteractWin:setDiscipleData()
if self.funcData==nil then return end












self.loveList:setChildLayoutGroupCreateItems(#self.funcData.likeList,function(index)
local loveItem=self.loveList:getChildLayoutGroupGridItem(index-1)
local loveId=self.funcData.likeList[index]
local conf={itemid=loveId,itemcount="",showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
loveItem:SetChildPropData(0,prop)
loveItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)

self:refreshLoyalty(true)
end

function UISystemZongMenOutgoerInteractWin:refreshLoyalty(withChange)
self:setLoyalty(self.funcData.loyalty)
if withChange then
self:setLoyaltyChange(self.change)
end
end

function UISystemZongMenOutgoerInteractWin:setLoyalty(value)
self.loyaltyTx:setText(FMT.fmt("忠诚度：{0}",value))
end

function UISystemZongMenOutgoerInteractWin:refreshLoyaltyDelta(delta)
self.loyaltyReduce:setActive(delta~=nil)
if delta then
self.loyaltyReduceValue:setText(math.min(delta,self.funcData.loyalty))
end
end

function UISystemZongMenOutgoerInteractWin:setLoyaltyChange(item)
self.change=item
if item then
local itemCfg=itemsConfig.getConfig(item.itemid)
local giftCfg=cfgHelper.get1(cfg_syssectzlconfig_get,self.zmCfg.zlid)
local deltaJJ=math.max(self.visit.jingjielv-self.data.jingjie,0)
local paramA=giftCfg.param[1]
local hideWorth=itemCfg.hideWorth
local paramB=giftCfg.param[2]
local likeScale=table.containsValue(self.funcData.likeList,item.itemid)and giftCfg.param[4]or 1
local meili=self.visit.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]
local paramC=giftCfg.param[3]
local value=math.floor(deltaJJ*paramA+hideWorth*paramB*likeScale+meili*paramC)


value=value>0 and value or nil
self:refreshLoyaltyDelta(value)
else

self:refreshLoyaltyDelta()
end
end

function UISystemZongMenOutgoerInteractWin:refreshAllBtn()
for i,v in ipairs(self.buttons)do
self:refreshButton(v,i)
end
end

function UISystemZongMenOutgoerInteractWin:refreshSingleBtn(index)
self:refreshButton(self.buttons[index],index)
end

function UISystemZongMenOutgoerInteractWin:refreshButton(item,index)
local flag=self.funcData==nil or not _funcButtonOpen[index](self.zmCfg)or not _funcButtonFlag[index](self.funcData)
item:setChildImageExGray(flag)
end

function UISystemZongMenOutgoerInteractWin:playEnterAnim()
if self.leaveTween and self.leaveTween:IsActive()then
self.leaveTween:Kill()
end
self.scenePanel:setActive(false)
self.root:setChildAnchoredPosition(Vector2(300,0))
self.root:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end
_this.scenePanel:setActive(true)
end
self.root:setChildDOAnchorPosX(0,0.25,func)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.leaveFlag=nil
end

function UISystemZongMenOutgoerInteractWin:doPreLeaveAnim(func)
self.dzPanel:setActive(false)
self.leaveTween=self.root:setChildDOAnchorPosX(550,0.25,func)
self.leaveFlag=true
end

function UISystemZongMenOutgoerInteractWin:refreshSceneDz()
if not self.data.flip then

self.dzPanel:setChildAnchoredPosition(Vector2(70,0))
else

self.dzPanel:setChildAnchoredPosition(Vector2(-85,0))
end
end

function UISystemZongMenOutgoerInteractWin:beginThink(time,callback,breakBack)
self.dzPanel:setActive(false)
self.npcPanel:setActive(true)
self.thinkCallback=callback
self.thinkBreak=breakBack
self.thinkProgress:animateFiveParams(0,100,100,time,false)
end

function UISystemZongMenOutgoerInteractWin:breakThink()
if self.thinkBreak then
self.thinkBreak()
self:resetThink()
end
end

function UISystemZongMenOutgoerInteractWin:resetThink()
self.thinkBreak=nil
self.thinkCallback=nil
self.dzPanel:setActive(true)
self.npcPanel:setActive(false)
end

function UISystemZongMenOutgoerInteractWin:onThinkFinish()
if self==nil then return end
self.dzPanel:setActive(true)
self.npcPanel:setActive(false)
if self.thinkCallback then
self.thinkCallback()
end
end

function UISystemZongMenOutgoerInteractWin:onChangeDZBtn()
if systemZongMenController:isOutgoerSceneDoing()then
return
end

if self.leaveFlag then
return
end

local selected=systemZongMenController:getOutgoerSceneInfo_VisitorData()
local discipleguid=selected and selected.discipleguid or nil
local args={
discipleguids={discipleguid},
openType=dzSelectWinOpenType.eSystemZMOutgoer,
funcType=edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer,
callback=function(guid)
systemZongMenController:changeOutgoerSceneVisitor(guid)
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UISystemZongMenOutgoerInteractWin:showTalk(side,content,time,callback,index)
index=index or 1
self.talkTween=Lua.SequenceProxy.New()
for i=1,index do
local rootCmp=not side and self.leftTalk[i]or self.rightTalk[i]
local descCmp=not side and self.leftTalkDesc[i]or self.rightTalkDesc[i]
descCmp:setText(content)
rootCmp:setChildCanvasGroupAlpha(1)
rootCmp:setScale(Vector3.zero)
local tween0=Lua.SequenceProxy.New()
local tween1=rootCmp:setChildDOScale(1.2,0.2)
tween0:Append(tween1)
local tween2=rootCmp:setChildDOScale(1,0.1)
tween0:Append(tween2)
self.talkTween:Append(tween0)
end
self.talkTween:AppendInterval(time)
self.talkTween:AppendCallback(function()
self:resetTalk()
if callback then
callback()
end
end)
end

function UISystemZongMenOutgoerInteractWin:resetTalk()
for i,v in ipairs(self.leftTalk)do
v:setChildCanvasGroupAlpha(0)
end
for i,v in ipairs(self.rightTalk)do
v:setChildCanvasGroupAlpha(0)
end
if self.talkTween and self.talkTween:IsActive()then
self.talkTween:Kill()
end
self.talkTween=nil
end

function UISystemZongMenOutgoerInteractWin.onSystemZMOutgoerDataInfo()
_this.funcData=systemZongMenModel:getOutgoerFuncData()
_this:refreshAllBtn()
_this:setDiscipleData()
end

function UISystemZongMenOutgoerInteractWin.onSystemZMOutgoerSceneChangeVisitor(discipleguid)
_this.visit=systemZongMenController:getOutgoerSceneInfo_VisitorData()
_this:setLoyaltyChange(_this.change)
end

function UISystemZongMenOutgoerInteractWin.onSystemZMOutgoerFuncDataLoyalty(serial,discipleguid,deltaLoyalty)
_this:refreshLoyalty()
end

function UISystemZongMenOutgoerInteractWin.onSystemZMOutgoerFuncDataTimes(funcIdx)
_this:refreshSingleBtn(funcIdx)
end

function UISystemZongMenOutgoerInteractWin.onSystemZMOutgoerDataRefresh()
local outgoer=systemZongMenModel:getOutgoerData(_this.data.discipleguid)
if outgoer==nil then
_this:onBtnClose()
end
end

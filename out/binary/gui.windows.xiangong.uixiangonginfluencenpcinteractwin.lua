







def_class("UIXianGongInfluenceNPCInteractWin",UIWindowBase)









function UIXianGongInfluenceNPCInteractWin:bindComponents()

self.btnList=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.giftBtn=UIButton.get(self,2)
self.giftList=UIObject.get(self,3)
self.giftReddot=UIObject.get(self,4)
self.giftRoot=UIObject.get(self,5)
self.giftView=UIObject.get(self,6)
self.likeBtn=UIButton.get(self,7)
self.likeReddot=UIObject.get(self,8)
self.lvName=UIText.get(self,9)
self.modelBtn=UIButton.get(self,10)
self.modelImage=UIObject.get(self,11)
self.modelObj=UIObject.get(self,12)
self.npcName=UIText.get(self,13)
self.progressBar=UIProgress.get(self,14)
self.progressHandle=UIObject.get(self,15)
self.progressTx=UIText.get(self,16)
self.rightPanel=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.saluteBtn=UIButton.get(self,19)
self.speakObj=UIObject.get(self,20)
self.speakTx=UIText.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.likeBtn:setButtonClick(function()self:onLikeBtn()end)

self.modelBtn:setButtonClick(function()self:onModelBtn()end)

self.saluteBtn:setButtonClick(function()self:onSaluteBtn()end)



end


function UIXianGongInfluenceNPCInteractWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnList);self.btnList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.giftList);self.giftList=nil;
_UIObject_release(self.giftReddot);self.giftReddot=nil;
_UIObject_release(self.giftRoot);self.giftRoot=nil;
_UIObject_release(self.giftView);self.giftView=nil;
_UIObject_release(self.likeBtn);self.likeBtn=nil;
_UIObject_release(self.likeReddot);self.likeReddot=nil;
_UIObject_release(self.lvName);self.lvName=nil;
_UIObject_release(self.modelBtn);self.modelBtn=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.npcName);self.npcName=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressHandle);self.progressHandle=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.saluteBtn);self.saluteBtn=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakTx);self.speakTx=nil;
end















local _this=nil
local _abName="ui/windows/xiangong/xiangongshili_atlas_pak.ab"
local _giftItemCmp={
root=2,
item=0,
over=1,
}
local _giftWord={
[eXJFactionNPCConditionType.eNPCLevel]=function(typo,npcId,lv)
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcCfg.image)
return FMT.fmt("提升{0}好感等级或许会知道一点消息",imageCfg.name)
end,
[eXJFactionNPCConditionType.eTaskFinish]=function(typo,taskId)
local npcId=xjFactionNPCModel:findNPCByTask(taskId)
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcCfg.image)
return FMT.fmt("提升{0}好感等级或许会知道一点消息",imageCfg.name)
end,
[eXJFactionNPCConditionType.eMessageRecv]=function(typo,messageId)
local npcList=xjFactionNPCModel:findNPCListByMessage(messageId)
local npcId=npcList[1]
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcCfg.image)
return FMT.fmt("提升{0}好感等级或许会知道一点消息",imageCfg.name)
end,
[eXJFactionNPCConditionType.eFactionLevel]=function(typo,factionId,lv)
local factionCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,factionId)
return FMT.fmt("提升{0}声望等级或许会知道一点消息",factionCfg.name)
end,
}
local _btnItemCmp={
root=3,
sign=0,
text=1,
flag=2,
}
local _buttonType={
eVisit=1,
eMessage=2,
eTask=3,
}
local _buttonInfoHandle={
[_buttonType.eVisit]={
signName=function(npcId,id)
return _abName,"image_xiangongyouh_14"
end,
getName=function(npcId,id)
return"送上拜帖"
end,
getFlag=function(npcId,id)
return false
end,
onClick=function(window,npcId,id)
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
if npcCfg.baitie then
window.root:setActive(false)
worldStoryController:showStoryTree(npcCfg.baitie,function()
local _window=UIManager:findActiveWindow("UIXianGongInfluenceNPCInteractWin")
if _window then
window.root:setActive(true)
end
end,nil,nil,{isFullOpen=false})
end

xjFactionNPCController:send_37_105(npcId)
end,
},
[_buttonType.eMessage]={
signName=function(npcId,id)
return _abName,"icon_tanhua_1"
end,
getName=function(npcId,id)
return cfgHelper.get2(cfg_xianjieshilijiaohuchatconfig_get,id,"chat_name")or"..."
end,
getFlag=function(npcId,id)
return false
end,
onClick=function(window,npcId,id)
window.root:setActive(false)

local args={
id=id,
parentWin=window,
npc=npcId,
callback=function()
window.root:setActive(true)
window:setChildWinArgs("UIXianGongInfluenceNPCTalkWin",nil)
end,
}
window:setChildWinArgs("UIXianGongInfluenceNPCTalkWin",args)
window:showWindow("UIXianGongInfluenceNPCTalkWin",args)

xjFactionNPCController:send_37_108(npcId,id)
end,
},
[_buttonType.eTask]={
signName=function(npcId,id)
local exCheck=xjFactionNPCModel:checkTaskAcceptExtraCondition(id)
local check=taskModel:fitAcceptCondition(id)
if exCheck and check then
return _abName,"icon_weituo_1"
else
return globalABLookup.global,"image_dysuo_1"
end
end,
getName=function(npcId,id)
local taskCfg=taskModel:getTaskConfig(id)
return taskCfg.name
end,
getFlag=function(npcId,id)
local taskData=taskModel:getTask(id)
local taskState=taskModel:getTaskState_transfromstate(taskData)
return taskState==taskModel.taskRewardState
end,
onClick=function(window,npcId,id)
local check,tips=taskModel:fitAcceptCondition(id)
if check then
check,tips=xjFactionNPCModel:checkTaskAcceptExtraCondition(id,"{0}解锁剧情")
if check then
window.rightPanel:setActive(false)
local args={
id=id,
parentWin=window,
npc=npcId,
callback=function()
window.rightPanel:setActive(true)
window:setChildWinArgs("UIXianGongInfluenceNPCTaskWin",nil)
end
}
window:setChildWinArgs("UIXianGongInfluenceNPCTaskWin",args)
window:showWindow("UIXianGongInfluenceNPCTaskWin",args)
return
end
end
UIManager.error(tips)
end,
},
}
local _defaultSize={800,800}



function UIXianGongInfluenceNPCInteractWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onTaskCondition,self.onTaskCondition)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.onXianGongNPCRelationChange,self.onXianGongNPCRelationChange)
self:addNotify(notifyConfig.onXianGongNPCDailyFreeChange,self.onXianGongNPCDailyFreeChange)
self:addNotify(notifyConfig.showUI,self.onShowUI)
self:addNotify(notifyConfig.closeUI,self.onCloseUI)
self:addProNotify(37,105,self.on_37_105)
self:addProNotify(37,106,self.on_37_106)
self:addProNotify(37,107,self.on_37_107)
self:addProNotify(37,108,self.on_37_108)

self.childWinArgs={}
end


function UIXianGongInfluenceNPCInteractWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceNPCInteractWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
self.parentWin=argtable.parentWin
self.npcID=argtable.npc
self.onClose=argtable.onClose
self.npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcID)

self:refreshNPC()
self:refreshSalute()
self:refreshProgress(true)
self:refreshGift()
self:refreshButtons()
self:speakWord0()

if argtable.weakGuide then
weakGuideController:beginGuide(argtable.weakGuide)
end
end


function UIXianGongInfluenceNPCInteractWin:onHide()

end




function UIXianGongInfluenceNPCInteractWin:onCloseBtn()
if self.onClose then
self.onClose()
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianGongInfluenceNPCInteractWin:onGiftBtn()
if not xjFactionNPCModel:isNPCLock(self.npcID)then
self.rightPanel:setActive(false)
local args={
parentWin=self,
npc=self.npcID,
callback=function()
self.rightPanel:setActive(true)
self:setChildWinArgs("UIXianGongInfluenceNPCGiftWin",nil)
end
}
self:setChildWinArgs("UIXianGongInfluenceNPCGiftWin",args)
self:showWindow("UIXianGongInfluenceNPCGiftWin",args)
end
end


function UIXianGongInfluenceNPCInteractWin:onSaluteBtn()
local haveGift=xjFactionNPCModel:haveNPCGift(self.npcID)
local over=xjFactionNPCModel:haveNPCOverGift(self.npcID)
if haveGift or over then

xjFactionNPCController:send_37_107(self.npcID)
end
end

function UIXianGongInfluenceNPCInteractWin:onLikeBtn()
local haveGift=xjFactionNPCModel:haveNPCGift(self.npcID)
local over=xjFactionNPCModel:haveNPCOverGift(self.npcID)
if haveGift or over then

xjFactionNPCController:send_37_107(self.npcID)
else
local args={
parentWin=self,
npc=self.npcID,
}
self:showWindow("UIXianGongInfluenceNPCLikeWin",args)
end
end

function UIXianGongInfluenceNPCInteractWin:setChildWinArgs(winName,winArgs)
self.childWinArgs[winName]=winArgs
end

function UIXianGongInfluenceNPCInteractWin:refreshNPC()
local nameStr=npcModel:getName(self.npcCfg.image)
local modelParams=npcModel:getImageInfo(self.npcCfg.image)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,self.npcCfg.image)
local scale=self.npcCfg.imageParam and self.npcCfg.imageParam[1]or 1
local size=self.npcCfg.imageParam and self.npcCfg.imageParam[2]or _defaultSize
self.npcName:setText(nameStr)
self.modelImage:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,true)
self.modelObj:setChildSizeDelta(size[1],size[2])
end

function UIXianGongInfluenceNPCInteractWin:refreshSalute()
local lock=xjFactionNPCModel:isNPCLock(self.npcID)
local haveGift=xjFactionNPCModel:haveNPCGift(self.npcID)
local over=xjFactionNPCModel:haveNPCOverGift(self.npcID)
local show=not lock and(over or haveGift)
self.saluteBtn:setActive(show)
self.likeReddot:setActive(show)
end

function UIXianGongInfluenceNPCInteractWin:refreshProgress(all)
local total,level,stepCur,stepMax=xjFactionNPCModel:getNPCRelation(self.npcID)
if all then
local levelCfg=cfgHelper.get1(cfg_xianjieshilijiaohufeellevelconfig_get,level)
self.lvName:setText(levelCfg.name)
end
if stepCur==stepMax then
self.progressBar:setProgressValue(10000,10000)
self.progressHandle:setChildAnchoredPos(0,291)

self.progressTx:setText("已满")
else
self.progressBar:setProgressValue(stepCur,stepMax)
self.progressHandle:setChildAnchoredPos(0,stepCur/stepMax*291)

self.progressTx:setText(mathHelper.formatNumber(stepCur))
end
end

function UIXianGongInfluenceNPCInteractWin:refreshGift()
local lock=xjFactionNPCModel:isNPCLock(self.npcID)
self.giftRoot:setActive(not lock)
if lock then return end

self.giftList:setChildLayoutGroupCreateItems(#self.npcCfg.recv_list,function(index)
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local config=self.npcCfg.recv_list[index]
local itemId=config[1]
local itemNum=1
local condId=config[2]
local limit=config[3]
local condition=xjFactionNPCModel:checkConditionsEx(condId)
local max=xjFactionNPCModel:getNPCGiftNumMax(self.npcID,limit[1],limit[2])
local cnt=xjFactionNPCModel:getNPCGiftCount(self.npcID,itemId)
item:SetChildButtonClick(_giftItemCmp.root,function()
self:onClickGift(index)
end)
item:SetChildActive(_giftItemCmp.item,condition)
item:SetChildActive(_giftItemCmp.over,condition and cnt==max)
if condition then
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(_giftItemCmp.item,_prop)
end
end)
self.giftView:setChildScrollRectEnable(#self.npcCfg.recv_list>4)

self:refreshGiftReddot()
end

function UIXianGongInfluenceNPCInteractWin:refreshGiftReddot()
local reddot=xjFactionNPCModel:getNPCGiftReddot(self.npcID)
self.giftReddot:setActive(reddot)
end

function UIXianGongInfluenceNPCInteractWin:onClickGift(index)
local config=self.npcCfg.recv_list[index]
local condId=config[2]
local condCfg=cfgHelper.get1(cfg_xianjieshilijiaohucondconfig_get,condId)
local condition=true
local limit=nil
local errStr=nil
if condCfg and condCfg.cond_val then
condition,errStr,limit=xjFactionNPCModel:checkConditions(condCfg.cond_val)
end

if not condition then
local condInfo=condCfg.cond_val[limit]
local condType=condInfo[1]
local wordHandle=_giftWord[condType]
if wordHandle then
local str=wordHandle(unpack(condInfo))
UIManager.info(str)
else
loggerUtil.logErrFMT("没有实现仙界势力NPC赠礼限制条件类型{0}的文本处理",condType)
end
else
local itemId=config[1]
itemsComponentHelper.onItemClickEx(itemId)
end
end

function UIXianGongInfluenceNPCInteractWin:refreshButtons()
self.buttonDatas={}
if xjFactionNPCModel:isNPCLock(self.npcID)then
if xjFactionNPCModel:hasNPCEnoughVisitItem(self.npcID)then
table.insert(self.buttonDatas,{_buttonType.eVisit,nil})
end
else
local messages=xjFactionNPCModel:getNPCMessages(self.npcID)
for i,v in ipairs(messages)do
table.insert(self.buttonDatas,{_buttonType.eMessage,v})
end

local taskData=xjFactionNPCModel:getNPCTaskData(self.npcID)
if taskData then
table.insert(self.buttonDatas,{_buttonType.eTask,taskData.taskid})
end
end

self.btnList:setChildLayoutGroupCreateItems(#self.buttonDatas,function(index)
local item=self.btnList:getChildLayoutGroupGridItem(index-1)
local data=self.buttonDatas[index]
local type=data[1]
local args=data[2]
local handle=_buttonInfoHandle[type]
item:SetChildButtonClick(_btnItemCmp.root,function()
self:onClickButton(index)
end)
item:SetChildCSImageSprite(_btnItemCmp.sign,handle.signName(self.npcID,args))
item:SetChildText(_btnItemCmp.text,handle.getName(self.npcID,args))
item:SetChildActive(_btnItemCmp.flag,handle.getFlag(self.npcID,args))
end)
end

function UIXianGongInfluenceNPCInteractWin:refreshButtonState(index)
local item=self.btnList:getChildLayoutGroupGridItem(index-1)
local data=self.buttonDatas[index]
local type=data[1]
local args=data[2]
local handle=_buttonInfoHandle[type]
item:SetChildCSImageSprite(_btnItemCmp.sign,handle.signName(self.npcID,args))
item:SetChildActive(_btnItemCmp.flag,handle.getFlag(self.npcID,args))
end

function UIXianGongInfluenceNPCInteractWin:refreshTaskButton()
for index,data in ipairs(self.buttonDatas)do
if data[1]==_buttonType.eTask then
self:refreshButtonState(index)
end
end
end



function UIXianGongInfluenceNPCInteractWin:checkRefreshTaskButton(type,id)
local taskData=xjFactionNPCModel:getNPCTaskData(self.npcID,false)
if taskData and xjFactionNPCModel:checkTaskAcceptExtraCondition(taskData.taskid)then
local haveData=false
for index,data in ipairs(self.buttonDatas)do
if data[1]==_buttonType.eTask and data[2]==taskData.taskid then
haveData=true
break
end
end
if not haveData then
self:refreshButtons()
return
end
end

if type>0 then

for index,data in ipairs(self.buttonDatas)do
if data[1]==_buttonType.eTask then
local taskCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,data[2])
if taskCfg then
local condCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,taskCfg.accept_limit)
if condCfg and next(condCfg.cond_val)then
for i,v in ipairs(condCfg.cond_val)do
if v[1]==type and v[2]==id then
self:refreshButtonState(index)
end
end
end
end
end
end
else
for index,data in ipairs(self.buttonDatas)do
if data[1]==_buttonType.eTask and data[2]==id then
self:refreshButtonState(index)
end
end
end
end

function UIXianGongInfluenceNPCInteractWin:onClickButton(index)
local data=self.buttonDatas[index]
local type=data[1]
local args=data[2]
local handle=_buttonInfoHandle[type]
handle.onClick(self,self.npcID,args)
end

function UIXianGongInfluenceNPCInteractWin:speakWord0()
local speak0=self.npcCfg.speak0
local total,level,stepCur,stepMax=xjFactionNPCModel:getNPCRelation(self.npcID)
local libs=nil
for i=level,1,-1 do
libs=speak0[i]
if libs then
break
end
end
if libs then
local r=math.random(1,#libs)
local str=libs[r]
self:speakWord(str)
end
end

function UIXianGongInfluenceNPCInteractWin:speakWord1()
local speak1=self.npcCfg.speak1
local total,level,stepCur,stepMax=xjFactionNPCModel:getNPCRelation(self.npcID)
local libs=nil
for i=level,1,-1 do
libs=speak1[i]
if libs then
break
end
end

if libs then
local r=math.random(1,#libs)
local str=libs[r]
self:speakWord(str)
end
end

function UIXianGongInfluenceNPCInteractWin:speakWord(str)
if self.speakTween and self.speakTween:IsActive()then
self.speakTween:Kill(true)
end
self.speakTx:setText('')
self.speakObj:setChildCanvasGroupAlpha(0)
self.speakObj:setScale(Vector3.zero)
self.speakTween=Lua.SequenceProxy.New()
local speakTxCmp=self.speakTx:getGameObject():GetComponent("Text")
local tween0=Lua.DOTweenProxyExtensions.DOText(speakTxCmp,"",0)
tween0:SetEase(DG.Tweening.Ease.Linear)
local tween1=self.speakObj:setChildCanvasGroupDOFade(1,0.1)
local tween2=self.speakObj:setChildDOScale(1.2,0.2)
local tween3=self.speakObj:setChildDOScale(1,0.1)
local tween4=Lua.DOTweenProxyExtensions.DOText(speakTxCmp,str,1)
local temp=Lua.SequenceProxy.New()
temp:Append(tween2)
temp:Append(tween3)
self.speakTween:Append(tween0)
self.speakTween:Append(temp)
self.speakTween:Join(tween1)
self.speakTween:Join(tween4)
end

function UIXianGongInfluenceNPCInteractWin:onModelBtn()
self:speakWord0()
end

function UIXianGongInfluenceNPCInteractWin.onTaskChange(taskid,taskstate)
local npcId=xjFactionNPCModel:findNPCByTask(taskid)

if _this.npcID==npcId then
if taskstate==taskModel.taskFinishState or taskstate==taskModel.taskAcceptState then
_this:refreshButtons()
else
_this:checkRefreshTaskButton(0,taskid)
end
elseif taskstate==taskModel.taskFinishState then
_this:checkRefreshTaskButton(2,taskid)
end
end

function UIXianGongInfluenceNPCInteractWin.onTaskCondition(taskid,changeType)
_this:checkRefreshTaskButton(0,taskid)
end

function UIXianGongInfluenceNPCInteractWin.on_item_list_changed(array,guidLookup,idLookup)
if not xjFactionNPCModel:isNPCLock(_this.npcID)then
for itemId,_ in pairs(idLookup)do
local npcs=xjFactionNPCModel:findNPCByGiftItemId(itemId)

if npcs and table.containsValue(npcs,_this.npcID)then
_this:refreshGiftReddot()
break
end
end
end

for itemId,_ in pairs(idLookup)do
local npcs=xjFactionNPCModel:findNPCByUnlockItemId(itemId)
if npcs and table.containsValue(npcs,_this.npcID)then
_this:refreshButtons()
break
end
end
end

function UIXianGongInfluenceNPCInteractWin.onXianGongNPCDailyFreeChange(npcId)
if npcId==nil or _this.npcID==npcId then
_this:refreshGiftReddot()
end
end

function UIXianGongInfluenceNPCInteractWin.onXianGongNPCRelationChange(npcId,changeLv,changeReputation)
if npcId==_this.npcID then
_this:refreshProgress(changeLv)

if changeLv then
_this:refreshGift()
_this:refreshSalute()
_this:refreshButtons()
return
end
end
if changeLv then
_this:checkRefreshTaskButton(1,npcId)
_this:refreshGiftReddot()
end
if changeReputation then
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
_this:checkRefreshTaskButton(4,faction)
end
end

function UIXianGongInfluenceNPCInteractWin.on_37_105(result,npcId)
if result==0 and npcId==_this.npcID then
_this:refreshGift()
_this:refreshSalute()
_this:refreshButtons()
end
end

function UIXianGongInfluenceNPCInteractWin.on_37_106(args)
local npcId=args[1]
if npcId==_this.npcID then
_this:speakWord1()
_this:refreshGift()
end
end

function UIXianGongInfluenceNPCInteractWin.on_37_107(result,npcId,flag,relation)
if result==0 and npcId==_this.npcID then
_this:refreshSalute()
end
end

function UIXianGongInfluenceNPCInteractWin.on_37_108(result,message)
if result==0 then
local npcList=xjFactionNPCModel:findNPCListByMessage(message)
local find=table.findValue(npcList,_this.npcID)
if find then
_this:refreshGift()
_this:refreshButtons()
else
_this:checkRefreshTaskButton(3,message)
end
end
end

function UIXianGongInfluenceNPCInteractWin.onShowUI(name)
if UIFullStoryBoardControl:isPlotBoardWinName(name)then
UIFullXJForceControl:hideWindow(_this.__name)
end
end

function UIXianGongInfluenceNPCInteractWin.onCloseUI(name)
if UIFullStoryBoardControl:isPlotBoardWinName(name)then
UIFullXJForceControl:showWindow(_this.__name,_this.argtable)
for winName,vis in pairs(_this.__childWindow)do
if vis==false then
local args=_this.childWinArgs[winName]
_this:showWindow(winName,args)
end
end
end
end
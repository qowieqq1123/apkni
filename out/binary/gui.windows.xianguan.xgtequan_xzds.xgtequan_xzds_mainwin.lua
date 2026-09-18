







def_class("xgTeQuan_XZDS_mainWin",UIWindowBase)









function xgTeQuan_XZDS_mainWin:bindComponents()

self.buffTips=UIObject.get(self,0)
self.cdTxt=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.closeBuffTipsBtn=UIButton.get(self,3)
self.costTxt=UIText.get(self,4)
self.findBtn=UIButton.get(self,5)
self.hiddenBuffList=UIObject.get(self,6)
self.infoBtn=UIButton.get(self,7)
self.jumpAnimation=UIToggleButton.get(self,8)
self.listContent=UIObject.get(self,9)
self.mbg=UIObject.get(self,10)
self.okBtn=UIButton.get(self,11)
self.rightPanel=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.showAllBtn=UIButton.get(self,14)
self.tipsText=UIObject.get(self,15)
self.title=UIText.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeBuffTipsBtn:setButtonClick(function()self:onCloseBuffTipsBtn()end)

self.findBtn:setButtonClick(function()self:onFindBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.showAllBtn:setButtonClick(function()self:onShowAllBtn()end)



end


function xgTeQuan_XZDS_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buffTips);self.buffTips=nil;
_UIObject_release(self.cdTxt);self.cdTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeBuffTipsBtn);self.closeBuffTipsBtn=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.findBtn);self.findBtn=nil;
_UIObject_release(self.hiddenBuffList);self.hiddenBuffList=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.listContent);self.listContent=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showAllBtn);self.showAllBtn=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.title);self.title=nil;
end
















local CmpRecordItemIndex={
root=0,
nameL=1,
iconL=2,
attrsL=3,
mbg=4,
selectBtnL=5,
stateL=6,
effect=7,
nameH=8,
iconH=9,
attrsH=10,
selectBtnH=11,
stateH=12,
}

local cardQuality={
blue=1,
orange=2,
}

local cardAnimState={
stand=1,
enter=2,
enter2=3,
}

local cardAnimID={
[cardQuality.blue]={
[cardAnimState.stand]=3074,
[cardAnimState.enter]=3075,
[cardAnimState.enter2]=3076,
},
[cardQuality.orange]={
[cardAnimState.stand]=3077,
[cardAnimState.enter]=3078,
[cardAnimState.enter2]=3079,
},
}
local cardEffectID={
[cardQuality.blue]={
{22626,22627},
{22628,22629},
{22630,22631},
},
[cardQuality.orange]={
{22632,22633},
{22634,22635},
{22636,22637},
},
}

local cardPos={{-313,0},{0,0},{313,0}}
local cardPosEx={{-156,0},{156,0}}

local _this
local _ab="ui/windows/xianguan/xgtequan_xzds/xgtequan_xzds_atlas_pak.ab"






function xgTeQuan_XZDS_mainWin:onLoaded(...)
self:bindComponents()
_this=self
self.hasCardAnimNum=0
self.selectShowIdx=nil
self.isShowAll=false

self:refreshJumpAnimation()
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)

self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)

end


function xgTeQuan_XZDS_mainWin:__delete()
self.saveJumpAniState()

self:unbindComponents()
self.isShowAll=nil
self.selectShowIdx=nil
self.hasCardAnimNum=0

_this=nil
end




function xgTeQuan_XZDS_mainWin:onShow(argtable,afterOnloaded)
self.xgId=argtable.baseData.xgid
self.tqType=argtable.baseData.tqtype
self.tqId=argtable.baseData.tqid

self.hasCardAnimNum=0
self.selectItemIdx=nil
self.selectShowIdx=nil
self.showAll=false

self:refreshAll(true)

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6085,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.findBtn:getID(),false,true,false)
self.findBtn:setChildUIModelShowTarget(6086,1,nil,eAnimationID.stand,false,false,0,nil)
end
end


function xgTeQuan_XZDS_mainWin:onHide()

end

function xgTeQuan_XZDS_mainWin.onTeQuanInfoChange(tqData)
if _this==nil then return end
local tqid=tqData.tqid
if tqid==_this.tqId then
_this:refreshAll()
end
end

function xgTeQuan_XZDS_mainWin:refreshAll(isInit)
self:refreshView(isInit)
self:refreshRight()
self:freshTeQuanOptionChangePart()
end

function xgTeQuan_XZDS_mainWin:refreshView(isInit)
local key=xianguanConfig.getTeQuanFindKey(self.xgId,self.tqId)
local obj=xianguanModel:getSelfTequanObj(key)

local isRandom=obj.data.len>0
local isSelect=self.selectItemIdx~=nil
local isShowBuffList=isRandom or isSelect
if not isShowBuffList then
self.buffList={}
end
if isRandom then
self.buffList=obj.data.list
end
self.tipsText:setChildCanvasGroupAlpha(0)

local callFunc=function(widget,index,data)
local buffType=data.param_1
local buffId=data.param_2
local name,desc,iconname,effects,quality=self:getBuffData(buffType,buffId)
local showQuality=quality==2

widget:SetChildActive(CmpRecordItemIndex.nameH,showQuality)
widget:SetChildActive(CmpRecordItemIndex.iconH,showQuality)
widget:SetChildActive(CmpRecordItemIndex.attrsH,showQuality)
widget:SetChildActive(CmpRecordItemIndex.selectBtnH,showQuality and isRandom)
widget:SetChildActive(CmpRecordItemIndex.stateH,showQuality and not isRandom)
widget:SetChildActive(CmpRecordItemIndex.nameL,not showQuality)
widget:SetChildActive(CmpRecordItemIndex.iconL,not showQuality)
widget:SetChildActive(CmpRecordItemIndex.attrsL,not showQuality)
widget:SetChildActive(CmpRecordItemIndex.selectBtnL,not showQuality and isRandom)
widget:SetChildActive(CmpRecordItemIndex.stateL,not showQuality and not isRandom)

local idx_name=showQuality and CmpRecordItemIndex.nameH or CmpRecordItemIndex.nameL
local idx_icon=showQuality and CmpRecordItemIndex.iconH or CmpRecordItemIndex.iconL
local idx_attrs=showQuality and CmpRecordItemIndex.attrsH or CmpRecordItemIndex.attrsL
local idx_selectBtn=showQuality and CmpRecordItemIndex.selectBtnH or CmpRecordItemIndex.selectBtnL
local idx_state=showQuality and CmpRecordItemIndex.stateH or CmpRecordItemIndex.stateL
widget:SetChildText(idx_name,name)
widget:SetChildIcon(idx_icon,iconname,false)
widget:SetChildLayoutGroupClearAllItems(idx_attrs)
if buffType==1 then
local len=#effects
widget:SetChildLayoutGroupCreateItems(idx_attrs,len,function(index)
local widget_item=widget:GetChildLayoutGroupGridItem(idx_attrs,index-1)
local str=cfgHelper.get2(cfg_guildstateeffectconfig_get,effects[index],'desc')

widget_item:SetChildText(0,str)
end)
elseif buffType==2 or buffType==3 then
local len=1
widget:SetChildLayoutGroupCreateItems(idx_attrs,len,function(index)
local widget_item=widget:GetChildLayoutGroupGridItem(idx_attrs,index-1)

widget_item:SetChildText(0,desc)
end)
end

widget:SetChildCSImageSprite(idx_selectBtn,_ab,FMT.fmt("button_xingzhantequan_{0}",showQuality and 4 or 2))
widget:SetChildCSImageSprite(idx_state,_ab,FMT.fmt("image_xingzhantequan_wz{0}",showQuality and 2 or 3))

widget:SetChildButtonClick(idx_selectBtn,function()
if self.hasCardAnimNum>0 then
UIManager.error("正在星占中")
return
end
widget:SetChildDOScale(-1,0.9,0.2,function()
widget:SetChildDOScale(-1,1,0.2,nil)
end)
local json_str=jsonHelper.encode({1,index})
self.selectItemIdx=index
xianguanController.sendUsePrivilege(self.xgId,self.tqId,json_str)
end)
end

local moveIdx=0
local moveTime=0.5
local isSelectOther=false
if isSelect then
local data=self.buffList[self.selectItemIdx]
isSelectOther=data.param_1==3
end
if isRandom then
self.hiddenBuffList:setChildLayoutGroupClearAllItems()
end
if isShowBuffList then
self.hasCardAnimNum=3
self.hiddenBuffList:setChildLayoutGroupCreateItems(3,function(index)
local widget=self.hiddenBuffList:getChildLayoutGroupGridItem(index-1)

local data=self.buffList[index]
if data~=nil then
local pos=cardPos[index]
widget:SetChildCanvasGroupAlpha(-1,1)
local buffType=data.param_1
local buffId=data.param_2
local name,desc,iconname,effects,quality=self:getBuffData(buffType,buffId)
if isRandom then

widget:SetChildCanvasGroupAlpha(CmpRecordItemIndex.root,0)
widget:SetChildAnchoredPosition(-1,Vector2.New(pos[1],pos[2]))
if isInit then
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.stand],1,nil)
widget:SetChildCanvasGroupDOFade(CmpRecordItemIndex.root,1,0.5,function()
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
callFunc(widget,index,data)
else
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,-1,0,nil)
widget:SetChildAnchoredPosition(CmpRecordItemIndex.mbg,Vector2.New(0,600))
if self.isJumpAni then
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.stand],1,nil)
widget:SetChildDOAnchorPosY(CmpRecordItemIndex.mbg,0,moveTime,function()
widget:SetChildCanvasGroupDOFade(CmpRecordItemIndex.root,1,0.5,nil)
callFunc(widget,index,data)
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
else
local effectIdx=math.random(1,#cardEffectID[quality][index])
widget:SetChildShowEffect(CmpRecordItemIndex.effect,cardEffectID[quality][index][effectIdx],true)
widget:SetChildAnchoredPosition(CmpRecordItemIndex.mbg,Vector2.New(0,600))
self:delayDo(1.5,function()
widget:SetChildDOAnchorPosY(CmpRecordItemIndex.mbg,0,moveTime,function()
widget:SetChildShowEffect(CmpRecordItemIndex.effect,-1,false)
widget:SetChildCanvasGroupDOFade(CmpRecordItemIndex.root,1,0.5,nil)
callFunc(widget,index,data)
end)
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.enter],1,function()
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.stand],1,nil)
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
end)
end
end
elseif isSelect then
local isShow
if isSelectOther then
isShow=self.selectItemIdx~=index
else
isShow=self.selectItemIdx==index
end
if isShow then
local showQuality=quality==2
local idx_selectBtn=showQuality and CmpRecordItemIndex.selectBtnH or CmpRecordItemIndex.selectBtnL
local idx_state=showQuality and CmpRecordItemIndex.stateH or CmpRecordItemIndex.stateL
if self.isJumpAni then
widget:SetChildActive(idx_state,false)
widget:SetChildActive(idx_selectBtn,false)
moveIdx=moveIdx+1
local posEx=isSelectOther and cardPosEx[moveIdx]or{0,0}
if not isSelectOther and index==2 then
widget:SetChildActive(idx_state,not isRandom)
widget:SetChildActive(idx_selectBtn,isRandom)
self.hasCardAnimNum=self.hasCardAnimNum-1
else
widget:SetChildDOAnchorPos(-1,Vector2.New(posEx[1],posEx[2]),moveTime,function()
widget:SetChildActive(idx_state,not isRandom)
widget:SetChildActive(idx_selectBtn,isRandom)
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
end
else
widget:SetChildActive(idx_state,false)
widget:SetChildActive(idx_selectBtn,false)
moveIdx=moveIdx+1
local posEx=isSelectOther and cardPosEx[moveIdx]or{0,0}
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.enter2],1,function()
widget:SetChildSpineAnimation(CmpRecordItemIndex.mbg,cardAnimID[quality][cardAnimState.stand],1,nil)
widget:SetChildActive(idx_state,not isRandom)
widget:SetChildActive(idx_selectBtn,isRandom)
if not isSelectOther and index==2 then
self.hasCardAnimNum=self.hasCardAnimNum-1
else
widget:SetChildDOAnchorPos(-1,Vector2.New(posEx[1],posEx[2]),moveTime,function()
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
end
end)
end
else
widget:SetChildDOAnchorPosY(-1,pos[2]+600,moveTime,function()
widget:SetChildCanvasGroupAlpha(-1,0)
self.hasCardAnimNum=self.hasCardAnimNum-1
end)
end
end
else
widget:SetChildCanvasGroupAlpha(-1,0)
self.hasCardAnimNum=self.hasCardAnimNum-1
end
end)
if isRandom then
if self.isJumpAni or isInit then
self.tipsText:setChildCanvasGroupDOFade(1,0.5,nil)
else
self:delayDo(moveTime+1.5,function()
self.tipsText:setChildCanvasGroupDOFade(1,0.5,nil)
end)
end
end
end
end

function xgTeQuan_XZDS_mainWin:refreshRight()
self.rightPanel:setChildSizeDelta(108,self.isShowAll and 458 or 160)
self.showAllBtn:setCSImageSprite(_ab,FMT.fmt("image_xingzhantequan_{0}",self.isShowAll and 3 or 2))

local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,self.tqId)
local list=privilegeCfg.effectArgs[3]
local c=#list

self.listContent:setChildLayoutGroupCreateItems(c,function(index)
local item=self.listContent:getChildLayoutGroupGridItem(index-1)
local buffType=list[index][1][1]
local buffId=list[index][1][2]
local name,desc,iconname,effects=self:getBuffData(buffType,buffId)
item:SetChildIcon(1,iconname,false)
item:SetChildButtonClick(0,function()
if self.selectShowIdx==index then
self.selectShowIdx=nil
self.buffTips:setChildCanvasGroupAlpha(0)
self.closeBuffTipsBtn:setActive(false)
return
end
self.selectShowIdx=index

self.buffTips:setChildCanvasGroupAlpha(1)
self.closeBuffTipsBtn:setActive(true)

local pos=self.listContent:getChildAnchoredPosition()
local itemPos=item:GetChildAnchoredPosition(-1)
self.buffTips:setChildAnchoredPosition(Vector2(-89,pos.y+itemPos.y))

local widget=self.buffTips:getWidgetBase()
widget:SetChildIcon(0,iconname,false)
widget:SetChildText(1,name)
widget:SetChildLayoutGroupClearAllItems(2)
if buffType==1 then
local len=#effects
widget:SetChildLayoutGroupCreateItems(2,len,function(w_index)
local widget_item=widget:GetChildLayoutGroupGridItem(2,w_index-1)
local str=cfgHelper.get2(cfg_guildstateeffectconfig_get,effects[w_index],'desc')
str=string.gsub(str,"aae252","549327")
widget_item:SetChildText(0,str)
end)
elseif buffType==2 or buffType==3 then
local len=1
widget:SetChildLayoutGroupCreateItems(2,len,function(w_index)
local widget_item=widget:GetChildLayoutGroupGridItem(2,w_index-1)
desc=string.gsub(desc,"aae252","549327")
widget_item:SetChildText(0,desc)
end)
end
end)
end)
end

function xgTeQuan_XZDS_mainWin:getBuffData(buffType,buffId)
if buffType==1 then
local buffCfg=cfgHelper.get2(cfg_guildstateconfig_get,buffId)
local iconname=iconHelper.getzmStateIcon(buffCfg.icon)
return buffCfg.name,nil,iconname,buffCfg.effects or{},buffCfg.xzds_quality
elseif buffType==2 then
local buffCfg=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffId)
return buffCfg.name,buffCfg.desc,buffCfg.iconNmae,nil,buffCfg.xzds_quality
elseif buffType==3 then
local buff=cfgHelper.get2(cfg_xianguanbaseconfig_get,1,"randBuff_getOtherBuff")
return buff[1],buff[2],buff[3],nil,buff[4]
end
end

function xgTeQuan_XZDS_mainWin:freshTeQuanOptionChangePart()
local tqId=self.tqId
local jobId=self.xgId
local key=xianguanConfig.getTeQuanFindKey(jobId,tqId)
local obj=xianguanModel:getSelfTequanObj(key)
local data=obj.data

local isShowCD=xianguanModel:callTeQuanObjFunc(jobId,tqId,'checkInCd')

self.cdTxt:setActive(isShowCD)

local maxUseNum=xianguanConfig.getTeQuanCfg(tqId,"times")
local usedTimes=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getTimes")or 0
local residueTimes=maxUseNum-usedTimes
local isCanUse=residueTimes>0
local color=isCanUse and"#F9F9F9"or"#f36666"
local timesStr=FMT.fmt("剩余次数：<color={2}>{0}</color>/{1}",residueTimes,maxUseNum,color)
self.costTxt:setText(timesStr)
self.costTxt:setChildAnchoredPosition(Vector2(2,isShowCD and-170 or-345))

if isShowCD then
self:startCDTimer()
end
end

function xgTeQuan_XZDS_mainWin:refreshJumpAnimation()
self.isJumpAni=userActorSetting.get('xgTeQuanXZDSJumpAniState',false)
self.jumpAnimation:setToggle(self.isJumpAni)
end

function xgTeQuan_XZDS_mainWin:saveJumpAniState()
userActorSetting.set('xgTeQuanXZDSJumpAniState',_this.isJumpAni or false,false)
userActorSetting.flush()
end


function xgTeQuan_XZDS_mainWin:startCDTimer()
self:stopCDTimer()

local tqId=self.tqId
local jobId=self.xgId

local cd=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getCd")
local curTime=timeHelper.getServerShortTime()

local dval=0
local callback=function()
curTime=timeHelper.getServerShortTime()
dval=cd-curTime

if dval>0 then
_this.cdTxt:setText(string.format("<color=#f36666>%s</color>",timeHelper.format_time_stamp4(dval)))
else
_this:stopCDTimer()
_this:freshTeQuanOptionChangePart()
end
end

self.cdTimer=self:setTimer(1,0,callback)

self.cdTxt:setText(string.format("<color=#f36666>%s</color>",timeHelper.format_time_stamp4(cd-curTime)))
end

function xgTeQuan_XZDS_mainWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end





function xgTeQuan_XZDS_mainWin:onCloseBtn()
self:closeSelf()
end



function xgTeQuan_XZDS_mainWin:onFindBtn()
local tqId=self.tqId
local jobId=self.xgId
if self.hasCardAnimNum>0 then
UIManager.error("正在星占中")
return
end

local key=xianguanConfig.getTeQuanFindKey(jobId,tqId)
local obj=xianguanModel:getSelfTequanObj(key)
local data=obj.data
if data.len>0 then
UIManager.error("未选择星占效果")
return
end
local isNotTime=xianguanModel:callTeQuanObjFunc(jobId,tqId,'checkUseTimes')
if isNotTime then
UIManager.error("星占次数不足")
return
end
local isInCD=xianguanModel:callTeQuanObjFunc(jobId,tqId,'checkInCd')
if isInCD then
local cd=xianguanModel:callTeQuanObjFunc(jobId,tqId,"getCd")
local curTime=timeHelper.getServerShortTime()
local dval=cd-curTime
UIManager.error(string.format("<color=#f36666>%s</color>后可星占",timeHelper.format_time_stamp4(dval)))
return
end

local flag=xianguanHelper.checkTeQuanUseCondition(data.xgid,data.tqid,true)
if not flag then
return
end

self.findBtn:setChildModelAnimationState(eAnimationID.enter,1)
if not self.isJumpAni then
self.mbg:setChildModelAnimationState(eAnimationID.enter,1)
end
xianguanController.sendUsePrivilege(jobId,tqId)
end



function xgTeQuan_XZDS_mainWin:onInfoBtn()
local d={}
d.mode=3
d.title="说明"
d.name='xgTeQuan_XZDS_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end



function xgTeQuan_XZDS_mainWin:onShowAllBtn()
if self.isRightAnim then return end
self.isRightAnim=true
self.isShowAll=not self.isShowAll
local cur_height=self.isShowAll and 458 or 160
self.rightPanel:setChildDOSizeDelta(Vector2(108,cur_height),0.5,function()
_this.isRightAnim=false
end)
self.showAllBtn:setCSImageSprite(_ab,FMT.fmt("image_xingzhantequan_{0}",self.isShowAll and 3 or 2))

if self.selectShowIdx then
self.selectShowIdx=nil
self.buffTips:setChildCanvasGroupAlpha(0)
self.closeBuffTipsBtn:setActive(false)
end
end

function xgTeQuan_XZDS_mainWin:onJumpAnimation(name,jump,data)
self.isJumpAni=jump
end



function xgTeQuan_XZDS_mainWin:onCloseBuffTipsBtn()
self.selectShowIdx=nil
self.buffTips:setChildCanvasGroupAlpha(0)
self.closeBuffTipsBtn:setActive(false)
end



function xgTeQuan_XZDS_mainWin:onOkBtn()
if self.hasCardAnimNum>0 then return end
self.selectData=nil
self:refreshAll()
end


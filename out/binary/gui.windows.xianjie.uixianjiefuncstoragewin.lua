







def_class("UIXianJieFuncStorageWin",UIWindowBase)









function UIXianJieFuncStorageWin:bindComponents()

self.funcBtn_Email=UIButton.get(self,0)
self.funcBtn_JieYin=UIButton.get(self,1)
self.funcBtn_Log=UIButton.get(self,2)
self.funcBtn_LTYWReward=UIButton.get(self,3)
self.funcBtn_MoJieRecord=UIButton.get(self,4)
self.funcBtn_XingYu=UIButton.get(self,5)
self.funcBtn_YuLingZhai=UIButton.get(self,6)
self.funcBtn_ZaWuBu=UIButton.get(self,7)
self.funcList=UIObject.get(self,8)
self.funcListbtn=UIButton.get(self,9)
self.funcListbtnselect=UIObject.get(self,10)
self.funcListReddot=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.underAttackBtn=UIButton.get(self,13)
self.funcBtn_LTYWCompensation=UIButton.get(self,14)
self.funcBtn_GateApply=UIButton.get(self,15)
self.funcBtn_MiZang=UIButton.get(self,16)
self.HQTBtn=UIButton.get(self,17)

self.funcBtn_Email:setButtonClick(function()self:onFuncBtn_Email()end)

self.funcBtn_JieYin:setButtonClick(function()self:onFuncBtn_JieYin()end)

self.funcBtn_Log:setButtonClick(function()self:onFuncBtn_Log()end)

self.funcBtn_LTYWReward:setButtonClick(function()self:onFuncBtn_LTYWReward()end)

self.funcBtn_MoJieRecord:setButtonClick(function()self:onFuncBtn_MoJieRecord()end)

self.funcBtn_XingYu:setButtonClick(function()self:onFuncBtn_XingYu()end)

self.funcBtn_YuLingZhai:setButtonClick(function()self:onFuncBtn_YuLingZhai()end)

self.funcBtn_ZaWuBu:setButtonClick(function()self:onFuncBtn_ZaWuBu()end)

self.funcListbtn:setButtonClick(function()self:onFuncListbtn()end)

self.underAttackBtn:setButtonClick(function()self:onUnderAttackBtn()end)

self.funcBtn_LTYWCompensation:setButtonClick(function()self:onFuncBtn_LTYWCompensation()end)

self.funcBtn_GateApply:setButtonClick(function()self:onFuncBtn_GateApply()end)

self.funcBtn_MiZang:setButtonClick(function()self:onFuncBtn_MiZang()end)

self.HQTBtn:setButtonClick(function()self:onHQTBtn()end)
self.funcBtn={
["Email"]=self.funcBtn_Email,
["JieYin"]=self.funcBtn_JieYin,
["Log"]=self.funcBtn_Log,
["LTYWReward"]=self.funcBtn_LTYWReward,
["MoJieRecord"]=self.funcBtn_MoJieRecord,
["XingYu"]=self.funcBtn_XingYu,
["YuLingZhai"]=self.funcBtn_YuLingZhai,
["ZaWuBu"]=self.funcBtn_ZaWuBu,
["LTYWCompensation"]=self.funcBtn_LTYWCompensation,
["GateApply"]=self.funcBtn_GateApply,
["MiZang"]=self.funcBtn_MiZang,
}



end


function UIXianJieFuncStorageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.funcBtn_Email);self.funcBtn_Email=nil;
_UIObject_release(self.funcBtn_JieYin);self.funcBtn_JieYin=nil;
_UIObject_release(self.funcBtn_Log);self.funcBtn_Log=nil;
_UIObject_release(self.funcBtn_LTYWReward);self.funcBtn_LTYWReward=nil;
_UIObject_release(self.funcBtn_MoJieRecord);self.funcBtn_MoJieRecord=nil;
_UIObject_release(self.funcBtn_XingYu);self.funcBtn_XingYu=nil;
_UIObject_release(self.funcBtn_YuLingZhai);self.funcBtn_YuLingZhai=nil;
_UIObject_release(self.funcBtn_ZaWuBu);self.funcBtn_ZaWuBu=nil;
_UIObject_release(self.funcList);self.funcList=nil;
_UIObject_release(self.funcListbtn);self.funcListbtn=nil;
_UIObject_release(self.funcListbtnselect);self.funcListbtnselect=nil;
_UIObject_release(self.funcListReddot);self.funcListReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.underAttackBtn);self.underAttackBtn=nil;
_UIObject_release(self.funcBtn_LTYWCompensation);self.funcBtn_LTYWCompensation=nil;
_UIObject_release(self.funcBtn_GateApply);self.funcBtn_GateApply=nil;
_UIObject_release(self.funcBtn_MiZang);self.funcBtn_MiZang=nil;
_UIObject_release(self.HQTBtn);self.HQTBtn=nil;
self.funcBtn=nil;
end















local _this
local _simpleKey="UIXianJieFuncStorageWin.funcList"




function UIXianJieFuncStorageWin:onLoaded(...)
self:bindComponents()
_this=self

self.bShowFuncList=true
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addProNotify(35,8,self.on_35_8)
self:addProNotify(35,9,self.on_35_9)
self:addProNotify(35,150,self.on_35_150)

self:addNotify(notifyConfig.on_mail_changed,self.on_mail_changed)
self:addNotify(notifyConfig.on_item_changed,self.on_item_change)



self:addNotify(notifyConfig.onXianJieMainWinSimpleStateChange,self.onXianJieMainWinSimpleStateChange)
end


function UIXianJieFuncStorageWin:__delete()
self:clearFLTweener()
self:clearShowTimer()
self:unbindComponents()
_this=nil
end




function UIXianJieFuncStorageWin:onShow(argtable,afterOnloaded)
self:refresh()
self:refreshReddot()
end


function UIXianJieFuncStorageWin:onHide()

end

function UIXianJieFuncStorageWin:refresh()








self.timerFunList={}
self.showBtns={}
for name,btn in pairs(self.funcBtn)do
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
if show then
self.showBtns[name]=true
end
end
self.showRoot=next(self.showBtns)~=nil
self.root:setActive(self.showRoot)

self:refreshXiJiBtn()
self:refreshActTimer()
self:freshFuncListAcive()
self:refreshHQTbtn()
end

function UIXianJieFuncStorageWin.on_mail_changed()
_this:refreshEmail()
end

function UIXianJieFuncStorageWin:refreshReddot()
if self.showRoot and not self.bShowFuncList then
local isReddot=self:checkReddot()
self.funcListReddot:setActive(isReddot)
end
end

function UIXianJieFuncStorageWin:refreshFuncButton(name)
if self.showRoot then
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
self.showBtns[name]=show or nil

local showRoot=next(self.showBtns)~=nil
self.root:setActive(showRoot)

if showRoot and not self.bShowFuncList then
self:refreshReddot()
end
end
end

function UIXianJieFuncStorageWin:refreshFuncButtons(names)
if self.showRoot then
for idx,name in ipairs(names)do
local refreshName=FMT.fmt("refresh{0}",name)
local show=self[refreshName](self)
self.showBtns[name]=show or nil
end

local showRoot=next(self.showBtns)~=nil
self.root:setActive(showRoot)

if showRoot and not self.bShowFuncList then
self:refreshReddot()
end
end
end

function UIXianJieFuncStorageWin:freshFuncListAcive()
self.bShowFuncList=not xianjieMainWinSimpleModeConfig:getRecordState(_simpleKey)
self.funcList:setActive(self.bShowFuncList)
self.funcListbtnselect:setActive(self.bShowFuncList)
if self.bShowFuncList then
self.funcListReddot:setActive(false)
end
self.funcList:setChildCanvasGroupAlpha(self.bShowFuncList and 1 or 0)
end

function UIXianJieFuncStorageWin:changeFuncListShow()
self.bShowFuncList=not xianjieMainWinSimpleModeConfig:changeRecordState(_simpleKey)

self:clearFLTweener()
if self.bShowFuncList then
self.funcList:setActive(true)
self.flTweener=self.funcList:setChildCanvasGroupDOFade(1,0.5,nil)
self.funcListReddot:setActive(false)
else
self.flTweener=self.funcList:setChildCanvasGroupDOFade(0,0.5,function()
self.funcList:setActive(false)
end)
end
self.funcListbtnselect:setActive(self.bShowFuncList)

self:refresh()
if not self.bShowFuncList then
self:refreshReddot()
end
end

function UIXianJieFuncStorageWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
self:endAllReddotPunchRotation()
end

function UIXianJieFuncStorageWin:checkReddot()
for name,btn in pairs(self.funcBtn)do
if self.showBtns[name]then
local funcName=FMT.fmt("check{0}Reddot",name)
local func=self[funcName]
if func and func(self)then
return true
end
end
end
return false
end


function UIXianJieFuncStorageWin.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eJianZhuTiShi then
_this:refreshFuncButton("ZaWuBu")
end
end

function UIXianJieFuncStorageWin.onXianJieMainWinSimpleStateChange()
_this:freshFuncListAcive()
end




function UIXianJieFuncStorageWin:onFuncListbtn()
self:changeFuncListShow()
end

function UIXianJieFuncStorageWin:onFuncBtn_ZaWuBu()
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=self.fastMarPage})
end

function UIXianJieFuncStorageWin:refreshZaWuBu()
local check=systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)
self.funcBtn_ZaWuBu:setActive(check)
if not check then
return false
end
local widget=self.funcBtn_ZaWuBu:getChildWidgetBase()
local num=0
local mNum=xiaodaotongModel:getManufactureReddotNum()
local bdNum=xiaodaotongModel:getBuildingReddotNum()
local tipsNum=xiaodaotongModel:getReddotNum()or 0
num=num+mNum+bdNum+tipsNum
if tipsNum>0 then
self.fastMarPage=3
elseif mNum>0 then
self.fastMarPage=1
elseif bdNum>0 then
self.fastMarPage=2
else
self.fastMarPage=3
end
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)

return num>0
end

function UIXianJieFuncStorageWin:refreshLog()
local check=systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)
self.funcBtn_Log:setActive(check)
if not check then
return false
end




local isReddot=xianjieModel:get_monsterReddot()or xianjieModel:get_ResourceReddot()or xianjieModel:isNewRiZhi()or xianjieModel:Get_reddotchangeflag()
self:refreshNoteReddot(isReddot)
return isReddot
end
function UIXianJieFuncStorageWin:refreshNoteReddot(isReddot)
local widget=self.funcBtn_Log:getChildWidgetBase()
widget:SetChildActive(5,isReddot)
if isReddot then
if self.reddotTweener==nil then

widget:SetChildRotation(5,0,0,0)
local tweener=widget:SetChildDOPunchRotation(5,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
widget:SetChildRotation(5,0,0,0)
end
end
end

function UIXianJieFuncStorageWin:refreshFuncBtn_Log()
_this:refreshLog()
end
function UIXianJieFuncStorageWin:onFuncBtn_Log()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
end

function UIXianJieFuncStorageWin.on_35_8()

end

function UIXianJieFuncStorageWin.on_35_9()

end

function UIXianJieFuncStorageWin:refreshXiJiBtn()
local vis=xianjieModel:isUnderAttack()
self.underAttackBtn:setActive(vis)
local btnWidget=self.underAttackBtn:getChildWidgetBase()
local widgetId=self.underAttackBtn:getID()
local func=function()
return xianjieModel:getMinLeftAttackTime()
end
self:startLeftTimer(btnWidget,widgetId,5,4,func)
self:doPunchRotation(btnWidget,3,widgetId,vis)
end

function UIXianJieFuncStorageWin:onUnderAttackBtn()



















local tabType=xianjieModel:getFirstTabType()
if tabType==ATTACKTABTYPE.eMJ then
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoJie,tabType=tabType}})
elseif tabType==ATTACKTABTYPE.eMG then
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoGong,tabType=tabType}})
else
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eSelfZMPos}})
end
end


function UIXianJieFuncStorageWin:refreshLTYWReward()
local isCanGet=xianJieArenaActModel:checkIsCanGetArenaReward()
local isInSettlement,delaySettleTime=xianJieArenaActController:checkActIsInSettlement()
local isNeedShowBtn
if isCanGet then
isNeedShowBtn=true
else
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen_ignoreCustomCdn()
if isOpen then
local isDoing=xianJieArenaActModel:checkIsXJArenaActDoing()
if isDoing then
isInSettlement=false
end
isNeedShowBtn=isInSettlement
else

isNeedShowBtn=false
end
end
self.funcBtn_LTYWReward:setActive(isNeedShowBtn)
if isNeedShowBtn then
local widget=self.funcBtn_LTYWReward:getChildWidgetBase()
widget:SetChildActive(2,isInSettlement)
end

return isCanGet
end

function UIXianJieFuncStorageWin:onFuncBtn_LTYWReward()
local page=4

local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen_ignoreCustomCdn()
local isDoing=xianJieArenaActModel:checkIsXJArenaActDoing()
local isInSettlement,delaySettleTime=xianJieArenaActController:checkActIsInSettlement()
if isOpen and not isDoing and not isInSettlement then
msgWinControl:addMsgWin(msgWinType.eLTYWRankBg,{page=page,extraArgs={isAutoOpen=true}})
else
UIManager.error("演武结算中，请稍候")
end
end


function UIXianJieFuncStorageWin:refreshLTYWCompensation()
local hasCompensation=xianJieArenaActModel:checkArenaHasCompensation()
self.funcBtn_LTYWCompensation:setActive(hasCompensation)
return hasCompensation
end
function UIXianJieFuncStorageWin:onFuncBtn_LTYWCompensation()
xianJieArenaActController:openArenaCompensationWin()
end


function UIXianJieFuncStorageWin:refreshGateApply()
local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local check
if showGateApplyBtn then
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
check=num>0
local widget=self.funcBtn_GateApply:getChildWidgetBase()

self.funcBtn_GateApply:setActive(check)
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
else
check=false
self.funcBtn_GateApply:setActive(check)
end

return check
end

function UIXianJieFuncStorageWin:onFuncBtn_GateApply()
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
return
end

local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
xianjieController:jumpMoJieGateByGateId(selfXmOwnGateId,true,true)
end

function UIXianJieFuncStorageWin:checkGateApplyReddot()
local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
if showGateApplyBtn then
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
return num>0
end
return false
end











































































function UIXianJieFuncStorageWin:refreshEmail()
local num=mailModel:getReddotCount()
local check=num>0
self.funcBtn_Email:setActive(check)
if not check then
return
end
local widget=self.funcBtn_Email:getChildWidgetBase()

local glableCfg=cfg_globalconfig_get(1)
local MaxCount=glableCfg.maxmail
if num>MaxCount then
num=MaxCount
end

widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end


function UIXianJieFuncStorageWin:refreshJieYin()
local vis=jiuchongtianjieGuideController:checkShowSupportEnter()

local widget=self.funcBtn_JieYin:getChildWidgetBase()
widget:SetChildActive(-1,vis)
if vis then
local reddot=jiuchongtianjieGuideController:getSupportReddot()
local widgetId=self.funcBtn_JieYin:getID()
self:doPunchRotation(widget,3,widgetId,reddot)

widget:SetChildActive(3,reddot)
end
end

function UIXianJieFuncStorageWin:checkJieYinReddot()
return false
end

function UIXianJieFuncStorageWin:onFuncBtn_JieYin()

UIManager:showWindow("UIXianJieJieYin_SupportWin")
end


function UIXianJieFuncStorageWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.mz_moneyId and _this.mz_moneyId==itemid then
_this:checkMiZangReddot()
end
end
function UIXianJieFuncStorageWin:refreshMiZang()
local csid=xianjieModel:getMoJieEnterConfig("csid")
local cfg=nil
if csid then
cfg=cfg_devildomshenyuanmizangconfig_get(csid)
end
if not cfg then
cfg=cfg_devildomshenyuanmizangconfig_get(1)
end
local cost=cfg.cost
if cost and cost[1]and cost[1][1]then
_this.mz_moneyId=cost[1][1]
end
local vis=xianjieController:check_MjJieDuanSan_SYMZEnter()
local widget=self.funcBtn_MiZang:getChildWidgetBase()
widget:SetChildActive(-1,vis)
if vis then
local reddot=xianjieController:check_MjJieDuanSan_SYMZReddot()
local widgetId=self.funcBtn_MiZang:getID()
self:doPunchRotation(widget,3,widgetId,reddot)
widget:SetChildActive(3,reddot)
end
end

function UIXianJieFuncStorageWin:checkMiZangReddot()
local widget=_this.funcBtn_MiZang:getChildWidgetBase()
local reddot=xianjieController:check_MjJieDuanSan_SYMZReddot()
local widgetId=_this.funcBtn_MiZang:getID()
_this:doPunchRotation(widget,3,widgetId,reddot)
widget:SetChildActive(3,reddot)
end
function UIXianJieFuncStorageWin:onFuncBtn_MiZang()
xianjieController:open_MjJieDuanSan_SYMZWin()
end


function UIXianJieFuncStorageWin:refreshHQTbtn()
local check=LunHuiDianModel:getHYReddot()
self.HQTBtn:setActive(check)
local widget=self.HQTBtn:getChildWidgetBase()
local widgetId=self.HQTBtn:getID()
self:doPunchRotation(widget,3,widgetId,check)
widget:SetChildActive(3,check)
end

function UIXianJieFuncStorageWin:onHQTBtn()
LunHuiDianModel:jumpHQTWin()
end








function UIXianJieFuncStorageWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIXianJieFuncStorageWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then

v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)
end
end
self.reddotTweenerList=nil
end












function UIXianJieFuncStorageWin:onFuncBtn_Email()
local reddot=mailController:hasReddot()
if reddot then
mailController:showMailUI()
end

end

function UIXianJieFuncStorageWin:refreshActTimer()
local isShowTimer=next(self.timerFunList)

if isShowTimer and self.bShowFuncList then
if self.showTimer==nil then
self.showTimer=self:setTimer(1,0,function()
if _this==nil then return end
_this:onShowUpdate()
end)
end
else
self:clearShowTimer()
end
end

function UIXianJieFuncStorageWin:clearShowTimer()
if self.showTimer~=nil then
self:stopTimerByID(self.showTimer)
self.showTimer=nil
end
end

function UIXianJieFuncStorageWin:onShowUpdate()

for name,func in pairs(self.timerFunList)do
func(self)
end
end

























function UIXianJieFuncStorageWin:refreshView()
if self.bShowFuncList then
self:refresh()
else
self:refreshReddot()
end
end


function UIXianJieFuncStorageWin:startLeftTimer(widget,widgetId,rootIdx,tIdx,func)
if self.timerList==nil then self.timerList={}end
self:stopLeftTimer(widgetId)
local lefTime=func()
if lefTime<=0 then
widget:SetChildActive(rootIdx,false)
return
end
widget:SetChildActive(rootIdx,true)
local tick=function()
local lefTime=func()
if lefTime>0 then
widget:SetChildText(tIdx,FMT.fmt("<color=#a1ec58>{0}</color>",timeHelper.format_time_stamp12(lefTime)))
else
widget:SetChildActive(rootIdx,false)
self:stopLeftTimer(widgetId)
end
end
self.timerList[widgetId]=self:setTimer(1,0,tick)
tick()
end

function UIXianJieFuncStorageWin:stopLeftTimer(widgetId)
if self.timerList==nil then return end
if self.timerList[widgetId]then
self:stopTimerByID(self.timerList[widgetId])
self.timerList[widgetId]=nil
end
end


function UIXianJieFuncStorageWin:hideFuncList()
if _this.bShowFuncList then
_this:onFuncListbtn()
end
end



function UIXianJieFuncStorageWin:checkXingYuReddot()
return XingYuController.checkXingYuReddot()
end


function UIXianJieFuncStorageWin:refreshXingYu()
local flag=XingYuController.checkXingYuReddot()
self.funcBtn_XingYu:setActive(flag)
local btnWidget=self.funcBtn_XingYu:getChildWidgetBase()
local num=XingYuController.getXingYuReddotCnt()
btnWidget:SetChildActive(3,num>0)
btnWidget:SetChildText(4,num)
return flag
end

function UIXianJieFuncStorageWin:onFuncBtn_XingYu()
XingYuController.showGetReward()
end

function UIXianJieFuncStorageWin:refreshYuLingZhai()
local state=YuLingZhaiModel:getHealType()
self.funcBtn_YuLingZhai:setActive(state==1)
end

function UIXianJieFuncStorageWin:checkYuLingZhaiReddot()
local state=YuLingZhaiModel:getHealType()
return state==1
end

function UIXianJieFuncStorageWin:onFuncBtn_YuLingZhai()
UIFullYuLingZhaiControl:showMainWindow()
end

function UIXianJieFuncStorageWin:refreshMoJieRecord()
local show=xianjieModel:haveMoJiRecordData()and xianjieModel:checkMoJieRecordData()
self.funcBtn_MoJieRecord:setActive(show)
end

function UIXianJieFuncStorageWin:onFuncBtn_MoJieRecord()
local show=xianjieModel:haveMoJiRecordData()and xianjieModel:checkMoJieRecordData()
if show then
UIManager:showWindow("UIMoJieRecordWin")
end
end

function UIXianJieFuncStorageWin.on_35_150()
_this:refreshMoJieRecord()
_this:refreshMiZang()
end

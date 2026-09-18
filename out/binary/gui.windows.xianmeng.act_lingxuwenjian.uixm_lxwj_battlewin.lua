







def_class("UIXM_LXWJ_BattleWin",UIWindowBase)









function UIXM_LXWJ_BattleWin:bindComponents()

self.attackNumObj=UIObject.get(self,0)
self.bottomPanel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.cloudItem=UIObject.get(self,3)
self.defBtn=UIButton.get(self,4)
self.InvolvePanel=UIObject.get(self,5)
self.leftGridPanel=UIObject.get(self,6)
self.leftPanel=UIObject.get(self,7)
self.mapRoot=UIObject.get(self,8)
self.notestBtn=UIButton.get(self,9)
self.rightGridPanel=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.scoreRanktBtn=UIButton.get(self,12)
self.status=UIText.get(self,13)
self.statusDesc=UIText.get(self,14)
self.statusIcon=UIImage.get(self,15)
self.uiRoot=UIObject.get(self,16)
self.wjtItem=UIObject.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.defBtn:setButtonClick(function()self:onDefBtn()end)

self.notestBtn:setButtonClick(function()self:onNotestBtn()end)

self.scoreRanktBtn:setButtonClick(function()self:onScoreRanktBtn()end)



end


function UIXM_LXWJ_BattleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attackNumObj);self.attackNumObj=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cloudItem);self.cloudItem=nil;
_UIObject_release(self.defBtn);self.defBtn=nil;
_UIObject_release(self.InvolvePanel);self.InvolvePanel=nil;
_UIObject_release(self.leftGridPanel);self.leftGridPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.notestBtn);self.notestBtn=nil;
_UIObject_release(self.rightGridPanel);self.rightGridPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scoreRanktBtn);self.scoreRanktBtn=nil;
_UIObject_release(self.status);self.status=nil;
_UIObject_release(self.statusDesc);self.statusDesc=nil;
_UIObject_release(self.statusIcon);self.statusIcon=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wjtItem);self.wjtItem=nil;
end
















local _this=nil
local lockInOpeningPanels={
['UIXM_LXWJ_WenJianWin']=true,
['UIXM_LXWJ_zhenyanWin']=true,
}


function UIXM_LXWJ_BattleWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onShowUI,self.onShowUI)
self.cloudWidget=self.cloudItem:getWidgetBase()
self.wjtWidget=self.wjtItem:getWidgetBase()
self.fazhenSpines={}
self.fazhenProgressTweeners={}
self.m_cav=self:getChildCanvas(-1)
self.uiRoot:setChildCanvas(self.m_cav[1],self.m_cav[2]+4)
self.cloudItem:setChildCanvas(self.m_cav[1],self.m_cav[2]+3)
end


function UIXM_LXWJ_BattleWin:__delete()
_this=nil
if self.cloudEffectID~=nil then
local widget=self.cloudWidget
widget:SetChildShowEffect(3,self.cloudEffectID,false)
self.cloudEffectID=nil
end
self:unbindComponents()
if lingxuwenjianModel:getEnterBattle()then
lingxuwenjianController:reqWJListen(0)
lingxuwenjianModel:setEnterBattle(nil)
end
self:closeExtraWin()
end

function UIXM_LXWJ_BattleWin:onHide_before()
if self.cloudEffectID~=nil then
local widget=self.cloudWidget
widget:SetChildShowEffect(3,self.cloudEffectID,false)
self.cloudEffectID=nil
end
end


function UIXM_LXWJ_BattleWin:onHide()
self:closeExtraWin()
self:clearMyTimer()
end

function UIXM_LXWJ_BattleWin.onShowUI(name)
if _this==nil then return end
if lockInOpeningPanels[name]==true then
_this.lockTime=nil
end
end

function UIXM_LXWJ_BattleWin:setLockTime(time)
self.lockTime=Time.realtimeSinceStartup+time
end

function UIXM_LXWJ_BattleWin:myShowPanel(name,args)
if lockInOpeningPanels[name]==true then
if not self:checkLockTime()then
return
end
self:setLockTime(1)
end
UIManager:showWindow(name,args)
end

function UIXM_LXWJ_BattleWin:checkLockTime()
if self.lockTime~=nil and Time.realtimeSinceStartup<self.lockTime then
return false
end
return true
end

function UIXM_LXWJ_BattleWin:closeExtraWin()
UIManager:closeWindow('UIXM_LXWJ_stateWin')
UIManager:closeWindow('UIXM_LXWJ_zhenyanWin')
UIManager:closeWindow('UIXM_LXWJ_WenJianWin')
UIManager:invokeUIMethod('UIXM_LXWJ_memberOneWin','onClickClose')
UIManager:invokeUIMethod('UIXM_LXWJ_memberThreeWin','onClickClose')
UIManager:closeWindow('UIXM_LXWJ_XMInfoWin')
end




function UIXM_LXWJ_BattleWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
lingxuwenjianModel:setEnterBattle(true)
UIManager:showWindow('UIXM_LXWJ_stateWin')
if afterOnloaded then
self:initWJT()
end
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshTime()

if afterOnloaded then
self:initMySide()
self:checkInitEnemySide()
else
self:refreshMyHome(nil)
self:refreshMyAllFaZhen()
self:checkInitEnemySide()
end

self:refreshWJT()


self.mapRoot:setChildAnchoredPos(0,0)


local checkJump=false
if argtable.openPos then
checkJump=true
self:doOpenPos(argtable.openPos)
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
self:delayDo(0.5,function()
lingxuwenjianController:doWeakGuide()
end)
end


if lingxuwenjianModel:hasEnemy()then
local checkStart=false
local checkOver=false
if self.raceState==eLXWJ_State.eFinish then
checkOver=true
elseif self.raceState==eLXWJ_State.eFight then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
checkStart=true
else
checkOver=true
end
end

if checkOver then
self:delayDo(1,function()
local isIn=newbieControl.isInNewbie()
if not isIn then
local raceIndex=lingxuwenjianModel:getRaceIndex()
local lunIndex=lingxuwenjianModel:getRaceLunIndex()
if lingxuwenjianModel:checkFisrtOver(raceIndex,lunIndex)then
UIManager:showWindow('UIXM_LXWJ_pipeiWin')
lingxuwenjianModel:markFisrtOver(raceIndex,lunIndex)
end
end
end)
elseif checkStart then
self:delayDo(1,function()
local isIn=newbieControl.isInNewbie()
if not isIn then
local raceIndex=lingxuwenjianModel:getRaceIndex()
local lunIndex=lingxuwenjianModel:getRaceLunIndex()
if lingxuwenjianModel:checkFisrtBegin(raceIndex,lunIndex)then
UIManager:showWindow('UIXM_LXWJ_pipeiWin')
lingxuwenjianModel:markFisrtBegin(raceIndex,lunIndex)
end
end
end)
end
end
end

function UIXM_LXWJ_BattleWin:doOpenPos(openPos)





if openPos[2]==0 then
local openReplayEx={}
openReplayEx.lxwjkey=openPos[3]
openReplayEx.openReplay=openPos.openReplay
UIManager:showWindow('UIXM_LXWJ_WenJianWin',{openReplayEx=openReplayEx})
else
local posData={openPos[1],openPos[2],openPos[3]}
posData.openReplay=openPos.openReplay
UIManager:showWindow('UIXM_LXWJ_zhenyanWin',{posData=posData})
end
end

function UIXM_LXWJ_BattleWin:clearMyTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
self.raceState=nil
self.fightState=nil
end
end

function UIXM_LXWJ_BattleWin:refreshTime()
local raceState,left=lingxuwenjianModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
if self.raceState==eLXWJ_State.eIdle then
self:onCloseBtn()
return
end
self:refreshAttackNum()
self:refreshCloudItem()
self:refreshDefBtn()
self:refreshInvolvePanel()
if self.raceState~=eLXWJ_State.eFight then
self:refreshWJT()
end
if self.raceState==eLXWJ_State.eStandby then
if raceState_old~=nil then
self:refreshMyHome(nil)
self:refreshMyAllFaZhen()
self:refreshEnemeyAllFaZhen()
end
elseif self.raceState==eLXWJ_State.eFight then
if raceState_old~=nil then
self:refreshMyHome(nil)
end
self.fightState=nil
elseif self.raceState==eLXWJ_State.eFinish then

end
end
if self.raceState==eLXWJ_State.eFight then
local fightState,left_=lingxuwenjianModel:getFightState()
local fightState_old=self.fightState
self.fightState=fightState
if self.fightState~=fightState_old then
self:refreshWJT()
end

if self.fightState==eLXWJ_Fight_State.eFight then
self:refreshWJTTime(left_)
end
end
self:refreshCloudTime(left)
end

function UIXM_LXWJ_BattleWin:refreshAttackNum()
local isshow=self.raceState==eLXWJ_State.eFight and lingxuwenjianModel:hasEnemy()
self.attackNumObj:setActive(isshow)
if isshow then
local widget=self.attackNumObj:getWidgetBase()
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or 0
local lerp=max-cur
widget:SetChildLayoutGroupCreateItems(0,max,function(i)
if _this==nil then return end
local item=widget:GetChildLayoutGroupGridItem(0,i-1)
local has=i<=lerp
local icon=has==true and'icon_xmgjian_1'or'icon_xmgjian_2'
item:SetChildCSImageSprite(-1,globalABLookup.lingxuwenjianicons,icon)
end)
end
end

function UIXM_LXWJ_BattleWin:refreshDefBtn()
local isshow=self.raceState~=eLXWJ_State.eFight
self.defBtn:setActive(isshow)
end

function UIXM_LXWJ_BattleWin:refreshInvolvePanel()
local isshow=lingxuwenjianModel:hasEnemy()and self.raceState==eLXWJ_State.eFight
self.InvolvePanel:setActive(isshow)
if isshow then
local isInvolve=lingxuwenjianModel:checkInDef()
local tipsInvolve=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'tipsMainWin')
local abName="ui/windows/xianmeng/act_lingxuwenjian/lingxuwenjianicons_atlas_pak.ab"
self.statusIcon:setSprite(abName,isInvolve and"image_shenfen_01"or"image_shenfen_02")
self.status:setText(isInvolve and"身份：<color=#4BABBC>防守成员</color>"or"身份：<color=#E9C774>非防守成员</color>")
self.statusDesc:setText(isInvolve and tipsInvolve[1]or tipsInvolve[2])
end
end


function UIXM_LXWJ_BattleWin:refreshCloudItem()
local showCloud=false
if self.raceState==eLXWJ_State.eStandby then
showCloud=true
elseif self.raceState==eLXWJ_State.eFight or self.raceState==eLXWJ_State.eFinish then
showCloud=not lingxuwenjianModel:hasEnemy()
end
if showCloud then
self.cloudItem:setChildCanvasGroupAlpha(1)
self.cloudItem:setChildCanvasGroupRaycast(true)
else
self.cloudItem:setChildCanvasGroupAlpha(0)
self.cloudItem:setChildCanvasGroupRaycast(false)
end
local widget=self.cloudWidget
if showCloud then
if self.cloudEffectID==nil then
self.cloudEffectID=10359
widget:SetChildShowEffect(3,self.cloudEffectID,true)
end
local pipeiSpID=nil
if self.raceState==eLXWJ_State.eStandby then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
pipeiSpID=4789
elseif self.raceState==eLXWJ_State.eFight then
local flag,cur,max=lingxuwenjianModel:checkBattleCond()
if flag then
if lingxuwenjianModel:hasEnemy()then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
pipeiSpID=4790
widget:SetChildText(2,'大战将启，请诸君为仙盟而战！')
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
local str=''



widget:SetChildText(1,str)
widget:SetChildText(2,'请等待下一轮匹配！')
end
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
local max=lingxuwenjianModel:getMaxJoinBattleNum()
widget:SetChildText(1,FMT.fmt('参与人数小于{0}人',max))
widget:SetChildText(2,'请等待下一轮匹配！')
end
elseif self.raceState==eLXWJ_State.eFinish then
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
local max=lingxuwenjianModel:getMaxJoinBattleNum()
widget:SetChildText(1,FMT.fmt('参与人数小于{0}人',max))
widget:SetChildText(2,'请等待下一轮匹配！')
end

if pipeiSpID~=self.pipeiSpID then
self.pipeiSpID=pipeiSpID
widget:SetChildActive(0,pipeiSpID~=nil)
if pipeiSpID~=nil then
widget:SetChildUIModelShowTarget(0,pipeiSpID,1,{},0,false,false,0,nil)
end
end
else
if self.cloudEffectID~=nil then
widget:SetChildShowEffect(3,self.cloudEffectID,false)
self.cloudEffectID=nil
end
end
end

function UIXM_LXWJ_BattleWin:refreshCloudTime(left)
if self.raceState==eLXWJ_State.eStandby then
local time_str=FMT.fmt('对手将于{0}后出现',timeHelper.format_time_stamp3(left))
local widget=self.cloudWidget
widget:SetChildText(2,time_str)
end
end





function UIXM_LXWJ_BattleWin:initWJT()
self.wjtWidget:SetChildUIModelShowTarget(0,4752,1,{},0,false,false,0,nil)
self.wjtWidget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onWJTClick()
end)
end

function UIXM_LXWJ_BattleWin:refreshWJT()
local widget=self.wjtWidget
if self.raceState==eLXWJ_State.eStandby then
widget:SetChildActive(2,false)
elseif self.raceState==eLXWJ_State.eFight then
if lingxuwenjianModel:hasEnemy()then
widget:SetChildActive(2,true)
local result=lingxuwenjianModel:checkBattleResult()
if result~=nil then

widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildActive(6,true)
self:refreshWJTResultView()
else
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
widget:SetChildActive(6,false)
self:refreshWJTTime()
else
widget:SetChildActive(3,false)
widget:SetChildActive(4,true)
widget:SetChildActive(6,false)
if self.battleSpID==nil then
self.battleSpID=4786
widget:SetChildUIModelShowTarget(5,self.battleSpID,1,{},0,false,false,0,nil)
end
end
end
else
widget:SetChildActive(2,false)
end
elseif self.raceState==eLXWJ_State.eFinish then
if lingxuwenjianModel:hasEnemy()then
widget:SetChildActive(2,true)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildActive(6,true)
self:refreshWJTResultView()
else
widget:SetChildActive(2,false)
end
end
end

function UIXM_LXWJ_BattleWin:refreshWJTResultView()
local widget=self.wjtWidget
local result=lingxuwenjianModel:checkBattleResult()

local abname_,icon_=lingxuwenjianModel:getResultIcon2(result)
widget:SetChildCSImageSprite(7,abname_,icon_)
widget:SetChildActive(8,result==1)
widget:SetChildActive(12,result==2)
if result==1 then

local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(10,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(9,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(11,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
elseif result==2 then

local enemyData=lingxuwenjianModel:getEnemyData()
local image=xianmengModel.splitGuildIcon(enemyData.enemyguildicon)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(14,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(13,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(15,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end
end

function UIXM_LXWJ_BattleWin:refreshWJTTime(left)
if self.raceState==eLXWJ_State.eFight then
if lingxuwenjianModel:hasEnemy()then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
if self.fightState==eLXWJ_Fight_State.eFight then
if left==nil then
local fightState,left_=lingxuwenjianModel:getFightState()
left=left_
end
local time_str=FMT.fmt('{0}后\n开始问剑',timeHelper.format_time_stamp3(left))
local widget=self.wjtWidget
widget:SetChildText(3,time_str)
end
end
end
end
end

function UIXM_LXWJ_BattleWin:onWJTClick()
self:myShowPanel('UIXM_LXWJ_WenJianWin')
end



function UIXM_LXWJ_BattleWin:initItemGuildSign(widget,image)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(4,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end



function UIXM_LXWJ_BattleWin:initMySide()
local leftWidget=self.leftGridPanel:getWidgetBase()

local homeWidget=leftWidget:GetChildWidgetBase(0)
homeWidget:SetChildUIModelShowTarget(0,4753,1,{},0,false,false,0,nil)
homeWidget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onMyHomeClick()
end)
homeWidget:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+1)
self:refreshMyHome(homeWidget)

for i=1,3 do
local widget=leftWidget:GetChildWidgetBase(i)
self:initMyFaZhen(widget,i)
self:refreshMyFZItem(widget,i)
end
end

function UIXM_LXWJ_BattleWin:refreshMyHome(homeWidget)
if homeWidget==nil then
local leftWidget=self.leftGridPanel:getWidgetBase()
homeWidget=leftWidget:GetChildWidgetBase(0)
end
local isshow=self.raceState==eLXWJ_State.eStandby
homeWidget:SetChildActive(1,isshow)
if isshow then

local image=xianmengModel:getGuildImage()
self:initItemGuildSign(homeWidget,image)

local name=xianmengModel:getXMName()
homeWidget:SetChildText(6,name)
end
end

function UIXM_LXWJ_BattleWin:initMyFaZhen(widget,idx)

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onMyFZClick(idx)
end)
widget:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+1)
end

function UIXM_LXWJ_BattleWin:refreshMyAllFaZhen()
local leftWidget=self.leftGridPanel:getWidgetBase()
for i=1,3 do
local widget=leftWidget:GetChildWidgetBase(i)
self:refreshMyFZItem(widget,i)
end
end

function UIXM_LXWJ_BattleWin:refreshMyFZItem(widget,idx,anim)
if idx<=0 then return end
if widget==nil then
local leftWidget=self.leftGridPanel:getWidgetBase()
widget=leftWidget:GetChildWidgetBase(idx)
end

local curman,maxman=lingxuwenjianModel:getMyFaZhenManNum(idx)
local isfull=curman>=maxman
local rate=lingxuwenjianModel:getFaZhenBloodRate(0,idx,curman,self.raceState)


local spineID=lingxuwenjianModel:getFaZhenSpine(0,idx)
local animState=lingxuwenjianModel:checkFaZhenAnim(rate,self.raceState)

if self.fazhenSpines[idx]==nil then
self.fazhenSpines[idx]={spineID,animState}
local anim=lingxuwenjianModel:getFaZhenAnimChange(nil,animState)

local old_animState=lingxuwenjianModel:getZhenFaChangeAnimationData(idx,0)

if animState==2 and old_animState~=2 then
anim=2147
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,0)
widget:SetChildShowEffect(6,10501,true)
elseif animState==3 and old_animState~=3 then
anim=2148
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,0)
widget:SetChildShowEffect(6,10501,true)
end
widget:SetChildUIModelShowTarget(0,spineID,1,{},anim,false,false,0,nil)
else
local old_animState=self.fazhenSpines[idx][2]
if animState~=old_animState then
self.fazhenSpines[idx][2]=animState
local anim=lingxuwenjianModel:getFaZhenAnimChange(old_animState,animState)

local old_animState=lingxuwenjianModel:getZhenFaChangeAnimationData(idx,0)

if animState==2 and old_animState~=2 then
anim=2147
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,0)
widget:SetChildShowEffect(6,10501,true)
elseif animState==3 and old_animState~=3 then
anim=2148
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,0)
widget:SetChildShowEffect(6,10501,true)
end
widget:SetChildModelAnimationState(0,anim)
end
end


local name_str=cfgHelper.get2(cfg_lingxuwenjianfazhenconfig_get,idx,'name')
if self.raceState==eLXWJ_State.eStandby then
if isfull then
name_str=FMT.fmt('<color=#aae252>{0}({1}/{2})</color>',name_str,curman,maxman)
else
name_str=FMT.fmt('<color=#f36666>{0}({1}/{2})</color>',name_str,curman,maxman)
end
else
name_str=FMT.fmt('<color=#aae252>{0}</color>',name_str)
end
widget:SetChildText(3,name_str)

if self.fazhenProgressTweeners[idx]~=nil then
if not self.fazhenProgressTweeners[idx]:IsComplete()then
self.fazhenProgressTweeners[idx]:OnComplete(nil)
self.fazhenProgressTweeners[idx]:Complete()
end
self.fazhenProgressTweeners[idx]=nil
end
if anim then
local speed=1
local old_rate=widget:GetChildIconFillAmount(5)
self.fazhenProgressTweeners[idx]=widget:SetChildImageDOFillAmount(5,rate,math.abs(rate-old_rate)*speed,function()
if _this==nil then return end
_this.fazhenProgressTweeners[idx]=nil
end)
else
widget:SetChildIconFillAmount(5,rate)
end

local showstate=self.raceState==eLXWJ_State.eStandby and isfull
widget:SetChildActive(6,showstate)
widget:SetChildActive(8,lingxuwenjianModel:checkInMyPos(playerModel:getActorID(),idx))
end

function UIXM_LXWJ_BattleWin:onMyHomeClick()
if self.raceState==eLXWJ_State.eStandby then
if lingxuwenjianModel:isLeader()then

lingxuwenjianController:openMemberList(1)
else
lingxuwenjianController:openMemberList(3)
end
else
lingxuwenjianController:openMemberList(3)
end
end

function UIXM_LXWJ_BattleWin:onMyFZClick(idx)
local posData={0,idx}
self:myShowPanel('UIXM_LXWJ_zhenyanWin',{posData=posData})
end





function UIXM_LXWJ_BattleWin:checkInitEnemySide()
local hasEnemy=lingxuwenjianModel:hasEnemy()
self.rightGridPanel:setActive(hasEnemy)
if hasEnemy then
self:initEnemySide()
end
end

function UIXM_LXWJ_BattleWin:initEnemySide()
local rightWidget=self.rightGridPanel:getWidgetBase()

local homeWidget=rightWidget:GetChildWidgetBase(0)
homeWidget:SetChildUIModelShowTarget(0,4757,1,{},0,false,false,0,nil)
homeWidget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onEnemyHomeClick()
end)


homeWidget:SetChildActive(1,false)








for i=1,3 do
local widget=rightWidget:GetChildWidgetBase(i)
self:initEnemyFaZhen(widget,i)
self:refreshEnemyFZItem(widget,i)
end
end

function UIXM_LXWJ_BattleWin:initEnemyFaZhen(widget,idx)
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onEnemyFZClick(idx)
end)
widget:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+1)

local name_str=cfgHelper.get2(cfg_lingxuwenjianfazhenconfig_get,idx,'name')
name_str=FMT.fmt('<color=#f36666>{0}</color>',name_str)
widget:SetChildText(3,name_str)
end

function UIXM_LXWJ_BattleWin:refreshEnemeyAllFaZhen()
local hasEnemy=lingxuwenjianModel:hasEnemy()
self.rightGridPanel:setActive(hasEnemy)
if hasEnemy then
local rightWidget=self.rightGridPanel:getWidgetBase()
for i=1,3 do
local widget=rightWidget:GetChildWidgetBase(i)
self:refreshEnemyFZItem(widget,i)
end
end
end

function UIXM_LXWJ_BattleWin:refreshEnemyFZItem(widget,idx,anim)
if idx<=0 then return end
if widget==nil then
local rightWidget=self.rightGridPanel:getWidgetBase()
widget=rightWidget:GetChildWidgetBase(idx)
end

local curman,maxman=lingxuwenjianModel:getEnemyFaZhenManNum(idx)
local rate=lingxuwenjianModel:getFaZhenBloodRate(1,idx,curman,self.raceState)


local spineID=lingxuwenjianModel:getFaZhenSpine(1,idx)
local animState=lingxuwenjianModel:checkFaZhenAnim(rate,self.raceState)

if self.fazhenSpines[-idx]==nil then
self.fazhenSpines[-idx]={spineID,animState}
local anim=lingxuwenjianModel:getFaZhenAnimChange(nil,animState)

local old_animState=lingxuwenjianModel:getZhenFaChangeAnimationData(idx,1)

if animState==2 and old_animState~=2 then
anim=2147
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,1)
widget:SetChildShowEffect(6,10501,true)
elseif animState==3 and old_animState~=3 then
anim=2148
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,1)
widget:SetChildShowEffect(6,10501,true)
end
widget:SetChildUIModelShowTarget(0,spineID,1,{},anim,false,false,0,nil)
else
local old_animState=self.fazhenSpines[-idx][2]
if animState~=old_animState then
self.fazhenSpines[-idx][2]=animState
local anim=lingxuwenjianModel:getFaZhenAnimChange(old_animState,animState)

local old_animState=lingxuwenjianModel:getZhenFaChangeAnimationData(idx,1)

if animState==2 and old_animState~=2 then
anim=2147
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,1)
widget:SetChildShowEffect(6,10501,true)
elseif animState==3 and old_animState~=3 then
anim=2148
lingxuwenjianModel:setZhenFaChangeAnimationData(idx,animState,1)
widget:SetChildShowEffect(6,10501,true)
end
widget:SetChildModelAnimationState(0,anim)
end
end


if self.fazhenProgressTweeners[-idx]~=nil then
if not self.fazhenProgressTweeners[-idx]:IsComplete()then
self.fazhenProgressTweeners[-idx]:OnComplete(nil)
self.fazhenProgressTweeners[-idx]:Complete()
end
self.fazhenProgressTweeners[-idx]=nil
end
if anim then
local speed=1
local old_rate=widget:GetChildIconFillAmount(5)
self.fazhenProgressTweeners[-idx]=widget:SetChildImageDOFillAmount(5,rate,math.abs(rate-old_rate)*speed,function()
if _this==nil then return end
_this.fazhenProgressTweeners[-idx]=nil
end)
else
widget:SetChildIconFillAmount(5,rate)
end
end

function UIXM_LXWJ_BattleWin:onEnemyHomeClick()
local rightWidget=self.rightGridPanel:getWidgetBase()
local pos=rightWidget:GetChildScreenPointToLocalPointRectangle(0)
UIManager:showWindow('UIXM_LXWJ_XMInfoWin',{pos=pos})
end

function UIXM_LXWJ_BattleWin:onEnemyFZClick(idx)
if lingxuwenjianModel:hasEnemy()then
local posData={1,idx}
self:myShowPanel('UIXM_LXWJ_zhenyanWin',{posData=posData})
end
end





function UIXM_LXWJ_BattleWin:onCloseBtn()
self:closeSelf()
end

function UIXM_LXWJ_BattleWin:onScoreRanktBtn()
lingxuwenjianController:openScoreWin()
end

function UIXM_LXWJ_BattleWin:onNotestBtn()
UIManager:showWindow('UIXM_LXWJ_notesWin')
end

function UIXM_LXWJ_BattleWin:onDefBtn()
if self.raceState==eLXWJ_State.eFight then
UIManager.error('决战阶段不能设置防守阵容')
return
end

lingxuwenjianController.setupDefTeams(1,nil,{openBattle=true})
end

function UIXM_LXWJ_BattleWin:rec_enemy()
self:refreshAttackNum()
self:refreshCloudItem()
self:refreshWJT()
self:refreshMyHome(nil)
self:checkInitEnemySide()
end

function UIXM_LXWJ_BattleWin:rec_result()
self:refreshWJT()
end

function UIXM_LXWJ_BattleWin:rec_fazhen(src,idx)

if src==0 then
self:refreshMyFZItem(nil,idx,true)
else
self:refreshEnemyFZItem(nil,idx,true)
end
end

function UIXM_LXWJ_BattleWin:rec_over()
self:refreshWJT()
UIManager:invokeUIMethod('UIXM_LXWJ_memberOneWin','onClickClose')
UIManager:invokeUIMethod('UIXM_LXWJ_memberThreeWin','onClickClose')
UIManager:closeWindow('UIXM_LXWJ_XMInfoWin')
end

function UIXM_LXWJ_BattleWin:refreshAnimation()
self:delayDo(0.5,function(...)
if _this==nil then return end
self:refreshMyAllFaZhen()
self:refreshEnemeyAllFaZhen()
end)
end

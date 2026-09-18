







def_class("UIXM_ZZSH_PvPMainWin",UIWindowBase)









function UIXM_ZZSH_PvPMainWin:bindComponents()

self.bottomPanel=UIObject.get(self,0)
self.boxBtn=UIButton.get(self,1)
self.boxNumObj=UIObject.get(self,2)
self.boxNumTxt=UIText.get(self,3)
self.fightTeamGrid=UIObject.get(self,4)
self.infoBtn=UIButton.get(self,5)
self.leftModel2Panel=UIObject.get(self,6)
self.leftPanel=UIObject.get(self,7)
self.moveBtn=UIButton.get(self,8)
self.myTeamBtn=UIButton.get(self,9)
self.noteBtn=UIButton.get(self,10)
self.noteBtnReddot=UIObject.get(self,11)
self.pvpTimeTxt=UIText.get(self,12)
self.pvpTipsObj=UIImage.get(self,13)
self.qishiBtn=UIButton.get(self,14)
self.qishiNumTxt=UIText.get(self,15)
self.qishiRankBtn=UIButton.get(self,16)
self.qishiSpine=UIObject.get(self,17)
self.rightPanel=UIObject.get(self,18)
self.root=UIObject.get(self,19)
self.setBtn=UIButton.get(self,20)
self.shopBtn=UIButton.get(self,21)
self.signBtn=UIButton.get(self,22)
self.teamBtn=UIButton.get(self,23)
self.teamWPBtn=UIButton.get(self,24)
self.teamWPNumObj=UIObject.get(self,25)
self.teamWPNumTxt=UIText.get(self,26)
self.teamWPPanel=UIObject.get(self,27)
self.tipsObj=UIObject.get(self,28)
self.tipsTxt=UIText.get(self,29)
self.topPanel=UIObject.get(self,30)
self.waipaiRoot=UIObject.get(self,31)
self.weekTask=UIButton.get(self,32)
self.weekTasknumTxt=UIText.get(self,33)
self.weekTaskReddot=UIObject.get(self,34)
self.weekTaskTips=UIText.get(self,35)
self.zhanlingBtn=UIButton.get(self,36)
self.zhanlingReddot=UIObject.get(self,37)
self.ybdBtn=UIButton.get(self,38)
self.emptyObj=UIObject.get(self,39)
self.ybdred=UIObject.get(self,40)

self.boxBtn:setButtonClick(function()self:onBoxBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.moveBtn:setButtonClick(function()self:onMoveBtn()end)

self.myTeamBtn:setButtonClick(function()self:onMyTeamBtn()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.qishiBtn:setButtonClick(function()self:onQishiBtn()end)

self.qishiRankBtn:setButtonClick(function()self:onQishiRankBtn()end)

self.setBtn:setButtonClick(function()self:onSetBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.teamWPBtn:setButtonClick(function()self:onTeamWPBtn()end)

self.weekTask:setButtonClick(function()self:onWeekTask()end)

self.zhanlingBtn:setButtonClick(function()self:onZhanlingBtn()end)

self.ybdBtn:setButtonClick(function()self:onYbdBtn()end)



end


function UIXM_ZZSH_PvPMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.boxBtn);self.boxBtn=nil;
_UIObject_release(self.boxNumObj);self.boxNumObj=nil;
_UIObject_release(self.boxNumTxt);self.boxNumTxt=nil;
_UIObject_release(self.fightTeamGrid);self.fightTeamGrid=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.leftModel2Panel);self.leftModel2Panel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.moveBtn);self.moveBtn=nil;
_UIObject_release(self.myTeamBtn);self.myTeamBtn=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.noteBtnReddot);self.noteBtnReddot=nil;
_UIObject_release(self.pvpTimeTxt);self.pvpTimeTxt=nil;
_UIObject_release(self.pvpTipsObj);self.pvpTipsObj=nil;
_UIObject_release(self.qishiBtn);self.qishiBtn=nil;
_UIObject_release(self.qishiNumTxt);self.qishiNumTxt=nil;
_UIObject_release(self.qishiRankBtn);self.qishiRankBtn=nil;
_UIObject_release(self.qishiSpine);self.qishiSpine=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setBtn);self.setBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.teamWPBtn);self.teamWPBtn=nil;
_UIObject_release(self.teamWPNumObj);self.teamWPNumObj=nil;
_UIObject_release(self.teamWPNumTxt);self.teamWPNumTxt=nil;
_UIObject_release(self.teamWPPanel);self.teamWPPanel=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.waipaiRoot);self.waipaiRoot=nil;
_UIObject_release(self.weekTask);self.weekTask=nil;
_UIObject_release(self.weekTasknumTxt);self.weekTasknumTxt=nil;
_UIObject_release(self.weekTaskReddot);self.weekTaskReddot=nil;
_UIObject_release(self.weekTaskTips);self.weekTaskTips=nil;
_UIObject_release(self.zhanlingBtn);self.zhanlingBtn=nil;
_UIObject_release(self.zhanlingReddot);self.zhanlingReddot=nil;
_UIObject_release(self.ybdBtn);self.ybdBtn=nil;
_UIObject_release(self.emptyObj);self.emptyObj=nil;
_UIObject_release(self.ybdred);self.ybdred=nil;
end
















local _this
local rankIconlp={
'image_shanhaisjui_4','image_shanhaisjui_5','image_shanhaisjui_6'
}
local stringF=string.format

function UIXM_ZZSH_PvPMainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onZZSHOrderChange,self.onZZSHOrderChange)
self:addNotify(notifyConfig.onBaoXiaReddotChange,self.onBaoXiaReddotChange)
self:addNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange,self.onZhengZhanShanHaiLogReddotChange)




self.shopBtn:setActive(false)
end


function UIXM_ZZSH_PvPMainWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_ZZSH_PvPTeamWin')
end


function UIXM_ZZSH_PvPMainWin:onHide()

end




function UIXM_ZZSH_PvPMainWin:onShow(argtable,afterOnloaded)
local guildid=xianmengModel:myXMGuildID()
self.guildid_str=tostring(guildid)
self.openTeam=zhengzhanshanhaiModel:checkpvpMainOpenTeamFlag()
self:initTime()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
self:refreshAllFightTeam()
end)
end
self:refreshTime()
self:refreshView()
self:checkWeekTaskOpen()
self:checkWeekTaskReddot()

self:refreshSetbyd()
end

function UIXM_ZZSH_PvPMainWin:refreshView()
self:refreshNoteReddot()
self:refreshBaoXiaReddot()
self:refreshSettingModel()
end

function UIXM_ZZSH_PvPMainWin:changeWinType()
self:refreshView()
end

function UIXM_ZZSH_PvPMainWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end






function UIXM_ZZSH_PvPMainWin:refreshTime()
if zhengzhanshanhaiModel.maskPvP then
local lerp=0
local timeData=zhengzhanshanhaiModel:getCurLunPvETime()
if timeData then
local sTime=timeData[1]
local cur=gameUtilityModel.getServerLongTime()
lerp=sTime-cur
if lerp<0 then lerp=0 end
end
local str=FMT.fmt('山海世界位面之门尚未开启，请祖师{0}后再临山海，征战称霸！',timeHelper.formatSimpleTime(lerp))
self.tipsTxt:setText(str)
else
local raceState,left=zhengzhanshanhaiModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
local icon=self.raceState==eZZSH_State.ePVPStandby and'image_shsjzzybui_1'or'image_shsjzzybui_2'
self.pvpTipsObj:setSprite(globalABLookup.zzshicons,icon)
end
self.pvpTimeTxt:setText(timeHelper.format_time_stamp(left))
end

if self.updataMoveBtn then
self:refreshMoveBtnProgress()
end
end

function UIXM_ZZSH_PvPMainWin:initTime()
local isShow=false
if zhengzhanshanhaiModel.maskPvP then
isShow=true
end
self.tipsObj:setActive(isShow)
self.pvpTipsObj:setActive(not isShow)
if not isShow then

local isShowSeasonTimeNow=UIManager:invokeUIMethod("UIXM_ZZSH_MapWin","getShSeasonTimeShowState")or false
self.emptyObj:setActive(isShowSeasonTimeNow)
end
end

function UIXM_ZZSH_PvPMainWin:setEmptyObjShow(isShow)
self.emptyObj:setActive(isShow)
end




function UIXM_ZZSH_PvPMainWin:refreshWaiPaiRoot()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then
local raceState=zhengzhanshanhaiModel:getLunState()
isShow=raceState==eZZSH_State.ePVPStandby
end
self.waipaiRoot:setActive(isShow)
if isShow then
if zhengzhanshanhaiModel:checkpvpOrderInit()then
self:refreshMyWaiPai()
end
end
end

function UIXM_ZZSH_PvPMainWin:refreshMyWaiPai()
local lp=zhengzhanshanhaiModel:getAllPvPOrder(true)
local list={}
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamtype_=1,max do
if lp[teamtype_]then
table.insert(list,teamtype_)
end
end
self.mOrderList=list
local cur=#self.mOrderList
local showPanel=self.openTeam
self.teamWPPanel:setActive(showPanel)
self.teamWPBtn:setActive(not showPanel)
local showNum=cur>0
if showPanel then
local widget=self.teamWPPanelWidget
if widget==nil then
widget=self.teamWPPanel:getWidgetBase()
self.teamWPPanelWidget=widget
end
if not self.isInitTeamWPPanel then
self.isInitTeamWPPanel=true

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onTeamWPBtn()
end)

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onTeamDetailBtn()
end)

widget:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onTeamJumpBtn(1)
end)
widget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onTeamJumpBtn(2)
end)
end

local num_str=FMT.fmt('外派仙阵({0}/{1})',cur,max)
widget:SetChildText(1,num_str)

widget:SetChildActive(6,showNum)
widget:SetChildActive(3,not showNum)

if showNum then
widget:SetChildLayoutGroupCreateItems(6,cur,function(idx)
if _this==nil then return end
local item=widget:GetChildLayoutGroupGridItem(6,idx-1)
local teamtype=_this.mOrderList[idx]

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onWaiPaiClick(idx)
end)

local rankIcon=rankIconlp[idx]or rankIconlp[#rankIconlp]
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,rankIcon)

local name_str=zhengzhanshanhaiModel:getTeamZhenRongName2(teamtype)
item:SetChildText(1,name_str)

local orderData=zhengzhanshanhaiModel:getOrder(teamtype)
local desc_str=self:getPvPOrderDesc(orderData)
item:SetChildText(2,desc_str or'')
end)
end
else
self.teamWPNumObj:setActive(showNum)
if showNum then
self.teamWPNumTxt:setText(tostring(cur))
end
end
end

function UIXM_ZZSH_PvPMainWin:getPvPOrderDesc(orderData)
local str
if orderData.guildid then
local xmData_=zhengzhanshanhaiModel:getXMData(orderData.guildid)
if xmData_ then
str=FMT.fmt('掠夺 <color=#FD8950>{0}</color>',xmData_.guildname)
end
elseif orderData.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(orderData.domainid)
if cfg then
str=FMT.fmt('占领 <color=#FD8950>{0}</color>',cfg.name)
end
end
return str
end

function UIXM_ZZSH_PvPMainWin:onWaiPaiClick(idx)
if not self:checkClickLock()then
return
end
local teamtype=self.mOrderList[idx]
local orderData=zhengzhanshanhaiModel:getOrder(teamtype)
if orderData then
if orderData.guildid then
local guildid=orderData.guildid
local xmData_=zhengzhanshanhaiModel:getXMData(guildid)
if xmData_ then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',xmData_.x,xmData_.y,0,false,0,function()
zhengzhanshanhaiController:openXMDetailInfoWin(guildid)
end)
end
elseif orderData.domainid then
local domainid=orderData.domainid
local g_x,g_y=zhengzhanshanhaiModel:getLingDiGridPos(domainid)
if g_x then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',g_x,g_y,0,false,0,function()
UIManager:showWindow('UIXM_ZZSH_lindiWin',{cfgID=domainid})
end)
end
end

end
end

function UIXM_ZZSH_PvPMainWin:onTeamWPBtn()
if zhengzhanshanhaiModel:checkpvpOrderInit()then
self.openTeam=not self.openTeam
zhengzhanshanhaiModel:setpvpMainOpenTeamFlag(self.openTeam)
self:refreshMyWaiPai()
end
end

function UIXM_ZZSH_PvPMainWin:onTeamDetailBtn()
zhengzhanshanhaiModel:checkOpenSelectTeamWin(2,{})
end

function UIXM_ZZSH_PvPMainWin:onTeamJumpBtn(typo)
if typo==1 then

UIManager:showWindow('UIXM_ZZSH_entitySelectPvPWin',{page=1})
else

UIManager:showWindow('UIXM_ZZSH_entitySelectPvPWin',{page=2})
end
end





function UIXM_ZZSH_PvPMainWin:refreshFightTeamGrid()
local isShow=false
local list
if not zhengzhanshanhaiModel.maskPvP then
local raceState=zhengzhanshanhaiModel:getLunState()
isShow=raceState==eZZSH_State.ePVPFight
if isShow then
list={}
local lp=zhengzhanshanhaiModel:getAllPvPOrder(true)
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamtype_=1,max do
if lp[teamtype_]then
local desc_str=self:getFightTeamDescStr(teamtype_)
table.insert(list,{teamtype_,desc_str})
end
end
end
end
self.mTeamList=list
self.fightTeamGrid:setActive(isShow)
if isShow then
local cur=#self.mTeamList
self.fightTeamGrid:setChildLayoutGroupCreateItems(cur,function(idx)
if _this==nil then return end
local item=_this.fightTeamGrid:getChildLayoutGroupGridItem(idx-1)
local data=_this.mTeamList[idx]

item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onFightTeamClick(idx)
end)

local desc_str=data[2]or''
item:SetChildText(0,desc_str)

_this:refreshFightTeamState(item,idx)
end)
end
end

function UIXM_ZZSH_PvPMainWin:refreshFightTeamState(item,idx)
if item==nil then
item=self.fightTeamGrid:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local data=self.mTeamList[idx]
local teamtype=data[1]

local desc_str=data[2]
if desc_str==nil then
desc_str=self:getFightTeamDescStr(teamtype)
if desc_str then
data[2]=desc_str
item:SetChildText(0,desc_str)
end
end

local state_str=self:getFightTeamStateStr(teamtype)
item:SetChildText(1,state_str or'')
end

function UIXM_ZZSH_PvPMainWin:getFightTeamDescStr(teamtype)
local desc
local orderData=zhengzhanshanhaiModel:getOrder(teamtype)
if orderData then
local targetData=orderData:getpvpTargetData()
if targetData then
local name=zhengzhanshanhaiModel:getTeamZhenRongName(teamtype)
if targetData.guildid then
local xmData=zhengzhanshanhaiModel:getXMData(targetData.guildid)
if xmData then
desc=FMT.fmt('{0} 掠夺 <color=#cd7c1c>{1}</color>',name,xmData.guildname)
end
elseif targetData.domainid then
local cfg=zhengzhanshanhaiModel:getLingDiCfg(targetData.domainid)
if cfg then
desc=FMT.fmt('{0} 抢占 <color=#cd7c1c>{1}</color>',name,cfg.name)
end
end
end
end
return desc
end

function UIXM_ZZSH_PvPMainWin:getFightTeamStateStr(teamtype)
local desc
local orderData=zhengzhanshanhaiModel:getOrder(teamtype)
if orderData then
local targetData=orderData:getpvpTargetData()
if targetData then
local teamData=targetData:getPvPTeam2(self.guildid_str,teamtype)
if teamData then
local state,name,time=zhengzhanshanhaiModel:getPvPTeamState(teamData,true)
if time~=nil then
desc=FMT.fmt('{0}抵达',timeHelper.format_time_stamp3(time))
else
desc=name
end
end
end
end
return desc
end

function UIXM_ZZSH_PvPMainWin:onFightTeamClick(idx)
local data=self.mTeamList[idx]
local teamtype=data[1]
local orderData=zhengzhanshanhaiModel:getOrder(teamtype)
if orderData then
local targetData=orderData:getpvpTargetData()
if targetData then
local pvpTeamData=targetData:getPvPTeam2(self.guildid_str,teamtype)
if pvpTeamData then
zhengzhanshanhaiModel:jumpPvPTeam(pvpTeamData)
end
end
end
end

function UIXM_ZZSH_PvPMainWin:refreshAllFightTeam()
if self.mTeamList and#self.mTeamList>0 then
local grid=self.fightTeamGrid:getChildLayoutGroupGridList()
for i=1,grid.Count do
local item=grid[i-1]
self:refreshFightTeamState(item,i)
end

end
end





function UIXM_ZZSH_PvPMainWin:onInfoBtn()
UIManager:showWindow('UIXM_ZZSH_entitySelectPvPWin')
end

function UIXM_ZZSH_PvPMainWin:refreshQBBtn()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then



local raceState=zhengzhanshanhaiModel:getLunState()
isShow=raceState==eZZSH_State.ePVPStandby
end
self.infoBtn:setActive(isShow)
end





function UIXM_ZZSH_PvPMainWin.onBaoXiaReddotChange()
if _this==nil then return end
_this:refreshBaoXiaReddot()
end

function UIXM_ZZSH_PvPMainWin:refreshBaoXiaReddot()
local num=zhengzhanshanhaiModel:isBXReddot()
local isshow=num>0
self.boxNumObj:setActive(isshow)
if isshow then
self.boxNumTxt:setText(tostring(num))
end
end

function UIXM_ZZSH_PvPMainWin:onBoxBtn()
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
end





function UIXM_ZZSH_PvPMainWin.onZhengZhanShanHaiLogReddotChange()
if _this==nil then return end
_this:refreshNoteReddot()
end

function UIXM_ZZSH_PvPMainWin:refreshNoteReddot()
local isReddot=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
self.noteBtnReddot:setActive(isReddot)
if isReddot then
if self.reddotTweener==nil then
self.noteBtnReddot:setRotation(0,0,0)
local tweener=self.noteBtnReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.noteBtnReddot:setRotation(0,0,0)
end
end
end

function UIXM_ZZSH_PvPMainWin:onNoteBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog()
end





function UIXM_ZZSH_PvPMainWin:onSetBtn()
UIManager:showWindow("UIXM_ZZSH_settingWin")
end

function UIXM_ZZSH_PvPMainWin:refreshSettingModel()
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1

local isshow=false
if not zhengzhanshanhaiModel.maskPvP then
isshow=showModel==1
end
self.leftModel2Panel:setActive(isshow)
if isshow then
self:refreshWaiPaiRoot()
self:refreshFightTeamGrid()
end
self:refreshQBBtn()

self:refershMoveBtn()
self:refershZhanLing()
self:refreshQiShiBtn()
self:refershMyTeamBtn()

self:refreshSignBtn()
self:refrshTeamBtn()

end





function UIXM_ZZSH_PvPMainWin:onMoveBtn()
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
if moveTime~=nil and cur<moveTime then
local lerp=moveTime-cur
UIManager.error(FMT.fmt('仙盟堡垒移动冷却中，{0}后才能再次移动',timeHelper.format_time_stamp11(lerp,true)))
return
end
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','activeSignModel',true,2)
end

function UIXM_ZZSH_PvPMainWin:refershMoveBtn()
local showMove=false
if not zhengzhanshanhaiModel.maskPvP and xianmengModel.checkPostPrivileByActor(playerModel:getActorID(),GUILD_PRIVILE_TYPE.gptZZSHSign)then
local raceState=zhengzhanshanhaiModel:getLunState()
showMove=raceState==eZZSH_State.ePVPStandby
if showMove then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
showMove=showModel==1 or showModel==2
end







end

self.moveBtn:setActive(showMove)
if showMove then
if self.moveBtnWidget==nil then
self.moveBtnWidget=self.moveBtn:getWidgetBase()
end
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
if moveTime~=nil and cur<moveTime then
self.updataMoveBtn=true
self.moveBtnWidget:SetChildActive(0,true)
self.moveBtnWidget:SetChildImageExGray(2,true)
self:refreshMoveBtnProgress(moveTime-cur)
else
self:refreshMoveBtnProgress(0)
end
end
end

function UIXM_ZZSH_PvPMainWin:refershZhanLing()







self.zhanlingBtn:setActive(false)
end


function UIXM_ZZSH_PvPMainWin:refreshMoveBtnProgress(lerp)
if lerp==nil then
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
lerp=moveTime-cur
if lerp<0 then lerp=0 end
end
if lerp>0 then
local move=zhengzhanshanhaiModel:getPvEMoveCoolTime()
local rate=(move-lerp)/move
self.moveBtnWidget:SetChildIconFillAmount(1,rate)
self.moveBtnWidget:SetChildText(3,timeHelper.format_time_stamp(lerp,true))
else
self.moveBtnWidget:SetChildActive(0,false)
self.moveBtnWidget:SetChildImageExGray(2,false)
self.moveBtnWidget:SetChildText(3,'')
self.updataMoveBtn=nil
end
end





function UIXM_ZZSH_PvPMainWin:onQishiRankBtn()
UIManager:showWindow("UIXM_ZZSH_RankListWin")
end

function UIXM_ZZSH_PvPMainWin:onQishiBtn()
UIManager:showWindow("UIXM_ZZSH_MomentumTipsWin")
end

function UIXM_ZZSH_PvPMainWin:refreshQiShiBtn()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
isShow=showModel==1 or showModel==2
end
self.qishiRankBtn:setActive(isShow)
self.qishiBtn:setActive(isShow)
if isShow then
if self.qishiSpineID==nil then
self.qishiSpineID=5284
self.qishiSpine:setChildUIModelShowTarget(self.qishiSpineID,1,{},0,false,false,0,nil)
end
local num=zhengzhanshanhaiModel:getMomentNum()
self.qishiNumTxt:setText(tostring(num))
end
end





function UIXM_ZZSH_PvPMainWin:onSignBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','activeSignModel',true,1)
end

function UIXM_ZZSH_PvPMainWin:refreshSignBtn()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
isShow=showModel==1 or showModel==2
end
self.signBtn:setActive(isShow)
end





function UIXM_ZZSH_PvPMainWin:onTeamBtn()
if not self:checkClickLock()then
return
end
zhengzhanshanhaiModel:checkOpenSelectTeamWin(1)
end

function UIXM_ZZSH_PvPMainWin:refrshTeamBtn()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
isShow=showModel==1 or showModel==2
end
self.teamBtn:setActive(isShow)
end





function UIXM_ZZSH_PvPMainWin:onMyTeamBtn()
UIManager:showWindow('UIXM_ZZSH_PvPTeamWin')
end

function UIXM_ZZSH_PvPMainWin:refershMyTeamBtn()
local showMove=false
if not zhengzhanshanhaiModel.maskPvP then
local raceState=zhengzhanshanhaiModel:getLunState()
showMove=raceState==eZZSH_State.ePVPFight
if showMove then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
showMove=showModel==1 or showModel==2
end
end
self.myTeamBtn:setActive(showMove)
end



function UIXM_ZZSH_PvPMainWin.onZZSHOrderChange(opType,qbGuid)
if _this==nil or not _this.isVisible then return end

_this:refreshWaiPaiRoot()
end

function UIXM_ZZSH_PvPMainWin:rec_myWaiPiaList()
self:refreshWaiPaiRoot()
self:refreshFightTeamGrid()
end


function UIXM_ZZSH_PvPMainWin:onWeekTask()
UIManager:showWindow('UIXM_ZZSH_WeekTaskWin')
end



function UIXM_ZZSH_PvPMainWin:checkWeekTaskOpen()
local SystemOpen=zhengzhanshanhaiController:checkSystemOpen_weekTask()
self.weekTask:setActive(SystemOpen)
if SystemOpen then
_this:checkWeekTaskReddot()
local IsShowTask=zhengzhanshanhaiModel:getIsShowTask()
if IsShowTask then
if zhengzhanshanhaiModel:checkWeekTaskAllComplete()then
self.weekTasknumTxt:setText("已完成全部任务")
else
self.taskList=zhengzhanshanhaiModel:getSortTaskList()
if self.taskList then
local fristTaskData=self.taskList[1].Data
local complete_cnt,rewardflag,needComplete_cnt=zhengzhanshanhaiModel:getComplete_cntAndrewardflag(fristTaskData)
local curCfg=zhengzhanshanhaiController:getZZSHCfg_weekTask(fristTaskData.id)
local desc
if complete_cnt>=needComplete_cnt then
desc=stringF("\n(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eGreenColor],stringF("%s/%s",needComplete_cnt,needComplete_cnt))
else
desc=stringF("\n(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eRedColor],stringF("%s/%s",complete_cnt,needComplete_cnt))
end
self.weekTasknumTxt:setText(stringF("%s%s",curCfg.Desc,desc))
end
end
else
local startTime,endTime=zhengzhanshanhaiModel:getPvPTime()
if endTime then
local func=function()
if _this then
local leftTime=(endTime-gameUtilityModel.getServerLongTime())
if leftTime>0 then
self.weekTasknumTxt:setText(FMT.fmt("<color=#FF0B0B>{0}</color>后重置任务",timeHelper.format_time_stamp11(leftTime,true)))
else
_this:stopTimerByID(_this.weekTaskPveTimer)
end
end
end
if not self.weekTaskPveTimer then
self.weekTaskPveTimer=self:setTimer(1,0,func)
end
end
end
end
end


function UIXM_ZZSH_PvPMainWin:checkWeekTaskReddot()
local SystemOpen=zhengzhanshanhaiController:checkSystemOpen_weekTask()
if SystemOpen then
local reddot=zhengzhanshanhaiModel:checkAllReddot()
self.weekTaskReddot:setActive(reddot)
end
end








function UIXM_ZZSH_PvPMainWin:onZhanlingBtn()


UIFullSHZhanLingController:showMainWindow({tabType=nil,nextFunc=function()
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
end})
end

function UIXM_ZZSH_PvPMainWin:onShopBtn()
funcShopController:openShopWin({shopId=eFuncShopType.eshanhaishop,canvasIdx=5})
end


function UIXM_ZZSH_PvPMainWin:onYbdBtn()
self:showWindow("UIXMZZSH_YuBeiDuiSetWin")
end


function UIXM_ZZSH_PvPMainWin:refreshSetbyd()


local reddot=not zhengzhanshanhaiModel:checkIsSetZZSHYbd()
self.ybdred:setActive(reddot)
end

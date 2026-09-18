







def_class("UIXYZDZhanRoundWin",UIWindowBase)









function UIXYZDZhanRoundWin:bindComponents()

self.dropItem=UIObject.get(self,0)
self.failItem=UIObject.get(self,1)
self.fightIcon=UIObject.get(self,2)
self.fighttime=UIText.get(self,3)
self.noItemTips=UIText.get(self,4)
self.replayIcon=UIButton.get(self,5)
self.root=UIObject.get(self,6)
self.Scroller=UILoopListView.new(self,7)
self.winItem=UIObject.get(self,8)

self.replayIcon:setButtonClick(function()self:onReplayIcon()end)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXYZDZhanRoundWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.failItem);self.failItem=nil;
_UIObject_release(self.fightIcon);self.fightIcon=nil;
_UIObject_release(self.fighttime);self.fighttime=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.replayIcon);self.replayIcon=nil;
_UIObject_release(self.root);self.root=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
_UIObject_release(self.winItem);self.winItem=nil;
end
















local scrollerItemCmpIndex={
scrollerItem=0,
back=1,
fightIcon=2,
leftPlayerRoot=3,
rightPlayerRoot=4,
replayIcon=5,
}

local playerItemCmpIndex={
teamTxt=0,
has=1,
noHas=2,
heaIcon=3,
name=4,
severName=5,
winImg=6,
FailImg=7,
}




function UIXYZDZhanRoundWin:onLoaded(...)
self:bindComponents()
end


function UIXYZDZhanRoundWin:__delete()
self:unbindComponents()
end




function UIXYZDZhanRoundWin:onShow(argtable,afterOnloaded)
self.selectLevel=JiuYuZhengFengModel:getData_rank_level()
local xyId=argtable.xyId
self.xyId=xyId
local round=argtable.menuPageIndex

local tabCfg=oneTabScreenConfig:getScreenConfig(SEC_FULL_TYPE.XYZhenDuoZhan)
local childCfg=tabCfg.children
self.tabType=childCfg[round]

self.round=round
local fightTimeStamp=XingYuController.getZDRoundFightTime(round)
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
self.isFinish=fightTimeStamp<timeHelper.getServerShortTime()or sumRound<=0
if self.isFinish then
self.fighttime:setText("已结束")
else
local date=timeHelper.dateServerStampData(timeHelper.convertLongStamp(fightTimeStamp))
local day,hour,min=date.day,date.hour,date.min
local timeStr=min==0 and FMT.fmt("{0}点对决",hour)or FMT.fmt("{0}点{1}分对决",hour,min)
self.fighttime:setText(timeStr)
end
local winRwList=XingYuController.getZDRoundRwList(xyId,round,true)
local failRwList=XingYuController.getZDRoundRwList(xyId,round,false)
local winItem=self.winItem:getWidgetBase()
local winRewardData=table.deepCopy(winRwList[1])
winRewardData.showStage=true
widgetHelper.setNormalRewardItem(winItem,-1,winRewardData,true)
local failItem=self.failItem:getWidgetBase()
local failRewardData=table.deepCopy(failRwList[1])
failRewardData.showStage=true
widgetHelper.setNormalRewardItem(failItem,-1,failRewardData,true)

local fightInfoList=XingYuModel:getXingYuData_zdzSequenceList(xyId,round)or{}
self.noItemTips:setActive(#fightInfoList<=0)
self.Scroller:initData("scrollerItem",fightInfoList)

end


function UIXYZDZhanRoundWin:onHide()

end

function UIXYZDZhanRoundWin:onFreshAction(index,widget,data)

widget:SetChildActive(scrollerItemCmpIndex.fightIcon,not self.isFinish or data.fightLogId=="")
widget:SetChildActive(scrollerItemCmpIndex.replayIcon,self.isFinish and data.fightLogId~="")
if self.isFinish then
widget:SetChildButtonClick(scrollerItemCmpIndex.replayIcon,function()
self:onReplayIcon(data)
end)
end

local leftPlayerRootWidget=widget:GetChildWidgetBase(scrollerItemCmpIndex.leftPlayerRoot)
local rightPlayerRootWidget=widget:GetChildWidgetBase(scrollerItemCmpIndex.rightPlayerRoot)
self:setPlayerInfo(leftPlayerRootWidget,data[1],data.winner)
self:setPlayerInfo(rightPlayerRootWidget,data[2],data.winner)
end

function UIXYZDZhanRoundWin:onStartAction()

end

function UIXYZDZhanRoundWin:onReplayIcon(data)
local fightLogId=data.fightLogId

local args={}
args.eReplayType=eRePlayerType.xingyu
args.showBattle=true
local player1=data[1]
local player2=data[2]
local isSelf_1=mathHelper.compareInt64(player1.actorId,playerModel:getActorID())
local isSelf_2=mathHelper.compareInt64(player2.actorId,playerModel:getActorID())
local winFlag

args.player1={player1.name,player1.iconInfo}
args.player2={player2.name,player2.iconInfo}
local xyId=self.xyId
local tabType=self.tabType
args.battleType=eBattleType.xingyu
args.fightCloseCallBack=function(battle)
loadingControl.openCloud(function()
if battle then
fightController:closeBattle(battle)
end
XingYuController.replayFlag=true
XingYuController.tabType=tabType
local ingFlag=XingYuController.checkHasTeam(xyId)
if ingFlag then
XingYuController.req_35_102(xyId)
else
XingYuController.req_35_107(xyId)
end

end)
end
if isSelf_1 then
winFlag=player1.winFlag
elseif isSelf_2 then
winFlag=player2.winFlag
end
if winFlag then
args.result=winFlag and 1 or 2
end
args.round=self.round or 1
if fightLogId and fightLogId~=""then
loadingControl.openCloud(function()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end

fightModel:setSendExtraArgs(eBattleType.xingyu,args)
fightController:send_log_list({fightLogId},args,true,true)
end,nil,true)







else
UIManager.error("回放失败，战斗记录已过期或无效")
end
end

function UIXYZDZhanRoundWin:setPlayerInfo(widget,playerInfo,winner)
if playerInfo.noActorId then
widget:SetChildActive(playerItemCmpIndex.has,false)
widget:SetChildActive(playerItemCmpIndex.noHas,true)
widget:SetChildText(playerItemCmpIndex.teamTxt,"")
else
widget:SetChildActive(playerItemCmpIndex.has,true)
widget:SetChildActive(playerItemCmpIndex.noHas,false)
local teamStr=FMT.fmt("{0}队",playerInfo.teamIndex)
widget:SetChildText(playerItemCmpIndex.teamTxt,teamStr)
local isSelf=mathHelper.compareInt64(playerInfo.actorId,playerModel:getActorID())
local fName=isSelf and FMT.cfmt(FONT_COLOR.eGreenColor,playerInfo.name)or playerInfo.name
widget:SetChildText(playerItemCmpIndex.name,fName)
local sName=isSelf and FMT.cfmt(FONT_COLOR.eGreenColor,loginModel:getServerName(playerInfo.serverId))or loginModel:getServerName(playerInfo.serverId)
widget:SetChildText(playerItemCmpIndex.severName,sName)
widget:SetChildActive(playerItemCmpIndex.winImg,winner~=0 and playerInfo.winFlag)
widget:SetChildActive(playerItemCmpIndex.FailImg,false)
playerController:setHeadIcon(widget,playerItemCmpIndex.heaIcon,{iconInfo=playerInfo.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
end

end






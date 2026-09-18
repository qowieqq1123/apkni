







def_class("UIJYZF_RankWin",UIWindowBase)









function UIJYZF_RankWin:bindComponents()

self.rankScrollView=UILoopListView.new(self,0)
self.topRankItem_1=UIObject.get(self,1)
self.topRankItem_2=UIObject.get(self,2)
self.topRankItem_3=UIObject.get(self,3)
self.myRankItem=UIObject.get(self,4)
self.timeTxt=UIText.get(self,5)
self.timeRoot=UIObject.get(self,6)
self.stageIcon=UIImage.get(self,7)
self.stageTip=UIObject.get(self,8)
self.reTimeTip=UIObject.get(self,9)
self.stageRewardRoot=UIObject.get(self,10)
self.stageRewardLayout=UIObject.get(self,11)
self.rankRewardRoot=UIObject.get(self,12)
self.rankRewardLayout=UIObject.get(self,13)
self.wayBtn=UIButton.get(self,14)
self.rewardBtn=UIButton.get(self,15)
self.title=UIText.get(self,16)
self.reTimeTxt=UIText.get(self,17)
self.stageTipBtn=UIButton.get(self,18)
self.closeBtn=UIButton.get(self,19)
self.stagenameBg=UIObject.get(self,20)
self.stagenameicon=UIImage.get(self,21)
self.sagemodel=UIObject.get(self,22)
self.logBtn=UIButton.get(self,23)
self.ruleBtn=UIButton.get(self,24)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.wayBtn:setButtonClick(function()self:onWayBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.stageTipBtn:setButtonClick(function()self:onStageTipBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.logBtn:setButtonClick(function()self:onLogBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.topRankItem={
self.topRankItem_1,
self.topRankItem_2,
self.topRankItem_3,
}



end


function UIJYZF_RankWin:unbindComponents()
local _UIObject_release=UIObject.release
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.topRankItem_1);self.topRankItem_1=nil;
_UIObject_release(self.topRankItem_2);self.topRankItem_2=nil;
_UIObject_release(self.topRankItem_3);self.topRankItem_3=nil;
_UIObject_release(self.myRankItem);self.myRankItem=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.stageIcon);self.stageIcon=nil;
_UIObject_release(self.stageTip);self.stageTip=nil;
_UIObject_release(self.reTimeTip);self.reTimeTip=nil;
_UIObject_release(self.stageRewardRoot);self.stageRewardRoot=nil;
_UIObject_release(self.stageRewardLayout);self.stageRewardLayout=nil;
_UIObject_release(self.rankRewardRoot);self.rankRewardRoot=nil;
_UIObject_release(self.rankRewardLayout);self.rankRewardLayout=nil;
_UIObject_release(self.wayBtn);self.wayBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.reTimeTxt);self.reTimeTxt=nil;
_UIObject_release(self.stageTipBtn);self.stageTipBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.stagenameBg);self.stagenameBg=nil;
_UIObject_release(self.stagenameicon);self.stagenameicon=nil;
_UIObject_release(self.sagemodel);self.sagemodel=nil;
_UIObject_release(self.logBtn);self.logBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
self.topRankItem=nil;
end















local rankItemIndex={
bg=0,
rank=1,
name=2,
num=3,
tipBtn=4,
upflag=5,
downflag=6,
}
local abName="ui/windows/jiuyuzhengfeng/jyzf_atlas_pak.ab"




function UIJYZF_RankWin:onLoaded(...)
self:bindComponents()
local show,lastLevel,curLevel=JiuYuZhengFengController:checkShowStageChangeWin()
if show then
self:showWindow("UIJYZF_StageChangeWin",{lastLevel=lastLevel,curLevel=curLevel})
end
self.requestCrossNameCallBack=function()
if self and not self.isClose then
self:CrossNameCallBack()
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
end


function UIJYZF_RankWin:__delete()
loginRequestUpdate:unregisterRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
self:unbindComponents()
end




function UIJYZF_RankWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIJYZF_RankWin:onHide()

end

function UIJYZF_RankWin:refresh()
local rankList=JiuYuZhengFengModel:getData_rankList()

self.rankList=rankList


for i,v in ipairs(self.topRankItem)do
local widget=v:getWidgetBase()
local args={}
args.rank=i
local data=rankList and rankList[i]or{}
args.crossId=data.param_1
args.score=data.param_2
self:setRankItemInfo(widget,args)
end


local myRankInfo=JiuYuZhengFengModel:getData_myRankInfo()
local widget=self.myRankItem:getWidgetBase()
local args={}
self:setRankItemInfo(widget,myRankInfo,true)
if rankList and#rankList>3 then
self.rankScrollView:initData("rankItem",{},#rankList-3)
else
self.rankScrollView:initData(nil,nil,0)
end


local pfId=JiuYuZhengFengModel:getData_pfId()
local baseCfg=cfg_xianyulevelbasicconfig_get(1)
self.wayBtn:setActive(baseCfg.jumpCfg~=nil)

local settle_time=baseCfg.settle_time
if settle_time and settle_time[pfId]then
local curTime=timeHelper.getServerShortTime()
local endTime=timeHelper.convertShortStamp(timeHelper.dataToTimeStam(settle_time[pfId][2]))
if curTime>=endTime then
self.timeRoot:setActive(false)
else
self.timeRoot:setActive(true)
local stopTime=timeHelper.convertShortStamp(timeHelper.dataToTimeStam(settle_time[pfId][1]))


self.timeTxt:setText(curTime>=stopTime and FMT.fmt("争锋结束时间：{0}",settle_time[pfId][2])or FMT.fmt("停止计分时间：{0}",settle_time[pfId][1]))
end

else
self.timeRoot:setActive(false)
end




local myCrossId=loginModel:getCrossServerId()
local myCName=loginModel:getCrossZoneName(myCrossId)
self.title:setText(myCName)


local rLevel=JiuYuZhengFengModel:getData_rank_level()
local rlist
local myRank=myRankInfo and myRankInfo.rank
if rLevel==0 then
self.stageTip:setActive(true)
self.stageRewardRoot:setActive(false)
local first_rank_reward=baseCfg.first_rank_reward
for i,v in ipairs(first_rank_reward)do
if myRank and v[1]<=myRank and myRank<=v[2]then
rlist=v[3]
break
end
end
self.stageIcon:setActive(true)
self.sagemodel:setActive(false)
self.stagenameBg:setActive(false)
else
self.stageIcon:setActive(false)
self.sagemodel:setActive(true)
self.stagenameBg:setActive(true)


local cfg=cfg_xianyulevelcconfig_get(rLevel)
for i,v in ipairs(cfg.rank_reward)do
if myRank and v[1]<=myRank and myRank<=v[2]then
rlist=v[3]
break
end
end
local assest=cfg.imgName
self.stagenameicon:setSprite(abName,assest)
local model=cfg.model
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.sagemodel:getID(),true,true,true)
end
self.sagemodel:setChildUIModelShowTarget(model,1,nil,eAnimationID.stand)
self.stageTip:setActive(false)
self.stageRewardRoot:setActive(true)
local list=cfg.level_reward
self.stageRewardLayout:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.stageRewardLayout:getChildLayoutGroupGridItem(index-1)
local rewardData=list[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end



local daily_update_time=baseCfg.daily_update_time
local rTime=daily_update_time[2]
local rtimeStr=rTime[2]==0 and FMT.fmt("每日{0}点刷新排行榜积分",rTime[1])or FMT.fmt("每日{0}点{1}分刷新排行榜积分",rTime[1],rTime[2])
self.reTimeTxt:setText(rtimeStr)


if rlist then
self.rankRewardRoot:setActive(true)
self.rankRewardLayout:setChildLayoutGroupCreateItems(#rlist,function(index)
local item=self.rankRewardLayout:getChildLayoutGroupGridItem(index-1)
local rewardData=rlist[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
self.rankRewardRoot:setActive(false)
end


end




function UIJYZF_RankWin:setRankItemInfo(widget,args,selfFlag)
if not args or not args.crossId then
widget:SetChildText(rankItemIndex.rank,args and args.rank or"--")
widget:SetChildText(rankItemIndex.name,selfFlag and loginModel:getCrossZoneName(loginModel:getCrossServerId())or"虚位以待")
widget:SetChildText(rankItemIndex.num,selfFlag and 0 or"")
widget:SetChildActive(rankItemIndex.tipBtn,false)
widget:SetChildActive(rankItemIndex.upflag,false)
widget:SetChildActive(rankItemIndex.downflag,false)
return
end

local rank=args.rank
local crossId=args.crossId
local score=args.score
widget:SetChildText(rankItemIndex.rank,rank)

local myCrossId=loginModel:getCrossServerId()
local cName=crossId and loginModel:getCrossZoneName(crossId)or"虚位以待"
widget:SetChildText(rankItemIndex.name,cName)
widget:SetChildText(rankItemIndex.num,mathHelper.formatNumber(score))
local showTipBtn=crossId and myCrossId and crossId~=myCrossId
widget:SetChildActive(rankItemIndex.tipBtn,showTipBtn)
if showTipBtn then
widget:SetChildButtonClick(rankItemIndex.tipBtn,function()
self:onTipBtn(args)
end)
end
local rLevel=JiuYuZhengFengModel:getData_rank_level()
if rLevel==0 then
widget:SetChildActive(rankItemIndex.upflag,false)
widget:SetChildActive(rankItemIndex.downflag,false)
else
local isSpe=JiuYuZhengFengModel:getData_isSpe()
local cfg=cfg_xianyulevelcconfig_get(rLevel)
local just_conf=isSpe and cfg.spe_level_just_conf or cfg.level_just_conf
local upIndex=just_conf[1]
local downIndex=#self.rankList-just_conf[2]+1

if rank<=upIndex then
widget:SetChildActive(rankItemIndex.upflag,true)
widget:SetChildActive(rankItemIndex.downflag,false)
elseif downIndex>upIndex and rank>=downIndex then
widget:SetChildActive(rankItemIndex.upflag,false)
widget:SetChildActive(rankItemIndex.downflag,true)
else
widget:SetChildActive(rankItemIndex.upflag,false)
widget:SetChildActive(rankItemIndex.downflag,false)
end
end
end

function UIJYZF_RankWin:onFreshAction(index,widget,data)
local args={}
args.rank=index+3
local data=self.rankList[args.rank]
args.crossId=data.param_1
args.score=data.param_2
self:setRankItemInfo(widget,args)
end


function UIJYZF_RankWin:onStartAction()
end

function UIJYZF_RankWin:onTipBtn(args)
self.reqList={}
self.clickRankInfo=args
local crossId=args.crossId
JiuYuZhengFengController.req_35_241(crossId)
self.reqList[crossId]=true

local myCrossId=loginModel:getCrossServerId()
JiuYuZhengFengController.req_35_241(myCrossId)
self.reqList[myCrossId]=true
end

function UIJYZF_RankWin:recvData_35_241(crossId)
if not self.reqList then
return
end
self.reqList[crossId]=nil
if next(self.reqList)then
return
end
local args={}
args.leftRankInfo=self.clickRankInfo
args.rightRankInfo=JiuYuZhengFengModel:getData_myRankInfo()or{rank=-1,crossId=loginModel:getCrossServerId(),score=0}
self:showWindow("UIJYZF_CompareWin",args)
end





function UIJYZF_RankWin:onWayBtn()










local baseCfg=cfg_xianyulevelbasicconfig_get(1)
local jumpCfg=baseCfg.jumpCfg
local args={
title='提升排名',
tips="可通过以下途径增加<color=#7D3B17>仙域积分</color>，提升排名：",
gainWayList=jumpCfg,
}
self:showWindow("UICommonGainWayWin",args)
end



function UIJYZF_RankWin:onRewardBtn()
local rLevel=JiuYuZhengFengModel:getData_rank_level()
if rLevel~=0 then
local tabIndex=rLevel
self:showWindow("UIJYZF_RewardPreviewWin",{tabIndex=tabIndex})
else
self:showWindow("UIJYZF_DWS_RewardPreviewWin")
end
end

function UIJYZF_RankWin:onStageTipBtn()
self:showWindow("UIJYZF_StageShowWin")
end

function UIJYZF_RankWin:onCloseBtn()
UIFullJiuYuZhengFengController:closeUI()
end

function UIJYZF_RankWin:onLogBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eJYZF_Record,{})
end

function UIJYZF_RankWin:onRuleBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eJYZF_Rule,{})
end

function UIJYZF_RankWin:CrossNameCallBack()
local myCrossId=loginModel:getCrossServerId()
local myCName=loginModel:getCrossZoneName(myCrossId)
self.title:setText(myCName)

local rankList=self.rankList

for i,v in ipairs(self.topRankItem)do
local widget=v:getWidgetBase()
local args={}
args.rank=i
local data=rankList and rankList[i]or{}
args.crossId=data.param_1
args.score=data.param_2
self:setRankItemInfo(widget,args)
end


local myRankInfo=JiuYuZhengFengModel:getData_myRankInfo()
local widget=self.myRankItem:getWidgetBase()
local args={}
self:setRankItemInfo(widget,myRankInfo,true)

if rankList and#rankList>3 then
local cnt=self.rankScrollView:getListViewItemShowCount()
for showIndex=1,cnt do
local showItem=self.rankScrollView:getListViewItemByItemIdx(showIndex)
if showItem then
local dataIndex=showItem.ItemIndex+1
local data=self.rankList[dataIndex+3]
if data then
self:onFreshAction(dataIndex,showItem.Widget)
end
end
end
end
end






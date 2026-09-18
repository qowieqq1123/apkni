







def_class("UIWDCQHaiXuanWin",UIWindowBase)









function UIWDCQHaiXuanWin:bindComponents()

self.changeBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.tipsBtn=UIButton.get(self,2)
self.fixGameTip=UIText.get(self,3)
self.gameTimeTip=UIText.get(self,4)
self.groupImg=UIImage.get(self,5)
self.funcIcons=UIObject.get(self,6)
self.recordBtn=UIButton.get(self,7)
self.defendBtn=UIButton.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.rwReddot=UIObject.get(self,10)
self.hasInGame=UIObject.get(self,11)
self.noGame=UIObject.get(self,12)
self.challengeCnt=UIText.get(self,13)
self.rankTips=UIText.get(self,14)
self.rewardScrollView=UIObject.get(self,15)
self.rewardContent=UIObject.get(self,16)
self.refreshBtn=UIButton.get(self,17)
self.nogameTips=UIText.get(self,18)
self.itemListPanel=UILoopListView.new(self,19)
self.rankline=UIObject.get(self,20)
self.notRankTips=UIText.get(self,21)
self.refreshBtnTxt=UIText.get(self,22)
self.JTtopBtn=UIButton.get(self,23)
self.JTbottomBtn=UIButton.get(self,24)
self.Content=UIObject.get(self,25)
self.modelRoot=UIObject.get(self,26)
self.model_1=UIObject.get(self,27)
self.model_2=UIObject.get(self,28)
self.Viewport=UIObject.get(self,29)
self.JTtopBtnEx=UIButton.get(self,30)
self.JTbottomBtnEx=UIButton.get(self,31)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.defendBtn:setButtonClick(function()self:onDefendBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.itemListPanel:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.JTtopBtn:setButtonClick(function()self:onJTtopBtn()end)

self.JTbottomBtn:setButtonClick(function()self:onJTbottomBtn()end)

self.JTtopBtnEx:setButtonClick(function()self:onJTtopBtnEx()end)

self.JTbottomBtnEx:setButtonClick(function()self:onJTbottomBtnEx()end)
self.model={
self.model_1,
self.model_2,
}



end


function UIWDCQHaiXuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.fixGameTip);self.fixGameTip=nil;
_UIObject_release(self.gameTimeTip);self.gameTimeTip=nil;
_UIObject_release(self.groupImg);self.groupImg=nil;
_UIObject_release(self.funcIcons);self.funcIcons=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.defendBtn);self.defendBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rwReddot);self.rwReddot=nil;
_UIObject_release(self.hasInGame);self.hasInGame=nil;
_UIObject_release(self.noGame);self.noGame=nil;
_UIObject_release(self.challengeCnt);self.challengeCnt=nil;
_UIObject_release(self.rankTips);self.rankTips=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.nogameTips);self.nogameTips=nil;
self.itemListPanel:deleteSelf();self.itemListPanel=nil;
_UIObject_release(self.rankline);self.rankline=nil;
_UIObject_release(self.notRankTips);self.notRankTips=nil;
_UIObject_release(self.refreshBtnTxt);self.refreshBtnTxt=nil;
_UIObject_release(self.JTtopBtn);self.JTtopBtn=nil;
_UIObject_release(self.JTbottomBtn);self.JTbottomBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.Viewport);self.Viewport=nil;
_UIObject_release(self.JTtopBtnEx);self.JTtopBtnEx=nil;
_UIObject_release(self.JTbottomBtnEx);self.JTbottomBtnEx=nil;
self.model=nil;
end


















local maxItemCnt=64
local col=3
local row=math.ceil(maxItemCnt/col)
local chairItemCmp={
rankBg=0,
rank=1,
nochanllge=2,
emptyRoot=3,
robotRoot=4,
playerRoot=5,
robotFight=6,
robotNmae=7,
palyerfight=8,
playerNmae=9,
playerServerNmae=10,
headIcon=11,
fightBg=12,
baohuBg=13,
baohuTime=14,
click=15,
robotIcon=16,
bg=17,
selfFlag=18,
loseHead=19,
}
local coolTime=5

local _this
function UIWDCQHaiXuanWin:onLoaded(...)
self:bindComponents()
_this=self


self.levelname={
'黄阶',
'玄阶',
'地阶',
'天阶',
}

end


function UIWDCQHaiXuanWin:__delete()
self:unbindComponents()
self:stopAllTimer()
end




function UIWDCQHaiXuanWin:onShow(argtable,afterOnloaded)
XiWeiSaiController.req_38_41()

local hasSubWin=false
if argtable and argtable.showAdjustWin then
hasSubWin=true
self:showWindow("UIXWSAdjustWin",argtable)
end

if argtable and argtable.showRecordWin then
hasSubWin=true
self:showWindow('UIXWSRecordWin',argtable)
end

if not hasSubWin and argtable and argtable.loading then
loadingControl.closeCloud()
end

end


function UIWDCQHaiXuanWin:onHide()
self:stopAllTimer()
end

function UIWDCQHaiXuanWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIWDCQHaiXuanWin:refreshAll()
self:checkShowPosChangeWin()
self:stopAllTimer()
self.abName=XiWeiSaiModel:getConfig_abName()
self.groupImageList=XiWeiSaiModel:getConfig_groupImageList()
self.group=XiWeiSaiModel:getData_group()
self.gamePlayerFlag=XiWeiSaiController.checkGamePlayerFlag()
self:refresh()
self:startTimer()
self:jumpTargetItem()
end

function UIWDCQHaiXuanWin:stopAllTimer()
if self.startTimerId then
self:stopTimerByID(self.startTimerId)
self.startTimerId=nil
end
end

function UIWDCQHaiXuanWin:startTimer()
local func=function()
local curTime=timeHelper.getServerShortTime()
self:refreshGameTimeTip(curTime)
self:refreshTimeDownItem(curTime)
self:refreshBtnState(curTime)
end
self.startTimerId=self:setTimer(1,0,func)
end

function UIWDCQHaiXuanWin:checkShowPosChangeWin()


if XiWeiSaiController.checkIntheGame()and XiWeiSaiController:getShowChangeWinFlag()then
self.showChangeWin=true
XiWeiSaiController.req_38_42()
end
end

function UIWDCQHaiXuanWin:Data_Recv_38_42()

if self.showChangeWin then
self.showChangeWin=false
local logList=XiWeiSaiModel:getData_logList()

if logList then
local firstLog
for i,v in ipairs(logList)do
if v.log_type==2 then
firstLog=v
break
end
end


if firstLog and firstLog.log_type==2 then
local log_times=firstLog.log_times
local lastlogtime=XiWeiSaiController:getChangeWinShowLogTime()

if log_times~=lastlogtime then
local args={}
args.logTime=log_times
args.pos=XiWeiSaiController.getPlayerRank()or 0
self:showWindow('UIXWSChangeWin',args)
end
end
end
else
self:showWindow('UIXWSRecordWin')
end
end

function UIWDCQHaiXuanWin:refresh()
self:refreshTopRoot()
self:refreshBottomRoot()
self:refreshItemListPanel()
end

function UIWDCQHaiXuanWin:refreshTopRoot()
self.groupImg:setCSImageSprite(self.abName,self.groupImageList[self.group])
self:refreshGameTimeTip()
end

function UIWDCQHaiXuanWin:refreshGameTimeTip(curTime)
local state,subState=XiWeiSaiController.getGameState()
local txt=""
if state==XWSStateEnum.ePreGame then
local startTime=XiWeiSaiModel.getConfig_startTime()
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(startTime))
txt=FMT.fmt('{0}月{1}日开启',smonth,sday)
elseif state==XWSStateEnum.eAfterGame then
txt="席位赛已结束"
elseif state==XWSStateEnum.eInGame then
local curTime=curTime or timeHelper.getServerShortTime()
local leftTime=0
if subState==XWSSubStateEnum.eFight then
local stopFightTime=XiWeiSaiModel:getConfig_stopFightTime()
leftTime=stopFightTime-curTime
txt=FMT.fmt('席位赛对战：{0}',timeHelper.format_time_stamp3(leftTime))
elseif subState==XWSSubStateEnum.eJieSuan then
local endTime=XiWeiSaiModel:getConfig_endTime()
leftTime=endTime-curTime
leftTime=leftTime<0 and 0 or leftTime
txt=FMT.fmt('席位赛结算：{0}',timeHelper.format_time_stamp3(leftTime))
end
end
self.gameTimeTip:setText(txt)
end

function UIWDCQHaiXuanWin:refreshBottomRoot()
self.hasInGame:setActive(self.gamePlayerFlag)
self.noGame:setActive(not self.gamePlayerFlag)
if self.gamePlayerFlag then
self.defendBtn:setActive(true)
self:refreshChallengeCnt()
self:refreshRank()
self:refreshBtnState()
else
self.defendBtn:setActive(false)
local cfgxfwdstage=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'wfwd_stage')
self.nogameTips:setText(FMT.fmt("仙法问道达到<color=#7d3b17>{0}</color>可参加席位赛",self.levelname[cfgxfwdstage]))
end
end

function UIWDCQHaiXuanWin:refreshChallengeCnt()
if self.gamePlayerFlag then
local state,subState=XiWeiSaiController.getGameState()
if state==XWSStateEnum.eInGame then
self.challengeCnt:setActive(true)
local cnt=XiWeiSaiController.getLeftChallengeCnt()
local ctxt=FMT.fmt("今日挑战次数：{0}",cnt)
self.challengeCnt:setText(ctxt)
else
self.challengeCnt:setActive(false)
end
end
end

function UIWDCQHaiXuanWin:refreshRank()
if self.gamePlayerFlag then
local state,subState=XiWeiSaiController.getGameState()
if state==XWSStateEnum.eInGame then
self.rankTips:setChildAnchoredPos(-153.7,40.6)
self.rankline:setActive(true)
else
self.rankTips:setChildAnchoredPos(-153.7,59.24)
self.rankline:setActive(false)
end
local rank=XiWeiSaiController.getPlayerRank()
local rtxt=FMT.fmt("我的席位：{0}",rank==nil and"未上榜"or rank)
self.rankTips:setText(rtxt)
if rank then
self.notRankTips:setActive(false)
self.rewardScrollView:setActive(true)
local posCfg=XiWeiSaiController.getPosCfg(self.group,rank)
local rewards=posCfg.rewards
if rewards then
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end
else
self.notRankTips:setActive(true)
self.rewardContent:setChildLayoutGroupClearAllItems()
self.rewardScrollView:setActive(false)
end
end
end

function UIWDCQHaiXuanWin:refreshBtnState(curTime)
if self.gamePlayerFlag then
local state,subState=XiWeiSaiController.getGameState()
if state==XWSStateEnum.eInGame then
self.refreshBtn:setActive(true)
self.refreshBtn:setGray(self.refreshBtnTime~=nil)
if self.refreshBtnTime then
local curTime=curTime or timeHelper.getServerShortTime()
local passTime=curTime-self.refreshBtnTime
if passTime>=coolTime then
self.refreshBtnTxt:setText("刷新")
self.refreshBtnTime=nil
self.refreshBtn:setGray(false)
else
self.refreshBtnTxt:setText(FMT.fmt("刷新（{0})",coolTime-passTime))
end
end
else
self.refreshBtn:setActive(false)
end
end
end

function UIWDCQHaiXuanWin:refreshItemListPanel()
local tempList={}
local prefabnameList={}









for pos=1,64 do
local rowCfg=self:getRowCfg(pos)
if not tempList[rowCfg.index]then
tempList[rowCfg.index]={}
prefabnameList[rowCfg.index]=rowCfg.prefabname
end
table.insert(tempList[rowCfg.index],pos)
end

tempList[#tempList+1]=0
prefabnameList[#prefabnameList+1]="chairListItemEmpty"

self.timeDownList={}
self.itemListPanel:initDataEx(prefabnameList,tempList)

self:refreshJiantou()
end

function UIWDCQHaiXuanWin:getRowCfg(pos)
local colIndex=pos
local jumpOffest=0
if pos<=3 then
return{index=1,prefabname="chairListItem3",len=0,colNum=3,colIndex=colIndex,jumpOffest=jumpOffest}
end
if pos<=8 then
colIndex=pos-3
if colIndex<3 then
jumpOffest=-colIndex*140
end
if colIndex>3 then
jumpOffest=(colIndex-3)*140
end
return{index=2,prefabname="chairListItem5",len=3,colNum=5,colIndex=colIndex,jumpOffest=jumpOffest}
end
local num=pos-8
local index=math.ceil(num/4)+2
local len=8+(index-3)*4
local left=pos-len
local colIndex=left%4==0 and 4 or left%4

if colIndex<2 then
jumpOffest=-colIndex*140
end
if colIndex>2 then
jumpOffest=(colIndex-2)*140
end

return{index=index,prefabname="chairListItem4",len=len,colNum=4,colIndex=colIndex,jumpOffest=jumpOffest}
end


function UIWDCQHaiXuanWin:onFreshAction(index,widget,data)











if index~=1 or index~=2 or index~=17 then
local cmpindex={
[1]=3,[2]=5,[17]=0
}

local bgIndex=index
if index>5 then
bgIndex=6+index%2
end

local abName=FMT.fmt("ui/windows/wdcqxiweisai/sharedtextures/xwssubbg_{0}.ab",bgIndex)
local assestNmae=FMT.fmt("xwssubbg_{0}",bgIndex)
widget:SetChildCSImageSprite(cmpindex[index]or 4,abName,assestNmae)

end

if data==0 then
return
end
local prefabCfg={
{num=3},
{num=5},
}
local num=prefabCfg[index]and prefabCfg[index].num or 4
for i=1,num do
local subwidget=widget:GetChildWidgetBase(i-1)
local pos=data[i]
if pos<=maxItemCnt then
subwidget:SetChildActive(-1,true)
self:refreshChairItem(subwidget,pos,index,i)








else
subwidget:SetChildActive(-1,false)
end
end
end

function UIWDCQHaiXuanWin:onStartAction()

end

function UIWDCQHaiXuanWin:getPosInfo(group,pos)
return XiWeiSaiController.getPosInfo(group,pos)
end

function UIWDCQHaiXuanWin:refreshChairItem(item,pos,row,col)
local info=self:getPosInfo(self.group,pos)


item:SetChildText(chairItemCmp.rank,pos)
local bgName={
"image_xizuosaiui_3",
"image_xizuosaiui_2",
"image_xizuosaiui_1"
}
item:SetChildCSImageSprite(chairItemCmp.bg,self.abName,bgName[pos]or"image_xizuosaiui_0")

if not info then
item:SetChildActive(chairItemCmp.emptyRoot,true)
item:SetChildActive(chairItemCmp.nochanllge,false)
item:SetChildActive(chairItemCmp.playerRoot,false)
item:SetChildActive(chairItemCmp.robotRoot,false)
return
end
local isLose=mathHelper.validInt64(info.actorId)and info.name==''



if isLose then

item:SetChildActive(chairItemCmp.emptyRoot,false)
item:SetChildActive(chairItemCmp.nochanllge,false)
item:SetChildActive(chairItemCmp.playerRoot,true)
item:SetChildActive(chairItemCmp.robotRoot,false)
item:SetChildActive(chairItemCmp.loseHead,true)
item:SetChildActive(chairItemCmp.fightBg,true)
item:SetChildText(chairItemCmp.playerNmae,playerModel:getOtherActorName(info.name))
local fight=mathHelper.formatNumber3(info.fight)
item:SetChildText(chairItemCmp.palyerfight,fight)
return
end

item:SetChildActive(chairItemCmp.emptyRoot,isLose)
if info.isSelfPos then
item:SetChildActive(chairItemCmp.nochanllge,false)
item:SetChildActive(chairItemCmp.selfFlag,true)
else
item:SetChildActive(chairItemCmp.nochanllge,not info.chanllgeFlag)
item:SetChildActive(chairItemCmp.selfFlag,false)
end

item:SetChildActive(chairItemCmp.playerRoot,not info.isRobot)
item:SetChildActive(chairItemCmp.robotRoot,info.isRobot)

if info.isRobot then
item:SetChildText(chairItemCmp.robotFight,mathHelper.formatNumber3(info.fight))
item:SetChildText(chairItemCmp.robotNmae,info.name)
playerController:setHeadIcon(item,chairItemCmp.robotIcon,{iconInfo=info.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
else
playerController:setHeadIcon(item,chairItemCmp.headIcon,{iconInfo=info.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
item:SetChildText(chairItemCmp.playerNmae,playerModel:getOtherActorName(info.name))
item:SetChildText(chairItemCmp.playerServerNmae,"")
local curTime=timeHelper.getServerShortTime()
local baohuLeftTime=info.win_times+info.protect_sec-curTime
local baohuFlag=baohuLeftTime>0
item:SetChildActive(chairItemCmp.fightBg,not baohuFlag)
item:SetChildActive(chairItemCmp.baohuBg,baohuFlag)
if baohuFlag then
item:SetChildText(chairItemCmp.baohuTime,timeHelper.format_time_stamp3(baohuLeftTime))
self:addTimeDown(row,col,info)
else
local fight=mathHelper.formatNumber3(info.fight)
item:SetChildText(chairItemCmp.palyerfight,fight)
self:removeTimeDown(row,col)
end
end
local func=function()
self:OnClickChairItem(info)
end
item:SetChildButtonClick(chairItemCmp.click,func,true)
end

function UIWDCQHaiXuanWin:refreshChairItem_pos(pos)
local rowCfg=self:getRowCfg(pos)
local rowIndex=rowCfg.index
local colIndex=rowCfg.colIndex
local widget=self.itemListPanel:getItemWidget(rowIndex)
if widget then
local subwidget=widget:GetChildWidgetBase(colIndex-1)
self:refreshChairItem(subwidget,pos,rowIndex,colIndex)
end
end

function UIWDCQHaiXuanWin:OnClickChairItem(info)





local state,subState=XiWeiSaiController.getGameState()
if state==XWSStateEnum.ePreGame then
UIManager.info("活动未开始")
return
elseif state==XWSStateEnum.eAfterGame then
UIManager.info("席位赛已结束")
return
elseif state==XWSStateEnum.eInGame then
if subState==XWSSubStateEnum.eJieSuan then
UIManager.info("结算中，不可挑战")
return
end
if info.isSelfPos then
return
end
if not info.isRobot then
local curbaohuLeftTime=info.win_times+info.protect_sec-timeHelper.getServerShortTime()
if curbaohuLeftTime>0 then
UIManager.info("保护时间不可挑战")
return
end
end

if subState==XWSSubStateEnum.eFight then
if not XiWeiSaiController.checkGamePlayerFlag()then
UIManager.info("未获得参赛资格")
return
end
local checkFlag,tagetRank=XiWeiSaiController.checkPosCanchallenge(info.pos)
if not checkFlag then
if tagetRank then
UIManager.info(FMT.fmt("请先挑战邻近{0}名的席位",tagetRank))
end
return
end
if not XiWeiSaiController.checkChallengeCnt()then
UIManager.info("挑战次数不足")
return
end
self:reqAndOpenFightingWin(info)
end
end
end

function UIWDCQHaiXuanWin:addTimeDown(row,col,info)
if not self.timeDownList then
return
end
if not self.timeDownList[row]then
self.timeDownList[row]={}
end
self.timeDownList[row][col]=info
end

function UIWDCQHaiXuanWin:removeTimeDown(row,col)
if not self.timeDownList or not self.timeDownList[row]then
return
end
self.timeDownList[row][col]=nil
end

function UIWDCQHaiXuanWin:refreshTimeDownItem(curTime)

























if self.timeDownList then
local dataIndex
local curTime=curTime or timeHelper.getServerShortTime()
for row,v in pairs(self.timeDownList)do
dataIndex=row
local widget=self.itemListPanel:getItemWidget(dataIndex)
if widget then
for col,info in pairs(v)do
if info and not info.isRobot then
local subwidget=widget:GetChildWidgetBase(col-1)
local curbaohuLeftTime=info.win_times+info.protect_sec-curTime
local curbaohuFlag=curbaohuLeftTime>0
subwidget:SetChildActive(chairItemCmp.fightBg,not curbaohuFlag)
subwidget:SetChildActive(chairItemCmp.baohuBg,curbaohuFlag)
if curbaohuFlag then
subwidget:SetChildText(chairItemCmp.baohuTime,timeHelper.format_time_stamp3(curbaohuLeftTime))
else
subwidget:SetChildText(chairItemCmp.palyerfight,mathHelper.formatNumber3(info.fight))
self:removeTimeDown(row,col)
end
end
end
end
end
end

end

function UIWDCQHaiXuanWin:reqAndOpenFightingWin(info)

local callback=function(rec_data)
local teamData={{},{},{}}

for i,v in pairs(rec_data)do
if v then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[#tdata+1]={pos=pId,typo=fightEntityType.diZi,guid=v.base.discipleguid,netData=v.base}
end
end
UIManager:showWindow("UIXWSAdjustWin",{selectPos=info.pos,selectGroup=info.group,monTeam=teamData})
end

if info.isRobot then
local posCfg=XiWeiSaiController.getPosCfg(info.group,info.pos)
local monList=posCfg.mon_group_conf
local monTeam=self:getMultipleMonsterList(monList)
UIManager:showWindow("UIXWSAdjustWin",{selectPos=info.pos,selectGroup=info.group,monTeam=monTeam})
else
local args={}
args.serverid=info.serverId
args.group=0
args.stage=0
args.idx=0
args.actType=bigCrossActType.eWDCQ
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eWenDingCangQiong,info.actorId,args,callback,true)
end
end

function UIWDCQHaiXuanWin:getMultipleMonsterList(monList)
local list={}
for i,v in ipairs(monList)do
local mcfg=cfgHelper.get1(cfg_monstergroup_get,v)

local tlist={}
list[i]=tlist
for ii,monsterID in ipairs(mcfg.monList)do
local d={typo=fightEntityType.monster,monsterID=monsterID}
table.insert(tlist,d)
end
end
return list
end




function UIWDCQHaiXuanWin:onChangeBtn()
UIFullWenDingCangQiongControl:showMainWin({loading=true})
end



function UIWDCQHaiXuanWin:onCloseBtn()
fullScreenUI.closeActiveUI()
end



function UIWDCQHaiXuanWin:onTipsBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='wdcqhxs_main_help_%s'})
end



function UIWDCQHaiXuanWin:onRecordBtn()

self.showChangeWin=false
XiWeiSaiController.req_38_42()
end



function UIWDCQHaiXuanWin:onDefendBtn()
local enterCallBack=function(guidList)
local tlist={}
for i,v in ipairs(guidList)do
for ii,vv in ipairs(v[2])do
table.insert(tlist,vv[2])
end
end
if not XiWeiSaiController:checkTeamSame(tlist)then
local sumfight=0
for i,v in ipairs(tlist)do
if not mathHelper.compareInt64(v,Int64_0)then
sumfight=sumfight+UIDiscipleModel:getDiscipleFightValue(v)
end
end
XiWeiSaiController.req_38_43(#tlist,tlist,int64.new(tostring(sumfight)))
else
UIManager.info('保存成功')
end
loadingControl.openCloud(function()
fightController:closeSelectStage()
UIFullWenDingCangQiongControl:showHaiXuanWin({loading=true})
end)
end

local faZeData=nil
local teamData=XiWeiSaiController.getDefendTeamData()
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="问鼎苍穹",
mapId=818009,

faZeData=faZeData,
multipleTeams=teamData,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()
loadingControl.openCloud(function()
fightController:closeSelectStage()
UIFullWenDingCangQiongControl:showHaiXuanWin({loading=true})
end)
end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
defaultSelectTeamIndex=1,
}

fightController.showPrepareWin(eFightPreSelectType.wdcqxiweisaidefendteam,winArgs)
end



function UIWDCQHaiXuanWin:onRewardBtn()
UIManager:showWindow('UIXWSRewardWin')
end



function UIWDCQHaiXuanWin:onRefreshBtn()
local curTime=timeHelper.getServerShortTime()
if self.refreshBtnTime then
local passTime=curTime-self.refreshBtnTime
if passTime<coolTime then
UIManager.info(FMT.fmt("{0}秒后可刷新",coolTime-passTime))
end
return
end
self.refreshBtnTime=curTime
self:refreshBtnState(curTime)
XiWeiSaiController.req_38_41()
end

function UIWDCQHaiXuanWin:onJTtopBtn()
self:jumpTargetItem()
end

function UIWDCQHaiXuanWin:onJTbottomBtn()
self:jumpTargetItem()
end

function UIWDCQHaiXuanWin:onJTtopBtnEx()
self:jumpTargetItem(1)
end

function UIWDCQHaiXuanWin:onJTbottomBtnEx()
self:jumpTargetItem(17)
end

function UIWDCQHaiXuanWin:jumpTargetItem(targetIndex)

if targetIndex then
self.itemListPanel:jumpItem(targetIndex)
return
end
local corPos=XiWeiSaiController.getPlayerRank()
if not corPos then
return
end
local rowCfg=self:getRowCfg(corPos)
local rowIndex=rowCfg.index
self.itemListPanel:jumpItem(rowIndex)
local pos=self.Content:getChildAnchoredPosition()
self.Content:setChildAnchoredPos(pos.x,pos.y+rowCfg.jumpOffest)
self:refreshJiantou()
end



function UIWDCQHaiXuanWin:refreshJiantou()


if not self.gamePlayerFlag then
self:refreshJiantouEx()
return
end

local corPos=XiWeiSaiController.getPlayerRank()
if not corPos then
self:refreshJiantouEx()
return
end

self.JTtopBtnEx:setActive(false)
self.JTbottomBtnEx:setActive(false)

local rowCfg=self:getRowCfg(corPos)
local rowIndex=rowCfg.index

local widget=self.itemListPanel:getItemWidget(rowIndex)
if widget then


local colIndex=rowCfg.colIndex
local subwidget=widget:GetChildWidgetBase(colIndex-1)
local position=subwidget:GetChildPosition(-1)
local screenPoint=CS.CSGUIManager.Instance:WorldToScreenPoint(position)

local tran=self.Viewport:getCommonComponent('RectTransform')
local lpos=CS.CSGUIManager.Instance:ScreenPointToRectTransform(tran,screenPoint,true)



if lpos.y>175 then
self.JTtopBtn:setActive(true)
self.JTbottomBtn:setActive(false)
return
end

if lpos.y<-635 then
self.JTtopBtn:setActive(false)
self.JTbottomBtn:setActive(true)
return
end
self.JTtopBtn:setActive(false)
self.JTbottomBtn:setActive(false)
return
end

local startItem=self.itemListPanel:getListViewItemByItemIdx(1)
local itemCount=self.itemListPanel:getListViewItemShowCount()
local startIndex=startItem.ItemIndex
local endIndex=startIndex+itemCount-1

if rowIndex<=startIndex then
self.JTtopBtn:setActive(true)
self.JTbottomBtn:setActive(false)
return
end
if rowIndex>=endIndex then
self.JTtopBtn:setActive(false)
self.JTbottomBtn:setActive(true)
return
end
self.JTtopBtn:setActive(false)
self.JTbottomBtn:setActive(false)
end

function UIWDCQHaiXuanWin:refreshJiantouEx()

self.JTtopBtn:setActive(false)
self.JTbottomBtn:setActive(false)
self.JTtopBtnEx:setActive(not self:checkChairItemShow(1,1))
self.JTbottomBtnEx:setActive(not self:checkChairItemShow(16,4))
end

function UIWDCQHaiXuanWin:checkChairItemShow(rowIndex,colIndex)

local widget=self.itemListPanel:getItemWidget(rowIndex)
if widget then
local subwidget=widget:GetChildWidgetBase(colIndex-1)
local position=subwidget:GetChildPosition(-1)
local screenPoint=CS.CSGUIManager.Instance:WorldToScreenPoint(position)

local tran=self.Viewport:getCommonComponent('RectTransform')
local lpos=CS.CSGUIManager.Instance:ScreenPointToRectTransform(tran,screenPoint,true)



if lpos.y>175 then
return false
end

if lpos.y<-635 then
return false
end
return true
end

local startItem=self.itemListPanel:getListViewItemByItemIdx(1)
local itemCount=self.itemListPanel:getListViewItemShowCount()
local startIndex=startItem.ItemIndex
local endIndex=startIndex+itemCount-1

if rowIndex<=startIndex then
return false
end
if rowIndex>=endIndex then
return false
end
return true
end


function UIWDCQHaiXuanWin:onScrollViewChange()
self:refreshJiantou()
end



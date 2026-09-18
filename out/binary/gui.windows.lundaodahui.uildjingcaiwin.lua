







def_class("UILDJingCaiWin",UIWindowBase)









function UILDJingCaiWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.jingcaiForget=UIObject.get(self,2)
self.watchButton=UIButton.get(self,3)
self.jingcaiFailRoot=UIObject.get(self,4)
self.jingcaiSuccessRoot=UIObject.get(self,5)
self.jingcaiPanel=UIObject.get(self,6)
self.timeBg=UIObject.get(self,7)
self.sureButton=UIButton.get(self,8)
self.jcb=UILinkImageText.get(self,9)
self.moneyRoot=UIObject.get(self,10)
self.title2=UIText.get(self,11)
self.zhichilv=UIProgress.get(self,12)
self.text2=UIText.get(self,13)
self.fightIcon=UIObject.get(self,14)
self.left=UIButton.get(self,15)
self.right=UIButton.get(self,16)
self.jingcaishibai=UIObject.get(self,17)
self.jingcaichenggong=UIObject.get(self,18)
self.selectCntText=UILinkImageText.get(self,19)
self.selectCntSlider=UIObject.get(self,20)
self.time=UIText.get(self,21)
self.buttonText=UIText.get(self,22)
self.money1Btn=UIButton.get(self,23)
self.rightText=UIText.get(self,24)
self.leftText=UIText.get(self,25)
self.zhizhen=UIObject.get(self,26)
self.leftNum=UIText.get(self,27)
self.select1=UIObject.get(self,28)
self.zhichi1=UIObject.get(self,29)
self.iconHeadItem1=UIObject.get(self,30)
self.lFlag=UIImage.get(self,31)
self.rFlag=UIImage.get(self,32)
self.iconHeadItem2=UIObject.get(self,33)
self.zhichi2=UIObject.get(self,34)
self.select2=UIObject.get(self,35)
self.rightNum=UIText.get(self,36)
self.got2=UILinkImageText.get(self,37)
self.got=UILinkImageText.get(self,38)
self.addBtn=UIButton.get(self,39)
self.xiazhuVal=UIText.get(self,40)
self.subBtn=UIButton.get(self,41)
self.maxCnt=UIButton.get(self,42)
self.handleImg=UIObject.get(self,43)
self.zhichiImg1=UIObject.get(self,44)
self.fight1=UIText.get(self,45)
self.zhichiImg2=UIObject.get(self,46)
self.fight2=UIText.get(self,47)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.watchButton:setButtonClick(function()self:onWatchButton()end)

self.sureButton:setButtonClick(function()self:onSureButton()end)

self.left:setButtonClick(function()self:onLeft()end)

self.right:setButtonClick(function()self:onRight()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)



end


function UILDJingCaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.jingcaiForget);self.jingcaiForget=nil;
_UIObject_release(self.watchButton);self.watchButton=nil;
_UIObject_release(self.jingcaiFailRoot);self.jingcaiFailRoot=nil;
_UIObject_release(self.jingcaiSuccessRoot);self.jingcaiSuccessRoot=nil;
_UIObject_release(self.jingcaiPanel);self.jingcaiPanel=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.sureButton);self.sureButton=nil;
_UIObject_release(self.jcb);self.jcb=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.zhichilv);self.zhichilv=nil;
_UIObject_release(self.text2);self.text2=nil;
_UIObject_release(self.fightIcon);self.fightIcon=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.jingcaishibai);self.jingcaishibai=nil;
_UIObject_release(self.jingcaichenggong);self.jingcaichenggong=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.buttonText);self.buttonText=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.rightText);self.rightText=nil;
_UIObject_release(self.leftText);self.leftText=nil;
_UIObject_release(self.zhizhen);self.zhizhen=nil;
_UIObject_release(self.leftNum);self.leftNum=nil;
_UIObject_release(self.select1);self.select1=nil;
_UIObject_release(self.zhichi1);self.zhichi1=nil;
_UIObject_release(self.iconHeadItem1);self.iconHeadItem1=nil;
_UIObject_release(self.lFlag);self.lFlag=nil;
_UIObject_release(self.rFlag);self.rFlag=nil;
_UIObject_release(self.iconHeadItem2);self.iconHeadItem2=nil;
_UIObject_release(self.zhichi2);self.zhichi2=nil;
_UIObject_release(self.select2);self.select2=nil;
_UIObject_release(self.rightNum);self.rightNum=nil;
_UIObject_release(self.got2);self.got2=nil;
_UIObject_release(self.got);self.got=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.xiazhuVal);self.xiazhuVal=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.zhichiImg1);self.zhichiImg1=nil;
_UIObject_release(self.fight1);self.fight1=nil;
_UIObject_release(self.zhichiImg2);self.zhichiImg2=nil;
_UIObject_release(self.fight2);self.fight2=nil;
end




















function UILDJingCaiWin:onLoaded(...)
self:bindComponents()
end


function UILDJingCaiWin:__delete()
self:unbindComponents()
end




function UILDJingCaiWin:onShow(argtable,afterOnloaded)
self.fightId=argtable.fightId
self.matchType=lundaodahuiModel:getFightMatchType(self.fightId)
self.waitToRecv=true

local matchTime=lundaodahuiModel:getMatchTime(self.matchType)

if matchTime then
local now=timeHelper.getServerLongTime()
if matchTime<=now then
self.timeBg:setActive(false)
self.isOver=true
self.buttonText:setText("已结束")
self.sureButton:setButtonEnable(false,true)
else
self.time:setText(FMT.fmt("<color=#7d3b17>竞猜截止：</color>{0}",timeHelper.format_time_stamp3(matchTime-now)))
self.matchTimer=self:setTimer(1,0,function()
local now=timeHelper.getServerLongTime()
if matchTime<=now then
self.isOver=true
self.timeBg:setActive(false)
if self.matchTimer then
self:stopTimerByID(self.matchTimer)
self.matchTimer=nil
end
self.buttonText:setText("已结束")
self.sureButton:setButtonEnable(false,true)
else
self.time:setText(FMT.fmt("<color=#7d3b17>竞猜截止：</color>{0}",timeHelper.format_time_stamp3(matchTime-now)))
end
end)
end
end

local iconname=iconHelper.getIconName(eMoneyType.mtJingCaiBi)
local moneyRoot=self.moneyRoot:getChildWidgetBase()
moneyRoot:SetChildIcon(0,iconname,false)

local jcRate=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,self.matchType,"jcRate")
self.text2:setText(FMT.fmt("（竞猜成功可获得{0}倍仙筹，失败返还一半仙筹）",jcRate[1]))

local jcbNum=lundaodahuiModel:getJcbNum()

local stamp=timeHelper.getServerShortTime()
local infostamp=lundaodahuiModel:getJingCaiInfoStamp(self.fightId)
if infostamp and stamp<infostamp+60 then
self.isRefresh=true
else
self.isRefresh=nil
lundaodahuiController.req_17_24(self.fightId,0,int64.zero,0)
end

if self.isRefresh then
local fightInfo=lundaodahuiModel:getTTSFightInfoByFightId(self.fightId)
local jingcaiInfo=lundaodahuiModel:getJingCaiInfo(self.fightId)

self:onRefresh(fightInfo,jingcaiInfo[1],true,jingcaiInfo[2],jcbNum)
else
local fightInfo=lundaodahuiModel:getTTSFightInfoByFightId(self.fightId)
self:onRefresh(fightInfo,0,true,nil,jcbNum)
end

local fightInfo=lundaodahuiModel:getTTSFightInfoByFightId(self.fightId)
if fightInfo then
local dzPlayer1=fightInfo.dzPalyerList[1]or{}
local dzPlayer2=fightInfo.dzPalyerList[2]or{}
self.serverId1=dzPlayer1.serverId
self.serverId2=dzPlayer2.serverId
self.playerId1=dzPlayer1.playerId
self.playerId2=dzPlayer2.playerId








if dzPlayer1.fight then
self.fight1:setText(mathHelper.formatNumber(mathHelper.int64_to_number(dzPlayer1.fight)))
end
self:req_actor(dzPlayer1.serverId,dzPlayer1.playerId,function(defense)
self:refresh_actor_defense1(defense)
end)
if dzPlayer2.fight then
self.fight2:setText(mathHelper.formatNumber(mathHelper.int64_to_number(dzPlayer2.fight)))
end
self:req_actor(dzPlayer2.serverId,dzPlayer2.playerId,function(defense)
self:refresh_actor_defense2(defense)
end)

local headWidget1=self.iconHeadItem1:getChildWidgetBase()
self:setHead(dzPlayer1,headWidget1)
local headWidget2=self.iconHeadItem2:getChildWidgetBase()
self:setHead(dzPlayer2,headWidget2)
end

end

function UILDJingCaiWin:req_actor(serverid,actor_id,callback)
otherPlayerController:reqCommonInfo(actor_id,otherPlayerInfoType.eLunDaoDaHuiFight,{serverid=serverid},callback)
end

function UILDJingCaiWin:recv_actor_defense()
if self.playerId1 then

local teams1,otherArgs=otherPlayerModel:getActorDefTeams(otherPlayerInfoType.eLunDaoDaHuiFight,self.playerId1,false)
if teams1 then
self:refresh_actor_defense1(teams1)
end
end
if self.playerId2 then

local teams2,otherArgs=otherPlayerModel:getActorDefTeams(otherPlayerInfoType.eLunDaoDaHuiFight,self.playerId2,false)
if teams2 then
self:refresh_actor_defense2(teams2)
end
end
end

function UILDJingCaiWin:getTotalFight(defenseData)

local totalFight=0
if defenseData then
for i,v in pairs(defenseData)do










totalFight=totalFight+tonumber(tostring(v.fightValNum))
end
end
return totalFight
end

function UILDJingCaiWin:refresh_actor_defense1(defenseData)
local totalFight=self:getTotalFight(defenseData)
self.fight1:setText(mathHelper.formatNumber(totalFight))
end

function UILDJingCaiWin:refresh_actor_defense2(defenseData)
local totalFight=self:getTotalFight(defenseData)
self.fight2:setText(mathHelper.formatNumber(totalFight))
end

function UILDJingCaiWin:onRefresh(dzInfo,xzNum,isRecv,selectPlayer,jcbNum)
if isRecv then
self.waitToRecv=false
end
local dzPlayer1=dzInfo.dzPalyerList[1]
local dzPlayer2=dzInfo.dzPalyerList[2]
local supportNum1=dzPlayer1.supportNum
local supportNum2=dzPlayer2.supportNum
local isXiaZhu=xzNum<=0

self.dzInfo=dzInfo
self.serverId1=dzPlayer1.serverId
self.serverId2=dzPlayer2.serverId
self.playerId1=dzPlayer1.playerId
self.playerId2=dzPlayer2.playerId
self.fightResult1=dzPlayer1.fightResult
self.fightResult2=dzPlayer2.fightResult


self.fightLogIdList=dzInfo.fightLogIdList


local haveResult=self.fightResult1~=0 or self.fightResult2~=0
if self.playerId1==selectPlayer then
self.selectPlayer=self.playerId1
elseif self.playerId2==selectPlayer then
self.selectPlayer=self.playerId2
else
self.selectPlayer=nil
end
self:setSelectPlayer()

if(supportNum1+supportNum2)==0 then
self.zhizhen:setChildAnchoredPosition(Vector3(333,0,0))
self.zhichilv:setProgressValue(50,100)
else
self.zhizhen:setChildAnchoredPosition(Vector3(666*(supportNum1/(supportNum1+supportNum2)),0,0))
self.zhichilv:setProgressValue(supportNum1,supportNum1+supportNum2)
end
self.leftText:setText(FMT.fmt("{0}%",(supportNum1+supportNum2)==0 and 0 or math.floor(supportNum1/(supportNum1+supportNum2)*100)))
self.rightText:setText(FMT.fmt("{0}%",(supportNum1+supportNum2)==0 and 0 or math.ceil(supportNum2/(supportNum1+supportNum2)*100)))
self.leftNum:setText(supportNum1)
self.rightNum:setText(supportNum2)
self.lFlag:setActive(self.fightResult1==1)
self.rFlag:setActive(self.fightResult2==1)


local moneyRoot=self.moneyRoot:getChildWidgetBase()
moneyRoot:SetChildText(1,jcbNum)
local showJcb=false
if(not haveResult)and isXiaZhu then
self.title2:setText("下注仙筹")
self.jingcaiPanel:setActive(true)
self.xiaZhuFlag=true
local mtJingCaiBi=lundaodahuiModel:getJcbNum()
self.max=mtJingCaiBi
local jcMax=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,self.matchType,"jcMax")
if jcMax then
if mtJingCaiBi>jcMax then
self.max=jcMax
end
end
self.min=1
self.selectCnt=1
if mtJingCaiBi<self.min then
self.max=0
self.min=0
self.selectCnt=0
end
self.selectCntSlider:setActive(true)
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
self.fightIcon:setActive(true)
if self.selectPlayer then
self.zhichi1:setActive(self.selectPlayer==self.playerId2)
self.zhichi2:setActive(self.selectPlayer==self.playerId1)
else
self.zhichi1:setActive(true)
self.zhichi2:setActive(true)
end
self.zhichiImg1:setActive(true)
self.zhichiImg2:setActive(true)
if self.max==0 then
self.selectCntText:setText("仙筹不足")
end
else
self.zhichi1:setActive(false)
self.zhichi2:setActive(false)
self.zhichiImg1:setActive(false)
self.zhichiImg2:setActive(false)
self.isOver=true
self.jingcaiPanel:setActive(false)
self.xiaZhuFlag=false
self.watchButton:setActive(haveResult)
self.sureButton:setButtonEnable(false,true)


if haveResult then
self.fightIcon:setActive(false)
self.title2:setText("竞猜结果")
self.buttonText:setText("已结束")
if not isXiaZhu then
local isSuccess=false
if selectPlayer==self.playerId1 then
if self.fightResult1==1 then
isSuccess=true
end
elseif selectPlayer==self.playerId2 then
if self.fightResult2==1 then
isSuccess=true
end
end
self.jingcaiSuccessRoot:setActive(isSuccess)
self.jingcaiFailRoot:setActive(not isSuccess)
local jcRate=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,self.matchType,"jcRate")
if isSuccess then
self.got:setText(FMT.fmt("<color=#7d3b17>仙筹</color><color=#549327>+{0}</color>",xzNum*jcRate[1]-xzNum))
else
self.got2:setText(FMT.fmt("<color=#7d3b17>仙筹</color><color=#c82c2c>{0}</color>",math.floor(xzNum*jcRate[2]-xzNum)))
end
self.jingcaiForget:setActive(false)
else
self.jingcaiForget:setActive(true)
end
self.leftNum:setActive(true)
self.rightNum:setActive(true)
else
if not isXiaZhu then
showJcb=true
self.jcb:setText(FMT.fmt("已下注<color=#7d3b17>{0}</color>仙筹",xzNum))
self.buttonText:setText("已下注")
self.jingcaiForget:setActive(false)
self.leftNum:setActive(true)
self.rightNum:setActive(true)
else
self.jingcaiForget:setActive(true)
self.leftNum:setActive(false)
self.rightNum:setActive(false)
end
self.fightIcon:setActive(true)
end

end
self.jcb:setActive(showJcb)

end

function UILDJingCaiWin:setHead(dzPlayer,headWidget)
if not dzPlayer.name or dzPlayer.name==""then
local name=playerModel:getOtherActorName(dzPlayer.name)
headWidget:SetChildText(3,FMT.fmt("{0}\n{1}","未知区服",name))
headWidget:SetChildActive(4,true)
else
headWidget:SetChildActive(4,false)
local serverName=loginModel:getServerName(dzPlayer.serverId)
headWidget:SetChildText(3,FMT.fmt("{0}\n{1}",serverName,dzPlayer.name))
playerController:setHeadIcon(headWidget,0,{scale=0.55,iconInfo=dzPlayer.iconInfo})
end


headWidget:SetChildButtonClick(2,function()
if not dzPlayer.name or dzPlayer.name==""then
return
end



UIFullLunDaoDaHuiControl:showLookRivalWinNew(dzPlayer.playerId,{dzPlayer.serverId,dzPlayer.iconInfo,dzPlayer.name},true)
end)
end

function UILDJingCaiWin:setSelectPlayer()
self.select1:setActive(self.selectPlayer==self.playerId1)
self.select2:setActive(self.selectPlayer==self.playerId2)
self.zhichi1:setActive(self.selectPlayer==self.playerId2)
self.zhichi2:setActive(self.selectPlayer==self.playerId1)
if self.selectPlayer==nil then
self.sureButton:setButtonEnable(false,true)
else
if not self.isOver then
self.sureButton:setButtonEnable(true,false)
end
end
end


function UILDJingCaiWin:onHide()

end

function UILDJingCaiWin:onSliderChange(value)
if self.max<1 then
return
end
self.selectCnt=value

if self.max==0 then
self.selectCntText:setText("仙筹不足")
else
self.selectCntText:setText(self.selectCnt)
end
end





function UILDJingCaiWin:onCloseBtn()
self:closeSelf()
end



function UILDJingCaiWin:onWatchButton()
if not self.fightLogIdList then
return
end
if#self.fightLogIdList==1 then
local fightId=self.fightLogIdList[1]
local info=self.dzInfo.dzPalyerList

fightController:send_254_29(fightId,{info,fightId,eRePlayerType.lundaodahui},true)
elseif#self.fightLogIdList>1 then
local info=self.dzInfo.dzPalyerList
local serverName1=loginModel:getServerName(info[1].serverId)
local serverName2=loginModel:getServerName(info[2].serverId)

local nameStr1=FMT.fmt("{0}",serverName1)
local nameStr2=FMT.fmt("{0}",serverName2)

local player1={info[1].playerId,info[1].name,info[1].iconInfo,nameStr1}
local player2={info[2].playerId,info[2].name,info[2].iconInfo,nameStr2}

local args={}
args.player1={FMT.fmt("{0}{1}",nameStr1,info[1].name),info[1].iconInfo}
args.player2={FMT.fmt("{0}{1}",nameStr2,info[2].name),info[2].iconInfo}
fightModel:setSendExtraArgs(eBattleType.lundaodahuiJueSai,args)

fightController:send_log_list(self.fightLogIdList,{info,self.fightLogIdList,eRePlayerType.lundaodahuiJueSai,page=3,subPage=self.matchType==eLDMatchType.jijunsai==1 or 2,eReplayType=eRePlayerType.lundaodahuiJueSai,showWinTimes=true,player1=player1,player2=player2},true)

end
end



function UILDJingCaiWin:onSureButton()
if self.waitToRecv then
return
end
local jingcaibi=self.selectCnt
if jingcaibi<1 then
UIManager.error("仙筹不足")
return
end
if not self.selectPlayer then
return
end

local okcallback=function()
if self.isOver then
UIManager.error("已经结算，无法下注")
return
end
UIManager.info("竞猜成功")
lundaodahuiController.req_17_24(self.fightId,self.selectServer,self.selectPlayer,self.selectCnt)
end

local content="竞猜后不可更改，是否确认下注"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=okcallback,
showclosebtn=true,
allowclickBG=true,
}
self.dialog=UIDialogManager.newDialog(showdata)
self.dialog:show()
end



function UILDJingCaiWin:onMaxCnt()
if self.waitToRecv then
return
end
end



function UILDJingCaiWin:onSubBtn()
if self.waitToRecv then
return
end
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UILDJingCaiWin:onAddBtn()
if self.waitToRecv then
return
end
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UILDJingCaiWin:onLeft()
if self.waitToRecv then
return
end
if not self.xiaZhuFlag then
return
end
self.selectServer=self.serverId1
self.selectPlayer=self.playerId1
self:setSelectPlayer()
UIManager.info("已支持")
end

function UILDJingCaiWin:onRight()
if self.waitToRecv then
return
end
if not self.xiaZhuFlag then
return
end
self.selectServer=self.serverId2
self.selectPlayer=self.playerId2
self:setSelectPlayer()
UIManager.info("已支持")
end

function UILDJingCaiWin:onMoney1Btn()
gainControl:showGainWin(eMoneyType.mtJingCaiBi)
end
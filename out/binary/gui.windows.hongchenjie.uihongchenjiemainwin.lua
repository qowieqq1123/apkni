







def_class("UIHongChenJieMainWin",UIWindowBase)









function UIHongChenJieMainWin:bindComponents()

self.Root=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.dzModel=UIObject.get(self,2)
self.enterEffect=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)
self.rightPart=UIObject.get(self,5)
self.leftPart=UIObject.get(self,6)
self.maskClickImg=UIObject.get(self,7)
self.midPart=UIObject.get(self,8)
self.startBtn=UIButton.get(self,9)
self.historyLifeTime=UIText.get(self,10)
self.leftTitlePart=UIObject.get(self,11)
self.historyJJLevel=UIText.get(self,12)
self.hongChenInsight=UIObject.get(self,13)
self.leftBtns=UIObject.get(self,14)
self.LLInfo=UIObject.get(self,15)
self.disposeDz2Btn=UIButton.get(self,16)
self.dzInfo=UIObject.get(self,17)
self.TXZReddot=UIObject.get(self,18)
self.TXZBtn=UIButton.get(self,19)
self.LLRankingBtn=UIButton.get(self,20)
self.GWRewardBtn=UIButton.get(self,21)
self.playInfomationBtn=UIButton.get(self,22)
self.hongChenInsightProgress=UIProgressBarAni.get(self,23)
self.preinfo=UIText.get(self,24)
self.addLLNumBtn=UIButton.get(self,25)
self.LLNumInfo=UIText.get(self,26)
self.dzVocation=UIImage.get(self,27)
self.disposeDzBtn=UIButton.get(self,28)
self.changeDzBtn=UIButton.get(self,29)
self.dzName=UIText.get(self,30)
self.GWReddot=UIObject.get(self,31)
self.LRReddot=UIObject.get(self,32)
self.hongChenInsightBar=UIObject.get(self,33)
self.hongChenInsightProgressInfo=UIText.get(self,34)
self.spDzFlag=UIImage.get(self,35)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.disposeDz2Btn:setButtonClick(function()self:onDisposeDz2Btn()end)

self.TXZBtn:setButtonClick(function()self:onTXZBtn()end)

self.LLRankingBtn:setButtonClick(function()self:onLLRankingBtn()end)

self.GWRewardBtn:setButtonClick(function()self:onGWRewardBtn()end)

self.playInfomationBtn:setButtonClick(function()self:onPlayInfomationBtn()end)

self.addLLNumBtn:setButtonClick(function()self:onAddLLNumBtn()end)

self.disposeDzBtn:setButtonClick(function()self:onDisposeDzBtn()end)

self.changeDzBtn:setButtonClick(function()self:onChangeDzBtn()end)



end


function UIHongChenJieMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.enterEffect);self.enterEffect=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.leftPart);self.leftPart=nil;
_UIObject_release(self.maskClickImg);self.maskClickImg=nil;
_UIObject_release(self.midPart);self.midPart=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.historyLifeTime);self.historyLifeTime=nil;
_UIObject_release(self.leftTitlePart);self.leftTitlePart=nil;
_UIObject_release(self.historyJJLevel);self.historyJJLevel=nil;
_UIObject_release(self.hongChenInsight);self.hongChenInsight=nil;
_UIObject_release(self.leftBtns);self.leftBtns=nil;
_UIObject_release(self.LLInfo);self.LLInfo=nil;
_UIObject_release(self.disposeDz2Btn);self.disposeDz2Btn=nil;
_UIObject_release(self.dzInfo);self.dzInfo=nil;
_UIObject_release(self.TXZReddot);self.TXZReddot=nil;
_UIObject_release(self.TXZBtn);self.TXZBtn=nil;
_UIObject_release(self.LLRankingBtn);self.LLRankingBtn=nil;
_UIObject_release(self.GWRewardBtn);self.GWRewardBtn=nil;
_UIObject_release(self.playInfomationBtn);self.playInfomationBtn=nil;
_UIObject_release(self.hongChenInsightProgress);self.hongChenInsightProgress=nil;
_UIObject_release(self.preinfo);self.preinfo=nil;
_UIObject_release(self.addLLNumBtn);self.addLLNumBtn=nil;
_UIObject_release(self.LLNumInfo);self.LLNumInfo=nil;
_UIObject_release(self.dzVocation);self.dzVocation=nil;
_UIObject_release(self.disposeDzBtn);self.disposeDzBtn=nil;
_UIObject_release(self.changeDzBtn);self.changeDzBtn=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.GWReddot);self.GWReddot=nil;
_UIObject_release(self.LRReddot);self.LRReddot=nil;
_UIObject_release(self.hongChenInsightBar);self.hongChenInsightBar=nil;
_UIObject_release(self.hongChenInsightProgressInfo);self.hongChenInsightProgressInfo=nil;
_UIObject_release(self.spDzFlag);self.spDzFlag=nil;
end



















local this


function UIHongChenJieMainWin:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.on_money_changed,function(...)self:on_money_changed(...)end)
notifySystem:listenNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)

self.isCanClickNext=true
end


function UIHongChenJieMainWin:__delete()
notifySystem:removelistener(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
self:unbindComponents()
this=nil
end




function UIHongChenJieMainWin:onShow(argtable,afterOnloaded)


self.id=argtable and argtable.id
self.data=hongChenJieModel:getGameHandle(self.id)
self.discipleGuid=self.data:getSelectDisciple()

local discipleData=UIDiscipleModel:getDiscipleData(self.discipleGuid)
if discipleData==nil then
self.discipleGuid=nil
self.data:setSelectDisciple(self.discipleGuid)
end

self:refreshTXZData()
self:refreshAll()
self:preparePlayAnim()

buildlightController:setBLState(false)

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHongChenJieFreeTips)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHongChenJieFreeTips,true)
end
end


function UIHongChenJieMainWin:onHide()

end

function UIHongChenJieMainWin:onShowArgRecv(args)
self:onShow(args)
end


function UIHongChenJieMainWin:refreshAll()

self:refreshMid()

self:refreshLeft()

self:refreshRight()

end

function UIHongChenJieMainWin:refreshLeft()

local historyLifeTime
local historyJJLevel
local dzHongChenInsightCurValue=0
local money_max=hongChenJieConfig.getBaseInfo(self.id,'money_max')
local moneyType=hongChenJieConfig.getBaseInfo(self.id,'money_type')
dzHongChenInsightCurValue=moneyModel.getMoney(moneyType)
dzHongChenInsightCurValue=Mathf.Min(dzHongChenInsightCurValue,money_max)


historyLifeTime=self.data:getMaxYear()
historyLifeTime=FMT.fmt('{0}年',historyLifeTime)
historyJJLevel=self.data:getMaxLevel()
historyJJLevel=self.data:getJingJieName(historyJJLevel,1)


local historyLifeTimeStr=FMT.fmt('历史时长：{0}',historyLifeTime)
local historyJJLevelStr=FMT.fmt('历史境界：{0}',historyJJLevel)

self.historyLifeTime:setText(historyLifeTimeStr)
self.historyJJLevel:setText(historyJJLevelStr)
self.preinfo:setText(itemsModel.getName(moneyType))
self.hongChenInsightProgress:animateThreeParams(dzHongChenInsightCurValue,money_max,0.2)
self.hongChenInsightBar:setChildIconFillAmount(dzHongChenInsightCurValue/money_max)
self.hongChenInsightProgressInfo:setText(FMT.fmt("{0}/{1}",dzHongChenInsightCurValue,money_max))

self.GWReddot:setActive(self.data:reddotGWReward())
self.LRReddot:setActive(self.data:reddotRankingReward())
end

function UIHongChenJieMainWin:refreshMid()
self:refreshModel()
self:refreshTimes()
end

function UIHongChenJieMainWin:refreshModel()
if self.discipleGuid then
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.discipleGuid,false,1)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.dzModel:getID(),true,false,true)
self.dzModel:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false,0)
self.dzModel:setChildUIModelShowFlipX(true)

local dzName=UIDiscipleModel:getDiscipleName(self.discipleGuid)
self.dzName:setText(dzName)

local jobicon=UIDiscipleModel:getJobIconNameX(self.discipleGuid)
self.dzVocation:setSprite(globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(self.discipleGuid)
self.spDzFlag:setActive(isSpDz)
end
local isShowDz=self.discipleGuid~=nil
self.dzModel:setActive(isShowDz)
self.dzInfo:setActive(isShowDz)
self.disposeDz2Btn:setActive(not isShowDz)
end

function UIHongChenJieMainWin:refreshTimes()
local freeCount=hongChenJieConfig.getBaseInfo(self.id,'free_num')
local buyCount=self.data:getBuyTimes()
local usedNum=self.data:getTimes()
local totalNum=freeCount+buyCount

local useNumInfo=totalNum-usedNum>0 and usedNum or toColorStringX(FONT_COLOR.eRedColor,usedNum)
local str=FMT.fmt("{0}/{1}",useNumInfo,totalNum)
local llNumInfo=FMT.fmt('踏入次数: {0}',str)
self.LLNumInfo:setText(llNumInfo)
end


function UIHongChenJieMainWin:refreshRight()
local isShow=self.discipleGuid~=nil

self.disposeDzBtn:setActive(not isShow)
self.changeDzBtn:setActive(isShow)
self.startBtn:setActive(isShow)
end


function UIHongChenJieMainWin:on_money_changed(mtype,last,curr)
local money_type=hongChenJieConfig.getBaseInfo(self.id,'money_type')
if money_type==mtype then
self:refreshLeft()
end
end





function UIHongChenJieMainWin:onAddLLNumBtn()
local todayBuyCount=self.data:getBuyTimes()
local buyCountCost=hongChenJieConfig.getBaseInfo(self.id,'consume')
local todayMaxBuyCount=#buyCountCost
local max=todayMaxBuyCount-todayBuyCount
if max<=0 then
UIManager.info("今日购买次数已耗尽")
return
end
local buyId=self.id

local costMoneyType=buyCountCost[1][1]


local getNeedCostNum=function(num)
local totalcost=0
for index=todayBuyCount+1,todayBuyCount+num do
local cost=buyCountCost[index]
totalcost=totalcost+cost[2]
end
return totalcost
end
local refresh=function(num)
local totalcost=getNeedCostNum(num)

local costIconName=iconHelper.getIconName(costMoneyType)
local costIconStr=chatEmotHelper.getIconEmotMesg(costIconName,40)
local haveNum=itemsModel.getCount(costMoneyType)
local costColor=FONT_COLOR.eRedColor
if haveNum>=totalcost then
costColor=FONT_COLOR.eGreenColor
end
local costStr=toColorString(costColor,totalcost)
local countStr=FMT.fmt("{0}次",num)
local surplusNum=max-num
local contentStr=FMT.fmt("是否花费{0}{1}购买{2}踏入次数",costIconStr,costStr,countStr,surplusNum)
return contentStr
end


local show_data={
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
max=max,
tips=FMT.fmt("（今日剩余次数：{0}）",max),
oktext='购买',
canceltext='取消',

tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local totalcost=getNeedCostNum(num)
moneySystem:useMoney(costMoneyType,totalcost,function()
hongChenJieController:reqBuyLLCount(buyId,num)
end,WARNING_TYPE.eWarning)
end,
moneytypes={{costMoneyType}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIHongChenJieMainWin:onPlayInfomationBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_jctj_hcj_help_%s'})
end



function UIHongChenJieMainWin:onLLRankingBtn()
UIFullHongChenJieControl:showWindow("UIHongChenJieRankingWin",{id=self.id})
end



function UIHongChenJieMainWin:onChangeDzBtn()
local _this=self
if self.data:checkIsGaming()then















UIManager.error('中途退出无法更换弟子')
else
self.data:showDisposeDzWin()
end
end



function UIHongChenJieMainWin:onDisposeDzBtn()
if self.data:checkIsGaming()then
UIManager.error('中途退出无法更换弟子')
else
self.data:showDisposeDzWin()
end
end



function UIHongChenJieMainWin:onStartBtn()



local data=self.data
local id=self.id
local discipleguid=data:getSelectDisciple()

local func=function()
if data:checkStartCount()then

if data:checkSelectIdentityProgress()then

local identityList=data:getIdentityList()
UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showPrepareWin({id=id,identityList=identityList})
end)
else
local isRestart=data:checkArchive()and HongChenJieRefreshIdentityState.restart or HongChenJieRefreshIdentityState.normal
hongChenJieController:reqRandIdentiy(id,discipleguid,isRestart)
end
else
if data:checkSelectIdentityProgress()then

local identityList=data:getIdentityList()
UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showPrepareWin({id=id,identityList=identityList})
end)
else
if self.data:checkIsCanBuyTimes()then
self:onAddLLNumBtn()
else
UIManager.error("踏入次数已耗尽")
end
end
end
end


local continueFunc=function()

if data:checkSelectIdentityProgress()then

local identityList=data:getIdentityList()
UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showPrepareWin({id=id,identityList=identityList})
end)
else

UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showGameWin({id=id})
end)
end
end
if data:checkArchive()then

local showdata=
{
type='UIDialouge',
title='提示',
content='是否以上次进度继续体验？\n(重新开始会消耗次数并结算上次进度奖励)',
oktext='继续体验',
canceltext='重新开始',
allowclickBG='false',
okcallback=continueFunc,
cancelcallback=func,
showclosebtn=true,
}
self.quitDialog=UIDialogManager.newDialog(showdata)
self.quitDialog:show()
else
func()
end
end

function UIHongChenJieMainWin:onDisposeDz2Btn()
self.data:showDisposeDzWin()
end

function UIHongChenJieMainWin:onGWRewardBtn()
UIFullHongChenJieControl:showWindow('UIHongChenJieGWRewardWin',{id=self.id})
end

function UIHongChenJieMainWin.onTYTXZRewardChange(passport_guid)
if passport_guid==this.passport_guid then
this:refreshTXZBtn()
end
end

function UIHongChenJieMainWin:isHideTxzBtn()
self.passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'passParm')
self.iconParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'iconParm')

local passporttype=self.passParm[1]
local sys_id=self.passParm[2]
local sub_sys_id=self.passParm[3]
local guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)
local txzId=UITYTongXingZhengModel:getTXZId(guid)

if not guid or not txzId then
local str=string.format("系統id：%s-%s 拿取guid或通行证id有误，请联系前端排查！！！",sys_id,sub_sys_id)
logErr(str)
end

if UITYTongXingZhengModel:isReceiveFullIncludeCharge(guid,txzId)then
local config=cfgHelper.get2(cfg_passportconfig_get,txzId,'drop_id')
if not config then
return false
end
end
return true
end

function UIHongChenJieMainWin:refreshTXZData()
self.passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'passParm')
self.iconParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'iconParm')

local passporttype=self.passParm[1]
local sys_id=self.passParm[2]
local sub_sys_id=self.passParm[3]
self.passport_guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)

if self.passport_guid then
self:refreshTXZBtn()
else
this.TXZBtn:setActive(false)
end
end

function UIHongChenJieMainWin:refreshTXZBtn()
local iconname=self.iconParm[1]
local abname=self.iconParm[2]
local reddot=UITYTongXingZhengController:checkReddot(self.passport_guid)

this.TXZReddot:setActive(reddot)

local flag=self:isHideTxzBtn()
if not flag then
UIManager:invokeUIMethod("UITYTXZRewardsWin","onCloseBtn")
end
this.TXZBtn:setActive(flag)


end

function UIHongChenJieMainWin:onTXZBtn()
if self.passport_guid then
UITYTongXingZhengController:showTXZWin(self.passport_guid,passportDefine.eHCJ)
end
end


function UIHongChenJieMainWin:playEnterPrepareWinAnim(id,identityList,d1,d2,d3)
d1=d1 or 3
d2=d2 or 2
d3=d3 or 4.5

local _this=self
local func=function()


_this.enterEffect:setChildShowEffect(20254,true)
_this.dzModel:setChildModelAnimationState(eAnimationID.attack7_2,1,nil)

_this:delayDo(d1,function()
_this.dzModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
_this.bgSpine:setChildSpineAnimation(2302,1,nil)
end)

_this:delayDo(d2,function()


_this.dzModel:setChildCanvasGroupDOFade(0,1,nil)
end)
_this:delayDo(d3,function()
UIFullHongChenJieControl:showPrepareWin({id=id,identityList=identityList})
_this.bgSpine:setChildSpineAnimation(2302,0,nil)
end)
end

UIManager:invokeUIMethod("UIHongChenJieTopWin",'hideBtn')

self.uiRoot:setChildCanvasGroupDOFade(0,1,func)
self.maskClickImg:setActive(true)
end

function UIHongChenJieMainWin:preparePlayAnim()
self.uiRoot:setChildCanvasGroupAlpha(1)
self.maskClickImg:setActive(false)
self.enterEffect:setChildShowEffect(20208,false)
self.bgSpine:setChildSpineAnimation(eAnimationID.stand,1,nil)
self.dzModel:setChildCanvasGroupAlpha(1)

self.dzModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
end










def_class("UITYTXZRewards_LevelWin",UIWindowBase)









function UITYTXZRewards_LevelWin:bindComponents()

self.buyBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.fullActiveFlag=UIObject.get(self,3)
self.fullPointTxt=UIText.get(self,4)
self.fullRoot=UIObject.get(self,5)
self.guanggaoci=UIImage.get(self,6)
self.guanggaocibg=UIObject.get(self,7)
self.jfname=UIText.get(self,8)
self.jumpBtn=UIButton.get(self,9)
self.lefttime=UIText.get(self,10)
self.level=UIText.get(self,11)
self.lvProgressBar=UIObject.get(self,12)
self.lvProgressRoot=UIObject.get(self,13)
self.lvProgressTxt=UIText.get(self,14)
self.modelBg=UIObject.get(self,15)
self.name=UIText.get(self,16)
self.pricesBtn=UIButton.get(self,17)
self.pricesCount=UIText.get(self,18)
self.ratio1=UIImage.get(self,19)
self.ratio1txt=UIText.get(self,20)
self.ratio2=UIImage.get(self,21)
self.ratio2txt=UIText.get(self,22)
self.recvDesc=UIText.get(self,23)
self.recvTimes=UIText.get(self,24)
self.rewadProgress=UIObject.get(self,25)
self.rewardProgressBar=UIObject.get(self,26)
self.root=UIObject.get(self,27)
self.ruleBtn=UIButton.get(self,28)
self.selectkuang=UIObject.get(self,29)
self.shopScrollerView=UIObject.get(self,30)
self.suo1=UIObject.get(self,31)
self.suo2=UIObject.get(self,32)
self.timeRoot=UIObject.get(self,33)
self.titleText=UIText.get(self,34)
self.touziName_1=UIText.get(self,35)
self.touziName_2=UIText.get(self,36)
self.unlcokBtn=UIButton.get(self,37)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.pricesBtn:setButtonClick(function()self:onPricesBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)
self.touziName={
self.touziName_1,
self.touziName_2,
}



end


function UITYTXZRewards_LevelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.fullActiveFlag);self.fullActiveFlag=nil;
_UIObject_release(self.fullPointTxt);self.fullPointTxt=nil;
_UIObject_release(self.fullRoot);self.fullRoot=nil;
_UIObject_release(self.guanggaoci);self.guanggaoci=nil;
_UIObject_release(self.guanggaocibg);self.guanggaocibg=nil;
_UIObject_release(self.jfname);self.jfname=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.lvProgressBar);self.lvProgressBar=nil;
_UIObject_release(self.lvProgressRoot);self.lvProgressRoot=nil;
_UIObject_release(self.lvProgressTxt);self.lvProgressTxt=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.pricesBtn);self.pricesBtn=nil;
_UIObject_release(self.pricesCount);self.pricesCount=nil;
_UIObject_release(self.ratio1);self.ratio1=nil;
_UIObject_release(self.ratio1txt);self.ratio1txt=nil;
_UIObject_release(self.ratio2);self.ratio2=nil;
_UIObject_release(self.ratio2txt);self.ratio2txt=nil;
_UIObject_release(self.recvDesc);self.recvDesc=nil;
_UIObject_release(self.recvTimes);self.recvTimes=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.selectkuang);self.selectkuang=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.suo1);self.suo1=nil;
_UIObject_release(self.suo2);self.suo2=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.touziName_1);self.touziName_1=nil;
_UIObject_release(self.touziName_2);self.touziName_2=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
self.touziName=nil;
end



















local _this
local abname="ui/windows/tongyongtxz/uitytxz_atlas_pak.ab"

function UITYTXZRewards_LevelWin:onLoaded(...)
_this=self
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(6288,1,{},eAnimationID.enter)
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)






local _freshWin=function()
_this:refreshWin()
end
self:addProNotify(29,12,_freshWin)
self:addProNotify(29,13,_freshWin)
self:addProNotify(29,14,_freshWin)
self:addProNotify(29,15,_freshWin)
end


function UITYTXZRewards_LevelWin:__delete()
self:unbindComponents()
_this=nil
self:stopTickTimer()
end




function UITYTXZRewards_LevelWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

if argtable then
self.guid=argtable.guid
self.txzId=argtable.txzId or 1
self.passportId=argtable.passportId
self.config=cfgHelper.get1(cfg_passportconfig_get,self.txzId)
self.guanggaoci:setCSImageSprite(abname,self.config.guanggaoicon)

self.endTime=UITYTongXingZhengModel:getEndTime(self.guid)
self.lastShowBuyBtn=0
local buy_level_conf=self.config.buy_level_conf
if buy_level_conf then
local day=buy_level_conf[1]
self.lastShowBuyBtn=day*86400
end
end

self:refreshWin()
end


function UITYTXZRewards_LevelWin:onHide()

end

function UITYTXZRewards_LevelWin:refreshWin()
self:freshInfo()
self:freshLevelProgress()
self:refreshBuyBtn()
end

function UITYTXZRewards_LevelWin:freshInfo()
local isJump=self.config.jump~=nil
self.jumpBtn:setActive(isJump)

local titleName=self.config.titlename
local num=UITYTongXingZhengModel:getProgress(self.guid)
if self.config.jifen_reduce then
num=math.floor(num/self.config.jifen_reduce)
end

self.timeRoot:setActive(true)
self:stopTickTimer()

local tick=function()
local endStr=UITYTongXingZhengModel:getCurLeftDay(self.guid)

_this:refreshBuyBtn()

if endStr then
_this.lefttime:setText(FMT.fmt('本期剩余时间：<color=#171311>{0}</color>',endStr))
else
_this.timeRoot:setActive(false)
_this:stopTickTimer()
end
end
self.tickTimer=self:setTimer(1,0,tick)
tick()

local touziCfg=self.config.investname
local ratioConfig=self.config.multiple_text

self.ratio1txt:setText(FMT.fmt("{0}收益",ratioConfig[1]))
self.ratio2txt:setText(FMT.fmt("{0}收益",ratioConfig[2]))

self.name:setText(titleName)
self.touziName[1]:setText(touziCfg[1])
self.touziName[2]:setText(touziCfg[2])









self.suo1:setActive(not UITYTongXingZhengModel:hasTouziMoney(self.guid))
self.suo2:setActive(not UITYTongXingZhengModel:hasTouziRecharge(self.guid))

local cfgs=UITYTongXingZhengModel:getPrizeCfgsByIndex(self.txzId)
self.rewardsCfgs=cfgs
self.rewardLen=#cfgs

local drop_id=cfgHelper.get2(cfg_passportconfig_get,self.txzId,'drop_id')
self.isShowFinalBoxRewardItem=drop_id~=nil

if self.isShowFinalBoxRewardItem then
self.rewardLen=self.rewardLen+1

self:refreshFull()
end
self.fullRoot:setActive(self.isShowFinalBoxRewardItem)

self.shopScrollerView:setChildScrollViewCreateGrids(self.rewardLen,1)
local grids=self.shopScrollerView:getChildScrollViewItemWidgets()
for i=1,self.rewardLen do
self:SetItemData(grids[i-1],i)
end

self.unlcokBtn:setActive(UITYTongXingZhengModel:hasAnyTouzi(self.guid))

local isFull=UITYTongXingZhengModel:isFinishFullLayer_Level(self.guid)
self.fullActiveFlag:setActive(isFull)

local selectIdx
local prizelayer=UITYTongXingZhengModel:getCanPizeLayer(self.guid,self.txzId)
selectIdx=prizelayer

if selectIdx and selectIdx<=0 and isFull then
selectIdx=self.rewardLen
end
selectIdx=selectIdx or 0
self.shopScrollerView:setChildScrollViewSelectItem(selectIdx,false,false,true)

local progress=0
local min=self.rewardsCfgs[1].layer

if isFull then
progress=1
else
local num=UITYTongXingZhengModel:getLevel(self.guid)
if num>min then
progress=self:getStageSegementProgressVal(num,self.isShowFinalBoxRewardItem)
end
end

self.rewadProgress:setChildIconFillAmount(progress)
end
function UITYTXZRewards_LevelWin:SetItemData(widget,index)
local isFinal=false
if self.isShowFinalBoxRewardItem then
isFinal=index==self.rewardLen
end

widget:SetChildActive(0,not isFinal)
if isFinal then return end

local widget2=widget:GetChildWidgetBase(0)
self:onFreshAction(index,widget2)
end

local _rewardItemCmpIndex={
self=0,
select=1,
spriteAni=2,
lock=3,
gray=4,
}
local _rewardListConfig={
[buyFlagType.free]={1,'freeReward'},
[buyFlagType.money]={2,'lock1Reward'},
[buyFlagType.recharge]={3,'lock2Reward'}
}
function UITYTXZRewards_LevelWin:onFreshAction(index,widget)
local rewardsCfgs=self.rewardsCfgs
local cfg=rewardsCfgs[index]
local layer=cfg.layer

local textnum=layer
if self.config.jifen_reduce then
textnum=math.floor(textnum/self.config.jifen_reduce)
end
widget:SetChildText(0,textnum)

local isRecved=UITYTongXingZhengModel:checkIsRecvedGradeReward(self.guid,index,buyFlagType.free)
local isCanRecv=UITYTongXingZhengModel:checkCanRecvGrade(self.guid,layer,index,buyFlagType.free)

widget:SetChildActive(4,isRecved or isCanRecv)

for type,rwCfg in ipairs(_rewardListConfig)do
local layoutIndex=rwCfg[1]
local rwkey=rwCfg[2]

local itemsList=cfg[rwkey]or{}
local isUnlock=UITYTongXingZhengModel:checkUnLockRewardType(_this.guid,type)
isRecved=UITYTongXingZhengModel:checkIsRecvedGradeReward(self.guid,index,type)
isCanRecv=UITYTongXingZhengModel:checkCanRecvGrade(self.guid,layer,index,type)
widget:SetChildLayoutGroupCreateItems(layoutIndex,#itemsList)
local grids=widget:GetChildLayoutGroupGridList(layoutIndex)
for gindex=1,grids.Count do
local widget1=grids[gindex-1]
local data={}
local reward=itemsList[gindex]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
widgetHelper.setNormalRewardItem(widget1,0,data)

widget1:SetChildActive(_rewardItemCmpIndex.select,isRecved)
widget1:SetChildActive(_rewardItemCmpIndex.spriteAni,isCanRecv)
widget1:SetChildActive(_rewardItemCmpIndex.lock,not isUnlock)
widget1:SetChildActive(_rewardItemCmpIndex.gray,not isUnlock or isRecved)
if isCanRecv then
widget1:SetChildButtonClick(2,function()
self:onPrize()
end,true)
end
end
end
end

function UITYTXZRewards_LevelWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
end

function UITYTXZRewards_LevelWin:onStartAction()

end

function UITYTXZRewards_LevelWin:onPrize()
local idx=UITYTongXingZhengModel:getMaxLayer_Level(self.txzId)
socketManager:send_29_12(self.guid,idx)
end

function UITYTXZRewards_LevelWin:refreshFull()
local name=self.config.rewardname
local desc=self.config.rewarddesc
local jfname=self.config.jfname
local jfvalue=self.config.cost

local recvedTimes=UITYTongXingZhengModel:getRecvTimes(self.guid)
local canrecvtines=UITYTongXingZhengModel:getCanRecvFinalBigRewardBoxCount(self.guid)
local descstr=string.format(desc,jfvalue,jfname)
local progress=UITYTongXingZhengModel:getProgress(self.guid)
local remainProgress=progress-recvedTimes*jfvalue
local recvstr=string.format("积分: %s/%s",remainProgress,jfvalue)

self.titleText:setText(name)
self.recvDesc:setText(descstr)
self.recvTimes:setText(recvstr)
self.pricesCount:setText(canrecvtines)
self.selectkuang:setActive(canrecvtines>0)
self.fullPointTxt:setText("秘宝")
end

function UITYTXZRewards_LevelWin:freshLevelProgress()
local level,exp,expMax=UITYTongXingZhengModel:getLevelProgressInfo(self.guid)

self.level:setText(level)
self.jfname:setText("等级")

self.lvProgressBar:setChildIconFillAmount(exp/expMax)
self.lvProgressTxt:setText(FMT.fmt("{0}/{1}",exp,expMax))
end
function UITYTXZRewards_LevelWin:refreshBuyBtn()
local curTime=timeHelper.getServerShortTime()

local isFull=UITYTongXingZhengModel:isFinishFullLayer_Level(self.guid)
if isFull then
self.buyBtn:setActive(false)
return
end

if self.lastShowBuyBtn==0 then
self.buyBtn:setActive(false)
return
end

local left=self.endTime-curTime
local isShow=self.lastShowBuyBtn>=left
self.buyBtn:setActive(isShow)
end



function UITYTXZRewards_LevelWin:onCloseBtn()
self:closeSelf()
end


function UITYTXZRewards_LevelWin:onRuleBtn()
local name=self.config.infoDesc
if name then
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=name})
end
end


function UITYTXZRewards_LevelWin:onUnlcokBtn()
UIManager:showWindow('UITYTongXingZhengTouZiWin',{guid=self.guid,txzId=self.txzId,passportId=self.passportId})
end


function UITYTXZRewards_LevelWin:onPricesBtn()
local value=UITYTongXingZhengModel:getCanRecvFinalBigRewardBoxCount(self.guid)
if not value or value==0 then
UIManager.info("可领取秘宝礼盒次数不足")
local itemId=self.config.showTips
if itemId then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=itemId,showModel=true})

end
else
socketManager:send_29_15(self.guid,value)
end
end

function UITYTXZRewards_LevelWin:onBuyBtn()
local passCfg=self.rewardsCfgs
local buy_level_conf=self.config.buy_level_conf
local curLevel=UITYTongXingZhengModel:getLevel(self.guid)
local consumeList=buy_level_conf[3]
local rewardCfgTemp={
{rwType=buyFlagType.free,cfgkey="freeReward"},
{rwType=buyFlagType.money,cfgkey="lock1Reward"},
{rwType=buyFlagType.recharge,cfgkey="lock2Reward"},
}
local args={}
args.moneyList={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}}
args.max_lv=#buy_level_conf[3]
args.curLevel=curLevel
args.canvas=8
args.desFmtStr="提升至 <size=28><color=#7d3b17>{0}</color></size> 级，可获得以下奖励"
args.levelFmtStr="购买{0}级："
args.getDataFunc=function(startIndex,endIndex)
local list={}
local lookup={}
for _,v in ipairs(rewardCfgTemp)do
if UITYTongXingZhengModel:checkUnLockRewardType(_this.guid,v.rwType)then
for index,cfg in pairs(passCfg)do
local tlevel=cfg.layer
local rlist=cfg[v.cfgkey]
if tlevel>=startIndex and tlevel<=endIndex then
for __,itemCfg in ipairs(rlist)do
if lookup[itemCfg[1]]then
lookup[itemCfg[1]]=lookup[itemCfg[1]]+itemCfg[2]
else
lookup[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
end
for itemid,cnt in pairs(lookup)do
local color=itemsConfig.getItemColor(itemid)
table.insert(list,{itemid,cnt,color,showStage=true})
end
return list
end
args.consumeItemId=buy_level_conf[2]
args.getNeedValueFunc=function(butCnt)
local need=0
for i=curLevel+1,curLevel+butCnt do
need=need+consumeList[i]
end
return need
end
args.buyFunc=function(selectCnt)
local buy_level=selectCnt-curLevel
UITYTongXingZhengController.reqBuyExp(_this.guid,buy_level)
end
self:showWindow("UICommonBuyWin",args)
end

function UITYTXZRewards_LevelWin:onJumpBtn()
UIManager:showWindow("UISubAct_TXZGotoWin",{cfg=self.config})
end

function UITYTXZRewards_LevelWin:getStageSegementProgressVal(curVal,isReduce)
local stageScoreRewardList=self.rewardsCfgs

local maxSegement=#stageScoreRewardList
local maxStage=maxSegement
if not isReduce then
maxStage=maxStage-1
end
local singleSegement=1/maxStage

local pre=0
local cur=0
local curSe=0
local boundVal=0

for index,segement in ipairs(stageScoreRewardList)do
boundVal=segement.layer
cur=boundVal
if boundVal>curVal then
break
end
pre=cur
curSe=index
end

local v_dur=curVal-pre
local b_dur=cur-pre

b_dur=Mathf.Max(1,b_dur)

if curSe>1 then
curSe=curSe-1
end

return curSe*singleSegement+(v_dur/b_dur)*singleSegement
end
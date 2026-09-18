







def_class("UIBaoLingShuWin",UIWindowBase)









function UIBaoLingShuWin:bindComponents()

self.root=UIObject.get(self,0)
self.jumpBehavior=UIButton.get(self,1)
self.qifuBtnOne=UIButton.get(self,2)
self.qifuBtnTen=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.qifuOneText=UIText.get(self,5)
self.qifuOneCost=UIObject.get(self,6)
self.qifuOneMoneyImg=UIImage.get(self,7)
self.qifuOneMoneyTxt=UIText.get(self,8)
self.qifuTenMoneyTxt=UIText.get(self,9)
self.tipsText=UIText.get(self,10)
self.qifuTenMoneyImg=UIImage.get(self,11)
self.tipsBtn=UIButton.get(self,12)
self.xuyuanCntText=UIText.get(self,13)
self.qifuOneFreeText=UIText.get(self,14)
self.pickUpPanel=UIObject.get(self,15)
self.pickUpGBModel=UIObject.get(self,16)
self.pickUpTime=UIText.get(self,17)
self.pickUpTips=UIImage.get(self,18)
self.pickShopBtn=UIButton.get(self,19)
self.pickUpShowLBtn=UIButton.get(self,20)
self.pickUpShowRBtn=UIButton.get(self,21)
self.pickUpShopBtnReddot=UIObject.get(self,22)
self.pickUpBgModel=UIObject.get(self,23)
self.pickUpGBClick=UIButton.get(self,24)
self.changePickUpBtn=UIButton.get(self,25)

self.jumpBehavior:setButtonClick(function()self:onJumpBehavior()end)

self.qifuBtnOne:setButtonClick(function()self:onQifuBtnOne()end)

self.qifuBtnTen:setButtonClick(function()self:onQifuBtnTen()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.pickShopBtn:setButtonClick(function()self:onPickShopBtn()end)

self.pickUpShowLBtn:setButtonClick(function()self:onPickUpShowLBtn()end)

self.pickUpShowRBtn:setButtonClick(function()self:onPickUpShowRBtn()end)

self.pickUpGBClick:setButtonClick(function()self:onPickUpGBClick()end)

self.changePickUpBtn:setButtonClick(function()self:onChangePickUpBtn()end)



end


function UIBaoLingShuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jumpBehavior);self.jumpBehavior=nil;
_UIObject_release(self.qifuBtnOne);self.qifuBtnOne=nil;
_UIObject_release(self.qifuBtnTen);self.qifuBtnTen=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.qifuOneText);self.qifuOneText=nil;
_UIObject_release(self.qifuOneCost);self.qifuOneCost=nil;
_UIObject_release(self.qifuOneMoneyImg);self.qifuOneMoneyImg=nil;
_UIObject_release(self.qifuOneMoneyTxt);self.qifuOneMoneyTxt=nil;
_UIObject_release(self.qifuTenMoneyTxt);self.qifuTenMoneyTxt=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.qifuTenMoneyImg);self.qifuTenMoneyImg=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.xuyuanCntText);self.xuyuanCntText=nil;
_UIObject_release(self.qifuOneFreeText);self.qifuOneFreeText=nil;
_UIObject_release(self.pickUpPanel);self.pickUpPanel=nil;
_UIObject_release(self.pickUpGBModel);self.pickUpGBModel=nil;
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.pickUpTips);self.pickUpTips=nil;
_UIObject_release(self.pickShopBtn);self.pickShopBtn=nil;
_UIObject_release(self.pickUpShowLBtn);self.pickUpShowLBtn=nil;
_UIObject_release(self.pickUpShowRBtn);self.pickUpShowRBtn=nil;
_UIObject_release(self.pickUpShopBtnReddot);self.pickUpShopBtnReddot=nil;
_UIObject_release(self.pickUpBgModel);self.pickUpBgModel=nil;
_UIObject_release(self.pickUpGBClick);self.pickUpGBClick=nil;
_UIObject_release(self.changePickUpBtn);self.changePickUpBtn=nil;
end

















local _this=nil
local configId
local timerList
local pickUpGBLoopTime=5


function UIBaoLingShuWin:onLoaded(...)
self:bindComponents()
_this=self
timerList={}
configId=baoLingShuModel:getConfId()
self.config=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)

self:addNotify(notifyConfig.onBaoLingShuPickUpStateChange,self.onBaoLingShuPickUpStateChange)
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChange)
self:addNotify(notifyConfig.on_item_changed,self.onItemChange)
end


function UIBaoLingShuWin:__delete()
self:stopAudioSound()
self:stopAudioSound_bg()
self:stopPickUpGBShowTimer()
self:stopPickUpGBModelLoadTimer()
self:changeBtnDoPunchRotation(false)
self:closeStage()
isometricMapSystem:leaveStoryMode(false)
UIManager.enableAllTips()
UIManager:closeWindow('UIBaoLingShuMainHUD')
_this=nil
timerList=nil
self:unbindComponents()
end




function UIBaoLingShuWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable,afterOnloaded)
end

function UIBaoLingShuWin:onShowArgRecv(argtable,afterOnloaded)
self.isHide=nil
self:addDzEntity()
self:dzMove()
UIManager.disableAllTips(false)

self:stopAudioSound()
self:stopAudioSound_bg()
self.audioHandleId_bg=nil
self.punchIntervalTime=2





if afterOnloaded then
self.defaultModelScale=self.pickUpGBModel:getScale()
self:flushCost()
self:refreshPickUpShopBtnReddot()
end
self:flushPickUpPanel(afterOnloaded)

if argtable and argtable.args and argtable.args.needOpenPickUpPage then

local openPageIndex=argtable.args.openPageIndex
UIFullBaoLingShuControl:showBaoLingShuPickUpWindow({openPageIndex=openPageIndex})
end
end


function UIBaoLingShuWin:onHide()
self.isHide=true

self.pickUpPanel:setActive(false)
self:stopAudioSound()
self:stopAudioSound_bg()
self:stopPickUpGBShowTimer()
self:stopPickUpGBModelLoadTimer()
self:changeBtnDoPunchRotation(false)
self:closeStage()
isometricMapSystem:leaveStoryMode(false)
UIManager.enableAllTips()
UIManager:closeWindow('UIBaoLingShuMainHUD')
end

function UIBaoLingShuWin:closeStage()
if not baoLingShuController.fightStage or baoLingShuController.fightStage.stageID~=101 then
return
end

self:stopOverTimer()
self:stopMoveTimer()
self:stopShowJumpBehaviorTimer()
for i=1,self.dzCount do
local ent=baoLingShuController.fightStage:getEntity(101+i)
ent:stopMoveTo()
ent:stopBehavior()
baoLingShuController.fightStage:removeEntity(101+i)
end
baoLingShuController.fightStage:close()
self.dzCount=0
self.entList={}
end

local function _onClickItem(itemid,index,guid,attach)
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIBaoLingShuWin:flushCost()
self.data=baoLingShuModel:get_baolingshu_data(configId)
if self.data then
self:flushOneCost()
self:flushTenCost()
local remainNum_orange=self.config.cjNum-self.data[2]
if remainNum_orange<=0 then
remainNum_orange=1
end
local tips_orange=FMT.fmt("<color=#549327>{0}</color> 次许愿后必出<color=#ca631d>橙色古宝</color>",remainNum_orange)
local remainNum_red=self.config.bdRedGuBao-self.data[16]
if remainNum_red<=0 then
remainNum_red=1
end
local tips_red=FMT.fmt("<color=#549327>{0}</color> 次许愿后必出<color=#c82c2c>红色古宝</color>",remainNum_red)
self.tipsText:setText(FMT.fmt("{0}\n{1}",tips_orange,tips_red))

local moneyname=moneyModel.getMoneyName(eMoneyType.mtLingYu)
local moneylimit_str=FMT.fmt('每日{0}许愿: <color=#ca631dff>{1}/{2}</color>次',moneyname,self.data[7],self.config.moneyLimit)
self.xuyuanCntText:setText(moneylimit_str)
end
end


function UIBaoLingShuWin:flushOneCost()
local freenum=baoLingShuModel:get_baolingshu_free_num()
local notFree=freenum<=0
self.qifuOneCost:setActive(notFree)
self.qifuOneText:setText(notFree and'许愿1次'or'免费许愿')
local freenum_str
if notFree then
freenum_str=''
local cost=self.config.useItem
local itemid=cost[1]
local needCnt=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem<needCnt then
local moneyType=cost[3]
local price=cost[4]
local isEnough=moneyModel.checkEnoughMoney(moneyType,price)
if isEnough then
itemid=moneyType
needCnt=price
end
end
local iconName=iconHelper.getIconName(itemid)
self.qifuOneMoneyImg:setImageIcon(iconName)
self.qifuOneMoneyTxt:setText(needCnt)
else
freenum_str=FMT.fmt('免费许愿: <color=#CA631D>{0}</color>次',freenum)
end
self.qifuOneFreeText:setText(freenum_str)
end


function UIBaoLingShuWin:flushTenCost()
local cost=self.config.useItem
local itemid=cost[1]
local needCnt=cost[2]*10
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem<needCnt then
local moneyType=cost[3]
local price=cost[4]*10
local isEnough=moneyModel.checkEnoughMoney(moneyType,price)
if isEnough then

itemid=moneyType

needCnt=price
end
end
local iconName=iconHelper.getIconName(itemid)
self.qifuTenMoneyImg:setImageIcon(iconName)
self.qifuTenMoneyTxt:setText(needCnt)
end

local _worldOffset=fightModel.getWorldCenter()
local originPos=
{
Vector3.New(2.56,0,-3.46)+_worldOffset,
Vector3.New(-0.72,0,-3.92)+_worldOffset,
Vector3.New(5.51,0,-2.14)+_worldOffset,
Vector3.New(-3.11,0,-2.8)+_worldOffset,
Vector3.New(7.57,0,-3.72)+_worldOffset,
Vector3.New(-5.37,0,-3.33)+_worldOffset,
}
function UIBaoLingShuWin:addDzEntity()
local dzList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
self.dzCount=#dzList>=6 and 6 or#dzList
for i=1,self.dzCount do
local rand=math.random(1,#dzList)
local dzData=dzList[rand]
local netdata=dzData.netData
local net=netdata.net
local dzId=net.discipleguid
baoLingShuController.fightStage:addEntity(101+i,fightEntityType.diZi,dzId,originPos[i]or originPos[1],false)
table.remove(dzList,rand)
end

self.entList={}
for i=1,self.dzCount do
local ent=baoLingShuController.fightStage:getEntity(101+i)
self.entList[#self.entList+1]=ent
end
UIManager:showWindow('UIBaoLingShuMainHUD',{entList=self.entList,config=self.config,dzCount=self.dzCount})
end

function UIBaoLingShuWin:dzMove()
if self.posList==nil then
self.posList={}
end
for i=1,self.dzCount do
local ent=self.entList[i]
if self.posList[i]==nil then
local pos=ent:getPosition()
self.posList[i]=pos
end
local list={-0.7,0.7}
local rand=math.random(1,#list)
local offsetX=list[rand]
self:loopMove(ent,self.posList[i],i,offsetX)
end
end

function UIBaoLingShuWin:loopMove(ent,pos,index,offsetX)
if self.isInQifuAnim then
return
end

local tarPosX=pos.x+offsetX
local tarPos=Vector3(tarPosX,pos.y,pos.z)
local time=math.random()+math.random(0,3)
local timer=self:delayDo(time,function(...)
if timerList[index]then
self:stopTimerByID(timerList[index])
end
timerList[index]=nil
local func=function(...)
ent:runAnimator(0,1)
self:loopMove(ent,pos,index,-offsetX)
end
ent:moveTo(tarPos,false,2.4,1,func)
ent:runAnimator(10,1)

local curPos=ent:getPosition()
ent:flipX(tarPosX>curPos.x)
end)
timerList[index]=timer
end


function UIBaoLingShuWin:runQiFuBehavior(configId,qifuCnt,typo,isFree)
self.isInQifuAnim=true
self:stopOverTimer()
self:stopMoveTimer()
self:stopShowJumpBehaviorTimer()
if self.dzCount==0 then
UIManager.error('没有弟子可许愿')
return
end

for i=1,self.dzCount do
local ent=self.entList[i]
ent:stopMoveTo()
ent.baolingShuHUD:showRoot(false)
if i~=1 then
ent:setVisible(false)
end
ent:fadeToColor(Color.New(1,1,1,0),0)
end
local firstFlag=self.data[6]
local showJumpBtn=true
if firstFlag==0 then
showJumpBtn=false
end

self.root:setActive(false)
UIManager:invokeUIMethod("UIForeGroundThreeWin","setRootActive",false)
self.jumpBehavior:setActive(false)
local func=function()
self.delayShowJumpBehaviorTimer=nil
self.jumpBehavior:setActive(showJumpBtn)
end
self.delayShowJumpBehaviorTimer=self:delayDo(5,func)
UIManager:hideWindow('UITopMoneyWin')
UIManager:callWindowFunc('UIBaoLingShuMainHUD','showPassAni',false)

UIManager.setMoneyMsgShowState(false,true)
baoLingShuController:req_qifu(configId,qifuCnt,typo,nil,isFree)


self:stopAudioSound()
if qifuCnt==1 then

self.audioHandleId=AudioManager.playAudio(518)
else

self.audioHandleId=AudioManager.playAudio(455)
end
end


function UIBaoLingShuWin:overQiFuExpression()
self.isInQifuAnim=false
self:stopShowJumpBehaviorTimer()
self.root:setActive(true)
self.jumpBehavior:setActive(false)
UIManager:showWindow('UITopMoneyWin')
UIManager:invokeUIMethod("UIForeGroundThreeWin","setRootActive",true)
end

function UIBaoLingShuWin:fadeShowDZ()
for i=1,self.dzCount do
local ent=self.entList[i]
ent:moveTo(originPos[i],false,0,1,nil)
ent:setVisible(true)
ent:fadeToColor(Color.New(1,1,1,1),1)
ent:runAnimator(0,1)
end
self.ovetTimer=self:delayDo(1,function(...)
for i=1,self.dzCount do
local ent=self.entList[i]
ent.baolingShuHUD:showRoot(true)
end
self:dzMove()
end)
end

function UIBaoLingShuWin:stopMoveTimer()
for i=1,self.dzCount do
if timerList and timerList[i]then
self:stopTimerByID(timerList[i])
timerList[i]=nil
end
end
end

function UIBaoLingShuWin:stopOverTimer()
if self.ovetTimer then
self:stopTimerByID(self.ovetTimer)
self.ovetTimer=nil
end
end

function UIBaoLingShuWin:stopShowJumpBehaviorTimer()
if self.delayShowJumpBehaviorTimer then
self:stopTimerByID(self.delayShowJumpBehaviorTimer)
self.delayShowJumpBehaviorTimer=nil
end
end


function UIBaoLingShuWin:flushPickUpPanel(isInit)
if isInit then
self.pickUpBgModel:setChildUIModelShowTarget(4862,0.24,{},eAnimationID.stand)
self.pickUpBgModel:setChildUIModelShowTargetOffset(0,18)
end

local pickUpShowGBList=baoLingShuModel:getPickUpShowGBList()
if pickUpShowGBList and next(pickUpShowGBList)then
self.showPickUpGbSelectIndex=1
local showCount=#pickUpShowGBList
self.showPickUpGbMaxSelectIndex=showCount
self.pickUpPanel:setActive(true)
self:refreshPickUpGBModel()
if showCount<=1 then

self.pickUpShowLBtn:setActive(false)
self.pickUpShowRBtn:setActive(false)
self.nextPickUpGBShowTime=nil
else

self.pickUpShowLBtn:setActive(true)
self.pickUpShowRBtn:setActive(true)
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
end

self:setPickUpGBShowTimer()
else

self.pickUpPanel:setActive(false)
self.pickShopBtn:setActive(false)
end

local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
local isShowChangeBtn=false
if isInPickUpNow then
local roundCount=baoLingShuModel:getPickUpShowGBPickUpRoundCount()
if roundCount and roundCount>1 then
isShowChangeBtn=true
end
end
self.changePickUpBtn:setActive(isShowChangeBtn)
self:changeBtnDoPunchRotation(isShowChangeBtn)
end

function UIBaoLingShuWin:refreshPickUpGBModel()

self.pickUpGBModel:setChildShowEffect(0,false)
local pickUpShowGBList=baoLingShuModel:getPickUpShowGBList()
local showCfg=pickUpShowGBList[self.showPickUpGbSelectIndex]
local showGBItemId=showCfg[1]
local gbId=gubaoLookup:good2GuBao(showGBItemId)
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid


local scale=self.defaultModelScale or Vector3.New(0.44,0.44,0.44)
self.pickUpGBModel:setScale(Vector3.zero)
self.pickUpGBModel:setChildShowEffect(effectId,true)
self:stopPickUpGBModelLoadTimer()
self.pickUpModelLoadTimer=self:delayDo(0.2,function()
if _this==nil then return end

_this.pickUpGBModel:setScale(scale)
end)


end

function UIBaoLingShuWin:pickUpGBJumpShow(jumpIndex,isInit)
self.pickUpShowScroller:setChildScrollViewSelectItem(jumpIndex-1,not isInit,false,false)
end

function UIBaoLingShuWin:setPickUpGBShowTimer()
self:stopPickUpGBShowTimer()
local timerFun=function(isFirst)
local nowTime=timeHelper.getServerLongTime()
if not isFirst and nowTime>=self.nextPickUpGBShowTime then
self:onPickUpShowRBtn()
end

local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
local abName="ui/windows/baolingshu/baolingshu_pickup_atlas_pak.ab"
if isInPickUpNow then
local lerp=eTime-nowTime
self.pickUpTime:setText(FMT.fmt("{0}",timeHelper.format_time_stamp11(lerp,true)))

self.pickUpTips:setSprite(abName,"image_qijiangubaoui_2")
else
if nsTime then
local lerp=nsTime-nowTime
self.pickUpTime:setText(FMT.fmt("预计{0}后开启",timeHelper.format_time_stamp11(lerp,true)))

self.pickUpTips:setSprite(abName,"image_qijiangubaoui_5")
else

self.pickUpPanel:setActive(false)
self.pickShopBtn:setActive(false)
return self:stopPickUpGBShowTimer()
end
end
end
self.pickUpShowTimer=self:setTimer(1,0,function()
return timerFun()
end)
timerFun(true)
end

function UIBaoLingShuWin:stopPickUpGBShowTimer()
if self.pickUpShowTimer then
self:stopTimerByID(self.pickUpShowTimer)
self.pickUpShowTimer=nil
end
end

function UIBaoLingShuWin:refreshPickUpShopBtnReddot()
local reddot=baoLingShuModel:checkBLSPickUpEnterReddot()
self.pickUpShopBtnReddot:setActive(reddot)
end

function UIBaoLingShuWin:stopPickUpGBModelLoadTimer()
if self.pickUpModelLoadTimer then
self:stopTimerByID(self.pickUpModelLoadTimer)
self.pickUpModelLoadTimer=nil
end
end




function UIBaoLingShuWin:onTipsBtn()


oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.blsrewards,{cjType=self.config.cjType,showType=1})
end

function UIBaoLingShuWin:checkQiFuNum(qifuCnt,isWarning)
local numLimit=self.config.numLimit
local curnum=self.data[5]
if curnum>=numLimit then
if isWarning then
UIManager.error('今日许愿总次数已达上限')
end
return false
elseif curnum+qifuCnt>numLimit then
if isWarning then
UIManager.error(FMT.fmt('剩余许愿总次数不足{0}次',qifuCnt))
end
return false
end
return true
end

function UIBaoLingShuWin:checkQiFuMoneyNum(qifuCnt,isWarning)
local moneyLimit=self.config.moneyLimit
local curmoney=self.data[7]
if curmoney>=moneyLimit then
if isWarning then
UIManager.error('今日灵玉许愿次数已达上限')
end
return false
elseif curmoney+qifuCnt>moneyLimit then
if isWarning then
UIManager.error(FMT.fmt('剩余灵玉许愿次数不足{0}次',qifuCnt))
end
return false
end
return true
end


function UIBaoLingShuWin:onQifuBtnOne()
local qifuCnt=1
if not self:checkQiFuNum(qifuCnt,true)then
return
end
local freenum=baoLingShuModel:get_baolingshu_free_num()
local free=freenum>0
local cost=self.config.useItem
local itemid=cost[1]
local itemCnt=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local qifuCntLerp=haveItem-itemCnt
if free or qifuCntLerp>=0 then

self:startItemQifuAnimation(qifuCnt,free)
else

qifuCntLerp=-qifuCntLerp
if not self:checkQiFuMoneyNum(qifuCntLerp,true)then
return
end


local moneyType=cost[3]
local price=cost[4]*qifuCntLerp
local isEnough=moneyModel.checkEnoughMoney(moneyType,price)
if not isEnough and moneyType==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(moneyType)
local needXianYuCount=price-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end

if isEnough then
self:reqMoneyQifu(cost,qifuCnt,qifuCntLerp)
else

UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end
end


function UIBaoLingShuWin:onQifuBtnTen()
local qifuCnt=10
if not self:checkQiFuNum(qifuCnt,true)then
return
end
local cost=self.config.useItem
local itemid=cost[1]
local itemCnt=cost[2]*qifuCnt
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local qifuCntLerp=haveItem-itemCnt
if qifuCntLerp>=0 then

self:startItemQifuAnimation(qifuCnt)
else

qifuCntLerp=-qifuCntLerp
if not self:checkQiFuMoneyNum(qifuCntLerp,true)then
return
end


local moneyType=cost[3]
local price=cost[4]*qifuCntLerp
local isEnough=moneyModel.checkEnoughMoney(moneyType,price)
if not isEnough and moneyType==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(moneyType)
local needXianYuCount=price-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end

if isEnough then
self:reqMoneyQifu(cost,qifuCnt,qifuCntLerp)
else

UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end
end

function UIBaoLingShuWin:startItemQifuAnimation(qifuCnt,isFree)
local checkPass=baoLingShuModel:getBLSPassAniState()
if checkPass then
baoLingShuController:req_qifu(configId,qifuCnt,0,nil,isFree)
else
self:runQiFuBehavior(configId,qifuCnt,0,isFree)
end
end

function UIBaoLingShuWin:reqMoneyQifu(cost,qifuCnt,qifuCntLerp)

local ignoreDialouge=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBaoLintShuBuyDialog)
local biItemID=cost[1]
local itemid=cost[3]
local itemCnt=cost[4]*qifuCntLerp
local songid=cost[5]
local songCnt=cost[6]*qifuCntLerp
local hasBi=qifuCnt-qifuCntLerp
local biName=itemsConfig.getItemName(biItemID)
local costName=moneyModel.getMoneyName(itemid)
local songName=moneyModel.getMoneyName(songid)
local contentStr
if hasBi>0 then
contentStr=FMT.fmt('是否使用<color=#7d3b17ff>{0}</color>个{1}，并花费<color=#7d3b17ff>{2}</color>{3}购买{4}{5}\n（赠送<color=#7d3b17ff>许愿{6}次</color>）',
hasBi,biName,itemCnt,costName,songCnt,songName,qifuCntLerp)
else
contentStr=FMT.fmt('是否花费<color=#7d3b17ff>{0}</color>{1}购买{2}{3}\n（赠送<color=#7d3b17ff>许愿{4}次</color>）',
itemCnt,costName,songCnt,songName,qifuCntLerp)
end
if ignoreDialouge then
self:startMoneyQifuAnimation(itemid,itemCnt,qifuCnt)
else


















local okcallback=function(...)
_this:startMoneyQifuAnimation(itemid,itemCnt,qifuCnt)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eBaoLintShuBuyDialog)
end
end

function UIBaoLingShuWin:startMoneyQifuAnimation(itemid,need,qifuCnt)
local callback=function()
local checkPass=baoLingShuModel:getBLSPassAniState()
if checkPass then
baoLingShuController:req_qifu(configId,qifuCnt,1)
else
self:runQiFuBehavior(configId,qifuCnt,1)
end
end

moneySystem:useMoney(itemid,need,callback,WARNING_TYPE.eWarning)
end

function UIBaoLingShuWin:changeBtnDoPunchRotation(isShow)
if isShow then
if self.changeBtnTweener==nil then
self.changePickUpBtn:setRotation(0,0,0)
local tweener=self.changePickUpBtn:setChildDOPunchRotation(Vector3(0,0,15),2,6,1,function()
if _this==nil or _this.isHide then return end
return _this:delayDo(_this.punchIntervalTime,function()
if _this==nil or _this.isHide then return end
if _this.changeBtnTweener then
_this:changeBtnDoPunchRotation(false)
_this:changeBtnDoPunchRotation(isShow)
end
end)
end)
tweener:SetEase(_Ease.Linear)

self.changeBtnTweener=tweener
end
else
if self.changeBtnTweener~=nil then
self.changeBtnTweener:Complete()
self.changeBtnTweener:Kill()
self.changeBtnTweener=nil
self.changePickUpBtn:setRotation(0,0,0)
end
end
end

function UIBaoLingShuWin:onCloseBtn()
UIFullBaoLingShuControl:closeUI(true,true)
end

function UIBaoLingShuWin:onJumpBehavior()
baoLingShuController.fightStage:resetCamera()
local ent=self.entList[1]
ent:stopBehavior()

self:stopAudioSound()
UIManager:callWindowFunc('UIBaoLingShuMainHUD','jumpToOverShowReward')
end

function UIBaoLingShuWin:stopAudioSound()
if self.audioHandleId then
AudioManager.stopAudioById(self.audioHandleId)
self.audioHandleId=nil
end
end

function UIBaoLingShuWin:stopAudioSound_bg()
if self.audioHandleId_bg then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.audioHandleId_bg,fadeTime,false)
self.audioHandleId_bg=nil
end
end

function UIBaoLingShuWin:onPickUpGBClick()

local pickUpShowGBList=baoLingShuModel:getPickUpShowGBList()
local showCfg=pickUpShowGBList[self.showPickUpGbSelectIndex]
local showGBItemId=showCfg[1]
itemsComponentHelper.onItemClickEx(showGBItemId)
end

function UIBaoLingShuWin:onPickShopBtn()

UIFullBaoLingShuControl:showBaoLingShuPickUpWindow()
end


function UIBaoLingShuWin:onPickUpShowLBtn()











local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex<=1 then







self.showPickUpGbSelectIndex=self.showPickUpGbMaxSelectIndex
else

self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex-1
end
self:refreshPickUpGBModel()
end


function UIBaoLingShuWin:onPickUpShowRBtn()











local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex>=self.showPickUpGbMaxSelectIndex then







self.showPickUpGbSelectIndex=1
else

self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex+1
end
self:refreshPickUpGBModel()
end


function UIBaoLingShuWin:onChangePickUpBtn()
self:showWindow("UIBaoLingShuPickUp_ChangeWin")
end


function UIBaoLingShuWin.onBaoLingShuPickUpStateChange(isOpenPickUp)
if _this==nil then return end

_this:flushPickUpPanel()

_this:flushCost()
end

function UIBaoLingShuWin.onMoneyChange(moneyType,lastVal,val)
local cost=_this.config.useItem
local costMoneyType=cost[3]
if moneyType==costMoneyType then
_this:flushCost()
end
end

function UIBaoLingShuWin.onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local cost=_this.config.useItem
local costItemId=cost[1]
if itemid==costItemId then
_this:flushCost()
end
end

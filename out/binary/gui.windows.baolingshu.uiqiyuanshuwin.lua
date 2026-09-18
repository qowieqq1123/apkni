







def_class("UIQiYuanShuWin",UIWindowBase)









function UIQiYuanShuWin:bindComponents()

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
self.openRoot=UIObject.get(self,26)
self.unopenRoot=UIObject.get(self,27)
self.wishChangeMask=UIButton.get(self,28)
self.wishChangeBtn=UIButton.get(self,29)
self.wishGbItem=UIObject.get(self,30)
self.wishGbName=UIText.get(self,31)
self.bigRewardGroup=UIObject.get(self,32)
self.openTimeTipsText=UIText.get(self,33)
self.passAni=UIToggleButton.get(self,34)
self.wishGubaoBgModel=UIObject.get(self,35)
self.openTimeTipsLayout=UIObject.get(self,36)
self.tomorrowOpenTips=UIObject.get(self,37)
self.remainingTimeTipsText=UIText.get(self,38)
self.changywbtn=UIButton.get(self,39)
self.baoXiangReddot=UIImage.get(self,40)

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

self.wishChangeMask:setButtonClick(function()self:onWishChangeMask()end)

self.wishChangeBtn:setButtonClick(function()self:onWishChangeBtn()end)

self.changywbtn:setButtonClick(function()self:onChangywbtn()end)



end


function UIQiYuanShuWin:unbindComponents()
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
_UIObject_release(self.openRoot);self.openRoot=nil;
_UIObject_release(self.unopenRoot);self.unopenRoot=nil;
_UIObject_release(self.wishChangeMask);self.wishChangeMask=nil;
_UIObject_release(self.wishChangeBtn);self.wishChangeBtn=nil;
_UIObject_release(self.wishGbItem);self.wishGbItem=nil;
_UIObject_release(self.wishGbName);self.wishGbName=nil;
_UIObject_release(self.bigRewardGroup);self.bigRewardGroup=nil;
_UIObject_release(self.openTimeTipsText);self.openTimeTipsText=nil;
_UIObject_release(self.passAni);self.passAni=nil;
_UIObject_release(self.wishGubaoBgModel);self.wishGubaoBgModel=nil;
_UIObject_release(self.openTimeTipsLayout);self.openTimeTipsLayout=nil;
_UIObject_release(self.tomorrowOpenTips);self.tomorrowOpenTips=nil;
_UIObject_release(self.remainingTimeTipsText);self.remainingTimeTipsText=nil;
_UIObject_release(self.changywbtn);self.changywbtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
end
















local _this=nil
local timerList
local stageID=106




function UIQiYuanShuWin:onLoaded(...)
self:bindComponents()
_this=self
timerList={}
self.config=cfgHelper.get1(cfg_wishtreeconfig_get,1)
self:setChildButtonClickDown(self.passAni:getID(),function(...)
self:onChangePassAni()
end,true,0)

self:addNotify(notifyConfig.on_money_changed,self.onMoneyChange)
self:addNotify(notifyConfig.on_item_changed,self.onItemChange)
end


function UIQiYuanShuWin:__delete()
qiYuanShuModel:saveQYSPassAniState()
self:stopAudioSound()
self:stopAudioSound_bg()
self:clearOpenTipsTimer()
self:clearRemainingTipsTimer()
self:stopBigRewardModelAllLoadTimer()
self:closeStage()
isometricMapSystem:leaveStoryMode(false)
UIManager.enableAllTips()
UIManager:closeWindow('UIBaoLingShuMainHUD')
_this=nil
timerList=nil
self:unbindComponents()
end


function UIQiYuanShuWin:onChangywbtn()
self:showWindow("UIQiYuanShuPickUp_ChangeWin")
local reddot=qiYuanShuModel:isNewReddot()
if reddot then
local list=cfg_wishtreelibconfig()
userActorSetting.set('UIQiYuanShuWinreddot',#list)
userActorSetting.flush()
self:doPunchRotation(false)
reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)
end
end




function UIQiYuanShuWin:onShow(argtable,afterOnloaded)
qiYuanShuModel:setQiYuanShuOpenlist()
self:onShowArgRecv(argtable,afterOnloaded)
end

function UIQiYuanShuWin:onShowArgRecv(argtable,afterOnloaded)
self:addDzEntity()

UIManager.disableAllTips(false)

self:stopAudioSound()
self:stopAudioSound_bg()
self.audioHandleId_bg=nil
self.bigRewardModelLoadTimer={}





if afterOnloaded then
self.wishGubaoBgModel:setChildUIModelShowTarget(4862,0.24,{},eAnimationID.stand)
self.wishGubaoBgModel:setChildUIModelShowTargetOffset(0,18)
end

self.checkPass=qiYuanShuModel:getQYSPassAniState()

self.passAni:setToggle(self.checkPass)

self:refresh(true)

if argtable and argtable.args and argtable.args.needOpenPickUpPage then

local openTabType=argtable.args.openTabType
UIFullBaoLingShuControl:showQiYuanShuPickUpWindow({openTabType=openTabType})
end
end


function UIQiYuanShuWin:onHide()
qiYuanShuModel:saveQYSPassAniState()

self.pickUpPanel:setActive(false)
self.bigRewardGroup:setActive(false)
self:stopAudioSound()
self:stopAudioSound_bg()
self:clearOpenTipsTimer()
self:clearRemainingTipsTimer()
self:stopBigRewardModelAllLoadTimer()
self:closeStage()
isometricMapSystem:leaveStoryMode(false)
UIManager.enableAllTips()
UIManager:closeWindow('UIBaoLingShuMainHUD')
end

function UIQiYuanShuWin:closeStage()
if not baoLingShuController.fightStage or baoLingShuController.fightStage.stageID~=stageID then
return
end

self:stopOverTimer()
self:stopMoveTimer()
self:stopShowJumpBehaviorTimer()
for i=1,self.dzCount do
local ent=baoLingShuController.fightStage:getEntity(stageID+i)
ent:stopMoveTo()
ent:stopBehavior()
baoLingShuController.fightStage:removeEntity(stageID+i)
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

function UIQiYuanShuWin:refresh(isInit)
self.lib_id=qiYuanShuModel:getQiYuanShuId()
self.data=qiYuanShuModel:get_qiyuanshu_data()
if isInit then

self:refreshBigRewardShow()
end


self:refreshBaoDiNum()


local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if isInQiYuanNow then

self.openRoot:setActive(true)
self.unopenRoot:setActive(false)

self:flushCost()


self:refreshWishGbPanel()
self:setRemainingTipsTimer()


local _List=qiYuanShuModel:getQiYuanShuOpenlist()
if _List and next(_List)then
self.changywbtn:setActive(true)
if qiYuanShuModel:isNewReddot()then
self:doPunchRotation(true)
end
else
self.changywbtn:setActive(false)
end
else

self.openRoot:setActive(false)
self.unopenRoot:setActive(true)

self.changywbtn:setActive(false)
self:setOpenTipsTimer()
end


self:refreshPickUpShopBtnReddot()


end


function UIQiYuanShuWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setActive(true)
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setActive(false)
end
end
end


function UIQiYuanShuWin:refreshPickUpShopBtnReddot()
local reddot=qiYuanShuModel:checkQiYuanShopReddot()
self.pickUpShopBtnReddot:setActive(reddot)
end

function UIQiYuanShuWin:refreshBigRewardShow()
local bigRewardCfg=qiYuanShuModel:getQiYuanShu_bigRewardShow(self.lib_id)

if not bigRewardCfg then
self.bigRewardGroup:setActive(false)
return
end
self.bigRewardGroup:setActive(true)
local rewardList=qiYuanShuModel:getShowDatas(bigRewardCfg)
local showRewards=rewardList[3]
local grids=self.bigRewardGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local gubaoItemId=showRewards[i]
if gubaoItemId then
widget:SetChildActive(-1,true)

local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid
if pram.effectid2 then
effectId=pram.effectid2
end

local scale=widget:GetChildScale(1)
widget:SetChildScale(1,Vector3.zero)
widget:SetChildShowEffect(1,effectId,true)
self:stopBigRewardModelLoadTimer(i)
self.bigRewardModelLoadTimer[i]=self:delayDo(0.2,function()
if _this==nil then return end
local widget=_this.bigRewardGroup:getChildCommonLayoutGroupWidgetItem(i-1)
widget:SetChildScale(1,scale)
end)



local name=itemCfg.name
widget:SetChildText(0,name)


widget:SetChildButtonClick(2,function()
itemsComponentHelper.onItemClickEx(gubaoItemId)
end,true)
else
widget:SetChildActive(-1,false)
end
end
end

function UIQiYuanShuWin:refreshWishGbPanel()

local wishGbId=qiYuanShuModel:getQiYuanShuWishGbId()
local hasWishGbId=wishGbId~=nil and wishGbId~=0
self.wishChangeMask:setActive(not hasWishGbId)
self.wishChangeBtn:setActive(hasWishGbId)
self.wishGbItem:setActive(hasWishGbId)
local wishGbName="未选心愿"
if hasWishGbId then
local itemid=gubaoLookup:gubao2GoodActive(wishGbId)
local widget=self.wishGbItem:getWidgetBase()
local conf={itemid=itemid,itemcount="",showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
wishGbName=itemsConfig.getItemName(itemid)
end
self.wishGbName:setText(wishGbName)
end

function UIQiYuanShuWin:refreshBaoDiNum()
local baodiNum_orange=self.data and self.data.bdNum or 0


local remainNum_orange=self.config.cjNum-baodiNum_orange
if remainNum_orange<=0 then
remainNum_orange=1
end
local tips_orange=FMT.fmt("<color=#549327>{0}</color> 次许愿后必出<color=#ca631d>橙色古宝</color>",remainNum_orange)

local baodiNum_red=self.data and self.data.bdNum_red or 0
local bdGuBao2=qiYuanShuModel:getQiYuanShu_bdGuBao(self.lib_id)
local remainNum_red=bdGuBao2[1]-baodiNum_red
if remainNum_red<=0 then
remainNum_red=1
end
local tips_red=FMT.fmt("<color=#549327>{0}</color> 次许愿后必出<color=#c82c2c>红色古宝</color>",remainNum_red)


self.tipsText:setText(FMT.fmt("{0}\n{1}",tips_orange,tips_red))
end

function UIQiYuanShuWin:flushCost()
if self.data then
self:flushOneCost()
self:flushTenCost()
end
end


function UIQiYuanShuWin:flushOneCost()
local freenum=qiYuanShuModel:get_qiyuanshu_free_num()
local notFree=freenum<=0
self.qifuOneCost:setActive(notFree)
self.qifuOneText:setText(notFree and'祈愿1次'or'免费祈愿')
local freenum_str
if notFree then
freenum_str=''
local cost=self.config.useItem
local itemid=cost[1]
local needCnt=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local moneyType=cost[3]
if haveItem<needCnt and moneyType~=nil then
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
freenum_str=FMT.fmt('免费祈愿: <color=#CA631D>{0}</color>次',freenum)
end
self.qifuOneFreeText:setText(freenum_str)
end


function UIQiYuanShuWin:flushTenCost()
local cost=self.config.useItem
local itemid=cost[1]
local needCnt=cost[2]*10
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local moneyType=cost[3]
if haveItem<needCnt and moneyType~=nil then
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
Vector3.New(0.5,0,-1.5)+_worldOffset,








}

function UIQiYuanShuWin:addDzEntity()
local originalDzList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort)
local maxSelectDzNum=1
local dzList={}
for i,dzData in ipairs(originalDzList)do
local netdata=dzData.netData
local net=netdata.net
local dzId=net.discipleguid
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,false,1)
if modelParams.componets[1]then
dzList[#dzList+1]=dzData
end
end

self.dzCount=#dzList>=maxSelectDzNum and maxSelectDzNum or#dzList
self.showDzIdList={}
for i=1,self.dzCount do
local rand=math.random(1,#dzList)
local dzData=dzList[rand]
local netdata=dzData.netData
local net=netdata.net
local dzId=net.discipleguid
baoLingShuController.fightStage:addEntity(stageID+i,fightEntityType.diZi,dzId,originPos[i]or originPos[1],false)
self.showDzIdList[i]=dzId
table.remove(dzList,rand)
end

self.entList={}
for i=1,self.dzCount do
local ent=baoLingShuController.fightStage:getEntity(stageID+i)
self.entList[#self.entList+1]=ent
ent:setColor(Color.New(0,0,0,0))
end
local lib_id=qiYuanShuModel:getQiYuanShuId()
local _config=qiYuanShuModel:getQiYuanShu_rewardShow(lib_id)
UIManager:showWindow('UIBaoLingShuMainHUD',{entList=self.entList,config=_config,dzCount=self.dzCount,showDzIdList=self.showDzIdList})
end

function UIQiYuanShuWin:dzChangeModelByIndex(index,isShowDaZuo)
local ent=self.entList[index]
if not ent then
return
end
if isShowDaZuo then
ent:setColor(Color.New(0,0,0,0))
else

ent:setColor(Color.New(1,1,1,0))
end
end

function UIQiYuanShuWin:dzMove()
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

function UIQiYuanShuWin:loopMove(ent,pos,index,offsetX)
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


function UIQiYuanShuWin:runQiFuBehavior(qifuCnt)
self:stopOverTimer()
self:stopMoveTimer()
self:stopShowJumpBehaviorTimer()
if self.dzCount==0 then
UIManager.error('没有弟子可祈愿')
return
end
self:dzChangeModelByIndex(1,false)

for i=1,self.dzCount do
local ent=self.entList[i]
ent:stopMoveTo()
ent.baolingShuHUD:showQiPao(false)
ent.baolingShuHUD:setDzModelActive(false)

end
local firstFlag=self.data and self.data.firstFlag or nil
local showJumpBtn=true
if firstFlag and firstFlag==0 then
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
qiYuanShuController:req_qiyuan(qifuCnt)


self:stopAudioSound()
if qifuCnt==1 then

self.audioHandleId=AudioManager.playAudio(518)
else

self.audioHandleId=AudioManager.playAudio(455)
end
end


function UIQiYuanShuWin:overQiFuExpression()
self:stopShowJumpBehaviorTimer()
self.root:setActive(true)
self.jumpBehavior:setActive(false)
UIManager:showWindow('UITopMoneyWin')
UIManager:invokeUIMethod("UIForeGroundThreeWin","setRootActive",true)
end

function UIQiYuanShuWin:fadeShowDZ()
self:dzChangeModelByIndex(1,true)
for i=1,self.dzCount do
local ent=self.entList[i]
ent:moveTo(originPos[i],false,0,1,nil)


ent.baolingShuHUD:setDzModelActive(true)
ent.baolingShuHUD:fadeInDzModel()
ent:runAnimator(0,1)
end
self.ovetTimer=self:delayDo(1,function(...)
for i=1,self.dzCount do
local ent=self.entList[i]
ent.baolingShuHUD:showQiPao(true)
end

end)
end

function UIQiYuanShuWin:stopMoveTimer()
for i=1,self.dzCount do
if timerList and timerList[i]then
self:stopTimerByID(timerList[i])
timerList[i]=nil
end
end
end

function UIQiYuanShuWin:stopOverTimer()
if self.ovetTimer then
self:stopTimerByID(self.ovetTimer)
self.ovetTimer=nil
end
end

function UIQiYuanShuWin:stopShowJumpBehaviorTimer()
if self.delayShowJumpBehaviorTimer then
self:stopTimerByID(self.delayShowJumpBehaviorTimer)
self.delayShowJumpBehaviorTimer=nil
end
end

function UIQiYuanShuWin:checkQiFuNum(qifuCnt,isWarning)
local numLimit=self.config.numLimit
local curnum=self.data and self.data.todayNum or 0
if curnum>=numLimit then
if isWarning then
UIManager.error('今日祈愿总次数已达上限')
end
return false
elseif curnum+qifuCnt>numLimit then
if isWarning then
UIManager.error(FMT.fmt('剩余祈愿总次数不足{0}次',qifuCnt))
end
return false
end
return true
end

function UIQiYuanShuWin:setOpenTipsTimer()
self:clearOpenTipsTimer()
local func=function()

local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=sTime and sTime-nowTime or 0
if lerp>0 then

local day=math.ceil(lerp/86400)
if day<=1 then

self.openTimeTipsLayout:setActive(false)
self.tomorrowOpenTips:setActive(true)
else

self.openTimeTipsText:setText(day)
self.openTimeTipsLayout:setActive(true)
self.tomorrowOpenTips:setActive(false)
end
else
return self:clearOpenTipsTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end

function UIQiYuanShuWin:clearOpenTipsTimer()
if self.openTipsTimer then
self:stopTimerByID(self.openTipsTimer)
self.openTipsTimer=nil
end
end

function UIQiYuanShuWin:setRemainingTipsTimer()
self:clearRemainingTipsTimer()
local func=function()

local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=eTime and eTime-nowTime or 0
if lerp>0 then

self.remainingTimeTipsText:setText(FMT.fmt("剩余时间：<color=#fd8950>{0}</color>",timeHelper.format_time_stamp11(lerp,true)))
else
self.remainingTimeTipsText:setText("本期祈愿未开启")
return self:clearRemainingTipsTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end

function UIQiYuanShuWin:clearRemainingTipsTimer()
if self.openTipsTimer then
self:stopTimerByID(self.openTipsTimer)
self.openTipsTimer=nil
end
end

function UIQiYuanShuWin:stopBigRewardModelAllLoadTimer()
for index,timer in pairs(self.bigRewardModelLoadTimer)do
self:stopTimerByID(self.bigRewardModelLoadTimer[index])
self.bigRewardModelLoadTimer[index]=nil
end
end

function UIQiYuanShuWin:stopBigRewardModelLoadTimer(index)
if self.bigRewardModelLoadTimer[index]then
self:stopTimerByID(self.bigRewardModelLoadTimer[index])
self.bigRewardModelLoadTimer[index]=nil
end
end




function UIQiYuanShuWin:onJumpBehavior()
baoLingShuController.fightStage:resetCamera()
local ent=self.entList[1]
ent:stopBehavior()

self:stopAudioSound()
UIManager:callWindowFunc('UIBaoLingShuMainHUD','jumpToOverShowReward')
end



function UIQiYuanShuWin:onQifuBtnOne()
local wishGbId=qiYuanShuModel:getQiYuanShuWishGbId()
local hasWishGbId=wishGbId~=nil and wishGbId~=0
if not hasWishGbId then
local showdata=
{
type='UIDialouge',
title='提示',
content="祈愿树当前没有选择心愿古宝，需前往选择",
oktext='立即前往',
allowclickBG=true,
okcallback=function(...)
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if not isInQiYuanNow then
return
end
UIFullBaoLingShuControl:showQiYuanShuPickUpWindow({openTabType=FULL_TAB_TYPE.eQYS_XingYuanGuBao})
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
return
end

local qifuCnt=1
if not self:checkQiFuNum(qifuCnt,true)then
return
end
local freenum=qiYuanShuModel:get_qiyuanshu_free_num()
local free=freenum>0
local cost=self.config.useItem
local itemid=cost[1]
local itemCnt=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local qifuCntLerp=haveItem-itemCnt
local moneyType=cost[3]
if free or qifuCntLerp>=0 then

self:startItemQifuAnimation(qifuCnt)
elseif moneyType~=nil then

qifuCntLerp=-qifuCntLerp

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
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end



function UIQiYuanShuWin:onQifuBtnTen()
local wishGbId=qiYuanShuModel:getQiYuanShuWishGbId()
local hasWishGbId=wishGbId~=nil and wishGbId~=0
if not hasWishGbId then
local showdata=
{
type='UIDialouge',
title='提示',
content="祈愿树当前没有选择心愿古宝，需前往选择",
oktext='立即前往',
allowclickBG=true,
okcallback=function(...)
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if not isInQiYuanNow then
return
end
UIFullBaoLingShuControl:showQiYuanShuPickUpWindow({openTabType=FULL_TAB_TYPE.eQYS_XingYuanGuBao})
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
return
end

local qifuCnt=10
if not self:checkQiFuNum(qifuCnt,true)then
return
end
local cost=self.config.useItem
local itemid=cost[1]
local itemCnt=cost[2]*qifuCnt
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local qifuCntLerp=haveItem-itemCnt
local moneyType=cost[3]
if qifuCntLerp>=0 then

self:startItemQifuAnimation(qifuCnt)
elseif moneyType~=nil then

qifuCntLerp=-qifuCntLerp

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
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemid)))
gainControl:showGainWin(itemid)
end
end



function UIQiYuanShuWin:onCloseBtn()
UIFullBaoLingShuControl:closeUI(true,true)
end



function UIQiYuanShuWin:onTipsBtn()


oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.blsrewards,{cjType=1,showType=2})
end



function UIQiYuanShuWin:onPickShopBtn()

UIFullBaoLingShuControl:showQiYuanShuPickUpWindow()
end



function UIQiYuanShuWin:onPickUpShowLBtn()
end



function UIQiYuanShuWin:onPickUpShowRBtn()
end



function UIQiYuanShuWin:onPickUpGBClick()
end



function UIQiYuanShuWin:onChangePickUpBtn()
end


function UIQiYuanShuWin:onWishChangeMask()

UIFullBaoLingShuControl:showQiYuanShuPickUpWindow({openTabType=FULL_TAB_TYPE.eQYS_XingYuanGuBao})
end


function UIQiYuanShuWin:onWishChangeBtn()

UIFullBaoLingShuControl:showQiYuanShuPickUpWindow({openTabType=FULL_TAB_TYPE.eQYS_XingYuanGuBao})
end


function UIQiYuanShuWin:startItemQifuAnimation(qifuCnt)
local checkPass=qiYuanShuModel:getQYSPassAniState()
if checkPass then
qiYuanShuController:req_qiyuan(qifuCnt)
else
self:runQiFuBehavior(qifuCnt)
end
end

function UIQiYuanShuWin:reqMoneyQifu(cost,qifuCnt,qifuCntLerp)

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
contentStr=FMT.fmt('是否使用<color=#7d3b17ff>{0}</color>个{1}，并花费<color=#7d3b17ff>{2}</color>{3}购买{4}{5}\n（赠送<color=#7d3b17ff>祈愿{6}次</color>）',
hasBi,biName,itemCnt,costName,songCnt,songName,qifuCntLerp)
else
contentStr=FMT.fmt('是否花费<color=#7d3b17ff>{0}</color>{1}购买{2}{3}\n（赠送<color=#7d3b17ff>祈愿{4}次</color>）',
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

function UIQiYuanShuWin:startMoneyQifuAnimation(itemid,need,qifuCnt)
local callback=function()
local checkPass=qiYuanShuModel:getQYSPassAniState()
if checkPass then
qiYuanShuController:req_qiyuan(qifuCnt)
else
self:runQiFuBehavior(qifuCnt)
end
end

moneySystem:useMoney(itemid,need,callback,WARNING_TYPE.eWarning)
end

function UIQiYuanShuWin:stopAudioSound()
if self.audioHandleId then
AudioManager.stopAudioById(self.audioHandleId)
self.audioHandleId=nil
end
end

function UIQiYuanShuWin:stopAudioSound_bg()
if self.audioHandleId_bg then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.audioHandleId_bg,fadeTime,false)
self.audioHandleId_bg=nil
end
end

function UIQiYuanShuWin.onMoneyChange(moneyType,lastVal,val)
local cost=_this.config.useItem
local costMoneyType=cost[3]
if moneyType==costMoneyType then
_this:flushCost()
end
end

function UIQiYuanShuWin.onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local cost=_this.config.useItem
local costItemId=cost[1]
if itemid==costItemId then
_this:flushCost()
end
end

function UIQiYuanShuWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIQiYuanShuWin:onChangePassAni()
self.checkPass=not self.checkPass
qiYuanShuModel:changeQYSPassAniState(self.checkPass)
end
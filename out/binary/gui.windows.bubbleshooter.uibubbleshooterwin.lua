







def_class("UIBubbleShooterWin",UIWindowBase)









function UIBubbleShooterWin:bindComponents()

self.ballRoot=UIObject.get(self,0)
self.bulletNumTxt=UIText.get(self,1)
self.bulletObj=UIObject.get(self,2)
self.buttleStandby=UIImage.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.deadlineObj=UIObject.get(self,5)
self.levelTxt=UIText.get(self,6)
self.maskRoot=UIObject.get(self,7)
self.ruletBtn=UIButton.get(self,8)
self.scorelTxt=UIText.get(self,9)
self.shooterObj=UIObject.get(self,10)
self.titleTxt=UIText.get(self,11)
self.touchBG=UIObject.get(self,12)
self.itemGrids=UIObject.get(self,13)
self.exDeadEffect=UIObject.get(self,14)
self.scoreArea=UIObject.get(self,15)
self.lineItem_1=UIObject.get(self,16)
self.lineItem_2=UIObject.get(self,17)
self.lineItem_3=UIObject.get(self,18)
self.lineItem_4=UIObject.get(self,19)
self.lineItem_5=UIObject.get(self,20)
self.lineItem_6=UIObject.get(self,21)
self.lineItem_7=UIObject.get(self,22)
self.lineRoot=UIObject.get(self,23)
self.shooterModel=UIObject.get(self,24)
self.xiaorenModel1=UIObject.get(self,25)
self.xiaorenModel2=UIObject.get(self,26)
self.bulletAnimRoot=UIObject.get(self,27)
self.bulletCostIcon=UIImage.get(self,28)
self.addCostBtn=UIButton.get(self,29)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ruletBtn:setButtonClick(function()self:onRuletBtn()end)

self.addCostBtn:setButtonClick(function()self:onAddCostBtn()end)
self.lineItem={
self.lineItem_1,
self.lineItem_2,
self.lineItem_3,
self.lineItem_4,
self.lineItem_5,
self.lineItem_6,
self.lineItem_7,
}


self.sprite_image_wuxingbutianwanfa_gj1=0
self.sprite_image_wuxingbutianwanfa_gj2=1
self.sprite_image_wuxingbutianwanfa_gj3=2
self.sprite_image_wuxingbutianwanfa_gj4=3
self.sprite_image_wuxingbutianwanfa_gj5=4
self.sprite_image_wuxingbutianwanfa_gj6=5
self.sprite_image_wuxingbutianwanfa_gj7=6

end


function UIBubbleShooterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ballRoot);self.ballRoot=nil;
_UIObject_release(self.bulletNumTxt);self.bulletNumTxt=nil;
_UIObject_release(self.bulletObj);self.bulletObj=nil;
_UIObject_release(self.buttleStandby);self.buttleStandby=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.deadlineObj);self.deadlineObj=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.maskRoot);self.maskRoot=nil;
_UIObject_release(self.ruletBtn);self.ruletBtn=nil;
_UIObject_release(self.scorelTxt);self.scorelTxt=nil;
_UIObject_release(self.shooterObj);self.shooterObj=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.touchBG);self.touchBG=nil;
_UIObject_release(self.itemGrids);self.itemGrids=nil;
_UIObject_release(self.exDeadEffect);self.exDeadEffect=nil;
_UIObject_release(self.scoreArea);self.scoreArea=nil;
_UIObject_release(self.lineItem_1);self.lineItem_1=nil;
_UIObject_release(self.lineItem_2);self.lineItem_2=nil;
_UIObject_release(self.lineItem_3);self.lineItem_3=nil;
_UIObject_release(self.lineItem_4);self.lineItem_4=nil;
_UIObject_release(self.lineItem_5);self.lineItem_5=nil;
_UIObject_release(self.lineItem_6);self.lineItem_6=nil;
_UIObject_release(self.lineItem_7);self.lineItem_7=nil;
_UIObject_release(self.lineRoot);self.lineRoot=nil;
_UIObject_release(self.shooterModel);self.shooterModel=nil;
_UIObject_release(self.xiaorenModel1);self.xiaorenModel1=nil;
_UIObject_release(self.xiaorenModel2);self.xiaorenModel2=nil;
_UIObject_release(self.bulletAnimRoot);self.bulletAnimRoot=nil;
_UIObject_release(self.bulletCostIcon);self.bulletCostIcon=nil;
_UIObject_release(self.addCostBtn);self.addCostBtn=nil;
self.lineItem=nil;
end


















local _this=nil
local ballSpeed=10
local lineColorImgList={
[bbBallColor.eYellow]="image_wuxingbutianwanfa_gj1",
[bbBallColor.eGreen]="image_wuxingbutianwanfa_gj2",
[bbBallColor.eBlue]="image_wuxingbutianwanfa_gj3",
[bbBallColor.eRed]="image_wuxingbutianwanfa_gj4",
[bbBallColor.eGary]="image_wuxingbutianwanfa_gj5",
[bbBallColor.eFunc1]="image_wuxingbutianwanfa_gj7",
[bbBallColor.eFunc2]="image_wuxingbutianwanfa_gj6",
}
local lineColorIndexList={
[bbBallColor.eYellow]=0,
[bbBallColor.eGreen]=1,
[bbBallColor.eBlue]=2,
[bbBallColor.eRed]=3,
[bbBallColor.eGary]=4,
[bbBallColor.eFunc1]=6,
[bbBallColor.eFunc2]=5,
}

local _maxLineItem=7
local _maxShowRowRange=13


function UIBubbleShooterWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self.ballFactory=require("lua.gameSys.bubbleShooter.ballGame.ballFactory")
self.ballRootWidget=self.ballRoot:getWidgetBase()

local gameObj=self.buttleStandby:getGameObject()
local component=gameObj:GetComponent("CSGUILuaFunction")
if component then
CS.BindFunction(component,self)
end

local gameObj2=self.bulletAnimRoot:getGameObject()
local component2=gameObj2:GetComponent("CSGUILuaFunction")
if component2 then
CS.BindFunction(component2,self)
end
end


function UIBubbleShooterWin:__delete()
cameraControl.setCameraActive(true)
local isNeedReset=not self.isNormalMode
_this=nil
self:unbindComponents()
self:clearTable()
self.ballFactory=nil
if initProControl.isDone()then
bubbleShooterController:sendCloseGameWin(self.gameid,isNeedReset)
if isNeedReset then
bubbleShooterModel:removeLevelData(self.gameid)
end
end
end


function UIBubbleShooterWin:onHide()
cameraControl.setCameraActive(true)
end

function UIBubbleShooterWin:clearTable()
self.ballFactory.releaseTable()
bubbleShooterController:removeAllEntitys()
clear_bbBallWidgetPool()
end

function UIBubbleShooterWin.on_money_changed(mType,oldValue,newValue)
if _this==nil then return end
if _this.changeMoneyLookup[mType]==true then
_this:refreshAllGoodItems()
_this:refreshBulletNum()
end
end




function UIBubbleShooterWin:onShow(argtable,afterOnloaded)
if not afterOnloaded then
self:clearTable()
end

cameraControl.setCameraActive(false)
self.gameid=argtable.id or'test'
local data=bubbleShooterModel:getLevelData(self.gameid)
local basecfg=bubbleShooterModel:getBaseConfig()
local cfg=cfgHelper.get2(cfg_bubbleshooterlevelconfig_get,data.groupid,data.level)
self.ballT=self.ballFactory.newTable(basecfg,cfg,data)
self.physics=self.ballFactory.physics
self.sub_actcfg=activitiesModel:getSubActivityConfig(data.sub_act_type,data.sub_act_id)
self.sub_actInfo=activitiesModel:getSubActInfo(data.act_id,data.sub_act_type,data.sub_act_id)
self.curSelectIndex=nil
self.changeMoneyLookup=self.sub_actInfo:getChangeMoneyLookup()
self.lastSelectBalls={}
self:initAddScoreShow()
self:refreshInfo()
self:initShooter()
self:initBulletObj()
self:initStandbyBullet()
self:initTableBalls()
end

function UIBubbleShooterWin:refreshInfo()
local data=bubbleShooterModel:getLevelData(self.gameid)
self.isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)

local sub_actcfg=activitiesModel:getSubActivityConfig(data.sub_act_type,data.sub_act_id)
local title_str=self.sub_actcfg.sub_name or'未命名'
self.titleTxt:setText(title_str)

local lvstr
if self.isNormalMode then
lvstr=FMT.fmt('第{0}关',data.level)
else
lvstr="无尽深渊"
end
self.levelTxt:setText(lvstr)

self:refreshScore()
self:initGoodItems()
end

function UIBubbleShooterWin:refreshScore(add)
local score
local str
local data=bubbleShooterModel:getLevelData(self.gameid)
local isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)
if isNormalMode then
score=cfgHelper.get3(cfg_bubbleshooterlevelconfig_get,data.groupid,data.level,'score')
str=FMT.fmt('通关积分:{0}',score)
else
if add==nil then
score=data.score
else
if not self.score then
self.score=0
end
score=self.score+add
end
str=FMT.fmt('积分:{0}',score)
end

self.score=score
self.scorelTxt:setText(str)
end

function UIBubbleShooterWin:refreshAllGoodItems()
local n=#self.goodlist
for i=1,n do
self:refreshItemState(nil,i)
end
end

function UIBubbleShooterWin:initGoodItems()
self.goodlist=self.sub_actInfo:getGoodList()
local grids=self.itemGrids:getChildCommonLayoutGroupWidgetList()
for index=1,grids.Count do
local widget=grids[index-1]
local data=self.goodlist[index]
if data then
widget:SetChildActive(-1,true)
local moneyType=data[2]

widget:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onGoodItemClick(index)
end)





self:refreshItemState(widget,index)

self:refreshItemSelect(widget,index,index==self.curSelectIndex)
else
widget:SetChildActive(-1,false)
end

end
end

function UIBubbleShooterWin:refreshItemState(item,index)
if item==nil then

item=self.itemGrids:getChildCommonLayoutGroupWidgetItem(index-1)
end
local d=self.goodlist[index]
local moneyType=d[2]
local num=moneyModel.getMoney(moneyType)
local has=num>0
item:SetChildActive(0,not has)
item:SetChildActive(3,has)
if has then
local str=FMT.fmt('拥有:{0}',num)
item:SetChildText(3,str)
else
local cost=d[3]
local icon=moneyModel.getIconNameEx(cost[1])
item:SetChildCSImageIcon(1,icon,false)
item:SetChildText(2,tostring(cost[2]))
end
end

function UIBubbleShooterWin:refreshItemSelect(item,index,isSelect)
if item==nil then

item=self.itemGrids:getChildCommonLayoutGroupWidgetItem(index-1)
end


local d=self.goodlist[index]
local idleEffectId
local color=d[1]
if color==bbBallColor.eFunc1 then
idleEffectId=60025
elseif color==bbBallColor.eFunc2 then
idleEffectId=60027
end
if idleEffectId and isSelect then
item:SetChildShowEffect(4,idleEffectId,true)
else
item:SetChildShowEffect(4,0,false)
end
end

function UIBubbleShooterWin:checkUseGood(index)
local d=self.goodlist[index]
local buyItemID=d[2]
local hasnum=itemsModel.getCount(buyItemID)
if hasnum<=0 then
local cost=d[3]
local costItemID=cost[1]
local costNum=cost[2]
local hasnum2=itemsModel.getCount(costItemID)
local maxBuyNum=math.floor(hasnum2/costNum)
if maxBuyNum>0 then
local refresh=function(num)
local itemNum=num*costNum
local colorStr=hasnum2>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costname=itemsModel.getName(costItemID)
local costStr=FMT.fmt("quad-icon={0}-quad<color=#{1}>{2}x{3}</color>",iconStr,colorStr,costname,itemNum)
iconStr=iconHelper.getIconName(buyItemID)
local buyname=itemsModel.getName(buyItemID)
local buyStr=FMT.fmt("quad-icon={0}-quad【{1}】x{2}",iconStr,buyname,num)
local contentStr=FMT.fmt('是否使用{0}兑换{1}？',costStr,buyStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=maxBuyNum,
oktext='确认',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
bubbleShooterController:reqExchange(buyItemID,num,_this.gameid)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
self:openBuyBallWin()
end
return false
end
return true
end

function UIBubbleShooterWin:onGoodItemClick(index)
if self.isShooting then return end

if self.curSelectIndex==index then
self.curSelectIndex=nil
self:refreshItemSelect(nil,index,false)
else
if not self:checkUseGood(index)then
return
end
if self.curSelectIndex~=nil then
self:refreshItemSelect(nil,self.curSelectIndex,false)
end
self:refreshItemSelect(nil,index,true)
self.curSelectIndex=index
end
self:initBulletObj()
end

function UIBubbleShooterWin:openBuyBallWin()
local costItemID=self.sub_actInfo.ballMoneyType
local costname=itemsModel.getName(costItemID)
local contentStr=FMT.fmt('当前可使用【{0}】已不足，是否购买？',costname)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
bubbleShooterController:openBuyBallWin(_this.gameid)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end

function UIBubbleShooterWin:onCloseBtn()
local contentStr
local show_data
local data=bubbleShooterModel:getLevelData(self.gameid)
local isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)
if not isNormalMode then
local str='是否保存当前进度，结算积分，退出无尽深渊？'
show_data={
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
_this:closeSelf()
end
}
else
local str='是否保存当前关卡进度，并退出当前关卡？'
show_data={
type='UIDialouge',
title='提示',
content=str,
oktext='保存退出',
canceltext='重新开始',
showclosebtn=true,
okcallback=function()
if _this==nil then return end
_this:closeSelf()
end,
cancelcallback=function()
if _this==nil then return end





_this:restartGame()
end,
}
end
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end

function UIBubbleShooterWin:onRuletBtn()







local args={
ruleGroupID=ruleTipsImageGroup.eWuXingBuTianGame,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIBubbleShooterWin:onAddCostBtn()
local costItemID=self.sub_actInfo.ballMoneyType
gainControl:showGainWin(costItemID)
end

function UIBubbleShooterWin:restartGame()
local data=bubbleShooterModel:getLevelData(self.gameid)
data.isExpired=true
self.isShooting=nil
bubbleShooterController:sendCloseGameWin(_this.gameid,true)
bubbleShooterController:checkOpenGameWin(_this.sub_actInfo)
end



function UIBubbleShooterWin:initShooter()
self:refreshBulletNum()
self:refreshDeadLine(true)
local beginEvent=function(idx,pos)
if _this==nil then return end
_this:onBeginDrag(Vector2(pos.x,pos.y))
end
local dragEvent=function(idx,pos)
if _this==nil then return end
_this:onDrag(Vector2(pos.x,pos.y))
end
local endEvent=function(idx,pos)
if _this==nil then return end
_this:onEndDrag(Vector2(pos.x,pos.y))
end
self.touchBG:initDragItem(0,beginEvent,dragEvent,endEvent)
local ballT=self.ballT
local hh=ballT.halfHeight
local hw=ballT:calculateTableHalfWidth()

self.maskRoot:setChildSizeDelta(hw+hw,hh+hh)





self.shootData={}

self:resetBulletObjPos(math.rad(90))


self.shooterModel:setChildSpineAnimation(eAnimationID.stand,1)
self.xiaorenModel1:setChildUIModelShowTarget(6389,1,{},eAnimationID.stand)
self.xiaorenModel2:setChildUIModelShowTarget(6390,1,{},eAnimationID.stand)
end

function UIBubbleShooterWin:refreshBulletNum()
local num=self.sub_actInfo:getBallNum()
self.bulletNumTxt:setText(tostring(num))
end

function UIBubbleShooterWin:refreshDeadLine(isInit)
local ballT=self.ballT
local showRow=ballT:calculateShowRow()
local backLine=ballT.sCfg.backLine
local isshow=showRow>=backLine-1
self.deadlineObj:setActive(isshow)
if isInit==true then
local y=ballT:calculateRowLinePosY(backLine)
self.deadlineObj:setChildAnchoredPos(0,y)
end
end

function UIBubbleShooterWin:onBeginDrag(pos)
if self.isShooting then return end
self.isDraging=true
self:calculationShooterAngle(pos)
end

function UIBubbleShooterWin:onDrag(pos)
if self.isShooting then return end
if not self.isDraging then return end
self:calculationShooterAngle(pos)
end

function UIBubbleShooterWin:onEndDrag(pos)
if self.isShooting then return end
if not self.isDraging then return end
self.selectBalls=nil
self.selectBallTypeColor=nil
self:refreshSelectBalls()
self.isDraging=false
self.lineRoot:setActive(false)
local shootData=self.shootData
if self.ballT:isValidAngle(shootData[2])then
local num=self.sub_actInfo:getBallNum()
if num>0 or self.curSelectIndex~=nil then
self:moveBullet()
else
self:openBuyBallWin()
end
end
if not self.isShooting then
self:resetBulletObjPos(math.rad(90))
end
end

function UIBubbleShooterWin:calculationShooterAngle(pos)
local ballT=self.ballT
local clickPos=self.maskRoot:getChildUIScreenPos2Local(pos)
local angle,angle_deg=ballT:getShootAngle(clickPos.x,clickPos.y)
self:resetBulletObjPos(angle)

local showLine=false
if ballT:isValidAngle(angle_deg)then
local poslist=self.physics.raycastLine(angle,self.ballT)
if poslist~=nil then
local color
if self.curSelectIndex==nil then
color=self.ballT:getShootColor(1)
else
local d=self.goodlist[self.curSelectIndex]
color=d[1]
end
local abname,icon=bubbleShooterModel:getBallIcon(color)

showLine=true
local count=#poslist-1
for idx=1,#self.lineItem do
local item=self.lineItem[idx]
if idx<=count then






local spriteIdx=lineColorIndexList[color]
self.winlua:SetChildSpriteByPrefabIndex(item:getID(),spriteIdx,false)

item:setActive(true)
local pos=poslist[idx]
local pos2=poslist[idx+1]
item:setChildAnchoredPos(pos[1],pos[2])
local angle_deg_=math.deg(pos[3])-90
item:setRotation(0,0,angle_deg_)
local dis=mathHelper.distanceEx(pos2[1],pos2[2],pos[1],pos[2])
item:setChildSizeDelta(12,dis)
else
item:setActive(false)
end
end

self.lineRoot:setActive(true)

if self.curSelectIndex then
local _,ballRow,ballCol,ball=self.physics.raycastPath(angle,ballT)
local specialParam=self.sub_actcfg.specialParam
self.selectBalls=self.ballT:calculateSelectBalls(ballRow,ballCol,color,specialParam)
self.selectBallTypeColor=color
else
self.selectBalls=nil
self.selectBallTypeColor=nil
end
self:refreshSelectBalls()
end
end
if showLine==false then
self.lineRoot:setActive(false)
end
local shootData=self.shootData
shootData[1]=angle
shootData[2]=angle_deg
end

function UIBubbleShooterWin:resetBulletObjPos(angle)
local ballT=self.ballT



local x=ballT.shooterPosX
local y=ballT.shooterPosY
self.bulletObj:setChildCanvasGroupAlpha(1)

self.bulletObj:setChildAnchoredPos(x,y)
end

function UIBubbleShooterWin:initBulletObj()
local widget=self.bulletObj:getWidgetBase()
local color
if self.curSelectIndex==nil then
color=self.ballT:getShootColor(1)
else
local d=self.goodlist[self.curSelectIndex]
color=d[1]
end
local abname,icon=bubbleShooterModel:getBallIcon(color)
widget:SetChildCSImageSprite(0,abname,icon)

local idleEffectId
if color==bbBallColor.eFunc1 then
idleEffectId=60025
elseif color==bbBallColor.eFunc2 then
idleEffectId=60027
end
if idleEffectId then
widget:SetChildShowEffect(3,idleEffectId,true)
else
widget:SetChildShowEffect(3,0,false)
end
end

function UIBubbleShooterWin:initStandbyBullet()
local color=self.ballT:getShootColor(2)
local abname,icon=bubbleShooterModel:getBallIcon(color)
self.buttleStandby:setSprite(abname,icon)
end

function UIBubbleShooterWin:moveBullet()
local ballT=self.ballT
local shootData=self.shootData
local poslist,dropRow,dropCol,ball=self.physics.raycastPath(shootData[1],ballT)
if poslist~=nil then
self.isShooting=true
self.moveData={poslist,dropRow,dropCol,ball}
self.moveIndex=0

self.shootargs=nil
local color
if self.curSelectIndex==nil then
color=0
else
local d=self.goodlist[self.curSelectIndex]
color=d[1]
end
bubbleShooterController:reqShoot(shootData[1],color,ballT.gameid)


self.shooterModel:setChildSpineAnimation(eAnimationID.touch,1)

self:doMoveBullet()

local widget=self.bulletObj:getWidgetBase()
widget:SetChildShowEffect(2,60028,true)
end
end

function UIBubbleShooterWin:doMoveBullet()
local idx=self.moveIndex+1
self.moveIndex=idx
local moveData=self.moveData
local poslist=moveData[1]
local c=#poslist
if idx<c then

local pos=poslist[idx]
local pos2=poslist[idx+1]
local dis=mathHelper.distance(pos[1],pos[2],pos2[1],pos2[2])
local t=dis/self.ballT.sCfg.ballSpeed
self.bulletObj:setChildAnchoredPos(pos[1],pos[2])
local func=function()
if _this==nil then return end
_this:doMoveBullet()
end
local tweener=self.bulletObj:setChildDOAnchorPos(Vector2(pos2[1],pos2[2]),t,func)
tweener:SetEase(DG.Tweening.Ease.Linear)
else


local x,y=self.ballT:getPosByRowCol(moveData[2],moveData[3])
local func=function()
if _this==nil then return end
_this:moveBulletEnd(true)
end
if x~=nil then
local tweener=self.bulletObj:setChildDOAnchorPos(Vector2(x,y),0.15,func)
tweener:SetEase(DG.Tweening.Ease.Linear)
else
func()
end

local ball=moveData[4]
if ball~=nil then

local angle=poslist[c-1][3]

end

end
end

function UIBubbleShooterWin:moveBulletEnd(needWait)







self:clearWaitingRecvTimer()
if self.curSelectIndex~=nil then
self:refreshItemSelect(nil,self.curSelectIndex,false)
self.curSelectIndex=nil
end
self.moveData=nil
self.moveIndex=nil

local widget=self.bulletObj:getWidgetBase()
widget:SetChildShowEffect(2,0,false)
local args=self.shootargs
if args~=nil then
local ballT=self.ballT
local delBalls=args.delBalls
if delBalls~=nil then
self:playDelBalls()
else

local ball=ballT:createBall(args.shootInfo,args.insertMoveRow)
ballT:initBallNeighborBall(ball)
ballT:refreshBallRoundNeighborBall(ball)
local createCB=function()
if _this==nil then return end
_this:delayDo(0.1,function()
if not _this.isPlayingNextStandByAnim then
_this.bulletObj:setChildCanvasGroupAlpha(0)
end
_this:playDropBalls()
end)
end
local row=ball.row
if row>self.maxShowRow then
ball.createCB=createCB
ball.ojbID=bubbleShooterController:addEntity(bubbleShooterEnityType.eBall,ball,self.ballRootWidget)
else
createCB()
end
end
else
self.isWaitingRecv=true
self.waitingRecvTimer=self:delayDo(3,function()
if self.isWaitingRecv then
UIManager.error("当前网络状态不佳")
end
end)










end
end

function UIBubbleShooterWin:nextStandby()


self:refreshDeadLine()

self:playNextStandbyAnim()

end

function UIBubbleShooterWin:playNextStandbyAnim()
self.isPlayingNextStandByAnim=true
self.buttleStandby:setChildAnimatorParameter("isSetNext","trigger","")





self.xiaorenModel1:setChildModelAnimationState(eAnimationID.touch,1)
self.bulletObj:setChildCanvasGroupAlpha(0)
local widget=self.bulletObj:getWidgetBase()
local color
if self.curSelectIndex==nil then
color=self.ballT:getShootColor(1)
else
local d=self.goodlist[self.curSelectIndex]
color=d[1]
end
local abname,icon=bubbleShooterModel:getBallIcon(color)
widget:SetChildCSImageSprite(0,abname,icon)
self.bulletAnimRoot:setChildAnimatorParameter("isHide","trigger","")
end

function UIBubbleShooterWin:finishStandbyAnim_setNext()
self.xiaorenModel2:setChildModelAnimationState(eAnimationID.touch,1)
self:resetBulletObjPos(math.rad(90))
self.bulletAnimRoot:setChildAnimatorParameter("isSetNew","trigger","")

local color=self.ballT:getShootColor(2)
local abname,icon=bubbleShooterModel:getBallIcon(color)
self.buttleStandby:setSprite(abname,icon)
self.buttleStandby:setChildAnimatorParameter("isEnter","trigger","")
end

function UIBubbleShooterWin:finishBallAnim_setNew()
self.isPlayingNextStandByAnim=nil
self.isShooting=nil
end

function UIBubbleShooterWin:clearWaitingRecvTimer()
if self.waitingRecvTimer then
self:stopTimerByID(self.waitingRecvTimer)
self.waitingRecvTimer=nil
end
end





function UIBubbleShooterWin:initTableBalls()
local ballT=self.ballT
local widget=self.ballRootWidget
self.selectBalls=nil
self.selectBallTypeColor=nil
local maxRow=ballT:calculateMaxRow3()
local maxShowRow=maxRow-_maxShowRowRange
for idx,ball in pairs(ballT.ballsLookup)do
local row=ball.row
if row>=maxShowRow then
ball.ojbID=bubbleShooterController:addEntity(bubbleShooterEnityType.eBall,ball,widget)
end
end
self.maxShowRow=maxShowRow
end

function UIBubbleShooterWin:checkTableBallsShow(shootArgs)
local ballT=self.ballT
local widget=self.ballRootWidget

local list={}
local delBalls=shootArgs.delBalls
local dropBalls=shootArgs.dropBalls
local secondDropBalls=shootArgs.secondDropBalls
local hideBallsLookup={}
if delBalls~=nil then
for _,idx in ipairs(delBalls)do
hideBallsLookup[idx]=true
end
end
if dropBalls~=nil then
for _,idx in ipairs(dropBalls)do
hideBallsLookup[idx]=true
end
end

if secondDropBalls~=nil then
for _,idx in ipairs(secondDropBalls)do
hideBallsLookup[idx]=true
end
end
local maxRow=0
for idx,ball in pairs(ballT.ballsLookup)do
if not hideBallsLookup[idx]then
list[#list+1]=ball
local row=ball.row
if row>maxRow then
maxRow=row
end
end
end
local count=#list
if count>1 then
table.sort(list,function(a,b)
return a.index<b.index
end)
end

local maxShowRow=maxRow-_maxShowRowRange
self.maxShowRow=maxShowRow
if count>0 then
for i=count,1,-1 do
local ball=list[i]
local row=ball.row
if row>=maxShowRow and not ball.ojbID then
ball.ojbID=bubbleShooterController:addEntity(bubbleShooterEnityType.eBall,ball,widget)
end
end
end
end

function UIBubbleShooterWin:playDelBalls(index)
local ballT=self.ballT
local args=self.shootargs
local delBalls=args.delBalls
local index,row,col,color=ballT:decomposeKey(args.shootInfo)
local time=0.8
local deadType=1
local exDeadEffectId
local exDeadEffectPos
local clearMaxPosY
local clearMaxPosX
local clearMinPosX
if color==bbBallColor.eFunc1 then
deadType=2
exDeadEffectId=60024
time=2
exDeadEffectPos=self.bulletObj:getChildAnchoredPosition()
elseif color==bbBallColor.eFunc2 then
deadType=3
exDeadEffectId=60026
time=1
for _,idx in ipairs(delBalls)do
local delBall=ballT:getBall(idx)
if delBall~=nil and delBall.ojbID~=nil then
local ent=bubbleShooterController:getEntity(delBall.ojbID)
if ent then
local delBallWidget=ent:getWidget()
if delBallWidget then
local pos=delBallWidget:GetChildAnchoredPosition(-1)
if not exDeadEffectPos then
exDeadEffectPos=pos
break
end
end
end
end
end
if exDeadEffectPos then
exDeadEffectPos.x=0
end
end
local widget=self.bulletObj:getWidgetBase()
if exDeadEffectId then
if exDeadEffectPos then
self.exDeadEffect:setChildAnchoredPosition(exDeadEffectPos)
self.exDeadEffect:setChildShowEffect(exDeadEffectId,true)
end
widget:SetChildShowEffect(1,0,false)
widget:SetChildShowEffect(3,0,false)
widget:SetChildCanvasGroupDOFade(0,0,0.25)
else
self.exDeadEffect:setChildShowEffect(0,false)
widget:SetChildShowEffect(1,60023,true)
widget:SetChildShowEffect(3,0,false)
widget:SetChildCanvasGroupAlpha(0,0)
end

for _,idx in ipairs(delBalls)do
if idx~=index then
local ball_=ballT:getBall(idx)
if ball_~=nil and ball_.ojbID~=nil then
local ent=bubbleShooterController:getEntity(ball_.ojbID)
if ent then
ent:playDead(time,deadType)
local ballWidget=ent:getWidget()
if ballWidget then
local pos=ballWidget:GetChildAnchoredPosition(-1)
if not clearMaxPosY or pos.y>clearMaxPosY then
clearMaxPosY=pos.y
end
if not clearMaxPosX or pos.x>clearMaxPosX then
clearMaxPosX=pos.x
end
if not clearMinPosX or pos.x<clearMinPosX then
clearMinPosX=pos.x
end
end
end
end
end
end

local score=bubbleShooterModel:calculateScore_del(delBalls)
local data=bubbleShooterModel:getLevelData(self.gameid)
local isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)
if not isNormalMode then

if clearMaxPosX and clearMinPosX and clearMaxPosY then
local scorePosX=(clearMaxPosX+clearMinPosX)/2
local scorePosY=clearMaxPosY<=750/2 and clearMaxPosY or 750/2
local scorePos={scorePosX,scorePosY}
self:addScoreShow(score,scorePos)
end
end
self:refreshScore(score)

local dropBalls=args.dropBalls
local hasDropBalls=dropBalls~=nil
local secondDropBalls=args.secondDropBalls
local hasSecondDropBalls=secondDropBalls~=nil

local waitRemoveList={}
for _,idx in ipairs(delBalls)do
if idx~=index then
local ball_=ballT:getBall(idx)
if ball_~=nil then
ballT:removeBall(idx)
table.insert(waitRemoveList,ball_)
end
end
end
if#waitRemoveList>0 then
for i,ball_ in ipairs(waitRemoveList)do
ballT:refreshBallRoundNeighborBall(ball_)
end
end
local hasMove=args.moveRow and args.moveRow~=ballT.moveRow or false

self:delayDo(time+0.1,function()
if not self.isPlayingNextStandByAnim then
self.bulletObj:setChildCanvasGroupAlpha(0)
end
widget:SetChildCanvasGroupAlpha(0,1)
if#waitRemoveList>0 then
for i,ball_ in ipairs(waitRemoveList)do
if ball_.ojbID~=nil then
bubbleShooterController:delEntityNow(ball_.ojbID)
ball_.ojbID=nil
end
end
end

if hasDropBalls then
self:refreshDeadLine()
elseif hasSecondDropBalls or hasMove then
self:playDropBalls()
end
end)

if hasDropBalls or(not hasSecondDropBalls and not hasMove)then
self:delayDo(time-0.5,function()
self:playDropBalls()
end)
end
end

function UIBubbleShooterWin:playDropBalls(isSecond)
local ballT=self.ballT
local args=self.shootargs
local dropBalls
if isSecond then
dropBalls=args.secondDropBalls
else
dropBalls=args.dropBalls
end
local clearMaxPosY
local clearMaxPosX
local clearMinPosX
local nextFunc=function()
if isSecond then
return self:playResult()
else
return self:checkPlaySecondDropBallsAndTryMoveTableBalls()
end
end

if dropBalls~=nil then
local animTime=1
local time=0.35
for _,idx in ipairs(dropBalls)do
local ball_=ballT:getBall(idx)
if ball_~=nil and ball_.ojbID~=nil then
local ent=bubbleShooterController:getEntity(ball_.ojbID)
if ent then
ent:playDead2(animTime)
local ballWidget=ent:getWidget()
if ballWidget then
local pos=ballWidget:GetChildAnchoredPosition(-1)
if not clearMaxPosY or pos.y>clearMaxPosY then
clearMaxPosY=pos.y
end
if not clearMaxPosX or pos.x>clearMaxPosX then
clearMaxPosX=pos.x
end
if not clearMinPosX or pos.x<clearMinPosX then
clearMinPosX=pos.x
end
end
end
end
end

local score=bubbleShooterModel:calculateScore_drop(dropBalls)
local data=bubbleShooterModel:getLevelData(self.gameid)
local isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)
if not isNormalMode then
local hasScorePos=clearMaxPosX and clearMinPosX and clearMaxPosY
if hasScorePos then


local scorePosX=(clearMaxPosX+clearMinPosX)/2
local scorePosY=clearMaxPosY<=750/2 and clearMaxPosY or 750/2
local scorePos={scorePosX,scorePosY}
self:addScoreShow(score,scorePos)
end
end
self:refreshScore(score)
local waitRemoveList={}
for _,idx in ipairs(dropBalls)do
local ball_=ballT:getBall(idx)
if ball_~=nil then
ballT:removeBall(idx)
table.insert(waitRemoveList,ball_)
end
end
if#waitRemoveList>0 then
for i,ball_ in ipairs(waitRemoveList)do
ballT:refreshBallRoundNeighborBall(ball_)
end
end
self:delayDo(animTime+0.1,function()
if#waitRemoveList>0 then
for i,ball_ in ipairs(waitRemoveList)do
if ball_.ojbID~=nil then
bubbleShooterController:delEntityNow(ball_.ojbID)
ball_.ojbID=nil
end
end
end
end)

return nextFunc()
else
return nextFunc()
end
end

function UIBubbleShooterWin:checkPlaySecondDropBallsAndTryMoveTableBalls()
local ballT=self.ballT
local args=self.shootargs
local secondDropBalls=args.secondDropBalls
if secondDropBalls~=nil then
self:moveTableBalls(true)
else
return self:playResult()
end
end

function UIBubbleShooterWin:playResult(isDontMove)
local args=self.shootargs
local result=args.result
if result~=0 then
local data=bubbleShooterModel:getLevelData(args.id)
local isNormalMode=bubbleShooterModel.isNormalMode(data.groupid,data.level)
notifySystem:postNotify(notifyConfig.onBubbleShooterResult,result)
if result==1 then
local score
if isNormalMode then
score=cfgHelper.get3(cfg_bubbleshooterlevelconfig_get,data.groupid,data.level,'score')
else
score=data.score
end

return self:showWindow("UIBubbleShooter_settlementWin",{result=result,parent=self,score=score})
else
if not isNormalMode then
UIManager.info(FMT.fmt('你失败了,无限模式下将获取积分{0}',data.score))
else

return self:showWindow("UIBubbleShooter_settlementWin",{result=result,parent=self})
end
end
self:closeSelf()
else
self:moveTableBalls()
end
end


function UIBubbleShooterWin:moveTableBalls(hasSecondDrop)
local ballT=self.ballT
local args=self.shootargs
local hasMove=ballT:changeMoveRow(args.moveRow)
local insertMoveRow=args.insertMoveRow
if not hasMove and insertMoveRow then
hasMove=true
end
if hasMove==true then
local time=0.35
local balls=ballT:getSortBalls()
local x,y,ent
for _,ball in ipairs(balls)do
x,y=ballT:getPosByRowCol(ball.row,ball.col)
ball:setPos(x,y)
if ball.ojbID~=nil then
ent=bubbleShooterController:getEntity(ball.ojbID)
if ent then
ent:playMove(x,y,time)
end
end
end
self:delayDo(time+0.1,function()
if hasSecondDrop then
return self:playDropBalls(true)
else
return self:nextStandby()
end
end)
else
if hasSecondDrop then
return self:playDropBalls(true)
else
return self:nextStandby()
end
end
end


function UIBubbleShooterWin:refreshSelectBalls()
local ballT=self.ballT
if self.lastSelectBalls and next(self.lastSelectBalls)then
for idx,_ in pairs(self.lastSelectBalls)do
local ball_=ballT:getBall(idx)
if ball_ then
if ball_~=nil and ball_.ojbID~=nil then
local ent=bubbleShooterController:getEntity(ball_.ojbID)
if ent then
local ballWidget=ent:getWidget()
if ballWidget then
ballWidget:SetChildActive(1,false)
ballWidget:SetChildActive(2,false)
end
end
end
end
self.lastSelectBalls[idx]=nil
end
end

if self.selectBalls then
for _,idx in ipairs(self.selectBalls)do
local ball_=ballT:getBall(idx)
if ball_ then
if ball_~=nil and ball_.ojbID~=nil then
local ent=bubbleShooterController:getEntity(ball_.ojbID)
if ent then
local ballWidget=ent:getWidget()
if ballWidget then
local showSelect1=self.selectBallTypeColor==bbBallColor.eFunc1
local showSelect2=self.selectBallTypeColor==bbBallColor.eFunc2
ballWidget:SetChildActive(1,showSelect1)
ballWidget:SetChildActive(2,showSelect2)
end
self.lastSelectBalls[idx]=true
end
end
end
end
end
end

function UIBubbleShooterWin:initAddScoreShow()
local maxScoreItemCount=10
self.scoreArea:setChildLayoutGroupCreateItems(maxScoreItemCount)
end


function UIBubbleShooterWin:addScoreShow(score,pos)
local scoreStr=tostring(score)

local scoreItemIndex=self:getScoreItemIndex()
self.nowSelectScoreItemIndex=scoreItemIndex
local item=self.scoreArea:getChildLayoutGroupGridItem(scoreItemIndex-1)
if item then
item:SetChildAnchoredPos(-1,pos[1],pos[2])
item:SetChildText(1,scoreStr)
item:SetChildActive(2,false)
self:delayDo(0.1,function()
if not _this then return end
item:SetChildActive(2,true)
end)
end
end

function UIBubbleShooterWin:getScoreItemIndex()
local nextIndex=self.nowSelectScoreItemIndex and self.nowSelectScoreItemIndex+1 or 1
if nextIndex>10 then
nextIndex=1
end

return nextIndex
end




function UIBubbleShooterWin:recv_shoot(args)

if args.id~=self.gameid then return end
local ballT=self.ballT
self.shootargs=args
ballT:initShootColor(args.waitBalls)


local newBalls=args.newBalls
if newBalls~=nil then
local newBallsList,insertRow,insertMoveRow=ballT:insertBalls(newBalls)
local delBalls=args.delBalls
if delBalls~=nil then
for i,idx in ipairs(delBalls)do
delBalls[i]=ballT:indexOffsetRow(idx,insertRow)
end
end
local dropBalls=args.dropBalls
if dropBalls~=nil then
for i,idx in ipairs(dropBalls)do
dropBalls[i]=ballT:indexOffsetRow(idx,insertRow)
end
end

self:checkTableBallsShow(args)









args.shootInfo=bubbleShooterModel:getKeyOffsetRow(args.shootInfo,insertRow)
args.insertMoveRow=insertMoveRow
else
self:checkTableBallsShow(args)
end

if self.isWaitingRecv then
self.isWaitingRecv=nil
return self:moveBulletEnd()
end
end


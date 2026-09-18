







def_class("UIHunYuanDanHuiWin",UIWindowBase)









function UIHunYuanDanHuiWin:bindComponents()

self.btnPanel=UIObject.get(self,0)
self.cansaiBtn=UIButton.get(self,1)
self.cansaiState=UIImage.get(self,2)
self.cansaiStateText=UIText.get(self,3)
self.cansaiTime=UIText.get(self,4)
self.cansaiTimeBg=UIObject.get(self,5)
self.chengjiuBtn=UIButton.get(self,6)
self.chengjiuReddot=UIObject.get(self,7)
self.chonzhiBtn=UIButton.get(self,8)
self.creater=UIGameobjectClone.new(self,9)
self.curType=UIText.get(self,10)
self.danyaoContent=UIObject.get(self,11)
self.danYaoItem=UIObject.get(self,12)
self.danyaoScroller=UIObject.get(self,13)
self.delBtn=UIButton.get(self,14)
self.delItemNumTxt=UIText.get(self,15)
self.delNumDi=UIObject.get(self,16)
self.delText=UIText.get(self,17)
self.effect=UIObject.get(self,18)
self.endGameBtn=UIButton.get(self,19)
self.fanhuiBtn=UIButton.get(self,20)
self.freeRewardBtn=UIButton.get(self,21)
self.gamePanel=UIObject.get(self,22)
self.grpContent=UIObject.get(self,23)
self.helpBtn=UIButton.get(self,24)
self.hitScore=UIObject.get(self,25)
self.huhuanBtn=UIButton.get(self,26)
self.huhuanItemNumTxt=UIText.get(self,27)
self.huhuanNumDi=UIObject.get(self,28)
self.huhuanText=UIText.get(self,29)
self.leftBtnList=UIObject.get(self,30)
self.mainPanel=UIObject.get(self,31)
self.mbg=UIObject.get(self,32)
self.moneyBtn=UIButton.get(self,33)
self.moneyRoot=UIObject.get(self,34)
self.myScore=UIText.get(self,35)
self.nextDanYaoItem=UIObject.get(self,36)
self.rankBtn=UIButton.get(self,37)
self.root=UIObject.get(self,38)
self.scoreRoot=UIObject.get(self,39)
self.scoreText=UIObject.get(self,40)
self.shengjieBtn=UIButton.get(self,41)
self.shengjieNumDi=UIObject.get(self,42)
self.shengjieText=UIText.get(self,43)
self.timeTxt=UIText.get(self,44)
self.timeTxt2=UIText.get(self,45)
self.upItemNumTxt=UIText.get(self,46)
self.useItemBtn=UIButton.get(self,47)
self.xunlianBtn=UIButton.get(self,48)
self.xunlianState=UIImage.get(self,49)
self.xunlianStateText=UIText.get(self,50)

self.cansaiBtn:setButtonClick(function()self:onCansaiBtn()end)

self.chengjiuBtn:setButtonClick(function()self:onChengjiuBtn()end)

self.chonzhiBtn:setButtonClick(function()self:onChonzhiBtn()end)

self.delBtn:setButtonClick(function()self:onDelBtn()end)

self.endGameBtn:setButtonClick(function()self:onEndGameBtn()end)

self.fanhuiBtn:setButtonClick(function()self:onFanhuiBtn()end)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.huhuanBtn:setButtonClick(function()self:onHuhuanBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.shengjieBtn:setButtonClick(function()self:onShengjieBtn()end)

self.useItemBtn:setButtonClick(function()self:onUseItemBtn()end)

self.xunlianBtn:setButtonClick(function()self:onXunlianBtn()end)



end


function UIHunYuanDanHuiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.cansaiBtn);self.cansaiBtn=nil;
_UIObject_release(self.cansaiState);self.cansaiState=nil;
_UIObject_release(self.cansaiStateText);self.cansaiStateText=nil;
_UIObject_release(self.cansaiTime);self.cansaiTime=nil;
_UIObject_release(self.cansaiTimeBg);self.cansaiTimeBg=nil;
_UIObject_release(self.chengjiuBtn);self.chengjiuBtn=nil;
_UIObject_release(self.chengjiuReddot);self.chengjiuReddot=nil;
_UIObject_release(self.chonzhiBtn);self.chonzhiBtn=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.curType);self.curType=nil;
_UIObject_release(self.danyaoContent);self.danyaoContent=nil;
_UIObject_release(self.danYaoItem);self.danYaoItem=nil;
_UIObject_release(self.danyaoScroller);self.danyaoScroller=nil;
_UIObject_release(self.delBtn);self.delBtn=nil;
_UIObject_release(self.delItemNumTxt);self.delItemNumTxt=nil;
_UIObject_release(self.delNumDi);self.delNumDi=nil;
_UIObject_release(self.delText);self.delText=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.endGameBtn);self.endGameBtn=nil;
_UIObject_release(self.fanhuiBtn);self.fanhuiBtn=nil;
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.gamePanel);self.gamePanel=nil;
_UIObject_release(self.grpContent);self.grpContent=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hitScore);self.hitScore=nil;
_UIObject_release(self.huhuanBtn);self.huhuanBtn=nil;
_UIObject_release(self.huhuanItemNumTxt);self.huhuanItemNumTxt=nil;
_UIObject_release(self.huhuanNumDi);self.huhuanNumDi=nil;
_UIObject_release(self.huhuanText);self.huhuanText=nil;
_UIObject_release(self.leftBtnList);self.leftBtnList=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.myScore);self.myScore=nil;
_UIObject_release(self.nextDanYaoItem);self.nextDanYaoItem=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scoreRoot);self.scoreRoot=nil;
_UIObject_release(self.scoreText);self.scoreText=nil;
_UIObject_release(self.shengjieBtn);self.shengjieBtn=nil;
_UIObject_release(self.shengjieNumDi);self.shengjieNumDi=nil;
_UIObject_release(self.shengjieText);self.shengjieText=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.timeTxt2);self.timeTxt2=nil;
_UIObject_release(self.upItemNumTxt);self.upItemNumTxt=nil;
_UIObject_release(self.useItemBtn);self.useItemBtn=nil;
_UIObject_release(self.xunlianBtn);self.xunlianBtn=nil;
_UIObject_release(self.xunlianState);self.xunlianState=nil;
_UIObject_release(self.xunlianStateText);self.xunlianStateText=nil;
end
















local _this
local _abname="ui/windows/activities/sub_hunyuandanhui/hunyuandanhui_atlas_pak.ab"
local _maxY=195




function UIHunYuanDanHuiWin:onLoaded(...)
self:bindComponents()
_this=self

self.creater:setRefreshAction(function(...)self:onFinishCreate(...)end)

self.winlua:SetChildUIDragEvent(self.danyaoScroller:getID(),0,self.beginDragCallback,self.endDragCallback,nil)

local _on_money_changed=function(mtype,last,curr)
if mtype==_this.sub_actcfg.money_type then
_this:freshMoney()
elseif _this.sub_actcfg.item_conf[mtype]then
_this:refreshItemNum()
end
end
self:addNotify(notifyConfig.on_money_changed,_on_money_changed)

self.m_cav=self:getChildCanvas(-1)

self.isEndGame=false
self.curModType=0
self.bodyList={}
self.bodyListIdxLookup={}
self.bodyTypeLookup={}
self.detailIdx=0
self.useItemType=nil
self.itemDanYaoIdList={}
self.delDanYaoList={}
self.loopTotleTime=0
self.scoreTextPool={}
self.hitScoreTextPool={}
self.scoreText:setActive(false)
self.hitScore:setActive(false)
end


function UIHunYuanDanHuiWin:__delete()
self:unbindComponents()
self:endAllReddotPunchRotation()
self.curModType=0
self.bodyList={}
self.bodyListIdxLookup={}
self.bodyTypeLookup={}
self.detailIdx=0
self.useItemType=nil
self.itemDanYaoIdList={}
self.delDanYaoList={}
self.scoreTextPool={}
self.hitScoreTextPool={}
_this=nil
end





function UIHunYuanDanHuiWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self:freshMoney()
self:initGameState(true)
self:setEndTimeTips()
end

function UIHunYuanDanHuiWin:refreshFreeReward()


local isGot=self.info:checkFreeRewardsIsGot()


self.freeRewardBtn:setActive(not isGot)
end


function UIHunYuanDanHuiWin:refreshBgModel()
if self.oldModelType==self.curModType then
return
end
self.oldModelType=self.curModType

if self.curModType==0 then
self.mbg:setChildUIModelShowTarget(6448,1,nil,eAnimationID.stand)
else
self.root:setChildCanvasGroupAlpha(0)
self.creater:setActive(false)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6448,1,nil,3628)
self:delayDo(1,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
self:delayDo(1.5,function()
if not _this then return end
_this.creater:setActive(true)
end)
end
end

function UIHunYuanDanHuiWin:setEndTimeTips()
if not self.nTimer then
local etime=self.info.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
local earlyEndTime=self.sub_actcfg.earlyEndTime or 0
local check=dt<earlyEndTime
if check then
if not self.isInSettlementTime then
self.isInSettlementTime=true
if self.myData.mod_type==1 then
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_endGame",self.actID,self.subType,self.subid)
end
end
local time_str=timeHelper.format_time_stamp11(dt,true)
self.timeTxt:setText(FMT.fmt('积分已结算：{0}后活动结束',time_str))
self.timeTxt2:setText(FMT.fmt('积分已结算：{0}后活动结束',time_str))
if dt<0 then
self.time:setText('活动已结束')
self:stopTimerByID(self.nTimer)
self.nTimer=nil
end
else
local st=dt-earlyEndTime
local time_str=timeHelper.format_time_stamp11(st,true)
self.timeTxt:setText(FMT.fmt('剩余时间：{0}',time_str))
self.timeTxt2:setText(FMT.fmt('活动剩余时间：{0}',time_str))
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end
end

function UIHunYuanDanHuiWin:showConfirmDialog3WhenActivityEnd()
local content=FMT.fmt("积分已结算，无法游玩")
self.dialog=UIDialogManager.getConfirmDialogEx(self.dialog,{
content=content,
})
self.dialog.show()
end

function UIHunYuanDanHuiWin:checkIsHunYuanDanHuiActivityEnd()
local activityData=activitiesModel:getAnyOpenActInfoBySubtype(SUB_ACTIVITY_TYPE.eHunYuanDanHui)

if activityData==nil then
return false
end

local remainTime=self.info.end_time-gameUtilityModel.getServerShortTime()
return remainTime<self.sub_actcfg.earlyEndTime
end


function UIHunYuanDanHuiWin:onHide()

end

function UIHunYuanDanHuiWin:freshCanSaiReddot()
local reddot=self.myData.mod_type==1
self.cansaiState:setActive(reddot)
end

function UIHunYuanDanHuiWin:freshChengJiuReddot()
local reddot=self.info:getChengJiuReddot()
self.chengjiuReddot:setActive(reddot)
end

function UIHunYuanDanHuiWin:freshShowMoney()
self.moneyRoot:setActive(self.curModType==1)
end

function UIHunYuanDanHuiWin:freshMoney()
local widget=self.moneyRoot:getChildWidgetBase()
local itemId=self.sub_actcfg.money_type
local have=moneyModel.getMoney(itemId)
widget:SetChildText(1,have)
end

function UIHunYuanDanHuiWin:startTick(flag)
self.loopTotleTime=gameUtilityModel.getServerShortTime()
self.timer=self:setTimer(0.01,-1,self.timeOutCall)

if not flag then
self:changeDanYao(false)

self:stopDelayTimer()

local waitTime=cfgHelper.get2(cfg_hunyuandanhuibaseconfig_get,1,'waitTime')
self.delayTimer=self:delayDo(waitTime or 2,function()
if not _this then return end
_this:changeGameState(nil,nil,true)
end)
end
end

function UIHunYuanDanHuiWin:stopDelayTimer()
if self.delayTimer~=nil then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end


function UIHunYuanDanHuiWin:stopPanelTimer()
if self.panelTimer~=nil then
self:stopTimerByID(self.panelTimer)
self.panelTimer=nil
end
if self.panelTimer2~=nil then
self:stopTimerByID(self.panelTimer2)
self.panelTimer2=nil
end
end

function UIHunYuanDanHuiWin:timeOutCall()
_this:loop()
end

function UIHunYuanDanHuiWin:stopTick()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIHunYuanDanHuiWin.beginDragCallback()

end

function UIHunYuanDanHuiWin.endDragCallback()


if _this:checkIsHunYuanDanHuiActivityEnd()and _this.myData.mod_type==1 then
_this.dialog=_this:showConfirmDialog3WhenActivityEnd()
return;
end


if _this.isEndGame then
_this:showEndGameTips()
return false
end
if _this.myData.mod_type==1 then
local itemId=_this.sub_actcfg.money_type
local have=0
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<=0 then
_this:onMoneyBtn()
return false
end
end
local pos=_this.danyaoContent:getChildLocalPosition()
local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,_this.myData.cur_id,'radius')
local _w=675-radius*2
local x=_w/2-math.abs(pos.x)
local y=205+radius
_this:createDetail(_this.myData.cur_id,x,y,0)
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_addDanYao",_this.actID,_this.subType,_this.subid,{_this.myData.cur_id,x,y,0})
end


function UIHunYuanDanHuiWin:initGameState(isInit,isPlayEffect)
if isInit then
self:clearAllDanYao()
end
self:stopDelayTimer()
self:changeGameState(isInit,isPlayEffect,not isInit)

if not isInit then
if self.myData.record_list_len>0 then
for i=1,self.myData.record_list_len do
local data=self.myData.record_list[i]
self:createDetail(data.ele_id,data.x,data.y,data.r,true)

local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,data.ele_id,'radius')
if data.y>=_maxY-radius then
self.isEndGame=true
end
end
self:stopTick()
self:startTick()
end
end

self:refreshItemNum()
self:freshCanSaiReddot()
self:freshChengJiuReddot()
end

function UIHunYuanDanHuiWin:clearAllDanYao()
for i,luaid in pairs(self.bodyList)do
self.creater:deleteItemByLuaid(luaid)
end

self.isEndGame=false
self.curModType=0
self.bodyList={}
self.bodyListIdxLookup={}
self.bodyTypeLookup={}
self.useItemType=nil
self.itemDanYaoIdList={}
self.delDanYaoList={}
end

function UIHunYuanDanHuiWin:changeDanYao(flag)
local cur_id,next_id=self.info:getCurDanYaoId()
if cur_id>0 then
local curItem=self.danYaoItem:getChildWidgetBase()
self:setDanYaoItem(curItem,cur_id)

local abname="ui/windows/activities/sub_hunyuandanhui/sharedtextures/image_wuxingbutianwanfa_gj8.ab"
curItem:SetChildCSImageSprite(3,abname,"image_wuxingbutianwanfa_gj8")
self.danyaoScroller:setActive(flag)

local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,cur_id,'radius')
if flag then
local _w=673-radius*2
if self.oldRadius~=radius then
self.oldRadius=radius
self.danyaoScroller:setChildSizeDelta(_w,655)
self.danyaoContent:setChildSizeDelta(_w*2,130)
end
self.danyaoContent:setLocalPosX(-_w/2)
self.danYaoItem:setLocalPosX(_w)
end
end

if next_id>0 then
local nextItem=self.nextDanYaoItem:getChildWidgetBase()
nextItem:SetChildCSImageSprite(1,_abname,self.info:getHYDHSrc(next_id))
end

end

function UIHunYuanDanHuiWin:changeGameState(init,isPlayEffect,isShow)
if not init then
self.curModType=self.myData.mod_type
self:refreshItemNum()
end
local modType=self.curModType
if modType==0 then

if isPlayEffect then
self:stopPanelTimer()
self.danyaoScroller:setActive(false)
self.effect:setChildShowEffect(22657,true)
self.panelTimer=self:delayDo(1,function()
if not _this then return end
_this.gamePanel:setActive(false)
_this.mainPanel:setActive(true)
end)
else
self.gamePanel:setActive(false)
self.mainPanel:setActive(true)
end
else
if isPlayEffect then
self:stopPanelTimer()
self.danyaoScroller:setActive(false)
self.panelTimer=self:delayDo(1,function()
if not _this then return end
_this.effect:setChildShowEffect(22656,true)
end)
self.panelTimer2=self:delayDo(2,function()
if not _this then return end
_this:changeDanYao(true)
end)
else
if isShow then
self:changeDanYao(true)
end
end
self.mainPanel:setActive(false)
local cur_id,next_id=self.info:getCurDanYaoId()
self.curType:setText(modType==1 and"参赛模式"or"训练模式")
self.gamePanel:setActive(true)
self.nextDanYaoItem:setActive(true)
self.endGameBtn:setActive(modType==1)
self.chonzhiBtn:setActive(modType==2)
self.myScore:setActive(modType==1)
end
self:refreshScore()
self:freshShowMoney()
self:refreshBgModel()

self:refreshFreeReward()
end

function UIHunYuanDanHuiWin:setDanYaoItem(item,type)
local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'radius')

item:SetChildCSImageSprite(1,_abname,self.info:getHYDHSrc(type))
item:SetChildSizeDelta(1,radius*2,radius*2)
item:SetChildSizeDelta(-1,radius*2,radius*2)
item:SetChildSizeDelta(2,radius*2,radius*2)
end

function UIHunYuanDanHuiWin:refreshScore()
local score=self.myData.score or 0
local score_str=FMT.fmt('我的积分：<color=#549327>{0}</color>',mathHelper.formatNumber3(score))
self.myScore:setText(score_str)
end

function UIHunYuanDanHuiWin:refreshItemNum()
local delItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.delDanYao)
local delNum=self.info:getItemCanUseNum(delItemId)
self.delItemNumTxt:setText(delNum)
self.delNumDi:setActive(self.curModType==1)

local huhuanItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.huhuanDanYao)
local huhuanNum=self.info:getItemCanUseNum(huhuanItemId)
self.huhuanItemNumTxt:setText(huhuanNum)
self.huhuanNumDi:setActive(self.curModType==1)

local upItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.upDanYao)
local upNum=self.info:getItemCanUseNum(upItemId)
self.upItemNumTxt:setText(upNum)
self.shengjieNumDi:setActive(self.curModType==1)
end


function UIHunYuanDanHuiWin:registCollisionEvent(luaid_a,luaid_b)
local a=self.creater:getLuaObject(luaid_a)
local b=self.creater:getLuaObject(luaid_b)
a:setIsFusionAnim(true)
b:setIsFusionAnim(true)

local animTime=0.2

local pos1=a.widget:GetChildLocalPosition(-1)
local pos2=b.widget:GetChildLocalPosition(-1)
local posX=(pos1.x+pos2.x)/2
local posY=(pos1.y+pos2.y)/2
a.widget:SetChildDOLocalMove(-1,Vector3(posX,posY,0),animTime,function()
if not _this then return end
local type=a.type+1
table.removeValue(_this.bodyTypeLookup[a.type],luaid_a)

a:setType(type)
a:setIsFusionAnim(nil)
if not _this.bodyTypeLookup[type]then
_this.bodyTypeLookup[type]={}
end
table.insert(_this.bodyTypeLookup[type],luaid_a)

_this:showScoreText(a.type-1,Vector3(posX,posY,0))
end)
b.widget:SetChildDOLocalMove(-1,Vector3(posX,posY,0),animTime,function()
if not _this then return end
local order=_this.bodyListIdxLookup[luaid_b]
table.removeValue(_this.bodyTypeLookup[b.type],luaid_b)
table.insert(_this.delDanYaoList,b.type)
_this.bodyList[order]=nil
_this.bodyListIdxLookup[luaid_b]=nil
_this.creater:deleteItemByLuaid(luaid_b)
end)
end

function UIHunYuanDanHuiWin:createDetail(type,x,y,r,isInit)
self.detailIdx=self.detailIdx+1
local order=self.detailIdx
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
args.type=type
args.x=x
args.y=y
args.r=r
args.m_cav=self.m_cav
local luaid=self.creater:createObject("hydhChildDanYaoItem",self.creater:getID(),order,args)
self.bodyList[order]=luaid
self.bodyListIdxLookup[luaid]=order
if not self.bodyTypeLookup[type]then
self.bodyTypeLookup[type]={}
end
table.insert(self.bodyTypeLookup[type],luaid)
if not isInit then
self:stopTick()
self:startTick()
end
end


function UIHunYuanDanHuiWin:onFinishCreate(assetName,guid,luaid)



_this.creater:callChildFunc(luaid,'onCreatedFinish')

if assetName=="hydhChildDanYaoItem"then
local luaobject=_this.creater:getLuaObject(luaid)
luaobject:setClickFunc(function()
if _this.allSleep then
_this:onItemTouch(luaid,luaobject)
end
end)
end
end

function UIHunYuanDanHuiWin:loop()
local isEnd=false
self.allSleep=true
for type,list in pairs(self.bodyTypeLookup)do
local len=#list
for i=1,len do
local curLuaid=list[i]
if curLuaid then
local a=self.creater:getLuaObject(curLuaid)
if a.isFusionAnim then
self.allSleep=false
elseif not a.isMaxType and i<len then
for j=i+1,len do
if list[j]then
local b=self.creater:getLuaObject(list[j])

if b.isFusionAnim then
self.allSleep=false
elseif not b.isMaxType and self:checkCircleCollisionOptimized(a,b)then
self:registCollisionEvent(curLuaid,list[j])
self.allSleep=false
end
end
end
end

local pos=a.widget:GetChildLocalPosition(-1)
local _x=a.x-pos.x
local _y=a.y-pos.y
if pos.y>_maxY+a.radius or _x*_x>=0.0001 or _y*_y>=0.0001 then
a:setPos(pos.x,pos.y)
self.allSleep=false
end
if pos.y>=_maxY-a.radius then
isEnd=true
end
end
end
end
self.isEndGame=isEnd

if#self.delDanYaoList>0 then
local records={}
for id,luaid in pairs(self.bodyList)do
local luaobject=self.creater:getLuaObject(luaid)
if luaobject then
local pos=luaobject.widget:GetChildLocalPosition(-1)
luaobject:setPos(pos.x,pos.y)
local x=pos.x
local y=pos.y
local angle=math.random(0,360)

table.insert(records,{luaobject.type,x,y,angle})
end
end
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_collision",self.actID,self.subType,self.subid,records,self.delDanYaoList)
self.delDanYaoList={}
end

local curTime=gameUtilityModel.getServerShortTime()
if curTime>self.loopTotleTime+8 then
self.allSleep=true
end

if self.allSleep and curTime>self.loopTotleTime+1 then
self:stopTick()

local records={}
for id,luaid in pairs(self.bodyList)do
local luaobject=self.creater:getLuaObject(luaid)
if luaobject then
local pos=luaobject.widget:GetChildLocalPosition(-1)
luaobject:setPos(pos.x,pos.y)
local x=pos.x
local y=pos.y
local angle=math.random(0,360)

table.insert(records,{luaobject.type,x,y,angle})

if luaobject.radius and y>=_maxY-luaobject.radius then
isEnd=true
end
end
end

call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_collision",self.actID,self.subType,self.subid,records,{})


self.isEndGame=isEnd
if isEnd then
self:showEndGameTips()
end
end
end


function UIHunYuanDanHuiWin:useItemFunc(itemDanYaoTypeList)
local records={}
for id,luaid in pairs(self.bodyList)do
local luaobject=self.creater:getLuaObject(luaid)
if luaobject then
local pos=luaobject.widget:GetChildLocalPosition(-1)
luaobject:setPos(pos.x,pos.y)
local x=pos.x
local y=pos.y
local angle=math.random(0,360)

table.insert(records,{luaobject.type,x,y,angle})
end
end
if self.useItemType then
local itemId=self.info:getItemIdByType(self.useItemType)
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_useItem",self.actID,self.subType,self.subid,itemId,1,records,itemDanYaoTypeList,{})

self:initItemBtn()
end
end

function UIHunYuanDanHuiWin:showEndGameTips()
if self.endGameDialog~=nil then
self.endGameDialog:show()
return
end
local showdata={
type='UIDialouge',
title='提示',
content="灵丹融合已陷入瓶颈（<color=#ca631d>超过红线</color>）,无法继续进行！\n祖师是否退出本局？（或使用道具破局）",
canceltext='取消',
oktext='确定',
okcallback=function()
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_endGame",self.actID,self.subType,self.subid)
if self.curModType==2 then
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_startGame",self.actID,self.subType,self.subid,2)
end
end,
showclosebtn=false,
}
self.endGameDialog=UIDialogManager.newDialog(showdata)
self.endGameDialog:show()
end


function UIHunYuanDanHuiWin:checkCircleCollisionOptimized(circle1,circle2)
local dx=circle1.x-circle2.x
local dy=circle1.y-circle2.y
local radii=circle1.radius+circle2.radius+12
return(dx*dx+dy*dy)<=(radii*radii)
end

function UIHunYuanDanHuiWin:onItemTouch(id,luaobject)
if self.timer~=nil then
return
end
local isMaxType=luaobject.isMaxType
if not self.useItemType then return end
local len=1
if self.useItemType==eHunYuanDanHuiUseItemType.delDanYao then

elseif self.useItemType==eHunYuanDanHuiUseItemType.huhuanDanYao then

len=2
elseif self.useItemType==eHunYuanDanHuiUseItemType.upDanYao then
local type=luaobject.type
local upItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.upDanYao)
local param=self.info:getItemParam(upItemId)

if type>param then
UIManager.error('该灵丹不可提升')
return
end
if isMaxType then
UIManager.error('灵丹已满阶，不可提升')
return
end
end

for idx,_id in ipairs(self.itemDanYaoIdList)do
if id==_id then
table.remove(self.itemDanYaoIdList,idx)
luaobject:setSelect(false)
return
end
end

if#self.itemDanYaoIdList>=len then
local oldId=self.itemDanYaoIdList[1]
table.remove(self.itemDanYaoIdList,1)
local oldLuaobject=self.creater:getLuaObject(oldId)
oldLuaobject:setSelect(false)
end

table.insert(self.itemDanYaoIdList,id)
luaobject:setSelect(true)
end






function UIHunYuanDanHuiWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIHunYuanDanHuiWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end

function UIHunYuanDanHuiWin:showScoreText(type,wpos)
local score=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'point')or 0
local tw
if#self.scoreTextPool>0 then
tw=table.remove(self.scoreTextPool)
else
local tran=self.scoreText:getTransform()
local nt=GameObject.Instantiate(tran,self.scoreRoot:getTransform())
nt.gameObject:SetActive(true)
tw=nt:GetComponent('CSGUIWidgetBase')
end
tw:SetChildText(0,score)
tw:SetChildLocalPosition(-1,wpos)
local pos=tw:GetChildAnchoredPosition3D(-1)
pos.y=pos.y+100
tw:SetChildDOAnchorPos3D(-1,pos,1.51,function()
table.insert(self.scoreTextPool,tw)
end)

tw:SetChildCanvasGroupAlpha(-1,1)
local tween=tw:SetChildCanvasGroupDOFade(-1,0,0.5,nil)
tween:SetDelay(1)

tw:SetChildScale(-1,Vector3.New(0,0,1))
tween=tw:SetChildDOScale(-1,1,0.25,nil)
tween:SetEase(_Ease.OutQuad)

tween=tw:SetChildDOScale(-1,0.5,0.5,nil)
tween:SetEase(_Ease.InQuad)
tween:SetDelay(0.25)
end

function UIHunYuanDanHuiWin:showHitScoreText(type)
local score=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'point2')or 0
if score<=0 then
return
end
local tw
if#self.hitScoreTextPool>0 then
tw=table.remove(self.hitScoreTextPool)
else
local tran=self.hitScore:getTransform()
local nt=GameObject.Instantiate(tran,self.scoreRoot:getTransform())
nt.gameObject:SetActive(true)
tw=nt:GetComponent('CSGUIWidgetBase')
end
tw:SetChildText(0,score)
local wpos=self.hitScore:getChildPosition()
tw:SetChildPosition(-1,wpos)
local pos=tw:GetChildAnchoredPosition3D(-1)
local spos=Vector3.New(pos.x+200,pos.y,pos.z)
tw:SetChildAnchoredPosition3D(-1,spos)
tw:SetChildDOAnchorPos3D(-1,pos,0.5,nil)
tw:SetChildCanvasGroupAlpha(-1,0)
tw:SetChildCanvasGroupDOFade(-1,1,0.5,nil)
local tween=tw:SetChildCanvasGroupDOFade(-1,0,0.5,function()
table.insert(self.hitScoreTextPool,tw)
end)
tween:SetDelay(1.5)
end

function UIHunYuanDanHuiWin:initItemBtn(type)
if#self.itemDanYaoIdList>0 then
for i,v in ipairs(self.itemDanYaoIdList)do
local luaobject=self.creater:getLuaObject(v)
if luaobject then
luaobject:setSelect(false)
end
end
end
self.useItemType=type
self.itemDanYaoIdList={}

self.delText:setText(type==eHunYuanDanHuiUseItemType.delDanYao and"取消消除"or"消除")
self.huhuanText:setText(type==eHunYuanDanHuiUseItemType.huhuanDanYao and"取消互换"or"互换")
self.shengjieText:setText(type==eHunYuanDanHuiUseItemType.upDanYao and"取消升阶"or"升阶")

self:stopDelayTimer()
self.danyaoScroller:setActive(type==nil)
self.btnPanel:setActive(type==nil)
self.useItemBtn:setActive(type~=nil)
end




function UIHunYuanDanHuiWin:onUseItemBtn()

if self:checkIsHunYuanDanHuiActivityEnd()and self.myData.mod_type==1 then
self.dialog=self:showConfirmDialog3WhenActivityEnd()
return;
end
if self.timer~=nil then
UIManager.info('运动停止后才能使用')
return
end
if not self.useItemType then return end
local len=1
if self.useItemType==eHunYuanDanHuiUseItemType.delDanYao then

elseif self.useItemType==eHunYuanDanHuiUseItemType.huhuanDanYao then

len=2
elseif self.useItemType==eHunYuanDanHuiUseItemType.upDanYao then

end

if#_this.itemDanYaoIdList~=len then
if len==1 then
UIManager.error('请选择一个丹药')
else
UIManager.error('请选择两个丹药')
end
return
end

local id=_this.itemDanYaoIdList[1]
local luaobject=_this.creater:getLuaObject(id)
local widget=luaobject.widget
local type=luaobject.type

local itemDanYaoTypeList={}
local _callFunc=function()
if _this.useItemType==eHunYuanDanHuiUseItemType.delDanYao then

table.removeValue(_this.bodyTypeLookup[type],id)
local order=_this.bodyListIdxLookup[id]
_this.bodyList[order]=nil
_this.bodyListIdxLookup[id]=nil
table.insert(itemDanYaoTypeList,type)
luaobject:setIsFusionAnim(true)
widget:SetChildDOScale(-1,0.2,0.2,function()
if not _this then return end
_this.creater:deleteItemByLuaid(id)
_this:useItemFunc(itemDanYaoTypeList)
end)
elseif _this.useItemType==eHunYuanDanHuiUseItemType.huhuanDanYao then

local newLuaobject=_this.creater:getLuaObject(_this.itemDanYaoIdList[2])
local newWidget=newLuaobject.widget
local pos1=newWidget:GetChildLocalPosition(-1)
local pos2=widget:GetChildLocalPosition(-1)
newLuaobject:setSelect(false)
luaobject:setSelect(false)
table.insert(itemDanYaoTypeList,newLuaobject.type)
table.insert(itemDanYaoTypeList,luaobject.type)

newLuaobject:setIsFusionAnim(true)
luaobject:setIsFusionAnim(true)

newWidget:SetChildDOScale(-1,0.2,0.2,function()
if not _this then return end
newWidget:SetChildLocalPos(-1,pos2.x,pos2.y,0)
newLuaobject:setPos(pos2.x,pos2.y)
newWidget:SetChildDOScale(-1,1,0.2,function()
newLuaobject:setIsFusionAnim(nil)
end)
end)
widget:SetChildDOScale(-1,0.2,0.2,function()
if not _this then return end
widget:SetChildLocalPos(-1,pos1.x,pos1.y,0)
luaobject:setPos(pos1.x,pos1.y)
widget:SetChildDOScale(-1,1,0.2,function()
luaobject:setIsFusionAnim(nil)
end)
_this:useItemFunc(itemDanYaoTypeList)
end)
elseif _this.useItemType==eHunYuanDanHuiUseItemType.upDanYao then
table.removeValue(_this.bodyTypeLookup[type],id)

if not _this.bodyTypeLookup[type+1]then
_this.bodyTypeLookup[type+1]={}
end
table.insert(_this.bodyTypeLookup[type+1],id)
luaobject:setType(type+1,true)
luaobject:setSelect(false)
table.insert(itemDanYaoTypeList,type)
_this:useItemFunc(itemDanYaoTypeList)
end
_this:stopTick()
_this:startTick(true)
end

local contentStr
local name=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'name')
if _this.useItemType==eHunYuanDanHuiUseItemType.delDanYao then
contentStr=FMT.fmt('是否消除<color=#efb150>【{0}】</color>？',name)

elseif _this.useItemType==eHunYuanDanHuiUseItemType.huhuanDanYao then

local newLuaobject=_this.creater:getLuaObject(_this.itemDanYaoIdList[2])
local newName=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,newLuaobject.type,'name')
contentStr=FMT.fmt('是否互换<color=#efb150>【{0}】、【{1}】</color>？',name,newName)
elseif _this.useItemType==eHunYuanDanHuiUseItemType.upDanYao then

contentStr=FMT.fmt('是否升阶<color=#efb150>【{0}】</color>？',name)
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eHunYuanDanHuiUseItem)
if not flag then
local showdata={
type='UIDialouge',
title='提示',
content=contentStr,
canceltext='取消',
oktext='确定',
choosetext="本次登录不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eHunYuanDanHuiUseItem,flag)
end,
okcallback=_callFunc,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
_callFunc()
end
end



function UIHunYuanDanHuiWin:onCansaiBtn()

if self:checkIsHunYuanDanHuiActivityEnd()then
self.dialog=self:showConfirmDialog3WhenActivityEnd()
return;
end
if self.myData.mod_type~=0 then
if self.myData.mod_type~=1 then
local showdata={
type='UIDialouge',
title='提示',
content="正在进行训练模式，是否结束训练模式并开启参赛模式？",
canceltext='取消',
oktext='确定',
okcallback=function()
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_endGame",self.actID,self.subType,self.subid)
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_startGame",self.actID,self.subType,self.subid,1)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
self:initGameState()
end
return
end
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_startGame",self.actID,self.subType,self.subid,1)
end



function UIHunYuanDanHuiWin:onChengjiuBtn()
local args={}
args.parentWin=self
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
self:showWindow("UIHunYuanDanHuiChenJiuWin",args)
end



function UIHunYuanDanHuiWin:onDelBtn()
if self.timer~=nil then
UIManager.info('运动停止后才能消除')
return
end
if self.useItemType==eHunYuanDanHuiUseItemType.delDanYao then
self:initItemBtn()
return
end
local delItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.delDanYao)
local delNum=self.info:getItemCanUseNum(delItemId)
if self.curModType==1 and delNum<=0 then
UIManager.error('消除道具不足')
gainControl:showGainWin(delItemId)
return
end
self:initItemBtn(eHunYuanDanHuiUseItemType.delDanYao)
end



function UIHunYuanDanHuiWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eHunYuanDanHui,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end



function UIHunYuanDanHuiWin:onHuhuanBtn()
if _this.timer~=nil then
UIManager.info('运动停止后才能互换')
return
end
if self.useItemType==eHunYuanDanHuiUseItemType.huhuanDanYao then
self:initItemBtn()
return
end
local huhuanItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.huhuanDanYao)
local huhuanNum=self.info:getItemCanUseNum(huhuanItemId)
if self.curModType==1 and huhuanNum<=0 then
UIManager.error('互换道具不足')
gainControl:showGainWin(huhuanItemId)
return
end
self:initItemBtn(eHunYuanDanHuiUseItemType.huhuanDanYao)
end



function UIHunYuanDanHuiWin:onRankBtn()
local list=self.info:getSubRankAct()
if#list>0 then
local sub_actInfo=list[1]
activitiesController:jump(sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
else
UIManager.info('没有配置相应排行榜活动')
end
end



function UIHunYuanDanHuiWin:onShengjieBtn()
if _this.timer~=nil then
UIManager.info('运动停止后才能升阶')
return
end
if self.useItemType==eHunYuanDanHuiUseItemType.upDanYao then
self:initItemBtn()
return
end
local upItemId=self.info:getItemIdByType(eHunYuanDanHuiUseItemType.upDanYao)
local upNum,isMaxNum=self.info:getItemCanUseNum(upItemId)

if self.curModType==1 and upNum<=0 then
if isMaxNum then
UIManager.error('升阶次数已达上限')
else
UIManager.error('升级道具不足')
gainControl:showGainWin(upItemId)
end
return
end
self:initItemBtn(eHunYuanDanHuiUseItemType.upDanYao)
end



function UIHunYuanDanHuiWin:onXunlianBtn()
if self.myData.mod_type~=0 then
if self.myData.mod_type~=2 then
UIManager.error('正在进行参赛模式')
else
self:initGameState()
end
return
end
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_startGame",self.actID,self.subType,self.subid,2)
end

function UIHunYuanDanHuiWin:onChonzhiBtn()
if _this.timer~=nil then
UIManager.info('运动停止后才能重置')
return
end
local modType=self.myData.mod_type
local showdata={
type='UIDialouge',
title='提示',
content="重置后将清空炼丹炉中的灵丹，重新开始，是否重置？",
canceltext='取消',
oktext='确定',
okcallback=function()
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_endGame",self.actID,self.subType,self.subid)
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_startGame",self.actID,self.subType,self.subid,modType)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIHunYuanDanHuiWin:onEndGameBtn()
if _this.timer~=nil then
UIManager.info('运动停止后才能结束')
return
end
local showdata={
type='UIDialouge',
title='提示',
content="是否结束本局挑战，并结算积分？",
canceltext='取消',
oktext='确定',
okcallback=function()
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_endGame",self.actID,self.subType,self.subid)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIHunYuanDanHuiWin:onCloseClick()
self:closeSelf()
end

function UIHunYuanDanHuiWin:onFanhuiBtn()
if _this.timer~=nil then
UIManager.error('运动停止后才能返回')
return
end
self.curModType=0
self:initGameState(true)
end

function UIHunYuanDanHuiWin:onMoneyBtn()
local itemId=self.sub_actcfg.money_type
gainControl:showGainWin(itemId)
end

function UIHunYuanDanHuiWin:onFreeRewardBtn()
call_activitiesHandle_func("activitiesHandle_hunyuandanhui","reqProtocol_freeGift",self.actID,self.subType,self.subid)
end

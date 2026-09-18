







def_class("UIWorldTourWin",UIWindowBase)









function UIWorldTourWin:bindComponents()

self.TourBlocks=UIObject.get(self,0)
self.TourPoints=UIObject.get(self,1)
self.ButtonRightSelected=UIObject.get(self,2)
self.RightRoot=UIObject.get(self,3)
self.RightBg=UIObject.get(self,4)
self.RuleBtn=UIButton.get(self,5)
self.RightTips=UIText.get(self,6)
self.AreaName=UIText.get(self,7)
self.AreaList=UIScrollView.get(self,8)
self.RightPanel=UIObject.get(self,9)
self.BgContent=UIImage.get(self,10)
self.MoneyButton=UIButton.get(self,11)
self.MoneyNum=UIText.get(self,12)
self.MoneyIcon=UIImage.get(self,13)
self.RightContent=UIText.get(self,14)
self.TourNum=UIText.get(self,15)
self.UnlockTx=UIText.get(self,16)
self.RewardList=UIScrollView.get(self,17)
self.ButtonBack=UIButton.get(self,18)
self.ButtonRight=UIButton.get(self,19)
self.ButtonGetAll=UIButton.get(self,20)
self.RulePanel=UIObject.get(self,21)
self.RuleTx=UIText.get(self,22)

self.RuleBtn:setButtonClick(function()self:onRuleBtn()end)

self.MoneyButton:setButtonClick(function()self:onMoneyButton()end)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.ButtonRight:setButtonClick(function()self:onButtonRight()end)

self.ButtonGetAll:setButtonClick(function()self:onButtonGetAll()end)



end


function UIWorldTourWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.TourBlocks);self.TourBlocks=nil;
_UIObject_release(self.TourPoints);self.TourPoints=nil;
_UIObject_release(self.ButtonRightSelected);self.ButtonRightSelected=nil;
_UIObject_release(self.RightRoot);self.RightRoot=nil;
_UIObject_release(self.RightBg);self.RightBg=nil;
_UIObject_release(self.RuleBtn);self.RuleBtn=nil;
_UIObject_release(self.RightTips);self.RightTips=nil;
_UIObject_release(self.AreaName);self.AreaName=nil;
_UIObject_release(self.AreaList);self.AreaList=nil;
_UIObject_release(self.RightPanel);self.RightPanel=nil;
_UIObject_release(self.BgContent);self.BgContent=nil;
_UIObject_release(self.MoneyButton);self.MoneyButton=nil;
_UIObject_release(self.MoneyNum);self.MoneyNum=nil;
_UIObject_release(self.MoneyIcon);self.MoneyIcon=nil;
_UIObject_release(self.RightContent);self.RightContent=nil;
_UIObject_release(self.TourNum);self.TourNum=nil;
_UIObject_release(self.UnlockTx);self.UnlockTx=nil;
_UIObject_release(self.RewardList);self.RewardList=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.ButtonRight);self.ButtonRight=nil;
_UIObject_release(self.ButtonGetAll);self.ButtonGetAll=nil;
_UIObject_release(self.RulePanel);self.RulePanel=nil;
_UIObject_release(self.RuleTx);self.RuleTx=nil;
end
















local areaKid={
openBg=0,
closeBg=1,
areaNameTx=2,
iconTask=3,
numTask=4,
reddot=5,
}
local blockKid={
root=0,
image=1,
}
local pointKid={
root=0,
working=1,
waiting=2,
finished=3,
timeTx=4,
headIcon=5,
}
local areaSelected=nil
local rightShow=true
local tickDatas={}
local tickTimer=nil
local shakes={}
local shake_interval={1,2}
local delayAnimation=0.4
local _this=nil




function UIWorldTourWin:onLoaded(...)
self:bindComponents()
_this=self
self.AreaList:setClickAction(function(...)self:onClickArea(...)end)
self.RewardList:setClickAction(function(...)self:onClickReward(...)end)
notifySystem:listenNotify(notifyConfig.onTourCountChange,self.onTourCountChange)
notifySystem:listenNotify(notifyConfig.onTourCompeleted,self.onTourCompeleted)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onUpdateMoney)
notifySystem:listenNotify(notifyConfig.on_money_init,self.onInitMoney)

self.cDelay=self:delayDo(0.5,function()
worldController:showCamera(false)
end)

worldController:stopCameraControl()

self.RightRoot:setActive(false)
self.RightBg:setChildUIModelShowTarget(2050,1.05,{},100,false,false,0.6,function()
self.animationDelya=self:delayDo(delayAnimation,function()
self.RightRoot:setActive(true)
end)
end)

self.RuleTx:setText(cfgHelper.get1(cfg_lang_get,"worldTour_tips_1"))
self.winlua:ForceLayoutRect(self.RulePanel:getID())
self.RulePanel:setActive(false)
end


function UIWorldTourWin:__delete()
worldController:releaseCloudMask()
self:unbindComponents()
areaSelected=nil
_this=nil
self:clearTickData()
rightShow=true
notifySystem:removelistener(notifyConfig.onTourCountChange,self.onTourCountChange)
notifySystem:removelistener(notifyConfig.onTourCompeleted,self.onTourCompeleted)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onUpdateMoney)
notifySystem:removelistener(notifyConfig.on_money_init,self.onInitMoney)
if self.cDelay then
self:stopTimerByID(self.cDelay)
self.cDelay=nil
end
if self.animationDelya then
self:stopTimerByID(self.animationDelya)
self.animationDelya=nil
end
worldController:showCamera(true)
self:stopShakeTick()

worldController:resumeCameraControl()
end




function UIWorldTourWin:onShow(argtable,afterOnloaded)
self:updateData()
self:initTopView()
self:initLeftArea()
self:initRightView()

self:showTips()

if#self.areas>0 then
local enter=1
for i,v in ipairs(self.areas)do
if worldTourModel:getAreaEmpty(v)then
enter=i
break
end
end
self:onClickArea(-1,enter)
end
self:delayDo(shake_interval[1],function()
self:startShakeTick()
end)
end


function UIWorldTourWin:onHide()

end




function UIWorldTourWin.onUpdateMoney(moneyType,lastVal,val)

if moneyType==eMoneyType.mtLingPai then
_this:setMoneyNum(val)
end
end

function UIWorldTourWin:onMoneyButton()

end

function UIWorldTourWin.onInitMoney()
_this:setMoneyNum()
end

function UIWorldTourWin.onTourCountChange(isAdd,tourIDs)
local areas={}
for i,v in ipairs(tourIDs)do
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v)
areas[pointCfg.area]=true
_this:refreshCenterPoint(v)
end
for i,v in pairs(areas)do
_this:refreshAreaTask(i)
end
_this:setTourCount()

_this:refreshGetAll()

end

function UIWorldTourWin.onTourCompeleted(tourIDs)
local areas={}
for i,v in ipairs(tourIDs)do
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v)
areas[pointCfg.area]=true
_this:refreshCenterPoint(v)
end
for i,v in pairs(areas)do
_this:refreshAreaReddot(i)
end
_this:refreshGetAll(true)
end

function UIWorldTourWin:onButtonGetAll()
local allData=worldTourModel:getAllData()
local nowTime=timeHelper.getServerShortTime()
local finishs={}
for i,v in pairs(allData)do
if nowTime>=v.endtime then
table.insert(finishs,i)
end
end
if#finishs>0 then
worldTourController:send_5_72(finishs)
else
self:refreshGetAll(false)
end
end

function UIWorldTourWin:onClickHelp()
local d={}
d.mode=3
d.title="游历说明"
d.name='worldTour_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIWorldTourWin:onClickHelp2()
local d={}
d.mode=3
d.title="派遣弟子说明"
d.name='worldTour_rule2_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIWorldTourWin:onButtonBack()
self:closeSelf()
end

function UIWorldTourWin:onClickArea(id,index,guid,attach)
local area=self.areas[index]
if areaSelected~=area then
if areaSelected then
self:showSelectArea(areaSelected,false)
end
areaSelected=area
self:showSelectArea(areaSelected,true)
self:changeAreaView(area)
end
end

function UIWorldTourWin:onClickReward(id,index,guid,attach)
local overOpen=index-#self.openRewards
if overOpen>0 then
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,areaSelected)
local rewardCfg=self.closeRewards[overOpen]
local tipsArgs={}
tipsArgs.itemid=id
tipsArgs.formType=TIPS_FORM_TYPE.eWorldTour
tipsArgs.itemguid=guid
tipsArgs.attach={desc=FMT.fmt("{0}解锁{1}个区块\n<a;前往探索;5;1;2,0,{2};/>",areaCfg.name,rewardCfg[4],-1)}



tipsManager.showTips(tipsArgs)
else
itemsComponentHelper.onItemClick(id,index,guid,attach)
end
end

function UIWorldTourWin.onClickWaitPoint(id)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,areaSelected)
local point=areaCfg.travelpoints[id]
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,point)
local blockNum=worldBlockModel:getAreaStateCount(areaSelected,worldBlockModel.BLOCKSTATE.OPEN)

local cost=nil
for i=blockNum,1,-1 do
if pointCfg.consume[i]then
cost=pointCfg.consume[i]
break
end
end
if not cost then
return logErr(FMT.fmt("游历点{0}消耗配置{1}有误",point,blockNum))
end
for i,v in ipairs(cost)do
if not moneyModel.checkEnoughMoney(v[1],v[2])then
gainControl:showGainWin(v[1])
return UIManager.error(FMT.fmt("{0}资源不足",moneyModel.getMoneyName(v[1])))
end
end




if worldTourModel:getCount()>=worldTourModel:getMaxCount()then
return UIManager.error("游历弟子已达上限")
end



local args={
openType=dzSelectWinOpenType.eYouLi,
callback=function(guid)
worldTourController:send_5_71(pointCfg.id,guid)
end,
select_dis=nil,
pointCfg=pointCfg,
cost=cost[1],
}
discipleSelectController:openDiscipleSelect(args,"选择弟子")
end

function UIWorldTourWin.onClickFinishPoint(id)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,areaSelected)
local point=areaCfg.travelpoints[id]
worldTourController:send_5_72({point})
end

function UIWorldTourWin.onClickWorkingPoint(id)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,areaSelected)
local point=areaCfg.travelpoints[id]
UIManager:showWindow("UIWorldTourRecallDialog",point)
end

function UIWorldTourWin:updateData()
self.areas={}
for i,v in pairs(cfg_worldareaconfig())do
if worldBlockModel:isAreaExistOpen(i)then
table.insert(self.areas,i)
end
end
table.sort(self.areas)
end

function UIWorldTourWin:pushTickData(id,item,endTime)
tickDatas[id]={item,endTime}
if not tickTimer then
tickTimer=self:setTimer(1,0,function()self:onTickUpdate()end)
end
end

function UIWorldTourWin:popTickData(id)
tickDatas[id]=nil
if not next(tickDatas)then
if tickTimer then
self:stopTimerByID(tickTimer)
end
tickTimer=nil
end
end

function UIWorldTourWin:clearTickData()
tickDatas={}
if tickTimer then
self:stopTimerByID(tickTimer)
end
tickTimer=nil
end

function UIWorldTourWin:onTickUpdate()
local finishs={}
for i,v in pairs(tickDatas)do
local item=v[1]
local least=v[2]-timeHelper.getServerShortTime()
if least>0 then
item:SetChildText(pointKid.timeTx,FMT.fmt("剩余：{0}",timeHelper.format_time_stamp3(least)))
else
item:SetChildActive(pointKid.working,false)
item:SetChildActive(pointKid.finished,true)
table.insert(finishs,i)
end
end
for i,v in ipairs(finishs)do
self:popTickData(v)
end



end

function UIWorldTourWin:initTopView()
self:setMoneyNum()
self:setTourCount()
self.MoneyIcon:setIcon(iconHelper.getMoneyIconName(13),false)
end

function UIWorldTourWin:initLeftArea()
local cnt=#self.areas
self.AreaList:freshGridsNum(cnt,cnt,1,false)
local getAll=false
for i,v in ipairs(self.areas)do
local item=self.AreaList:getGridObjectByindex(i-1)
local cfg=cfgHelper.get1(cfg_worldareaconfig_get,v)
item:SetChildText(areaKid.areaNameTx,cfg.name)
local taskCnt=worldTourModel:getAreaTourCnt(v)
item:SetChildActive(areaKid.iconTask,taskCnt>0)
item:SetChildText(areaKid.numTask,FMT.fmt("X{0}",taskCnt))
local reddot=worldTourModel:getAreaReddot(v)
item:SetChildActive(areaKid.reddot,reddot)
item:SetChildActive(areaKid.closeBg,true)
item:SetChildActive(areaKid.openBg,false)




getAll=getAll or reddot
end
self:refreshGetAll(getAll)
end

function UIWorldTourWin:initRightView()
local duration=cfgHelper.getdef(cfg_worldtravelpointconfig,"duration")
self.RightTips:setText(FMT.fmt("弟子每次游历持续{0}",timeHelper.format_time_stamp11(duration,true)))
end

function UIWorldTourWin:setMoneyNum(value)
self.MoneyNum:setText(value or moneyModel.getMoney(eMoneyType.mtLingPai))
end

function UIWorldTourWin:setTourCount()
local max=worldTourModel:getMaxCount()
local cur=worldTourModel:getCount()
self.TourNum:setText(FMT.fmt("{0}/{1}",cur,max))
end

function UIWorldTourWin:setUnlockNum(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local max=#areaCfg.blocks
local cur=0
for i,v in ipairs(areaCfg.blocks)do
if worldBlockModel:checkBlockState(areaCfg.world,v,worldBlockModel.BLOCKSTATE.OPEN)then
cur=cur+1
end
end
self.UnlockTx:setText(FMT.fmt("已解锁块：{0}/{1}",cur,max))
end

function UIWorldTourWin:refreshGetAll(getAll)
local show=getAll
if show==nil then
show=false
for i,v in ipairs(self.areas)do
local reddot=worldTourModel:getAreaReddot(v)
if reddot then
show=true
break
end
end
end
self.ButtonGetAll:setActive(show)
end

function UIWorldTourWin:showSelectArea(index,selected)
local item=self.AreaList:getGridObjectByindex(index-1)



item:SetChildActive(areaKid.closeBg,not selected)
item:SetChildActive(areaKid.openBg,selected)

end

function UIWorldTourWin:setRightView(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
self.AreaName:setText(areaCfg.name)
self.RightContent:setText(areaCfg.travelcontent)

if areaCfg.traveldrop then
local blockNum=worldBlockModel:getAreaStateCount(area,worldBlockModel.BLOCKSTATE.OPEN)
local cnt=#areaCfg.traveldrop
local col=4
local row=math.ceil(cnt/col)
local propDatas={}
self.RewardList:freshGridsNum(cnt,row,col,false)
self.openRewards={}
self.closeRewards={}
for i,v in ipairs(areaCfg.traveldrop)do
if blockNum<v[4]then
table.insert(self.closeRewards,v)
else
table.insert(self.openRewards,v)
end
end
table.sort(self.openRewards,self.sortOpenRewards)
table.sort(self.closeRewards,self.sortCloseRewards)
local openConf={showname=false}
for i,v in ipairs(self.openRewards)do
openConf.itemcount=v[2]<=0 and""or nil
local prop=itemsComponentHelper.getCommonFillData({itemid=v[1],itemcount=v[2],},openConf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=v[3]==1
prop[PropIndex(DataPropKey.eWidgetActive,9)]=v[3]==2
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
table.insert(propDatas,prop)
end
local closeConf={itemcount="",showname=false}
for i,v in ipairs(self.closeRewards)do
local prop=itemsComponentHelper.getCommonFillData({itemid=v[1],itemcount=v[2],},closeConf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
prop[PropIndex(DataPropKey.eWidgetGray,2)]=true
prop[PropIndex(DataPropKey.eWidgetGray,3)]=true
table.insert(propDatas,prop)
end













self.RewardList:initPropData(propDatas)
else
self.RewardList:clearItems()
end
end

function UIWorldTourWin:setCenterView(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local bgImage=areaCfg.travelbg
self.BgContent:setSprite(bgImage[1],bgImage[2])

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,areaCfg.world)
local mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,worldCfg.sceneMap)
local maskInfo=mapCfg.maskParams
local clouds=worldBlockModel:getMasks(areaCfg.world)
self.winlua:SetChildCSImageMatTextureEx(self.BgContent:getID(),"_ControlTex",maskInfo,clouds)
self.winlua:SetChildCSImageMatVector(self.BgContent:getID(),"_ControlTex",worldSceneMapModel:getMaskUVRect())

local pos=bgImage[3]
local posX=pos and pos[1]or 0
local posY=pos and pos[2]or 0
self.BgContent:setChildAnchoredPosition(Vector3.New(posX,posY,0))
local blockCnt=math.min(#areaCfg.blocks,#areaCfg.travelblocks)
self.TourBlocks:setChildLayoutGroupCreateItems(blockCnt)
for i,v in ipairs(areaCfg.blocks)do
local blockItem=self.TourBlocks:getChildLayoutGroupGridItem(i-1)
local blockUICfg=areaCfg.travelblocks[i]
if blockUICfg then
blockItem:SetChildCSImageSprite(blockKid.image,blockUICfg[2],blockUICfg[3])
blockItem:SetChildAnchoredPosition(blockKid.root,mathHelper.convertArrayToVector(blockUICfg[1]))
blockItem:SetChildActive(blockKid.image,not worldBlockModel:checkBlockState(areaCfg.world,v,worldBlockModel.BLOCKSTATE.OPEN))
end
end

local pointCnt=#areaCfg.travelpoints
self.TourPoints:setChildLayoutGroupCreateItems(pointCnt)
for i,v in ipairs(areaCfg.travelpoints)do
local pointItem=self.TourPoints:getChildLayoutGroupGridItem(i-1)
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v)
local pointData=worldTourModel:getData(v)
local isOpen=worldBlockModel:checkBlockState(pointCfg.world,pointCfg.block,worldBlockModel.BLOCKSTATE.OPEN)
pointItem:SetChildAnchoredPosition(pointKid.root,mathHelper.convertArrayToVector(pointCfg.uiPoint))
pointItem:SetChildButtonClickWithID(pointKid.waiting,self.onClickWaitPoint,i,true)
pointItem:SetChildButtonClickWithID(pointKid.finished,self.onClickFinishPoint,i,true)
pointItem:SetChildButtonClickWithID(pointKid.working,self.onClickWorkingPoint,i,true)
if not isOpen then
self:popShake(i)

pointItem:SetChildActive(pointKid.waiting,false)
pointItem:SetChildActive(pointKid.working,false)
pointItem:SetChildActive(pointKid.finished,false)
elseif pointData then
local least=pointData.endtime-timeHelper.getServerShortTime()
local isFinish=least<=0

self:popShake(i)

pointItem:SetChildActive(pointKid.waiting,false)
pointItem:SetChildActive(pointKid.working,not isFinish)
pointItem:SetChildActive(pointKid.finished,isFinish)
if not isFinish then
pointItem:SetChildText(pointKid.timeTx,FMT.fmt("剩余：{0}",timeHelper.format_time_stamp3(least)))
self:pushTickData(i,pointItem,pointData.endtime)




local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(pointData.discipleguid)
comHelper.setChildModelRawImageEx(pointKid.headIcon,pointItem,modelParams,eHeadCenterType.eHead,1,false)
end
else
self:pushShake(i)
pointItem:SetChildActive(pointKid.waiting,true)
pointItem:SetChildActive(pointKid.working,false)
pointItem:SetChildActive(pointKid.finished,false)
end
end
end

function UIWorldTourWin:pushShake(index)
if not table.containsValue(shakes,index)then
table.insert(shakes,index)
end
end

function UIWorldTourWin:popShake(index)
table.removeValue(shakes,index)
end

function UIWorldTourWin:startShakeTick()
if not self.shakeTimer then
local tickUpdate=function()
local shakeCnt=#shakes
if shakeCnt>0 then
local shakeIdx=math.random(shakeCnt)
local index=shakes[shakeIdx]

local item=self.TourPoints:getChildLayoutGroupGridItem(index-1)

item:SetChildDOTweenAnimation_DOPlay(pointKid.waiting,nil,1,2)
end
end
tickUpdate()
self.shakeTimer=self:setTimer(shake_interval[2],0,tickUpdate)
end
end

function UIWorldTourWin:stopShakeTick()
if self.shakeTimer then
self:stopTimerByID(self.shakeTimer)
self.shakeTimer=nil
end
end

function UIWorldTourWin:changeAreaView(area)
self:clearTickData()
self:setUnlockNum(area)
self:setRightView(area)
self:setCenterView(area)
end

function UIWorldTourWin:refreshCenterPoint(point)
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,point)
if areaSelected==pointCfg.area then
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,pointCfg.area)
local index=-1
for i,v in ipairs(areaCfg.travelpoints or{})do
if v==point then
index=i
break
end
end
if index<0 then return end

local pointItem=self.TourPoints:getChildLayoutGroupGridItem(index-1)
local pointData=worldTourModel:getData(point)
local isOpen=worldBlockModel:checkBlockState(pointCfg.world,pointCfg.area,worldBlockModel.BLOCKSTATE.OPEN)
if not isOpen then
self:popShake(index)

pointItem:SetChildActive(pointKid.waiting,false)
pointItem:SetChildActive(pointKid.working,false)
pointItem:SetChildActive(pointKid.finished,false)
elseif pointData then
local least=pointData.endtime-timeHelper.getServerShortTime()
local isFinish=least<=0

self:popShake(index)

pointItem:SetChildActive(pointKid.waiting,false)
pointItem:SetChildActive(pointKid.working,not isFinish)
pointItem:SetChildActive(pointKid.finished,isFinish)
if not isFinish then
pointItem:SetChildText(pointKid.timeTx,FMT.fmt("剩余：{0}",timeHelper.format_time_stamp3(least)))
self:pushTickData(index,pointItem,pointData.endtime)




local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(pointData.discipleguid)
comHelper.setChildModelRawImageEx(pointKid.headIcon,pointItem,modelParams,eHeadCenterType.eHead,1,false)
return
end
else
self:pushShake(index)

pointItem:SetChildActive(pointKid.waiting,true)
pointItem:SetChildActive(pointKid.working,false)
pointItem:SetChildActive(pointKid.finished,false)
end
self:popTickData(index)
end
end

function UIWorldTourWin:refreshAreaTask(area)
for i,v in ipairs(self.areas)do
if v==area then
local item=self.AreaList:getGridObjectByindex(i-1)
local taskCnt=worldTourModel:getAreaTourCnt(v)
item:SetChildActive(areaKid.iconTask,taskCnt>0)
item:SetChildText(areaKid.numTask,FMT.fmt("X{0}",taskCnt))
local reddot=worldTourModel:getAreaReddot(v)
item:SetChildActive(areaKid.reddot,reddot)
break
end
end
end

function UIWorldTourWin:refreshAreaReddot(area)
for i,v in ipairs(self.areas)do
if v==area then
local item=self.AreaList:getGridObjectByindex(i-1)
local reddot=worldTourModel:getAreaReddot(v)
item:SetChildActive(areaKid.reddot,reddot)
break
end
end
end

function UIWorldTourWin.sortOpenRewards(a,b)
local colora=itemsConfig.getConfig(a[1]).color
local colorb=itemsConfig.getConfig(b[1]).color
if colora~=colorb then
return colora>colorb
else
return a[1]>b[1]
end
end

function UIWorldTourWin.sortCloseRewards(a,b)
if a[4]~=b[4]then
return a[4]<b[4]
else
return _this.sortOpenRewards(a,b)
end
end

function UIWorldTourWin:showTips()
local tips=worldTourModel:popBlockOpenTourRecord()

if#tips>0 then
for i,v in ipairs(tips)do
local world=v[1]
local area=v[2]
local block=v[3]
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
UIManager.info(FMT.fmt("{1}区域已解锁；{0}区域游历点更多了",areaCfg.name,blockCfg.name))
end
end
end

function UIWorldTourWin:onButtonRight()
rightShow=not rightShow
self.ButtonRightSelected:setActive(not rightShow)
self.RightPanel:setActive(rightShow)
if rightShow then
self.winlua:SetChildCanvasGroupAlpha(self.RightRoot:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.RightRoot:getID(),1,0.5)
end
end

function UIWorldTourWin:onRuleBtn()
local show=self.winlua:GetChildActiveSelf(self.RulePanel:getID())
show=not show
self.RulePanel:setActive(show)
end

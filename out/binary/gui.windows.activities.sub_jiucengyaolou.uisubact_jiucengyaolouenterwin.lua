







def_class("UISubAct_JiuCengYaoLouEnterWin",UIWindowBase)









function UISubAct_JiuCengYaoLouEnterWin:bindComponents()

self.mask=UIObject.get(self,0)
self.centerRoot=UIObject.get(self,1)
self.smoke=UIObject.get(self,2)
self.modelRoot=UIObject.get(self,3)
self.spineObject=UIObject.get(self,4)
self.baoXiang=UIButton.get(self,5)
self.baoxiangSO=UIObject.get(self,6)
self.baoXiangOpen=UIButton.get(self,7)
self.shadow=UIObject.get(self,8)
self.model=UIObject.get(self,9)
self.reddot=UIObject.get(self,10)
self.cost=UIObject.get(self,11)
self.costText=UIText.get(self,12)
self.costIcon=UIImage.get(self,13)
self.jxReddot=UIObject.get(self,14)
self.tips=UIObject.get(self,15)
self.nandulv=UIText.get(self,16)
self.jumpButton2=UIButton.get(self,17)
self.jumpButton1=UIButton.get(self,18)
self.nandujj=UIText.get(self,19)
self.jxButton=UIButton.get(self,20)
self.selectButton=UIButton.get(self,21)
self.logButton=UIButton.get(self,22)
self.wenzi_3=UIObject.get(self,23)
self.wenzi_4=UIObject.get(self,24)
self.wenzi_1=UIObject.get(self,25)
self.wenzi_2=UIObject.get(self,26)
self.wenzi_5=UIObject.get(self,27)
self.time=UIText.get(self,28)
self.nandu=UIButton.get(self,29)
self.level=UIText.get(self,30)
self.listHead=UIObject.get(self,31)
self.ListPanel=UIObject.get(self,32)
self.head=UIObject.get(self,33)
self.itemPanel=UIObject.get(self,34)

self.baoXiang:setButtonClick(function()self:onBaoXiang()end)

self.baoXiangOpen:setButtonClick(function()self:onBaoXiangOpen()end)

self.jumpButton2:setButtonClick(function()self:onJumpButton2()end)

self.jumpButton1:setButtonClick(function()self:onJumpButton1()end)

self.jxButton:setButtonClick(function()self:onJxButton()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.logButton:setButtonClick(function()self:onLogButton()end)

self.nandu:setButtonClick(function()self:onNandu()end)
self.wenzi={
self.wenzi_1,
self.wenzi_2,
self.wenzi_3,
self.wenzi_4,
self.wenzi_5,
}



end


function UISubAct_JiuCengYaoLouEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.centerRoot);self.centerRoot=nil;
_UIObject_release(self.smoke);self.smoke=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.spineObject);self.spineObject=nil;
_UIObject_release(self.baoXiang);self.baoXiang=nil;
_UIObject_release(self.baoxiangSO);self.baoxiangSO=nil;
_UIObject_release(self.baoXiangOpen);self.baoXiangOpen=nil;
_UIObject_release(self.shadow);self.shadow=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.jxReddot);self.jxReddot=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.nandulv);self.nandulv=nil;
_UIObject_release(self.jumpButton2);self.jumpButton2=nil;
_UIObject_release(self.jumpButton1);self.jumpButton1=nil;
_UIObject_release(self.nandujj);self.nandujj=nil;
_UIObject_release(self.jxButton);self.jxButton=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.logButton);self.logButton=nil;
_UIObject_release(self.wenzi_3);self.wenzi_3=nil;
_UIObject_release(self.wenzi_4);self.wenzi_4=nil;
_UIObject_release(self.wenzi_1);self.wenzi_1=nil;
_UIObject_release(self.wenzi_2);self.wenzi_2=nil;
_UIObject_release(self.wenzi_5);self.wenzi_5=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.nandu);self.nandu=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.listHead);self.listHead=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
self.wenzi=nil;
end



















function UISubAct_JiuCengYaoLouEnterWin:onLoaded(...)
self:bindComponents()
self.ListPanel:setChildScrollViewInit(0.5,true,function(...)self:onListClick(...)end)
if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('jiuCengYaoLouBG')
self.spineObject:setSprite(abName[1],abName[2])
else

self.spineObject:setChildUIModelShowTarget(3048,1,{},eAnimationID.stand,false,false,0,nil)
end

self.selectButton:setChildUIModelShowTarget(3049,1,{},eAnimationID.stand,false,false,0,nil)

self.nandutips=nil
self:showWenZi()
end


function UISubAct_JiuCengYaoLouEnterWin:__delete()
self:clearTimer()
self:unbindComponents()
self.nandutips=nil
end




function UISubAct_JiuCengYaoLouEnterWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
self.subid=argtable.sub_act_id
local enterSelect

if argtable.extraParams then
self.jumpIdx=argtable.extraParams.jumpIndex
enterSelect=argtable.extraParams.enterSelect
end
self.nandutips=nil
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self:updateData()
self:setRemainingTimeTimer()

self.spineObject:setChildCanvasGroupAlpha(0)
self.spineObject:setChildCanvasGroupDOFade(1,0.2,nil)
self.centerRoot:setChildCanvasGroupAlpha(0)
self.centerRoot:setChildCanvasGroupDOFade(1,0.5,nil)

self:refreshPanel(true,self.selectedLayer==nil)

self:refreshJXReddot()

if enterSelect then
self:onSelectButton(true)
end
end


function UISubAct_JiuCengYaoLouEnterWin:onHide()

end

function UISubAct_JiuCengYaoLouEnterWin:refreshJXReddot()
local reddot=false
if self.info then
reddot=self.info:checkJXReddot()or false
end
self.jxReddot:setActive(reddot)
end

function UISubAct_JiuCengYaoLouEnterWin:updateData()
local data={}
local serverData=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local level=serverData.level
local clearLayer=serverData.floor
local monsterList=serverData.monidxList or{}

self.nanduLevel=level

local floorCfg=self.config.floor
local monLv=activitiesHandle_jiucengyaolou:getMonLv(self.config,level)
local length=#floorCfg
for i,v in ipairs(floorCfg)do
local rwList=v[3]
local reward=nil
for _,rwv in ipairs(rwList)do
if monLv>=rwv[1]and monLv<=rwv[2]then
reward=rwv[3]
break
end
end
local monsterIdx=monsterList[i]
local monsterData=v[5][monsterIdx]
local last=i==length
local ruleData=v[9]
if monsterData then
monsterData=monsterData[1]
table.insert(data,{floor=i,last=last,floorCfg=v,rewardList=reward,monster=monsterData[1],monLv=monLv,effect=monsterData[2],allEffect=self.config.fixed,citiaoList=monsterData[3],ruleData=ruleData})
end
end

self.clearAll=clearLayer>=length
self.floorDataList=data
self.clearLayer=clearLayer

end

function UISubAct_JiuCengYaoLouEnterWin:refreshPanel(anim,smoke)
anim=anim or false
smoke=smoke or false

local longTime=timeHelper.getServerShortTime()
local et=longTime-self.start_time
local day=1
local isOpen=true
if et<0 then
day=1
isOpen=false
else
local cc=math.ceil(et/60)
cc=math.floor(cc/60)
cc=math.floor(cc/24)
local DD=cc
day=DD+1
end

self.today=day

local canBuy=self.clearLayer>0 and activitiesHandle_jiucengyaolou:canGotReward(self.actid,self.subid,self.clearLayer)==1
if self.clearAll or canBuy then
self.selectedLayer=self.clearLayer
else
local d=self.floorDataList[self.clearLayer+1]
if d then
local floor=self.clearLayer+1
local cfg=d.floorCfg
if cfg[1]>self.today then
self.selectedLayer=self.clearLayer
else
self.selectedLayer=floor
end
else
self.selectedLayer=self.clearLayer
end
end
if self.jumpIdx then
self.selectedLayer=self.jumpIdx
end
self:refreshList()
self:selectLayer(self.selectedLayer,anim,smoke)

self.nandulv:setText(self.nanduLevel)

end

function UISubAct_JiuCengYaoLouEnterWin:refreshList()
local floorDataList=self.floorDataList
local length=#floorDataList

self.ListPanel:setChildScrollViewCreateGrids(length,1)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
self.gridCount=count
local layer
for i=1,count do
local item=grids[count-i]
local floorData=floorDataList[i]
if item then
if floorData then
layer=i
local cfg=floorData.floorCfg

if cfg[1]<=self.today and layer<=self.clearLayer+1 then
item:SetChildText(0,FMT.fmt("第{0}层",layer))
else
item:SetChildText(0,"")
item:SetChildCanvasGroupAlpha(3,1)
end

local reddot=activitiesHandle_jiucengyaolou:canGotReward(self.actid,self.subid,layer)
item:SetChildActive(7,reddot==1)

local jixian=self.info:isJXGetReward(layer)
item:SetChildActive(2,jixian)
item:SetChildActive(1,self.selectedLayer==layer)
else
item:SetChildActive(5,false)
end
end
end
end

function UISubAct_JiuCengYaoLouEnterWin:onListClickLayer(floor,notwarring)
local index=self.gridCount-floor
self:onListClick(1,index,notwarring)
end

function UISubAct_JiuCengYaoLouEnterWin:onListClick(clicknum,index,notwarring)
local listIndex=index-1
local floor=self.gridCount-index
local floorDataList=self.floorDataList
local v=floorDataList[floor]
if not v then
return
end
if self.selectedLayer==floor then
return
end


local cfg=v.floorCfg
if cfg[1]<=self.today then
if floor>self.clearLayer+1 then
if notwarring then
UIManager.error(FMT.fmt("通关第{0}层开启",floor-1))
end
return
end
else
if notwarring then
UIManager.error(FMT.fmt("第{0}层将在活动第{1}天开启",floor,cfg[1]))
end
return
end
local oldGrid=self.ListPanel:getChildScrollViewItemWidget(self.gridCount-self.selectedLayer)
if oldGrid then
oldGrid:SetChildActive(1,false)
end

local grid=self.ListPanel:getChildScrollViewItemWidget(index)
if grid then

grid:SetChildActive(1,true)
self.selectedLayer=floor
self:selectLayer(floor,nil,true)
end
end


local offset={0,0}
function UISubAct_JiuCengYaoLouEnterWin:selectLayer(floor,anim,smoke)
local floorDataList=self.floorDataList
local floorData=floorDataList[floor]
if floorData then
local monster=floorData.monster

local monsterCfg=cfgHelper.get(cfg_monstergroup_get,monster)
local model=monsterCfg.model


self.smoke:setChildShowEffect(11001,smoke==true)
self.modelRoot:setActive(false)


local JJName=UIDiscipleModel.getJJNameCommon(floorData.monLv,3)
self.nandujj:setText(FMT.fmt("推荐弟子境界：<color=#fd8950>{0}</color>",JJName))
self.level:setText(monsterCfg.name)
self.model:setChildUIModelRemoveTarget()
local delay=self:setTimer(0.5,1,function()
if self and not self.isClose then
self.modelRoot:setActive(true)
self.model:setScale(Vector3(1.5,1.5,1.5))
local modelParam=cfgHelper.get2(cfg_dbbodyconfig_get,model[1],'scales2')
modelParam=modelParam and modelParam[3]or{1,0,0}
local scale=modelParam[1]or model[2]
self.model:setChildUIModelShowTarget(model[1],scale,model[3]or{},eAnimationID.stand,false,false,0,function()
self.model:setChildModelAnimationState(eAnimationID.stand)
end)

self.model:setChildUIModelShowTargetOffset(modelParam[2]or 0,modelParam[3]or 0)
self.shadow:setScale(Vector3(0.7*model[2],0.7*model[2],1))
end
end)


local reward=floorData.rewardList
if reward then
self:showItemPanel(reward)
end
self:refreshRecvReward(floor)
end
end

function UISubAct_JiuCengYaoLouEnterWin:doPunchRotation(reddot)
local index=self.reddot:getID()
if reddot then
self.reddot:setActive(true)
if self.reddotTweener==nil then
self:setChildRotation(index,0,0,0)
local tweener=self:setChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self:setChildRotation(index,0,0,0)
end
self.reddot:setActive(false)
end
end

function UISubAct_JiuCengYaoLouEnterWin:refreshRecvReward(floor)
local passData=activitiesHandle_jiucengyaolou:getPassData(self.actid,self.subid,floor)
local recvData=activitiesHandle_jiucengyaolou:getRecvRewardData(self.actid,self.subid,floor)
local floorDataList=self.floorDataList
local floorData=floorDataList[floor]
if passData~=nil then
local times=recvData or 0
local canBuy=false
local canBuyTwice=false
local isGot=false
local costConfig=floorData.floorCfg[4]
local buyTimes=#costConfig
if times==0 then
canBuy=true
elseif times>=1 and times<=buyTimes then
canBuyTwice=true
else
isGot=true
local reward=floorData.rewardList
if reward then
self:showItemPanel(reward)
end
end

if canBuyTwice then

if floorData then

local cost=costConfig[times]
self.costIcon:setChildIcon(iconHelper.getIconName(cost[1][1]),false)
self.costText:setText(FMT.fmt("{0}开启",cost[1][2]))
end
end
if canBuy then
self.baoxiangSO:setActive(true)
if not self.initBaoXiang then
self.baoxiangSO:setChildUIModelShowTarget(3047,1,{},eAnimationID.stand,false,false,0,nil)
self.initBaoXiang=true
end
else
self.baoxiangSO:setActive(false)
end
self.baoXiang:setActive(not isGot and not canBuy)
self.cost:setActive(canBuyTwice)
self.baoXiangOpen:setActive(isGot)
local grid=self.ListPanel:getChildScrollViewItemWidget(self.gridCount-floor)
if grid then
grid:SetChildActive(7,canBuy)
end
else
self.baoXiang:setActive(true)
self.cost:setActive(false)
self.baoxiangSO:setActive(false)
self.baoXiangOpen:setActive(false)
end



end

function UISubAct_JiuCengYaoLouEnterWin:showItemPanel(args)
local itemList=args
if itemList then

local canBuy=activitiesHandle_jiucengyaolou:canGotReward(self.actid,self.subid,self.selectedLayer)
local count=#itemList
self.itemPanel:setChildScrollViewCreateGrids(count,count)
local grids=self.itemPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]

local rewardNum=reward[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local gray=canBuy==3 and 1 or 0
local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=true,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,self.onClickItem)
item:SetChildPropData(2,prop)
item:SetChildActive(0,canBuy==3)
else
item:SetChildActive(1,false)
end
end
end
end

function UISubAct_JiuCengYaoLouEnterWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end


function UISubAct_JiuCengYaoLouEnterWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
else
self.time:setText("活动已结束")

UIManager.error("活动已结束")
self.isOver=true
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_JiuCengYaoLouEnterWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_JiuCengYaoLouEnterWin:onSelectClickDown()
self.selectButton:setChildModelAnimationState(eAnimationID.button_click,1)
end
function UISubAct_JiuCengYaoLouEnterWin:onSelectClickUp()
self.selectButton:setChildModelAnimationState(eAnimationID.button_up,1)
end

function UISubAct_JiuCengYaoLouEnterWin:addWenZi(showCfg)
local showCfg=cfg_jiucengyaoloushowconfig_get(1)
local areaList=showCfg.posArea
local usingArea=self.usingArea
if not usingArea then
self.usingArea={}
end
if not self.useGrid then
self.useGrid={}
for i,v in ipairs(self.wenzi)do
table.insert(self.useGrid,v)
end
end
local notUsingList={}
for i=1,#areaList do
if not self.usingArea[i]then
table.insert(notUsingList,i)
end
end
if not next(notUsingList)then
return
end
if not next(self.useGrid)then
return
end
local areaIndex=notUsingList[math.random(1,#notUsingList)]
local area=areaList[areaIndex]
local pos=Vector3.New(math.random(area[1],area[1]+area[3]),(math.random(area[2],area[2]+area[4])),0)
local grid=self.useGrid[1]
table.remove(self.useGrid,1)
if grid then
local widget=grid:getChildWidgetBase()
widget:SetChildAnchoredPosition(0,pos)
widget:SetChildCanvasGroupAlpha(0,0)
widget:SetChildCanvasGroupDOFade(0,1,showCfg.dur,function()
local tweener=widget:SetChildCanvasGroupDOFade(0,0,showCfg.dur,nil)
tweener:SetLoops(showCfg.times,_LoopType.Yoyo)
end)
self:setTimer(showCfg.dur*showCfg.times,1,function()
table.insert(self.useGrid,grid)
end)
end
end

function UISubAct_JiuCengYaoLouEnterWin:showWenZi()
local showCfg=cfg_jiucengyaoloushowconfig_get(1)
if not self.wenziTimer then
self.wenziTimer=self:setTimer(showCfg.cd,0,function()
self:addWenZi(showCfg)
end)
end
end





function UISubAct_JiuCengYaoLouEnterWin:onSelectButton(enterSelect)


local floorDataList=self.floorDataList
local data=floorDataList[self.selectedLayer]
local monster=data.monster
local actid=self.actid
local subType=self.subType
local subid=self.subid
local selectedLayer=self.selectedLayer
local monsterCfg=cfgHelper.get(cfg_monstergroup_get,monster)
local fightCallback=function(citiaoList)
local length=#citiaoList
fightController.showPrepareWin(eFightPreSelectType.jiucengyaolou,
{
enterTxt='九层妖楼',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterList=monsterCfg.monList,
groupId=monster,
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.jiucengyaolou,guidList,monsterCfg.mapId or 0,zfId,{actid,subType,subid,selectedLayer,length,citiaoList})
end,
cancelCallBack=function()
activitiesController:jump(actid,subType,subid,{jumpIndex=selectedLayer})
end,
})

end


local cfg=data.floorCfg
if cfg[1]<=self.today then
if selectedLayer>self.clearLayer+1 then
UIManager.error(FMT.fmt("通关第{0}层开启",self.clearLayer+1))
return
end
else
UIManager.error(FMT.fmt("第{0}层将在活动第{1}天开启",selectedLayer,cfg[1]))
return
end


UIManager:showWindow("UISubAct_JiuCengYaoLouSelectWin",{actid=self.actid,subType=self.subType,subid=self.subid,floor=self.selectedLayer,startTime=self.start_time,floorData=data,fightCallback=fightCallback,enterSelect=enterSelect})
end



function UISubAct_JiuCengYaoLouEnterWin:onJumpButton1()
end



function UISubAct_JiuCengYaoLouEnterWin:onJumpButton2()
end

function UISubAct_JiuCengYaoLouEnterWin:onBaoXiang()
local canBuy=activitiesHandle_jiucengyaolou:canGotReward(self.actid,self.subid,self.selectedLayer)
if canBuy==1 then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,self.selectedLayer}))
elseif canBuy==2 then

local floorDataList=self.floorDataList
local floorData=floorDataList[self.selectedLayer]
if floorData then
local recvData=activitiesHandle_jiucengyaolou:getRecvRewardData(self.actid,self.subid,self.selectedLayer)
local costConfig=floorData.floorCfg[4][recvData]
local cost=costConfig
local iconname=iconHelper.getIconName(cost[1][1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local content=FMT.fmt("是否确认花费{0}<color=#7d3b17>{1}</color> 继续开启",iconStr,cost[1][2])
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
moneySystem:useMoney(cost[1][1],cost[1][2],function()
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({2,self.selectedLayer}))
end,WARNING_TYPE.eWarning)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
elseif canBuy==0 then
UIManager.info("通关本层后可领取")
end

end

function UISubAct_JiuCengYaoLouEnterWin:onBaoXiangOpen()

end

function UISubAct_JiuCengYaoLouEnterWin:onLogButton()
self:showWindow("UIJiuCengYaoLouLogWin",{act_id=self.actid,subType=self.subType,sub_act_id=self.subid,layer=self.selectedLayer,data=self.floorDataList})
end

function UISubAct_JiuCengYaoLouEnterWin:onJxButton()
self:showWindow("UIJCYLJiXianJiangLiWin",{act_id=self.actid,subType=self.subType,sub_act_id=self.subid,data=self.floorDataList})
end

function UISubAct_JiuCengYaoLouEnterWin:onNandu()
self.nandutips=not self.nandutips
self.tips:setActive(self.nandutips)
end
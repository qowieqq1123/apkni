







def_class("UIYuLingZhaiWin",UIWindowBase)









function UIYuLingZhaiWin:bindComponents()

self.accButton=UIButton.get(self,0)
self.accImg=UIObject.get(self,1)
self.allSelect=UIButton.get(self,2)
self.animRoot=UIObject.get(self,3)
self.bdLevel=UIText.get(self,4)
self.canGotText=UIText.get(self,5)
self.coldtime=UIText.get(self,6)
self.discipleAnimRoot=UIObject.get(self,7)
self.discipleDesc=UIText.get(self,8)
self.discipleDescBg=UIButton.get(self,9)
self.discipleDescObj=UIObject.get(self,10)
self.effect1=UIObject.get(self,11)
self.effect2=UIObject.get(self,12)
self.emptyPanel=UIObject.get(self,13)
self.finButton=UIButton.get(self,14)
self.finButton2=UIButton.get(self,15)
self.finCost=UIText.get(self,16)
self.finCost2=UIText.get(self,17)
self.finCostImg=UIObject.get(self,18)
self.finCostImg2=UIObject.get(self,19)
self.freeImg=UIObject.get(self,20)
self.freeNum=UIText.get(self,21)
self.healButton=UIButton.get(self,22)
self.healPanel=UIObject.get(self,23)
self.healProgressbg=UIProgressBarAni.get(self,24)
self.healProgressTime=UIText.get(self,25)
self.helpButton=UIButton.get(self,26)
self.hurtNum=UIText.get(self,27)
self.hurtProgressBar=UIObject.get(self,28)
self.levelUpBtn=UIButton.get(self,29)
self.levelUpBtnText=UIText.get(self,30)
self.levelUpPanel=UIObject.get(self,31)
self.limitTimesBg=UIObject.get(self,32)
self.limitTimesText=UIText.get(self,33)
self.materials=UIObject.get(self,34)
self.materialsItem_1=UIBaseItem.get(self,35)
self.materialsItem_2=UIBaseItem.get(self,36)
self.materialsItem_3=UIBaseItem.get(self,37)
self.materialsItem_4=UIBaseItem.get(self,38)
self.materialsItem_5=UIBaseItem.get(self,39)
self.mbg=UIObject.get(self,40)
self.mengButton=UIButton.get(self,41)
self.mengButton0=UIButton.get(self,42)
self.mengNum=UIText.get(self,43)
self.root=UIObject.get(self,44)
self.scrollView=UIObject.get(self,45)
self.select=UIObject.get(self,46)
self.startPanel=UIObject.get(self,47)
self.stopButton=UIButton.get(self,48)
self.stopButton2=UIButton.get(self,49)
self.tequanPanel=UIObject.get(self,50)
self.tqdesc=UIObject.get(self,51)
self.tqicon=UIImage.get(self,52)
self.tqname=UIText.get(self,53)
self.x1=UIObject.get(self,54)
self.x2=UIObject.get(self,55)
self.xg_actor_name=UIText.get(self,56)
self.xgEffect=UIObject.get(self,57)
self.xgframe=UIButton.get(self,58)
self.xgHealButton=UIButton.get(self,59)
self.xgHealTimes=UIText.get(self,60)
self.xgname=UIText.get(self,61)
self.xgtips=UIButton.get(self,62)

self.accButton:setButtonClick(function()self:onAccButton()end)

self.allSelect:setButtonClick(function()self:onAllSelect()end)

self.discipleDescBg:setButtonClick(function()self:onDiscipleDescBg()end)

self.finButton:setButtonClick(function()self:onFinButton()end)

self.finButton2:setButtonClick(function()self:onFinButton2()end)

self.healButton:setButtonClick(function()self:onHealButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.mengButton:setButtonClick(function()self:onMengButton()end)

self.mengButton0:setButtonClick(function()self:onMengButton0()end)

self.stopButton:setButtonClick(function()self:onStopButton()end)

self.stopButton2:setButtonClick(function()self:onStopButton2()end)

self.xgframe:setButtonClick(function()self:onXgframe()end)

self.xgHealButton:setButtonClick(function()self:onXgHealButton()end)

self.xgtips:setButtonClick(function()self:onXgtips()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}
self.xg_actor={
["name"]=self.xg_actor_name,
}


self.sprite_image_waichu=0
self.sprite_image_kongwei=1
self.sprite_button_zongshouhuo_1=2
self.sprite_button_zongshouhuo_2=3

end


function UIYuLingZhaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.accButton);self.accButton=nil;
_UIObject_release(self.accImg);self.accImg=nil;
_UIObject_release(self.allSelect);self.allSelect=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.canGotText);self.canGotText=nil;
_UIObject_release(self.coldtime);self.coldtime=nil;
_UIObject_release(self.discipleAnimRoot);self.discipleAnimRoot=nil;
_UIObject_release(self.discipleDesc);self.discipleDesc=nil;
_UIObject_release(self.discipleDescBg);self.discipleDescBg=nil;
_UIObject_release(self.discipleDescObj);self.discipleDescObj=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.emptyPanel);self.emptyPanel=nil;
_UIObject_release(self.finButton);self.finButton=nil;
_UIObject_release(self.finButton2);self.finButton2=nil;
_UIObject_release(self.finCost);self.finCost=nil;
_UIObject_release(self.finCost2);self.finCost2=nil;
_UIObject_release(self.finCostImg);self.finCostImg=nil;
_UIObject_release(self.finCostImg2);self.finCostImg2=nil;
_UIObject_release(self.freeImg);self.freeImg=nil;
_UIObject_release(self.freeNum);self.freeNum=nil;
_UIObject_release(self.healButton);self.healButton=nil;
_UIObject_release(self.healPanel);self.healPanel=nil;
_UIObject_release(self.healProgressbg);self.healProgressbg=nil;
_UIObject_release(self.healProgressTime);self.healProgressTime=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.hurtNum);self.hurtNum=nil;
_UIObject_release(self.hurtProgressBar);self.hurtProgressBar=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.levelUpPanel);self.levelUpPanel=nil;
_UIObject_release(self.limitTimesBg);self.limitTimesBg=nil;
_UIObject_release(self.limitTimesText);self.limitTimesText=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mengButton);self.mengButton=nil;
_UIObject_release(self.mengButton0);self.mengButton0=nil;
_UIObject_release(self.mengNum);self.mengNum=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.startPanel);self.startPanel=nil;
_UIObject_release(self.stopButton);self.stopButton=nil;
_UIObject_release(self.stopButton2);self.stopButton2=nil;
_UIObject_release(self.tequanPanel);self.tequanPanel=nil;
_UIObject_release(self.tqdesc);self.tqdesc=nil;
_UIObject_release(self.tqicon);self.tqicon=nil;
_UIObject_release(self.tqname);self.tqname=nil;
_UIObject_release(self.x1);self.x1=nil;
_UIObject_release(self.x2);self.x2=nil;
_UIObject_release(self.xg_actor_name);self.xg_actor_name=nil;
_UIObject_release(self.xgEffect);self.xgEffect=nil;
_UIObject_release(self.xgframe);self.xgframe=nil;
_UIObject_release(self.xgHealButton);self.xgHealButton=nil;
_UIObject_release(self.xgHealTimes);self.xgHealTimes=nil;
_UIObject_release(self.xgname);self.xgname=nil;
_UIObject_release(self.xgtips);self.xgtips=nil;
self.materialsItem=nil;
self.xg_actor=nil;
end
















local _this




function UIYuLingZhaiWin:onLoaded(...)
self:bindComponents()
_this=self


self.levelUpPanel:setActive(zongmenModel:getMountainId()==mapIdType.fort)

self._onProgressUpdateAction=function(...)
if not _this then return end
_this:onProgressUpdateAction(...)
end
self.healProgressbg:setUpdateAction(self._onProgressUpdateAction)
self.healProgressbg:setFinishAction(function(...)self:onProgressBarFinishAction(...)end)

self.selectCnt={}
self.hzActorBT={}
self.selectAllFlag=false

local guildid=xianmengModel:getMyXMGuildID()
if guildid then
xianmengController:reqXMMemberListCheckCD(guildid)
end

self.on_building_event=function(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.levelUpComplete then
local data=zongmenModel:getBuildingData(bdId)
if self.bdData and self.bdData.un_build_id==bdId then
self.bdData=data
self.bdLevel:setText(FMT.fmt("{0}级愈灵斋",self.bdData.level))
if self:isMaxLevel(data)then
self.levelUpBtnText:setText("建筑信息")
else
self.levelUpBtnText:setText("建筑升级")
end
self:refreshLimit(self.bdData.level)
end
end
end
self:addNotify(notifyConfig.building_event,self.on_building_event)

self.onTeQuanInfoChange=function(tqData)
local tqid=tqData.tqid
local actorid,job,tequan=YuLingZhaiModel:getHealXGTeQuanActor()
if tqid==tequan then
self:refreshRecv()
end
if tqid==27 and self.useXGBtn then
self.xgEffect:setChildShowEffect(20637,true)
self.useXGBtn=nil
end
end
self:addNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)

self.onGuildMemberChange=function()
self:refreshTeQuan()
end
self:addNotify(notifyConfig.onGuildMemberChange,self.onGuildMemberChange)
end

function UIYuLingZhaiWin:isMaxLevel(bdData)
return cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)==nil
end

function UIYuLingZhaiWin.onTeQuanInfoChange(tqData)
if _this==nil or not _this.isVisible then return end

end


function UIYuLingZhaiWin:__delete()
self:unbindComponents()
_this=nil
self:removeUIInstance()
end




function UIYuLingZhaiWin:onShow(argtable,afterOnloaded)
self.openSelectAll=true

self.bdData=argtable.bdData or YuLingZhaiModel:getBuildingData(mapIdType.fort)

if self:isMaxLevel(self.bdData)then
self.levelUpBtnText:setText("建筑信息")
else
self.levelUpBtnText:setText("建筑升级")
end

self:refreshRightPanel()
self:refreshLeftPanel()

self:refreshAnim()
self:freshHuZhuBtn()

self:refreshTeQuan()
end


function UIYuLingZhaiWin:onHide()

end

function UIYuLingZhaiWin:refreshRecv()
self.selectCnt={}
self.openSelectAll=true
self.waitResult=nil
self:refreshRightPanel()
self:refreshLeftPanel()

self:refreshAnim()

self:freshHuZhuBtn()

self:refreshTeQuan()
end

function UIYuLingZhaiWin:refreshState()
local state=YuLingZhaiModel:getHealType()

self.discipleDesc:setText(state==2 and"快速治疗中"or"免费治疗中")

self.startPanel:setActive(state==1)
self.healPanel:setActive(state==2)
end

function UIYuLingZhaiWin:refreshLimit(lv)
local limit=YuLingZhaiModel:getSoldierMaxEx(lv)
self.healLimit=limit
local total=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
self.hurtProgressBar:setChildUIProgressbar(total,limit,false)
self.hurtNum:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(total),mathHelper.formatNumber(limit)))
end

function UIYuLingZhaiWin:refreshLeftPanel()
local limit=YuLingZhaiModel:getSoldierMax()
self.healLimit=limit
local num=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)

self.healnum=num
local total=num
self.hurtProgressBar:setChildUIProgressbar(total,limit,false)
self.hurtNum:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(total),mathHelper.formatNumber(limit)))

local state=YuLingZhaiModel:getHealType()or 1



self.startPanel:setActive(num>0 and state<=1)
self.healPanel:setActive(num>0 and state==2)

self.emptyPanel:setActive(num==0)
self.scrollView:setActive(num>0)
if num>0 and state==1 then
self.x1:setActive(false)
self.x2:setActive(false)
self.freeImg:setActive(true)
self.accImg:setActive(false)
self.discipleDescBg:setActive(true)
self:refreshStartPanel()
self.scrollView:setGray(false)

if self.openSelectAll then
self:onAllSelect(true)
if not self.waitResult then
self.openSelectAll=nil
end
end
elseif num>0 and state==2 then
self:refreshHealPanel()
self.scrollView:setGray(true)
else
self.discipleDescBg:setActive(false)
end

if self.bdData then
self.bdLevel:setText(FMT.fmt("{0}级愈灵斋",self.bdData.level))
end

self:freshHealNum()
end


function UIYuLingZhaiWin:refreshRightPanel()

self:dealHurtList()
self:refreshRightHurtList()
end

function UIYuLingZhaiWin:dealHurtList()
local list=YuLingZhaiModel:getHealData()or{}
local moneyList=xianjieModel:getSoldierHurtList(xjSoldierHurtType.eSeriousInjury)or{}
local dataList={}
local soldierCfg=cfg_fairylandsoldierconfig()
local state=YuLingZhaiModel:getHealType()
for i,v in ipairs(soldierCfg)do
local num=state==2 and(list[i]or 0)or(moneyList[i]or 0)

if num>0 then
table.insert(dataList,{config=v,num=num,healNum=list[i]or 0})
end
end

table.sort(dataList,function(a,b)
return a.config.id>b.config.id
end)

self.dataList=dataList
end

local abname="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"

function UIYuLingZhaiWin:refreshRightHurtList()
local state=YuLingZhaiModel:getHealType()
local dataList=self.dataList
self.scrollView:setChildScrollViewCreateGrids(#dataList,1)

self.discipleDescObj:setActive(#dataList>0)

local girds=self.scrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
if widget then
local data=dataList[i]
local config=data.config
local num=data.num
local healNum=data.healNum

widget:SetChildCSImageSprite(7,abname,config.bgIcon)
widget:SetChildCSImageSprite(0,abname,config.nameIcon)

widget:SetChildSliderInit(1,state==2 and healNum or self.selectCnt[config.id]or 0,0,num,function(val)self:onSliderChange(config.id,val,widget)end)
self:delayDo(0.02,function()
local w=self.scrollView:getChildScrollViewItemWidget(i-1)
if w then
w:SetChildSliderValue(1,state==2 and healNum or self.selectCnt[config.id]or 0)
end
end)
widget:SetChildInputFieldChange(2,true,function(...)
if not self then return end
return self:changeSelectCount(num,widget,config.id,...)
end)
widget:SetChildButtonClick(3,function()
if(self.selectCnt[config.id]or 0)>=num then
return
end
widget:SetChildSliderValue(1,(self.selectCnt[config.id]or 0)+1)
end)
widget:SetChildButtonClick(4,function()
if(self.selectCnt[config.id]or 0)==0 then
return
end
widget:SetChildSliderValue(1,(self.selectCnt[config.id]or 0)-1)
end)
widget:SetChildButtonClick(5,function()
if self.selectCnt[config.id]and self.selectCnt[config.id]>0 then
local desc=FMT.fmt('是否遣散<color=#5b9856>{0}</color>名<color=#5b9856>{1}</color>修士\n修士被遣散后将会云游四海，隐于山林之间，您的修士总战力将会因此降低，并且您<color=#5b9856>不会得到任何补偿</color>，请慎重选择',self.selectCnt[config.id],config.name)
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.okcallback=function()

local selectCnt=self.selectCnt[config.id]
if selectCnt then
socketManager:send_6_134(1,{{config.id,selectCnt}})
end
end
self.dialog:show()
else
UIManager.error("数量不能为0")
end
end)
end
end
end

function UIYuLingZhaiWin:onSliderChange(id,val,widget)
self.selectCnt[id]=val
widget:SetChildInputFieldValue(2,val)

self:refreshStartPanel()

end

function UIYuLingZhaiWin:changeSelectCount(maxCount,widget,id,str)

local count=tonumber(str)

local originalCount=self.selectCnt[id]or 0
local isNeedReset=false
if count==nil then

count=1
isNeedReset=true
elseif count==originalCount then

return
elseif count<1 then

count=1
isNeedReset=true
elseif count>maxCount then

count=maxCount
isNeedReset=true
end

if isNeedReset then
local countSelectWidget=widget
countSelectWidget:SetChildInputFieldValue(2,count)
return
end

if self.selectCnt[id]==count then
return
end
widget:SetChildSliderValue(1,count)
end

function UIYuLingZhaiWin:checkLimit()
local cnt=0
for i,v in pairs(self.selectCnt)do
cnt=cnt+v
if cnt>self.healLimit then
return true
end
end
return false
end

function UIYuLingZhaiWin:refreshStartPanel()

local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local time=YuLingZhaiModel:calcSoldierAccTime(YLZ_HEAL_TYPE.eFast,self.selectCnt)

local finCost=bdConfig.rapid_recover

self.finCostImg:setChildIcon(iconHelper.getIconName(finCost[1]))
self.finCost:setText(math.ceil(finCost[2]*time/(finCost[3]or 1)))

self.coldtime:setText(timeHelper.format_time_stamp(time))

local cost=YuLingZhaiModel:calcSoldierCost(self.selectCnt)

for i,item in ipairs(self.materialsItem)do
if cost[i]then
item:setActive(true)
local matItemId=cost[i][1]
local needCount=cost[i][2]
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)

local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end

self.healButton:setGray(time==0)
self.finButton:setGray(time==0)
local sendNum=0
for _,v in pairs(self.selectCnt)do sendNum=sendNum+v end
if self.healnum and sendNum<self.healnum then
if self.selectAllFlag then
self.selectAllFlag=false
end
self.select:setActive(self.selectAllFlag)
else
self.selectAllFlag=true
self.select:setActive(self.selectAllFlag)
end
end

function UIYuLingZhaiWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIYuLingZhaiWin:refreshHealPanel()
self.discipleDescBg:setActive(false)
self.x1:setActive(true)
self.x2:setActive(true)
self.freeImg:setActive(false)
self.accImg:setActive(true)
local startStamp=YuLingZhaiModel:getHealStartTime()
local useTime=YuLingZhaiModel:getLeftTime(true)
local endStamp=startStamp+useTime
local now=timeHelper.getServerShortTime()

local left=endStamp-now
self.dur=useTime
if left>0 then
self.stopButton:setActive(true)
self.stopButton2:setActive(false)
self.healProgressbg:animateFiveParams(useTime-endStamp+now,useTime,useTime,endStamp-now)
else
self.healProgressbg:animateTwoParams(endStamp,endStamp)
self.healProgressTime:setText("治疗完成")
self.stopButton:setActive(false)

end

local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local finCost=bdConfig.rapid_recover
self.finCostImg2:setChildIcon(iconHelper.getIconName(finCost[1]))
self.finCost2:setText(math.ceil(finCost[2]*useTime/(finCost[3]or 1)))
end

function UIYuLingZhaiWin:onProgressUpdateAction(div,time)
local time=math.ceil(self.dur-self.dur*div)
if time>0 then
self.healProgressTime:setText(FMT.fmt("{0}",timeHelper.format_time_stamp(time)))
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local finCost=bdConfig.rapid_recover
self.finCost2:setText(math.ceil(finCost[2]*time/(finCost[3]or 1)))
else
self.healProgressTime:setText('治疗完成')
self.stopButton:setActive(false)

end
end

function UIYuLingZhaiWin:onProgressBarFinishAction()
self.healProgressTime:setText('治疗完成')
self.stopButton:setActive(false)

end

function UIYuLingZhaiWin:refreshAnim()
self.animBuilding=self.animBuilding or{}

if next(self.animBuilding)then return end

local state=YuLingZhaiModel:getHealType()

self:removeUIInstance()

if state==2 then
self.hZState=1
self:createHS(0)
self:createHZ(0,1)
else
self:createHS(2)
end
end


function UIYuLingZhaiWin:removeUIInstance()
if self.changeHZTimer then
self:stopTimerByID(self.changeHZTimer)
self.changeHZTimer=nil
end

if self.hsActorBT then
uiAIManager:removeUIInstance(self.hsActorBT)
self.hsActorBT=nil
end
if self.hzActorBT[1]then
uiAIManager:removeUIInstance(self.hzActorBT[1])
self.hzActorBT[1]=nil
end
if self.hzActorBT[2]then
uiAIManager:removeUIInstance(self.hzActorBT[2])
self.hzActorBT[2]=nil
end
end

function UIYuLingZhaiWin:createHS(hsState)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)
local effect1=self.effect1:getID()
local effect2=self.effect2:getID()
local initData={


speakHUDParent=1,
leftPos={7.7,-200},
rightPos={180,-200},
effect1=effect1,
effect2=effect2,
hsState=hsState,
stateId=0,
hzState=0,
wWidget=self.winid,
}
local tran=self.discipleAnimRoot:getCommonComponent('Transform')
local vpos=Vector2.New(initData.rightPos[1],initData.rightPos[2])
local model=aiCfg.hushi
self.animBuilding[1]=1
return uiAIManager:createUIObject('UIYuLingZhaiWin','bt_ui_yulingzhai',INSTANCE_TYPE.eUIDisciple,model[1],
tran,vpos,initData,{scale=model[2]},function(bt)
self.animBuilding[1]=nil
self.hsActorBT=bt
end)
end

function UIYuLingZhaiWin:getHSSpeakText(bt,tkey)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)
bt:setSharedVar(tkey,aiCfg.hushiask[math.random(1,#aiCfg.hushiask)])
end

function UIYuLingZhaiWin:createHZ(hsState,hzActorBTIdx)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)

local initData={
speakHUDParent=1,
leftPos={-100,-190},
leftPos2={-100,-235},
leftPos3={-60,-320},
rightPos={540,-320},

hsState=0,
hzState=hsState,
stateId=1,
}
local tran=self.discipleAnimRoot:getCommonComponent('Transform')
local vpos=Vector2.New(initData.leftPos[1],initData.leftPos[2])
local model=aiCfg.shangzhe[math.random(1,#aiCfg.shangzhe)]
self.animBuilding[2]=1
return uiAIManager:createUIObject('UIYuLingZhaiWin','bt_ui_yulingzhai',INSTANCE_TYPE.eUIDisciple,model[1],
tran,vpos,initData,{scale=model[2],flip=1},function(bt)
self.animBuilding[2]=nil
self.hzActorBT[hzActorBTIdx]=bt
end)
end

function UIYuLingZhaiWin:getQYSpeakText(bt,tkey)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)
bt:setSharedVar(tkey,aiCfg.quanyuask[math.random(1,#aiCfg.quanyuask)])
end

function UIYuLingZhaiWin:getHZState(bt,tkey)
if(self.hZState==1 and self.hzActorBT[1])or(self.hZState==2 and self.hzActorBT[2])then

if self.hZState==1 then
local s=self.hzActorBT[1]:getSharedVar("hzState")or 0
bt:setSharedVar(tkey,s==0 and 0 or 1)
elseif self.hZState==2 then
local s=self.hzActorBT[2]:getSharedVar("hzState")or 0
bt:setSharedVar(tkey,s==0 and 0 or 1)
end
else
bt:setSharedVar(tkey,1)
end
end

function UIYuLingZhaiWin:getHSState(bt,tkey)
if self.hsActorBT then
local s=self.hsActorBT:getSharedVar("hsState")or 0
if s==0 then
bt:setSharedVar(tkey,0)
end
end
end


function UIYuLingZhaiWin:getHZModel(bt,tkey)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)
bt:setSharedVar(tkey,aiCfg.shangzhe[math.random(1,#aiCfg.shangzhe)][1])
end

function UIYuLingZhaiWin:getQYModel(bt,tkey)
local aiCfg=cfgHelper.get1(cfg_yulingzhaianimconfig_get,1)










local model=aiCfg.quanyu[math.random(1,#aiCfg.quanyu)]
local bodyid=model[1]
local components=model[3]or{}

bt:setSharedVar("hzmkey",bodyid)
bt:setSharedVar("hzmComponnets",components)

end

function UIYuLingZhaiWin:changeHZ()
self.changeHZTimer=self:delayDo(1.5,function()
if self.hZState==1 then
if not self.hzActorBT[2]then
self:createHZ(0,2)
else
self.hzActorBT[2]:setSharedVar("hzState",0)
self.hzActorBT[2]:reset(true)

end
self.hZState=2
else
if self.hzActorBT[1]then

self.hzActorBT[1]:setSharedVar("hzState",0)
self.hzActorBT[1]:reset(true)
end
self.hZState=1
end
end)

end

function UIYuLingZhaiWin:freshHuZhuBtn()
local state=YuLingZhaiModel:getHealType()
local isOpen=YingXianGeModel:checkOpen()
local canQiuZhu,hasQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,7)

if isOpen then
if canQiuZhu then

if xianjieController:checkInMoGongZhengDuo()then
self.mengButton0:setActive(false)
self.accButton:setActive(true)
else
self.mengButton0:setActive(true)
self.accButton:setActive(false)
end
self.mengButton:setActive(false)
else
self.accButton:setActive(true)
self.mengButton0:setActive(false)
self.mengButton:setActive(false)










end
local limit,maxLimit=xianjieModel:getHuZhuLimitTimes(7)
self.limitTimesBg:setActive(maxLimit~=nil and state==2)
if maxLimit~=nil and state==2 then
if limit>=maxLimit then
self.limitTimesText:setText("<color=#76D81E>今日盟友可协助总次数已满，无法求助</color>")
else
self.limitTimesText:setText(FMT.fmt("今日盟友可协助总次数：<color=#76D81E>{0}</color>",math.max(maxLimit-limit,0)))
end
end
else
self.accButton:setActive(true)
self.mengButton0:setActive(false)
self.mengButton:setActive(false)
self.limitTimesBg:setActive(false)
end

end

function UIYuLingZhaiWin:freshHealNum()
local state=YuLingZhaiModel:getHealType()
if state==1 then
self:stopHealTimer()
local sortList={}
local hurtList=YuLingZhaiModel:getHealData()or{}
for id,v in pairs(hurtList)do
if v>0 then
table.insert(sortList,{id,v})
end
end
table.sort(sortList,function(a,b)return a[1]>b[1]end)
local id=sortList[1]
if id then
local hp=xianjieModel:getSoldierAttr(id[1],xjSoldierAttr.hp)
local speedAdd=YuLingZhaiModel:getHealSpeedAdd(state)
local time=math.ceil(hp/speedAdd)
self.refreshHealTime=time

time=math.max(time,5)
local call=function()
local num=YuLingZhaiModel:getFreeHealNum()
self.freeNum:setText(math.max(num,0))
local cfgnum=cfgHelper.getdef1(cfg_yulingzhaiconfig,'in_adv_recover_hp')
self.canGotText:setText(num>=cfgnum and"可领取"or"治疗中")
end
call()
self.freshHealTimer=self:setTimer(time,0,call)
end
else
self:stopHealTimer()
self.freeNum:setText('')
end
end

function UIYuLingZhaiWin:stopHealTimer()
if self.freshHealTimer then
self:stopTimerByID(self.freshHealTimer)
end
end

function UIYuLingZhaiWin:refreshTeQuan()
local actorList,job,tequan,isMySelf=YuLingZhaiModel:getEffectXGTeQuanActor()


if next(actorList)and(tequan~=nil and xianguanHelper.checkTeQuanPlatformLimit(tequan))then
local myactor=playerModel:getActorID()


local tequanConfig=cfgHelper.get(cfg_xianguanprivilegeconfig_get,tequan)

local buffid=tequanConfig.effectArgs[1]

local isBuffEffect=buffid~=nil and homeBuffModel.isHasEffectBuff(buffid)

local addSpeed=0
local buffCfg=cfgHelper.get1(cfg_guildstateconfig_get,buffid)
for i,effectId in ipairs(buffCfg.effects)do
local buffCfg=cfgHelper.get2(cfg_guildstateeffectconfig_get,effectId)
if buffCfg.effect_type==BUFF_EFFECT_TYPE.eJunZhenAttr then
local param=buffCfg.param
if param[eAttributeType.eZL_Speed]then
addSpeed=param[eAttributeType.eZL_Speed]/10000
break
end
end
end


self.tqname:setText(tequanConfig.name)
self.xgframe:setActive(isBuffEffect and self.healnum>0)

local tqIconName=xianguanConfig.getTeQuanIconName(tequanConfig.icon)
self.tqicon:setImageIcon(tqIconName,false)




local xgname=cfgHelper.get(cfg_xianguanconfig_get,job,"name")


local addStr=''
for i,v in ipairs(actorList)do
local name=(mathHelper.compareInt64(v,myactor)and isMySelf)and playerModel:getActorName()or xianmengModel:getXMMemberName(v)
if i==1 then
addStr=FMT.fmt("{0}{1}",addStr,name)
else
addStr=FMT.fmt("{0}、{1}",addStr,name)
end
end
self.xgname:setText(FMT.fmt("【{0}】",xgname))
self.xg_actor_name:setText(addStr)

local desclist={}
local helpStr="xgTeQuan_CSBL_%d"
for i=1,3 do
local langStr=cfgHelper.get1(cfg_lang_get,string.format(helpStr,i))
if langStr then
table.insert(desclist,string.format(langStr,FMT.fmt("{0}%",addSpeed*100)))
end
end
self.tqdesc:setChildLayoutGroupCreateItems(#desclist)
local grids=self.tqdesc:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(0,desclist[i])
grid:SetChildActive(-1,true)
end

else
self.xgframe:setActive(false)
end
self:refreshXGHealBtn()
end

function UIYuLingZhaiWin:refreshXGHealBtn()
local actorid,job,tequan=YuLingZhaiModel:getHealXGTeQuanActor()
local privilegeKey=xianguanConfig.getTeQuanFindKey(job,tequan)
local teQuanObj=xianguanModel:getSelfTequanObj(privilegeKey)
local state=YuLingZhaiModel:getHealType()

self.xgHealButton:setActive(teQuanObj~=nil)
if teQuanObj then
local max=teQuanObj:getConfig("times")or 1
local times=teQuanObj.data.times or 0

if times<max then
if teQuanObj:checkInCd()then
local left=teQuanObj:getCdLeft()
self:startXGHealBtnTimer(1,left)
self.xgHealButton:setGray(true)
else
self.xgHealTimes:setText(FMT.fmt("剩余：{0}/{1}",max-times,max))
self.xgHealButton:setGray(max-times==0)
end
else
local left=xianguanConfig.getResetCD(tequan)

if left and left>0 then
self:startXGHealBtnTimer(2,left)
else
self.xgHealTimes:setText(FMT.fmt("剩余：{0}/{1}",max-times,max))
end
self.xgHealButton:setGray(max-times==0)
end
end
end

function UIYuLingZhaiWin:startXGHealBtnTimer(cdType,left)
local str=cdType==1 and"<color=#aae252>{0}后可使用</color>"or"{0}后重置"
local cd=left
local call=function()
cd=cd-1
self.xgHealTimes:setText(FMT.fmt(str,timeHelper.format_time_stamp12(cd)))
if cd<=0 then
self:stopXGHealBtnTimer()
self:refreshXGHealBtn()
end
end
self.xgHealTimer=self:setTimer(1,0,call)
self.xgHealTimes:setText(FMT.fmt(str,timeHelper.format_time_stamp12(cd)))
end

function UIYuLingZhaiWin:stopXGHealBtnTimer()
if self.xgHealTimer then
self:stopTimerByID(self.xgHealTimer)
self.xgHealTimer=nil
end
end




function UIYuLingZhaiWin:onAllSelect(exeFlag)
if exeFlag~=nil then
self.selectAllFlag=not exeFlag
end
if not self.selectAllFlag then
local dataList=self.dataList
local girds=self.scrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
if widget then
local data=dataList[i]
local num=data.num
widget:SetChildSliderValue(1,num)
end
end
self.selectAllFlag=true
else
local girds=self.scrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
if widget then
widget:SetChildSliderValue(1,0)
end
end
self.selectAllFlag=false
end

self.select:setActive(self.selectAllFlag)
end



function UIYuLingZhaiWin:onDiscipleDescBg()
local state=YuLingZhaiModel:getHealType()
if state==1 then
if YuLingZhaiModel:isFreeHealCanGet()then
YuLingZhaiController.req_6_133()
else
local sortList={}
local hurtList=YuLingZhaiModel:getHealData()or{}
for id,v in pairs(hurtList)do
if v>0 then
table.insert(sortList,{id,v})
end
end
table.sort(sortList,function(a,b)return a[1]>b[1]end)
local id=sortList[1]
if id then
local cfgnum=cfgHelper.getdef1(cfg_yulingzhaiconfig,'in_adv_recover_hp')
local hp=xianjieModel:getSoldierAttr(id[1],xjSoldierAttr.hp)
local speedAdd=YuLingZhaiModel:getHealSpeedAdd(state)
local time=math.ceil(hp/speedAdd)
local extraStrList={}

table.insert(extraStrList,FMT.fmt("当前免费治疗耗时：{0}",timeHelper.format_time_stamp11(YuLingZhaiModel:getLeftTime(true),true)))
table.insert(extraStrList,FMT.fmt("当前免费治疗效率：{0}/单个修士",timeHelper.formatSimpleTime(time)))
table.insert(extraStrList,"免费治疗的效率是根据当前最高境界的修士动态计算，有一定的预估误差")
table.insert(extraStrList,FMT.fmt("免费治疗的治愈人数达到{0}时，才可以进行领取",cfgnum))
self:onBtnWieghtRule(self.discipleDescBg,extraStrList)
end


end
elseif state==2 then

end
end

function UIYuLingZhaiWin:onBtnWieghtRule(posItem,extraStrList)
local d={}
d.showType=3
d.pos=Vector2.New(15,-30)
d.posItem=posItem

d.extraStrList=extraStrList
UIManager:showWindow('UIConditionTipsFour',d)
end



function UIYuLingZhaiWin:onFinButton()

local cost=YuLingZhaiModel:calcSoldierCost(self.selectCnt)
if cost then
for i,item in ipairs(cost)do
local matItemId=item[1]
local needCount=item[2]
local have=UIDanYaoModel:getHaveItemCount(matItemId)
if have<needCount then
gainControl:showCommonGainWin_item(matItemId,{needCount=needCount})
return
end
end
end

local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local time=YuLingZhaiModel:calcSoldierAccTime(YLZ_HEAL_TYPE.eFast,self.selectCnt)

local finCost=bdConfig.rapid_recover

local needCount=math.ceil(finCost[2]*time/(finCost[3]or 1))






local sendList={}
for id,v in pairs(self.selectCnt)do
if v>0 then
table.insert(sendList,{id,v})
end
end
local len=#sendList

local list={{finCost[1],needCount}}

moneySystem:useMoney(finCost[1],needCount,function()
if len>0 then
local desc=FMT.fmt('是否花费<color=#5b9856>{0}</color>灵玉\n立即完成这批重伤修士的救治？',needCount)
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.okcallback=function()
YuLingZhaiController.req_6_132(3,len,sendList)
end
self.dialog:show()
end
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)



end

function UIYuLingZhaiWin:onFinButton2()
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)

local startStamp=YuLingZhaiModel:getHealStartTime()
local useTime=YuLingZhaiModel:getLeftTime(true)
local endStamp=startStamp+useTime
local now=timeHelper.getServerShortTime()
local left=endStamp-now

if left<=0 then
return
end

local finCost=bdConfig.rapid_recover
local have=UIDanYaoModel:getHaveItemCount(finCost[1])
local needCount=math.ceil(finCost[2]*left/(finCost[3]or 1))






moneySystem:useMoney(finCost[1],needCount,function()
local healData=YuLingZhaiModel:getHealData()
if healData then
local sendList={}
for id,v in pairs(healData)do
if v>0 then
table.insert(sendList,{id,v})
end
end
local len=#sendList
if len>0 then
local desc=FMT.fmt('是否花费<color=#5b9856>{0}</color>灵玉\n立即完成这批重伤修士的救治？',needCount)
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.okcallback=function()
local _now=timeHelper.getServerShortTime()
local left=endStamp-_now
if left<=0 then
return
end
YuLingZhaiController.req_6_132(3,len,sendList)
end
self.dialog:show()
end
end
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)

end



function UIYuLingZhaiWin:onHealButton()
if self:checkLimit()then
UIManager.error("超过容量上限")
return
end


local cost=YuLingZhaiModel:calcSoldierCost(self.selectCnt)
if cost then
for i,item in ipairs(cost)do
local matItemId=item[1]
local needCount=item[2]
local have=UIDanYaoModel:getHaveItemCount(matItemId)
if have<needCount then
gainControl:showCommonGainWin_item(matItemId,{needCount=needCount})
return
end
end
end

local sendList={}
for id,v in pairs(self.selectCnt)do
if v>0 then
table.insert(sendList,{id,v})
end
end
local len=#sendList
if len>0 then
YuLingZhaiController.req_6_132(YLZ_HEAL_TYPE.eFast,len,sendList)
end
end



function UIYuLingZhaiWin:onLevelUpBtn()
UIManager:showWindow("UIXJBuildingInfoWin",self.bdData)
end



function UIYuLingZhaiWin:onTechan()
end

function UIYuLingZhaiWin:onAccButton()















local finishTime=YuLingZhaiModel:getEndStamp()
local args={}
args.titleName="紧急加速"
args.pos=2
args.extraWin='UIXJBuildingSpeedUpWin'
local ubdId=self.bdData.un_build_id
local initFinishTimeFunc=function()
local finishTime=YuLingZhaiModel:getEndStamp()
if not finishTime then
finishTime=0
end
return finishTime
end
args.extraParams={
showPage=1,
un_build_id=ubdId,
build_id=SLG_SYSTEM_TYPE.eYuLingZhai,
speedType=speedUpType.eYuLingZhai,
finishTime=finishTime,
initFinishTimeFunc=initFinishTimeFunc,
tipsText="治疗",
XJSpeedUp=REPEAT_TYPE.eXJYuLingZhaiSpeedUp,
backImg={"ui/windows/yulingzhai/yulingzhai_atlas_pak.ab","image_yulingzhaiA_10"}
}
args.showClose=false
self:showWindow('UIXJBuildingPageBgWin',args)
end

function UIYuLingZhaiWin:onStopButton()
local func=function()
YuLingZhaiController.req_6_133(1)
end

local desc='您确认<color=#5b9856>取消快速治疗</color>？\n取消只返还未进行快速治疗的资源，\n但已经消耗的加速道具<color=#5b9856>不会</color>返还'
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.okcallback=func

self.dialog:show()
end

function UIYuLingZhaiWin:onMengButton()
if not xianmengModel:hasXM()then
local func=function()
if not xianmengModel:checkInit()then



return
end
if mainControl:isSceneType(eSceneType.eZongmen)or mainControl:isSceneType(eSceneType.eXianJie)then
if zongmenControl:isMountid(mapIdType.xianmeng)then
xianmengController:leaveXianMengMap()
else
if xianmengModel:hasXM()then
xianmengController:enterXianMengMap()
else
UIFullYuLingZhaiControl:closeUI(true)
xianmengController:openJoinWin()
end
end
end
end
local desc='加入仙盟才可向盟友求助，\n是否前往加入仙盟？'
self.dialog=UIDialogManager.getConfirmDialog(self.dialog,'提示',desc)
self.dialog.oktext='加入仙盟'
self.dialog.canceltext='取消'
self.dialog.okcallback=func
self.dialog:show()
return
end
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,7)
if canQiuZhu then


xianjieController.reqQiuZhu(speedUpType.eYuLingZhai,speedUpMode.eAskHelp,nil)
else
local guid=xianjieModel:getQiuzhuGuid(speedUpMode.eAskHelp,7)
local data=xianjieModel:getCooperaionDataByGuid(guid)
local times=data and data.times or 0
local addTime,maxCount=YingXianGeModel:getReduceTimesData()
UIManager.info(FMT.fmt("当前求助进度：{0}/{1}",times,maxCount))
end
end

function UIYuLingZhaiWin:onMengButton0()
self:onMengButton()
end

function UIYuLingZhaiWin:onHelpButton()
local d={}
d.mode=3
d.title="规则介绍"
d.name='yulingzhai_help_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

function UIYuLingZhaiWin:onXgHealButton()
local actorid,job,tequan=YuLingZhaiModel:getHealXGTeQuanActor()

local privilegeKey=xianguanConfig.getTeQuanFindKey(job,tequan)
local teQuanObj=xianguanModel:getSelfTequanObj(privilegeKey)
if teQuanObj then
teQuanObj:use("")
self.useXGBtn=true
end
end

function UIYuLingZhaiWin:onXgframe()
self.xgtips:setActive(true)
end


function UIYuLingZhaiWin:onXgtips()
self.xgtips:setActive(false)
end

function UIYuLingZhaiWin:onStopButton2()
YuLingZhaiController.req_6_133()
end

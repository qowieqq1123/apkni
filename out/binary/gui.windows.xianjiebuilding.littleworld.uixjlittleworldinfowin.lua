







def_class("UIXJLittleWorldInfoWin",UIWindowBase)









function UIXJLittleWorldInfoWin:bindComponents()

self.addOrderCD=UIText.get(self,0)
self.addOrderCDRoot=UIObject.get(self,1)
self.addOrderDesc=UIText.get(self,2)
self.addOrderIcon=UIButton.get(self,3)
self.addOrderMoney=UIText.get(self,4)
self.addOrderMoneyIcon=UIImage.get(self,5)
self.addOrderPanel=UIObject.get(self,6)
self.addOrderRoot=UIObject.get(self,7)
self.attrPanel=UIObject.get(self,8)
self.banBuButton=UIButton.get(self,9)
self.baoxiangBtn=UIButton.get(self,10)
self.baoxiangReddot=UIObject.get(self,11)
self.baoxiangTime=UIText.get(self,12)
self.centerRoot=UIObject.get(self,13)
self.closeBtn=UIButton.get(self,14)
self.costPanel=UIObject.get(self,15)
self.detailPanel=UIObject.get(self,16)
self.dzattrDetailBtn=UIButton.get(self,17)
self.eventScrollview=UIObject.get(self,18)
self.faLingButton=UIButton.get(self,19)
self.helpButton=UIButton.get(self,20)
self.leftRoot=UIObject.get(self,21)
self.level=UIText.get(self,22)
self.levelPanel=UIObject.get(self,23)
self.levelPanelRoot=UIObject.get(self,24)
self.levelUpRoot=UIObject.get(self,25)
self.levelUpRootF=UIObject.get(self,26)
self.materialsItem_1=UIBaseItem.get(self,27)
self.materialsItem_2=UIBaseItem.get(self,28)
self.materialsItem_3=UIBaseItem.get(self,29)
self.materialsItem_4=UIBaseItem.get(self,30)
self.materialsItem_5=UIBaseItem.get(self,31)
self.maxLevel=UIText.get(self,32)
self.OrderDesc=UIText.get(self,33)
self.pagePanel=UIObject.get(self,34)
self.rightRoot=UIObject.get(self,35)
self.ruleList=UIObject.get(self,36)
self.rulePart=UIButton.get(self,37)
self.stateRoot=UIObject.get(self,38)
self.stateScroll=UIObject.get(self,39)
self.techanDetailBtn=UIButton.get(self,40)
self.upButton=UIButton.get(self,41)
self.upReddot=UIObject.get(self,42)
self.Viewport=UIObject.get(self,43)
self.weixingButton=UIButton.get(self,44)
self.weixingReddot=UIObject.get(self,45)
self.worldlevel=UIText.get(self,46)
self.worldLvPopCond=UIText.get(self,47)
self.xianghuoWarringBtn=UIButton.get(self,48)
self.xiushiPanel=UIObject.get(self,49)
self.xiushiView=UIObject.get(self,50)
self.xsTipsButton=UIButton.get(self,51)
self.zhenwuButton=UIButton.get(self,52)
self.zhenwuReddot=UIObject.get(self,53)

self.addOrderIcon:setButtonClick(function()self:onAddOrderIcon()end)

self.banBuButton:setButtonClick(function()self:onBanBuButton()end)

self.baoxiangBtn:setButtonClick(function()self:onBaoxiangBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.dzattrDetailBtn:setButtonClick(function()self:onDzattrDetailBtn()end)

self.faLingButton:setButtonClick(function()self:onFaLingButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.rulePart:setButtonClick(function()self:onRulePart()end)

self.techanDetailBtn:setButtonClick(function()self:onTechanDetailBtn()end)

self.upButton:setButtonClick(function()self:onUpButton()end)

self.weixingButton:setButtonClick(function()self:onWeixingButton()end)

self.xianghuoWarringBtn:setButtonClick(function()self:onXianghuoWarringBtn()end)

self.xsTipsButton:setButtonClick(function()self:onXsTipsButton()end)

self.zhenwuButton:setButtonClick(function()self:onZhenwuButton()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}



end


function UIXJLittleWorldInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addOrderCD);self.addOrderCD=nil;
_UIObject_release(self.addOrderCDRoot);self.addOrderCDRoot=nil;
_UIObject_release(self.addOrderDesc);self.addOrderDesc=nil;
_UIObject_release(self.addOrderIcon);self.addOrderIcon=nil;
_UIObject_release(self.addOrderMoney);self.addOrderMoney=nil;
_UIObject_release(self.addOrderMoneyIcon);self.addOrderMoneyIcon=nil;
_UIObject_release(self.addOrderPanel);self.addOrderPanel=nil;
_UIObject_release(self.addOrderRoot);self.addOrderRoot=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.banBuButton);self.banBuButton=nil;
_UIObject_release(self.baoxiangBtn);self.baoxiangBtn=nil;
_UIObject_release(self.baoxiangReddot);self.baoxiangReddot=nil;
_UIObject_release(self.baoxiangTime);self.baoxiangTime=nil;
_UIObject_release(self.centerRoot);self.centerRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.detailPanel);self.detailPanel=nil;
_UIObject_release(self.dzattrDetailBtn);self.dzattrDetailBtn=nil;
_UIObject_release(self.eventScrollview);self.eventScrollview=nil;
_UIObject_release(self.faLingButton);self.faLingButton=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.levelPanelRoot);self.levelPanelRoot=nil;
_UIObject_release(self.levelUpRoot);self.levelUpRoot=nil;
_UIObject_release(self.levelUpRootF);self.levelUpRootF=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.maxLevel);self.maxLevel=nil;
_UIObject_release(self.OrderDesc);self.OrderDesc=nil;
_UIObject_release(self.pagePanel);self.pagePanel=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.stateRoot);self.stateRoot=nil;
_UIObject_release(self.stateScroll);self.stateScroll=nil;
_UIObject_release(self.techanDetailBtn);self.techanDetailBtn=nil;
_UIObject_release(self.upButton);self.upButton=nil;
_UIObject_release(self.upReddot);self.upReddot=nil;
_UIObject_release(self.Viewport);self.Viewport=nil;
_UIObject_release(self.weixingButton);self.weixingButton=nil;
_UIObject_release(self.weixingReddot);self.weixingReddot=nil;
_UIObject_release(self.worldlevel);self.worldlevel=nil;
_UIObject_release(self.worldLvPopCond);self.worldLvPopCond=nil;
_UIObject_release(self.xianghuoWarringBtn);self.xianghuoWarringBtn=nil;
_UIObject_release(self.xiushiPanel);self.xiushiPanel=nil;
_UIObject_release(self.xiushiView);self.xiushiView=nil;
_UIObject_release(self.xsTipsButton);self.xsTipsButton=nil;
_UIObject_release(self.zhenwuButton);self.zhenwuButton=nil;
_UIObject_release(self.zhenwuReddot);self.zhenwuReddot=nil;
self.materialsItem=nil;
end


















local pageTypeList=
{
[1]='产能',
[2]='人口',
}



function UIXJLittleWorldInfoWin:onLoaded(...)
self:bindComponents()

self.on_year_changed=function()
self:onRecvPeople()
end
self:addNotify(notifyConfig.on_year_changed,self.on_year_changed)
self.onZongMenBuffFresh=function()
self:refreshStatePanel()
end
self:addNotify(notifyConfig.onZongMenBuffFresh,self.onZongMenBuffFresh)

self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChange(...)end)

self.leftRoot:setChildAnchoredPos(-251,0)
self.leftRoot:setChildDOAnchorPosX(51,0.5)
self.centerRoot:setChildAnchoredPos(0,200)
self.centerRoot:setChildDOAnchorPosY(0,0.5)
self.rightRoot:setChildAnchoredPos(201,0)
self.rightRoot:setChildDOAnchorPosX(0,0.5)

UIManager:invokeUIMethod("UIPlanent","showStarHalo",false)

self:addNotify(notifyConfig.onXCEquipChange,function(...)
self:refreshXingChenBtn()
end)
end


function UIXJLittleWorldInfoWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldInfoWin:onShow(argtable,afterOnloaded)

self:refreshInfoPanel()

self:refreshCostPanel()
self:refreshRewardPanel()
self:refreshPeoplePanel()
self:refreshEventPanel()
self:refreshStatePanel()
self:refreshPagePanel()
if argtable and argtable.openFaLing then
self:showWindow("UIXJLittleWorldFaLingWin")
end
end

function UIXJLittleWorldInfoWin:onShowArgRecv(argtable)
self:onShow()
end


function UIXJLittleWorldInfoWin:onHide()

end

function UIXJLittleWorldInfoWin:onRecvUp(lv)
self:refreshInfoPanel()
self:refreshCostPanel()
self:refreshPeoplePanel()
self:refreshAddOrderPanel()
self:showWindow("UIXJLittleWorldLevelUpTips",{new_lv=lv})
end

function UIXJLittleWorldInfoWin:onRecvPeople()
self:refreshInfoPanel()
self:refreshPeoplePanel()
end



function UIXJLittleWorldInfoWin:onRecvReward()
self:refreshRewardPanel()
end


function UIXJLittleWorldInfoWin:refreshXingChenBtn()
self:doPunchRotation_Btn(2,self.winid,self.weixingReddot:getID(),xingChenHelper.isHaveSlotCanEquip())
end

function UIXJLittleWorldInfoWin:refreshZhenWuBtn()
self:doPunchRotation_Btn(3,self.winid,self.zhenwuReddot:getID(),LittleWorldModel:isZhenWuCanEquipReddot()or LittleWorldModel:haveZhenWuCanActive())
end


function UIXJLittleWorldInfoWin:refreshInfoPanel()

local level=LittleWorldModel:getLittleWorldLevel()
self.worldlevel:setText(level)

local attrLookup=LittleWorldModel:getDiscipleAddAttr_Lookup()
local attrList=attrListHelper.transformToList(attrLookup,{{eAttributeType.eATK},{eAttributeType.eDEF},{eAttributeType.eHP}})
self.attrPanel:setChildLayoutGroupCreateItems(#attrList,nil)
local childGrids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attr=attrList[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
childItem:SetChildText(0,FMT.fmt("{0}：{1}",name,str))
end

local rewardList={}
local moneyDrop=LittleWorldModel.get_money_drop_id1(level)
if moneyDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,moneyDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end







local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldMoneyRate)

local zhenwuLookup,zhenwuPerentLooup=LittleWorldModel:getZhenWuItemEffect()

self.levelPanel:setChildLayoutGroupCreateItems(#rewardList,nil)
local childGrids=self.levelPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local rw=rewardList[i]
childItem:SetChildIcon(1,iconHelper.getIconName(rw[1]),false)
childItem:SetChildText(2,mathHelper.formatNumber(math.floor(rw[2]*(1+(addValLookup[rw[1]]or 0)/100+(zhenwuPerentLooup[rw[1]]or 0)/100))))
end

self:refreshUpReddot()

local unlock2Lv=cfgHelper.get(cfg_smallworldconfig_get,1,"open_lv")
local unlockLv_star=cfgHelper.get(cfg_smallworldconfig_get,1,"stars_open_lv")

if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorldZW)then
self.zhenwuButton:setActive(false)
else
self.zhenwuButton:setActive(true)
self:refreshZhenWuBtn()
end

if not xingChenHelper.isXingChenOpen()then
self.weixingButton:setActive(false)
else
self.weixingButton:setActive(true)
self:refreshXingChenBtn()
end
end


function UIXJLittleWorldInfoWin:refreshCostPanel()
local world_lv=LittleWorldModel:getLittleWorldLevel()
local costConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_costs")
local nextConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv+1)

if nextConfig then
local pop=LittleWorldModel:getLittleWorldPopulation()
local populationCond=true
local populationNum=0
local conditionConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_condition")
if conditionConfig then
for i,v in ipairs(conditionConfig)do
if v[1]==1 then
if pop<v[2]then
populationCond=false
populationNum=v[2]
break
end
end
end
end
self.levelUpRoot:setActive(true)
self.maxLevel:setActive(false)
for i,item in ipairs(self.materialsItem)do
local reward=costConfig[i]
if reward then
local matItemId=reward[1]
local needCount=reward[2]
local showStage=not moneyConfig.isMoney(matItemId)
local have=itemsModel.getCount(matItemId)
local color=have>=needCount and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local countStr
if moneyConfig.isMoney(matItemId)then
countStr=FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber(needCount),color)
else
countStr=FMT.fmt("<color={2}>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(needCount),color)
end
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:setActive(true)
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
itemsComponentHelper.onItemClick(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end
if populationCond then
self.upButton:setActive(true)
self.worldLvPopCond:setText("")
else
self.upButton:setActive(false)
self.worldLvPopCond:setText(FMT.fmt("升级条件：人口达到<color=#f36666>{0}</color>",mathHelper.formatNumber4(populationNum,2)))
end
else
self.levelUpRoot:setActive(false)
self.maxLevel:setActive(true)
self.maxLevel:setText("已满级")
end




end


function UIXJLittleWorldInfoWin:refreshRewardPanel()
local canGet=LittleWorldModel:canGetReward()or false

self.baoxiangBtn:setActive(canGet)
self:doPunchRotation_Btn(1,self.winid,self.baoxiangReddot:getID(),canGet)
self:stopBXTimer()
if canGet then
local moneyStart=LittleWorldModel:getMoneyStartSec()

local now=timeHelper.getServerShortTime()
local limit=cfgHelper.get(cfg_smallworldconfig_get,1,"store_time")*3600

local time=now-moneyStart
if time>=limit then
self.baoxiangTime:setText(timeHelper.format_time_stamp3(limit))
else
self.baoxiangTime:setText(timeHelper.format_time_stamp3(time))
self.bxTimer=self:setTimer(1,0,function()
local n=timeHelper.getServerShortTime()
local t=n-moneyStart
self.baoxiangTime:setText(timeHelper.format_time_stamp3(t))
if t>=limit then
self:stopBXTimer()
end
end)
end

end
end

function UIXJLittleWorldInfoWin:stopBXTimer()
if self.bxTimer then
self:stopTimerByID(self.bxTimer)
self.bxTimer=nil
end
end

function UIXJLittleWorldInfoWin:refreshEventPanel()
local datas=LittleWorldModel:getEventData()
datas=table.reverse(datas)
local len=#datas
self.eventScrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.eventScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]


local year=gameUtilityModel.getGameYearPassByLongStamp(data.time or 0)

item:SetChildText(1,FMT.fmt('【系统】第{0}年,{1}',year,data.content))
item:SetChildButtonClick(3,function()
self:showWindow("UIXJLittleWorldEventWin")
end)
end
end

function UIXJLittleWorldInfoWin:refreshStatePanel()
self:clearBuffTimer()
local allBuffList=homeBuffModel.getAllList()

self.showBuffList={}
for i,v in ipairs(allBuffList)do
local guildstateconfig=cfg_guildstateconfig_get(v[1])
if guildstateconfig.show or guildstateconfig.show==nil then
if guildstateconfig.isSystemShow==1 then
self.showBuffList[#self.showBuffList+1]=v
end
end
end

local showBuffCount=#self.showBuffList
local isShowBuffPanel=showBuffCount>0
self.stateRoot:setActive(isShowBuffPanel)
if isShowBuffPanel then
self.stateScroll:setChildScrollViewCreateGrids(showBuffCount,showBuffCount)
local grids=self.stateScroll:getChildScrollViewItemWidgets()
local isSetTimer=false
for i=1,grids.Count do
local widget=grids[i-1]
local data=self.showBuffList[i]
local id=data[1]
local endStamp=data[2]
local guildstateconfig=cfg_guildstateconfig_get(id)
local showTimeByConfig=guildstateconfig.showtime~=false
local isEveryTime=endStamp<=0
local showTime=not isEveryTime and showTimeByConfig or false

local bufftype=guildstateconfig.bufftype or false

local iconname=iconHelper.getzmStateIcon(guildstateconfig.icon)

local hasHigher=homeBuffModel.hasHigherLevelBuff(id)


widget:SetChildCSImageIcon(0,iconname,false)
widget:SetChildImageExGray(0,hasHigher)

widget:SetChildActive(2,bufftype)
widget:SetChildActive(3,not bufftype)

local color=bufftype and FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]


widget:SetChildActive(1,showTime)
if showTime then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
local timeStr=""
if left>0 then
timeStr=FMT.fmt("<color={1}>{0}</color>",timeHelper.format_time_stamp13(left),color)
end
widget:SetChildText(1,timeStr)
isSetTimer=true
end

widget:SetChildButtonClick(0,function()
local args=
{
buffid=id,
posWidget=widget,
pos={x=0,y=-150}
}
self:showWindow("UILongHuHuiJuanTips",args)
end)
end

if isSetTimer then

self:setBuffTimer()
end
end
end

function UIXJLittleWorldInfoWin:refreshJiShiBuffPanel_onlyTime()
local showBuffCount=#self.showBuffList
local isShowBuffPanel=showBuffCount>0
self.stateRoot:setActive(isShowBuffPanel)
if isShowBuffPanel then
local grids=self.stateScroll:getChildScrollViewItemWidgets()
local isSetTimer=false
for i=1,grids.Count do
local widget=grids[i-1]
local data=self.showBuffList[i]
local id=data[1]
local endStamp=data[2]
local guildstateconfig=cfg_guildstateconfig_get(id)
local showTimeByConfig=guildstateconfig.showtime~=false
local isEveryTime=endStamp<=0
local showTime=not isEveryTime and showTimeByConfig or false
local bufftype=guildstateconfig.bufftype or false
local color=bufftype and FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]


widget:SetChildActive(1,showTime)
if showTime then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
local timeStr=""
if left>0 then
timeStr=FMT.fmt("<color={1}>{0}</color>",timeHelper.format_time_stamp13(left),color)
else

return self:refreshStatePanel()
end
widget:SetChildText(1,timeStr)
isSetTimer=true
end
end
if not isSetTimer then

return self:clearBuffTimer()
end
else

return self:clearBuffTimer()
end
end

function UIXJLittleWorldInfoWin:setBuffTimer()
self:clearBuffTimer()
self.buffTimer=self:setTimer(1,0,function()
if not self then return end
return self:refreshJiShiBuffPanel_onlyTime()
end)
end

function UIXJLittleWorldInfoWin:clearBuffTimer()
if self.buffTimer then
self:stopTimerByID(self.buffTimer)
self.buffTimer=nil
end
end

function UIXJLittleWorldInfoWin:refreshPagePanel()
self.pagePanel:setChildLayoutGroupCreateItems(#pageTypeList,nil)
local grids=self.pagePanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,pageTypeList[i])
grid:SetChildButtonClick(2,function()
if self.pageIndex~=i then
if self.pageIndex then
self:onClickPage(self.pageIndex,false)
end
self.pageIndex=i
self:onClickPage(i,true)
end
end)
end
if not self.pageIndex then
self.pageIndex=1
self:onClickPage(1,true)
end
end

function UIXJLittleWorldInfoWin:onClickPage(idx,flag)
local grid=self.pagePanel:getChildLayoutGroupGridItem(idx-1)
if grid then
grid:SetChildActive(0,flag)
end
if flag then
if idx==1 then
self.levelPanelRoot:setActive(true)
self.levelUpRootF:setActive(true)
self.xiushiPanel:setActive(false)
self.addOrderPanel:setActive(false)
elseif idx==2 then
self.levelPanelRoot:setActive(false)
self.levelUpRootF:setActive(false)
self.xiushiPanel:setActive(true)
self.addOrderPanel:setActive(true)

self:refreshXiuShiPanel()
self:refreshAddOrderPanel()
end
end
end

function UIXJLittleWorldInfoWin:refreshXiuShiPanel()
local lv=LittleWorldModel:getLittleWorldLevel()
local config=cfgHelper.get(cfg_smallworldlvconfig_get,lv,"population_max")
local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eXiuShiAddLimit)
local xiuShiNum=LittleWorldModel:getXiuShiInfo()or{}
self.xiushiView:setChildLayoutGroupCreateItems(#config)
local grids=self.xiushiView:getChildLayoutGroupGridList()
local nameList=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushi_name")
for i=1,grids.Count do
local grid=grids[i-1]
if xiuShiNum[i]then
local name=nameList[i]
grid:SetChildActive(-1,true)
grid:SetChildText(1,FMT.fmt("{0}\t\t{1}/{2}",name,xiuShiNum[i]or 0,mathHelper.formatNumber4(math.ceil(config[i]*(1+(addVal or 0)/10000)),2)))
else
grid:SetChildActive(-1,false)
end
end
end

function UIXJLittleWorldInfoWin:refreshAddOrderPanel()
local xiushiaddorder=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushiaddorder")
local orderConfig=cfgHelper.get(cfg_smallworldorderconfig_get,xiushiaddorder)
local xhVal=LittleWorldModel:getLittleWorldXianghuo()or 0

local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eFaLingCostChange)
local cost=mathHelper.floor(orderConfig.cost*(1-(addVal/100)))
self.addOrderMoney:setText(FMT.fmt("<color={1}>{0}</color>",cost,xhVal>=cost and"#549327"or"#c82c2c"))
self.addOrderMoneyIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtIncense))
self.addOrderIcon:setImageIcon(FMT.fmt("icon_lw_faling_{0}",orderConfig.icon))
self.addOrderDesc:setText(orderConfig.name)

local unlock_lv=orderConfig.unlock_lv
local lv=LittleWorldModel:getLittleWorldLevel()

local unlock=lv>=unlock_lv

if not unlock then
self.banBuButton:setActive(false)
self.addOrderCDRoot:setActive(true)
self.addOrderCD:setText(FMT.fmt("<color=#f36666>小世界{0}级解锁</color>",unlock_lv))
return
end

local cd=orderConfig.cd_time
local now=timeHelper.getServerShortTime()
local last=LittleWorldModel:getLastFaLingTime(orderConfig.id)
local durtion=orderConfig.durtion
if durtion then
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
if last then
if now-last<=durtion then
self.addOrderCD:setText(FMT.fmt("持续时间：<color=#549327>{0}</color>",timeHelper.format_time_stamp3(durtion-(now-last))))
self.banBuButton:setActive(false)
self.addOrderCDRoot:setActive(true)
self.cdTimer=self:setTimer(1,0,function()
local now=timeHelper.getServerShortTime()
self.addOrderCD:setText(FMT.fmt("持续时间：<color=#549327>{0}</color>",timeHelper.format_time_stamp3(durtion-(now-last))))
if durtion-(now-last)<0 then
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
end
self.cdTimer=nil
self:setCDTimer(last,cd)
end
end)
else
self:setCDTimer(last,cd)
end

end
else
self:setCDTimer(last,cd)
end
end

function UIXJLittleWorldInfoWin:setCDTimer(last,cd)
if cd then
local now=timeHelper.getServerShortTime()
if last and now-last<=cd then
self.addOrderCD:setText(FMT.fmt("冷却时间：<color=#f36666>{0}</color>",timeHelper.format_time_stamp3(cd-(now-last))))
self.banBuButton:setActive(false)
self.addOrderCDRoot:setActive(true)
self.cdTimer=self:setTimer(1,0,function()
local now=timeHelper.getServerShortTime()
self.addOrderCD:setText(FMT.fmt("冷却时间：<color=#f36666>{0}</color>",timeHelper.format_time_stamp3(cd-(now-last))))
if cd-(now-last)<0 then
self.banBuButton:setActive(true)
self.addOrderCDRoot:setActive(false)
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
end
self.cdTimer=nil
end
end)
else
self.banBuButton:setActive(true)
self.addOrderCDRoot:setActive(false)
end
else
self.banBuButton:setActive(true)
self.addOrderCDRoot:setActive(false)
end
end

local detailAttr=
{

[1]={
name="人口",
getNum=function()
return LittleWorldModel:getLittleWorldPopulation()
end,
getMax=function()
local lv=LittleWorldModel:getLittleWorldLevel()
return LittleWorldModel.getPopulationMax(lv)
end,
onHelp=function(self,widget,widgetID)
local lv=LittleWorldModel:getLittleWorldLevel()
local inc=LittleWorldModel.getPopulationAdd(lv)



local extraStrList={FMT.fmt("人口增长：{0}~{1}/年",inc[1],inc[2])}
self:onBtnWieghtRule("littleworld_renkou_%d",widget,widgetID,extraStrList)

end,
checkRed=function(self,widget)
return false
end
},

[2]={
name="香火值",
limit=0,
getNum=function()
return LittleWorldModel:getLittleWorldXianghuo()
end,
getMax=function()
local lv=LittleWorldModel:getLittleWorldLevel()
return LittleWorldModel.getXiaoHuoValMax(lv)
end,
onHelp=function(self,widget,widgetID,this)
local lv=LittleWorldModel:getLittleWorldLevel()
local inc=cfgHelper.get(cfg_smallworldlvconfig_get,lv,"incense_conf")
local pop=LittleWorldModel:getLittleWorldPopulation()
local num=0

for i,v in ipairs(inc[1])do
if v[1][1]<=pop and v[1][2]>=pop then
num=v[2]
end
end
local addValLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eLittleWorldAttrRate)
local addVal=addValLookup[eLittleWorldAttr.xhVal]or 0
addVal=1+(addVal/100)
local zwEffect=LittleWorldModel:getZhenWuAttrEffectById(eLittleWorldAttr.eLittleWorldAttrRate)
addVal=1+(zwEffect/100)




local extraStrList={FMT.fmt("香火值增长：{0}/年",mathHelper.floor(num*addVal))}
self:onBtnWieghtRule("littleworld_xianghuozhi_%d",widget,widgetID,extraStrList)

end,
checkRed=function()
local lv=LittleWorldModel:getLittleWorldLevel()
return LittleWorldModel:getLittleWorldXianghuo()>=LittleWorldModel.getXiaoHuoValMax(lv)
end
},

[3]={
name="稳定度",
getNum=function()
return LittleWorldModel:getLittleWorldStability()
end,
getMax=function()
return LittleWorldModel.getStabilityMax()
end,
onHelp=function(self,widget,widgetID)
self:onBtnWieghtRule("littleworld_wendingdu_%d",widget,widgetID)

end,
checkRed=function()
return LittleWorldModel:getLittleWorldStability()<30
end
},
}


function UIXJLittleWorldInfoWin:refreshPeoplePanel()
self.detailPanel:setChildLayoutGroupCreateItems(#detailAttr,nil)
local childGrids=self.detailPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attrInfo=detailAttr[i]
local checkRed=attrInfo:checkRed()
if checkRed then
childItem:SetChildText(1,FMT.fmt("{0}：<color=#F36666>{1}</color>/{2}",attrInfo.name,mathHelper.formatNumber7(attrInfo:getNum()or 0,0,2),mathHelper.formatNumber4(attrInfo:getMax(),2)))
else
childItem:SetChildText(1,FMT.fmt("{0}：{1}/{2}",attrInfo.name,mathHelper.formatNumber7(attrInfo:getNum()or 0,0,2),mathHelper.formatNumber4(attrInfo:getMax(),2)))
end


if i==2 then
self.xianghuoWarringBtn:setActive(checkRed)
end

childItem:SetChildButtonClick(2,function()attrInfo.onHelp(self,childItem,2,attrInfo)end)
end

self:refreshCostPanel()
self:refreshXiuShiPanel()
end

function UIXJLittleWorldInfoWin:onBtnWieghtRule(name,widget,widgetID,extraStrList,pos,extraLast)
local d={}
d.showType=2
d.pos=pos or Vector2.New(15,30)
d.posWidget=widget
d.posWidgetIndex=widgetID
d.name=name
d.extraLast=extraLast
d.extraStrList=extraStrList
UIManager:showWindow('UIConditionTipsFour',d)
end

function UIXJLittleWorldInfoWin:refreshUpReddot()
local reddot=true
local world_lv=LittleWorldModel:getLittleWorldLevel()
local costConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_costs")
if costConfig then
for i,reward in ipairs(costConfig)do
local have=UIDanYaoModel:getHaveItemCount(reward[1])
if have<reward[2]then
reddot=false
break
end
end
end

local conditionConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_condition")
if conditionConfig then
local pop=LittleWorldModel:getLittleWorldPopulation()
for i,v in ipairs(conditionConfig)do
if v[1]==1 then
if pop<v[2]then
reddot=false
break
end
end
end
end

self.upReddot:setActive(reddot)
end


function UIXJLittleWorldInfoWin:doPunchRotation_Btn(widgetId,btnWidget,index,reddot)
if not self.reddotTweener_BtnList then
self.reddotTweener_BtnList={}
end

if reddot then
if self.reddotTweener_BtnList[widgetId]==nil then
btnWidget:SetChildRotation(index,0,0,0)
local tweener=btnWidget:SetChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_BtnList[widgetId]={}
self.reddotTweener_BtnList[widgetId].tweener=tweener
self.reddotTweener_BtnList[widgetId].cmpIndex=index
self.reddotTweener_BtnList[widgetId].btnWidget=btnWidget
btnWidget:SetChildActive(index,true)
end
else
if self.reddotTweener_BtnList[widgetId]~=nil then
btnWidget:SetChildActive(index,false)
local tweener=self.reddotTweener_BtnList[widgetId].tweener
tweener:Complete()
tweener:Kill()
self.reddotTweener_BtnList[widgetId]=nil
btnWidget:SetChildRotation(index,0,0,0)
end
end
end





function UIXJLittleWorldInfoWin:onDzattrDetailBtn()
local attrLookup=LittleWorldModel:getDiscipleAddAttr_Lookup()

local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UICommonAttrDetailWin'
local extraParams={}
extraParams.attrLookup=attrLookup
args.extraParams=extraParams
self:showWindow('UICommonPageWin',args)
end



function UIXJLittleWorldInfoWin:onFaLingButton()
self:showWindow("UIXJLittleWorldFaLingWin")
end



function UIXJLittleWorldInfoWin:onHelpButton()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIXJLittleWorldInfoWin_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end



function UIXJLittleWorldInfoWin:onTechanDetailBtn()
local level=LittleWorldModel:getLittleWorldLevel()
local rewardList={}
local moneyDrop=LittleWorldModel.get_money_drop_id1(level)
if moneyDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,moneyDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end
local itemDrop=LittleWorldModel.get_item_drop_id1(level)
if itemDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,itemDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end
self:showWindow("UILittleWorldTeChanWin",{detail=rewardList})
end



function UIXJLittleWorldInfoWin:onUpButton()
local world_lv=LittleWorldModel:getLittleWorldLevel()
local costConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_costs")
if costConfig then
for i,reward in ipairs(costConfig)do
local have=UIDanYaoModel:getHaveItemCount(reward[1])
if have<reward[2]then
gainControl:showCommonGainWin_item(reward[1],{needCount=reward[2]})
UIManager.error("所需材料不足")
return
end
end
end

local conditionConfig=cfgHelper.get(cfg_smallworldlvconfig_get,world_lv,"lv_condition")
if conditionConfig then
local pop=LittleWorldModel:getLittleWorldPopulation()
for i,v in ipairs(conditionConfig)do
if v[1]==1 then
if pop<v[2]then
UIManager.error(FMT.fmt("人口不足{0}人",mathHelper.formatNumber4(v[2],2)))
return
end
end
end
end












LittleWorldController.req_37_67()


end



function UIXJLittleWorldInfoWin:onWeixingButton()
UIFullLittleWorldControl:showXingChenMainWindow({playOpen=true})
end




function UIXJLittleWorldInfoWin:onZhenwuButton()
UIFullLittleWorldControl:showZhenWuMainWindow()
end

function UIXJLittleWorldInfoWin:onCloseBtn()
UIFullLittleWorldControl:closeUI()
end

function UIXJLittleWorldInfoWin:onBanBuButton()
local xhVal=LittleWorldModel:getLittleWorldXianghuo()or 0
local xiushiaddorder=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushiaddorder")
local orderConfig=cfgHelper.get(cfg_smallworldorderconfig_get,xiushiaddorder)
local lv=LittleWorldModel:getLittleWorldLevel()

local unlock=lv>=orderConfig.unlock_lv
if not unlock then
UIManager.error(FMT.fmt("小世界{0}级解锁",orderConfig.unlock_lv))
return
end
local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eFaLingCostChange)
local cost=mathHelper.floor(orderConfig.cost*(1-(addVal/100)))
if xhVal>=cost then
LittleWorldController.req_37_70(xiushiaddorder)
else
UIManager.error("香火值不足")
end
end

function UIXJLittleWorldInfoWin:onBaoxiangBtn()
LittleWorldController.req_37_68()
end

function UIXJLittleWorldInfoWin:onAddOrderIcon()
local xiushiaddorder=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushiaddorder")
local desc=cfgHelper.get(cfg_smallworldorderconfig_get,xiushiaddorder,"desc")

self.rulePart:setActive(true)
self.OrderDesc:setText(desc)
end

function UIXJLittleWorldInfoWin:onRulePart()
self.rulePart:setActive(false)
end


function UIXJLittleWorldInfoWin:onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtIncense then
self:onRecvPeople()
end
end

function UIXJLittleWorldInfoWin:onXianghuoWarringBtn()



local extraStrList={}
extraStrList[2]="香火值已满，为避免持续溢出，请<color=#aae252>颁布法令</color>"
extraStrList[1]="小世界达到<color=#aae252>4级</color>可颁布法令"
self:onBtnWieghtRule(nil,self.winid,self.xianghuoWarringBtn:getID(),extraStrList,Vector2.New(5,0))
end

function UIXJLittleWorldInfoWin:onXsTipsButton()
local extraStrList={}
local num=LittleWorldModel:getLittleWorldPopulation()
extraStrList[1]=FMT.fmt("小世界当前人口：<color=#aae252>{0}</color>",mathHelper.formatNumber4(num,2))
local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eXiuShiAddLimit)
extraStrList[2]=FMT.fmt("小世界各等级修士人口上限：{0}",addVal>0 and FMT.fmt("<color=#aae252>+{0}%</color>",addVal/100)or"无")
local addRate=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eXiuShiAddAddRate)
addRate=addRate+(gubaoModel:geteSmallWorldXiuShiAddSpeed()*100)
extraStrList[3]=FMT.fmt("小世界各等级修士增长速率：{0}",addRate>0 and FMT.fmt("<color=#aae252>+{0}%</color>",addRate/100)or"无")
local str="各等级修士人口每次新增："
local lv=LittleWorldModel:getLittleWorldLevel()
local config=cfgHelper.get(cfg_smallworldlvconfig_get,lv,"population")
local list={}
for i,v in ipairs(config)do
for _,vv in ipairs(v[1])do
if num>=vv[1][1]and num<=vv[1][2]then
list[i]=vv[2]
end
end
end
local nameList=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushi_name")
for i,v in ipairs(nameList)do
str=str..FMT.fmt("\n{0}：<color=#aae252>{1}</color>",v,math.floor(list[i]*(1+addRate/10000)))
end
extraStrList[4]=str
self:onBtnWieghtRule("littleworld_xiushi_renkou_%d",self.winid,self.xsTipsButton:getID(),extraStrList,Vector2.New(5,-300),true)
end

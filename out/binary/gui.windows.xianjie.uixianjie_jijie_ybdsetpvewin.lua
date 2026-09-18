







def_class("UIXianJie_JiJie_YBDSetPVEWin",UIWindowBase)









function UIXianJie_JiJie_YBDSetPVEWin:bindComponents()

self.addbtn=UIButton.get(self,0)
self.blackBG=UIObject.get(self,1)
self.btnClose=UIButton.get(self,2)
self.centerpanel=UIObject.get(self,3)
self.changeBtn=UIButton.get(self,4)
self.clickMask=UIButton.get(self,5)
self.emptyItem=UIObject.get(self,6)
self.infoPanel=UIObject.get(self,7)
self.jieXXTypeGroup=UIObject.get(self,8)
self.jijietxt=UIText.get(self,9)
self.lsRewardJoinBtn=UIButton.get(self,10)
self.lsRewardJoinNotSelect=UIImage.get(self,11)
self.lsRewardJoinSelect=UIImage.get(self,12)
self.normalXXTypeGroup=UIObject.get(self,13)
self.pveControllBtn=UIButton.get(self,14)
self.pveControllClose=UIObject.get(self,15)
self.pveControllOpen=UIObject.get(self,16)
self.pveDropdown=UIDropdown.get(self,17)
self.rewardJoinBtn=UIButton.get(self,18)
self.rewardJoinNotSelect=UIImage.get(self,19)
self.rewardJoinSelect=UIImage.get(self,20)
self.ruleBtn=UIButton.get(self,21)
self.saveBtn=UIButton.get(self,22)
self.saveMoneyText=UIText.get(self,23)
self.takeBtn=UIButton.get(self,24)
self.teamItem=UIObject.get(self,25)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.lsRewardJoinBtn:setButtonClick(function()self:onLsRewardJoinBtn()end)

self.pveControllBtn:setButtonClick(function()self:onPveControllBtn()end)

self.rewardJoinBtn:setButtonClick(function()self:onRewardJoinBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.saveBtn:setButtonClick(function()self:onSaveBtn()end)

self.takeBtn:setButtonClick(function()self:onTakeBtn()end)



end


function UIXianJie_JiJie_YBDSetPVEWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.jieXXTypeGroup);self.jieXXTypeGroup=nil;
_UIObject_release(self.jijietxt);self.jijietxt=nil;
_UIObject_release(self.lsRewardJoinBtn);self.lsRewardJoinBtn=nil;
_UIObject_release(self.lsRewardJoinNotSelect);self.lsRewardJoinNotSelect=nil;
_UIObject_release(self.lsRewardJoinSelect);self.lsRewardJoinSelect=nil;
_UIObject_release(self.normalXXTypeGroup);self.normalXXTypeGroup=nil;
_UIObject_release(self.pveControllBtn);self.pveControllBtn=nil;
_UIObject_release(self.pveControllClose);self.pveControllClose=nil;
_UIObject_release(self.pveControllOpen);self.pveControllOpen=nil;
_UIObject_release(self.pveDropdown);self.pveDropdown=nil;
_UIObject_release(self.rewardJoinBtn);self.rewardJoinBtn=nil;
_UIObject_release(self.rewardJoinNotSelect);self.rewardJoinNotSelect=nil;
_UIObject_release(self.rewardJoinSelect);self.rewardJoinSelect=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.saveBtn);self.saveBtn=nil;
_UIObject_release(self.saveMoneyText);self.saveMoneyText=nil;
_UIObject_release(self.takeBtn);self.takeBtn=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
end
















local _this
local pveDropdownName={'1阶及以上','2阶及以上','3阶及以上','4阶及以上','5阶及以上'}
local _teamItemCmpIndex={
bg=0,
stateImg=1,
stateImg2=2,
yzName=3,
teamGrid=4,
soldierBgIcon=5,
soldierNameIcon=6,
soldierNumText=7,
soldierIcon=8,
yzModel=9,
}
local _clickOpenBtnCd=0.5




function UIXianJie_JiJie_YBDSetPVEWin:onLoaded(...)
_this=self
self:bindComponents()
self.pveDropdown:setChangeAction(function(...)self:onPVEDropdownChange(...)end)
end


function UIXianJie_JiJie_YBDSetPVEWin:__delete()
_this=nil
self:closeWindow('UITopMoneyWin2')
self:unbindComponents()
end




function UIXianJie_JiJie_YBDSetPVEWin:onShow(argtable,afterOnloaded)
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
self.parentPage=argtable and argtable.parentPage
self.infoPanel:setChildCanvasGroupAlpha(0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

self.moneyType=eMoneyType.mtXianLing
local ybdMoneyCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ybdMoneyParam')
self.moneyWarnNum=ybdMoneyCfg[1]
self.moneyMaxNum=ybdMoneyCfg[2]

self:showWindow("UITopMoneyWin2",{moneys={{self.moneyType}},offsetX=0,offsetY=-25})

self.normalXXTypeList={
[1]={
id=1,
name="仙墟(仙)",
},
[2]={
id=2,
name="仙墟(魔)",
},
}
self.jieXXTypeList={}
local cfg=cfg_xianguanxianxutypeconfig()
for i,v in ipairs(cfg)do
local item={
id=v.id,
name=v.namestr,
}
self.jieXXTypeList[#self.jieXXTypeList+1]=item
end

self:refresh(true)
end


function UIXianJie_JiJie_YBDSetPVEWin:onHide()

end

function UIXianJie_JiJie_YBDSetPVEWin:refresh(isInit)

self:refreshOpenBtnPanel()


self:refreshTeamPanel()


self:refreshPVECndPanel()


self:refreshMoneyPanel()


self:refreshXianXuPanel(isInit)



end

function UIXianJie_JiJie_YBDSetPVEWin:refreshOpenBtnPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
self.isOpen_PVE=bitHelper.check_pos(openFlag,0)

self.pveControllOpen:setActive(self.isOpen_PVE)
self.pveControllClose:setActive(not self.isOpen_PVE)
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshTeamPanel()
local ybdType=1
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
self.teamItem:setActive(hasYzData)
self.emptyItem:setActive(not hasYzData)
if hasYzData then
local widget=self.teamItem:getWidgetBase()
local yzId=ybdTeamData.yzId
local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and not next(chuZhengDzList)~=nil





local dzList=ybdTeamData.dzList
local dznum=#dzList
widget:SetChildLayoutGroupCreateItems(_teamItemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(_teamItemCmpIndex.teamGrid,index-1)
local dzGuid=dzList[index]
local netData=UIDiscipleModel:getDiscipleData(dzGuid)
local has=netData~=nil
dzItem:SetChildActive(-1,has)
local dzHeadItemWidget=dzItem:GetChildWidgetBase(0)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzHeadItemWidget,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzHeadItemWidget,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

UIDiscipleModel:setDiscipleXianMoHeadImage(dzHeadItemWidget,8,netData)
end
end)


local allSoldierCount=0
local soldierList=ybdTeamData.soldierList
local maxSoldierLevel
if soldierList and next(soldierList)then
for i,money in ipairs(soldierList)do
local moneyType=money[1]
local count=money[2]
if count>0 then
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if not maxSoldierLevel or soldierLevel>maxSoldierLevel then
maxSoldierLevel=soldierLevel
end
allSoldierCount=allSoldierCount+count
end
end
end
local numStr=mathHelper.formatNumber4(allSoldierCount,1)
if allSoldierCount<=0 then
numStr=FMT.cfmt(FONT_COLOR.eRedColor,numStr)
end
self.allSoldierCount=allSoldierCount
widget:SetChildText(_teamItemCmpIndex.soldierNumText,numStr)
local isShowSoldierIcon=maxSoldierLevel~=nil
widget:SetChildActive(_teamItemCmpIndex.soldierIcon,isShowSoldierIcon)
if isShowSoldierIcon then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_teamItemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_teamItemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


local yzModelId=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'defaultBoatModelId')
widget:SetChildUIModelShowTarget(_teamItemCmpIndex.yzModel,yzModelId,0.4,nil,eAnimationID.stand)
end
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshPVECndPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local stageNameList=self:getStageNameList()
self.pveDropdown:setOption(stageNameList)
self.monsterStage=ybdData and ybdData.pveCnd and ybdData.pveCnd.monsterStage or 3
self.pveDropdown:setValue(self.monsterStage-1)
end

function UIXianJie_JiJie_YBDSetPVEWin:getStageNameList()
local monsterType=xjServerEnityType.eMonsterHouse
local min,max=xianjieController:getMonsterMaxlevel(monsterType)
local list={}
for i=min,max do
list[i]=FMT.fmt("{0}阶及以上",i)
end
return list
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshMoneyPanel()
local ybdData=xianjieModel:getJiJieYBDData()
self.ybdMoneyNum=ybdData and ybdData.moneyNum or 0
local moneyName=moneyModel.getMoneyName(self.moneyType)
local str=FMT.fmt("目前预备队可用{0}：",moneyName)
if self.ybdMoneyNum<self.moneyWarnNum then
str=FMT.fmt("{0}<color=#c82c2c>{1}</color>",str,self.ybdMoneyNum)
else
str=FMT.fmt("{0}<color=#549327>{1}</color>",str,self.ybdMoneyNum)
end
self.saveMoneyText:setText(str)
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshRewardJoinFlag()
local ybdData=xianjieModel:getJiJieYBDData()
self.rewardJoinFlag=ybdData and ybdData.rewardJoinFlag or 0
local isNotJoin=self.rewardJoinFlag==1
self.rewardJoinSelect:setActive(isNotJoin)
self.rewardJoinNotSelect:setActive(not isNotJoin)
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshLSRewardJoinFlag()
local ybdData=xianjieModel:getJiJieYBDData()
self.lsRewardJoinFlag=ybdData and ybdData.lsRewardJoinFlag or 0
local isNotJoin=self.lsRewardJoinFlag==1
self.lsRewardJoinSelect:setActive(isNotJoin)
self.lsRewardJoinNotSelect:setActive(not isNotJoin)
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshXianXuPanel(isInit)

self:refreshRewardJoinFlag()

self:refreshLSRewardJoinFlag()


self:refreshNormalXXTypePanel(isInit)


self:refreshJieXXTypePanel(isInit)
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshNormalXXTypePanel(isInit)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
if isInit then
self.normalXXTypeGroup:setChildLayoutGroupCreateItems(#self.normalXXTypeList,function(index)
local item=self.normalXXTypeGroup:getChildLayoutGroupGridItem(index-1)
local cfg=self.normalXXTypeList[index]
if cfg then
item:SetChildActive(-1,true)

local name=cfg.name
item:SetChildText(0,name)

local id=cfg.id

item:SetChildButtonClick(1,function()
return self:onClickNormalXXTypeItem(id)
end)


local isRejected=rejectedNormalXXList[id]or false
item:SetChildActive(2,isRejected)
item:SetChildActive(3,not isRejected)
else
item:SetChildActive(-1,false)
end
end)
else
local grids=self.normalXXTypeGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local cfg=self.normalXXTypeList[index]
if cfg then

local id=cfg.id
local isRejected=rejectedNormalXXList[id]or false
item:SetChildActive(2,isRejected)
item:SetChildActive(3,not isRejected)
end
end
end
end

function UIXianJie_JiJie_YBDSetPVEWin:refreshJieXXTypePanel(isInit)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
if isInit then
self.jieXXTypeGroup:setChildLayoutGroupCreateItems(#self.jieXXTypeList,function(index)
local item=self.jieXXTypeGroup:getChildLayoutGroupGridItem(index-1)
local cfg=self.jieXXTypeList[index]
if cfg then
item:SetChildActive(-1,true)

local name=cfg.name
item:SetChildText(0,name)

local id=cfg.id

item:SetChildButtonClick(1,function()
return self:onClickJieXXTypeItem(id)
end)


local isRejected=rejectedJieXXList[id]or false
item:SetChildActive(2,isRejected)
item:SetChildActive(3,not isRejected)
else
item:SetChildActive(-1,false)
end
end)
else
local grids=self.jieXXTypeGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local cfg=self.jieXXTypeList[index]
if cfg then

local id=cfg.id
local isRejected=rejectedJieXXList[id]or false
item:SetChildActive(2,isRejected)
item:SetChildActive(3,not isRejected)
end
end
end
end




function UIXianJie_JiJie_YBDSetPVEWin:onPveControllBtn()
local nowTime=gameUtilityModel.getServerShortTime2()
if self.clickOpenBtnStamp and nowTime-self.clickOpenBtnStamp<_clickOpenBtnCd then
UIManager.error("点击过快，请稍后再试")
return
end
self.clickOpenBtnStamp=nowTime

local ybdData=xianjieModel:getJiJieYBDData()
local ybdType=1
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
if not hasYzData then
UIManager.error("请先设置预备队")
return
end

local openFlag=ybdData and ybdData.openFlag or 0
if self.isOpen_PVE then
openFlag=bitHelper.set_0(openFlag,0)
else
openFlag=bitHelper.set_1(openFlag,0)
end
xianjieController:reqMassYBDChangeOpenFlag(openFlag)
end



function UIXianJie_JiJie_YBDSetPVEWin:onClickMask()
end



function UIXianJie_JiJie_YBDSetPVEWin:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end



function UIXianJie_JiJie_YBDSetPVEWin:onSaveBtn()

local money_ybd=self.ybdMoneyNum
local money_self=moneyModel.getMoney(self.moneyType)
if money_self<=0 then
gainControl:showGainWin(self.moneyType)
return
end
local moneyName=moneyModel.getMoneyName(self.moneyType)
if money_ybd>=self.moneyMaxNum then
UIManager.info(FMT.fmt("预备队{0}存储已达上限",moneyName))
return
end

local costnum=1
local refresh=function(num)
return""
end
local maxNeedNum=self.moneyMaxNum-money_ybd
local maxLimitNum=math.min(money_self,maxNeedNum)
local color1=money_self>=self.moneyWarnNum and"#549327"or"#c82c2c"
local color2=money_ybd>=self.moneyWarnNum and"#549327"or"#c82c2c"

local tipContent=FMT.fmt("目前祖师拥有的{0}: <color={1}>{2}</color>",moneyName,color1,money_self)
local tipContent2=FMT.fmt("目前预备队可用{0}: <color={1}>{2}</color>",moneyName,color2,money_ybd)
local tipContent3=FMT.fmt("请选择存入给预备队用的{0}数量：",moneyName)

local show_data={
type='UIDialougeKuFangCount',
title=FMT.fmt('存入{0}',moneyName),
refreshcallback=refresh,
max=maxLimitNum,
tips=" ",
tips2=" ",
tips3=" ",
paneltipsa="",
paneltipsb=tipContent2,
paneltipsc=tipContent3,
oktext='存入',
canceltext='取消',
tipContent="",
singlenum=costnum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local addNum=costnum*num
local ybdData=xianjieModel:getJiJieYBDData()
local originalMoneyNum=ybdData and ybdData.moneyNum or 0
local newMoneyNum=originalMoneyNum+addNum
xianjieController:reqMassYBDMoneyAndSoldierSave(newMoneyNum)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIXianJie_JiJie_YBDSetPVEWin:onTakeBtn()

local money_ybd=self.ybdMoneyNum
local money_self=moneyModel.getMoney(self.moneyType)
local moneyName=moneyModel.getMoneyName(self.moneyType)
if money_ybd<=0 then
UIManager.info(FMT.fmt("预存的{0}不足，无法取出",moneyName))
return
end

local costnum=1
local refresh=function(num)
return""
end


local moneyLimit=moneyModel.getMoneyMaxCountByID_Custom(self.moneyType)
local remain=moneyLimit-money_self
local amount=moneyLimit==nil and money_ybd or remain

if moneyLimit~=nil and amount==0 then
local tipsTex=FMT.fmt("{0}已达到上限，无法取出",moneyName)
UIManager.error(tipsTex)
return
end

local maxLimitNum=math.min(amount,money_ybd)
local color1=money_self>=self.moneyWarnNum and"#549327"or"#c82c2c"
local color2=money_ybd>=self.moneyWarnNum and"#549327"or"#c82c2c"

local tipContent=FMT.fmt("目前祖师拥有的{0}: <color={1}>{2}</color>",moneyName,color1,money_self)
local tipContent2=FMT.fmt("目前预备队可用{0}: <color={1}>{2}</color>",moneyName,color2,money_ybd)
local tipContent3=FMT.fmt("请选择取出预存{0}数量：",moneyName)

local show_data={
type='UIDialougeKuFangCount',
title=FMT.fmt('取出{0}',moneyName),
refreshcallback=refresh,
max=maxLimitNum,
tips=" ",
tips2=" ",
tips3=" ",
paneltipsa="",
paneltipsb=tipContent2,
paneltipsc=tipContent3,
oktext='取出',
canceltext='取消',
tipContent="",
singlenum=costnum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local subNum=costnum*num
local ybdData=xianjieModel:getJiJieYBDData()
local originalMoneyNum=ybdData and ybdData.moneyNum or 0
local newMoneyNum=originalMoneyNum-subNum
xianjieController:reqMassYBDMoneyAndSoldierSave(newMoneyNum)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIXianJie_JiJie_YBDSetPVEWin:onAddbtn()

local extraCost={}
local func=function(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={moneyType,moneyCount}
end

local ybdType=1
local teamData={
yzId,
#dzList,
dzList,
#soldierList,
soldierList,
}
xianjieController:reqMassYBDTeamChange(ybdType,teamData)
end
local parentPage=self.parentPage
local page=self.page
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
orderType=xjOrderType.eJiJieJoin,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
minSoldierNum=1,
isYBDSet=true,
confirmBtnStr="设置预备队",
cancelCallBack=function()
UIManager:showWindow('UIXianJie_JiJie_teamListBgWin',{page=parentPage,extraArgs={isOpenYBDPage=page}})
end,
})
end



function UIXianJie_JiJie_YBDSetPVEWin:onChangeBtn()

local ybdType=1
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
local soldierList=ybdTeamData and ybdTeamData.soldierList
local selectYzIndex=ybdTeamData and ybdTeamData.yzId
local defaultSoldierList
if soldierList and next(soldierList)then
defaultSoldierList={}
for i,v in ipairs(soldierList)do
local moneyType=v[1]
local moneyCount=v[2]
local soldierIdx=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if defaultSoldierList[soldierIdx]then
defaultSoldierList[soldierIdx]=defaultSoldierList[soldierIdx]+moneyCount
else
defaultSoldierList[soldierIdx]=moneyCount
end
end
end
local dzList=ybdTeamData and ybdTeamData.dzList
local extraCost={}
local func=function(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={moneyType,moneyCount}
end

local teamData={
yzId,
#dzList,
dzList,
#soldierList,
soldierList,
}
xianjieController:reqMassYBDTeamChange(ybdType,teamData)
end
local parentPage=self.parentPage
local page=self.page
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
defaultSoldierList=defaultSoldierList,
defaultDzList=dzList,

orderType=xjOrderType.eJiJieJoin,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
minSoldierNum=1,
selectYzIndex=selectYzIndex,
isYBDSet=true,
confirmBtnStr="设置预备队",
cancelCallBack=function()
UIManager:showWindow('UIXianJie_JiJie_teamListBgWin',{page=parentPage,extraArgs={isOpenYBDPage=page}})
end,
})
end

function UIXianJie_JiJie_YBDSetPVEWin:onPVEDropdownChange(idx)
idx=idx+1
self.monsterStage=idx






local ybdData=xianjieModel:getJiJieYBDData()
local rewardJoinFlag=ybdData and ybdData.rewardJoinFlag or 0
local lsRewardJoinFlag=ybdData and ybdData.lsRewardJoinFlag or 0
xianjieController:reqMassYBDSetPveCnd_pveChange(self.monsterStage,rewardJoinFlag,lsRewardJoinFlag)
end


function UIXianJie_JiJie_YBDSetPVEWin:onRewardJoinBtn()

local ybdData=xianjieModel:getJiJieYBDData()
local isNotJoin=self.rewardJoinFlag==1
local newFlag=isNotJoin and 0 or 1
local lsRewardJoinFlag=ybdData and ybdData.lsRewardJoinFlag or 0
xianjieController:reqMassYBDSetPveCnd_pveChange(self.monsterStage,newFlag,lsRewardJoinFlag)
end

function UIXianJie_JiJie_YBDSetPVEWin:onLsRewardJoinBtn()

local ybdData=xianjieModel:getJiJieYBDData()
local isNotJoin=self.lsRewardJoinFlag==1
local newFlag=isNotJoin and 0 or 1
local rewardJoinFlag=ybdData and ybdData.rewardJoinFlag or 0
xianjieController:reqMassYBDSetPveCnd_pveChange(self.monsterStage,rewardJoinFlag,newFlag)
end

function UIXianJie_JiJie_YBDSetPVEWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eYBDRule
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UIXianJie_JiJie_YBDSetPVEWin:onXianxuSettingBtn()
local args={}
args.posItem=self.xianxuSettingBtn
args.pos=Vector2.New(0,-35)
self:showWindow('UIXianJie_JiJie_YBDSet_xxSubWin',args)
end

function UIXianJie_JiJie_YBDSetPVEWin:onClickNormalXXTypeItem(id)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
local isRejected=rejectedNormalXXList[id]or false
rejectedNormalXXList[id]=not isRejected
local xmList={}
for id,flag in pairs(rejectedNormalXXList)do
if flag then
xmList[#xmList+1]=id
end
end

local xgList={}
for xgtType,flag in pairs(rejectedJieXXList)do
if flag then
xgList[#xgList+1]=xgtType
end
end
xianjieController:reqMassYBDSetXianXuRejectedList(xmList,xgList)
end

function UIXianJie_JiJie_YBDSetPVEWin:onClickJieXXTypeItem(id)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
local isRejected=rejectedJieXXList[id]or false
rejectedJieXXList[id]=not isRejected

local xmList={}
for id,flag in pairs(rejectedNormalXXList)do
if flag then
xmList[#xmList+1]=id
end
end

local xgList={}
for xgtType,flag in pairs(rejectedJieXXList)do
if flag then
xgList[#xgList+1]=xgtType
end
end
xianjieController:reqMassYBDSetXianXuRejectedList(xmList,xgList)
end
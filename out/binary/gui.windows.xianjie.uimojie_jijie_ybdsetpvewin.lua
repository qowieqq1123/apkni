







def_class("UIMoJie_JiJie_YBDSetPVEWin",UIWindowBase)









function UIMoJie_JiJie_YBDSetPVEWin:bindComponents()

self.addbtn=UIButton.get(self,0)
self.blackBG=UIObject.get(self,1)
self.btnClose=UIButton.get(self,2)
self.centerpanel=UIObject.get(self,3)
self.changeBtn=UIButton.get(self,4)
self.clickMask=UIButton.get(self,5)
self.emptyItem=UIObject.get(self,6)
self.infoPanel=UIObject.get(self,7)
self.jijietxt=UIText.get(self,8)
self.pveControllBtn=UIButton.get(self,9)
self.pveControllClose=UIObject.get(self,10)
self.pveControllOpen=UIObject.get(self,11)
self.ruleBtn=UIButton.get(self,12)
self.saveBtn=UIButton.get(self,13)
self.saveMoneyTex=UIText.get(self,14)
self.selfXMChildGroup=UIObject.get(self,15)
self.takeBtn=UIButton.get(self,16)
self.teamItem=UIObject.get(self,17)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.pveControllBtn:setButtonClick(function()self:onPveControllBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.saveBtn:setButtonClick(function()self:onSaveBtn()end)

self.takeBtn:setButtonClick(function()self:onTakeBtn()end)



end


function UIMoJie_JiJie_YBDSetPVEWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.jijietxt);self.jijietxt=nil;
_UIObject_release(self.pveControllBtn);self.pveControllBtn=nil;
_UIObject_release(self.pveControllClose);self.pveControllClose=nil;
_UIObject_release(self.pveControllOpen);self.pveControllOpen=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.saveBtn);self.saveBtn=nil;
_UIObject_release(self.saveMoneyTex);self.saveMoneyTex=nil;
_UIObject_release(self.selfXMChildGroup);self.selfXMChildGroup=nil;
_UIObject_release(self.takeBtn);self.takeBtn=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
end
















local _this
local _storedMoneyType=eMoneyType.mtMoLing
local _clickOpenBtnCd=0.5

local _ybdTeamItemCmpIndex={
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


local _xMPositionItemCmpIndex={
name=0,
toggle=1,
tick=2,
clickMask=3,
}




function UIMoJie_JiJie_YBDSetPVEWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJie_JiJie_YBDSetPVEWin:__delete()
self:unbindComponents()
end




function UIMoJie_JiJie_YBDSetPVEWin:onShow(argtable,afterOnloaded)
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
self.parentPage=argtable and argtable.parentPage
self.infoPanel:setChildCanvasGroupAlpha(0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)


local ybdMoneyCfg=cfgHelper.get2(cfg_devildombaseconfig_get,1,'ybdMoneyParam')
self.ybdMoneyWarnNum=ybdMoneyCfg[1]
self.ybdMoneyMaxNum=ybdMoneyCfg[2]
self:showWindow("UITopMoneyWin2",{moneys={{_storedMoneyType}},offsetX=0,offsetY=-25})

self:refreshView()
end


function UIMoJie_JiJie_YBDSetPVEWin:onHide()

end





function UIMoJie_JiJie_YBDSetPVEWin:onAddbtn()
local callback=self.onYbdEditResultCallback

local parentPage=self.parentPage
local page=self.page
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=callback,
extraCost={},
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


function UIMoJie_JiJie_YBDSetPVEWin:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end


function UIMoJie_JiJie_YBDSetPVEWin:onChangeBtn()

local ybdType=eYbdType.MoJieYbd
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
local callback=self.onYbdEditResultCallback

local parentPage=self.parentPage
local page=self.page
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=callback,
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


function UIMoJie_JiJie_YBDSetPVEWin:onClickMask()
end


function UIMoJie_JiJie_YBDSetPVEWin:onPveControllBtn()
local nowTime=gameUtilityModel.getServerShortTime2()
if self.clickOpenBtnStamp and nowTime-self.clickOpenBtnStamp<_clickOpenBtnCd then
UIManager.error("点击过快，请稍后再试")
return
end
self.clickOpenBtnStamp=nowTime

local ybdData=xianjieModel:getJiJieYBDData()
local ybdType=eYbdType.MoJieYbd
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
if not hasYzData then
UIManager.error("请先设置预备队")
return
end

local openFlag=ybdData and ybdData.openFlag or 0
if self.moJieYBDEnable then
openFlag=bitHelper.set_0(openFlag,2)
else
openFlag=bitHelper.set_1(openFlag,2)
end
xianjieController:reqMassYBDChangeOpenFlag(openFlag)
end


function UIMoJie_JiJie_YBDSetPVEWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_devildombaseconfig_get,1,'jiJieYbdRuleDescLang')
local langId=ruleLangIdList and ruleLangIdList[1]or nil
if langId then
self:showWindow("UIRuleWin",{
title="规则",
mode=3,
name=langId
})
end
end


function UIMoJie_JiJie_YBDSetPVEWin:onSaveBtn()
local storedMoneyAmount=self.ybdStoredMoneyAmount
local myMoneyAmount=moneyModel.getMoney(_storedMoneyType)
if myMoneyAmount<=0 then
gainControl:showGainWin(_storedMoneyType)
return
end

local moneyName=moneyModel.getMoneyName(_storedMoneyType)
if storedMoneyAmount>=self.ybdMoneyMaxNum then
UIManager.info(FMT.fmt("预备队{0}存储已达上限",moneyName))
return
end

local costNum=1
local refresh=function(num)
return""
end
local maxNeedNum=self.ybdMoneyMaxNum-storedMoneyAmount
local maxLimitNum=math.min(myMoneyAmount,maxNeedNum)
local ybdMoneyNumTextColor=storedMoneyAmount>=self.ybdMoneyWarnNum and"#549327"or"#c82c2c"

local tipContent2=FMT.fmt("目前预备队可用{0}: <color={1}>{2}</color>",moneyName,ybdMoneyNumTextColor,storedMoneyAmount)
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
singlenum=costNum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local addNum=costNum*num
local ybdData=xianjieModel:getJiJieYBDData()
local originalMoneyNum=ybdData and ybdData.molingCnt or 0
local newMoneyNum=originalMoneyNum+addNum
xianjieController:reqMoJieMassYBDMoneyAndSoldierSave(newMoneyNum)

end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function UIMoJie_JiJie_YBDSetPVEWin:onTakeBtn()

local storedMoneyAmount=self.ybdStoredMoneyAmount
local myMoneyAmount=moneyModel.getMoney(_storedMoneyType)
local moneyName=moneyModel.getMoneyName(_storedMoneyType)
if storedMoneyAmount<=0 then
UIManager.info(FMT.fmt("预存的{0}不足，无法取出",moneyName))
return
end

local costNum=1
local refresh=function(num)
return""
end


local moneyLimit=moneyModel.getMoneyMaxCountByID_Custom(_storedMoneyType)
local remain=moneyLimit-myMoneyAmount
local amount=moneyLimit==nil and storedMoneyAmount or remain

if moneyLimit~=nil and amount==0 then
local tipsTex=FMT.fmt("{0}已达到上限，无法取出",moneyName)
UIManager.error(tipsTex)
return
end

local maxLimitNum=math.min(amount,storedMoneyAmount)
local ybdMoneyTexColor=storedMoneyAmount>=self.ybdMoneyWarnNum and"#549327"or"#c82c2c"

local tipContent2=FMT.fmt("目前预备队可用{0}: <color={1}>{2}</color>",moneyName,ybdMoneyTexColor,storedMoneyAmount)
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
singlenum=costNum or 1,
sliderRootposY=-55,
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local subNum=costNum*num
local ybdData=xianjieModel:getJiJieYBDData()
local originalMoneyNum=ybdData and ybdData.molingCnt or 0
local newMoneyNum=originalMoneyNum-subNum
xianjieController:reqMoJieMassYBDMoneyAndSoldierSave(newMoneyNum)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshView()

self:initXMPositionPermissionList()

self:refreshYBDSwitchBtnView()

self:refreshYBDTeamInfoView()

self:refreshStoredMoneyView()

self:refreshXMMemberJiJieView()
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshYBDSwitchBtnView()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
self.moJieYBDEnable=bitHelper.check_pos(openFlag,2)

self.pveControllOpen:setActive(self.moJieYBDEnable)
self.pveControllClose:setActive(not self.moJieYBDEnable)
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshYBDTeamInfoView()
local ybdType=eYbdType.MoJieYbd
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)

self.hasYBDTeamDisplayable=ybdTeamData and ybdTeamData.yzId~=nil or false
self.teamItem:setActive(self.hasYBDTeamDisplayable)
self.emptyItem:setActive(not self.hasYBDTeamDisplayable)


if not self.hasYBDTeamDisplayable then
return
end

local widget=self.teamItem:getWidgetBase()

local dzList=ybdTeamData.dzList
local dznum=#dzList
widget:SetChildLayoutGroupCreateItems(_ybdTeamItemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(_ybdTeamItemCmpIndex.teamGrid,index-1)
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
widget:SetChildText(_ybdTeamItemCmpIndex.soldierNumText,numStr)
local isShowSoldierIcon=maxSoldierLevel~=nil
widget:SetChildActive(_ybdTeamItemCmpIndex.soldierIcon,isShowSoldierIcon)
if isShowSoldierIcon then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_ybdTeamItemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_ybdTeamItemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


local yzModelId=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'defaultBoatModelId')
widget:SetChildUIModelShowTarget(_ybdTeamItemCmpIndex.yzModel,yzModelId,0.4,nil,eAnimationID.stand)
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshStoredMoneyView()
local ybdData=xianjieModel:getJiJieYBDData()

self.ybdStoredMoneyAmount=ybdData and ybdData.molingCnt or 0
local moneyName=moneyModel.getMoneyName(_storedMoneyType)
local displayContent=FMT.fmt("目前预备队可用{0}：<color={2}>{1}</color>",
moneyName,
self.ybdStoredMoneyAmount,
self.ybdStoredMoneyAmount<self.ybdMoneyWarnNum and"#c82c2c"or"#549327")
self.saveMoneyTex:setText(displayContent)
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshXMMemberJiJieView()
local gridList=self.selfXMChildGroup:getChildLayoutGroupGridList()
if gridList and gridList.Count>0 then
for index=1,gridList.Count do
local widget=gridList[index-1]
self:refreshXMMemberJiJieOptionItem(widget,index,false)
end
else
self.xMPositionList=self:getXMPositionInfoList()
self.selfXMChildGroup:setChildLayoutGroupCreateItems(#self.xMPositionList,function(index)
local widget=self.selfXMChildGroup:getChildLayoutGroupGridItem(index-1)
self:refreshXMMemberJiJieOptionItem(widget,index,true)
end)
end
end

function UIMoJie_JiJie_YBDSetPVEWin:refreshXMMemberJiJieOptionItem(widget,index,isInit)
local xMPositionCfg=self.xMPositionList[index]
if not xMPositionCfg then
widget:SetChildActive(-1,false)
else
widget:SetChildActive(-1,true)
local canChange=xMPositionCfg.isCanChange
widget:SetChildActive(_xMPositionItemCmpIndex.clickMask,not canChange)
widget:SetChildActive(_xMPositionItemCmpIndex.tick,not canChange)
widget:SetChildActive(_xMPositionItemCmpIndex.toggle,canChange)
local positionName=xMPositionCfg.name
if canChange then
local isAllowed=self.xMPositionPermissionList and self.xMPositionPermissionList[index]or false
widget:SetChildToggle(_xMPositionItemCmpIndex.toggle,isAllowed)
if isInit then
widget:SetChildToggleChange(_xMPositionItemCmpIndex.toggle,function(name,isOn)
if not _this then return end
return _this:onXMPositionPermissionToggleChange(index,isOn)
end)

widget:SetChildButtonClick(_xMPositionItemCmpIndex.clickMask,function(name,isOn)
return
end,true)
end
else
positionName=FMT.cfmt(FONT_COLOR.eNomalGrayColor,positionName)
widget:SetChildButtonClick(_xMPositionItemCmpIndex.clickMask,function(name,isOn)
return UIManager.error("盟主和副盟主无法取消权限")
end,true)
end


widget:SetChildText(_xMPositionItemCmpIndex.name,positionName)
end
end

function UIMoJie_JiJie_YBDSetPVEWin:getXMPositionInfoList()

local allPositionCfg=cfg_guildpositionconfig()
local selectablePositions={}
for i,cfg in ipairs(allPositionCfg)do
local postId=cfg.id
local privilege=cfg.privilege
local isCanChange=true
if privilege and privilege[GUILD_PRIVILE_TYPE.gptFLInvite]then
isCanChange=false
end

selectablePositions[#selectablePositions+1]={
postId=postId,
name=cfg.name,
isCanChange=isCanChange,
}
end

return selectablePositions
end

function UIMoJie_JiJie_YBDSetPVEWin:initXMPositionPermissionList()
local ybdData=xianjieModel:getJiJieYBDData()
local permissionList=ybdData.postList[eYbdType.MoJieYbd]or{}
if not permissionList then
return
end

local optionList=self:getXMPositionInfoList()
self.xMPositionPermissionList={}
for i,v in ipairs(optionList)do
local posId=v.postId
local isAllow=permissionList[posId]
if isAllow then
self.xMPositionPermissionList[i]=isAllow
end
end
end

function UIMoJie_JiJie_YBDSetPVEWin:onXMPositionPermissionToggleChange(index,isOn)
self.xMPositionPermissionList[index]=isOn

local flagList={}
if self.xMPositionPermissionList then
for pos,flag in pairs(self.xMPositionPermissionList)do
if flag then
flagList[#flagList+1]=pos
end
end
end

xianjieController:reqMassYBDSetPostLimitList(eYbdType.MoJieYbd,flagList)
end


function UIMoJie_JiJie_YBDSetPVEWin.onYbdEditResultCallback(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={
moneyType,
moneyCount
}
end
local ybdType=eYbdType.MoJieYbd
local teamData={
yzId,
#dzList,
dzList,
#soldierList,
soldierList,
}
xianjieController:reqMassYBDTeamChange(ybdType,teamData)
end
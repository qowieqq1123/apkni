







def_class("UIXianJie_JiJie_YBDSetPVPWin",UIWindowBase)









function UIXianJie_JiJie_YBDSetPVPWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.clickMask=UIButton.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)
self.centerpanel=UIObject.get(self,4)
self.jijietxt=UIText.get(self,5)
self.teamItem=UIObject.get(self,6)
self.emptyItem=UIObject.get(self,7)
self.addbtn=UIButton.get(self,8)
self.changeBtn=UIButton.get(self,9)
self.pvpControllBtn=UIButton.get(self,10)
self.pvpControllClose=UIObject.get(self,11)
self.pvpControllOpen=UIObject.get(self,12)
self.selfXMChildGroup=UIObject.get(self,13)
self.ruleBtn=UIButton.get(self,14)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.pvpControllBtn:setButtonClick(function()self:onPvpControllBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIXianJie_JiJie_YBDSetPVPWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.jijietxt);self.jijietxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.pvpControllBtn);self.pvpControllBtn=nil;
_UIObject_release(self.pvpControllClose);self.pvpControllClose=nil;
_UIObject_release(self.pvpControllOpen);self.pvpControllOpen=nil;
_UIObject_release(self.selfXMChildGroup);self.selfXMChildGroup=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
end
















local _this
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
local _itemCmpIndex={
name=0,
toggle=1,
tick=2,
clickMask=3,
}
local _clickOpenBtnCd=0.5




function UIXianJie_JiJie_YBDSetPVPWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_YBDSetPVPWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_JiJie_YBDSetPVPWin:onShow(argtable,afterOnloaded)
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
self.parentPage=argtable and argtable.parentPage
self.infoPanel:setChildCanvasGroupAlpha(0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

self:refresh(true)
end


function UIXianJie_JiJie_YBDSetPVPWin:onHide()

end

function UIXianJie_JiJie_YBDSetPVPWin:refresh(isInit)

self:refreshOpenBtnPanel()


self:refreshTeamPanel()


self:refreshPVPCndPanel(isInit)
end

function UIXianJie_JiJie_YBDSetPVPWin:refreshOpenBtnPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
self.isOpen_PVP=bitHelper.check_pos(openFlag,1)

self.pvpControllOpen:setActive(self.isOpen_PVP)
self.pvpControllClose:setActive(not self.isOpen_PVP)
end

function UIXianJie_JiJie_YBDSetPVPWin:refreshTeamPanel()
local ybdType=2
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


function UIXianJie_JiJie_YBDSetPVPWin:refreshPVPCndPanel(isInit)

if isInit then
self:initSelfXMSelectList()
end
self:refreshSelfXMPanel(isInit)


end


function UIXianJie_JiJie_YBDSetPVPWin:refreshSelfXMPanel(isInit)
local optionList=self:getXMPostList()
if isInit then
self.selfXMChildGroup:setChildLayoutGroupCreateItems(#optionList,function(index)
local widget=self.selfXMChildGroup:getChildLayoutGroupGridItem(index-1)
self:refreshSelfXMOptionItem(widget,index,isInit)
end)
else
local grids=self.selfXMChildGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshSelfXMOptionItem(widget,i,isInit)
end
end
end

function UIXianJie_JiJie_YBDSetPVPWin:refreshSelfXMOptionItem(widget,index,isInit)
local optionList=self:getXMPostList()
local optionCfg=optionList[index]
if optionCfg then
widget:SetChildActive(-1,true)
local isCanChange=optionCfg.isCanChange
widget:SetChildActive(_itemCmpIndex.clickMask,not isCanChange)
widget:SetChildActive(_itemCmpIndex.tick,not isCanChange)
widget:SetChildActive(_itemCmpIndex.toggle,isCanChange)
local nameStr=optionCfg.name
if isCanChange then

local isSelect=self.selectList and self.selectList[index]or false
widget:SetChildToggle(_itemCmpIndex.toggle,isSelect)
if isInit then
widget:SetChildToggleChange(_itemCmpIndex.toggle,function(name,isOn)
if not _this then return end
return self:onSelfXMOptionToggleChange(index,isOn)
end)

widget:SetChildButtonClick(_itemCmpIndex.clickMask,function(name,isOn)
return
end,true)

end
else
nameStr=FMT.cfmt(FONT_COLOR.eNomalGrayColor,nameStr)
widget:SetChildButtonClick(_itemCmpIndex.clickMask,function(name,isOn)
return UIManager.error("盟主和副盟主无法取消权限")
end,true)
end


widget:SetChildText(_itemCmpIndex.name,nameStr)
else
widget:SetChildActive(-1,false)
end
end

function UIXianJie_JiJie_YBDSetPVPWin:getXMPostList()
if self.selectPostList then
return self.selectPostList
end

local allPostCfg=cfg_guildpositionconfig()
local selectPostList={}
for i,cfg in ipairs(allPostCfg)do
local postId=cfg.id
local privilege=cfg.privilege
local isCanChange=true
if privilege and privilege[GUILD_PRIVILE_TYPE.gptFLInvite]then
isCanChange=false
end

selectPostList[#selectPostList+1]={
postId=postId,
name=cfg.name,
isCanChange=isCanChange,
}
end

self.selectPostList=selectPostList
return self.selectPostList
end

function UIXianJie_JiJie_YBDSetPVPWin:initSelfXMSelectList()
local ybdData=xianjieModel:getJiJieYBDData()
local postSelectList=ybdData.postList or{}
postSelectList=postSelectList[eYbdType.ZhanZhengYbd]
if not postSelectList then
return
end
local optionList=self:getXMPostList()
self.selectList={}
for i,v in ipairs(optionList)do
local posId=v.postId
local isSelect=postSelectList[posId]
if isSelect then
self.selectList[i]=isSelect
end
end
end




function UIXianJie_JiJie_YBDSetPVPWin:onClickMask()
end



function UIXianJie_JiJie_YBDSetPVPWin:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end



function UIXianJie_JiJie_YBDSetPVPWin:onAddbtn()

local extraCost={}
local func=function(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={moneyType,moneyCount}
end

local ybdType=2
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



function UIXianJie_JiJie_YBDSetPVPWin:onChangeBtn()

local ybdType=2
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



function UIXianJie_JiJie_YBDSetPVPWin:onPvpControllBtn()

local func=function()
local nowTime=gameUtilityModel.getServerShortTime2()
if self.clickOpenBtnStamp and nowTime-self.clickOpenBtnStamp<_clickOpenBtnCd then
UIManager.error("点击过快，请稍后再试")
return
end
self.clickOpenBtnStamp=nowTime

local ybdData=xianjieModel:getJiJieYBDData()
local ybdType=2
local ybdTeamData=xianjieModel:getJiJieYBDData_teamDataByYBDType(ybdType)
local hasYzData=ybdTeamData and ybdTeamData.yzId~=nil or false
if not hasYzData then
UIManager.error("请先设置预备队")
return
end

local openFlag=ybdData and ybdData.openFlag or 0
if self.isOpen_PVP then
openFlag=bitHelper.set_0(openFlag,1)
else
openFlag=bitHelper.set_1(openFlag,1)
end
xianjieController:reqMassYBDChangeOpenFlag(openFlag)
end
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local hasOpen=bitHelper.check_pos(openFlag,1)
if tianshudazhenModel:isOpeningFHZ()and not hasOpen then
local desc='参与战争将退出护山大阵，是否继续参与？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
else
func()
end
end

function UIXianJie_JiJie_YBDSetPVPWin:onSelfXMOptionToggleChange(index,isOn)
self.selectList[index]=isOn

local list={}
if self.selectList then
for posId,isSelect in pairs(self.selectList)do
if isSelect then
list[#list+1]=posId
end
end
end
xianjieController:reqMassYBDSetPostLimitList(eYbdType.ZhanZhengYbd,list)
end

function UIXianJie_JiJie_YBDSetPVPWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eYBDRule
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

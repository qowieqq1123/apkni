







def_class("UIXianJie_JiJie_YBDSetWin",UIWindowBase)









function UIXianJie_JiJie_YBDSetWin:bindComponents()

self.pveControllClose=UIObject.get(self,0)
self.pveControllOpen=UIObject.get(self,1)
self.pveControllBtn=UIButton.get(self,2)
self.blackBG=UIObject.get(self,3)
self.clickMask=UIButton.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.btnClose=UIButton.get(self,6)
self.centerpanel=UIObject.get(self,7)
self.saveMoneyText=UIText.get(self,8)
self.saveBtn=UIButton.get(self,9)
self.takeBtn=UIButton.get(self,10)
self.pveDropdown=UIDropdown.get(self,11)
self.jijietxt=UIText.get(self,12)
self.teamItem=UIObject.get(self,13)
self.emptyItem=UIObject.get(self,14)
self.addbtn=UIButton.get(self,15)
self.changeBtn=UIButton.get(self,16)
self.pvpControllBtn=UIButton.get(self,17)
self.pvpControllClose=UIObject.get(self,18)
self.pvpControllOpen=UIObject.get(self,19)
self.pvpCndBtn=UIButton.get(self,20)
self.singleNumText=UIText.get(self,21)
self.changeSingleNumBtn=UIButton.get(self,22)

self.pveControllBtn:setButtonClick(function()self:onPveControllBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.saveBtn:setButtonClick(function()self:onSaveBtn()end)

self.takeBtn:setButtonClick(function()self:onTakeBtn()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.pvpControllBtn:setButtonClick(function()self:onPvpControllBtn()end)

self.pvpCndBtn:setButtonClick(function()self:onPvpCndBtn()end)

self.changeSingleNumBtn:setButtonClick(function()self:onChangeSingleNumBtn()end)



end


function UIXianJie_JiJie_YBDSetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pveControllClose);self.pveControllClose=nil;
_UIObject_release(self.pveControllOpen);self.pveControllOpen=nil;
_UIObject_release(self.pveControllBtn);self.pveControllBtn=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.saveMoneyText);self.saveMoneyText=nil;
_UIObject_release(self.saveBtn);self.saveBtn=nil;
_UIObject_release(self.takeBtn);self.takeBtn=nil;
_UIObject_release(self.pveDropdown);self.pveDropdown=nil;
_UIObject_release(self.jijietxt);self.jijietxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.emptyItem);self.emptyItem=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.pvpControllBtn);self.pvpControllBtn=nil;
_UIObject_release(self.pvpControllClose);self.pvpControllClose=nil;
_UIObject_release(self.pvpControllOpen);self.pvpControllOpen=nil;
_UIObject_release(self.pvpCndBtn);self.pvpCndBtn=nil;
_UIObject_release(self.singleNumText);self.singleNumText=nil;
_UIObject_release(self.changeSingleNumBtn);self.changeSingleNumBtn=nil;
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




function UIXianJie_JiJie_YBDSetWin:onLoaded(...)
_this=self
self:bindComponents()
self.pveDropdown:setChangeAction(function(...)self:onPVEDropdownChange(...)end)
end


function UIXianJie_JiJie_YBDSetWin:__delete()
_this=nil
self:closeWindow('UITopMoneyWin2')
self:unbindComponents()
end




function UIXianJie_JiJie_YBDSetWin:onShow(argtable,afterOnloaded)
self.parentPage=argtable and argtable.parentPage or 1
self.infoPanel:setChildCanvasGroupAlpha(0)
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

self.moneyType=eMoneyType.mtXianLing
local ybdMoneyCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ybdMoneyParam')
self.moneyWarnNum=ybdMoneyCfg[1]
self.moneyMaxNum=ybdMoneyCfg[2]

self:showWindow("UITopMoneyWin2",{moneys={{self.moneyType}},offsetX=0,offsetY=-25})

self:refresh()
end


function UIXianJie_JiJie_YBDSetWin:onHide()

end

function UIXianJie_JiJie_YBDSetWin:refresh()

self:refreshOpenBtnPanel()


self:refreshTeamPanel()


self:refreshPVECndPanel()


self:refreshMoneyPanel()


self:refreshPVPCndPanel()


self:refreshSingleSoldierPanel()
end

function UIXianJie_JiJie_YBDSetWin:refreshOpenBtnPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
self.isOpen_PVE=bitHelper.check_pos(openFlag,0)
self.isOpen_PVP=bitHelper.check_pos(openFlag,1)

self.pveControllOpen:setActive(self.isOpen_PVE)
self.pveControllClose:setActive(not self.isOpen_PVE)

self.pvpControllOpen:setActive(self.isOpen_PVP)
self.pvpControllClose:setActive(not self.isOpen_PVP)
end

function UIXianJie_JiJie_YBDSetWin:refreshTeamPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local hasYzData=ybdData and ybdData.yzId~=nil or false
self.teamItem:setActive(hasYzData)
self.emptyItem:setActive(not hasYzData)
if hasYzData then
local widget=self.teamItem:getWidgetBase()
local yzId=ybdData.yzId
local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and not next(chuZhengDzList)~=nil





local dzList=ybdData.dzList
local dznum=#dzList
widget:SetChildLayoutGroupCreateItems(_teamItemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(_teamItemCmpIndex.teamGrid,index-1)
local dzGuid=dzList[index]
local netData=UIDiscipleModel:getDiscipleData(dzGuid)
local has=netData~=nil
dzItem:SetChildActive(-1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzItem,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzItem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
end
end)


local allSoldierCount=0
local soldierList=ybdData.soldierList
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

function UIXianJie_JiJie_YBDSetWin:refreshPVECndPanel()
local ybdData=xianjieModel:getJiJieYBDData()
self.pveDropdown:setOption(pveDropdownName)
self.monsterStage=ybdData and ybdData.pveCnd and ybdData.pveCnd.monsterStage or 3
self.pveDropdown:setValue(self.monsterStage-1)
end

function UIXianJie_JiJie_YBDSetWin:refreshPVPCndPanel()






end

function UIXianJie_JiJie_YBDSetWin:refreshMoneyPanel()
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

function UIXianJie_JiJie_YBDSetWin:refreshSingleSoldierPanel()
local ybdData=xianjieModel:getJiJieYBDData()
local singleSoldierNum=ybdData and ybdData.singleSoldierNum or 0
self.singleNumText:setText(FMT.fmt("集结数量: {0}",mathHelper.formatNumber4(singleSoldierNum,1)))
end




function UIXianJie_JiJie_YBDSetWin:onPveControllBtn()
local nowTime=gameUtilityModel.getServerShortTime2()
if self.clickOpenBtnStamp and nowTime-self.clickOpenBtnStamp<_clickOpenBtnCd then
UIManager.error("点击过快，请稍后再试")
return
end
self.clickOpenBtnStamp=nowTime

local ybdData=xianjieModel:getJiJieYBDData()
local hasYzData=ybdData and ybdData.yzId~=nil or false
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



function UIXianJie_JiJie_YBDSetWin:onClickMask()
self:onBtnClose()
end



function UIXianJie_JiJie_YBDSetWin:onBtnClose()
self:closeSelf()
end



function UIXianJie_JiJie_YBDSetWin:onSaveBtn()

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
local ybdSoldierList=ybdData and ybdData.soldierList or{}
xianjieController:reqMassYBDMoneyAndSoldierSave(newMoneyNum,ybdSoldierList)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIXianJie_JiJie_YBDSetWin:onTakeBtn()

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
local maxLimitNum=money_ybd
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
local ybdSoldierList=ybdData and ybdData.soldierList or{}
xianjieController:reqMassYBDMoneyAndSoldierSave(newMoneyNum,ybdSoldierList)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIXianJie_JiJie_YBDSetWin:onAddbtn()

local extraCost={}
local func=function(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={moneyType,moneyCount}
end

local ybdData=xianjieModel:getJiJieYBDData()
local moneyNum=ybdData and ybdData.moneyNum or 0
xianjieController:reqMassYBDMoneyAndSoldierSave(moneyNum,soldierList)
xianjieController:reqMassYBDTeamChange(yzId,dzList)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
orderType=xjOrderType.eJiJieJoin,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
isYBDSet=true,
confirmBtnStr="设置预备队",
cancelCallBack=function()
local page=1
UIManager:showWindow('UIXianJie_JiJie_teamListBgWin',{page=page,extraArgs={isOpenYBDWin=true}})
end,
})
end



function UIXianJie_JiJie_YBDSetWin:onChangeBtn()

local ybdData=xianjieModel:getJiJieYBDData()
local soldierList=ybdData and ybdData.soldierList
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
local dzList=ybdData and ybdData.dzList
local extraCost={}
local func=function(dzList,selectMoneyList,yzId)
local soldierList={}
for i,v in ipairs(selectMoneyList)do
local moneyType=v[1]
local moneyCount=v[2]
soldierList[i]={moneyType,moneyCount}
end

local ybdData=xianjieModel:getJiJieYBDData()
local moneyNum=ybdData and ybdData.moneyNum or 0
xianjieController:reqMassYBDMoneyAndSoldierSave(moneyNum,soldierList)
xianjieController:reqMassYBDTeamChange(yzId,dzList)
end
local page=self.parentPage
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
defaultSoldierList=defaultSoldierList,
defaultDzList=dzList,
extraSoldierList=defaultSoldierList,
orderType=xjOrderType.eJiJieJoin,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
isYBDSet=true,
confirmBtnStr="设置预备队",
cancelCallBack=function()
UIManager:showWindow('UIXianJie_JiJie_teamListBgWin',{page=page,extraArgs={isOpenYBDWin=true}})
end,
})
end



function UIXianJie_JiJie_YBDSetWin:onPvpControllBtn()

local func=function()
local nowTime=gameUtilityModel.getServerShortTime2()
if self.clickOpenBtnStamp and nowTime-self.clickOpenBtnStamp<_clickOpenBtnCd then
UIManager.error("点击过快，请稍后再试")
return
end
self.clickOpenBtnStamp=nowTime

local ybdData=xianjieModel:getJiJieYBDData()
local hasYzData=ybdData and ybdData.yzId~=nil or false
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
if tianshudazhenModel:isOpeningFHZ()then
local desc='参与战争将退出护山大阵，是否继续参与？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
else
func()
end
end

function UIXianJie_JiJie_YBDSetWin:onPVEDropdownChange(idx)
idx=idx+1
self.monsterStage=idx
xianjieController:reqMassYBDSetPveCnd_monsterStage(self.monsterStage)
end

function UIXianJie_JiJie_YBDSetWin:onPvpCndBtn()
self:showWindow("UIXianJie_JiJie_YBDPvPCndWin")
end

function UIXianJie_JiJie_YBDSetWin:onChangeSingleNumBtn()
local callback=function(changeNum)
if _this==nil then return end
xianjieController:reqMassYBDSetSingleSoldierNum(changeNum)
end


local tsdSingleMaxUseCount=xianjieModel:getJiJieAddCount()
local tsdMaxUseCount=tsdSingleMaxUseCount*5

local checkFunc=function(changeNum)
if changeNum<1 then
UIManager.error("至少出征一名修士")
return false
end

if tsdMaxUseCount and changeNum>tsdMaxUseCount then
UIManager.error("参与集结的修士上限受天枢殿等级影响")
return false,tsdMaxUseCount
end


return true
end
local ybdData=xianjieModel:getJiJieYBDData()
local nowNum=ybdData and ybdData.singleSoldierNum or 0
local args={
title='集结修士数量',
defaultNum=nowNum,
defaultDesc="请输入集结修士数量",
checkFunc=checkFunc,
callback=callback,
}
self:showWindow('UICommonChangeNumWin',args)
end
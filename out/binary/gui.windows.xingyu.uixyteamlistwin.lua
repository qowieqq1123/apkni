







def_class("UIXYTeamListWIn",UIWindowBase)









function UIXYTeamListWIn:bindComponents()

self.mask=UIButton.get(self,0)
self.xyteamListItem_1=UIObject.get(self,1)
self.xyteamListItem_2=UIObject.get(self,2)
self.xyteamListItem_3=UIObject.get(self,3)
self.enter=UIButton.get(self,4)
self.enterBg=UIObject.get(self,5)

self.mask:setButtonClick(function()self:onMask()end)

self.enter:setButtonClick(function()self:onEnter()end)
self.xyteamListItem={
self.xyteamListItem_1,
self.xyteamListItem_2,
self.xyteamListItem_3,
}



end


function UIXYTeamListWIn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.xyteamListItem_1);self.xyteamListItem_1=nil;
_UIObject_release(self.xyteamListItem_2);self.xyteamListItem_2=nil;
_UIObject_release(self.xyteamListItem_3);self.xyteamListItem_3=nil;
_UIObject_release(self.enter);self.enter=nil;
_UIObject_release(self.enterBg);self.enterBg=nil;
self.xyteamListItem=nil;
end
















local cmpIndex={
hss=0,
noDz=1,
setTeamBtn=2,
slotList={3,4,5,6,7},
fight=8,
bgModel=9,
root=10,
lock=11,
click=12,
}



function UIXYTeamListWIn:onLoaded(...)
self:bindComponents()
self.widgetList={}
for i,v in ipairs(self.xyteamListItem)do
local widget=v:getWidgetBase()
self.widgetList[i]=widget
widget:SetChildButtonClick(cmpIndex.setTeamBtn,function()
self:openSelectTeamWin(i)
end)
widget:SetChildButtonClick(cmpIndex.click,function()
self:openSelectTeamWin(i)
end)
end
loadingControl.closeCloud()
end


function UIXYTeamListWIn:__delete()
self:unbindComponents()
end




function UIXYTeamListWIn:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
self.xyId=xyId

local teamList=XingYuModel:getXingYuData_teamList(xyId)




local hasTeam=XingYuController.checkHasTeam(xyId)
if not hasTeam then
self.enter:setActive(true)
self.enterBg:setActive(true)
self.enter:setChildUIModelShowTarget(5657,1,nil,eAnimationID.stand)

self:refrshlocal()
return
end
self.enter:setActive(false)
self.enterBg:setActive(false)
for teamIndex,widget in ipairs(self.widgetList)do

local xingyuTeam
if teamList then
for i,_xingyuTeam in ipairs(teamList)do
if _xingyuTeam.index==teamIndex then
xingyuTeam=_xingyuTeam
break
end
end
end
local hasDz=xingyuTeam and xingyuTeam.len>0
widget:SetChildActive(cmpIndex.click,false)
widget:SetChildActive(cmpIndex.hss,hasDz)
widget:SetChildActive(cmpIndex.noDz,not hasTeam)
widget:SetChildActive(cmpIndex.lock,hasTeam and not hasDz)
widget:SetChildUIModelShowTarget(cmpIndex.bgModel,hasDz and 5655 or 5656,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
widget:SetChildCanvasGroupDOFade(cmpIndex.root,1,0.5)
end)
end)

if hasDz then
local fight=mathHelper.int64_to_number(xingyuTeam.fightVal)

local guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)






for ii,cIndex in ipairs(cmpIndex.slotList)do
if guidList[ii]then
widget:SetChildActive(cIndex,true)
local headshot=widget:GetChildWidgetBase(cIndex)
local guid=guidList[ii]
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)


UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
else
widget:SetChildActive(cIndex,false)
end
end
widget:SetChildText(cmpIndex.fight,mathHelper.formatNumber3(fight))
end
end
end


function UIXYTeamListWIn:onHide()

end


function UIXYTeamListWIn:refrshlocal()
local xyId=self.xyId

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local localteamList=localCfg.localteamListEx





for teamIndex,widget in ipairs(self.widgetList)do
local strTeamIndex=tostring(teamIndex)
local haslcoalDz=false
local localGuidList={}

if localteamList and localteamList[strTeamIndex]then
local dzList=localteamList[strTeamIndex]
for i2,guidStr in ipairs(dzList)do
local guid=int64.new(guidStr)
if guidStr~='0'and not mathHelper.compareInt64(guid,Int64_0)and
not XingYuController.checkXingYuLimtDz(xyId,guid)and
not XingYuController.checkXingYuDz(guid)then
localGuidList[#localGuidList+1]=guid
haslcoalDz=true
end
end
end
widget:SetChildActive(cmpIndex.click,true)
widget:SetChildActive(cmpIndex.hss,haslcoalDz)
widget:SetChildActive(cmpIndex.noDz,not haslcoalDz)
widget:SetChildActive(cmpIndex.lock,false)
widget:SetChildUIModelShowTarget(cmpIndex.bgModel,haslcoalDz and 5655 or 5656,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
widget:SetChildCanvasGroupDOFade(cmpIndex.root,1,0.5)
end)
end)

if haslcoalDz then
local fight=0
local guidList=localGuidList
for ii,cIndex in ipairs(cmpIndex.slotList)do
if guidList[ii]then
widget:SetChildActive(cIndex,true)
local headshot=widget:GetChildWidgetBase(cIndex)
local guid=guidList[ii]
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)
fight=fight+UIDiscipleModel:getDiscipleFightValue(guid)

UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
else
widget:SetChildActive(cIndex,false)
end
end
widget:SetChildText(cmpIndex.fight,mathHelper.formatNumber3(fight))
end
end
end





function UIXYTeamListWIn:onMask()
self:closeSelf()
end

function UIXYTeamListWIn:onEnter()
local xyId=self.xyId
local inLimtTime=XingYuController.checkInPaiQianLimtTime(xyId)
if inLimtTime then
UIManager.error("当前时段不可派遣")
return
end

local teamList={}
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local localteamList=localCfg.localteamListEx


local emptyIndex
local fisrtNoFullTeamIndex
if localteamList then
for strTeamIndex,v in pairs(localteamList)do
local xingyuTeamSet={}
xingyuTeamSet[1]=tonumber(strTeamIndex)

local dzList=v
local senddzList={}
local isEmpty=true

for i2,guidStr in ipairs(dzList)do
local guid=int64.new(guidStr)
if guidStr~='0'and not mathHelper.compareInt64(guid,Int64_0)and
not XingYuController.checkXingYuLimtDz(xyId,guid)and
not XingYuController.checkXingYuDz(guid)then
isEmpty=false
table.insert(senddzList,guid)
else
table.insert(senddzList,Int64_0)
if not fisrtNoFullTeamIndex or xingyuTeamSet[1]<fisrtNoFullTeamIndex then
fisrtNoFullTeamIndex=xingyuTeamSet[1]
end
end
end
xingyuTeamSet[2]=#senddzList
xingyuTeamSet[3]=senddzList

if isEmpty then
if not emptyIndex or xingyuTeamSet[1]<emptyIndex then
emptyIndex=xingyuTeamSet[1]
end
else
table.insert(teamList,xingyuTeamSet)
end
end
end

if#teamList>0 then
if emptyIndex then
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local showFlagList=localCfg.showFlagList
local strXyId=tostring(xyId)
if not showFlagList or(showFlagList and not showFlagList[strXyId])then
local str=FMT.fmt("<color=#7D3B17>第{0}队</color>未上阵弟子，进入星域后将锁定所\n有队伍，无法更换弟子，是否进入？",emptyIndex)
local callback=function()
XingYuController.req_35_101(xyId,#teamList,teamList)
end
UIDialogManager.getConfirmDialog3(nil,str,callback,nil,nil,nil)
return
end
elseif fisrtNoFullTeamIndex then
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local showFlagList=localCfg.showFlagList
local strXyId=tostring(xyId)
if not showFlagList or(showFlagList and not showFlagList[strXyId])then
local str=FMT.fmt("<color=#7D3B17>第{0}队</color>未上阵满弟子，进入星域后将锁定\n队伍，无法更换弟子，是否确定？",fisrtNoFullTeamIndex)
local callback=function()
XingYuController.req_35_101(xyId,#teamList,teamList)
end
UIDialogManager.getConfirmDialog3(nil,str,callback,nil,nil,nil)
return
end
end

local str="进入星域后将锁定队伍，无法更换弟子，\n是否确定？"
local callback=function()
XingYuController.req_35_101(xyId,#teamList,teamList)
end
UIDialogManager.getConfirmDialog3(nil,str,callback,nil,nil,nil)

else
UIManager.info("未选择上阵弟子")
end
end



function UIXYTeamListWIn:openSelectTeamWin(index)
local xyId=self.xyId






local xyCfg=XingYuModel:getXingYuConfig(xyId)
local enterCallBack=function(guidList)



local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
if not localCfg.localteamListEx then
localCfg.localteamListEx={}
end
local localteamList=localCfg.localteamListEx






for index,v in ipairs(guidList)do




















local strdzList={}
for ii,vv in ipairs(v[2])do
table.insert(strdzList,mathHelper.int64_to_string(vv[2]))
end
localteamList[tostring(index)]=strdzList
end
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)
























loadingControl.openCloud(function()
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
XingYuController:openXYListWin(false,xyId)
UIManager:showWindow("UIXYTeamListWIn",{xyId=xyId})
end,nil,true)
end

local cancelCallBack=function()
XingYuController:openXYListWin(false,xyId)
UIManager:showWindow("UIXYTeamListWIn",{xyId=xyId})
end

local enterTxt=xyCfg.name
local teamData={}
local teamLockCfgList={}
local hasTeam=XingYuController.checkHasTeam(xyId)
for i=1,3 do

teamData[i]={}
local lockFlag=XingYuController.checkTeamLock(xyId,i)
teamLockCfgList[i]={lockFlag=lockFlag,teamlockTips="队伍已锁定",dzlockTips="弟子已锁定",}































if hasTeam then

local dzList=XingYuController.getXingYuTeamPosDzList_TeamIndex(xyId,i)
for i2,v2 in ipairs(dzList or{})do
if v2~=0 and not mathHelper.compareInt64(v2,Int64_0)then
teamData[i][tostring(v2)]={i2,1,v2}
end
end
else

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local localteamList=localCfg.localteamListEx

local strTeamIndex=tostring(i)


if localteamList and localteamList[strTeamIndex]then
local dzList=localteamList[strTeamIndex]
for i2,guidStr in ipairs(dzList)do
local guid=int64.new(guidStr)
if guidStr~='0'and not mathHelper.compareInt64(guid,Int64_0)and
not XingYuController.checkXingYuLimtDz(xyId,guid)and
not XingYuController.checkXingYuDz(guid)then
teamData[i][guidStr]={i2,1,guid}
end
end
end
end

end

local dZTempList={}




local allData=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(allData)do
local dzguid=v.netData.net.discipleguid
if not XingYuController.checkXingYuLimtDz(xyId,dzguid)then
dZTempList[#dZTempList+1]=dzguid
end

end




local winArgs=
{
enterCallBack=enterCallBack,
enterTxt=enterTxt,
mapId=817001,
multipleTeams=teamData,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=cancelCallBack,
sureBodyid=2068,
sureBodyAnim=eAnimationID.stand,
dontCloseStage=false,
notNeedDealOverTime=true,
defaultSelectTeamIndex=index,
editorTeam=true,
lockSelect=dZTempList,
teamLockCfgList=teamLockCfgList,
isSortByTeamSelect=true,
checkSelectCnt=false,
checkSelectCntEx=true,
checkDZSortFunc=function(guid)
return not XingYuController.checkXingYuDz(guid)
end,
checkXingYuFlagFunc=function(guid)
return XingYuController.checkXingYuDz(guid)
end,
checkTeamFullDzFunc=function(index)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local showFlagList=localCfg.showFlagList
if not showFlagList then
showFlagList={}
end
local strXyId=tostring(xyId)
showFlagList[strXyId]=true
localCfg.showFlagList=showFlagList
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)

local str=FMT.fmt("<color=#7D3B17>第{0}队</color>未上阵满弟子，进入星域后将锁定\n队伍，无法更换弟子，是否确定？",index)
return str
end,
noDzSZFunc=function(index)
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXingYu,{})
local showFlagList=localCfg.showFlagList
if not showFlagList then
showFlagList={}
end
local strXyId=tostring(xyId)
showFlagList[strXyId]=true
localCfg.showFlagList=showFlagList
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXingYu,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXingYu)

local str=FMT.fmt("<color=#7D3B17>第{0}队</color>未上阵弟子，进入星域后将锁定所\n有队伍，无法更换弟子，是否确定？",index)
return str
end,

mustHasDz=true,
}

fightController.showPrepareWin(eFightPreSelectType.xingyupaiqian,winArgs,function()
UIFullFightPrepareControl:showWindow("UIFightPrepareXingYuHJEffectWin",{teamIndex=index,xyId=xyId,tips="环境效果"})
end)
end

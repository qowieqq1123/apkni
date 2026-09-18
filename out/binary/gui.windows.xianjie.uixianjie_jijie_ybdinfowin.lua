







def_class("UIXianJie_JiJie_YBDInfoWin",UIWindowBase)









function UIXianJie_JiJie_YBDInfoWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.teamFightText=UIText.get(self,4)
self.teamDzPanel=UIObject.get(self,5)
self.discipleGroup=UIObject.get(self,6)
self.soldierGroup=UIObject.get(self,7)
self.yzEquipPanel=UIObject.get(self,8)
self.yzMixSkillPanel=UIObject.get(self,9)
self.attrAddPanel=UIObject.get(self,10)
self.yzOnlySkillPanel=UIObject.get(self,11)
self.btnPanel=UIObject.get(self,12)
self.inviteBtn=UIButton.get(self,13)
self.bgModel=UIObject.get(self,14)
self.root=UIObject.get(self,15)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.inviteBtn:setButtonClick(function()self:onInviteBtn()end)



end


function UIXianJie_JiJie_YBDInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.teamFightText);self.teamFightText=nil;
_UIObject_release(self.teamDzPanel);self.teamDzPanel=nil;
_UIObject_release(self.discipleGroup);self.discipleGroup=nil;
_UIObject_release(self.soldierGroup);self.soldierGroup=nil;
_UIObject_release(self.yzEquipPanel);self.yzEquipPanel=nil;
_UIObject_release(self.yzMixSkillPanel);self.yzMixSkillPanel=nil;
_UIObject_release(self.attrAddPanel);self.attrAddPanel=nil;
_UIObject_release(self.yzOnlySkillPanel);self.yzOnlySkillPanel=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.inviteBtn);self.inviteBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this
local _dzItemCmpIndex=
{
name=0,
fight=1,
head=2,
color=3,
job=4,
root=5,
self=6,
panel=7,
tianminObj=8,
lvBg=9,
lvText=10,
back_xianmo=11,
}

local _soldierItemCmpIndex={
bgIcon=0,
nameIcon=1,
numText=2,
}




function UIXianJie_JiJie_YBDInfoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_YBDInfoWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_JiJie_YBDInfoWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5726,1,{},eAnimationID.enter)
self:delayDo(0.4,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.massActorId=argtable and argtable.massActorId
self.massGuid=argtable and argtable.massGuid
self.infoGuid=argtable and argtable.infoGuid
self.actorId=argtable and argtable.actorId

self:refresh()
end


function UIXianJie_JiJie_YBDInfoWin:onHide()

end

function UIXianJie_JiJie_YBDInfoWin:refresh()

self.ybdData=xianjieModel:getJiJieYBDListDataByActorId(self.actorId)


self:refreshPlayerPanel()


self:refreshSoldierPanel()

self.teamDzPanel:setActive(true)
self.yzEquipPanel:setActive(false)
self.yzMixSkillPanel:setActive(false)
self.attrAddPanel:setActive(false)
self.yzOnlySkillPanel:setActive(false)

self:refreshTeamDzPanel()



self.btnPanel:setActive(true)

self:refreshBtnPanel()
end


function UIXianJie_JiJie_YBDInfoWin:refreshPlayerPanel()


local iconInfo=self.ybdData.iconInfo
local headWidget=self.head:getWidgetBase()
playerController:setHeadIcon(headWidget,-1,{iconInfo=iconInfo,scale=0.62})


local nameStr=self.ybdData.actorname
self.name:setText(nameStr)


local teamFightValue=0
if self.ybdData then
local dzFightList={}
local dzlist=self.ybdData.discipleList or{}
for i,netData in ipairs(dzlist)do
local has=netData~=nil and netData.flag>0
if has then
local dzGuidStr=tostring(netData.discipleguid)
local fightValue_int64=netData.fightvalue
local fightValue=mathHelper.int64_to_number(fightValue_int64)
dzFightList[dzGuidStr]=fightValue
end
end
local soldierList={}
local moneyList=self.ybdData.moneyList

for _,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
local soldierId=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if soldierList[soldierId]then
soldierList[soldierId]=soldierList[soldierId]+count
else
soldierList[soldierId]=count
end
end
teamFightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList)
end
self.teamFightText:setText(FMT.fmt("队伍实力：{0}",mathHelper.formatNumber3(teamFightValue)))
end

function UIXianJie_JiJie_YBDInfoWin:refreshTeamDzPanel()
local dzlist=self.ybdData.discipleList or{}
local dznum=#dzlist
self.discipleGroup:setChildLayoutGroupCreateItems(dznum,function(index)
local dzItem=self.discipleGroup:getChildLayoutGroupGridItem(index-1)
local netData=dzlist[index]
local has=netData~=nil and netData.flag>0
dzItem:SetChildButtonClick(_dzItemCmpIndex.panel,function()
if _this==nil then return end
_this:onHeadClick(index)
end,true)
dzItem:SetChildActive(-1,has)
if has then

dzItem:SetChildText(_dzItemCmpIndex.name,netData.disciplename)

local fightValue=tostring(netData.fightvalue)
dzItem:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))

local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(_dzItemCmpIndex.head,dzItem,modelParams,eHeadCenterType.eHalf,nil,false)

local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData,color)
dzItem:SetChildCSImageSprite(_dzItemCmpIndex.color,abname,iconname)

local jobIcon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(_dzItemCmpIndex.job,globalABLookup.global,jobIcon)

dzItem:SetChildCSImageSprite(_dzItemCmpIndex.lvBg,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
local lv_str=tostring(netData.jingjielv)
dzItem:SetChildText(_dzItemCmpIndex.lvText,lv_str)

UIDiscipleController.refreshCommonItemTianMing(dzItem,netData,_dzItemCmpIndex.tianminObj)

UIDiscipleModel:setDiscipleXianMoBackImage(dzItem,_dzItemCmpIndex.back_xianmo,netData)
end
end)
end

function UIXianJie_JiJie_YBDInfoWin:refreshSoldierPanel()
local moneyList=self.ybdData.moneyList
local sortList=self:getSortSoldierList(moneyList)

self.soldierGroup:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.soldierGroup:getChildLayoutGroupGridItem(index-1)
local soldierData=sortList[index]
if soldierData then
widget:SetChildActive(-1,true)
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,soldierData.level)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_soldierItemCmpIndex.bgIcon,iconAb,bgIconName)
local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_soldierItemCmpIndex.nameIcon,iconAb,levelIconName)
widget:SetChildText(_soldierItemCmpIndex.numText,mathHelper.formatNumber4(soldierData.count,1))
else
widget:SetChildActive(-1,false)
end

end)
end


function UIXianJie_JiJie_YBDInfoWin:refreshYzMixSkillPanel()

end

function UIXianJie_JiJie_YBDInfoWin:refreshBtnPanel()

end

function UIXianJie_JiJie_YBDInfoWin:getSortSoldierList(moneyList)
local sortList={}
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
sortList[#sortList+1]={
level=soldierLevel,
moneyType=moneyType,
count=count,
}
end

table.sort(sortList,function(a,b)
if a.soldierLevel==b.soldierLevel then
return a.moneyType<b.moneyType
else
return a.soldierLevel>b.soldierLevel
end
end)

return sortList
end




function UIXianJie_JiJie_YBDInfoWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_YBDInfoWin:onCloseBtn()
self:closeSelf()
end


function UIXianJie_JiJie_YBDInfoWin:onInviteBtn()

local actorId=self.actorId
local infoguid=self.infoGuid

local lastCdStamp=xianjieModel:getJiJieSelfMassYBDCdStamp(infoguid,actorId)or 0
local cdTime=xianjieModel:getJiJieSelfMassYBDCd()
local nowTime=timeHelper.getServerShortTime()
if nowTime-lastCdStamp<cdTime then
UIManager.error("操作频繁，请稍后再试")
return
end


local zmData=xianjieModel:getZongMenData(actorId)
local bornAreaID=zmData:getBornAreaID()
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
local ret,gateList,errorParams=xianjieController:checkMovePath(bornAreaID,zmData.sceneidx,zmData.gridX_c,zmData.gridZ_c,sceneidx,gridX_c,gridZ_c,true)
if not ret then

if errorParams then
local errStr=""
local isOtherZmInNeutralArea=errorParams.isSelfInNeutralArea
local isSelfZmInNeutralArea=errorParams.isTargetInNeutralArea
if isOtherZmInNeutralArea then

errStr="处于本阵内无法邀请阵外的祖师参与集结"
elseif isSelfZmInNeutralArea then

errStr="处于阵外无法邀请本阵内的祖师参与集结"
else

errStr="处于本阵内无法邀请其他本阵的祖师内参与集结"
end
UIManager.error(errStr)
end
return
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieInvite
local params={tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr,nil,nil,gateList)

self:onCloseBtn()
end

function UIXianJie_JiJie_YBDInfoWin:onHeadClick()

end

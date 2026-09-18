







def_class("UIXianJie_JiJie_teamInfoWin",UIWindowBase)









function UIXianJie_JiJie_teamInfoWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.flagLayout=UIObject.get(self,2)
self.leaderFlag=UIObject.get(self,3)
self.initiatorFlag=UIObject.get(self,4)
self.head=UIObject.get(self,5)
self.selfFlag=UIObject.get(self,6)
self.name=UIText.get(self,7)
self.teamFightText=UIText.get(self,8)
self.leaderSoldierNumText=UIText.get(self,9)
self.massSoldierText=UIText.get(self,10)
self.teamDzPanel=UIObject.get(self,11)
self.discipleGroup=UIObject.get(self,12)
self.soldierGroup=UIObject.get(self,13)
self.yzEquipPanel=UIObject.get(self,14)
self.yzMixSkillPanel=UIObject.get(self,15)
self.attrAddPanel=UIObject.get(self,16)
self.yzOnlySkillPanel=UIObject.get(self,17)
self.yzMemberSkillPanel=UIObject.get(self,18)
self.btnPanel=UIObject.get(self,19)
self.changeLeaderBtn=UIButton.get(self,20)
self.kickOutBtn=UIButton.get(self,21)
self.bgModel=UIObject.get(self,22)
self.root=UIObject.get(self,23)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.changeLeaderBtn:setButtonClick(function()self:onChangeLeaderBtn()end)

self.kickOutBtn:setButtonClick(function()self:onKickOutBtn()end)



end


function UIXianJie_JiJie_teamInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.flagLayout);self.flagLayout=nil;
_UIObject_release(self.leaderFlag);self.leaderFlag=nil;
_UIObject_release(self.initiatorFlag);self.initiatorFlag=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.selfFlag);self.selfFlag=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.teamFightText);self.teamFightText=nil;
_UIObject_release(self.leaderSoldierNumText);self.leaderSoldierNumText=nil;
_UIObject_release(self.massSoldierText);self.massSoldierText=nil;
_UIObject_release(self.teamDzPanel);self.teamDzPanel=nil;
_UIObject_release(self.discipleGroup);self.discipleGroup=nil;
_UIObject_release(self.soldierGroup);self.soldierGroup=nil;
_UIObject_release(self.yzEquipPanel);self.yzEquipPanel=nil;
_UIObject_release(self.yzMixSkillPanel);self.yzMixSkillPanel=nil;
_UIObject_release(self.attrAddPanel);self.attrAddPanel=nil;
_UIObject_release(self.yzOnlySkillPanel);self.yzOnlySkillPanel=nil;
_UIObject_release(self.yzMemberSkillPanel);self.yzMemberSkillPanel=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.changeLeaderBtn);self.changeLeaderBtn=nil;
_UIObject_release(self.kickOutBtn);self.kickOutBtn=nil;
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

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
cmpBtn=15,
}



function UIXianJie_JiJie_teamInfoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_teamInfoWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_JiJie_teamInfoWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5726,1,{},eAnimationID.enter)
self:delayDo(0.4,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.isTeamInfo=argtable and argtable.isTeamInfo or false
self.massActorId=argtable and argtable.massActorId
self.massGuid=argtable and argtable.massGuid
self.infoGuid=argtable and argtable.infoGuid
self.showMemberIndex=argtable and argtable.showMemberIndex

self:refresh()
end


function UIXianJie_JiJie_teamInfoWin:onHide()

end

function UIXianJie_JiJie_teamInfoWin:refresh()

self.msgData=xianjieModel:getJiJieTeamDetail(self.massActorId,self.massGuid)
self.isSelfInitiator=playerModel:checkActorId(self.massActorId)

local memberList=self.msgData.memberList
if not self.showMemberIndex then
self.showMemberIndex=self:getMassLeaderIndex()
end
self.memberData=memberList[self.showMemberIndex]
self.showActorId=self.memberData.actorid
self.isLeader=self.memberData.isleader==1
self.isInitiator=mathHelper.compareInt64(self.massActorId,self.showActorId)


self:refreshPlayerPanel()


self:refreshSoldierPanel()


self.teamDzPanel:setActive(true)
self.yzEquipPanel:setActive(self.isLeader)

self.attrAddPanel:setActive(self.isLeader)



self:refreshTeamDzPanel()
if self.isLeader then

self:refreshYzEquipPanel()












self:refreshAttrAddPanel()
else


end

local chuZhengSec=self.msgData.sec
local isChuZheng=chuZhengSec==0
local isShowBtnPanel=false
if self.isSelfInitiator and not self.isTeamInfo and not isChuZheng then
if not self.isInitiator or not self.isLeader then

isShowBtnPanel=true
end
end
self.btnPanel:setActive(isShowBtnPanel)
if isShowBtnPanel then

self:refreshBtnPanel()
end
end

function UIXianJie_JiJie_teamInfoWin:refreshPlayerPanel()
local playZmData
local isSelf=playerModel:checkActorId(self.showActorId)
if isSelf then
playZmData=xianjieModel:getMyZongMenData()
else
playZmData=xianjieModel:getZongMenData(self.showActorId)
end

local iconInfo=playZmData.iconInfo
local headWidget=self.head:getWidgetBase()
playerController:setHeadIcon(headWidget,-1,{iconInfo=iconInfo,scale=0.62,enableFadeCompatible=true})


local nameStr=playZmData.actorname
self.name:setText(nameStr)


self.leaderFlag:setActive(self.isLeader)
self.initiatorFlag:setActive(self.isInitiator)
self.flagLayout:setActive(self.isLeader or self.isInitiator)
self.selfFlag:setActive(isSelf)


local teamFightValue=0
local allSoldierCount=0
if self.msgData then
local dzFightList={}
local dzlist=self.memberData.discipleList or{}
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
local jzAttrList={}
local moneyList
if self.isTeamInfo then
moneyList={}
local memberList=self.msgData.memberList
for i,memberData in pairs(memberList)do
local list=memberData.moneyList
moneyList[#moneyList+1]=list

local bonusList=memberData.bonusList
if bonusList and#bonusList>0 then
for i=1,#bonusList do
local attr=bonusList[i]
if jzAttrList[attr.param_1]then
jzAttrList[attr.param_1]=jzAttrList[attr.param_1]+attr.param_2
else
jzAttrList[attr.param_1]=attr.param_2
end
end
end
end
else
moneyList={self.memberData.moneyList}
local bonusList=self.memberData.bonusList
if bonusList and#bonusList>0 then
for i=1,#bonusList do
local attr=bonusList[i]
if jzAttrList[attr.param_1]then
jzAttrList[attr.param_1]=jzAttrList[attr.param_1]+attr.param_2
else
jzAttrList[attr.param_1]=attr.param_2
end
end
end
end
for _,list in ipairs(moneyList)do
for _,money in ipairs(list)do
local moneyType=money.param_1
local count=money.param_2
local soldierId=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if soldierList[soldierId]then
soldierList[soldierId]=soldierList[soldierId]+count
else
soldierList[soldierId]=count
end
allSoldierCount=allSoldierCount+count
end
end
teamFightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList,jzAttrList)
end
self.teamFightText:setText(FMT.fmt("队伍实力：{0}",mathHelper.formatNumber3(teamFightValue)))

self.leaderSoldierNumText:setActive(self.isTeamInfo)
self.massSoldierText:setActive(self.isTeamInfo)
if self.isTeamInfo and self.msgData then

local moneyList=self.memberData.moneyList
local leaderSoldierCount=0
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
leaderSoldierCount=leaderSoldierCount+count
end
self.leaderSoldierNumText:setText(FMT.fmt("队长随队修士数量：{0}",mathHelper.formatNumber4(leaderSoldierCount,1)))


local maxCount=self.msgData.maxSoldierCount or 0
self.massSoldierText:setText(FMT.fmt("随队修士上限：{0}/{1}",mathHelper.formatNumber4(allSoldierCount,1),mathHelper.formatNumber4(maxCount,1)))
end
end

function UIXianJie_JiJie_teamInfoWin:refreshTeamDzPanel()
local dzlist=self.memberData.discipleList or{}
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

function UIXianJie_JiJie_teamInfoWin:refreshSoldierPanel()
local allMoneyList=self:getAllMoneyList()
local sortList=self:getSortSoldierList(allMoneyList)

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

function UIXianJie_JiJie_teamInfoWin:refreshYzEquipPanel()
local boatList=self.memberData.boatList or{}
local shipData=boatList[1]or{}
local zq4List=shipData.zq4List or{}
local equipNum=0
self.equipList={}
for i,v in ipairs(zq4List)do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
self.equipList[type1]=v
equipNum=equipNum+1
end

for i=1,3 do
self:refreshEquipItemEx(i)
end

self.yzEquipPanel:setActive(equipNum>0)
end


function UIXianJie_JiJie_teamInfoWin:refreshEquipItemEx(idx)
local panelWidget=self.yzEquipPanel:getWidgetBase()
local widget=panelWidget:GetChildCommonLayoutGroupWidgetItem(0,idx-1)
local equip=self.equipList[idx]
local typename
if idx==1 then
typename="龙首"
elseif idx==2 then
typename="龙骨"
else
typename="阵炉"
end
widget:SetChildText(_itemWidgetIdx.cmpItemName,typename)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local star=stage

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=yunZhouEquipsConfig.checkEquipIsCanJingLian(equip)
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIXianJie_JiJie_teamInfoWin:refreshYzMemberSkillPanel()
local sortMemberList=self:getSortMemberList()
local panelWidget=self.yzMemberSkillPanel:getWidgetBase()
panelWidget:SetChildLayoutGroupCreateItems(0,#sortMemberList,function(index)
local widget=panelWidget:GetChildLayoutGroupGridItem(0,index-1)
local memberData=sortMemberList[index]
if memberData then
widget:SetChildActive(-1,true)
local isLeader=memberData.data.isleader==1
local titleStr=isLeader and"先锋阵旗-{0}"or"队员阵旗-{0}"
local actorId=memberData.data.actorid
local playZmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
playZmData=xianjieModel:getMyZongMenData()
else
playZmData=xianjieModel:getZongMenData(actorId)
end
local nameStr=playZmData.actorname
widget:SetChildText(0,FMT.fmt(titleStr,nameStr))
else
widget:SetChildActive(-1,false)
end
end)
end

function UIXianJie_JiJie_teamInfoWin:refreshYzOnlySkillPanel()

end

function UIXianJie_JiJie_teamInfoWin:refreshAttrAddPanel()
local panelWidget=self.attrAddPanel:getWidgetBase()


local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eYZ_Speed,
eAttributeType.ePoZhen,
eAttributeType.eJunSha,
}
local attrExtraAddValue={
[eAttributeType.eYZ_Speed]=10000,
[eAttributeType.ePoZhen]=10000,
}
local attrList={}
local attrNum=0

local memberList=self.msgData.memberList
for i,memberData in pairs(memberList)do
if memberData.bonuslistlen>0 then
for i=1,memberData.bonuslistlen do
local attr=memberData.bonusList[i]
local attrId=attr.param_1
local extraAddValue=attrExtraAddValue[attrId]or 0
local attrValue=attr.param_2+extraAddValue

if attrList[attrId]then
attrList[attrId]=attrList[attrId]+attrValue
else
attrList[attrId]=attrValue
attrNum=attrNum+1
end
end
end
end

self.attrAddPanel:setActive(attrNum>0)
if attrNum>0 then
panelWidget:SetChildLayoutGroupCreateItems(0,#attrTypes,function(index)
local item=panelWidget:GetChildLayoutGroupGridItem(0,index-1)
local attrID=attrTypes[index]
local attrValue=attrList[attrID]
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrID)

item:SetChildText(0,FMT.fmt("{0}加成：",attrCfg.attrname))
item:SetChildText(1,FMT.fmt("+{0}",helper.getAttributeStrEx(attrID,attrValue or 0)))
end)
end
end

function UIXianJie_JiJie_teamInfoWin:refreshYzMixSkillPanel()

end

function UIXianJie_JiJie_teamInfoWin:refreshBtnPanel()
self.changeLeaderBtn:setActive(not self.isLeader)
self.kickOutBtn:setActive(not self.isInitiator)
end

function UIXianJie_JiJie_teamInfoWin:getSortSoldierList(allMoneyList)
local sortList={}
local sortLookUp={}
for _,moneyList in ipairs(allMoneyList)do
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
if sortLookUp[moneyType]then
sortLookUp[moneyType]=sortLookUp[moneyType]+count
else
sortLookUp[moneyType]=count
end
end
end

for moneyType,count in pairs(sortLookUp)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
sortList[#sortList+1]={
level=soldierLevel,
moneyType=moneyType,
count=count,
}
end

table.sort(sortList,function(a,b)
if a.level==b.level then
return a.moneyType<b.moneyType
else
return a.level>b.level
end
end)

return sortList
end

function UIXianJie_JiJie_teamInfoWin:getSortMemberList()
local memberList=self.msgData.memberList
local sortList={}
for idx,data in ipairs(memberList)do
local weight=idx
local isLeader=data.isleader==1
if isLeader then
weight=weight-1000
end
sortList[#sortList+1]={
data=data,
originalIndex=idx,
weight=weight,
}
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

return sortList
end

function UIXianJie_JiJie_teamInfoWin:getMassLeaderIndex()
if not self.msgData then
return
end
local memberList=self.msgData.memberList or{}
for i,v in ipairs(memberList)do
if v.isleader==1 then
return i
end
end
end

function UIXianJie_JiJie_teamInfoWin:getAllMoneyList()
local moneyList
if self.isTeamInfo then
moneyList={}
local memberList=self.msgData.memberList
for i,memberData in pairs(memberList)do
local list=memberData.moneyList
moneyList[#moneyList+1]=list
end
else
moneyList={self.memberData.moneyList}
end
return moneyList
end





function UIXianJie_JiJie_teamInfoWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_teamInfoWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_JiJie_teamInfoWin:onChangeLeaderBtn()





















local infoguid=self.infoGuid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieTransfer
local actorId=self.showActorId
local params={tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)

self:onCloseBtn()
end



function UIXianJie_JiJie_teamInfoWin:onKickOutBtn()
local infoguid=self.infoGuid
local massActorId=self.massActorId
local actorId=self.showActorId


local lastCdStamp=xianjieModel:getJiJieSelfMassYBDCdStamp(infoguid,actorId)or 0
local cdTime=xianjieModel:getJiJieSelfMassYBDCd()
local nowTime=timeHelper.getServerShortTime()
if nowTime-lastCdStamp<cdTime then
UIManager.error("操作频繁，请稍后再试")
return
end

local func=function()
if not _this then return end
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieKickOut
local params={tostring(massActorId),tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)

self:onCloseBtn()
end

local playZmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
playZmData=xianjieModel:getMyZongMenData()
else
playZmData=xianjieModel:getZongMenData(actorId)
end
local nameStr=playZmData.actorname
local desc=FMT.fmt("是否踢出{0}？\n踢出后{0}将离开本次集结",nameStr)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end

function UIXianJie_JiJie_teamInfoWin:onHeadClick(index)
local actorId=self.showActorId
local dzlist=self.memberData.discipleList or{}
local isSelf=playerModel:checkActorId(self.showActorId)
local netData=dzlist[index]
local dzGuidList={}
local dzDataList={}
local needNewData=false
for posIndex,netData in ipairs(dzlist)do
local guid=netData.discipleguid
local has=netData~=nil and netData.flag>0
if has then
local dzData_=otherPlayerModel:getDZData(guid)
if not dzData_ then
needNewData=true
end
dzGuidList[#dzGuidList+1]=guid
dzDataList[#dzDataList+1]=dzData_
end
end
if isSelf then
otherPlayerController:openSelfPlayerDZInfoWin(dzGuidList,netData.discipleguid)
else
if not needNewData then

otherPlayerController:openOtherPlayerDZInfoWin2(netData.discipleguid,dzDataList)
else
local zmData=xianjieModel:getZongMenData(self.showActorId)
local serverid=zmData.serverid

local attach={serverid=serverid}
otherPlayerController:openOtherPlayerDZInfoWin(actorId,netData.discipleguid,needNewData,true,attach,dzGuidList)
end
end

end

function UIXianJie_JiJie_teamInfoWin:onClickYunZhouComponents(pos)
local equip=self.equipList[pos]
local suitData=XianYunGangModel:getOtherPlayerYunZhouComponentsSuitData(self.equipList)
if equip then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemguid=equip.itemguid,itemid=equip.itemid,attach={suitData=suitData,itemData=equip.itemData,pos=pos}})
end
end



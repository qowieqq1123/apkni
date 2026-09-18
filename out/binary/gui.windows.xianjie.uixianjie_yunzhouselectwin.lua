







def_class("UIXianJie_YunZhouSelectWin",UIWindowBase)









function UIXianJie_YunZhouSelectWin:bindComponents()

self.mask=UIButton.get(self,0)
self.selectDzClick=UIButton.get(self,1)
self.discipleScrollView=UIObject.get(self,2)
self.notDzTips=UIObject.get(self,3)
self.teamFightValueText=UIText.get(self,4)
self.changeShipPanel=UIObject.get(self,5)
self.shipName=UIText.get(self,6)
self.equipGridsGroup=UIObject.get(self,7)
self.zhenQiItem=UIBaseItem.get(self,8)
self.zhenQiSkillGroup=UIObject.get(self,9)
self.confirmBtn=UIButton.get(self,10)
self.yzNameText=UIText.get(self,11)
self.changeNameBtn=UIButton.get(self,12)
self.yzScrollView=UIObject.get(self,13)
self.closeBtn=UIButton.get(self,14)
self.bgModel=UIObject.get(self,15)
self.root=UIObject.get(self,16)
self.yzModel=UIObject.get(self,17)
self.clickTips=UIText.get(self,18)

self.mask:setButtonClick(function()self:onMask()end)

self.selectDzClick:setButtonClick(function()self:onSelectDzClick()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_YunZhouSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.selectDzClick);self.selectDzClick=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.notDzTips);self.notDzTips=nil;
_UIObject_release(self.teamFightValueText);self.teamFightValueText=nil;
_UIObject_release(self.changeShipPanel);self.changeShipPanel=nil;
_UIObject_release(self.shipName);self.shipName=nil;
_UIObject_release(self.equipGridsGroup);self.equipGridsGroup=nil;
_UIObject_release(self.zhenQiItem);self.zhenQiItem=nil;
_UIObject_release(self.zhenQiSkillGroup);self.zhenQiSkillGroup=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.yzNameText);self.yzNameText=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.yzScrollView);self.yzScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.yzModel);self.yzModel=nil;
_UIObject_release(self.clickTips);self.clickTips=nil;
end
















local _this
local _yunzhouItemCmpIndex={
bg=0,
select=1,
name=2,
useFlag=3,
}
local _dzItemCmpIndex=
{
name=0,
fight=1,
stateName=2,
head=3,
color=4,
job=5,
mask=6,
root=7,
stateImg=8,
self=9,
panel=10,
state=11,
tianminObj=12,
banFlag=13,
ban=14,
back_xianmo=15,
spDzFlag=16,
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

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}





function UIXianJie_YunZhouSelectWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_YunZhouSelectWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_YunZhouSelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5727,1,{},eAnimationID.enter)
self:delayDo(0.4,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.selectYzIndex=argtable and argtable.selectYzIndex
self.isCheckSMDData=argtable and argtable.isCheckSMDData
self.smdId=argtable and argtable.smdId
self.isIgnoreYzOccupy=argtable and argtable.isIgnoreYzOccupy
self.isOnlyEditTeam=argtable and argtable.isOnlyEditTeam
self.isCheckXJYZData=argtable and argtable.isCheckXJYZData
self.curTeamIndex=argtable and argtable.curTeamIndex
self.yzUsedLookup=argtable and argtable.yzUsedLookup
self.gx_id=argtable and argtable.gx_id
self.yzBoatDataList=argtable and argtable.yzBoatDataList
if not self.yzBoatDataList then
self.yzBoatDataList=XianYunGangModel:getBoatList()or{}
end

self.maxYunZhouCount=#self.yzBoatDataList
if not self.selectYzIndex then

local hasFreeTeam=false
for i=1,self.maxYunZhouCount do
local yzBdData=self.yzBoatDataList[i]
local yzId=yzBdData.boatid
local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and not next(chuZhengDzList)~=nil
if self.isIgnoreYzOccupy then
isUsing=false
end

if not isUsing and self.isCheckSMDData then

local yzSMDId=xianjieModel:GetYetYunzhou(yzId)
if yzSMDId~=0 and yzSMDId~=self.smdId then
isUsing=true
end
end

if not isUsing and self.isCheckXJYZData then

local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(yzId,self.gx_id)
if not isUsedYZ and self.yzUsedLookup[yzId]~=nil and self.yzUsedLookup[yzId]~=self.curTeamIndex then
isUsedYZ=true
end
if isUsedYZ then
isUsing=true
end
end
if not isUsing then
self.selectYzIndex=i
hasFreeTeam=true
break
end
end

if not hasFreeTeam then

self.selectYzIndex=1
end
end

self:refresh()
end


function UIXianJie_YunZhouSelectWin:onHide()

end

function UIXianJie_YunZhouSelectWin:refresh()

self.yunZhouDataList=xianjieModel:getXJYunZhouDataList()
if self.isCheckXJYZData then
self.yunZhouDataList=XianJunYanZhenModel:getXJYZYunZhouDataList()
end


self:refreshYunZhouList()


self:refreshSelectYunZhouInfo()
end

function UIXianJie_YunZhouSelectWin:refreshYunZhouList()
self.yzScrollView:setChildScrollViewCreateGrids(self.maxYunZhouCount,self.maxYunZhouCount)
local grids=self.yzScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local yzBdData=self.yzBoatDataList[i]
local yzId=yzBdData.boatid
local data=self.yunZhouDataList[yzId]or{}
local isSelect=self.selectYzIndex==i


widget:SetChildActive(_yunzhouItemCmpIndex.bg,not isSelect)
widget:SetChildActive(_yunzhouItemCmpIndex.select,isSelect)


local name=yzBdData.name

local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,yzId)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.name then
name=bdData.name
end
widget:SetChildText(_yunzhouItemCmpIndex.name,name)


local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and not next(chuZhengDzList)~=nil
if self.isIgnoreYzOccupy then
isUsing=false
end
if not isUsing and self.isCheckSMDData then

local yzSMDId=xianjieModel:GetYetYunzhou(yzId)
if yzSMDId~=0 and yzSMDId~=self.smdId then
isUsing=true
end
end
if not isUsing and self.isCheckXJYZData then

local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(yzId,self.gx_id)
if not isUsedYZ and self.yzUsedLookup[yzId]~=nil and self.yzUsedLookup[yzId]~=self.curTeamIndex then
isUsedYZ=true
end
if isUsedYZ then
isUsing=true
end
end
widget:SetChildActive(_yunzhouItemCmpIndex.useFlag,isUsing)

if not isSelect then

widget:SetChildButtonClick(_yunzhouItemCmpIndex.bg,function()
if _this==nil then return end
return _this:selectYunZhou(i)
end,true)
end
end
end

function UIXianJie_YunZhouSelectWin:refreshSelectYunZhouInfo()
local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local yzId=yzBdData.boatid
local data=self.yunZhouDataList[yzId]or{}


local name=yzBdData.name

local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,yzId)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.name then
name=bdData.name
end
self.yzNameText:setText(name)


local isUsedYZ=self.isCheckXJYZData and XianJunYanZhenModel:getIsUsedYZ(yzId,self.gx_id)


local teamDzList_lookup=data.team
local hasTeam=teamDzList_lookup~=nil and next(teamDzList_lookup)~=nil
self.notDzTips:setActive(not hasTeam)
self.clickTips:setActive(hasTeam)
self.discipleScrollView:setActive(hasTeam)
local dzFightList={}
if hasTeam then
local teamDzList={}
for idx,dzGuidStr in pairs(teamDzList_lookup)do
local dzGuid=int64.new(dzGuidStr)
teamDzList[#teamDzList+1]={
posIdx=idx,
dzGuid=dzGuid,
}
end

local dzCount=#teamDzList
self.discipleScrollView:setChildScrollViewCreateGrids(dzCount,dzCount)
local grids=self.discipleScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local teamDzData=teamDzList[i]
local guid=teamDzData.dzGuid
local netdata=UIDiscipleModel:getDiscipleData(guid)
if not netdata then
widget:SetChildActive(-1,false)
else
widget:SetChildActive(-1,true)


widget:SetChildText(_dzItemCmpIndex.name,UIDiscipleModel:getDiscipleName(guid))

local fightValue=UIDiscipleModel:getDiscipleFightValue(guid)
local dzGuidStr=tostring(guid)

dzFightList[dzGuidStr]=fightValue
widget:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))



local dzState,stateStr=xianjieModel:getDZState(guid,true)
local isOccupy=dzState~=nil
if self.isCheckXJYZData then

isOccupy=isUsedYZ
if isOccupy then
stateStr="锁定中"
end
local pos=self.yzUsedLookup[yzId]
if not isOccupy and pos~=nil and pos~=self.curTeamIndex then
isOccupy=true
stateStr=FMT.fmt("第{0}队",pos)
end
end
if isOccupy then

widget:SetChildActive(_dzItemCmpIndex.state,true)
widget:SetChildText(_dzItemCmpIndex.stateName,stateStr)
else
widget:SetChildActive(_dzItemCmpIndex.state,false)
end

comHelper.setChildModelRawImage(widget,guid,_dzItemCmpIndex.head,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
widget:SetChildActive(_dzItemCmpIndex.spDzFlag,isSpDz)

UIDiscipleController.refreshCommonItemTianMing(widget,netdata,_dzItemCmpIndex.tianminObj)

UIDiscipleModel:setDiscipleXianMoBackImage(widget,_dzItemCmpIndex.back_xianmo,netdata)
end
end
end


self:refreshYzEquipPanel()




local teamFightValue=xianjieModel:getXJYZTeamFightValue(dzFightList)
self.teamFightValueText:setText(mathHelper.formatNumber(teamFightValue))



local yzModelId=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'defaultBoatModelId')
self.yzModel:setChildUIModelShowTarget(yzModelId,0.5,nil,eAnimationID.stand)

if self.isCheckXJYZData then
self.confirmBtn:setActive(not isUsedYZ)
end
end

function UIXianJie_YunZhouSelectWin:refreshYzEquipPanel()
for i=1,3 do
self:refreshYzEquipItemEx(i)
end
end

function UIXianJie_YunZhouSelectWin:selectYunZhou(yzIndex)
if self.selectYzIndex==yzIndex then
return
end
self.selectYzIndex=yzIndex
self:refresh()
end

function UIXianJie_YunZhouSelectWin:changeNameRecv(changeName)







self:refresh()
end

function UIXianJie_YunZhouSelectWin:refreshYzEquipItemEx(idx)
local widget=self.equipGridsGroup:getChildCommonLayoutGroupWidgetItem(idx-1)
local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local boatid=yzBdData.boatid
local equip=XianYunGangModel:getYunZhouComponentsPosData(boatid,idx)
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
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,true)
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





function UIXianJie_YunZhouSelectWin:onMask()
self:onCloseBtn()
end



function UIXianJie_YunZhouSelectWin:onSelectDzClick()


local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local yzId=yzBdData.boatid
if self.isCheckXJYZData then
local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(yzId,self.gx_id)
if isUsedYZ then
return UIManager.error("该云舟已锁定 无法布置")
end
end
local isCheckSMDData=self.isCheckSMDData
local isOnlyEditTeam=self.isOnlyEditTeam
local smdId=self.smdId
local gx_id=self.gx_id
self:showWindow("UIXianJie_yzTeamSelectWin",{yzIndex=yzId,isCheckSMDData=isCheckSMDData,smdId=smdId,isOnlyEditTeam=isOnlyEditTeam,isCheckXJYZData=self.isCheckXJYZData,gx_id=gx_id})
end



function UIXianJie_YunZhouSelectWin:onConfirmBtn()

local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local yzId=yzBdData.boatid
local data=self.yunZhouDataList[yzId]or{}
local teamDzList_lookup=data.team
local hasTeam=teamDzList_lookup~=nil and next(teamDzList_lookup)~=nil
if not hasTeam then
return UIManager.error("当前队伍没有选择弟子 无法布置")
end


local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil
if self.isIgnoreYzOccupy then
isUsing=false
end
if not isUsing and self.isCheckSMDData then

local yzSMDId=xianjieModel:GetYetYunzhou(yzId)
if yzSMDId~=0 and yzSMDId~=self.smdId then
isUsing=true
end
end
if self.isCheckXJYZData then
local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(yzId,self.gx_id)
if isUsedYZ then
return UIManager.error("该云舟已锁定 无法布置")
end






end
if isUsing then
return UIManager.error("该云舟已出征 无法布置")
end






UIManager:invokeUIMethod("UIXianJie_YunZhouPrepareWin","onYunZhouTeamSelectRecv",yzId)
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onYunZhouTeamSelectRecv",yzId)
self:onCloseBtn()
end



function UIXianJie_YunZhouSelectWin:onChangeNameBtn()

















local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local yzId=yzBdData.boatid
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,yzId)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
local rename_conf=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'rename_conf')
if rename_conf==nil then
UIManager.error('该建筑没有改名配置')
return
end
local sfId=mapIdType.fort
UIManager:showWindow('UIBuildChangeNameWin',{sfId=sfId,bdData=bdData})

end



function UIXianJie_YunZhouSelectWin:onCloseBtn()
self:closeSelf()
end

function UIXianJie_YunZhouSelectWin:onClickYunZhouComponents(pos)
local yzBdData=self.yzBoatDataList[self.selectYzIndex]
local boatid=yzBdData.boatid

local equip=XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
if equip then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYunZhouComponents,itemguid=equip.itemguid,itemid=equip.itemid,attach={yzId=boatid,pos=pos}})
else
local callFunc=function()
self:showWindow("UIYunZhouComponentsGainWin",{boat_id=boatid,pos=pos})
end
XianJunYanZhenModel:showXJYZUsedDialouge({boat_id=boatid,callFunc=callFunc})
end
end

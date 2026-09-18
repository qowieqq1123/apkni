







def_class("UIShouLanInfoWin",UIWindowBase)









function UIShouLanInfoWin:bindComponents()

self.changeBtn=UIButton.get(self,0)
self.buildModel=UIObject.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.decorate=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.name=UIText.get(self,5)
self.volume=UIText.get(self,6)
self.chucun=UIObject.get(self,7)
self.emScrollView=UIObject.get(self,8)
self.addExp=UIText.get(self,9)
self.rwScrollView=UIObject.get(self,10)
self.emTips=UIText.get(self,11)
self.ccvalue=UIText.get(self,12)
self.volumeGroup=UIObject.get(self,13)
self.decorateAdd=UIObject.get(self,14)
self.decorateIcon=UIImage.get(self,15)
self.getRewardBtn=UIButton.get(self,16)
self.costGroup=UIObject.get(self,17)
self.rwGroup=UIObject.get(self,18)
self.decorateNameText=UIText.get(self,19)
self.notLsTips=UIObject.get(self,20)
self.buildEffect=UIObject.get(self,21)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.decorate:setButtonClick(function()self:onDecorate()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)



end


function UIShouLanInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.buildModel);self.buildModel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.decorate);self.decorate=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.volume);self.volume=nil;
_UIObject_release(self.chucun);self.chucun=nil;
_UIObject_release(self.emScrollView);self.emScrollView=nil;
_UIObject_release(self.addExp);self.addExp=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.emTips);self.emTips=nil;
_UIObject_release(self.ccvalue);self.ccvalue=nil;
_UIObject_release(self.volumeGroup);self.volumeGroup=nil;
_UIObject_release(self.decorateAdd);self.decorateAdd=nil;
_UIObject_release(self.decorateIcon);self.decorateIcon=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.costGroup);self.costGroup=nil;
_UIObject_release(self.rwGroup);self.rwGroup=nil;
_UIObject_release(self.decorateNameText);self.decorateNameText=nil;
_UIObject_release(self.notLsTips);self.notLsTips=nil;
_UIObject_release(self.buildEffect);self.buildEffect=nil;
end
















local _this
local cmpVolumeItemIdx={
notSelect=0,
select=1,
green=2,
red=3,
}




function UIShouLanInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.emScrollView:setChildScrollViewInit(0,true,self.on_element_click,nil)

end


function UIShouLanInfoWin:__delete()
self:unbindComponents()

_this=nil
end

function UIShouLanInfoWin.on_element_click(num,index)
local data=_this.elementData[index+1]
local widget=_this.emScrollView:getChildScrollViewItemWidget(index)
local pos=widget:GetChildUIScreenPos(0)
UIShouLanControl:showElementInfoWin(pos,{0,-35},data[2],data[1]==1)
end




function UIShouLanInfoWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
if guid>0 then
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
if argtable.unBuildID then
self.unBuildID=argtable.unBuildID
self.bdData=zongmenModel:getBuildingData(self.unBuildID)
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
end

self.sfId=zongmenModel:getMountainId()
self:refresh()
end

function UIShouLanInfoWin:onShowArgRecv()
self:refresh()
end


function UIShouLanInfoWin:onHide()

end

function UIShouLanInfoWin:refresh()
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,sldata.build_id)



local modelID=self:getBuildModelId(self.bdData.build_id,self.bdData.level)
local scale=isometricMapSystem:getModelScale(modelID,true)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.buildModel:getID(),true,true,true)
end
scale=slcfg.uiModelScale or scale*0.8
local offset=slcfg.uiModelOffset or{0,0}
self.buildModel:setChildUIModelShowTarget(modelID,scale,nil,eAnimationID.stand)
self.buildModel:setChildUIModelShowTargetOffset(offset[1],offset[2])

self.name:setText(cfg.name)

self:refreshVolumePanel()

local maxVal=slcfg.max_item_cnt
local currVal=UIShouLanModel:getStoreNum(self.bdData.un_build_id)
self.chucun:setChildUIProgressbar(currVal,maxVal,false)
self.ccvalue:setText(FMT.fmt('{0}/{1}',currVal,maxVal))
local costList=slcfg.keep_cost


local maintenanceRate=self:getMaintenanceRate()
local costCount=#costList
self.costGroup:setChildLayoutGroupCreateItems(costCount,function(index)
local widget=self.costGroup:getChildLayoutGroupGridItem(index-1)
local cost=costList[index]
if cost then
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,iconHelper.getIconName(cost[1]),false)
local val=mathHelper.safe_ceil(cost[2]*maintenanceRate)
widget:SetChildText(1,FMT.fmt('{0}/年',val))
end
end)


self.addExp:setText(FMT.fmt('{0}点境界修为/年',slcfg.add_xiuwei))

self.elementData=feedingSystem:getElementDataSL(self.bdData.un_build_id,1)
feedingSystem:setElementList(self.winlua,self.emScrollView:getID(),self.elementData)
self.emTips:setText(#self.elementData<=0 and'无'or'')
self:setRewardList()

self:refreshDecorate()
end

function UIShouLanInfoWin:getMaintenanceRate()
local rate=1
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
for k,v in pairs(sldata.petBaseInfoLookup)do
local lsData=lingshouModel:getLingShouData(k)
local srate=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.SHOULAN_MAINTENANCE_COST_RATE)
rate=rate+srate
end
return rate
end

function UIShouLanInfoWin:getBuildModelId(build_id,level)
level=level or 1
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
if bdCfg.sp_ui_model then
if bdCfg.sp_ui_model[level]then
return bdCfg.sp_ui_model[level]
else
local showLv
for lv,cfg in pairs(bdCfg.sp_ui_model)do
if level>=lv then
if not showLv or lv>showLv then
showLv=lv
end
end
end
return bdCfg.sp_ui_model[showLv]
end
end
end

function UIShouLanInfoWin:refreshVolumePanel()
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,sldata.build_id)
local buildVolume=slcfg.volume
local nowUseVolume=UIShouLanModel:getMonsterVolume(self.bdData.un_build_id)
local nowSelectVolume=0
local previewSelectCount=nowUseVolume+nowSelectVolume
local maxShowCount=buildVolume

self.volumeGroup:setChildLayoutGroupCreateItems(maxShowCount,function(index)
local widget=self.volumeGroup:getChildLayoutGroupGridItem(index-1)
local isSelect=index<=nowUseVolume
local isPreview=not isSelect and index<=previewSelectCount
local isGreen=isPreview and previewSelectCount<=buildVolume
local isRed=isPreview and previewSelectCount>buildVolume
local isNotSelect=not isSelect and not isPreview and index<=buildVolume

widget:SetChildActive(cmpVolumeItemIdx.notSelect,isNotSelect)
widget:SetChildActive(cmpVolumeItemIdx.select,isSelect)
widget:SetChildActive(cmpVolumeItemIdx.green,isGreen)
widget:SetChildActive(cmpVolumeItemIdx.red,isRed)
end)
end

function UIShouLanInfoWin:setRewardList()
local rewards=self:getRewardList()
local len=#rewards


self.notLsTips:setActive(len<=0)
self.rwGroup:setChildLayoutGroupCreateItems(len,function(index)
local itemWidget=self.rwGroup:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemId=data[1]
local itemCount=data[2]

local countStr=mathHelper.formatNumber(itemCount)
local showCountBG=true
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
return self:onClickRewardItem(...)
end)
end)

local isCanGetReward=false
for i=1,len do
local data=rewards[i]
local itemCount=data[2]
if itemCount>0 then
isCanGetReward=true
end
end
self.getRewardBtn:setActive(isCanGetReward)
end

function UIShouLanInfoWin:getLSRewardId(cdatas,level)
for i,v in ipairs(cdatas)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
return nil
end

function UIShouLanInfoWin:getLSRewardIdList(cdatas,level)
local rewardIdList={}
for i,v in ipairs(cdatas)do
if level>=v[1]and level<=v[2]then
rewardIdList[#rewardIdList+1]=v[3]
end
end
return rewardIdList
end

function UIShouLanInfoWin:getRewardList()
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
local rwlist={}
local dlist={}
local hasRwLookup={}
for k,v in pairs(sldata.petBaseInfoLookup)do
local lsdata=lingshouModel:getLingShouData(k)
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsdata.id)
if lscfg.item_create then

local rwIdList=self:getLSRewardIdList(lscfg.item_create,lsdata.jj_lvl)
for _,rwId in ipairs(rwIdList)do
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
if rwcfg then
for ii,vv in ipairs(rwcfg.showItems)do

dlist[vv[1]]=vv
end
end
end
end
local hasRewardList=v.commItem
for i,item in ipairs(hasRewardList)do
local itemId=item.param_1
local itemCount=item.param_2
if hasRwLookup[itemId]then
hasRwLookup[itemId]=hasRwLookup[itemId]+itemCount
else
hasRwLookup[itemId]=itemCount
end
end
end
for itemId,v in pairs(dlist)do
local itemCount=hasRwLookup[itemId]or 0
table_insert(rwlist,{itemId,itemCount})
end

if#rwlist>0 then
table.sort(rwlist,function(a,b)
local itemId_a=a[1]
local itemId_b=b[1]
local itemColor_a=itemsConfig.getItemColor(itemId_a)
local itemColor_b=itemsConfig.getItemColor(itemId_b)
if itemColor_a==itemColor_b then
return itemId_a<itemId_b
else
return itemColor_a>itemColor_b
end
end)
end
return rwlist
end

function UIShouLanInfoWin:refreshDecorate()
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,sldata.build_id)
local isOpenSLDecorateSys=systemModel.isOpen(SYSTEM_DEFINE.eShouLanDecorate)

local isShowDecorate=slcfg.decorate~=nil and isOpenSLDecorateSys
self.decorate:setActive(isShowDecorate)
if isShowDecorate then

local currItemId=sldata.decorate_id
local hasDecorate=currItemId~=nil and currItemId>0
self.decorateAdd:setActive(not hasDecorate)
self.decorateIcon:setActive(hasDecorate)
local decorateStr="添加装饰"
if hasDecorate then
self.decorateIcon:setIcon(iconHelper.getIconName(currItemId),true)
local decorateCfg=cfgHelper.get(cfg_petdecorateconfig_get,currItemId)
if decorateCfg then
decorateStr=decorateCfg.name
end
end
self.decorateNameText:setText(decorateStr)
end
end


function UIShouLanInfoWin:onFinishShouLanTypeChange(slId)
if slId==self.bdData.un_build_id then

self.buildEffect:setChildShowEffect(10685,true)
self:refresh()
end
end



function UIShouLanInfoWin:onChangeBtn()
UIManager:showWindow('UIShouLanSelectWin',self.bdData)
end

function UIShouLanInfoWin:onDecorate()
UIManager:showWindow('UISLDecorateWin',self.bdData)
end

function UIShouLanInfoWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name="ui_shouLan_rule_%d"
UIManager:showWindow('UIRuleWin',d)
end

function UIShouLanInfoWin:onGetRewardBtn()
UIShouLanControl:receiveSLReward(self.bdData.un_build_id)
end

function UIShouLanInfoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
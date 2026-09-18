







def_class("UIMonsterSelect",UIWindowBase)









function UIMonsterSelect:bindComponents()

self.root=UIObject.get(self,0)
self.scrollView=UIObject.get(self,1)
self.applyBtn=UIButton.get(self,2)
self.shaixuan=UIToggleButton.get(self,3)
self.sortBtn=UIButton.get(self,4)
self.volume=UIText.get(self,5)
self.applyBtnText=UIText.get(self,6)
self.volumeGroup=UIObject.get(self,7)
self.noLSTips=UIObject.get(self,8)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.sortBtn:setButtonClick(function()self:onSortBtn()end)



end


function UIMonsterSelect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.shaixuan);self.shaixuan=nil;
_UIObject_release(self.sortBtn);self.sortBtn=nil;
_UIObject_release(self.volume);self.volume=nil;
_UIObject_release(self.applyBtnText);self.applyBtnText=nil;
_UIObject_release(self.volumeGroup);self.volumeGroup=nil;
_UIObject_release(self.noLSTips);self.noLSTips=nil;
end
















local _this

local _item_index={
select=0,
zizhi=1,
zhuangtai=2,
volumeGroup=3,
emScrollView=4,
lsItem=5,
detailBtn=6,
}

local cmpVolumeItemIdx={
notSelect=0,
select=1,
green=2,
red=3,
}

local lsItemCmpIdx={
back=0,
name=1,
rawImage=2,
sign=3,
desc=4,
fight=5,
reddot=6,
generationBg=7,
generationText=8,
}




function UIMonsterSelect:onLoaded(...)
self:bindComponents()

self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)

_this=self

self.sortCondition={}
self.sortType=eDiscipleSortType.eFightSort
self.sortOrder=eSortOrder.eDown

self.onlyCanUse=true
self.shaixuan:setToggleChange(function(name,isOn,data)
self.onlyCanUse=isOn
self:showList()
end)

self.scrollView:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UIMonsterSelect:__delete()
self:unbindComponents()

_this=nil
end

function UIMonsterSelect.on_item_click(clicknum,index)
if _this.selectIndex then
local item=_this.scrollView:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(_item_index.select,false)
end

_this.selectIndex=index

local item=_this.scrollView:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(_item_index.select,true)

_this:refreshVolumePanel()
end

function UIMonsterSelect:getDatas()
local slId=self.args.slId
local stId=self.args.stId
local datas=self:getSortList()
local list={}
for k,v in pairs(datas)do
local lsSlId=UIShouLanModel:getShouLanUbdIdByLsGuid(v.guid)
if not lsSlId or lsSlId~=stId then

local volume=lingshouModel.getLingShouPropertyValEx(v.guid,lingshouPropertyType.VOLUME)
if not self.onlyCanUse or(UIShouLanModel:isCanPutIn(slId,volume)and not lingshouModel.checkStateExistEx(v.pet_state,eLingShouStateType.petBuild)and lingshouModel:canStateChangeEx(v.pet_state,eLingShouStateType.petBuild))then
table.insert(list,v)
end
end
end
table.sort(list,function(a,b)
local lsSlId_a=UIShouLanModel:getShouLanUbdIdByLsGuid(a.guid)
local lsSlId_b=UIShouLanModel:getShouLanUbdIdByLsGuid(b.guid)
if not lsSlId_a and lsSlId_b then
return true
elseif lsSlId_a and not lsSlId_b then
return false
else
if a.jj_lvl>b.jj_lvl then
return true
elseif a.jj_lvl<b.jj_lvl then
return false
else
return a.id<b.id
end
end
end)
return list
end




function UIMonsterSelect:onShow(argtable,afterOnloaded)
self.args=argtable
self:showList()
if#self.datas>0 then
self.on_item_click(0,0)
end






self:refreshVolumePanel()
end


function UIMonsterSelect:onHide()

end

function UIMonsterSelect:showList()
local datas=self:getDatas()
self.datas=datas
local len=#datas



local un_build_id=self.args.slId
local attrs=feedingSystem:getElementDataSL(un_build_id,1)
local checklist={{},{}}
for i,v in ipairs(attrs)do
checklist[v[1]][v[2]]=true
end
self.scrollView:setChildScrollViewDelayCreateGrids(len,2,0.02,1,false,false,function(index,item)
local data=datas[index+1]
local cfg=cfgHelper.get1(cfg_lingshouconfig_get,data.id)


local lsItemWidget=item:GetChildWidgetBase(_item_index.lsItem)
comHelper.setChildModelRawImage_lingshou(lsItemWidget,data.id,lsItemCmpIdx.rawImage,0,eHeadCenterType.eHead,1)
local lsName=data.name or cfg.name
lsItemWidget:SetChildText(lsItemCmpIdx.name,lsName)
local color=lingshouModel:getColor(data.guid)
lsItemWidget:SetChildCSImageSprite(lsItemCmpIdx.back,globalABLookup.lingshoumain,lingshouColorToFrame[color])
lsItemWidget:SetChildText(lsItemCmpIdx.desc,lingshouModel:getJJName(data.guid,3))
lsItemWidget:SetChildActive(lsItemCmpIdx.sign,cfg.bianyi==1)

item:SetChildText(_item_index.zizhi,lingshouModel.getLingShouPropertyVal(data,lingshouPropertyType.ZIZHI))

local lsSlId=UIShouLanModel:getShouLanUbdIdByLsGuid(data.guid)
if lsSlId then

local bdData=zongmenModel:getBuildingData(lsSlId)
local name=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'name')
item:SetChildText(_item_index.zhuangtai,name)
else
item:SetChildText(_item_index.zhuangtai,'暂无兽栏')
end


local volumeCount=lingshouModel.getLingShouPropertyValEx(data.guid,lingshouPropertyType.VOLUME)
item:SetChildLayoutGroupCreateItems(_item_index.volumeGroup,volumeCount)


local elementData=feedingSystem:getElementDataM(cfg)
feedingSystem:setElementList(item,_item_index.emScrollView,elementData,checklist)


item:SetChildButtonClick(_item_index.detailBtn,function()
if not _this or not _this.isVisible then return end
return _this:onClickLsDetailBtn(data.guid)
end,true)

end)

self.noLSTips:setActive(len<=0)
end

function UIMonsterSelect:refreshVolumePanel()
local sldata=UIShouLanModel:getShouLanData(self.args.slId)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,sldata.build_id)
local buildVolume=slcfg.volume
local nowUseVolume=UIShouLanModel:getMonsterVolume(self.args.slId)
local nowSelectVolume=0
if self.selectIndex then
local data=self.datas[self.selectIndex+1]
if data then
nowSelectVolume=lingshouModel.getLingShouPropertyValEx(data.guid,lingshouPropertyType.VOLUME)
end
end
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





function UIMonsterSelect:onApplyBtn()
if self.selectIndex then
local data=self.datas[self.selectIndex+1]
if not UIShouLanModel:isCanPutIn(self.args.slId,data.cfg.volume,true)then

return
end

local slTrait,wordID=lingshouModel:checkLingShouHasTraitTypeEx(data.guid,lingshouTraitEffectEnum.LINGSHOU_LIVE_NO_OTHER_RACE)
if slTrait then
local rateLookup=UIShouLanModel:getShouLanLingShouRaceList(self.args.slId)
local len=table.numsEx(rateLookup)
if len>1 or(len==1 and rateLookup[data.cfg.race]==nil)then
local wordName=cfgHelper.get(cfg_lingshouwordconfig_get,wordID,'name')
local content=FMT.fmt("{0}的{1}特性,无法与其他种族的灵兽在同一兽栏",toColorString(FONT_COLOR.eOrangeColor,data.name),toColorString(FONT_COLOR.eOrangeColor,wordName))
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确认',
okcallback=function()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end
end
local inHas,sLsGuid,sWordID=UIShouLanModel:checkShouLanNoLingShouRaceTrait(self.args.slId,data.cfg.race)
if inHas then
local lsData=lingshouModel:getLingShouData2(sLsGuid)
local wordName=cfgHelper.get(cfg_lingshouwordconfig_get,sWordID,'name')
local content=FMT.fmt("兽栏中{0}的{1}特性,无法与其他种族的灵兽在同一兽栏",toColorString(FONT_COLOR.eOrangeColor,lsData.name),toColorString(FONT_COLOR.eOrangeColor,wordName))
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确认',
okcallback=function()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local lsSlId=UIShouLanModel:getShouLanUbdIdByLsGuid(data.guid)
if lsSlId then

local bdData=zongmenModel:getBuildingData(lsSlId)
if not feedingSystem:isCanRemove(bdData.un_build_id,data.guid,true)then
return
end
end
local callback=function()
if lsSlId then

local bdData=zongmenModel:getBuildingData(lsSlId)
UIShouLanControl:reqRemoveFormShouLan(bdData.un_build_id,1,{data.guid})
end
UIShouLanControl:reqAddToShouLan(self.args.slId,1,{data.guid})
UIManager:invokeUIMethod('UICommonDragonBoneWin','onClickClose')
end
if lsSlId then
self:showTipsDialog('该灵兽已在别的兽栏，确定要转移到该兽栏吗？',callback)
else
callback()
end
end
end



function UIMonsterSelect:getSortList()
local list=lingshouLookup:getSortList(self.sortType,self.sortCondition,self.sortOrder)
return list
end

function UIMonsterSelect:onSortBtn()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=lingshouLookup:getConditonFilter(self.sortCondition)
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIMonsterSelect.selecConditionBack(data)
if _this==nil then
return
end

_this.filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(_this.filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:showList()
end

function UIMonsterSelect:showTipsDialog(content,callback)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',




okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIMonsterSelect:onClickLsDetailBtn(lsGuid)
local lsList=self.datas
UIFullLingShouMainControl:showWindow_SingleInfoTab(self,{
lslist=lsList,
ls_guid=lsGuid,

hideOrderBtn=true,
},{ls_guid=lsGuid,})
end








def_class("UISubAct_xianjieqiyuan_SelectLoveDialog",UIWindowBase)









function UISubAct_xianjieqiyuan_SelectLoveDialog:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.fullTips=UIText.get(self,2)
self.havenotTips=UIText.get(self,3)
self.chongGrid=UIObject.get(self,4)
self.moneyRoot=UIButton.get(self,5)
self.orientationImg=UIImage.get(self,6)
self.nameImg=UIImage.get(self,7)
self.detailpBtn=UIButton.get(self,8)
self.gailv_Btn=UIButton.get(self,9)
self.xiaoren=UIObject.get(self,10)
self.selectBtn=UIButton.get(self,11)
self.filterBtn=UIButton.get(self,12)
self.haveTgg=UIToggleButton.get(self,13)
self.closeBtn=UIButton.get(self,14)
self.scrollView=UIObject.get(self,15)
self.lihui=UIObject.get(self,16)
self.model=UIObject.get(self,17)
self.moneyIcon=UIImage.get(self,18)
self.moneyDesc=UIText.get(self,19)
self.selectTx=UIText.get(self,20)
self.gailvspine=UIObject.get(self,21)

self.background:setButtonClick(function()self:onBackground()end)

self.moneyRoot:setButtonClick(function()self:onMoneyRoot()end)

self.detailpBtn:setButtonClick(function()self:onDetailpBtn()end)

self.gailv_Btn:setButtonClick(function()self:onGailv_Btn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.gailv={
["Btn"]=self.gailv_Btn,
}



end


function UISubAct_xianjieqiyuan_SelectLoveDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.havenotTips);self.havenotTips=nil;
_UIObject_release(self.chongGrid);self.chongGrid=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.orientationImg);self.orientationImg=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.detailpBtn);self.detailpBtn=nil;
_UIObject_release(self.gailv_Btn);self.gailv_Btn=nil;
_UIObject_release(self.xiaoren);self.xiaoren=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.haveTgg);self.haveTgg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.lihui);self.lihui=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyDesc);self.moneyDesc=nil;
_UIObject_release(self.selectTx);self.selectTx=nil;
_UIObject_release(self.gailvspine);self.gailvspine=nil;
self.gailv=nil;
end















local _this=nil
local _listItemCmp={
root=-1,
back=0,
select=1,
name=2,
rawImage=3,
job=4,
desc=5,
orientation=6,
tuijian=7,
choosed=8,
}
local _modelCmp={
click=0,
lihui=1,
detailpBtn=2,
orientation=3,
tuijian=4,
xiaoren=5,
name=6,
select=7,
select2=8,
xiaorenBtn=9,
tianmingLvText=10,
chongGrid=11,
moneyIcon=12,
moneyDesc=13,
moneyObj=14,
}
local _abName="ui/windows/activities/sub_xianjieqiyuan/xianjieqiyuan_atlas_pak.ab"



function UISubAct_xianjieqiyuan_SelectLoveDialog:onLoaded(...)
self:bindComponents()
_this=self


self.haveTgg:setToggle(self._ownedFlag)
self.haveTgg:setToggleChange(function(...)self:onHaveToggleChanged(...)end)
end


function UISubAct_xianjieqiyuan_SelectLoveDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_xianjieqiyuan_SelectLoveDialog:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.current=argtable.current
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)

self:refreshList()
self:selectDefault()
end


function UISubAct_xianjieqiyuan_SelectLoveDialog:onHide()

end



function UISubAct_xianjieqiyuan_SelectLoveDialog:onBackground()
self:onCloseBtn()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow("UISubAct_xianjieqiyuan_SelectLoveDialog")
else
self:closeSelf()
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onHaveToggleChanged(name,isToggle,data)
self._ownedFlag=isToggle
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterOwnedFlag",self._ownedFlag)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianJieQiYuan)
self:refreshList()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onSelectBtn()
if self.selectData then
if self.selectData.index==self.current then
UIManager.info("已选中该名弟子")
else
local json_str=jsonHelper.encode({1,self.selectData.index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,json_str)

end
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:initFilterData()
if self._filterName==nil then
local cfg=cfg_disciplevocationconfig()
local temp={}
local jobNames={}
local orientationNames={}
for i,v in pairsBySortKey(cfg)do
table.insert(jobNames,{name=v.name,id=i})
temp[v.orientation]=true
end
for i,v in pairsBySortKey(temp)do
local c=cfgHelper.get1(cfg_disciplevocationorientationconfig_get,i)
table.insert(orientationNames,{name=c.name,id=i})
end
self._filterName={}
self._filterName[1]={"定位",orientationNames}
self._filterName[2]={"职业",jobNames}
end
if self._filterFlag==nil then
self._jobFlags=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterJobFlag",{})
self._orientationFlags=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterOrientationFlag",{})
self._filterFlag={}
self._filterFlag[1]={}
for i,v in ipairs(self._filterName[1][2])do
self._filterFlag[1][i]=self._orientationFlags[v.id]or nil
end
self._filterFlag[2]={}
for i,v in ipairs(self._filterName[2][2])do
self._filterFlag[2][i]=self._jobFlags[v.id]or nil
end
end
if self._ownedFlag==nil then
self._ownedFlag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterOwnedFlag",false)
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onFilterBtn()
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.extraWin='UIFilterThreeWin'
local extraParams={filterName=self._filterName,filterFlag=self._filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog.selecConditionBack(data)
if _this==nil then
return
end

_this._filterFlag=data.filterFlag
local orientationFlags=data.filterFlag[1]
local orientationNames=data.filterName[1][2]
for i,v in ipairs(orientationNames)do
_this._orientationFlags[v.id]=orientationFlags[i]or nil
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterOrientationFlag",_this._orientationFlags)

local jobFlags=data.filterFlag[2]
local jobNames=data.filterName[2][2]
for i,v in ipairs(orientationNames)do
_this._jobFlags[v.id]=jobFlags[i]or nil
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianJieQiYuan,"filterJobFlag",_this._jobFlags)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianJieQiYuan)

_this:refreshList()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:refreshList()
self.listData={}
self.selectIndex=nil
local checkJob=false
local checkOrientation=false
local checkToggle=false
local tmCfg=cfg_discipletianminglevelconfig()
local tmMax=#tmCfg
for i,v in ipairs(self.config.disciple)do
local itemID=v[1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local dzID=dzData.id
local findInfos=UIDiscipleModel:findDisciplesByID(dzID)
local finds={}
for i,v in ipairs(findInfos)do
finds[#finds+1]=UIDiscipleModel:getDiscipleDataByStr(v.discipleguidStr)
end
local owned=#finds>0
local job=dzData.imageInfo.job
local orientation=UIDiscipleModel:getJobOrientation(job,dzID)
if checkJob and not self._jobFlags[job]then

elseif checkOrientation and not self._orientationFlags[orientation]then

elseif self._ownedFlag and owned then

else
local weights={}
weights[1]=i==self.config.defaultdz and 0 or 1
weights[5]=i
if owned then
local tmLv=UIDiscipleModel:getTianMingLevelEx(finds[1])
weights[2]=1
weights[3]=tmLv>=tmMax and 1 or 0
weights[4]=tmMax-tmLv
else
weights[2]=0
weights[3]=0
weights[4]=0
end
table.insert(self.listData,{index=i,finds=finds,disciple=dzData,sortWeight=weights})
if self.selectData and self.selectData.index==i then
self.selectIndex=#self.listData
end
if not checkToggle and not owned then
checkToggle=true
end
end
end
table.sort(self.listData,self.sortListData)
local listCnt=#self.listData
self.scrollView:setChildScrollViewCreateGrids(listCnt,3)
if listCnt>0 then
for i=1,listCnt do
self:refreshListItem(i)
end
end
self.haveTgg:setActive(checkToggle)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog.sortListData(a,b)
for i=1,5 do
local weightA=a.sortWeight[i]
local weightB=b.sortWeight[i]
if weightA~=weightB then
return weightA<weightB
end
end
return false
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:selectDefault()
if self.selectIndex then return end
for index,data in ipairs(self.listData)do
if data.index==self.current then
self:onClickItem(index,data)
return
end
end
self:onClickItem(1,self.listData[1])
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:refreshListItem(index)
local item=self.scrollView:getChildScrollViewItemWidget(index-1)
local data=self.listData[index]
local dzData=data.disciple
local imageInfo=dzData.imageInfo
local color=imageInfo.color
local jobid=imageInfo.job
local isSelect=self.selectData and dzData.srctype==self.selectData.disciple.srctype or false
local isOwned=#data.finds>0
local isRecommond=data.index==self.config.defaultdz
local isChoosed=data.index==self.current
local iconname=cfgHelper.get3(cfg_discipletianmingfloorconfig_get,0,'colorframe',color)
item:SetChildCSImageSprite(_listItemCmp.back,globalABLookup.diciplecolorframe,iconname)
item:SetChildActive(_listItemCmp.select,isSelect)
item:SetChildText(_listItemCmp.name,dzData.disciplename)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelRawImageEx(_listItemCmp.rawImage,item,modelParams,eHeadCenterType.eHead,nil,false)
item:SetChildCSImageSprite(_listItemCmp.job,globalABLookup.global,UIDiscipleModel:getJobIconName(jobid))
item:SetChildText(_listItemCmp.desc,isOwned and"已拥有"or"未拥有")
local abname,icon=UIDiscipleModel:getJobOrientationIcon(imageInfo.job,dzData.id)
item:SetChildCSImageSprite(_listItemCmp.orientation,abname,icon)
item:SetChildActive(_listItemCmp.tuijian,isRecommond)
item:SetChildActive(_listItemCmp.choosed,isChoosed)
item:SetChildButtonClick(_listItemCmp.root,function()
self:onClickItem(index,data)
end)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onClickItem(index,data)
if self.selectIndex then
local selectItem=self.scrollView:getChildScrollViewItemWidget(self.selectIndex-1)
selectItem:SetChildActive(_listItemCmp.select,false)
end

self:onSelectItem(data)
self.selectIndex=index
self.selectData=data

local selectItem=self.scrollView:getChildScrollViewItemWidget(self.selectIndex-1)
selectItem:SetChildActive(_listItemCmp.select,true)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onSelectItem(data)
local item=self.model:getChildWidgetBase()
local dzData=data.disciple
local info=dzData.imageInfo
local itemID=dzData.srctype
local owned=#data.finds>0
local orientation=UIDiscipleModel:getJobOrientation(info.job,dzData.id)
local dzPos=self.config.dzpos[itemID]
local nameImageName=dzPos[5]
local offsetx=dzPos[6]or 0
local offsety=dzPos[7]or 0
local scale=dzPos[8]or 1
local flipx=dzPos[9]==1

local args={isNotBg=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)



self.lihui:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,false,0)
self.lihui:setChildUIModelShowTargetOffset(offsetx,offsety)
self.lihui:setChildUIModelShowFlipX(flipx)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
self.xiaoren:setChildUIModelShowTarget(modelParams.body,0.75,modelParams.componets,eAnimationID.stand,false,false,0)

self.nameImg:setSprite(_abName,nameImageName)

local icon=cfgHelper.get2(cfg_disciplevocationorientationconfig_get,orientation,'xjqyicon')
self.orientationImg:setSprite(_abName,icon)

self.moneyRoot:setActive(owned and data.sortWeight[3]==0)
self.havenotTips:setActive(not owned)
if owned then
local netData=data.finds[1]
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local cost=UIDiscipleModel:getUpTianMingCost(netData)
local itemid=cost[1][1]
local itemNum=cost[1][2]
local has_itemNum=bagModel.getItemCountById(itemid)
local num_str=FMT.fmt('{0}/{1}',has_itemNum,itemNum)
if has_itemNum<itemNum then
num_str=toColorString(FONT_COLOR.eRedColor,num_str)
end
self.moneyDesc:setText(num_str)
self.moneyIcon:setImageIcon(iconHelper.getIconName(itemid),false)

local tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv)
local next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv+1)
local isFull=next_tmcfg==nil
self.fullTips:setActive(isFull)
self.chongGrid:setActive(not isFull)
if not isFull then
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)



local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=self.chongGrid:getChildCommonLayoutGroupWidgetList()
for i=1,3 do
local sitem=grids[i-1]
local isActive=i<=chong
local scale=1
if not isActive then
abName=globalABLookup.dizitianmingicons
iconName='image_dztianmingui_2'
scale=2
end
sitem:SetChildCSImageSprite(0,abName,iconName)
sitem:SetChildScale(0,Vector3.New(scale,scale,scale))
end

end
else
self.chongGrid:setActive(false)
self.fullTips:setActive(false)
end

local isCurrent=data.index==self.current
self.selectBtn:setChildGraphicGray(isCurrent)
self.selectTx:setText(isCurrent and"已选择"or"选择弟子")

self.gailv_Btn:setActive(isCurrent)
if isCurrent then
self.gailvspine:setChildUIModelShowTarget(5295,1,{},5,false,false,0,function()

end)
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onDetailpBtn()
local dzData=self.selectData.disciple
local itemID=dzData.srctype
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onMoneyRoot()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:onGailv_Btn()
if _this==nil then return end
local d={}
d.title='规则说明'
d.mode=3
d.name='xianyuanxunfang_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog:rec_selectUp(actID,subType,subId,idx)
if self.info:compare(actID,subType,subId)then
local old=self.current
self.current=idx

local isCurrent=self.selectData.index==self.current
self.selectBtn:setChildGraphicGray(isCurrent)
self.selectTx:setText(isCurrent and"已选择"or"选择弟子")
self.gailv_Btn:setActive(isCurrent)
if isCurrent then
self.gailvspine:setChildUIModelShowTarget(5295,1,{},5,false,false,0,function()

end)
end

for i,v in ipairs(self.listData)do
if v.index==old then
local item=self.scrollView:getChildScrollViewItemWidget(i-1)
item:SetChildActive(_listItemCmp.choosed,false)
elseif v.index==idx then
local item=self.scrollView:getChildScrollViewItemWidget(i-1)
item:SetChildActive(_listItemCmp.choosed,true)
end
end
end
end

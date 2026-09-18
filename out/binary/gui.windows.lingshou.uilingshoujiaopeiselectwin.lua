







def_class("UILingShouJiaoPeiSelectWin",UIWindowBase)









function UILingShouJiaoPeiSelectWin:bindComponents()

self.viewList_2=UIObject.get(self,0)
self.viewList_1=UIObject.get(self,1)
self.togglehead_2=UIObject.get(self,2)
self.togglehead_1=UIObject.get(self,3)
self.none_2=UIObject.get(self,4)
self.none_1=UIObject.get(self,5)
self.toggle_1=UIToggleButton.get(self,6)
self.toggle_2=UIToggleButton.get(self,7)
self.viewRoot_1=UIObject.get(self,8)
self.viewRoot_2=UIObject.get(self,9)
self.sortOrderButton=UIButton.get(self,10)
self.sortConditionButton=UIButton.get(self,11)
self.sortTypeDropdown=UIDropdown.get(self,12)
self.confirmBtn=UIButton.get(self,13)
self.needTx=UIText.get(self,14)
self.closeBtn=UIButton.get(self,15)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.viewList={
self.viewList_1,
self.viewList_2,
}
self.togglehead={
self.togglehead_1,
self.togglehead_2,
}
self.none={
self.none_1,
self.none_2,
}
self.toggle={
self.toggle_1,
self.toggle_2,
}
self.viewRoot={
self.viewRoot_1,
self.viewRoot_2,
}



end


function UILingShouJiaoPeiSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.viewList_2);self.viewList_2=nil;
_UIObject_release(self.viewList_1);self.viewList_1=nil;
_UIObject_release(self.togglehead_2);self.togglehead_2=nil;
_UIObject_release(self.togglehead_1);self.togglehead_1=nil;
_UIObject_release(self.none_2);self.none_2=nil;
_UIObject_release(self.none_1);self.none_1=nil;
_UIObject_release(self.toggle_1);self.toggle_1=nil;
_UIObject_release(self.toggle_2);self.toggle_2=nil;
_UIObject_release(self.viewRoot_1);self.viewRoot_1=nil;
_UIObject_release(self.viewRoot_2);self.viewRoot_2=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.needTx);self.needTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.viewList=nil;
self.togglehead=nil;
self.none=nil;
self.toggle=nil;
self.viewRoot=nil;
end
















local _this=nil
local itemCmp={
this=-1,
head=0,
name=1,
tick=2,
jingjieTx=3,
raceTx=4,
zizhiTx=5,
xinqingTx=6,
fanyanTx=7,
banTx=8,
black=9,
}




function UILingShouJiaoPeiSelectWin:onLoaded(...)
self:bindComponents()
_this=self

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
for i,v in ipairs(self.toggle)do
v:setToggleChange(function(name,isOn,data)self:onClickToggle(i,isOn)end)
end



end


function UILingShouJiaoPeiSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UILingShouJiaoPeiSelectWin:onShow(argtable,afterOnloaded)
if not argtable then
loggerUtil.logErrFMT("界面 UILingShouJiaoPeiSelectWin 没有传入对应参数")
self:closeSelf()
end
self.ubdId=argtable.ubdId
self.selects=table.deepCopy(argtable.selects)
self.callback=argtable.callback
self.viewIdx=argtable.sType or 1

if self.selects[SEX_TYPE.eMale]and not self.selects[SEX_TYPE.eFeMale]then
self.first=SEX_TYPE.eMale
elseif self.selects[SEX_TYPE.eFeMale]and not self.selects[SEX_TYPE.eMale]then
self.first=SEX_TYPE.eFeMale
else
self.first=SEX_TYPE.eNo
end




self.sortTypeList=eLingShouSortType:getLSSortList3()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortType=eLingShouSortType.eJingJieSort
for i,v in ipairs(self.sortTypeList)do
if v==self.sortType then
self.sortTypeIndex=i
end
end
if self.sortTypeIndex==nil then
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
end
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self:initListData()
self:refreshSelected(SEX_TYPE.eMale)
self:refreshSelected(SEX_TYPE.eFeMale)
self.toggle[self.viewIdx]:setToggle(true)
end


function UILingShouJiaoPeiSelectWin:onHide()

end




function UILingShouJiaoPeiSelectWin:onCloseBtn()
self:closeSelf()
end


function UILingShouJiaoPeiSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:showViewList(self.viewIdx)
end


function UILingShouJiaoPeiSelectWin:onSortConditionButton()
if self.filterName==nil or self.filterFlag==nil then
local c=1
self.filterName={}
self.filterFlag={}
self.filterName[c]={}
self.filterName[c][1]='种族'
self.filterName[c][2]={}
self.filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(self.filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(self.sortCondition,c,i)
table.insert(self.filterFlag[c],flag)
end
end
end
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


function UILingShouJiaoPeiSelectWin:onConfirmBtn()
local fGuid=self.selects[SEX_TYPE.eMale]
local mGuid=self.selects[SEX_TYPE.eFeMale]
if fGuid~=nil and mGuid~=nil then
local fData=lingshouModel:getLingShouData(fGuid)
local mData=lingshouModel:getLingShouData(mGuid)
local fRace=fData.cfg.race
local mRace=mData.cfg.race
if fRace==mRace then
local condition=yushoufangModel:getConditonCfg()
local check=false
if fData.jj_lvl<condition[1]or fData.xinqing<condition[2]then
local index1=SEX_TYPE.eMale
self.selects[SEX_TYPE.eMale]=nil
self:refreshSelected(SEX_TYPE.eMale)
if index1==self.viewIdx then
for i,v in ipairs(self.showList)do
local item=self.viewList[index1]:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(v.guid,self.selects[index1]))
end
end
check=true
end
if mData.jj_lvl<condition[1]or mData.xinqing<condition[2]then
local index1=SEX_TYPE.eFeMale
self.selects[SEX_TYPE.eFeMale]=nil
self:refreshSelected(SEX_TYPE.eFeMale)
if index1==self.viewIdx then
for i,v in ipairs(self.showList)do
local item=self.viewList[index1]:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(v.guid,self.selects[index1]))
end
end
check=true
end

if check then
self:showViewList(self.viewIdx)
return UIManager.error("灵兽属性已改变")
end

if self.callback then
self.callback(fGuid,mGuid)
end
self:closeSelf()
else
UIManager.error("请选择同种族灵兽繁衍")
end
else
UIManager.error("请确定繁衍灵兽")
end
end

function UILingShouJiaoPeiSelectWin.selecConditionBack(data)
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

_this:showViewList(_this.viewIdx)
end

function UILingShouJiaoPeiSelectWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:showViewList(self.viewIdx)
end

function UILingShouJiaoPeiSelectWin:onClickToggle(index,isOn)
self.viewRoot[index]:setActive(isOn)
if isOn then
self.viewIdx=index
self:showViewList(index)
end
end

function UILingShouJiaoPeiSelectWin:showViewList(index)
index=index or 1
self:sortListData(index)
self:refreshViewList(index)
end

function UILingShouJiaoPeiSelectWin:initListData()
self.allList={}
self.allList[SEX_TYPE.eMale]={}
self.allList[SEX_TYPE.eFeMale]={}

local lsDatas=lingshouModel:getLingShouDatas()
for i,v in pairs(lsDatas)do
if self.allList[v.sex]then
local least=lingshouModel:getFanYanLeast(v.guid)
if least>0 then
table.insert(self.allList[v.sex],v)
end
end
end
end

function UILingShouJiaoPeiSelectWin:sortListData(index)
self.showList={}
local selectRace=nil
if self.first and index~=self.first then
local firstGuid=self.selects[self.first]
if firstGuid then
local firstData=lingshouModel:getLingShouData(firstGuid)
selectRace=firstData.cfg.race
end
end

for i,v in ipairs(self.allList[index])do
local lscfg=v.cfg
if not selectRace or selectRace==lscfg.race then
if not lingshouModel.checkStateExistEx(v.pet_state,eLingShouStateType.petBorn)and lingshouModel:canStateChangeEx(v.pet_state,eLingShouStateType.petBorn)then
if self.sortCondition[1]~=nil and#self.sortCondition[1]>0 then
for i1,v1 in ipairs(self.sortCondition[1])do
if lscfg.race==v1 then
table.insert(self.showList,v)
end
end
else
table.insert(self.showList,v)
end
end
end
end
yushoufangModel:sortSelectList(self.showList,self.sortType,self.sortOrder)

end

function UILingShouJiaoPeiSelectWin:refreshViewList(index)
local count=#self.showList
local show=count>0
local func=function(idx)
self:refreshViewListItem(index,idx)
end
self.viewList[index]:setChildLayoutGroupCreateItems(count,func)
self.none[index]:setActive(not show)
end

function UILingShouJiaoPeiSelectWin:refreshViewListItem(sex,index)
local item=self.viewList[sex]:getChildLayoutGroupGridItem(index-1)
local lsData=self.showList[index]

local lsID=lsData.id
local lscfg=lsData.cfg
local guid=lsData.guid


local name_str=lsData.name
item:SetChildText(itemCmp.name,name_str)

comHelper.setChildModelRawImage_lingshou(item,lsID,itemCmp.head,0,eHeadCenterType.eHead,1)

local jj_str=lingshouModel:getJJName(guid,2)
item:SetChildText(itemCmp.jingjieTx,FMT.fmt("境界：{0}",jj_str))

local raceCfg=cfgHelper.get1(cfg_lingshouraceconfig_get,lscfg.race)
local race_str=raceCfg.name
item:SetChildText(itemCmp.raceTx,FMT.fmt("种族：{0}",race_str))

item:SetChildText(itemCmp.zizhiTx,FMT.fmt("资质：{0}",lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))

item:SetChildText(itemCmp.xinqingTx,FMT.fmt("心情值：{0}",lsData.xinqing))





local fyNum=lingshouModel:getFanYanLeast(guid)
item:SetChildText(itemCmp.fanyanTx,FMT.fmt("繁衍剩余次数：{0}",fyNum))

item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(guid,self.selects[sex]))

local condition=yushoufangModel:getConditonCfg()
if lsData.jj_lvl<condition[1]then
local needLvStr=lingshouModel.getJJNameEx(condition[1],3)
item:SetChildText(itemCmp.banTx,FMT.fmt("需要达到{0}期",needLvStr))
item:SetChildActive(itemCmp.black,true)
elseif lsData.xinqing<condition[2]then
item:SetChildText(itemCmp.banTx,FMT.fmt("需要心情值达到{0}",condition[2]))
item:SetChildActive(itemCmp.black,true)
else
item:SetChildText(itemCmp.banTx,"")
item:SetChildActive(itemCmp.black,false)
end

item:SetChildButtonClick(itemCmp.this,function()
self:onClickItem(sex,index)
end)
end

function UILingShouJiaoPeiSelectWin:onClickItem(index1,index2)
local lsData=self.showList[index2]
local condition=yushoufangModel:getConditonCfg()
if lsData.jj_lvl<condition[1]then
local needLvStr=lingshouModel.getJJNameEx(condition[1],3)
return UIManager.error(FMT.fmt("需要达到{0}期",needLvStr))
elseif lsData.xinqing<condition[2]then
return UIManager.error(FMT.fmt("需要心情值达到{0}",condition[2]))
end
if self.selects[index1]~=lsData.guid then
local oldData=nil
if self.selects[index1]then
oldData=lingshouModel:getLingShouData(self.selects[index1])
end
self.selects[index1]=lsData.guid
if not self.first or self.first==SEX_TYPE.eNo then
self.first=index1
end
self:refreshSelected(index1)
if index1==self.viewIdx then
for i,v in ipairs(self.showList)do
local item=self.viewList[index1]:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(v.guid,self.selects[index1]))
end
end
if oldData and oldData.cfg.race~=lsData.cfg.race then
local otherIndex=index1==SEX_TYPE.eMale and SEX_TYPE.eFeMale or SEX_TYPE.eMale
self.selects[otherIndex]=nil
self:refreshSelected(otherIndex)
end
else
self.selects[index1]=nil
self:refreshSelected(index1)
if index1==self.viewIdx then
for i,v in ipairs(self.showList)do
local item=self.viewList[index1]:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(v.guid,self.selects[index1]))
end
end
if self.first and(self.first==index1 or self.first==SEX_TYPE.eNo)then
self.first=nil
local otherIndex=index1==SEX_TYPE.eMale and SEX_TYPE.eFeMale or SEX_TYPE.eMale
self.selects[otherIndex]=nil
self:refreshSelected(otherIndex)
end
end
end

function UILingShouJiaoPeiSelectWin:refreshSelected(index)
local lsGuid=self.selects[index]
if lsGuid then
local lsData=lingshouModel:getLingShouData(lsGuid)
local lsID=lsData.id
local headCmp=self.togglehead[index]
headCmp:setActive(true)
comHelper.setChildModelRawImage_lingshou(self.winlua,lsID,headCmp:getID(),0,eHeadCenterType.eHead,1)
else
self.togglehead[index]:setActive(false)
end
end

function UILingShouJiaoPeiSelectWin:finishSelect(ubdId)
if self.ubdId==ubdId then
self:closeSelf()
end
end
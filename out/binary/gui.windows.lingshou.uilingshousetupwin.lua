







def_class("UILingShouSetupWin",UIWindowBase)









function UILingShouSetupWin:bindComponents()

self.root=UIObject.get(self,0)
self.lingshouRoot=UIObject.get(self,1)
self.noLingShouTitle=UIObject.get(self,2)
self.lingshouItem=UIObject.get(self,3)
self.lingshouGrid=UIObject.get(self,4)
self.gainPage=UIObject.get(self,5)
self.dressToggle=UIToggleButton.get(self,6)
self.blackImg=UIButton.get(self,7)
self.Dropdown1=UIDropdownEx.get(self,8)
self.Dropdown2=UIDropdownEx.get(self,9)
self.bagLine=UIObject.get(self,10)
self.gainScrollView=UIScrollView.get(self,11)
self.filterBtn=UIButton.get(self,12)
self.filterRoot=UIObject.get(self,13)
self.pageCreater=UIObject.get(self,14)
self.btnReset=UIButton.get(self,15)
self.btnConfirm=UIButton.get(self,16)
self.closeFilterBtn=UIButton.get(self,17)

self.blackImg:setButtonClick(function()self:onBlackImg()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.closeFilterBtn:setButtonClick(function()self:onCloseFilterBtn()end)



end


function UILingShouSetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lingshouRoot);self.lingshouRoot=nil;
_UIObject_release(self.noLingShouTitle);self.noLingShouTitle=nil;
_UIObject_release(self.lingshouItem);self.lingshouItem=nil;
_UIObject_release(self.lingshouGrid);self.lingshouGrid=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.bagLine);self.bagLine=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.filterRoot);self.filterRoot=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.closeFilterBtn);self.closeFilterBtn=nil;
end
















local _this
local pageItemCmpIndex={
name=0,
childCreater=1,
toggle=2,
checkMark=3,
}

local childItemCmpIndex={
toggle=0,
name=1,
icon=2,
bg=3,
}


function UILingShouSetupWin:onLoaded(...)
_this=self
self:bindComponents()
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)

self.Dropdown2:setChangeAction(function(...)self:onDropdown2Change(...)end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.gainScrollView:bindScrollWidget(function(...)
self:fillGainData(...)
end)
notifySystem:listenNotify(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
end


function UILingShouSetupWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UILingShouTipsWin')

notifySystem:removelistener(notifyConfig.onDiscipleLingShouChange,self.onDiscipleLingShouChange)
end


function UILingShouSetupWin:onHide()

end

function UILingShouSetupWin.onDiscipleLingShouChange(dis_guid,changeType,ls_guid1,ls_guid2)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.dis_guid)then return end

_this:rec_setup(changeType,ls_guid1,ls_guid2)
end




function UILingShouSetupWin:onShow(argtable,afterOnloaded)
self.dis_guid=argtable.dis_guid
self.cur_ls=UIDiscipleModel:getDZLingShou(self.dis_guid)
self.produce=cfgHelper.get(cfg_lingshoubasicconfig_get,1,"produce")
self.lockRefresh=true















self.sortTypeList=eLingShouSortType:getLSSortList2()
self.Dropdown2:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortTypeIndex=1
self.sortType=self.sortTypeList[self.sortTypeIndex]
self.Dropdown2:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self.sortCondition={}

self.select_ls=self.cur_ls
self:refreshView()

self:refreshTips()
local posx=0
if self.select_ls~=nil then
posx=-343
end
self.root:setLocalPosX(posx)
end

function UILingShouSetupWin:refreshTips(ignoreBlack)
local isShowTips=self.select_ls~=nil and not self.isShowFilter
if not ignoreBlack then
self.blackImg:setActive(not isShowTips)
end
if isShowTips then

local fromType=TIPS_FORM_TYPE.eEquipListWin
local old=nil
if self.cur_ls~=nil and mathHelper.compareInt64(self.select_ls,self.cur_ls)then

else
local olddz=UIDiscipleModel:checkHasLingShouDZ(self.select_ls)
if olddz~=nil then


old=olddz.discipleguid
else


end
end
local tipswin=UIManager:findActiveWindow('UILingShouTipsWin')
if tipswin~=nil then
tipswin:onSelectLS(self.select_ls,fromType,old)
else
self:showWindow('UILingShouTipsWin',{ls_guid=self.select_ls,dzOwner=self.dis_guid,fromType=fromType,old_dzOwner=old})
end
end
end

function UILingShouSetupWin:closeTips()
UIManager:closeWindow('UILingShouTipsWin')
self.blackImg:setActive(true)
end

function UILingShouSetupWin:setBlackImg(isShow)
self.blackImg:setActive(isShow)
end





















































function UILingShouSetupWin:getLingShouSortList()
local sortOrder=eSortOrder.eDown
local nowEquipLs=self.cur_ls
local checkDress=not self.dressToggle:getToggle()
local list=lingshouLookup:getSortLsEquipList(self.sortType,self.sortCondition,sortOrder,nowEquipLs,checkDress)
self.lslist=list
end

function UILingShouSetupWin:refreshView()


self:getLingShouSortList()
if self.select_ls==nil then
if#self.lslist>0 then
self.select_ls=self.lslist[1].guid
end
end

local showCurLs=self.cur_ls~=nil
self.noLingShouTitle:setActive(not showCurLs)
self.lingshouItem:setActive(showCurLs)
if showCurLs then
local item=self.lingshouItem:getWidgetBase()
item:SetChildActive(9,not showCurLs)
item:SetChildActive(10,showCurLs)
local lsData=lingshouModel:getLingShouData(self.cur_ls)
local lscfg=lsData.cfg


self:refreshItemSelect(item,mathHelper.compareInt64(self.select_ls,self.cur_ls))


comHelper.setChildModelHeadIconBGByColor(item,1,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsData.id,2,0,eHeadCenterType.eHead,1)

local showSign=lscfg.bianyi==1
item:SetChildActive(3,showSign)

item:SetChildText(4,lsData.name)

local desc_str=nil
if self.sortType==eLingShouSortType.eFightSort then
desc_str=nil
elseif self.sortType==eLingShouSortType.eJingJieSort then
desc_str=FMT.fmt('境界：{0}',lingshouModel:getJJName(self.cur_ls,2))
elseif self.sortType==eLingShouSortType.eQianLi then
local ql_str=lingshouModel.getQianLiDescEx(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
desc_str=FMT.fmt('潜力：{0}',ql_str)
end
local showDesc=desc_str~=nil
item:SetChildActive(5,not showDesc)
item:SetChildActive(6,showDesc)
if showDesc then
item:SetChildText(6,desc_str)
else
item:SetChildText(11,lingshouModel:getFightValue(self.cur_ls))
end

item:SetChildButtonClick(8,function()
self:onItemClick(self.cur_ls)
end,true)


local lsID=lsData.id
local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
item:SetChildActive(12,isLDLS)
end
self:refreshLSListView()
end

function UILingShouSetupWin:refreshLSListView()
local num=#self.lslist
local showBagLs=#self.lslist>0
self.gainPage:setActive(not showBagLs)
self.bagLine:setActive(showBagLs)
local func=function(idx)
self:refreshLSItem(idx)
end
self.lingshouGrid:setChildLayoutGroupCreateItems(num,func)

if not showBagLs then
self:refreshGainPage()
end
end

function UILingShouSetupWin:refreshGainPage()


local produce=self.produce or nil
local len=produce and#produce or 0
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end

function UILingShouSetupWin:fillGainData(index,widget)
local info=self.produce and self.produce[index]or nil
local jump=info and info.jump or info
local hasjump=jump~=nil
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if not hasjump then

return
end
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function UILingShouSetupWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
return false,systemModel.getOpenTips(sysid)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end

function UILingShouSetupWin:refreshItemSelect(item,isselect)
item:SetChildActive(0,isselect)
end

function UILingShouSetupWin:refreshLSItem(idx)
local item=self.lingshouGrid:getChildLayoutGroupGridItem(idx-1)
local lsData=self.lslist[idx]
local guid=lsData.guid
local lscfg=lsData.cfg

self:refreshItemSelect(item,mathHelper.compareInt64(self.select_ls,guid))


comHelper.setChildModelHeadIconBGByColor(item,1,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsData.id,2,0,eHeadCenterType.eHead,1)

local showSign=lscfg.bianyi==1
item:SetChildActive(3,showSign)

item:SetChildText(4,lsData.name)

local desc_str=nil
if self.sortType==eLingShouSortType.eFightSort then
desc_str=nil
elseif self.sortType==eLingShouSortType.eJingJieSort then
desc_str=FMT.fmt('境界：{0}',lingshouModel:getJJName(guid,2))
elseif self.sortType==eLingShouSortType.eQianLi then
local ql_str=lingshouModel.getQianLiDescEx(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
desc_str=FMT.fmt('潜力：{0}',ql_str)
end
local showDesc=desc_str~=nil
item:SetChildActive(5,not showDesc)
item:SetChildActive(6,showDesc)
if showDesc then
item:SetChildText(6,desc_str)
else
item:SetChildText(10,lingshouModel:getFightValue(guid))
end

item:SetChildButtonClick(7,function()
self:onItemClick(guid)
end,true)

local netData=UIDiscipleModel:checkHasLingShouDZ(guid)
local showDZ=netData~=nil
item:SetChildActive(9,showDZ)
if showDZ then
comHelper.setChildModelRawImage(item,netData.discipleguid,8,0,eHeadCenterType.eHead)
end


local lsID=lsData.id
local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
item:SetChildActive(11,isLDLS)
end

function UILingShouSetupWin:refreshSelectView()
if self.select_ls~=nil then
local lsData=self:getDataByLS(self.select_ls)
if lsData==nil then
self.select_ls=nil
if self.cur_ls~=nil then
self.select_ls=self.cur_ls
local item=self:getItemByLS(self.select_ls)
self:refreshItemSelect(item,true)
else
if#self.lslist>0 then
self.select_ls=self.lslist[1].guid
end
end
end
end
end

function UILingShouSetupWin:refreshFilterPanel()
local filterName,filterFlag=lingshouLookup:getEquipLsListConditionFilter(self.sortCondition)
self.filterName=filterName
self.filterFlag=filterFlag
local pagenum=#self.filterName
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UILingShouSetupWin:refreshPageItem(item,pageidx)
local pageData=self.filterName[pageidx]
local pageTitle=pageData[1]
local childNameList=pageData[2]
local tipsDesc=pageData[3]
self.filterFlag[pageidx]=self.filterFlag[pageidx]or{}
local childFlagList=self.filterFlag[pageidx]

item:SetChildText(pageItemCmpIndex.name,pageTitle)

local childnum=#childNameList
item:SetChildLayoutGroupCreateItems(pageItemCmpIndex.childCreater,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,i,childNameList,childFlagList,pageidx)
end

item:SetChildActive(pageItemCmpIndex.toggle,false)
end

function UILingShouSetupWin:refreshChildItem(childItem,idx,childNameList,childFlagList,pageidx)
local desc_str=childNameList[idx].name
local isselect=childFlagList[idx]or false
childItem:SetChildToggleChange(childItemCmpIndex.toggle,nil)
childItem:SetChildToggle(childItemCmpIndex.toggle,isselect)
childItem:SetChildToggleChange(childItemCmpIndex.toggle,function(name,isOn)
childFlagList[idx]=isOn
_this:refreshSortCnd()
_this:refreshView()
end)
childItem:SetChildText(childItemCmpIndex.name,desc_str)
end

function UILingShouSetupWin:refreshSortCnd()
local filterFlag=self.filterFlag
self.sortCondition={}
for i,v in ipairs(filterFlag)do
self.sortCondition[i]={}
local fns=self.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(self.sortCondition[i],fns[i1].typeid)
end
end
end
end

function UILingShouSetupWin:getItemByLS(ls_guid)
if mathHelper.compareInt64(ls_guid,self.cur_ls)then
return self.lingshouItem:getWidgetBase()
else
for i,v in ipairs(self.lslist)do
if mathHelper.compareInt64(ls_guid,v.guid)then
return self.lingshouGrid:getChildLayoutGroupGridItem(i-1)
end
end
end
return nil
end

function UILingShouSetupWin:getDataByLS(ls_guid)
if mathHelper.compareInt64(ls_guid,self.cur_ls)then
return lingshouModel:getLingShouData(ls_guid)
else
for i,v in ipairs(self.lslist)do
if mathHelper.compareInt64(ls_guid,v.guid)then
return v
end
end
end
return nil
end

function UILingShouSetupWin:onItemClick(ls_guid)
if mathHelper.compareInt64(ls_guid,self.select_ls)then return end
local item1=self:getItemByLS(self.select_ls)
if item1 then
self:refreshItemSelect(item1,false)
end
self.select_ls=ls_guid
local item2=self:getItemByLS(self.select_ls)
self:refreshItemSelect(item2,true)

self:refreshTips()
end

function UILingShouSetupWin:onToggleChanged(name,isToggle,data)



self:getLingShouSortList()
self:refreshSelectView()
self:refreshLSListView()
self:refreshTips()
end

function UILingShouSetupWin:onDropdownChange(idx)

if self.lockRefresh then return end
idx=idx+1
if self.elementTypeIndex==idx then return end
self.elementTypeIndex=idx
self.elementType=self.elementTypeList[idx]

self:refreshView()
end

function UILingShouSetupWin:onDropdown2Change(idx)

if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]


self:refreshView()

end

function UILingShouSetupWin:onBlackImg()
self:closeSelf()
end

function UILingShouSetupWin:rec_setup(changeType,ls1,ls2)
if changeType==eEquipChangeType.eReplace then
self.cur_ls=ls2
UIManager.info('灵兽更换成功')

return self:onBlackImg()
elseif changeType==eEquipChangeType.eSetup then
self.cur_ls=ls1
UIManager.info('灵兽携带成功')

return self:onBlackImg()
elseif changeType==eEquipChangeType.eRemove then
self.cur_ls=nil
end
self.select_ls=self.cur_ls
self:refreshView()
self:refreshTips()
end

function UILingShouSetupWin:onGainItemClick(id,index,guid,attach)

local produce=self.produce
local jumpArgs=produce and produce[id].jump or nil
if jumpArgs then
jumpManager:jump(jumpArgs)
else
loggerUtil.logErrFMT('道具{0}获取途径中跳转没有配置',self.itemid)
end
end

function UILingShouSetupWin:onFilterBtn()
if self.isShowFilter then
self:onCloseFilterBtn()
return
end
self.isShowFilter=true
self.filterRoot:setActive(true)
self:refreshFilterPanel()
self:closeTips()
end

function UILingShouSetupWin:onCloseFilterBtn()
self:refreshSortCnd()
self.isShowFilter=false
self.filterRoot:setActive(false)
self:refreshTips(true)
self:refreshView()
end

function UILingShouSetupWin:onBtnReset()
for i,v in pairs(self.filterFlag)do
for i1,v1 in pairs(v)do
self.filterFlag[i][i1]=false
end
end
self:refreshSortCnd()
self:refreshFilterPanel()
self:refreshView()
end

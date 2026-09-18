







def_class("UILingShouYSFSelectWin",UIWindowBase)









function UILingShouYSFSelectWin:bindComponents()

self.sortOrderButton=UIButton.get(self,0)
self.sortConditionButton=UIButton.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.confirmBtn=UIButton.get(self,3)
self.needTx=UIText.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.leftbtn=UIObject.get(self,6)
self.rightbtn=UIObject.get(self,7)
self.lingShouScrollView=UIObject.get(self,8)
self.none_1=UIObject.get(self,9)
self.Content=UIObject.get(self,10)
self.taskScroller=UIObject.get(self,11)
self.tipsbtn=UIButton.get(self,12)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)
self.none={
self.none_1,
}



end


function UILingShouYSFSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.needTx);self.needTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftbtn);self.leftbtn=nil;
_UIObject_release(self.rightbtn);self.rightbtn=nil;
_UIObject_release(self.lingShouScrollView);self.lingShouScrollView=nil;
_UIObject_release(self.none_1);self.none_1=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
self.none=nil;
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
local btnindex=
{
selfitem=0,
addimg=1,
headicon=2,
sexflag=3,
select=4,
btn=5,
bg=6,
name=7,
line=8,
}
local itemindex=
{
noselect=0,
headicon=1,
name=2,
sexflag=3,
jingjietxt=4,
zizhitxt=5,
xinqingtxt=6,
fanyantxt=7,
select=8,
black=9,
blacktxt=10,
btn=11,
headbtn=12,
headbg=13,
}
local sex_abname='ui/windows/lingshou/lingshouxuemai_atlas_pak.ab'
local sexarry=
{
[1]='image_yushoufang_13',
[2]='image_yushoufang_12',
}
local lines=
{
[1]='image_yushoufang_08',
[2]='image_yushoufang_09',
}

local _useLoop=api_Available_GetChildLoopTreeView()or false




function UILingShouYSFSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.lingShouList={}

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)



self.sortTypeList=eLingShouSortType:getLSSortList6()
self.sortTypeDropdown:setOption(eLingShouSortTypeName:getName2List2(self.sortTypeList))
self.sortType=eLingShouSortType.eColorSort
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
self.sortOrder=eSortOrder.eUp
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortTypeIndex-1)
self.lockRefresh=false

self.posSelidx=1
self.ls_selectid=0
self.ls_selectguid=nil
self.ls_left_guid=nil
self.ls_right_guid=nil

self.chooserace=0
self.choosecolor=0
self.chooseds=0

self.leftsex=0
self.issure=false














end


function UILingShouYSFSelectWin:__delete()
self:unbindComponents()
_this=nil
end


function UILingShouYSFSelectWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.sortType=self.sortTypeList[idx]

self:freshSortLSList()
end

function UILingShouYSFSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder

self:freshSortLSList()
end

function UILingShouYSFSelectWin:onSortConditionButton()
local filterName,filterFlag=lingshouLookup:getConditonFilter2(self.sortCondition)
self.filterName=filterName
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selecConditionBack}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end

function UILingShouYSFSelectWin.selecConditionBack(data)
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

_this:freshSortLSList()
end


function UILingShouYSFSelectWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UILingShouYSFSelectWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UILingShouYSFSelectWin:showLingShouTips(lsGUid)
local lsData=lingshouModel:getLingShouData(lsGUid)
local dis_guid=UIDiscipleModel:checkHasLingShouDZ(lsData.guid)
local fromType=TIPS_FORM_TYPE.eNone
local tipswin=UIManager:findActiveWindow('UILingShouTipsWin')
if tipswin~=nil then
tipswin:onSelectLS(lsData.guid,fromType,nil)
else
UIManager:showWindow('UILingShouTipsWin',{ls_guid=lsData.guid,dzOwner=dis_guid,fromType=fromType,blackImgAlpha=0,offsetx=200})
end
end

function UILingShouYSFSelectWin:onLeftClickBtn(index,init)
if not init then
if index==self.posSelidx then
return
end
end
self.posSelidx=index
local leftwidegt=self.leftbtn:getChildWidgetBase()
leftwidegt:SetChildActive(btnindex.select,self.posSelidx==1)
local rightwidegt=self.rightbtn:getChildWidgetBase()
rightwidegt:SetChildActive(btnindex.select,self.posSelidx==2)



self:setLingshouList()

local lsguid=self:getnowLSChooseGuid(self.posSelidx)
if lsguid then
self.ls_selectid=self:getLingShouIndexByGuid(lsguid)or 0
self.ls_selectguid=lsguid
else
self.ls_selectid=0
self.ls_selectguid=nil
end



self:freshLsListPanel()
end

function UILingShouYSFSelectWin:onLsLoopGridViewItemClick(itemIndex,itemGuid)


local lsData=self.lingShouList[itemIndex].lsData
if lsData then
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)or 0
local jj_lvl=lsData.jj_lvl or 0
local need_jingjie=self.config.need_jingjie
local need_love=self.config.need_love
if jj_lvl<need_jingjie then
local needLvStr2=lingshouModel.getJJNameEx(need_jingjie,2)
UIManager.info(FMT.fmt("需要达到{0}",needLvStr2))
return
elseif xinqing<need_love then
UIManager.info(FMT.fmt("需要心情值达到{0}",need_love))
return
end
end

if itemIndex==self.ls_selectid then

local old_idx=self.ls_selectid
self.ls_selectid=0
self.ls_selectguid=nil
if old_idx>0 then
local old_item=self.taskScroller:getChildScrollViewItemWidget(old_idx-1)
if old_item then
old_item:SetChildActive(itemindex.select,false)
old_item:SetChildActive(itemindex.noselect,true)
end
end


self:clearnowLSChooseGuid(self.posSelidx)
else

local old_idx=self.ls_selectid
self.ls_selectid=itemIndex
self.ls_selectguid=itemGuid

if old_idx>0 then
local old_item=self.taskScroller:getChildScrollViewItemWidget(old_idx-1)
if old_item then
old_item:SetChildActive(itemindex.select,false)
old_item:SetChildActive(itemindex.noselect,true)
end
end
if itemIndex>0 then
local item=self.taskScroller:getChildScrollViewItemWidget(itemIndex-1)
if item then
item:SetChildActive(itemindex.select,true)
item:SetChildActive(itemindex.noselect,false)
end
end


self:setnowLSChooseGuid(self.posSelidx,self.ls_selectguid)
end


self:setLSsex()

self:refreshLeftPanel()


if not self.ls_left_guid and not self.ls_right_guid then
self:setLingshouList()
self:freshLsListPanel()
end

end

function UILingShouYSFSelectWin:onConfirmBtn2()
local l_lsguid=self:getLSChooseGuid(1)
local r_lsguid=self:getLSChooseGuid(2)
if l_lsguid~=nil and r_lsguid~=nil then
local fData=lingshouModel:getLingShouData(l_lsguid)
local mData=lingshouModel:getLingShouData(r_lsguid)
local fRace=fData.cfg.race
local mRace=mData.cfg.race
if fRace==mRace then

































self.issure=true
if self.callback then
self.callback(l_lsguid,r_lsguid)
end
self:closeSelf()
else
UIManager.error("请选择同种族灵兽繁衍")
end
end
end
function UILingShouYSFSelectWin:onConfirmBtn()
if not self.ls_left_guid and not self.ls_right_guid then
UIManager.info('请先选择灵兽')
return
end

if self.ls_left_guid and not self.ls_right_guid then
if self.posSelidx==2 then
UIManager.info('请先选择灵兽')
end
self:onLeftClickBtn(2,true)
return
end


if not self.ls_left_guid and self.ls_right_guid then
if self.posSelidx==1 then
UIManager.info('请先选择灵兽')
end
self:onLeftClickBtn(1,true)
return
end


if self.ls_left_guid and self.ls_right_guid then
self:setLSChooseGuid(1,self.ls_left_guid)
self:setLSChooseGuid(2,self.ls_right_guid)
if self.callback then
self.callback()
end
self:closeSelf()
end
end




function UILingShouYSFSelectWin:onShow(argtable,afterOnloaded)
if not argtable then
loggerUtil.logErrFMT("界面 UILingShouYSFSelectWin 没有传入对应参数")
self:closeSelf()
end
self.ubdId=argtable.ubdId
self.callback=argtable.callback

self.config=cfg_lingshoubabybasicconfig_get(1)
self.posSelidx=argtable.posSelidx or 1
self.un_build_id=argtable.un_build_id


local lsguid=self:getLSChooseGuid(self.posSelidx)
if lsguid then
self.ls_selectid=self:getLingShouIndexByGuid(lsguid)or 0
self.ls_selectguid=lsguid
end


self.ls_left_guid=self:getLSChooseGuid(1)
self.ls_right_guid=self:getLSChooseGuid(2)
self:setLSsex()


self:initLeftBtn()

self:onLeftClickBtn(self.posSelidx,true)
end


function UILingShouYSFSelectWin:onHide()

end
function UILingShouYSFSelectWin:onCloseBtn()
self:closeSelf()
end



function UILingShouYSFSelectWin:setLSsex()

local l_sex=0
self.chooserace=0
self.choosecolor=0
self.chooseds=0
local l_lsguid=self.ls_left_guid
if l_lsguid then
local lsdata=lingshouModel:getLingShouData(l_lsguid)
if lsdata then
l_sex=lsdata.sex
self.chooserace=lsdata.cfg.race
self.choosecolor=lsdata.cfg.color
self.chooseds=lsdata.generation
end
end

local r_sex=0
local r_lsguid=self.ls_right_guid
if r_lsguid then
local lsdata=lingshouModel:getLingShouData(r_lsguid)
if lsdata then
r_sex=lsdata.sex
self.chooserace=lsdata.cfg.race
self.choosecolor=lsdata.cfg.color
self.chooseds=lsdata.generation
end
end

self.leftsex=0
if l_sex==1 then
self.leftsex=1
elseif l_sex==2 then
self.leftsex=2
end
if r_sex==1 then
self.leftsex=2
elseif r_sex==2 then
self.leftsex=1
end
end

function UILingShouYSFSelectWin:getLSChooseGuid(posidx)
return yushoufangModel:getLSChooseData(self.un_build_id,posidx)
end

function UILingShouYSFSelectWin:setLSChooseGuid(posidx,lsguid)
yushoufangModel:setLSChooseData(self.un_build_id,posidx,lsguid)
end

function UILingShouYSFSelectWin:clearnowLSChooseGuid(posidx)
if posidx==1 then
self.ls_left_guid=nil
elseif posidx==2 then
self.ls_right_guid=nil
end
end

function UILingShouYSFSelectWin:setnowLSChooseGuid(posidx,lsguid)
if posidx==1 then
self.ls_left_guid=lsguid
elseif posidx==2 then
self.ls_right_guid=lsguid
end
end

function UILingShouYSFSelectWin:getnowLSChooseGuid(posidx)
if posidx==1 then
return self.ls_left_guid
elseif posidx==2 then
return self.ls_right_guid
end
end


function UILingShouYSFSelectWin:LSjumpindex()
if self.lingShouList and#self.lingShouList>6 then
if self.ls_selectid and self.ls_selectid>6 then

self.taskScroller:setChildScrollViewSelectItem(self.ls_selectid-1,false,false,false)
end
end
end

function UILingShouYSFSelectWin:getLingShouIndexByGuid(guid)
for index,data in ipairs(self.lingShouList)do
if mathHelper.compareInt64(guid,data.lsData.guid)then
return index
end
end
return false
end




function UILingShouYSFSelectWin:initLeftBtn()

local leftwidegt=self.leftbtn:getChildWidgetBase()
local l_lsguid=self.ls_left_guid
local leftdata
if l_lsguid then
leftdata=lingshouModel:getLingShouData(l_lsguid)
end
if leftdata then
local lsId=leftdata.id
local sex=leftdata.sex
leftwidegt:SetChildActive(btnindex.addimg,false)
leftwidegt:SetChildActive(btnindex.sexflag,true)
leftwidegt:SetChildCSImageSprite(btnindex.sexflag,sex_abname,sexarry[sex])

comHelper.setChildModelRawImage_lingshou(leftwidegt,lsId,btnindex.headicon,0,eHeadCenterType.eHead,1)


local lsCfg=leftdata.cfg
leftwidegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[lsCfg.color])
leftwidegt:SetChildGray(btnindex.bg,false)
leftwidegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[1])


local name=leftdata.name
leftwidegt:SetChildText(btnindex.name,name)
else
leftwidegt:SetChildActive(btnindex.addimg,true)
leftwidegt:SetChildActive(btnindex.sexflag,false)
leftwidegt:SetChildActive(btnindex.headicon,false)


leftwidegt:SetChildText(btnindex.name,"暂无灵兽")
leftwidegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[3])
leftwidegt:SetChildGray(btnindex.bg,true)
leftwidegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[2])
end
leftwidegt:SetChildActive(btnindex.select,self.posSelidx==1)
leftwidegt:SetChildButtonClick(btnindex.btn,function()
if _this==nil then return end
self:onLeftClickBtn(1)
end)


local rightwidegt=self.rightbtn:getChildWidgetBase()
local r_lsguid=self.ls_right_guid
local rightdata
if r_lsguid then
rightdata=lingshouModel:getLingShouData(r_lsguid)
end

if rightdata then
local lsId=rightdata.id
local sex=rightdata.sex
rightwidegt:SetChildActive(btnindex.addimg,false)
rightwidegt:SetChildActive(btnindex.sexflag,true)
rightwidegt:SetChildCSImageSprite(btnindex.sexflag,sex_abname,sexarry[sex])

comHelper.setChildModelRawImage_lingshou(rightwidegt,lsId,btnindex.headicon,0,eHeadCenterType.eHead,1)


local lsCfg=rightdata.cfg
rightwidegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[lsCfg.color])
rightwidegt:SetChildGray(btnindex.bg,false)
rightwidegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[1])


local name=rightdata.name
rightwidegt:SetChildText(btnindex.name,name)
else
rightwidegt:SetChildActive(btnindex.addimg,true)
rightwidegt:SetChildActive(btnindex.sexflag,false)
rightwidegt:SetChildActive(btnindex.headicon,false)


rightwidegt:SetChildText(btnindex.name,"暂无灵兽")
rightwidegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[3])
rightwidegt:SetChildGray(btnindex.bg,true)
rightwidegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[2])
end
rightwidegt:SetChildActive(btnindex.select,self.posSelidx==2)
rightwidegt:SetChildButtonClick(btnindex.btn,function()
if _this==nil then return end
self:onLeftClickBtn(2)
end)
end

function UILingShouYSFSelectWin:refreshLeftPanel()
local lsdata
local widegt
if self.posSelidx==1 then
widegt=self.leftbtn:getChildWidgetBase()
elseif self.posSelidx==2 then
widegt=self.rightbtn:getChildWidgetBase()
end
local lsguid=self:getnowLSChooseGuid(self.posSelidx)
if lsguid then
lsdata=lingshouModel:getLingShouData(lsguid)
end
if lsdata then
local lsId=lsdata.id
local sex=lsdata.sex
widegt:SetChildActive(btnindex.addimg,false)
widegt:SetChildActive(btnindex.sexflag,true)
widegt:SetChildCSImageSprite(btnindex.sexflag,sex_abname,sexarry[sex])

widegt:SetChildActive(btnindex.headicon,true)
comHelper.setChildModelRawImage_lingshou(widegt,lsId,btnindex.headicon,0,eHeadCenterType.eHead,1)


local lsCfg=lsdata.cfg
widegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[lsCfg.color])
widegt:SetChildGray(btnindex.bg,false)
widegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[1])


local name=lsdata.name
widegt:SetChildText(btnindex.name,name)
else
widegt:SetChildActive(btnindex.addimg,true)
widegt:SetChildActive(btnindex.sexflag,false)
widegt:SetChildActive(btnindex.headicon,false)


widegt:SetChildText(btnindex.name,"暂无灵兽")
widegt:SetChildCSImageSprite(btnindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[3])
widegt:SetChildGray(btnindex.bg,true)
widegt:SetChildCSImageSprite(btnindex.line,sex_abname,lines[2])
end
end



function UILingShouYSFSelectWin:setLingshouList()
self.lingShouList={}

local sex=0
if self.posSelidx==1 then
if self.leftsex==1 then
sex=1
elseif self.leftsex==2 then
sex=2
end
else
if self.leftsex==1 then
sex=2
elseif self.leftsex==2 then
sex=1
end
end
local chooserace=self.chooserace
local choosecolor=self.choosecolor
local chooseds=self.chooseds

local list=lingshouLookup:getSortList4(self.sortType,self.sortCondition,self.sortOrder)
if#list>0 then
for i,lsData in ipairs(list)do
if lsData.sex<3 and not lingshouModel.checkStateExistEx(lsData.pet_state,eLingShouStateType.petBorn)and lingshouModel:canStateChangeEx(lsData.pet_state,eLingShouStateType.petBorn)then
local born_times=lsData.born_times or 0
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)

if lscfg and born_times>0 then
local weight=i
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)or 0
local color=lsData.cfg.color
local generation=lsData.generation or 0
local zizhi=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)or 0
local jj_lvl=lsData.jj_lvl or 0
if self.sortType==eLingShouSortType.eColorSort then
weight=color*1000000+generation*100000+zizhi*10000+jj_lvl*1000
elseif self.sortType==eLingShouSortType.eDaiShu then
weight=generation*1000000+color*100000+zizhi*10000+jj_lvl*1000
elseif self.sortType==eLingShouSortType.eZiZhi then
weight=zizhi*1000000+color*100000+generation*10000+jj_lvl*1000
elseif self.sortType==eLingShouSortType.eJingJieSort then
weight=jj_lvl*1000000+color*100000+generation*10000+zizhi*1000
end
if xinqing<self.config.need_love then
weight=weight-10000000000
end
if jj_lvl<self.config.need_jingjie then
weight=weight-100000000000
end

if sex>0 then
if lsData.sex==sex then
if lsData.cfg.race==chooserace and lsData.cfg.color==choosecolor and lsData.generation==chooseds then
table.insert(self.lingShouList,{lsData=lsData,weight=weight})
end
end
else
table.insert(self.lingShouList,{lsData=lsData,weight=weight})
end
end
end
end
end
if#self.lingShouList>1 then
table.sort(self.lingShouList,function(a,b)
return a.weight>b.weight
end)
end

end

function UILingShouYSFSelectWin:freshSortLSList()
self:setLingshouList()
self:freshLsListPanel()
end

function UILingShouYSFSelectWin:freshLsListPanel()






local dataNum=#self.lingShouList
if dataNum>0 then
self.none_1:setActive(false)
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,2)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local itemIndex=i
local lsData=self.lingShouList[itemIndex].lsData
local lsId=lsData.id
local lsGUid=lsData.guid
local lsCfg=lsData.cfg
local lsName=lsData.name
local lsColor=lsCfg.color
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)

local generation=lsData.generation or 0
local zizhi=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)or 0
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)or 0
local born_times=lsData.born_times or 0
local mating_cnt=lsCfg.mating_cnt or 0
local jj_lvl=lsData.jj_lvl or 0
local sex=lsData.sex or 1




comHelper.setChildModelHeadIconBGByColor(item,itemindex.headbg,lsCfg.color)

comHelper.setChildModelRawImage_lingshou(item,lsId,itemindex.headicon,0,eHeadCenterType.eHead,1)

item:SetChildButtonClick(itemindex.headbtn,function()
if _this==nil then return end
_this:showLingShouTips(lsGUid)
end)


item:SetChildText(itemindex.name,lsName)

item:SetChildText(itemindex.zizhitxt,FMT.fmt("资质：<color=#7d3b17>{0}</color>",zizhi))

item:SetChildText(itemindex.xinqingtxt,FMT.fmt("心情值：<color=#7d3b17>{0}</color>",xinqing))

local cha=born_times
item:SetChildText(itemindex.fanyantxt,FMT.fmt("剩余繁衍次数：<color=#7d3b17>{0}</color>",cha))

item:SetChildCSImageSprite(btnindex.sexflag,sex_abname,sexarry[sex])


local zznume=cfgHelper.get2(cfg_lingshouraceconfig_get,lsCfg.race,'name')

local needLvStr=lingshouModel.getJJNameEx(jj_lvl,2)
local desc=FMT.fmt("{0}代{1}  {2}",generation,zznume,needLvStr)
item:SetChildText(itemindex.jingjietxt,desc)


if self.ls_selectid==itemIndex then
item:SetChildActive(itemindex.select,true)
item:SetChildActive(itemindex.noselect,false)
else
item:SetChildActive(itemindex.select,false)
item:SetChildActive(itemindex.noselect,true)
end


item:SetChildButtonClick(itemindex.btn,function()
if _this==nil then return end
_this:onLsLoopGridViewItemClick(itemIndex,lsGUid,item)
end)


local need_jingjie=self.config.need_jingjie
local need_love=self.config.need_love

if jj_lvl<need_jingjie then
local needLvStr2=lingshouModel.getJJNameEx(need_jingjie,2)
item:SetChildText(itemindex.blacktxt,FMT.fmt("境界未达到<color=#f36666>{0}</color>",needLvStr2))
item:SetChildActive(itemindex.black,true)
elseif xinqing<need_love then
item:SetChildText(itemindex.blacktxt,FMT.fmt("心情值不足<color=#f36666>{0}</color>",need_love))
item:SetChildActive(itemindex.black,true)
else
item:SetChildText(itemindex.blacktxt,"")
item:SetChildActive(itemindex.black,false)
end
end
end
else
self.taskScroller:setActive(false)
self.none_1:setActive(true)
end
end
function UILingShouYSFSelectWin:startLoopAction()
end
function UILingShouYSFSelectWin:freshLoopAction(i,item)
local index=i+1
self:refreshLsItem(index,item)
end

function UILingShouYSFSelectWin:refreshLsItem(index,item)
local itemIndex=index
local lsData=self.lingShouList[itemIndex].lsData
local lsId=lsData.id
local lsGUid=lsData.guid
local lsCfg=lsData.cfg
local lsName=lsData.name
local lsColor=lsCfg.color
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)

local generation=lsData.generation or 0
local zizhi=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)or 0
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)or 0
local born_times=lsData.born_times or 0
local mating_cnt=lsCfg.mating_cnt or 0
local jj_lvl=lsData.jj_lvl or 0
local sex=lsData.sex or 1



item:SetChildCSImageSprite(itemindex.bg,globalABLookup.lingshoumain,lingshouColorToFrame[lsColor])

comHelper.setChildModelRawImage_lingshou(item,lsId,itemindex.headicon,0,eHeadCenterType.eHead,1)

item:SetChildText(itemindex.name,lsName)

item:SetChildText(itemindex.zizhitxt,FMT.fmt("资质：{0}",zizhi))

item:SetChildText(itemindex.xinqingtxt,FMT.fmt("心情值：{0}",xinqing))

local cha=mating_cnt-born_times
item:SetChildText(itemindex.fanyantxt,FMT.fmt("剩余繁衍次数：{0}",cha))

item:SetChildCSImageSprite(btnindex.sexflag,sex_abname,sexarry[sex])


local zznume=cfgHelper.get2(cfg_lingshouraceconfig_get,lsCfg.race,'name')

local needLvStr=lingshouModel.getJJNameEx(jj_lvl,2)
local desc=FMT.fmt("{0}代{1}  {2}",generation,zznume,needLvStr)
item:SetChildText(itemindex.jingjietxt,desc)


if self.ls_selectid==itemIndex then
item:SetChildActive(itemindex.select,true)
else
item:SetChildActive(itemindex.select,false)
end


item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onLsLoopGridViewItemClick(itemIndex,lsGUid,item)
end)


local need_jingjie=self.config.need_jingjie
local need_love=self.config.need_love

if jj_lvl<need_jingjie then
local needLvStr2=lingshouModel.getJJNameEx(need_jingjie,2)
item:SetChildText(itemindex.blacktxt,FMT.fmt("需要达到{0}期",needLvStr2))
item:SetChildActive(itemindex.black,true)
elseif xinqing<need_love then
item:SetChildText(itemindex.blacktxt,FMT.fmt("需要心情值达到{0}",need_love))
item:SetChildActive(itemindex.black,true)
else
item:SetChildText(itemindex.blacktxt,"")
item:SetChildActive(itemindex.black,false)
end
end




function UILingShouYSFSelectWin:refreshViewListItem(sex,index)
local item=self.viewList[sex]:getChildLayoutGroupGridItem(index-1)
local lsData=self.lingShouList[index]

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

item:SetChildText(itemCmp.xinqingTx,FMT.fmt("心情值：{0}",lingshouModel:getLSXinQingValueEx(lsData)))





local fyNum=lingshouModel:getFanYanLeast(guid)
item:SetChildText(itemCmp.fanyanTx,FMT.fmt("繁衍剩余次数：{0}",fyNum))

item:SetChildActive(itemCmp.tick,mathHelper.compareInt64(guid,self.selects[sex]))
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)
local condition=yushoufangModel:getConditonCfg()
if lsData.jj_lvl<condition[1]then
local needLvStr=lingshouModel.getJJNameEx(condition[1],2)
item:SetChildText(itemCmp.banTx,FMT.fmt("需要达到{0}期",needLvStr))
item:SetChildActive(itemCmp.black,true)
elseif xinqing<condition[2]then
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
function UILingShouYSFSelectWin:onClickItem(index1,index2)
local lsData=self.lingShouList[index2]
local condition=yushoufangModel:getConditonCfg()
local xinqing=lingshouModel:getLSXinQingValueEx(lsData)
if lsData.jj_lvl<condition[1]then
local needLvStr=lingshouModel.getJJNameEx(condition[1],2)
return UIManager.error(FMT.fmt("需要达到{0}期",needLvStr))
elseif xinqing<condition[2]then
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
for i,v in ipairs(self.lingShouList)do
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
for i,v in ipairs(self.lingShouList)do
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
function UILingShouYSFSelectWin:refreshSelected(index)
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
function UILingShouYSFSelectWin:finishSelect(ubdId)
if self.ubdId==ubdId then
self:closeSelf()
end
end









def_class("UIMDiscipleSelect_AirGameWin",UIWindowBase)









function UIMDiscipleSelect_AirGameWin:bindComponents()

self.back=UIObject.get(self,0)
self.btnFire=UIButton.get(self,1)
self.btnWork=UIButton.get(self,2)
self.check1=UIImage.get(self,3)
self.check2=UIImage.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.condition=UIObject.get(self,6)
self.condition1=UIText.get(self,7)
self.condition2=UIText.get(self,8)
self.costTips=UIObject.get(self,9)
self.emptyIcon=UIObject.get(self,10)
self.emptyPart=UIObject.get(self,11)
self.emptyTip=UIText.get(self,12)
self.filterBtn=UIButton.get(self,13)
self.filterList=UIObject.get(self,14)
self.filterTabScrollView=UIObject.get(self,15)
self.filterTip=UIText.get(self,16)
self.mask=UIObject.get(self,17)
self.roleListPanel=UIObject.get(self,18)
self.searchBtn=UIButton.get(self,19)
self.searchCancelBtn=UIButton.get(self,20)
self.searchInput=UIInputField.get(self,21)
self.selectType=UIObject.get(self,22)
self.transTip=UIText.get(self,23)
self.transTipBg=UIObject.get(self,24)
self.txtFire=UIText.get(self,25)
self.txtWork=UIText.get(self,26)

self.btnFire:setButtonClick(function()self:onBtnFire()end)

self.btnWork:setButtonClick(function()self:onBtnWork()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIMDiscipleSelect_AirGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.btnFire);self.btnFire=nil;
_UIObject_release(self.btnWork);self.btnWork=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.emptyIcon);self.emptyIcon=nil;
_UIObject_release(self.emptyPart);self.emptyPart=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.filterList);self.filterList=nil;
_UIObject_release(self.filterTabScrollView);self.filterTabScrollView=nil;
_UIObject_release(self.filterTip);self.filterTip=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.selectType);self.selectType=nil;
_UIObject_release(self.transTip);self.transTip=nil;
_UIObject_release(self.transTipBg);self.transTipBg=nil;
_UIObject_release(self.txtFire);self.txtFire=nil;
_UIObject_release(self.txtWork);self.txtWork=nil;
end
















local item_cmp_index=
{
img_select=0,
icon_head=1,
txt_name=2,
txt_desc1=3,
txt_desc2=4,
txt_tips=5,
scrollView_spe=6,
icon_sign=7,
img_color=8,
icon_cursign=9,
grid_spe=10,
grid_speBtns=11,
txt_desc3=12,
ex_info=13,
chuiweiBack=14,
chuiweiImg=15,
jiuzhiBtn=16,
stateObj=17,
stateName=18,
fightTxt=19,
blackRoot=20,
blackTx=21,
xiangxi=22,
up=23,
taozhuangGrid=24,
jobRoot=25,
jobImg=26,
jobText=27,
order=28,
quguan=29,
exx_info=30,
exx_info_root=31,
txt_desc4=32,
lockRoot=33,
lockText=34,
rightRoot=35,
frame=36,
sixAttrList=37,
}

local _this

local _attrTabIdList={0,4,2,3,6,5,1}
local _attrTabNameList={"全 部","潜 力","根 骨","聪 慧","机 缘","魅 力","资 质"}



function UIMDiscipleSelect_AirGameWin:onLoaded(...)
self:bindComponents()

_this=self

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

self.filterIndex=1

self:preTipDesc()
end


function UIMDiscipleSelect_AirGameWin:__delete()
self.roleListPanel:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UIMDiscipleSelect_AirGameWin:onShow(argtable,afterOnloaded)
self.args=argtable


self.dzFilterTypeList=argtable.dzFilterTypeList or{}
self.sortPlanId=argtable.sortPlanId
self.selectdzguid=argtable.selectdzguid
self.dzShowTypeList=argtable.dzShowTypeList

self.workCallBack=argtable.workCallBack
self.fireCallBack=argtable.fireCallBack

self.filterTipDesc=argtable.filterTipDesc
self.emptyTipDesc=argtable.emptyTipDesc

self.isNotShowSearchBox=argtable.isNotShowSearchBox
self.isShowFireBtn=argtable.isShowFireBtn

self.select_index=nil
self.select_dz=self.selectdzguid

local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end

self.filterTip:setActive(self.filterTipDesc~=nil)
if self.filterTipDesc then
self.filterTip:setText(self.filterTipDesc)
end

self.emptyTip:setActive(self.emptyTipDesc~=nil)
if self.emptyTipDesc then
self.emptyTip:setText(self.emptyTipDesc)
end

self.searchInput:setActive(not self.isNotShowSearchBox)

self:refreshTabView()
self:refreshView()

if afterOnloaded then
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
end
end


function UIMDiscipleSelect_AirGameWin:onHide()

end

function UIMDiscipleSelect_AirGameWin:refreshTabView()
local createFunc=function(index)
local tabItem=_this.filterList:getChildLayoutGroupGridItem(index-1)
local tabid=_attrTabIdList[index]
local tabName=_attrTabNameList[index]

local isSelect=_this.filterIndex==index

tabItem:SetChildActive(0,isSelect)
tabItem:SetChildText(1,tabName)

tabItem:SetBaseItemClickEvent(-1,function()
local preItem=_this.filterList:getChildLayoutGroupGridItem(_this.filterIndex-1)
preItem:SetChildActive(0,false)

_this.filterIndex=index
tabItem:SetChildActive(0,true)

_this:refreshView()
end)

end
self.filterList:setChildLayoutGroupCreateItems(#_attrTabIdList,createFunc)
end

function UIMDiscipleSelect_AirGameWin:initDiscipleList()
self.disciplelist={}
local list=self:getNetDataList()
list=airGameEnterModel:getVocFilterDiscipleList(list)

for k,data in ipairs(list)do
local state=true
local guid=data.discipleguid


if state then
local temp={}
local sorts={}
temp.sorts=sorts
temp.disciple=data
if self.filterIndex==1 then
sorts[1]=UIDiscipleModel:getSixAttrTotalVal(guid)
else
local baseAttrType=_attrTabIdList[self.filterIndex]
sorts[1]=data.attrList[baseAttrType]
end

local voc=UIDiscipleModel:getDiscipleJob(guid)
local isLock=airGameEnterConfig.checkVocationUnLock(voc)
if isLock then
sorts[1]=10000+sorts[1]
end

if UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="审问中"then
temp.isInterrogation=true
elseif UIDiscipleModel:getDiscipleStateDesc(guid,'',nil,nil)=="垂危中"then
temp.isChuiWei=true
end

temp.checkCurrent=mathHelper.compareInt64(data.discipleguidStr,self.selectdzguid)

table.insert(self.disciplelist,temp)
end
end
end

function UIMDiscipleSelect_AirGameWin:refreshView()
self:refreshScrollView()
self:refreshButtons()

local isShowtTip=_this.filterIndex~=1
self.transTipBg:setActive(isShowtTip)
if isShowtTip then
local sixAttrId=_attrTabIdList[_this.filterIndex]
local transCfg=self.transLookUp[sixAttrId]
local sixAttrName=UIDiscipleModel:getDiscipleBaseAttrName(sixAttrId)
local transAttrName=cfgHelper.get2(cfg_airattributesconfig_get,transCfg.id,'attrname')
local info=FMT.fmt("{0}越高,天境中{1}越高",sixAttrName,transAttrName)
self.transTip:setText(info)
end
end

function UIMDiscipleSelect_AirGameWin:reSelectDisciple(default_idx)
default_idx=default_idx or 1
local dzNum=#self.disciplelist
if dzNum>0 then
if self.select_dz~=nil then
local f=nil
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.disciple.discipleguid,self.select_dz)then
f=i
break
end
end
if f then
self.select_index=f
else
self.select_index=default_idx
end
elseif self.select_index~=nil then
local f=self.disciplelist[self.select_index]
if f==nil then
self.select_index=default_idx
end
else
self.select_index=default_idx
end
else
self.select_index=nil
self.select_dz=nil
end
if self.select_index then
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
end
end

function UIMDiscipleSelect_AirGameWin:getNetDataList()
local list=UIDiscipleModel:getSortList()
if self.inputstr~=nil then
local temp={}
local temp_search={}
if self.nameSearchList==nil then
self.nameSearchList={}
end
for i,v in ipairs(list)do
local netData=v
local guid_str=netData.discipleguidStr
local str=self.nameSearchList[guid_str]
if str==nil then
str=UIDiscipleModel.getSearchName(guid_str,netData.disciplename)
self.nameSearchList[guid_str]=str
end
local d={v,str}
table.insert(temp_search,d)
end
if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
return temp
else
return list
end
end

function UIMDiscipleSelect_AirGameWin:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()

local isShowEmpty=#self.disciplelist==0
self.emptyPart:setActive(isShowEmpty)
end

function UIMDiscipleSelect_AirGameWin:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local item_cmp_index_=item_cmp_index

self:setHead(item,guid)

item:SetChildActive(item_cmp_index_.img_select,self.select_index==index)










if self.args.exInfoFunc then
local text1,text2=self.args.exInfoFunc(disdata)
item:SetChildText(item_cmp_index_.ex_info,text1)

if text2 then
item:SetChildActive(item_cmp_index_.exx_info_root,true)
item:SetChildText(item_cmp_index_.exx_info,text2)
else
item:SetChildActive(item_cmp_index_.exx_info_root,false)
end
else
item:SetChildText(item_cmp_index_.ex_info,'')
end




local attrLen=6
local sixAttrList=disdata.attrList
local createFunc=function(index)
local aitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.sixAttrList,index-1)
local val=sixAttrList[index]
local name=UIDiscipleModel:getDiscipleBaseAttrName(index)

aitem:SetChildText(0,name)
aitem:SetChildText(1,val)
end
item:SetChildLayoutGroupCreateItems(item_cmp_index_.sixAttrList,attrLen,createFunc)



local voc=UIDiscipleModel:getDiscipleJob(guid)
local isLock=not airGameEnterConfig.checkVocationUnLock(voc)

item:SetChildActive(item_cmp_index_.blackRoot,isLock)
if isLock then
local lockTip=airGameEnterConfig:getVocationUnLockTips(voc)
item:SetChildText(item_cmp_index_.blackTx,lockTip)
end
end

function UIMDiscipleSelect_AirGameWin.onDescSlotClick(disIdx,speIdx)
if _this==nil then return end
local item_cmp_index_=discipleSelectController.item_cmp_index
local data=_this.disciplelist[disIdx]
local effects=data.build_effects
local cfg=effects[speIdx]
local item=_this.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(item_cmp_index_.grid_spe,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIMDiscipleSelect_AirGameWin:refreshSelect(index,flag)

local item=self.grids[index-1]
local item_cmp_index_=discipleSelectController.item_cmp_index
item:SetChildActive(item_cmp_index_.img_select,flag)
end

function UIMDiscipleSelect_AirGameWin:onClickItem(index)
if self.select_index==index then return end

local old=self.select_index
self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid

local voc=UIDiscipleModel:getDiscipleJob(self.select_dz)
local isLock=not airGameEnterConfig.checkVocationUnLock(voc)
if isLock then
local lockTip=airGameEnterConfig:getVocationUnLockTips(voc)
UIManager.error(lockTip)
return
end

if self.grids.Count>old then
self:refreshSelect(old,false)
end
self:refreshSelect(index,true)
self:refreshButtons()
end

function UIMDiscipleSelect_AirGameWin:refreshButtons()
local c=#self.disciplelist
if c>0 then
local data=self.disciplelist[self.select_index]
local checkCurrent=data.checkCurrent
self.btnFire:setActive(checkCurrent and self.isShowFireBtn)
self.btnWork:setActive(not checkCurrent)

self.txtWork:setText(discipleSelectController.isDiziEmptyOrNil(self.selectdzguid)and'安排'or'替换')
self.txtFire:setText('卸任')
else
self.btnFire:setActive(false)
self.btnWork:setActive(false)
end
end


function UIMDiscipleSelect_AirGameWin:setHead(item,guid)
local item_cmp_index_=discipleSelectController.item_cmp_index

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(item_cmp_index_.img_color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

comHelper.setChildModelRawImage(item,guid,item_cmp_index_.icon_head,0,eHeadCenterType.eHalf,nil,false)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(item_cmp_index_.txt_name,name)

local fight_str
local dzData=UIDiscipleModel:getDiscipleData(guid)
local isShuWuDZ=dzData and UIDiscipleModel:isShuWuDisciple(dzData.id)
if isShuWuDZ then
local shili=UIDiscipleModel:getShuWuFightValue(guid)
fight_str=FMT.fmt('<color=#7d3b17>实力</color> {0}',shili)
else
fight_str=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid))
end
item:SetChildText(item_cmp_index_.fightTxt,fight_str)
end


function UIMDiscipleSelect_AirGameWin:preTipDesc()
self.transLookUp={}
local transAttrAllCfg=cfg_dizisixattrtransformconfig()
for index,cfg in pairs(transAttrAllCfg)do
self.transLookUp[cfg.sixAttrId]=cfg
end
end


function UIMDiscipleSelect_AirGameWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self:clearSearchInput()
self:refreshView()
end

function UIMDiscipleSelect_AirGameWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIMDiscipleSelect_AirGameWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIMDiscipleSelect_AirGameWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end


local checkResetFunc=function(callback)
if airGameEnterModel:checkShowChangeInfoDialouge()then
local showdata=
{
type='UIDialouge',
title='提示',
content='当前有未完成的挑战，切换弟子将清除记录，是否切换？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
airGameEnterModel:setCancelContinueFlag(true)
airController:clearActorDataAndProcessData()
callback()
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
else
callback()
end
end

function UIMDiscipleSelect_AirGameWin:onBtnWork()

if self.select_index then
local data=self.disciplelist[self.select_index]
local disdata=data.disciple
local checkCurrent=data.checkCurrent
if checkCurrent then
UIManager.error("已安排此弟子")
else
if self.workCallBack then
local func=function()
self.workCallBack(disdata)
self:onClickClose()
end
checkResetFunc(func)
else
logErr("缺少安排 回调方法")
end
end
else
UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
end

function UIMDiscipleSelect_AirGameWin:onBtnFire()
if not discipleSelectController.isDiziEmptyOrNil(self.select_dz)then
if self.select_index then
if self.fireCallBack then
local func=function()
self.fireCallBack()
self:onClickClose()
end
checkResetFunc(func)
else
logErr("缺少卸任 回调方法")
end
else
UIManager.error(cfgHelper.getlang('disciple_select_tips_5'))
end
else

UIManager.error('还未选择弟子')
end
end

function UIMDiscipleSelect_AirGameWin:onClickClose()
self:closeSelf()
end

function UIMDiscipleSelect_AirGameWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshView()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
self.inputstr=inputstr
local list=self:getNetDataList()
if#list<=0 then
self.inputstr=nil
UIManager.info('宗门查无此人')
return
end
self.searchInput:setInputFieldValue('')
self:refreshView()
end

function UIMDiscipleSelect_AirGameWin:onCloseBtn()
self:closeSelf()
end

function UIMDiscipleSelect_AirGameWin:onFilterBtn()

local args={}
args.titleName="筛选职业"

args.extraWin='UIAirGameFilterDiscipleWin'
args.extraParams={}
args.closeCB=function()
if _this==nil then return end
_this:refreshView()
end
UIManager:showWindow('UICommonPageTwoWin',args)
end












def_class("UISchoolDiscipleSelectWin",UIWindowBase)








function UISchoolDiscipleSelectWin:bindComponents()

self.back=UIObject.get(self,0)
self.discipleNumText=UIText.get(self,1)
self.okBtn=UIButton.get(self,2)
self.roleListPanel=UIObject.get(self,3)
self.sortOrderButton=UIButton.get(self,4)
self.tipsText=UIText.get(self,5)
self.UIComboBox=UIObject.get(self,6)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UISchoolDiscipleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.UIComboBox);self.UIComboBox=nil;
end

















local _this

local itemIndex={
bg=0,
name=1,
head=2,
desc=3,
sixAttr=4,
flag=5,
level=6,
newFlag=7,
jobImg=8,
lv_obj=9,
spDzFlag=11,
}

local selectSortType={
class=1,
sixAttr=2,
}

local selectDzList={}


local sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
local sixAttrName=''



function UISchoolDiscipleSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.eSortOrder=eSortOrder.eDown

local _OnClickRoleItemCallback=function(...)
self:OnClickRoleItemCallback(...)
end
local _OnLongClickRoleItemCallBack=function(...)
self:onLongClickRoleItemCallBack(...)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,_OnLongClickRoleItemCallBack)

self.UIComboBox:setChildComboBoxInit(self.on_combobox_change)
end


function UISchoolDiscipleSelectWin:__delete()
_this=nil
selectDzList={}
self.eSortOrder=nil
self.selectSortType=nil
self.selectClass=nil
self.tableCount=nil
self:unbindComponents()
end

function UISchoolDiscipleSelectWin.on_combobox_change(index)
if _this.selectSortType==index+1 then
return
end
_this.selectSortType=index+1
_this.eSortOrder=eSortOrder.eDown
if _this.selectClass then
if _this.selectSortType==selectSortType.class then
_this:refreshRoleListByClass()
else
_this:refreshRoleListBySixAttr()
end
else
_this:refreshRoleListBySixAttr()
end
end





function UISchoolDiscipleSelectWin:onShow(argtable,afterOnloaded)
self.selectClass=argtable.curClass
self.tableCount=argtable.tableCount
local selectTableIdx=argtable.tableIdx
local selecteddzList=argtable.diziList


for i=1,self.tableCount do
local guid=selecteddzList[i]
if guid then
selectDzList[#selectDzList+1]=guid
else
selectDzList[#selectDzList+1]=0
end
end

self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self:initSort()
self.on_combobox_change(0)
end


function UISchoolDiscipleSelectWin:onHide()

end

function UISchoolDiscipleSelectWin:initSort()
local option={}
local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
sixAttrName=sixAttrCfg[sixAttrType].name
if self.selectClass then
local proSkillName=cfgHelper.get2(cfg_discipleproskillconfig_get,self.selectClass,'name')
option={FMT.fmt('{0}等级',proSkillName),sixAttrName}
else
option={sixAttrName}
end
self.UIComboBox:setChildComboBoxOption(0,option)

self.tipsText:setText('弟子聪慧越高获得专业经验越多')
end




function UISchoolDiscipleSelectWin:onSortOrderButton()
self.eSortOrder=not self.eSortOrder
if self.selectClass then
if self.selectSortType==selectSortType.class then
self:refreshRoleListByClass()
else
self:refreshRoleListBySixAttr()
end
else
self:refreshRoleListBySixAttr()
end
end


function UISchoolDiscipleSelectWin:onOkBtn()
local win=UIManager:findActiveWindow('UISchoolMainWin')
if win then
win:setSelectDZlist(selectDzList)
win:refreshTableInfo()
win:playAnimation(UISchoolModel.curAniState.changeDZ)
if self.selectClass then
UISchoolModel:changeClassSelectDzDataListByClassType(self.selectClass,selectDzList)
end
end
if UIManager:findActiveWindow('UIGuildOrderSetupWin_autoClass')then
if self.selectClass then
UISchoolModel:changeClassSelectDzDataListByClassType(self.selectClass,selectDzList)
end
UIManager:callWindowFunc('UIGuildOrderSetupWin_autoClass','refreshDZList',selectDzList)
end
self:closeSelf()
end


function UISchoolDiscipleSelectWin:refreshRoleListByClass()
self.disciplesList=UISchoolModel:getDZListSortResult(sixAttrType,self.selectClass,self.eSortOrder,selectSortType.class)
self:initRoleListPanel()
end


function UISchoolDiscipleSelectWin:refreshRoleListBySixAttr()
self.disciplesList=UISchoolModel:getDZListSortResult(sixAttrType,self.selectClass,self.eSortOrder,selectSortType.sixAttr)
self:initRoleListPanel()
end


function UISchoolDiscipleSelectWin:initRoleListPanel()
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local netdata=self.disciplesList[i].netData
local net=netdata.net
local guid=net.discipleguid

local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(guid,sixAttrType)

local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,self.selectClass)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(itemIndex.bg,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(itemIndex.jobImg,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(itemIndex.spDzFlag,isSpDz)

local isnew=netdata.isnew==true
item:SetChildActive(itemIndex.newFlag,isnew)

item:SetChildText(itemIndex.name,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,itemIndex.head,0,eHeadCenterType.eHalf)

local showClassLevel=self.selectClass~=nil
item:SetChildActive(itemIndex.lv_obj,showClassLevel)
if showClassLevel then

item:SetChildCSImageSprite(itemIndex.lv_obj,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
item:SetChildText(itemIndex.level,tostring(classLevel))
end

local sixAttrStr=FMT.fmt('{0} <color=#171311ff>{1}</color>',sixAttrName,sixAttrValue)
item:SetChildText(itemIndex.sixAttr,sixAttrStr)


local desc=UIDiscipleModel:getDiscipleStateDesc(guid)





local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local nextlevel=expList[classLevel+1]
if nextlevel==nil then
desc=FMT.fmt('<color=#FF7C80>已满级</color>')
end
item:SetChildText(itemIndex.desc,desc)
local isSelected=self:checkSelectDz(guid)

item:SetChildActive(itemIndex.flag,isSelected)
end
self:refreshSelectDiZiCount()
end

function UISchoolDiscipleSelectWin:checkSelectDz(guid)
for index,v in ipairs(selectDzList)do
if mathHelper.compareInt64(v,guid)then
return true,index
end
end
return false
end

function UISchoolDiscipleSelectWin:getSelectDzLength()
local len=0
for _,v in ipairs(selectDzList)do
if v~=0 then
len=len+1
end
end
return len
end


function UISchoolDiscipleSelectWin:OnClickRoleItemCallback(clickCount,index)

local netdata=self.disciplesList[index+1].netData
local guid=netdata.net.discipleguid
local isSelected,idx=self:checkSelectDz(guid)
local selectedDzCnt=self:getSelectDzLength()
if isSelected then
selectDzList[idx]=0
else
if selectedDzCnt>=self.tableCount then
UIManager.error('没有位置了')
return
end












local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,self.selectClass)
local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local nextlevel=expList[classLevel+1]
if nextlevel==nil then
UIManager.error('弟子已满级')
return
end
for i,v in ipairs(selectDzList)do
if v==0 then
selectDzList[i]=guid
break
end
end
end
self:refreshSelectDiZiCount()
local item=self.roleListPanel:getChildScrollViewItemWidget(index)
item:SetChildActive(itemIndex.flag,not isSelected)
end


function UISchoolDiscipleSelectWin:onLongClickRoleItemCallBack(clickCount,index)

local dzdata=self.disciplesList[index+1].netData
local guid=dzdata.net.discipleguid

local data=otherPlayerModel.discipleStruct_to_discipleStruct3(dzdata.net)
local selfActorId=playerModel:getActorID()
otherPlayerModel:addDZData(selfActorId,data,false)

local args={}
args.dis_guid=guid
args.dislist={data}
args.tabType=FULL_TAB_TYPE.eOtherDiscipleAttr
UIManager:showWindow('UIOtherDiscipleMainWin',args)
end

function UISchoolDiscipleSelectWin:refreshSelectDiZiCount()
local cur=self:getSelectDzLength()
local max=self.tableCount
local color_str
local btnGray=false
if cur<=0 then
btnGray=true
color_str='<color=#c82c2cff>{0}/{1}</color>'
else
color_str='{0}/{1}'
end
local num_str=FMT.fmt(color_str,cur,max)
self.discipleNumText:setText(num_str)
self.okBtn:setGray(btnGray)
self.okBtn:setButtonInteractable(not btnGray)
end









def_class("UIMysteryEventDiscipleSelectWin",UIWindowBase)









function UIMysteryEventDiscipleSelectWin:bindComponents()

self.back=UIObject.get(self,0)
self.discipleNumText=UIText.get(self,1)
self.okBtn=UIButton.get(self,2)
self.roleListPanel=UIObject.get(self,3)
self.sortOrderButton=UIButton.get(self,4)
self.tipsText=UIText.get(self,5)
self.titlle=UIText.get(self,6)
self.UIComboBox=UIObject.get(self,7)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)



end


function UIMysteryEventDiscipleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.discipleNumText);self.discipleNumText=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.titlle);self.titlle=nil;
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



local selectDzList={}
local sixAttrName=''


function UIMysteryEventDiscipleSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.eSortOrder=eSortOrder.eDown
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
local _OnClickRoleItemCallback=function(...)
self:OnClickRoleItemCallback(...)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)

self.UIComboBox:setChildComboBoxInit(self.on_combobox_change)
end


function UIMysteryEventDiscipleSelectWin:__delete()
_this=nil
selectDzList={}
self.eSortOrder=nil
self.selectSortType=nil
self.selectClass=nil
self.tableCount=nil
self:unbindComponents()
end

function UIMysteryEventDiscipleSelectWin.on_combobox_change(index)
if _this.selectSortType==index+1 then
return
end
_this.selectSortType=index+1
_this.eSortOrder=eSortOrder.eDown
_this:refreshRoleList()
end





function UIMysteryEventDiscipleSelectWin:onShow(argtable,afterOnloaded)
self.condition=argtable.condition
self.tableCount=argtable.tableCount or 1
local selectTableIdx=argtable.tableIdx
local selecteddzList=argtable.diziList
local condtionStr=argtable.conditionStr
local titleStr=argtable.titleStr

for i=1,self.tableCount do
selectDzList[i]=0
end

self.tipsText:setText(condtionStr or"")
if titleStr and titleStr~=""then
self.titlle:setText(titleStr)
end

self:initSort()
self.on_combobox_change(0)

self.okFunc=argtable.okFunc

end


function UIMysteryEventDiscipleSelectWin:onHide()

end

function UIMysteryEventDiscipleSelectWin:initSort()
local sortType={}
local str=''
if self.condition then
for i,v in ipairs(self.condition)do
local conditionType=v[2]
sortType[conditionType]=1
end
end
local sortTypeList={}
for t,v in pairs(sortType)do
table.insert(sortTypeList,t)
end
end






function UIMysteryEventDiscipleSelectWin:onSortOrderButton()
self.eSortOrder=not self.eSortOrder
self:refreshRoleList()
end


function UIMysteryEventDiscipleSelectWin:onOkBtn()
if self.okFunc then
self.okFunc(selectDzList)
end
self:closeSelf()
end


function UIMysteryEventDiscipleSelectWin:refreshRoleList()
self.disciplesList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,{},eSortOrder.eDown)

table.sort(self.disciplesList,function(a,b)
if self:checkMatchCondition(self.condition,a.netData.net.discipleguid)and not self:checkMatchCondition(self.condition,b.netData.net.discipleguid)then
return true
else
return false
end
end)
self:initRoleListPanel()
end

function UIMysteryEventDiscipleSelectWin:checkMatchCondition(conditionCfg,guid,warring)
if not next(conditionCfg)then
return true
end
local conditionType,value,notMatchIndex
local isMatch=true
for i,v in ipairs(conditionCfg)do
conditionType=v[2]
value=v[3]
if not MysteryEventCnd:can_match_condition(conditionType,guid,value,warring)then
isMatch=false
notMatchIndex=i
break
end
end
if isMatch then

notMatchIndex=#conditionCfg
end
return isMatch
end


function UIMysteryEventDiscipleSelectWin:initRoleListPanel()
local dataNum=#self.disciplesList
self.roleListPanel:setChildScrollViewCreateGrids(dataNum,6)

local grids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local netdata=self.disciplesList[i].netData
local net=netdata.net
local guid=net.discipleguid


local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(itemIndex.bg,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(itemIndex.jobImg,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(itemIndex.spDzFlag,isSpDz)

item:SetChildActive(itemIndex.newFlag,false)
item:SetChildActive(10,false)

item:SetChildText(itemIndex.name,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,itemIndex.head,0,eHeadCenterType.eHalf)

item:SetChildText(itemIndex.level,UIDiscipleModel:getDiscipleJJLevel(guid))




local str=''

if self.condition and next(self.condition)then
for i,v in ipairs(self.condition)do
local conditionType=v[2]
local value=v[3]
local desc=MysteryEventCnd:getTips(conditionType,guid,value,{"#23911b","#ce0b0b"})
str=FMT.fmt("{0} {1}",str,desc)
end
item:SetChildText(itemIndex.sixAttr,str)
else
item:SetChildText(itemIndex.sixAttr,FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid)))
end

local isSelected=self:checkSelectDz(guid)

item:SetChildActive(itemIndex.flag,isSelected)
end
self:refreshSelectDiZiCount()
end

function UIMysteryEventDiscipleSelectWin:checkSelectDz(guid)
for index,v in ipairs(selectDzList)do
if mathHelper.compareInt64(v,guid)then
return true,index
end
end
return false
end

function UIMysteryEventDiscipleSelectWin:getSelectDzLength()
local len=0
for _,v in ipairs(selectDzList)do
if v~=0 then
len=len+1
end
end
return len
end


function UIMysteryEventDiscipleSelectWin:OnClickRoleItemCallback(clickCount,index)

local netdata=self.disciplesList[index+1].netData
local guid=netdata.net.discipleguid
local isSelected,idx=self:checkSelectDz(guid)
local selectedDzCnt=self:getSelectDzLength()

if isSelected then
selectDzList[idx]=0
else
if selectedDzCnt>=self.tableCount then
UIManager.error('弟子已选满')
return
end

if not self:checkMatchCondition(self.condition,guid,true)then
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

function UIMysteryEventDiscipleSelectWin:refreshSelectDiZiCount()
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

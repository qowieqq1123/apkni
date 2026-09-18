







def_class("UIXMFenpeiSelectWin",UIWindowBase)









function UIXMFenpeiSelectWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.titleText=UIText.get(self,2)
self.btnClose=UIButton.get(self,3)
self.back=UIObject.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.sortConditionButton=UIButton.get(self,6)
self.sortOrderButton=UIButton.get(self,7)
self.sortTypeDropdown=UIDropdown.get(self,8)
self.actorListPanel=UIObject.get(self,9)
self.sureBtn=UIButton.get(self,10)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.sortOrderButton:setButtonClick(function()self:onSortOrderButton()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIXMFenpeiSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.sortOrderButton);self.sortOrderButton=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
end


















local selectActorItemCmp={
icon=0,
level=1,
name=2,
fight=3,
huoyue=4,
bg=5,
select=6,
}
local sortTypeName={
'飞升台修复',
'七日活跃',
'实力',
}


function UIXMFenpeiSelectWin:onLoaded(...)
self:bindComponents()
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIXMFenpeiSelectWin:__delete()
self:unbindComponents()
end




function UIXMFenpeiSelectWin:onShow(argtable,afterOnloaded)
self.sortTypeDropdown:setOption(sortTypeName)
self.sortType=3
self.sortOrder=eSortOrder.eDown
self.filterFlag={

{
true,
true,
}
}
self.sortTypeDropdown:setValue(self.sortType-1)

end


function UIXMFenpeiSelectWin:onHide()

end

function UIXMFenpeiSelectWin:onDropdownChange(idx)

idx=idx+1
self.sortType=idx
self:refreshMemberList()
end

function UIXMFenpeiSelectWin:checkfilterCdn(temp)
local fftTilterFlag=self.filterFlag[1]
for i,v in ipairs(fftTilterFlag)do
if not v then
if i==1 then
if xianmengModel:chexkFSTIsFinsh(temp.actorid)then
return false
end
elseif i==2 then
if not xianmengModel:chexkFSTIsFinsh(temp.actorid)then
return false
end
end
end
end
return true
end

function UIXMFenpeiSelectWin:refreshMemberList()
self.selectIndex=nil
local list=xianmengModel:getXMMemberList()
local temp={}
for i,v in ipairs(list)do
if self:checkfilterCdn(v)then
local d={}
d.netData=v
d.actorid=v.actorid
d.sorthuoyue=v.weekscore
d.sortfight=tonumber(tostring(v.fight))
d.sortFST=xianmengModel:chexkFSTIsFinsh(v.actorid)and 1 or 0
table.insert(temp,d)
end
end




if self.sortType==1 then
table.sort(temp,function(a,b)
if self.sortOrder==eSortOrder.eDown then
return a.sortFST>b.sortFST
else
return a.sortFST<b.sortFST
end
end)
elseif self.sortType==2 then
table.sort(temp,function(a,b)
if self.sortOrder==eSortOrder.eDown then
return a.sorthuoyue>b.sorthuoyue
else
return a.sorthuoyue<b.sorthuoyue
end
end)
elseif self.sortType==3 then
table.sort(temp,function(a,b)
if self.sortOrder==eSortOrder.eDown then
return a.sortfight>b.sortfight
else
return a.sortfight<b.sortfight
end
end)
end
self.memberList=temp
local c=#self.memberList
self.actorListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.actorListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshItem(grids[i-1],i)
end
end

function UIXMFenpeiSelectWin:getMemberIndex(actorid)
for i,v in ipairs(self.memberList)do
if mathHelper.compareInt64(v.actorid,actorid)then
return i
end
end
return nil
end

function UIXMFenpeiSelectWin:refreshItemByActorID(actorid)
local index=self:getMemberIndex(actorid)
if index then
self:refreshItem(nil,index)
end
end

function UIXMFenpeiSelectWin:refreshItem(item,index)
if item==nil then
item=self.actorListPanel:getChildScrollViewItemWidget(index-1)
end

if item then
local actorData=self.memberList[index].netData
playerController:setHeadIcon(item,selectActorItemCmp.icon,{iconInfo=actorData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

item:SetChildText(selectActorItemCmp.level,tostring(actorData.level))

item:SetChildText(selectActorItemCmp.name,actorData.actorname)

local fightnum=tonumber(tostring(actorData.fight))
local fight_str=FMT.fmt('实力：{0}',mathHelper.formatNumber3(fightnum))
item:SetChildText(selectActorItemCmp.fight,fight_str)

local huoyue=FMT.fmt('七日活跃：{0}',tostring(actorData.weekscore))
if self.sortType==1 then

huoyue=self.memberList[index].sortFST==1 and"飞升台修复：<color=#c82c2c>完成</color>"or"飞升台修复：<color=#549327>未完成</color>"
end
item:SetChildText(selectActorItemCmp.huoyue,huoyue)

item:SetChildActive(selectActorItemCmp.select,self.selectIndex==index)
item:SetChildButtonClick(selectActorItemCmp.bg,function()
self:onItemClick(index)
end)
end
end

function UIXMFenpeiSelectWin:refreshItemSelect(item,index)
if item==nil then
item=self.actorListPanel:getChildScrollViewItemWidget(index-1)
end
if item then

item:SetChildActive(selectActorItemCmp.select,self.selectIndex==index)
end
end





function UIXMFenpeiSelectWin:onCloseClick()
self:closeSelf()
end

function UIXMFenpeiSelectWin:onBtnClose()
self:closeSelf()
end



function UIXMFenpeiSelectWin:onSortConditionButton()

self.filterName={
{
'飞升台修复',
{
{name='完成'},
{name='未完成'},
},
},
}
local callback=function(data)
self.filterFlag=data.filterFlag
self:refreshMemberList()
end
local args={}
args.titleName="仙盟成员筛选"

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=callback}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageTwoWin',args)
end


function UIXMFenpeiSelectWin:onSortOrderButton()
self.sortOrder=not self.sortOrder
self:refreshMemberList()
end


function UIXMFenpeiSelectWin:onItemClick(index)
local actorData=self.memberList[index].netData

if self.selectIndex then
if self.selectIndex==index then
self.selectIndex=nil
else
local oldIndex=self.selectIndex
self.selectIndex=index

self:refreshItemSelect(nil,oldIndex)
end
else
self.selectIndex=index
end

self:refreshItemSelect(nil,index)




end

function UIXMFenpeiSelectWin:onSureBtn()
local actorData
if self.selectIndex then
actorData=self.memberList[self.selectIndex].netData
end
UIManager:invokeUIMethod("UIXMCK_ZH_FP_Win","selectActor",actorData)
self:closeSelf()
end

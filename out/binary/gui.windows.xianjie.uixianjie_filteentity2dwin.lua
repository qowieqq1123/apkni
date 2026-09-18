







def_class("UIXianJie_filteEntity2DWin",UIWindowBase)









function UIXianJie_filteEntity2DWin:bindComponents()

self.block=UIButton.get(self,0)
self.filter2GridPanel=UIObject.get(self,1)
self.filter2Panel=UIObject.get(self,2)
self.filterGridPanel=UIObject.get(self,3)
self.filter3Panel=UIObject.get(self,4)
self.filter3GridPanel=UIObject.get(self,5)
self.filter3Viewport=UIObject.get(self,6)
self.filter2Arrow=UIObject.get(self,7)
self.filter2Viewport=UIObject.get(self,8)
self.bottomPos=UIObject.get(self,9)

self.block:setButtonClick(function()self:onBlock()end)



end


function UIXianJie_filteEntity2DWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.block);self.block=nil;
_UIObject_release(self.filter2GridPanel);self.filter2GridPanel=nil;
_UIObject_release(self.filter2Panel);self.filter2Panel=nil;
_UIObject_release(self.filterGridPanel);self.filterGridPanel=nil;
_UIObject_release(self.filter3Panel);self.filter3Panel=nil;
_UIObject_release(self.filter3GridPanel);self.filter3GridPanel=nil;
_UIObject_release(self.filter3Viewport);self.filter3Viewport=nil;
_UIObject_release(self.filter2Arrow);self.filter2Arrow=nil;
_UIObject_release(self.filter2Viewport);self.filter2Viewport=nil;
_UIObject_release(self.bottomPos);self.bottomPos=nil;
end
















local _this=nil
local itemH=74
local offestH={5,5}
local itemSpace=6
local maxShowCnt=5
local overOffest=20
local infoPanelH=504

function UIXianJie_filteEntity2DWin:onLoaded(...)
_this=self
self:bindComponents()
local pos=self.bottomPos:getChildScreenPointToLocalPointRectangle(-1)
self.bottomY=pos.y+offestH[2]
self.topY=pos.y+infoPanelH-offestH[1]
end


function UIXianJie_filteEntity2DWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianJie_filteEntity2DWin:onHide()

end




function UIXianJie_filteEntity2DWin:onShow(argtable,afterOnloaded)
self:refreshInfoPanel()
end

function UIXianJie_filteEntity2DWin:refreshInfoPanel()
if self.filterList==nil or self.refreshFlag then
self.refreshFlag=false
self.filterList,self.lookUpkeyList=xianjieController:getFilterEntity2DCfg()
self.filterRecord=xianjieController:getFilterEntity2DRecord()

local c=#self.lookUpkeyList
self.filterGridPanel:setChildLayoutGroupClearAllItems()
self.filterGridPanel:setChildLayoutGroupCreateItems(c)
local sceneidx=xianjieModel:getSceneIndex()
local grids=self.filterGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local type1=self.lookUpkeyList[i].type1
local cfgEx=cfg_fairylandentitybigicontypeconfig_get(type1)
local isHideflag=cfgEx.isHide
local isHide=true
if isHideflag then
if isHideflag==0 then
isHide=true
else
if xianjienSceneIndexType:isMoJie(sceneidx)then
isHide=not(isHideflag==2)
elseif xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
isHide=not(isHideflag==3)
else
isHide=not(isHideflag==1)
end
end
else
isHide=false
end
if not isHide then
item:SetChildActive(-1,true)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onFilterItemClick(i)
end)

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onCtrlAllClick(i)
end)



local icon=cfgEx.icon
local extra=cfgEx.filteWinExtra
if extra and extra[3]then
icon=nil
end
xianjieController:createXjIcon(globalABLookup.xjhud2icons,icon,extra,item,1)


local name=cfgEx.name
if type1==14 or type1=="14"then

name=xianjieModel:getSgMonsterTypeName()
end
item:SetChildText(2,name)

self:refeshFilterItemSelect(item,i)
else
item:SetChildActive(-1,false)
end
end
end
end


function UIXianJie_filteEntity2DWin:onCtrlAllClick(idx)
local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1
local len=#list1

if len==1 then
self:openFilter2(false)
else
local item=self.filterGridPanel:getChildLayoutGroupGridItem(idx-1)
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
self:openFilter2(true,idx,pos.x,pos.y)
end


local flag=false
for i,v in ipairs(list1)do
local type2=v.type2
for ii,vv in ipairs(v.list2)do
local type3=vv
flag=self:getFilterRecord(type1,type2,type3)
if flag then
break
end
end
if flag then
break
end
end
flag=not flag

if not self.filterRecord then
self.filterRecord=xianjieController:getFilterEntity2DRecord()
end
if not self.filterRecord[type1]then
self.filterRecord[type1]={}
end

for i,v in ipairs(list1)do
local type2=v.type2
if not self.filterRecord[type1][type2]then
self.filterRecord[type1][type2]={}
end
for ii,vv in ipairs(v.list2)do
local type3=vv
self.filterRecord[type1][type2][type3]=flag
end
end

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJFilter)
self:refeshFilterItemSelect(nil,idx)
for sidx=1,len do
self:refeshFilter2ItemSelect(nil,sidx)
end

xianjieController:changeFilterEntity2DEx(type1)
end


function UIXianJie_filteEntity2DWin:onFilterItemClick(idx)
local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1
local len=#list1

if len==1 then
local flag=self:getFilterRecord(type1,"1","1")
self:setFilterRecord(type1,"1","1",not flag)
self:refeshFilterItemSelect(nil,idx)
self:openFilter2(false)
xianjieController:changeFilterEntity2D(type1)
else
if self.filter2Index~=idx then
local item=self.filterGridPanel:getChildLayoutGroupGridItem(idx-1)
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
self:openFilter2(true,idx,pos.x,pos.y)
else
self:openFilter2(false)
end
end
end

function UIXianJie_filteEntity2DWin:refeshFilterItemSelect(item,idx)
if item==nil then
item=self.filterGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local type1=self.lookUpkeyList[idx].type1

local list=self.filterRecord[type1]

local isblack=true
if list then
for i,subList in pairs(list)do
for i2,flag in pairs(subList)do
if flag==true then
isblack=false
break
end
end
if not isblack then
break
end
end
else
isblack=false
end
item:SetChildActive(3,isblack)
end

function UIXianJie_filteEntity2DWin:openFilter2(flag,idx,moveX,moveY)
if flag then

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local d=self.filterList[type1]
self.filter2Index=idx
self.filter2Panel:setActive(true)



local c=#list1
local isOver=c>maxShowCnt
local showLen=isOver and maxShowCnt or c
local clickItemCenterY=moveY-itemH/2
local clickItemDis_top=self.topY-clickItemCenterY
local clickItemDis_bottom=clickItemCenterY-self.bottomY

local vh=showLen*itemH+(showLen-1)*itemSpace+(isOver and overOffest or 0)
local ph=vh+offestH[1]+offestH[2]
local contentH=showLen*itemH+(showLen-1)*itemSpace
local halfContent=contentH/2
local targetY=clickItemCenterY
if halfContent<=clickItemDis_top and halfContent<=clickItemDis_bottom then
targetY=targetY+halfContent+offestH[1]
elseif halfContent>clickItemDis_top then
targetY=targetY+itemH/2
local over=contentH-(targetY-self.bottomY-overOffest)
if over>0 then
targetY=targetY+over
end
targetY=targetY+offestH[1]
elseif halfContent>clickItemDis_bottom then
targetY=targetY+itemH/2


local over=contentH-(targetY-self.bottomY-overOffest)


targetY=targetY+over+offestH[1]
else

end



self.filter2Panel:setLocalPos(moveX+315,targetY,0)



self.filter2Arrow:setActive(true)
self.filter2Arrow:setLocalPos(moveX+310,moveY-37,0)


self.filter2Viewport:setChildSizeDelta(308,vh)
self.filter2Panel:setChildSizeDelta(308,ph)
self.filter2Panel:setChildScrollRectEnable(c>maxShowCnt)

self.filter2GridPanel:setChildLayoutGroupClearAllItems()
self.filter2GridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.filter2GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local type2=list1[i].type2
local d_=d[type2]
local id=d_.type2Id
local cfg=cfg_fairylandentityicontypeconfig_get(id)
local name=cfg.name

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onFilter2ItemClick(i)
end)


local icon=cfg.icon
local extra=cfg.filteWinExtra
if extra and extra[3]then
icon=nil
end
xianjieController:createXjIcon(globalABLookup.xjhud2icons,icon,extra,item,1)

item:SetChildText(2,name)

self:refeshFilter2ItemSelect(item,i)
end
else
self.filter2Arrow:setActive(false)
self.filter2Panel:setActive(false)
self.filter2Index=nil
if self.filter3Index then
self:openFilter3(false)
end
end
end



function UIXianJie_filteEntity2DWin:onFilter2ItemClick(sidx)
local idx=self.filter2Index

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local type2=list1[sidx].type2
local list2=list1[sidx].list2

local len=#list2
if len==1 then
local flag=self:getFilterRecord(type1,type2,"1")
self:setFilterRecord(type1,type2,"1",not flag)
self:refeshFilter2ItemSelect(nil,sidx)
self:refeshFilterItemSelect(nil,idx)
self:openFilter3(false)
xianjieController:changeFilterEntity2D(type1,type2)
else
if self.filter3Index~=sidx then
local item=self.filter2GridPanel:getChildLayoutGroupGridItem(sidx-1)
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
self:openFilter3(true,sidx,pos.x,pos.y)
else
self:openFilter3(false)
end
end
end

function UIXianJie_filteEntity2DWin:refeshFilter2ItemSelect(item,sidx)
if item==nil then
item=self.filter2GridPanel:getChildLayoutGroupGridItem(sidx-1)
end
if not item or not self.filter2Index then
return
end
local idx=self.filter2Index

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local type2=list1[sidx].type2

local isblack=true
local list=self.filterRecord[type1]
local subList=list and list[type2]or nil
if subList then
for i2,flag in pairs(subList)do
if flag==true then
isblack=false
break
end
end
else
isblack=false
end

item:SetChildActive(3,isblack)
end

function UIXianJie_filteEntity2DWin:onBlock()










UIManager:invokeUIMethod('UIXianJie_mapWin','closeFilterWin2')
self:closeSelf()
end

function UIXianJie_filteEntity2DWin:openFilter3(flag,sidx,moveX,moveY)
if flag then
local idx=self.filter2Index

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local type2=list1[sidx].type2
local list2=list1[sidx].list2

local d=self.filterList[type1][type2]
self.filter3Index=sidx
self.filter3Panel:setActive(true)
self.filter3Panel:setLocalPos(moveX+315,moveY,0)


local c=#list2
local isOver=c>maxShowCnt
local showLen=isOver and maxShowCnt or c
local vh=showLen*itemH+(showLen-1)*itemSpace+(isOver and overOffest or 0)
local ph=vh+offestH[1]+offestH[2]
self.filter3Viewport:setChildSizeDelta(308,vh)
self.filter3Panel:setChildSizeDelta(308,ph)
self.filter3Panel:setChildScrollRectEnable(isOver)


self.filter3GridPanel:setChildLayoutGroupClearAllItems()
self.filter3GridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.filter3GridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local type3=list2[i]
local d_=d[type3]
local id=d_.id
local cfg=cfg_fairylandentityicontypeconfig2_get(id)
local name=cfg.name


item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onFilter3ItemClick(i)
end)


local icon=cfg.icon
local extra=cfg.filteWinExtra
if extra and extra[3]then
icon=nil
end
xianjieController:createXjIcon(globalABLookup.xjhud2icons,icon,extra,item,1)

item:SetChildText(2,name)

self:refeshFilter3ItemSelect(item,i)
end


else
self.filter3Panel:setActive(false)
self.filter3Index=nil
end
end


function UIXianJie_filteEntity2DWin:onFilter3ItemClick(ssidx)
local idx=self.filter2Index
local sidx=self.filter3Index

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local type2=list1[sidx].type2
local list2=list1[sidx].list2

local type3=list2[ssidx]

local d=self.filterList[type1][type2]

local flag=self:getFilterRecord(type1,type2,type3)
self:setFilterRecord(type1,type2,type3,not flag)
self:refeshFilter3ItemSelect(nil,ssidx)
self:refeshFilter2ItemSelect(nil,sidx)
self:refeshFilterItemSelect(nil,idx)
xianjieController:changeFilterEntity2D(type1,type2,type3)
end

function UIXianJie_filteEntity2DWin:refeshFilter3ItemSelect(item,ssidx)
if item==nil then
item=self.filter3GridPanel:getChildLayoutGroupGridItem(ssidx-1)
end
local idx=self.filter2Index
local sidx=self.filter3Index

local type1=self.lookUpkeyList[idx].type1
local list1=self.lookUpkeyList[idx].list1

local type2=list1[sidx].type2
local list2=list1[sidx].list2

local type3=list2[ssidx]

local isblack=self:getFilterRecord(type1,type2,type3)==false
item:SetChildActive(3,isblack)
end

function UIXianJie_filteEntity2DWin:getFilterRecord(type1,type2,type3)
if not self.filterRecord then
return true
end
if not self.filterRecord[type1]then
return true
end
if not self.filterRecord[type1][type2]then
return true
end
return self.filterRecord[type1][type2][type3]
end

function UIXianJie_filteEntity2DWin:setFilterRecord(type1,type2,type3,flag)
if not self.filterRecord then
self.filterRecord=xianjieController:getFilterEntity2DRecord()
end
if not self.filterRecord[type1]then
self.filterRecord[type1]={}
end
if not self.filterRecord[type1][type2]then
self.filterRecord[type1][type2]={}
end
self.filterRecord[type1][type2][type3]=flag
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJFilter)
end

function UIXianJie_filteEntity2DWin:refreshCurWin()
self.refreshFlag=true
self:refreshInfoPanel()
local curIdx=self.filter2Index
local curSidx=self.filter3Index
if self.filter2Index then
self:openFilter2(false)
end
if curIdx then
self:onFilterItemClick(curIdx)
end
if curSidx then
self:onFilter2ItemClick(curSidx)
end
end

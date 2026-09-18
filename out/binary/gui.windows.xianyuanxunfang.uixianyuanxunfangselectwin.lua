







def_class("UIXianYuanXunFangSelectWin",UIWindowBase)









function UIXianYuanXunFangSelectWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.haveTgg=UIToggleButton.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.root=UIObject.get(self,5)
self.scrollList=UIEnhancedScrollerLua.get(self,6)
self.selectBtn=UIButton.get(self,7)
self.selectItem_1=UIButton.get(self,8)
self.selectItem_2=UIButton.get(self,9)
self.selectItem_3=UIButton.get(self,10)
self.selectTx=UIText.get(self,11)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.selectItem_1:setButtonClick(function()self:onSelectItem_1()end)

self.selectItem_2:setButtonClick(function()self:onSelectItem_2()end)

self.selectItem_3:setButtonClick(function()self:onSelectItem_3()end)
self.selectItem={
self.selectItem_1,
self.selectItem_2,
self.selectItem_3,
}



end


function UIXianYuanXunFangSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.haveTgg);self.haveTgg=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollList);self.scrollList=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectItem_1);self.selectItem_1=nil;
_UIObject_release(self.selectItem_2);self.selectItem_2=nil;
_UIObject_release(self.selectItem_3);self.selectItem_3=nil;
_UIObject_release(self.selectTx);self.selectTx=nil;
self.selectItem=nil;
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
newflag=9,
lockobj=10,
lockTxt=11,
}
local _selectItemCmp={
root=-1,
empty=0,
have=1,
lihui=2,
job=3,
name=4,
chongGrid=5,
xiaorenBtn=6,
xiaoren=7,
love=8,
select=9,
checkBtn=10,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
local _showArrowCnt=6
local _scrollItemWidth=135
local _scrollViewWidth=784
local _limit=8


function UIXianYuanXunFangSelectWin:onLoaded(...)
_this=self
self:bindComponents()
self._ownedFlag=false
self.leftIndex=1
self.haveTgg:setToggleChange(function(...)self:onHaveToggleChanged(...)end)

self.scrollListScript=UIPrepareEnScroller(self.scrollList:getGameObject(),self.scrollList:getCSharpObject(),nil,nil)
self.scrollListScript.window=self
end


function UIXianYuanXunFangSelectWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianYuanXunFangSelectWin:onHide()

end




function UIXianYuanXunFangSelectWin:onShow(argtable,afterOnloaded)
self.myData=xianyuanxunfangModel:getData()
self.mycfg=xianyuanxunfangModel:getCfg2()

self:initLeftList()
self:updateLeftData()
self:refreshLeftList()
self:refreshRightList()
self:refreshSelectBtn()
end

function UIXianYuanXunFangSelectWin:onBackground()

end

function UIXianYuanXunFangSelectWin:onCloseBtn()
self:closeSelf()
end

function UIXianYuanXunFangSelectWin:onSelectBtn()
local change=false
for i,v in ipairs(self.leftList)do
if v==0 then
UIManager.info(FMT.fmt("需要选择{0}名弟子加入仙缘寻访",self.mycfg.select_num))
return
elseif i==1 and self.oldLookup[v]~=true then
change=true
elseif i~=1 and self.oldLookup[v]~=false then
change=true
end
end
if change then
xianyuanxunfangController:reqSelectDZ(self.leftList)
end
end

function UIXianYuanXunFangSelectWin:onLeftBtn()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end
local leftIdx=math.floor(self.scrollContainer.anchoredPosition.x/_scrollItemWidth+0.5)
local jumpIdx=math.max(-leftIdx-1,0)
self.scrollListScript:jumpToDataIndex(jumpIdx,0,0,true,1,0.2,nil)
end

function UIXianYuanXunFangSelectWin:onRightBtn()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end

local leftIdx=math.ceil(self.scrollContainer.anchoredPosition.x/_scrollItemWidth-0.5)
local jumpIdx=math.min(-leftIdx+1,#self.rightData-1)
self.scrollListScript:jumpToDataIndex(jumpIdx,0,0,true,1,0.2,nil)
end

function UIXianYuanXunFangSelectWin:onHaveToggleChanged(name,isToggle,data)
self._ownedFlag=isToggle
self:refreshRightList()
end

function UIXianYuanXunFangSelectWin:refreshRightList()
self.rightData={}
local checkToggle=false
local tmCfg=cfg_discipletianminglevelconfig()
local tmMax=#tmCfg
local openDay=timeHelper.getServerOpenDay()
for i,v in ipairs(self.mycfg.disciple)do
local itemID=v[1]
local openDay_=v[3]
local lerpDay=openDay_-openDay
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
if self._ownedFlag and owned then

else
local weights={}
local find=table.findValue(self.mycfg.defaultdz,i)
weights[1]=find or(#self.mycfg.defaultdz+1)
weights[5]=i
local tmLv=nil
if owned then
tmLv=UIDiscipleModel:getTianMingLevelEx(finds[1])
weights[2]=1
weights[3]=tmLv>=tmMax and 1 or 0
weights[4]=tmMax-tmLv
else
weights[2]=0
weights[3]=0
weights[4]=0
end
local data={index=i,finds=finds,disciple=dzData,tmLv=tmLv,sortWeight=weights,itemID=itemID,lerpDay=lerpDay}
table.insert(self.rightData,data)

if not checkToggle and not owned then
checkToggle=true
end
end
end
table.sort(self.rightData,self.sortListData)
local listCnt=#self.rightData
self.leftBtn:setActive(false)
self.rightBtn:setActive(listCnt>_showArrowCnt)
self.scrollListScript:initData(self.rightData,135,listCnt)
self.scrollListScript:jumpToDataIndex(0,0,0,true,0,0,nil)
self.haveTgg:setActive(checkToggle)
end

function UIXianYuanXunFangSelectWin.sortListData(a,b)
for i=1,5 do
local weightA=a.sortWeight[i]
local weightB=b.sortWeight[i]
if weightA~=weightB then
return weightA<weightB
end
end
return false
end

function UIXianYuanXunFangSelectWin:refreshRightListItem(index,item)
local data=self.rightData[index]
local dzData=data.disciple
local imageInfo=dzData.imageInfo
local color=imageInfo.color
local jobid=imageInfo.job
local isSelect=self.leftList[self.leftIndex]==data.index
local isOwned=#data.finds>0
local isRecommond=table.containsValue(self.mycfg.defaultdz,data.index)
local findLeft=table.findValue(self.leftList,data.index)
local isChoosed=findLeft~=nil and findLeft~=self.leftIndex
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

local isNew=xianyuanxunfangModel:checkDZNew(data.itemID)
item:SetChildActive(_listItemCmp.newflag,isNew)

local isLock=data.lerpDay>0
item:SetChildActive(_listItemCmp.lockobj,isLock)
if isLock then
local lockstr=FMT.fmt('{0}天后加入',data.lerpDay)
item:SetChildText(_listItemCmp.lockTxt,lockstr)
end



end

function UIXianYuanXunFangSelectWin:onClickRightItem(index)
local data=self.rightData[index]
if data.lerpDay>0 then
local lockstr=FMT.fmt('该弟子{0}天后加入寻访',data.lerpDay)
UIManager.error(lockstr)
return
end
if xianyuanxunfangModel:checkDZNew(data.itemID)then
xianyuanxunfangModel:clearDZNew(data.itemID)
end
local other=nil
if self.leftList[self.leftIndex]==data.index then
self.leftList[self.leftIndex]=0
else
other=table.findValue(self.leftList,data.index)
if other then
self.leftList[other]=0
end
self.leftList[self.leftIndex]=data.index
end

self:refreshLeftItem(self.leftIndex)
if other then
self:refreshLeftItem(other)
end
self:refreshRightSelectAndChoosed()
self:refreshSelectBtn()
end

function UIXianYuanXunFangSelectWin:refreshRightSelectAndChoosed()
local startIdx=self.scrollListScript:getStartCellViewIndex()
local endIdx=self.scrollListScript:getEndCellViewIndex()
for itemIdx=startIdx,endIdx do
local item=self.scrollListScript:GetCell(itemIdx)
if item then
local data=self.rightData[itemIdx+1]
local isSelect=self.leftList[self.leftIndex]==data.index
local findLeft=table.findValue(self.leftList,data.index)
local isChoosed=findLeft~=nil and findLeft~=self.leftIndex
item:SetChildActive(_listItemCmp.select,isSelect)
item:SetChildActive(_listItemCmp.choosed,isChoosed)
end
end
end

function UIXianYuanXunFangSelectWin:onClickLeftItem(i)
if i~=self.leftIndex then
if self.leftIndex then
local item=self.selectItem[self.leftIndex]:getChildWidgetBase()
item:SetChildActive(_selectItemCmp.select,false)
end

self.leftIndex=i

local item=self.selectItem[self.leftIndex]:getChildWidgetBase()
item:SetChildActive(_selectItemCmp.select,true)

self:refreshRightSelectAndChoosed()
end
end

function UIXianYuanXunFangSelectWin:onClickLeftCancel(i)
local index=self.leftList[i]
if index>0 then
self.leftList[i]=0
self:refreshLeftItem(i)
end
end

function UIXianYuanXunFangSelectWin:onClickLeftDetail(i)
local index=self.leftList[i]
if index>0 then
local v=self.mycfg.disciple[index]
local itemID=v[1]
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end
end

function UIXianYuanXunFangSelectWin:updateLeftData()
self.oldLookup={}
self.leftList={}
for i=1,self.mycfg.select_num do
local idx=self.myData.items[i]or 0
if i==self.myData.itemid then
table.insert(self.leftList,1,idx)
self.oldLookup[idx]=true
else
table.insert(self.leftList,idx)
self.oldLookup[idx]=false
end
end
end

function UIXianYuanXunFangSelectWin:initLeftList()
for i,v in ipairs(self.selectItem)do
local show=self.mycfg.select_num>=i
v:setActive(show)
if show then
local item=v:getChildWidgetBase()
item:SetChildButtonClick(_selectItemCmp.root,function()
self:onClickLeftItem(i)
end)
item:SetChildButtonClick(_selectItemCmp.xiaorenBtn,function()
self:onClickLeftDetail(i)
end)
item:SetChildButtonClick(_selectItemCmp.checkBtn,function()
self:onClickLeftDetail(i)
end)
item:SetChildActive(_selectItemCmp.love,i==1)
end
end
end

function UIXianYuanXunFangSelectWin:refreshLeftList()
for i=1,math.min(#self.selectItem,self.mycfg.select_num)do
local item=self.selectItem[i]:getChildWidgetBase()
self:refreshLeftItem(i,item)
end
end

function UIXianYuanXunFangSelectWin:refreshLeftItem(i,item)
item=item or self.selectItem[i]:getChildWidgetBase()
local index=self.leftList[i]
item:SetChildActive(_selectItemCmp.have,index>0)
item:SetChildActive(_selectItemCmp.empty,index==0)
item:SetChildActive(_selectItemCmp.select,self.leftIndex==i)
if index>0 then
local v=self.mycfg.disciple[index]
local itemID=v[1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo
local dzID=dzData.id
local jobid=info.job
local findInfos=UIDiscipleModel:findDisciplesByID(dzID)
local finds={}
for i,v in ipairs(findInfos)do
finds[#finds+1]=UIDiscipleModel:getDiscipleDataByStr(v.discipleguidStr)
end

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
modelParams.scale=0.025
modelParams.offset={0,1}
comHelper.setChildModelRawImageEx(_selectItemCmp.lihui,item,modelParams,eHeadCenterType.eNone,1,false)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(_selectItemCmp.xiaoren,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)

item:SetChildCSImageSprite(_selectItemCmp.job,globalABLookup.global,UIDiscipleModel:getJobIconName(jobid))
item:SetChildText(_selectItemCmp.name,dzData.disciplename)

local tmlv=#finds>0 and UIDiscipleModel:getTianMingLevelEx(finds[1])or-1
item:SetChildActive(_selectItemCmp.chongGrid,tmlv>0)
if tmlv>0 then
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=item:GetChildCommonLayoutGroupWidgetList(_selectItemCmp.chongGrid)
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
end
end

function UIXianYuanXunFangSelectWin:initScrollContainer()
local tf=self.scrollList:getCommonComponent("RectTransform")
if tf.childCount>0 then
self.scrollContainer=tf:GetChild(0)
self.leftBorder=-_scrollItemWidth/_limit
self.rightBorder=-_scrollItemWidth*(#self.rightData-1/_limit)+_scrollViewWidth
return true
end
return false
end

function UIXianYuanXunFangSelectWin:refreshScrollButton()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end

self.leftBtn:setActive(self.scrollContainer.anchoredPosition.x<self.leftBorder)
self.rightBtn:setActive(self.scrollContainer.anchoredPosition.x>self.rightBorder)
end

function UIXianYuanXunFangSelectWin:onScrollRectValueChange()
self:refreshScrollButton()
end

function UIXianYuanXunFangSelectWin:refreshSelectBtn()
for i,v in ipairs(self.leftList)do
if v==0 then
self.selectBtn:setChildGraphicGray(true,false,false)
return
end
end
self.selectBtn:setChildGraphicGray(false,false,false)
end

function UIXianYuanXunFangSelectWin:rec_selectUp()
self:updateLeftData()
self:refreshLeftList()
self:refreshRightSelectAndChoosed()
end

function UIXianYuanXunFangSelectWin:rec_selectDZ()
self:onCloseBtn()
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
self.window:refreshRightListItem(dataIndex,cell)
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell)
self.window:onClickRightItem(dataIndex+1)
end

function UIXianYuanXunFangSelectWin:onSelectItem_1()
end

function UIXianYuanXunFangSelectWin:onSelectItem_2()
end

function UIXianYuanXunFangSelectWin:onSelectItem_3()
end
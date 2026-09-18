







def_class("UISubAct_xianjieqiyuan_SelectLoveDialog2",UIWindowBase)









function UISubAct_xianjieqiyuan_SelectLoveDialog2:bindComponents()

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


function UISubAct_xianjieqiyuan_SelectLoveDialog2:unbindComponents()
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
chongGrid=9,
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



function UISubAct_xianjieqiyuan_SelectLoveDialog2:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(247,36,self.on_247_36)
self:addProNotify(247,37,self.on_247_37)
self:addProNotify(247,41,self.on_247_41)

self._ownedFlag=false
self.leftIndex=1
self.haveTgg:setToggleChange(function(...)self:onHaveToggleChanged(...)end)

self.scrollListScript=UIPrepareEnScroller(self.scrollList:getGameObject(),self.scrollList:getCSharpObject(),nil,nil)
self.scrollListScript.window=self
end


function UISubAct_xianjieqiyuan_SelectLoveDialog2:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_xianjieqiyuan_SelectLoveDialog2:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self:initLeftList()
if self.info then
self.data=self.info:getData()
if self.data then
self:updateLeftData()
self:refreshLeftList()
self:refreshRightList()
self:refreshSelectBtn()
return
end
end
self:onCloseBtn()
end


function UISubAct_xianjieqiyuan_SelectLoveDialog2:onHide()

end




function UISubAct_xianjieqiyuan_SelectLoveDialog2:onBackground()

end


function UISubAct_xianjieqiyuan_SelectLoveDialog2:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UISubAct_xianjieqiyuan_SelectLoveDialog2:onSelectBtn()
local change=false
for i,v in ipairs(self.leftList)do
if v==0 then
UIManager.info(FMT.fmt("需要选择{0}名弟子加入仙界奇缘",self.config.select_num))
return
elseif i==1 and self.oldLookup[v]~=true then
change=true
elseif i~=1 and self.oldLookup[v]~=false then
change=true
end
end
if change then
local json_str=jsonHelper.encode({4,self.leftList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,json_str)
end

self:onCloseBtn()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onLeftBtn()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end
local leftIdx=math.floor(self.scrollContainer.anchoredPosition.x/_scrollItemWidth+0.5)
local jumpIdx=math.max(-leftIdx-1,0)
self.scrollListScript:jumpToDataIndex(jumpIdx,0,0,true,1,0.2,nil)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onRightBtn()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end

local leftIdx=math.ceil(self.scrollContainer.anchoredPosition.x/_scrollItemWidth-0.5)
local jumpIdx=math.min(-leftIdx+1,#self.rightData-1)
self.scrollListScript:jumpToDataIndex(jumpIdx,0,0,true,1,0.2,nil)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onHaveToggleChanged(name,isToggle,data)
self._ownedFlag=isToggle
self:refreshRightList()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshRightList()
self.rightData={}
local checkToggle=false
local tmCfg=cfg_discipletianminglevelconfig()
local tmMax=#tmCfg
local defaultCnt=#self.config.defaultdz
for i,v in ipairs(self.config.disciple)do
local itemID=v
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local dzID=dzData.id
local isjihuo=liandonModel:CheckDiZiActive_Guanlian(dzID)
if isjihuo then
dzID=isjihuo.id
end
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
local find=table.findValue(self.config.defaultdz,i)

local tmLv=owned and UIDiscipleModel:getTianMingLevelEx(finds[1])or-1
weights[1]=find and 0 or 1
weights[2]=tmLv
weights[3]=dzID
local data={index=i,finds=finds,disciple=dzData,tmLv=tmLv,sortWeight=weights,itemID=itemID}
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

function UISubAct_xianjieqiyuan_SelectLoveDialog2.sortListData(a,b)
for i=1,3 do
local weightA=a.sortWeight[i]
local weightB=b.sortWeight[i]
if weightA~=weightB then
return weightA<weightB
end
end
return false
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshRightListItem(index,item)
local data=self.rightData[index]
local dzData=data.disciple
local imageInfo=dzData.imageInfo
local color=imageInfo.color
local jobid=imageInfo.job
local isSelect=self.leftList[self.leftIndex]==data.index
local isRecommond=table.containsValue(self.config.defaultdz,data.index)
local findLeft=table.findValue(self.leftList,data.index)
local isChoosed=findLeft~=nil
local iconname=cfgHelper.get3(cfg_discipletianmingfloorconfig_get,0,'colorframe',color)
item:SetChildCSImageSprite(_listItemCmp.back,globalABLookup.diciplecolorframe,iconname)
item:SetChildActive(_listItemCmp.select,isSelect)
item:SetChildText(_listItemCmp.name,dzData.disciplename)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelRawImageEx(_listItemCmp.rawImage,item,modelParams,eHeadCenterType.eHead,nil,false)
item:SetChildCSImageSprite(_listItemCmp.job,globalABLookup.global,UIDiscipleModel:getJobIconName(jobid))
if#data.finds<=0 then
item:SetChildText(_listItemCmp.desc,"未拥有")
item:SetChildActive(_listItemCmp.chongGrid,false)
else
item:SetChildText(_listItemCmp.desc,"")
item:SetChildActive(_listItemCmp.chongGrid,true)
local tmLv=UIDiscipleModel:getTianMingLevelEx(data.finds[1])

local chong=UIDiscipleModel.getTianMingLevelChong(tmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=item:GetChildCommonLayoutGroupWidgetList(_listItemCmp.chongGrid)
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
local abname,icon=UIDiscipleModel:getJobOrientationIcon(imageInfo.job,dzData.id)
item:SetChildCSImageSprite(_listItemCmp.orientation,abname,icon)
item:SetChildActive(_listItemCmp.tuijian,isRecommond)
item:SetChildActive(_listItemCmp.choosed,isChoosed)



end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onClickRightItem(index)
local data=self.rightData[index]
local leftIdx=table.findValue(self.leftList,data.index)
if leftIdx then
self.leftList[leftIdx]=0
self:refreshLeftItem(leftIdx)
else
self.leftList[self.leftIndex]=data.index
self:refreshLeftItem(self.leftIndex)
end
self:refreshRightSelectAndChoosed()
self:refreshSelectBtn()

if leftIdx==nil then
for i,v in ipairs(self.selectItem)do
if self.leftList[i]==0 then
self:onClickLeftItem(i)
return
end
end
end





























end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshRightSelectAndChoosed()
local startIdx=self.scrollListScript:getStartCellViewIndex()
local endIdx=self.scrollListScript:getEndCellViewIndex()
for itemIdx=startIdx,endIdx do
local item=self.scrollListScript:GetCell(itemIdx)
if item then
local data=self.rightData[itemIdx+1]
local isSelect=self.leftList[self.leftIndex]==data.index
local findLeft=table.findValue(self.leftList,data.index)
local isChoosed=findLeft~=nil
item:SetChildActive(_listItemCmp.select,isSelect)
item:SetChildActive(_listItemCmp.choosed,isChoosed)
end
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onClickLeftItem(i)
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

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onClickLeftCancel(i)
local index=self.leftList[i]
if index>0 then
self.leftList[i]=0
self:refreshLeftItem(i)
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onClickLeftDetail(i)
local index=self.leftList[i]
if index>0 then
local itemID=self.config.disciple[index]
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:updateLeftData()
self.oldLookup={}
self.leftList={}
for i=1,self.config.select_num do
local v=self.data.items[i]or 0
if i==self.data.itemid then
table.insert(self.leftList,1,v)
self.oldLookup[v]=true
else
table.insert(self.leftList,v)
self.oldLookup[v]=false
end
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:initLeftList()
for i,v in ipairs(self.selectItem)do
local show=self.config.select_num>=i
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

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshLeftList()
for i=1,math.min(#self.selectItem,self.config.select_num)do
local item=self.selectItem[i]:getChildWidgetBase()
self:refreshLeftItem(i,item)
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshLeftItem(i,item)
item=item or self.selectItem[i]:getChildWidgetBase()
local index=self.leftList[i]
item:SetChildActive(_selectItemCmp.have,index>0)
item:SetChildActive(_selectItemCmp.empty,index==0)
item:SetChildActive(_selectItemCmp.select,self.leftIndex==i)
if index>0 then
local itemID=self.config.disciple[index]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo
local dzID=dzData.id
local isjihuo=liandonModel:CheckDiZiActive_Guanlian(dzID)
if isjihuo then
dzID=isjihuo.id
end
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

function UISubAct_xianjieqiyuan_SelectLoveDialog2:initScrollContainer()
local tf=self.scrollList:getCommonComponent("RectTransform")
if tf.childCount>0 then
self.scrollContainer=tf:GetChild(0)
self.leftBorder=-_scrollItemWidth/_limit
self.rightBorder=-_scrollItemWidth*(#self.rightData-1/_limit)+_scrollViewWidth
return true
end
return false
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshScrollButton()
if self.scrollContainer==nil then
if not self:initScrollContainer()then
return
end
end

self.leftBtn:setActive(self.scrollContainer.anchoredPosition.x<self.leftBorder)
self.rightBtn:setActive(self.scrollContainer.anchoredPosition.x>self.rightBorder)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:onScrollRectValueChange()
self:refreshScrollButton()
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2:refreshSelectBtn()
for i,v in ipairs(self.leftList)do
if v==0 then
self.selectBtn:setChildGraphicGray(true,false,false)
return
end
end
self.selectBtn:setChildGraphicGray(false,false,false)
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2.on_247_36(args)
local actId=args[1]
local subId=args[2]
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this.data=_this.info:getData()
if _this.data then
_this:updateLeftData()
_this:refreshLeftList()
_this:refreshRightSelectAndChoosed()
else
_this:onCloseBtn()
end
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2.on_247_37(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this:updateLeftData()
_this:refreshLeftList()
_this:refreshRightSelectAndChoosed()
end
end

function UISubAct_xianjieqiyuan_SelectLoveDialog2.on_247_41(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this:onCloseBtn()
end
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
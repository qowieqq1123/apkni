







def_class("UIWorldXiuZhenJiaZuManagerWin",UIWindowBase)









function UIWorldXiuZhenJiaZuManagerWin:bindComponents()

self.back=UIObject.get(self,0)
self.dragObject=UIObject.get(self,1)
self.jiazuScroller=UIScrollView.get(self,2)
self.fightSortBtn=UIButton.get(self,3)
self.jingjieSortBtn=UIButton.get(self,4)
self.liantiSortBtn=UIButton.get(self,5)
self.dzScrollview=UIObject.get(self,6)
self.selectFightImg=UIObject.get(self,7)
self.selectJingJieImg=UIObject.get(self,8)
self.selectLianTiImg=UIObject.get(self,9)
self.jobName_3=UIText.get(self,10)
self.dzName_3=UIText.get(self,11)
self.dzName_4=UIText.get(self,12)
self.jobName_4=UIText.get(self,13)
self.dzName_5=UIText.get(self,14)
self.jobName_5=UIText.get(self,15)
self.dzName_2=UIText.get(self,16)
self.jobName_2=UIText.get(self,17)
self.name=UIText.get(self,18)
self.select=UIObject.get(self,19)
self.dzName_1=UIText.get(self,20)
self.jobName_1=UIText.get(self,21)
self.dzNameImg_1=UIObject.get(self,22)
self.dzModel_1=UIObject.get(self,23)
self.lRole_1=UIImage.get(self,24)
self.lRole_2=UIImage.get(self,25)
self.dzNameImg_2=UIObject.get(self,26)
self.dzModel_2=UIObject.get(self,27)
self.dzModel_3=UIObject.get(self,28)
self.lRole_3=UIImage.get(self,29)
self.dzNameImg_3=UIObject.get(self,30)
self.lRole_4=UIImage.get(self,31)
self.dzModel_4=UIObject.get(self,32)
self.dzNameImg_4=UIObject.get(self,33)
self.lRole_5=UIImage.get(self,34)
self.dzModel_5=UIObject.get(self,35)
self.dzNameImg_5=UIObject.get(self,36)
self.topBorder=UIObject.get(self,37)
self.bottomBorder=UIObject.get(self,38)
self.rightBorder=UIObject.get(self,39)
self.leftBorder=UIObject.get(self,40)
self.top_5=UIObject.get(self,41)
self.top_2=UIObject.get(self,42)
self.top_1=UIObject.get(self,43)
self.bottom_5=UIObject.get(self,44)
self.bottom_4=UIObject.get(self,45)
self.bottom_3=UIObject.get(self,46)
self.bottom_2=UIObject.get(self,47)
self.bottom_1=UIObject.get(self,48)
self.secondLeft=UIObject.get(self,49)
self.firstLeft=UIObject.get(self,50)
self.secondRight=UIObject.get(self,51)
self.firstRight=UIObject.get(self,52)
self.top_3=UIObject.get(self,53)
self.top_4=UIObject.get(self,54)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.jingjieSortBtn:setButtonClick(function()self:onJingjieSortBtn()end)

self.liantiSortBtn:setButtonClick(function()self:onLiantiSortBtn()end)
self.jobName={
self.jobName_1,
self.jobName_2,
self.jobName_3,
self.jobName_4,
self.jobName_5,
}
self.dzName={
self.dzName_1,
self.dzName_2,
self.dzName_3,
self.dzName_4,
self.dzName_5,
}
self.dzNameImg={
self.dzNameImg_1,
self.dzNameImg_2,
self.dzNameImg_3,
self.dzNameImg_4,
self.dzNameImg_5,
}
self.dzModel={
self.dzModel_1,
self.dzModel_2,
self.dzModel_3,
self.dzModel_4,
self.dzModel_5,
}
self.lRole={
self.lRole_1,
self.lRole_2,
self.lRole_3,
self.lRole_4,
self.lRole_5,
}
self.top={
self.top_1,
self.top_2,
self.top_3,
self.top_4,
self.top_5,
}
self.bottom={
self.bottom_1,
self.bottom_2,
self.bottom_3,
self.bottom_4,
self.bottom_5,
}



end


function UIWorldXiuZhenJiaZuManagerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.jiazuScroller);self.jiazuScroller=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.jingjieSortBtn);self.jingjieSortBtn=nil;
_UIObject_release(self.liantiSortBtn);self.liantiSortBtn=nil;
_UIObject_release(self.dzScrollview);self.dzScrollview=nil;
_UIObject_release(self.selectFightImg);self.selectFightImg=nil;
_UIObject_release(self.selectJingJieImg);self.selectJingJieImg=nil;
_UIObject_release(self.selectLianTiImg);self.selectLianTiImg=nil;
_UIObject_release(self.jobName_3);self.jobName_3=nil;
_UIObject_release(self.dzName_3);self.dzName_3=nil;
_UIObject_release(self.dzName_4);self.dzName_4=nil;
_UIObject_release(self.jobName_4);self.jobName_4=nil;
_UIObject_release(self.dzName_5);self.dzName_5=nil;
_UIObject_release(self.jobName_5);self.jobName_5=nil;
_UIObject_release(self.dzName_2);self.dzName_2=nil;
_UIObject_release(self.jobName_2);self.jobName_2=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.dzName_1);self.dzName_1=nil;
_UIObject_release(self.jobName_1);self.jobName_1=nil;
_UIObject_release(self.dzNameImg_1);self.dzNameImg_1=nil;
_UIObject_release(self.dzModel_1);self.dzModel_1=nil;
_UIObject_release(self.lRole_1);self.lRole_1=nil;
_UIObject_release(self.lRole_2);self.lRole_2=nil;
_UIObject_release(self.dzNameImg_2);self.dzNameImg_2=nil;
_UIObject_release(self.dzModel_2);self.dzModel_2=nil;
_UIObject_release(self.dzModel_3);self.dzModel_3=nil;
_UIObject_release(self.lRole_3);self.lRole_3=nil;
_UIObject_release(self.dzNameImg_3);self.dzNameImg_3=nil;
_UIObject_release(self.lRole_4);self.lRole_4=nil;
_UIObject_release(self.dzModel_4);self.dzModel_4=nil;
_UIObject_release(self.dzNameImg_4);self.dzNameImg_4=nil;
_UIObject_release(self.lRole_5);self.lRole_5=nil;
_UIObject_release(self.dzModel_5);self.dzModel_5=nil;
_UIObject_release(self.dzNameImg_5);self.dzNameImg_5=nil;
_UIObject_release(self.topBorder);self.topBorder=nil;
_UIObject_release(self.bottomBorder);self.bottomBorder=nil;
_UIObject_release(self.rightBorder);self.rightBorder=nil;
_UIObject_release(self.leftBorder);self.leftBorder=nil;
_UIObject_release(self.top_5);self.top_5=nil;
_UIObject_release(self.top_2);self.top_2=nil;
_UIObject_release(self.top_1);self.top_1=nil;
_UIObject_release(self.bottom_5);self.bottom_5=nil;
_UIObject_release(self.bottom_4);self.bottom_4=nil;
_UIObject_release(self.bottom_3);self.bottom_3=nil;
_UIObject_release(self.bottom_2);self.bottom_2=nil;
_UIObject_release(self.bottom_1);self.bottom_1=nil;
_UIObject_release(self.secondLeft);self.secondLeft=nil;
_UIObject_release(self.firstLeft);self.firstLeft=nil;
_UIObject_release(self.secondRight);self.secondRight=nil;
_UIObject_release(self.firstRight);self.firstRight=nil;
_UIObject_release(self.top_3);self.top_3=nil;
_UIObject_release(self.top_4);self.top_4=nil;
self.jobName=nil;
self.dzName=nil;
self.dzNameImg=nil;
self.dzModel=nil;
self.lRole=nil;
self.top=nil;
self.bottom=nil;
end

















local imageabname='ui/windows/fight/sharedtextures/fight_prepare.ab'


function UIWorldXiuZhenJiaZuManagerWin:onLoaded(...)
self:bindComponents()
local _onClickJiaZuCallBack=function(...)
self:onClickJiaZuCallBack(...)
end
self.jiazuScroller:setClickAction(_onClickJiaZuCallBack)

local _onClickRoleItemCallback=function(...)
self:onClickRoleItemCallback(...)
end
local _onLongClickRoleCallback=function(...)
self:onLongClickRoleCallback(...)
end
self.dzScrollview:setChildScrollViewInit(-1,true,_onClickRoleItemCallback,_onLongClickRoleCallback)

local _beginDragCallback=function(...)
self:beginDragCallback(...)
end
local _dragCallback=function(...)
self:dragCallback(...)
end
local _endDragCallback=function(...)
self:endDragCallback(...)
end
for i,v in ipairs(self.dzModel)do
self.winlua:InitDragItem(v:getID(),i,_beginDragCallback,_dragCallback,_endDragCallback)
end

self.sortType=eDiscipleSortType.eFightSort
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.selectJiaZuIndex=1

self.allFamilyData=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
self.dzGuidList={}
end


function UIWorldXiuZhenJiaZuManagerWin:__delete()
self:reqChangeDzList()
self:unbindComponents()
end




function UIWorldXiuZhenJiaZuManagerWin:onShow(argtable,afterOnloaded)
self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)

self:initGuidList()
self:refreshJiaZuList()
self:refreshDzModels()
self:refreshBtnsState()
self:refreshDzPanel()
end


function UIWorldXiuZhenJiaZuManagerWin:onHide()

end

function UIWorldXiuZhenJiaZuManagerWin:initGuidList()
for i,v in ipairs(self.allFamilyData)do
self.dzGuidList[i]={}
local dzList=v.dzList
if dzList then
for j,dzData in ipairs(dzList)do
if UIDiscipleModel:getDiscipleData(dzData.unitId)then
self.dzGuidList[i][j]=dzData.unitId
else
self.dzGuidList[i][j]=int64.zero
end
end
end
end
end

function UIWorldXiuZhenJiaZuManagerWin:refreshJiaZuList()
self.jiazuScroller:freshGridsNum(#self.allFamilyData,#self.allFamilyData,1,true)

for i=1,#self.allFamilyData do
local item=self.jiazuScroller:getGridObjectByindex(i-1)
if item then
local data=self.allFamilyData[i]
local guid=data.guid
item:SetChildActive(0,true)

item:SetChildActive(1,i==self.selectJiaZuIndex)

local name=worldXiuZhenJiaZuModel:getFamilyName(guid,true)
name=string.gsub(name,'）','）\n')
item:SetChildText(2,name)
end
end
self.jiazuScroller:jumpToLockX(self.selectJiaZuIndex)
end

function UIWorldXiuZhenJiaZuManagerWin:onClickJiaZuCallBack(id,index,guid,attach)
if self.selectJiaZuIndex==index then return end
self:clearDzModels()
self.selectJiaZuIndex=index

for i=1,#self.allFamilyData do
local item=self.jiazuScroller:getGridObjectByindex(i-1)
if item then
local data=self.allFamilyData[i]
item:SetChildActive(1,i==self.selectJiaZuIndex)
end
end
self:refreshDzModels()
self:refreshDzPanel()
end

function UIWorldXiuZhenJiaZuManagerWin:refreshDzModels()
local familyGuidList=self.dzGuidList[self.selectJiaZuIndex]
if#familyGuidList>0 then
for i,dzId in ipairs(familyGuidList)do
local haveDz=tostring(dzId)~='0'
self.dzNameImg[i]:setActive(haveDz)
if haveDz then
comHelper.setChildHead2(self.dzModel[i],dzId,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dzModel[i]:getID(),true)
self.dzName[i]:setText(UIDiscipleModel:getDiscipleName(dzId))
self.jobName[i]:setText(UIDiscipleModel:getJobNameX(dzId))
self.lRole[i]:setSprite(globalABLookup.global,'image_zdjuesezhanwei_2')
else
self.lRole[i]:setSprite(imageabname,'image_zdjuesezhanwei_1')
end
end
else
for i=1,5 do
self.dzNameImg[i]:setActive(false)
self.lRole[i]:setSprite(imageabname,'image_zdjuesezhanwei_1')
end
end
end

function UIWorldXiuZhenJiaZuManagerWin:clearDzModels()
local familyGuidList=self.dzGuidList[self.selectJiaZuIndex]
for i,dzId in ipairs(familyGuidList)do
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[i]:getID())
self.dzNameImg[i]:setActive(false)
self.lRole[i]:setSprite(imageabname,'image_zdjuesezhanwei_1')
end
end

function UIWorldXiuZhenJiaZuManagerWin:refreshDzPanel()
self.disciplesList=discipleLookup:getSortDiscipleList(self.sortType,self.sortCondition,self.sortOrder)
local dataNum=#self.disciplesList
self.dzScrollview:setChildScrollViewCreateGrids(dataNum,2)

local grids=self.dzScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local netdata=self.disciplesList[i].netData
local guid=netdata.net.discipleguid
local widget=grids[i-1]
if widget then

local color=UIDiscipleModel:getDiscipleColor(guid)
widget:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
widget:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
widget:SetChildActive(9,isSpDz)

widget:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

local scale=0.65
comHelper.setChildModelRawImage(widget,guid,3,0,eHeadCenterType.eHalf)

local descStr=''
if self.sortType==eDiscipleSortType.eJingJieSort then
local jjlv=netdata.net.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
if p~=nil then
descStr=FMT.fmt('{0}{1}阶',n,p)
else
descStr=n
end
elseif self.sortType==eDiscipleSortType.eLianTiSort then
local ltlv=netdata.net.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
if p1~=nil then
descStr=FMT.fmt('{0}{1}层',n1,p1)
else
descStr=n1
end
else
descStr=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid))
end
widget:SetChildText(4,descStr)

local inCurFamily=self:checkDzInCurFamily(guid)
local inOtherFamily=self:checkDzIsInOtherFamily(guid)
local stateStr=''
if inCurFamily then
stateStr='已成为客卿'
elseif inOtherFamily then
stateStr='其他家族的客卿'
end
widget:SetChildText(5,stateStr)
widget:SetChildActive(8,inCurFamily or inOtherFamily)

local selected=self:checkIsSelectedGuid(guid)
widget:SetChildActive(6,selected)
end
end
end

function UIWorldXiuZhenJiaZuManagerWin:onClickRoleItemCallback(clickCount,index)

local discipleData=self.disciplesList[index+1]
local netdata=discipleData.netData
local guid=netdata.net.discipleguid
local selected=self:checkIsSelectedGuid(guid)
local dzGuidList=self.dzGuidList[self.selectJiaZuIndex]
local havePos=false
local pos=1
if#dzGuidList>0 then
for i,v in ipairs(dzGuidList)do
if tostring(v)=='0'then
havePos=true
pos=i
break
end
end
if not selected and not havePos then
UIManager.info('该家族客卿已满')
return
end
end

local widget=self.dzScrollview:getChildScrollViewItemWidget(index)
local stateStr=selected and''or'已成为客卿'
widget:SetChildText(5,stateStr)
widget:SetChildActive(6,not selected)
widget:SetChildActive(8,not selected)

if selected then
local posIndex
for i,v in ipairs(dzGuidList)do
if mathHelper.compareInt64(guid,v)then
posIndex=i
break
end
end
if posIndex then
self.dzNameImg[posIndex]:setActive(false)
self.lRole[posIndex]:setSprite(imageabname,'image_zdjuesezhanwei_1')
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[posIndex]:getID())
dzGuidList[posIndex]=int64.zero
else
logErr('该弟子已上阵，没有找到信息')
end
else
dzGuidList[pos]=guid
self.dzNameImg[pos]:setActive(true)
self.lRole[pos]:setSprite(globalABLookup.global,'image_zdjuesezhanwei_2')
comHelper.setChildHead2(self.dzModel[pos],guid,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dzModel[pos]:getID(),true)
self.dzName[pos]:setText(UIDiscipleModel:getDiscipleName(guid))
self.jobName[pos]:setText(UIDiscipleModel:getJobNameX(guid))

local isInOther,jiazuIndex,posIndex=self:checkDzIsInOtherFamily(guid)
if isInOther then
local changeDzList=self.dzGuidList[jiazuIndex]
changeDzList[posIndex]=int64.zero
end
end
end

function UIWorldXiuZhenJiaZuManagerWin:checkDzIsInOtherFamily(guid)
for i,dzList in ipairs(self.dzGuidList)do
if i~=self.selectJiaZuIndex then
for j,dzId in ipairs(dzList)do
if mathHelper.compareInt64(dzId,guid)then
return true,i,j
end
end
end
end
return false
end

function UIWorldXiuZhenJiaZuManagerWin:checkDzInCurFamily(guid)
local dzList=self.dzGuidList[self.selectJiaZuIndex]
for i,dzId in ipairs(dzList)do
if mathHelper.compareInt64(dzId,guid)then
return true
end
end
return false
end

function UIWorldXiuZhenJiaZuManagerWin:checkIsSelectedGuid(guid)
local dzGuidList=self.dzGuidList[self.selectJiaZuIndex]
for i,v in ipairs(dzGuidList)do
if mathHelper.compareInt64(v,guid)then
return true
end
end
return false
end

function UIWorldXiuZhenJiaZuManagerWin:getJiaZuListIndex(guid)
for i,v in ipairs(self.allFamilyData)do
if mathHelper.compareInt64(v.guid,guid)then
return i
end
end
end

function UIWorldXiuZhenJiaZuManagerWin:checkDragIndexHaveDZ(index)
local familyGuidList=self.dzGuidList[self.selectJiaZuIndex]
local dzId=familyGuidList[index]
if tostring(dzId)~='0'then
return true,dzId
end
return false
end

function UIWorldXiuZhenJiaZuManagerWin:getIndexByPos(x,y)
for i,v in ipairs(self.dzModel)do
local left
local right
local bottom=self.bottom[i]:getChildUIScreenPos().y
local top=self.top[i]:getChildUIScreenPos().y
if i==1 or i==2 then
left=self.firstLeft:getChildUIScreenPos().x
right=self.firstRight:getChildUIScreenPos().x
else
left=self.secondLeft:getChildUIScreenPos().x
right=self.secondRight:getChildUIScreenPos().x
end
if x>=left and x<=right and y>=bottom and y<=top then
return i
end
end
return-1
end

function UIWorldXiuZhenJiaZuManagerWin:checkOverBorder(x,y)
local left=self.leftBorder:getChildUIScreenPos().x
local right=self.rightBorder:getChildUIScreenPos().x
local bottom=self.bottomBorder:getChildUIScreenPos().y
local top=self.topBorder:getChildUIScreenPos().y
if x<left or x>right or y<bottom or y>top then
return true
end
return false
end


function UIWorldXiuZhenJiaZuManagerWin:beginDragCallback(index,position)

local haveDz,dzId=self:checkDragIndexHaveDZ(index)
if haveDz then
self.dragObject:setActive(true)
self.dragObject:setChildUIScreenPos(Vector2(position.x,position.y))

comHelper.setChildHead2(self.dragObject,dzId,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dragObject:getID(),true)
self.winlua:SetChildUIModelShowScale(self.dzModel[index]:getID(),0.01)
end
end

function UIWorldXiuZhenJiaZuManagerWin:dragCallback(index,position)
self.dragObject:setChildUIScreenPos(Vector2(position.x,position.y))
end

function UIWorldXiuZhenJiaZuManagerWin:endDragCallback(index,position)

local familyGuidList=self.dzGuidList[self.selectJiaZuIndex]
local endIndex=self:getIndexByPos(position.x,position.y)
local checkRemove=self:checkOverBorder(position.x,position.y)
if endIndex>0 and index~=endIndex then
local haveDz,dzId=self:checkDragIndexHaveDZ(endIndex)
if haveDz then
local indexGuid=familyGuidList[index]
familyGuidList[index]=dzId
familyGuidList[endIndex]=indexGuid
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[index]:getID())
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[endIndex]:getID())

comHelper.setChildHead2(self.dzModel[index],dzId,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dzModel[index]:getID(),true)

comHelper.setChildHead2(self.dzModel[endIndex],indexGuid,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dzModel[endIndex]:getID(),true)

self.dzName[index]:setText(UIDiscipleModel:getDiscipleName(dzId))
self.dzName[endIndex]:setText(UIDiscipleModel:getDiscipleName(indexGuid))
self.jobName[index]:setText(UIDiscipleModel:getJobNameX(dzId))
self.jobName[endIndex]:setText(UIDiscipleModel:getJobNameX(indexGuid))
else
local indexGuid=familyGuidList[index]
familyGuidList[index]=int64.zero
familyGuidList[endIndex]=indexGuid

self.dzNameImg[index]:setActive(false)
self.dzNameImg[endIndex]:setActive(true)

self.lRole[index]:setSprite(imageabname,'image_zdjuesezhanwei_1')
self.lRole[endIndex]:setSprite(globalABLookup.global,'image_zdjuesezhanwei_2')

comHelper.setChildHead2(self.dzModel[endIndex],indexGuid,0.85,0,-50,false)
self.winlua:SetChildUIModelShowFlipX(self.dzModel[endIndex]:getID(),true)

self.dzName[endIndex]:setText(UIDiscipleModel:getDiscipleName(indexGuid))
self.jobName[endIndex]:setText(UIDiscipleModel:getJobNameX(indexGuid))

self.winlua:SetChildUIModelRemoveTarget(self.dzModel[index]:getID())
end
elseif checkRemove then
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[index]:getID())
self.dzNameImg[index]:setActive(false)
self.lRole[index]:setSprite(imageabname,'image_zdjuesezhanwei_1')
familyGuidList[index]=int64.zero
self:refreshDzPanel()
end
self.dragObject:setActive(false)
self.winlua:SetChildUIModelShowScale(self.dzModel[index]:getID(),1)
end


function UIWorldXiuZhenJiaZuManagerWin:refreshBtnsState()
self.selectFightImg:setActive(self.sortType==eDiscipleSortType.eFightSort)
self.selectJingJieImg:setActive(self.sortType==eDiscipleSortType.eJingJieSort)
self.selectLianTiImg:setActive(self.sortType==eDiscipleSortType.eLianTiSort)
end



function UIWorldXiuZhenJiaZuManagerWin:onFightSortBtn()
if self.sortType==eDiscipleSortType.eFightSort then return end
self.sortType=eDiscipleSortType.eFightSort
self:refreshBtnsState()
self:refreshDzPanel()
end

function UIWorldXiuZhenJiaZuManagerWin:onJingjieSortBtn()
if self.sortType==eDiscipleSortType.eJingJieSort then return end
self.sortType=eDiscipleSortType.eJingJieSort
self:refreshBtnsState()
self:refreshDzPanel()
end

function UIWorldXiuZhenJiaZuManagerWin:onLiantiSortBtn()
if self.sortType==eDiscipleSortType.eLianTiSort then return end
self.sortType=eDiscipleSortType.eLianTiSort
self:refreshBtnsState()
self:refreshDzPanel()
end

function UIWorldXiuZhenJiaZuManagerWin:onClickClose()
self:closeSelf()
end

function UIWorldXiuZhenJiaZuManagerWin:reqChangeDzList()
for i,v in ipairs(self.allFamilyData)do
local guidList=self:getSortGuidList(i)
worldXiuZhenJiaZuController:req_change_xzfamily(v.world,v.guid,#guidList,guidList)
end
end

function UIWorldXiuZhenJiaZuManagerWin:getSortGuidList(i)
local familyGuidList=self.dzGuidList[i]
local guidList={}
for i=1,5 do
local guid=familyGuidList[i]
if not mathHelper.validInt64(guid)then
table.insert(guidList,i,{0,int64.zero})
else
table.insert(guidList,i,{1,guid})
end
end
return guidList
end

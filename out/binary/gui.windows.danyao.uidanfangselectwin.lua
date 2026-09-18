







def_class("UIDanFangSelectWin",UIWindowBase)








function UIDanFangSelectWin:bindComponents()

self.back=UIObject.get(self,0)
self.bagLine=UIObject.get(self,1)
self.bagPage=UIObject.get(self,2)
self.bagScrollView=UIObject.get(self,3)
self.blackBG=UIObject.get(self,4)
self.btnClose=UIButton.get(self,5)
self.infoPanel=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.titleText=UIText.get(self,8)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIDanFangSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.bagLine);self.bagLine=nil;
_UIObject_release(self.bagPage);self.bagPage=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end















local _this=nil

function UIDanFangSelectWin:onLoaded(...)
_this=self
self:bindComponents()
if self.bagScrollView and self.bagScrollView.setChildScrollViewInit then
self.bagScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end
end


function UIDanFangSelectWin:__delete()
_this=nil
self:unbindComponents()
self:closeExtra()
local winName=self.extraWin
if winName then
UIManager:removeWindowAwake(winName)
end
local cb=self.closeCB
if cb then
cb()
end
end


function UIDanFangSelectWin:onHide()

end

function UIDanFangSelectWin.showUI()
if _this==nil then return end
if _this.markDragon==false then return end
_this:showExtra()
end




function UIDanFangSelectWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}


self:setRootLPosX(0)
self:closeExtra()
self:resetRootCanves()

self.dfId=argtable.dfId
self.selectedPlanIdx=argtable.selectedPlanIdx
self.onConfirm=argtable.onConfirm

local planCount=tonumber(argtable.planCount)or 0
if planCount<0 then planCount=0 end

local showSelectedOnInit=argtable.showSelectedOnInit==true
if showSelectedOnInit then
local idx=tonumber(self.selectedPlanIdx)
if idx and idx>0 and idx<=planCount then
self.selectIndex=idx
else
self.selectIndex=nil
end
else
self.selectIndex=nil
end

local list={}
if argtable.costPlanList and type(argtable.costPlanList)=='table'then
for i=1,planCount do
list[i]=argtable.costPlanList[i]
end
else
for i=1,planCount do
list[i]={}
end
end

self.planCount=planCount
self.planList=list


self.bagScrollView:setChildScrollViewCreateGrids(planCount,1)
self.bagScrollView:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.bagScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:refreshItem(i,item,list[i])
end
end


local showBG=argtable.showBG
if showBG==nil then showBG=true end
self.blackBG:setActive(showBG)
local showClose=argtable.showClose
if showClose==nil then showClose=true end
self.btnClose:setActive(showClose)
local titleName=argtable.titleName
self.defaultTitleName=titleName
self:refreshTitle(titleName)
self.moveX=self:doMove(argtable.pos)

local cb=function()
self:onLoadFinish()
end
self.markAnim=false
self.markDragon=false
if afterOnloaded then
self.infoPanel:setChildCanvasGroupAlpha(0)
self.back:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
else
cb()
end
end


function UIDanFangSelectWin:refreshItem(i,item,itemList)
itemList=itemList or{}

item:SetChildLayoutGroupCreateItems(3,3)
local grids=item:GetChildLayoutGroupGridList(3)
for idx=0,grids.Count-1 do
local grid=grids[idx]
local fangAn=itemList[idx+1]
if fangAn then
local have=itemsModel.getCount(fangAn[1])
local countStr
if itemsConfig.isMoney(fangAn[1])then
if have>=fangAn[2]then
countStr=mathHelper.formatNumber(fangAn[2])
else
countStr=FMT.fmt("<color=#f36666>{0}</color>",mathHelper.formatNumber(fangAn[2]))
end
else
if have>=fangAn[2]then
countStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
else
countStr=FMT.fmt("<color=#f36666>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
end
end

local conf={showname=false,showcount=true,showCountBG=true,itemcount=countStr,showStageBg=true}
local it={itemid=fangAn[1],itemcount=fangAn[2]}
local prop=itemsComponentHelper.getCommonFillData(it,conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(-1,prop)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
else
grid:SetChildActive(-1,false)
end
end

item:SetChildButtonClick(1,function()
if self.selectIndex then
local old=self.bagScrollView:getChildScrollViewItemWidget(self.selectIndex-1)
if old then
old:SetChildActive(1,true)
old:SetChildActive(0,false)
end
end

item:SetChildActive(1,false)
item:SetChildActive(0,true)
self.selectIndex=i

local cb=self.onConfirm
if cb then
cb(i)
end

self:onCloseClick()
end)


if self.selectIndex==i then
item:SetChildActive(1,false)
item:SetChildActive(0,true)
else
item:SetChildActive(1,true)
item:SetChildActive(0,false)
end

item:SetChildText(2,FMT.fmt("方案{0}",mathHelper.numberToChinese(i)))
end

function UIDanFangSelectWin:doMove(pos)

pos=pos or 2
local moveX=0
if pos==1 then
moveX=-430
elseif pos==3 then
moveX=430
elseif pos==4 then
moveX=-250
elseif pos==5 then
moveX=337
elseif pos==6 then
moveX=-357
end
self.infoPanel:setLocalPosX(moveX)
self.back:setLocalPosX(moveX)
return moveX
end

function UIDanFangSelectWin:showCloseBtn(bShow)
self.btnClose:setActive(bShow)
end

function UIDanFangSelectWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UIDanFangSelectWin:showExtra()
if self.markAnim==true then return end
local winName=self.extraWin
local moveX=self.moveX
if winName~=nil then
local win=UIManager:findActiveWindow(winName)
if win~=nil then
win:setChildCanvasGroupAlpha(-1,0)
win:setChildCanvasGroupDOFade(-1,1,1,nil)
win:setChildLocalPosX(-1,moveX)
self.markAnim=true
end
end
end

function UIDanFangSelectWin:onLoadFinish()
self.markDragon=true
if self.markAnim==true then return end
local func=function()
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)
self:showExtra()
end
self:delayDo(0.3,func)
end

function UIDanFangSelectWin:onCloseClick()
self:closeSelf()
end

function UIDanFangSelectWin:onBtnClose()
self:onCloseClick()
end

function UIDanFangSelectWin:resetRootCanves(sortLayer,sortOrder)
if sortLayer==nil then
self.root:setChildRemoveCanvas()
else
self.root:setChildCanvas(sortLayer,sortOrder)
end
end

function UIDanFangSelectWin:moveRoot(moveX,duration)
self.root:setChildDOLocalMoveX(moveX,duration)
end

function UIDanFangSelectWin:setRootLPosX(xpos)
local pos=self.root:getChildLocalPosition()
pos.x=xpos
self.root:setChildLocalPosition(pos)
end

function UIDanFangSelectWin:refreshTitle(titleName)
titleName=titleName or self.defaultTitleName
self.titleText:setText(titleName)
end


function UIDanFangSelectWin:refreshPlanList(planCount)
planCount=tonumber(planCount)or 0
if planCount<0 then planCount=0 end
self.planCount=planCount
if not self.bagScrollView or not self.bagScrollView.setChildScrollViewCreateGrids then
return
end
self.bagScrollView:setChildScrollViewCreateGrids(planCount,1)
end









def_class("UIAStrokeGameWin",UIWindowBase)









function UIAStrokeGameWin:bindComponents()

self.ActiveLine=UIObject.get(self,0)
self.bgeffect=UIObject.get(self,1)
self.BgLine=UIObject.get(self,2)
self.bgmodel=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.DragRoot=UIObject.get(self,5)
self.effect=UIObject.get(self,6)
self.forgetEffect=UIObject.get(self,7)
self.forgetTips=UIObject.get(self,8)
self.forgetTipsButton=UIButton.get(self,9)
self.ItemPool=UIObject.get(self,10)
self.LeafLine=UIObject.get(self,11)
self.leafObject=UIObject.get(self,12)
self.leafObject2=UIObject.get(self,13)
self.removeButton=UIButton.get(self,14)
self.resetButton=UIButton.get(self,15)
self.wanfabtn=UIButton.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.forgetTipsButton:setButtonClick(function()self:onForgetTipsButton()end)

self.removeButton:setButtonClick(function()self:onRemoveButton()end)

self.resetButton:setButtonClick(function()self:onResetButton()end)

self.wanfabtn:setButtonClick(function()self:onWanfabtn()end)



end


function UIAStrokeGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ActiveLine);self.ActiveLine=nil;
_UIObject_release(self.bgeffect);self.bgeffect=nil;
_UIObject_release(self.BgLine);self.BgLine=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.DragRoot);self.DragRoot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.forgetEffect);self.forgetEffect=nil;
_UIObject_release(self.forgetTips);self.forgetTips=nil;
_UIObject_release(self.forgetTipsButton);self.forgetTipsButton=nil;
_UIObject_release(self.ItemPool);self.ItemPool=nil;
_UIObject_release(self.LeafLine);self.LeafLine=nil;
_UIObject_release(self.leafObject);self.leafObject=nil;
_UIObject_release(self.leafObject2);self.leafObject2=nil;
_UIObject_release(self.removeButton);self.removeButton=nil;
_UIObject_release(self.resetButton);self.resetButton=nil;
_UIObject_release(self.wanfabtn);self.wanfabtn=nil;
end


















local posData={}
local lineData={}

local linkedIndexList={}

local leafPointList={}

local radius=50

local isDrag=false
local isLineInPoint=false


local configPosWidgetIndex=0
local configPosList={}


local _this=nil



function UIAStrokeGameWin:onLoaded(...)
self:bindComponents()

_this=self

self.winlua:SetChildUIDragEvent(self.DragRoot:getID(),0,self.beginDragCallback,self.endDragCallback,self.dragCallback)

self.ActiveLine:setLineRendererPositionCount(0)
self.LeafLine:setLineRendererPositionCount(2)
self.leafObject:setChildDragonTarget(2038,1,nil,2043)
self.leafObject2:setChildDragonTarget(2038,1,nil,2043)
end


function UIAStrokeGameWin:__delete()
self.leafObject:setChildUIModelRemoveTarget(0)
self:unbindComponents()
posData={}
lineData={}
linkedIndexList={}
leafPointList={}
isLineInPoint=false
_this=nil




end




function UIAStrokeGameWin:onShow(argtable,afterOnloaded)
self.bgmodel:setChildUIModelShowTarget(6018,1,{},eAnimationID.enter)
self.configMode=argtable and argtable.configMode
self.args=argtable
self.mapId=self.args.mapId
if self.mapId then
self:loadConfigId(self.mapId)
end
if UIManager:isActive('UITopMoneyWin')then
UIManager:hideWindow('UITopMoneyWin')
end
if self.args.startCallback then
self.args.startCallback()
end
end

function UIAStrokeGameWin:initPointPos(posList)
posData=posList
self.winlua:SetChildLayoutGroupCreateItems(self.ItemPool:getID(),#posData)
self.list={}
for i=1,#posData do
local pos=posData[i]
self:setPointWidget(i,Vector2(pos[1],pos[2]),false)
end


end

function UIAStrokeGameWin:setBgLine(lineList)
lineData=lineList
self.BgLine:setLineRendererPositionCount(0)
for i,v in ipairs(lineData)do
local beginId=v[1]
local endId=v[2]
local beginPos=posData[beginId]
local endPos=posData[endId]
if beginPos and endPos then
if i>1 then
self.BgLine:addLineRendererPos(Vector2(endPos[1],endPos[2]))
else
self.BgLine:addLineRendererPos(Vector2(beginPos[1],beginPos[2]))
self.BgLine:addLineRendererPos(Vector2(endPos[1],endPos[2]))
end
end
end
end



function UIAStrokeGameWin:setPointWidget(index,position,active)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.ItemPool:getID(),index-1)
if widget then
if position then
widget:SetChildAnchoredPosition(0,position)
end
if active then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,false)
end
if self.configMode then
widget:SetChildText(3,index)
end
end
end

function UIAStrokeGameWin:removeLineVertex()
local positionCount=self.ActiveLine:getLineRendererPositionCount()
if positionCount==0 then
return
end
self.LeafLine:setActive(false)
if positionCount==1 or positionCount==2 then
self:resetLineVertex()
else

self.ActiveLine:setLineRendererPositionCount(positionCount-1)
table.remove(linkedIndexList,#linkedIndexList)
local leafPoint=leafPointList[#leafPointList]
local active=false
for i,v in ipairs(linkedIndexList)do
if lineData[v]then
if lineData[v][1]==leafPoint or lineData[v][2]==leafPoint then
active=true
end
end
end
self:setPointWidget(leafPoint,nil,active)
table.remove(leafPointList,#leafPointList)
leafPoint=leafPointList[#leafPointList]
if leafPoint then
local pos=posData[leafPoint]
self.leafObject:setChildAnchoredPosition(Vector2(pos[1],pos[2]))
end
end
isLineInPoint=false
end


function UIAStrokeGameWin:resetLineVertex()
self.LeafLine:setActive(false)
self.leafObject:setActive(false)
self.ActiveLine:setLineRendererPositionCount(0)
linkedIndexList={}
for i,v in ipairs(leafPointList)do
self:setPointWidget(v,nil,false)
end
leafPointList={}
isLineInPoint=false
end



function UIAStrokeGameWin:onHide()

end

function UIAStrokeGameWin:onRemoveButton()
self:removeLineVertex()
end

function UIAStrokeGameWin:onResetButton()
self:resetLineVertex()
end


function UIAStrokeGameWin:onFinishGame()


self.effect:setChildShowEffect(10060,true)
self:setTimer(2,1,function()

if self.args.callback then
self.args.callback(1)
end
self:closeSelf()
end)
end

function UIAStrokeGameWin:onCloseBtn()
UILittleGameController:quitTips(function()

self.effect:setChildShowEffect(10064,true)
self:setTimer(2,1,function()

if self.args.callback then
self.args.callback(0)
end
self:closeSelf()
end)
end)
end


function UIAStrokeGameWin:loadConfigId(configId)
local config=courtroomModel.cfg_posConfig_get(configId)
if config then
local testPosList=config.posList
local testLineList=config.lineList
if testLineList~=nil and testPosList~=nil then
self:initPointPos(testPosList)
self:setBgLine(testLineList)
end
else
UIManager.error('无配置文件')
end
end


function UIAStrokeGameWin:LineInPoint(pos)
local inPoint=nil

for k,pointPos in pairs(posData)do
if(pos.x>=(pointPos[1]-radius)and pos.y>=(pointPos[2]-radius)and pos.x<=(pointPos[1]+radius)and pos.y<=(pointPos[2]+radius))then
inPoint=k
break
end
end
return inPoint

end

function UIAStrokeGameWin:isNearPoint(beginPointIndex,endPointIndex)
for k,v in pairs(lineData)do
local headIndex=v[1]
local endIndex=v[2]

if((beginPointIndex==headIndex and endPointIndex==endIndex)or(beginPointIndex==endIndex and endPointIndex==headIndex))then
return k
end
end
end

function UIAStrokeGameWin:isLinked(linkIndex)
if(#linkedIndexList>0)then
for k,v in pairs(linkedIndexList)do
if(linkIndex==v)then
return true
end
end
end
return false
end

function UIAStrokeGameWin:isFinished()
return#linkedIndexList==#lineData
end

function UIAStrokeGameWin.beginDragCallback(index,position)

if _this:isFinished()then

return
end
local index=_this:LineInPoint(position)

local activedLineCount=_this.ActiveLine:getLineRendererPositionCount()
if activedLineCount==0 then

if(not isLineInPoint)and index~=nil then
table.insert(leafPointList,index)

local pointPos=posData[index]
if pointPos then
local vec2=Vector2(pointPos[1],pointPos[2])
_this.LeafLine:setActive(true)
_this.LeafLine:setLineRendererPos(0,vec2)
_this.LeafLine:setLineRendererPos(1,position)
_this.leafObject2:setChildAnchoredPosition(position)
end
isLineInPoint=true
end
else
if#leafPointList>0 then
local curBeginPoint=leafPointList[#leafPointList]
local pointPos=posData[curBeginPoint]
if pointPos then
_this.LeafLine:setActive(true)
local vec2=Vector2(pointPos[1],pointPos[2])
_this.LeafLine:setLineRendererPos(0,vec2)
_this.LeafLine:setLineRendererPos(1,position)
_this.leafObject2:setChildAnchoredPosition(position)
end
end
end

isDrag=true
end

function UIAStrokeGameWin.dragCallback(index,position)
if not isDrag then
return
end
_this.leafObject2:setChildAnchoredPosition(position)
_this.LeafLine:setLineRendererPos(1,position)

_this:checkPosition(position)
end

function UIAStrokeGameWin:checkPosition(position)
local activedLineCount=_this.ActiveLine:getLineRendererPositionCount()
local index=_this:LineInPoint(position)
local curBeginPoint=-1
if#leafPointList>0 then
curBeginPoint=leafPointList[#leafPointList]
end
if index then
local lineIndex=_this:isNearPoint(curBeginPoint,index)
if lineIndex and(not _this:isLinked(lineIndex))then

if activedLineCount==0 then
local pointPos=posData[curBeginPoint]
if pointPos then
local vec2=Vector2(pointPos[1],pointPos[2])
_this.ActiveLine:addLineRendererPos(vec2)
_this:setPointWidget(curBeginPoint,nil,true)
pointPos=posData[index]
if pointPos then
vec2=Vector2(pointPos[1],pointPos[2])
_this.ActiveLine:addLineRendererPos(vec2)
_this:setPointWidget(index,nil,true)
_this.LeafLine:setLineRendererPos(0,vec2)
_this.leafObject:setActive(true)
_this.leafObject:setChildAnchoredPosition(vec2)
end
end
else
local pointPos=posData[index]
if pointPos then
local vec2=Vector2(pointPos[1],pointPos[2])
_this.ActiveLine:addLineRendererPos(vec2)
_this:setPointWidget(index,nil,true)
_this.LeafLine:setLineRendererPos(0,vec2)
_this.leafObject:setActive(true)
_this.leafObject:setChildAnchoredPosition(vec2)
end
end
table.insert(leafPointList,index)
table.insert(linkedIndexList,lineIndex)

isLineInPoint=false

if _this:isFinished()then

_this.LeafLine:setActive(false)
_this:onFinishGame()
end
end
end
end

function UIAStrokeGameWin.endDragCallback(index,position)
isDrag=false
_this:checkPosition(position)
_this.LeafLine:setActive(false)

if isLineInPoint and#leafPointList==1 then
leafPointList={}
isLineInPoint=false
end
end



function UIAStrokeGameWin:setGridPos()
configPosList={}
local gridList=self.ItemPool:getChildLayoutGroupGridList()
local gridNum=gridList.Count
for i=1,gridNum do
if gridList[i-1]then
local pos=gridList[i-1]:GetChildAnchoredPosition(0)
configPosList[i]={pos.x,pos.y}
end
end

self:initPointPos(configPosList)
end

function UIAStrokeGameWin:setTestBgLine(lineTable)
self.BgLine:setLineRendererPositionCount(0)

self:setBgLine(lineTable)
end

function UIAStrokeGameWin:getTestBgLine()
return lineData
end

function UIAStrokeGameWin:addLastPointWidget()
if not self.configMode then
return
end

local gridList=self.ItemPool:getChildLayoutGroupGridList()
local gridNum=gridList.Count
if gridNum==0 then
self:CreatePoint(1)
else
self.ItemPool:setChildLayoutGroupAddItem()
gridList=self.ItemPool:getChildLayoutGroupGridList()
gridNum=gridList.Count
self:setPointWidget(gridNum,nil,false)
end

configPosWidgetIndex=configPosWidgetIndex+1

end

function UIAStrokeGameWin:removeLastPointWidget()
if not self.configMode then
return
end
if configPosWidgetIndex<=0 then
return
end
self.ItemPool:setChildLayoutGroupRemoveItem()
configPosWidgetIndex=configPosWidgetIndex-1
end

function UIAStrokeGameWin:CreatePoint(num)
if not self.configMode then
return
end
self.winlua:SetChildLayoutGroupCreateItems(self.ItemPool:getID(),num)
local gridList=self.ItemPool:getChildLayoutGroupGridList()
local gridNum=gridList.Count
for i=1,gridNum do
if gridList[i-1]then
self:setPointWidget(i,nil,false)
end
end
end

function UIAStrokeGameWin:testSaveId(configId)
if next(posData)and next(lineData)then
courtroomModel.FileExport(configId,posData,lineData)
end
end



function UIAStrokeGameWin:onWanfabtn()
UIAStrokeGameWin:showWindow("UIAStrokeGameTipsWin")
end

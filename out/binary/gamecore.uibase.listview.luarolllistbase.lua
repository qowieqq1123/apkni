

LuaRollListBase=simple_class()




function LuaRollListBase:__init(winlua,cmpObj)
self.winlua=winlua
self.cmpObj=cmpObj
local _beginDrag=function(index,pos)
self:beginDrag(pos)
end
local _onDrag=function(index,pos)
self:onDrag(pos)
end
local _endDrag=function(index,pos)
self:endDrag(pos)
end
self.winlua:SetChildUIDragEvent(self.cmpObj:getID(),0,_beginDrag,_endDrag,_onDrag)
end


function LuaRollListBase:__delete()
self:stopRoll()
end





function LuaRollListBase:createList(count,itemSize,spacing)
self.spacing=spacing or 0
self.itemSize=itemSize
self.count=count
self.showCnt=math.ceil(self.contentSize/(itemSize+spacing))
self.loadCnt=self.showCnt+1

self.dataList={}
self.cmpList={}
self.cmpObj:setChildLayoutGroupCreateItems(self.loadCnt,function(index)
local idx=index-1
local item=self.cmpObj:getChildLayoutGroupGridItem(index-1)

local dataIdx=idx%self.count
if dataIdx==0 then
dataIdx=self.count
end
self.dataList[index]=dataIdx
self.cmpList[index]=item
item:SetChildAnchors(-1,Vector2.up,Vector2.up)
item:SetChildPivot(-1,Vector2.up)
self:initListItem(item,index)
self:onRefershItem(item,dataIdx)
end)
end




function LuaRollListBase:itemIdxToDataIdx(itemIdx)
return self.dataList[itemIdx]
end




function LuaRollListBase:startRoll(speed,order)
if self.rolls==nil then
self.rolls={}
for i,v in ipairs(self.cmpList)do
self.rolls[i]=self:doRoll(i,v,speed,order)
end
end
end


function LuaRollListBase:stopRoll()
if self.rolls~=nil then
for i,v in ipairs(self.rolls)do
self:killRoll(i,v)
end
self.rolls=nil
self.suspend=nil
end
end


function LuaRollListBase:pauseRoll()
if self.rolls~=nil then
if not self.suspend then
self.suspend=true
for i,v in ipairs(self.rolls)do
self:freezeRoll(i,v)
end
end
end
end


function LuaRollListBase:resumeRoll()
if self.rolls~=nil then
if self.suspend then
self.suspend=false
for i,v in ipairs(self.rolls)do
self:refreezeRoll(i,v)
end
end
end
end



function LuaRollListBase:beginDrag(pos)
self.dragPos=pos
self:stopRoll()
end



function LuaRollListBase:onDrag(pos)
local delta=pos-self.dragPos
self:onDragDelta(delta)
self.dragPos=pos
end



function LuaRollListBase:endDrag(pos)
self.dragPos=nil
end




function LuaRollListBase:killRoll(itemIdx,tween)
if tween then
tween:Kill(false)
end
end




function LuaRollListBase:freezeRoll(itemIdx,tween)
if tween then
tween:TogglePause()
end
end




function LuaRollListBase:refreezeRoll(itemIdx,tween)
if tween then
tween:TogglePause()
end
end




function LuaRollListBase:initListItem(item,itemIdx)

end



function LuaRollListBase:onDragDelta(delta)

end




function LuaRollListBase:onRefershItem(item,dataIdx)

end






function LuaRollListBase:doRoll(item,speed,order)

end

function LuaRollListBase:overTop()

local dataIndex=self.dataList[self.bottom]+1
if dataIndex>self.count then
dataIndex=dataIndex-self.count
end
self.dataList[self.top]=dataIndex
self:onRefershItem(self.cmpList[self.top],dataIndex)

self.bottom=self.top
self.top=self.top+1
if self.top>self.loadCnt then
self.top=self.top-self.loadCnt
end
end

function LuaRollListBase:overBottom()

local dataIndex=self.dataList[self.top]-1
if dataIndex<=0 then
dataIndex=dataIndex+self.count
end
self.dataList[self.bottom]=dataIndex
self:onRefershItem(self.cmpList[self.bottom],dataIndex)

self.top=self.bottom
self.bottom=self.bottom-1
if self.bottom<=0 then
self.bottom=self.bottom+self.loadCnt
end
end

LuaRollListVertical=simple_class(LuaRollListBase)

local _linearEase=DG.Tweening.Ease.Linear

function LuaRollListVertical:__init(winlua,cmpObj)
LuaRollListBase.__init(self,winlua,cmpObj)
self.contentSize=self.winlua:GetChildSizeDeltaY(self.cmpObj:getID())
end

function LuaRollListVertical:createList(count,itemSize,spacing,dragLoop)
LuaRollListBase.createList(self,count,itemSize,spacing)
self.top=1
self.bottom=self.loadCnt
self.dragLoop=dragLoop
end

function LuaRollListVertical:initListItem(item,itemIdx)
local temp=(self.spacing+self.itemSize)*(2-itemIdx)
local position=Vector2.New(0,temp)
item:SetChildAnchoredPosition(-1,position)
end

function LuaRollListVertical:overTopItem(pos)
local item=self.cmpList[self.top]
pos=pos or item:GetChildAnchoredPosition(-1)

pos.y=pos.y-(self.spacing+self.itemSize)*self.loadCnt
item:SetChildAnchoredPosition(-1,pos)

self:overTop()
end

function LuaRollListVertical:overBottomItem(pos)
local item=self.cmpList[self.bottom]
pos=pos or item:GetChildAnchoredPosition(-1)

pos.y=pos.y+(self.spacing+self.itemSize)*self.loadCnt
item:SetChildAnchoredPosition(-1,pos)

self:overBottom()
end

function LuaRollListVertical:limitDragDelta(pos)
local absY=math.abs(pos.y)
if absY>0 then
pos.y=math.min(absY,self.itemSize)*(pos.y/absY)
end
return pos
end

function LuaRollListVertical:onDragDelta(pos)
pos=self:limitDragDelta(pos)

local deltas={}
for i=1,self.loadCnt do
local item=self.cmpList[i]
local positon=item:GetChildAnchoredPosition(-1)
positon.y=positon.y+pos.y
deltas[i]=positon
end

local topPos=deltas[self.top]
local dataTop=self:itemIdxToDataIdx(self.top)
local overTop=false
local bottomPos=deltas[self.bottom]
local dataBottom=self:itemIdxToDataIdx(self.bottom)
local overBottom=false

if not self.dragLoop then
if dataBottom==1 then
local temp=bottomPos.y-(-self.contentSize)
if temp>0 then
for i,v in ipairs(deltas)do
v.y=v.y-temp
end
end
elseif dataTop==self.count then
local temp=self.itemSize-topPos.y
if temp>0 then
for i,v in ipairs(deltas)do
v.y=v.y+temp
end
end
end
end

if topPos.y>self.spacing+self.itemSize then
topPos.y=topPos.y-(self.spacing+self.itemSize)*self.loadCnt
overTop=true
end

if bottomPos.y<-(self.spacing+self.itemSize)*self.showCnt then
bottomPos.y=bottomPos.y+(self.spacing+self.itemSize)*self.loadCnt
overBottom=true
end

for i,v in ipairs(deltas)do
local item=self.cmpList[i]
item:SetChildAnchoredPosition(-1,v)
end

if overTop then
self:overTop()
elseif overBottom then
self:overBottom()
end
end

function LuaRollListVertical:doRoll(itemIdx,item,speed,order)
local itemPos=item:GetChildAnchoredPosition(-1)
local targetY=self.spacing+self.itemSize
if order==ScrollerOrder.reverse then
targetY=targetY*-self.showCnt
end
local distance=math.abs(itemPos.y-targetY)
if distance>0 then
local duration=distance/speed
local tween=item:SetChildDOAnchorPosY(-1,targetY,duration,function()
self:onRollComplete(itemIdx,item,speed,order)
end)
tween:SetEase(_linearEase)
return tween
else
return self:onRollComplete(itemIdx,item,speed,order)
end
end

function LuaRollListVertical:onRollComplete(itemIdx,item,speed,order)
self:killRoll(self.rolls[itemIdx])

if order==ScrollerOrder.order then
if itemIdx==self.top then
self:overTopItem()
else
logErr(FMT.fmt("垂直滚动列表，异常滚动完成 {0}，{1}，{2}",order,self.top,itemIdx))
end
elseif order==ScrollerOrder.reverse then
if itemIdx==self.bottom then
self:overBottomItem()
else
logErr(FMT.fmt("垂直滚动列表，异常滚动完成 {0}，{1}，{2}",order,self.top,itemIdx))
end
end

self.rolls[itemIdx]=self:doRoll(itemIdx,item,speed,order)
return self.rolls[itemIdx]
end
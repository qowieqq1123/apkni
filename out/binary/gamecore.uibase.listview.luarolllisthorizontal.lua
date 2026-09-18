
LuaRollListHorizontal=simple_class(LuaRollListBase)

local _linearEase=DG.Tweening.Ease.Linear

function LuaRollListHorizontal:__init(winlua,cmpObj)
LuaRollListBase.__init(self,winlua,cmpObj)
self.contentSize=self.winlua:GetChildSizeDeltaX(self.cmpObj:getID())
end

function LuaRollListHorizontal:createList(count,itemSize,spacing,dragLoop)
LuaRollListBase.createList(self,count,itemSize,spacing)
self.top=1
self.bottom=self.loadCnt
self.dragLoop=dragLoop
end

function LuaRollListHorizontal:initListItem(item,itemIdx)
local temp=(self.spacing+self.itemSize)*(itemIdx-2)
local position=Vector2.New(temp,0)
item:SetChildAnchoredPosition(-1,position)
end

function LuaRollListHorizontal:overTopItem(pos)
local item=self.cmpList[self.top]
pos=pos or item:GetChildAnchoredPosition(-1)

pos.x=pos.x+(self.spacing+self.itemSize)*self.loadCnt
item:SetChildAnchoredPosition(-1,pos)

self:overTop()
end

function LuaRollListHorizontal:overBottomItem(pos)
local item=self.cmpList[self.bottom]
pos=pos or item:GetChildAnchoredPosition(-1)

pos.x=pos.x-(self.spacing+self.itemSize)*self.loadCnt
item:SetChildAnchoredPosition(-1,pos)

self:overBottom()
end

function LuaRollListHorizontal:limitDragDelta(pos)
local absX=math.abs(pos.x)
if absX>0 then
pos.x=math.min(absX,self.itemSize)*(pos.x/absX)
end
return pos
end

function LuaRollListHorizontal:onDragDelta(pos)
pos=self:limitDragDelta(pos)

local deltas={}
for i=1,self.loadCnt do
local item=self.cmpList[i]
local positon=item:GetChildAnchoredPosition(-1)
positon.x=positon.x+pos.x
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
local temp=bottomPos.x-self.contentSize
if temp<0 then
for i,v in ipairs(deltas)do
v.x=v.x-temp
end
end
elseif dataTop==self.count then
local temp=topPos.x-(-self.itemSize)
if temp>0 then
for i,v in ipairs(deltas)do
v.x=v.x-temp
end
end
end
end

if topPos.x<-self.spacing-self.itemSize then
topPos.x=topPos.x+(self.spacing+self.itemSize)*self.loadCnt
overTop=true
end

if bottomPos.x>(self.spacing+self.itemSize)*self.showCnt then
bottomPos.x=bottomPos.x-(self.spacing+self.itemSize)*self.loadCnt
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

function LuaRollListHorizontal:doRoll(itemIdx,item,speed,order)
local itemPos=item:GetChildAnchoredPosition(-1)
local targetX=-(self.spacing+self.itemSize)
if order==ScrollerOrder.reverse then
targetX=targetX*-self.showCnt
end
local distance=math.abs(itemPos.x-targetX)
if distance>0 then
local duration=distance/speed
local tween=item:SetChildDOAnchorPosX(-1,targetX,duration,function()
self:onRollComplete(itemIdx,item,speed,order)
end)
tween:SetEase(_linearEase)
return tween
else
return self:onRollComplete(itemIdx,item,speed,order)
end
end

function LuaRollListHorizontal:onRollComplete(itemIdx,item,speed,order)
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
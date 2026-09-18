







def_class("UIThrowOutExpWin",UIWindowBase)









function UIThrowOutExpWin:bindComponents()

self.throwOurGrid=UIObject.get(self,0)



end


function UIThrowOutExpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.throwOurGrid);self.throwOurGrid=nil;
end

















local _tickTime=0.15
local _closeTime=5
local _closeTimeCounter
local _tickTimer
local _fadeoffsetX=40
local _fadeoffsetY=50

local _maxThrowOutNum=100
local _throwOutType={
[0]={
startPos=Vector3.New(0,0,0),
entPos=Vector3.New(0,80,0)
},

}

local _Ease=DG.Tweening.Ease
local _table_insert=table.insert
local _table_remove=table.remove

function UIThrowOutExpWin:onLoaded(...)
self:bindComponents()
end

function UIThrowOutExpWin:__delete()
self:unbindComponents()
if _tickTimer~=nil then
self:stopTimerByID(_tickTimer)
_tickTimer=nil
end
_closeTimeCounter=nil
end

function UIThrowOutExpWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initView()
end
if _tickTimer==nil then
local func=function()
self:tickUpdata()
end
_tickTimer=self:setTimer(_tickTime,0,func)
end

if argtable then
self:addMessage(argtable)
end
end

function UIThrowOutExpWin:onHide()

end


function UIThrowOutExpWin:initView()
self.defaultFontSize=24
self.defaultFontColor=Color.New(0,1,0,1)
local pos=self:getChildCanvas(-1)
self.defaultSortLayer=pos[1]
self.defaultSortOrder=pos[2]

self.comList={}
self.keyIdx=0
self.throwOurGrid:setChildLayoutGroupCreateItems(_maxThrowOutNum)
local grid=self.throwOurGrid:getChildLayoutGroupGridList()
for i=1,_maxThrowOutNum do
local item=grid[i-1]
local d={}
d.item=item
_table_insert(self.comList,d)

item:SetChildText(1,'')
item:SetChildCanvasGroupAlpha(0,0)
end
end

function UIThrowOutExpWin:getKeyIdx()
self.keyIdx=self.keyIdx+1
if self.keyIdx>_maxThrowOutNum then
self.keyIdx=1
end
return self.keyIdx
end

function UIThrowOutExpWin:timeClose()
_closeTimeCounter=nil
self:closeSelf()
end

function UIThrowOutExpWin:tickUpdata()
self:addMessageEx()

local has=false
for i,v in ipairs(self.comList)do
if v.state==true then
has=true
break
end
end
if has then
_closeTimeCounter=0
else
if _closeTimeCounter==nil then
_closeTimeCounter=0
end
_closeTimeCounter=_closeTimeCounter+_tickTime
if _closeTimeCounter>=_closeTime then
self:timeClose()
end
end
end

function UIThrowOutExpWin:throwOut(k_idx,args)
local thType=args.pos or 0
local str=args.str
local fontSize=args.fontSize
local fontColor=args.fontColor
local sortLayer=args.sortLayer
local sortOrder=args.sortOrder

local comdata=self.comList[k_idx]
local tyconfig=_throwOutType[thType]
local tw_idx

local item=comdata.item

if fontSize then
item:SetChildTextFontSize(1,fontSize)
else
item:SetChildTextFontSize(1,self.defaultFontSize)
end
if fontColor then
item:SetTextColor(1,fontColor)
else
item:SetTextColor(1,self.defaultFontColor)
end
if sortLayer~=nil and sortOrder~=nil then
item:SetChildCanvas(2,sortLayer,sortOrder)
else
item:SetChildCanvas(2,self.defaultSortLayer,self.defaultSortOrder)
end

if comdata.tweenlist and#comdata.tweenlist>0 then
for i,v in ipairs(comdata.tweenlist)do
self:clearTweener(v)
end
end
comdata.tweenlist={}
if comdata.closeTimer1~=nil then
self:stopTimerByID(comdata.closeTimer1)
comdata.closeTimer1=nil
end
if comdata.closeTimer2~=nil then
self:stopTimerByID(comdata.closeTimer2)
comdata.closeTimer2=nil
end

local startPos=args.startPos or tyconfig.startPos
item:SetChildCanvasGroupAlpha(0,1)
item:SetChildText(1,str)
item:SetChildLocalPosition(0,startPos)

comdata.state=true

local entPos=args.entPos or tyconfig.entPos
local t1=item:SetChildDOLocalMove(0,entPos,1.5,nil)
t1:SetEase(_Ease.OutQuint)
table.insert(comdata.tweenlist,t1)

local func2=function()
comdata.closeTimer1=nil
local t3=item:SetChildCanvasGroupDOFade(0,0,1,nil)
t3:SetEase(_Ease.InSine)
table.insert(comdata.tweenlist,t3)
end
comdata.closeTimer1=self:delayDo(0.9,func2)



local func4=function()
local func5=function()
comdata.state=false
end
comdata.closeTimer2=nil
local pos=Vector2.New(entPos.x+_fadeoffsetX,entPos.y+_fadeoffsetY)
local t2=item:SetChildDOLocalMove(0,pos,1,func5)
t2:SetEase(_Ease.InSine)
table.insert(comdata.tweenlist,t2)
end
comdata.closeTimer2=self:delayDo(1,func4)
end
function UIThrowOutExpWin:clearTweener(tw)
if tw==nil then return end
if not tw:IsComplete()then
tw:OnComplete(nil)
tw:Complete()
end
end

function UIThrowOutExpWin:addMessage(args)
if self.throwTime==nil or Time.realtimeSinceStartup-self.throwTime>=_tickTime then
self.throwTime=Time.realtimeSinceStartup
local k_idx=self:getKeyIdx()
self:throwOut(k_idx,args)
else
if self.waitList==nil then
self.waitList={}
end
table.insert(self.waitList,args)
end
end

function UIThrowOutExpWin:addMessageEx()
if self.waitList~=nil and Time.realtimeSinceStartup-self.throwTime>=_tickTime then
local args=table.remove(self.waitList,1)
if#self.waitList<=0 then self.waitList=nil end
self:addMessage(args)
end
end

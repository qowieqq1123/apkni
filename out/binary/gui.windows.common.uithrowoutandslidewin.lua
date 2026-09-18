







def_class("UIThrowOutAndSlideWin",UIWindowBase)









function UIThrowOutAndSlideWin:bindComponents()

self.throwOurGrid=UIObject.get(self,0)



end


function UIThrowOutAndSlideWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.throwOurGrid);self.throwOurGrid=nil;
end
















local tickTime=0.15
local closeTime=5
local closeTimeCounter
local tickTimer

local maxThrowOutNum=10
local throwOutType={

[0]={
startPos=Vector3.New(0,0,0),
entPos=Vector3.New(0,200,0)
},

[1]={
startPos=Vector3.New(-238,-180,0),
entPos=Vector3.New(-238,100,0)
},

[2]={
startPos=Vector3.New(0,-144,0),
entPos=Vector3.New(0,100,0)
},

[3]={
startPos=Vector3.New(135,-100,0),
entPos=Vector3.New(135,105,0)
},

[4]={
startPos=Vector3.New(300,-100,0),
entPos=Vector3.New(300,105,0)
},
}

local _Ease=DG.Tweening.Ease
local table_insert=table.insert
local table_remove=table.remove


function UIThrowOutAndSlideWin:onLoaded(...)
self:bindComponents()

end


function UIThrowOutAndSlideWin:__delete()
self:unbindComponents()
if tickTimer~=nil then
self:stopTimerByID(tickTimer)
tickTimer=nil
end
closeTimeCounter=nil
end


function UIThrowOutAndSlideWin:onHide()

end

function UIThrowOutAndSlideWin:initView()
self.defaultFontSize=24
self.defaultFontColor=Color.New(0,1,0,1)
local pos=self:getChildCanvas(-1)
self.defaultSortLayer=pos[1]
self.defaultSortOrder=pos[2]

self.comList={}
self.keyIdx=0
self.throwOurGrid:setChildLayoutGroupCreateItems(maxThrowOutNum)
local grid=self.throwOurGrid:getChildLayoutGroupGridList()
for i=1,maxThrowOutNum do
local item=grid[i-1]
local d={}
d.item=item
table_insert(self.comList,d)

item:SetChildText(1,'')
item:SetChildCanvasGroupAlpha(0,0)
end
end

function UIThrowOutAndSlideWin:getKeyIdx()
self.keyIdx=self.keyIdx+1
if self.keyIdx>maxThrowOutNum then
self.keyIdx=1
end
return self.keyIdx
end

function UIThrowOutAndSlideWin:timeClose()
closeTimeCounter=nil
self:closeSelf()
end




function UIThrowOutAndSlideWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initView()
end
if tickTimer==nil then
local func=function()
self:tickUpdata()
end
tickTimer=self:setTimer(tickTime,0,func)
end

if argtable then
self:addMessage(argtable)
end
end

function UIThrowOutAndSlideWin:tickUpdata()
self:addMessageEx()

local has=false
for i,v in ipairs(self.comList)do
if v.state==true then
has=true
break
end
end
if has then
closeTimeCounter=0
else
if closeTimeCounter==nil then
closeTimeCounter=0
end
closeTimeCounter=closeTimeCounter+tickTime
if closeTimeCounter>=closeTime then
self:timeClose()
end
end
end

function UIThrowOutAndSlideWin:throwOut(k_idx,args)
local thType=args[1]
local str=args[2]
local fontSize=args[3]
local fontColor=args[4]
local sortLayer=args[5]
local sortOrder=args[6]

local comdata=self.comList[k_idx]
local tyconfig=throwOutType[thType]
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
if comdata.closeTimer~=nil then
self:stopTimerByID(comdata.closeTimer)
comdata.closeTimer=nil
end

local startPos=args.startPos or tyconfig.startPos
item:SetChildCanvasGroupAlpha(0,1)
item:SetChildText(1,str)
item:SetChildLocalPosition(0,startPos)

comdata.state=true

local entPos=args.entPos or tyconfig.entPos
local func1=function()
comdata.state=false
end
local t1=item:SetChildDOLocalMove(0,entPos,1.5,func1)
t1:SetEase(_Ease.OutQuint)
table.insert(comdata.tweenlist,t1)


item:SetChildScale(0,Vector3.zero)
local fun3=function()
local t3=item:SetChildDOScale(0,1,0.5,nil)
table.insert(comdata.tweenlist,t3)
end
local t2=item:SetChildDOScale(0,2,0.3,fun3)
table.insert(comdata.tweenlist,t2)


local func2=function()
comdata.closeTimer=nil
local t4=item:SetChildCanvasGroupDOFade(0,0,1.5,nil)
table.insert(comdata.tweenlist,t4)
end
comdata.closeTimer=self:delayDo(0.5,func2)
end
function UIThrowOutAndSlideWin:clearTweener(tw)
if tw==nil then return end
if not tw:IsComplete()then
tw:OnComplete(nil)
tw:Complete()
end
end

function UIThrowOutAndSlideWin:addMessage(args)
if self.throwTime==nil or Time.realtimeSinceStartup-self.throwTime>=tickTime then
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

function UIThrowOutAndSlideWin:addMessageEx()
if self.waitList~=nil and Time.realtimeSinceStartup-self.throwTime>=tickTime then
local args=table.remove(self.waitList,1)
if#self.waitList<=0 then self.waitList=nil end
self:addMessage(args)
end
end
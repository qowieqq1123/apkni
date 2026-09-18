







def_class("UIMoJieShiLiBuffTips",UIWindowBase)









function UIMoJieShiLiBuffTips:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.reScrollView=UIObject.get(self,2)
self.shilipanel=UIObject.get(self,3)
self.arr=UIObject.get(self,4)



end


function UIMoJieShiLiBuffTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.reScrollView);self.reScrollView=nil;
_UIObject_release(self.shilipanel);self.shilipanel=nil;
_UIObject_release(self.arr);self.arr=nil;
end
















local _this
local itemidx=
{
selfitem=0,
name=1,
desc=2,
time=3,
line=4
}
local debuff={}
local skillpanelIndex=
{
skillicon={0,1,2,3,4,5,6,7},
skillnum={8,9,10,11,12,13,14,15},
}



function UIMoJieShiLiBuffTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieShiLiBuffTips:__delete()
self:unbindComponents()
for index=1,6 do
self:clearTimer(index)
end
local cb=self.callback
if cb then
cb()
end
_this=nil
end




function UIMoJieShiLiBuffTips:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end

self.pos=pos
local exparem=argtable.exparem


local root=self.reScrollView
if exparem then
root:setChildLocalPosition(Vector3.New(exparem[1][1],exparem[1][2],exparem[1][3]))
self.arr:setChildLocalPosition(Vector3.New(exparem[2][1],exparem[2][2],exparem[2][3]))
self.arr:setRotation(exparem[3][1],exparem[3][2],exparem[3][3])
else
root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
end
root:setChildCanvasGroupAlpha(0)
root:setChildCanvasGroupDOFade(1,0.6,nil)
root:setScale(Vector3.New(1,1,1))

if argtable.bufflsit then
local cfgs=cfg_devildomforceconfig_get(3)
local showbuff=cfgs.showbuff
if showbuff then
for i,buffid in ipairs(showbuff)do
debuff[buffid]=true
end
end

local bufflsit=self:sortbufflist(argtable.bufflsit)
local len=#bufflsit
if len==1 then
self.reScrollView:setChildSizeDelta(390,155)
elseif len==2 then
self.reScrollView:setChildSizeDelta(390,290)
end
self:freshpanel(bufflsit)
self:freshicon(bufflsit)
else
logErr(FMT.fmt('传入的buff列表为空'))
end
end


function UIMoJieShiLiBuffTips:onHide()

end

function UIMoJieShiLiBuffTips:sortbufflist(bufflsit)
local temp={}
for i,buffinfo in pairs(bufflsit)do
local buffid=buffinfo.buffid
local endsec=buffinfo.endsec
local num=buffinfo.num
local weight=buffid
if debuff[buffid]then
weight=buffid+1000000
end
table.insert(temp,{endsec=endsec,buffid=buffid,num=num,weight=weight})
end
if#temp>1 then
table.sort(temp,function(a,b)
return a.weight<b.weight
end)
end
return temp
end


function UIMoJieShiLiBuffTips:freshpanel(bufflsit)
if bufflsit and next(bufflsit)then
local len=#bufflsit
self.reScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.reScrollView:getChildScrollViewItemWidgets()
local stamp=timeHelper.getServerShortTime()
for j=1,len do
local buffinfo=bufflsit[j]
local item=grids[j-1]
local buffid=buffinfo.buffid
local buffCfg=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid)
local endsec=buffinfo.endsec

local name=buffCfg.name
if debuff[buffid]then
name=FMT.fmt('<color=#f36666>{0}</color>',buffCfg.name)
end
item:SetChildText(itemidx.name,name)
item:SetChildText(itemidx.desc,buffCfg.desc)






if endsec<=stamp then
item:SetChildLocalPosY(itemidx.name,38)
item:SetChildLocalPosY(itemidx.desc,-10)
end
self:startTimer(item,endsec,j)
end
end
end

function UIMoJieShiLiBuffTips:freshicon(bufflsit)
if bufflsit and next(bufflsit)then
self.shilipanel:setActive(true)
local item=self.shilipanel:getWidgetBase()
local num=#skillpanelIndex.skillicon
for i=1,num do
local buffinfo=bufflsit[i]
if buffinfo then
local buffid=buffinfo.buffid
local _num=buffinfo.num
item:SetChildActive(skillpanelIndex.skillicon[i],true)
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
item:SetChildIcon(skillpanelIndex.skillicon[i],buffCfg.iconNmae,false)
item:SetChildText(skillpanelIndex.skillnum[i],'')
else
item:SetChildActive(skillpanelIndex.skillicon[i],false)
end
end
else
self.shilipanel:setActive(false)
end
end


function UIMoJieShiLiBuffTips:clearTimer(index)
if not self.timer then
self.timer={}
end
if self.timer[index]then
self:stopTimerByID(self.timer[index])
self.timer[index]=nil
end
end
function UIMoJieShiLiBuffTips:startTimer(widget,endsec,index)

local str=''
local tick=function()
local stamp=timeHelper.getServerShortTime()
if endsec>stamp then
str=FMT.fmt('持续时间：{0}',timeHelper.format_time_stamp(endsec-stamp))
widget:SetChildText(itemidx.time,str)
else
widget:SetChildText(itemidx.time,'<color=#f36666>已过期</color>')
self:clearTimer(index)
end
end
tick()

if not self.timer then
self.timer={}
end
self.timer[index]=self:setTimer(1,0,tick)
end


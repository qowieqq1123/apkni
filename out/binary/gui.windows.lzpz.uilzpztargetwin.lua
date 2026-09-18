







def_class("UILZPZTargetWin",UIWindowBase)









function UILZPZTargetWin:bindComponents()

self.scrollView=UIObject.get(self,0)



end


function UILZPZTargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
end



















function UILZPZTargetWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UILZPZTargetWin:__delete()
self:unbindComponents()
end




function UILZPZTargetWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UILZPZTargetWin:refresh()
self:showTargetList()
end


function UILZPZTargetWin:onHide()

end

function UILZPZTargetWin:getDatas()
local topScore=lingZhenPengZhuangModel:getTopScore()
local cfgs=cfg_lingzhenpengzhuangaimconfig()
local list={}
for i,v in ipairs(cfgs)do
local flag=2
if topScore>=v.score then
flag=1
end
if lingZhenPengZhuangModel:isReceive(v.id)then
flag=3
end
table.insert(list,{id=v.id,cfg=v,flag=flag})
end
table.sort(list,function(a,b)
if a.flag<b.flag then
return true
elseif a.flag==b.flag then
return a.id<b.id
else
return false
end
end)
return list
end

function UILZPZTargetWin:showTargetList()
local receiveFunc=function()
local sendList={}
for i,v in ipairs(self.datas)do
if v.flag==1 then
table.insert(sendList,v.id)
end
end
local len=#sendList
if len>0 then
lingZhenPengZhuangController:reqSetFlag(len,sendList)
end
end
local topScore=lingZhenPengZhuangModel:getTopScore()
self.datas=self:getDatas()
local len=#self.datas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
local need=data.cfg.score
item:SetChildText(0,FMT.fmt('灵阵分数达到{0}点({1}/{2})',need,topScore,need))
local check1=data.flag==1
local check2=data.flag==3
item:SetChildActive(1,check1)
item:SetChildActive(2,check2)
local rewards=data.cfg.reward
for ii=1,2 do
local index=ii+2
local rwd=rewards[ii]
if rwd then
item:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(item,index,rwd)
else
item:SetChildActive(index,false)
end
end
if check1 then
item:SetChildButtonClick(1,receiveFunc)
end
end
end




function UILZPZTargetWin:onCloseClick()
self:closeSelf()
end
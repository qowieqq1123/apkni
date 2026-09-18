







def_class("UIZongHuiWin",UIWindowBase)









function UIZongHuiWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.taskScroller=UIObject.get(self,2)
self.rightpanel=UIObject.get(self,3)
self.controllBtn=UIButton.get(self,4)
self.controllClose=UIObject.get(self,5)
self.controllOpen=UIObject.get(self,6)
self.center=UIObject.get(self,7)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIZongHuiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.rightpanel);self.rightpanel=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.center);self.center=nil;
end
















local _this
local itemidx=
{
selfitem=0,
select=1,
icon=2,
new=3,
name=4,
btn=5,
hide=6,
}
local rightidx=
{
desc1=0,
desc2=1,
arrDescItem=2,
timebg=3,
time=4,
}
local item_Arr={0,1,2,3,4}
local item_ArrTxt={5,6,7,8,9}
local abname=''



function UIZongHuiWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectid=1
self.hidelist={}
self.inithidelist={}
end


function UIZongHuiWin:__delete()
self:unbindComponents()
self:onChangeZHState()
_this=nil
end


function UIZongHuiWin:onChangeZHState()
if self.hidelist and next(self.hidelist)then
local list={}
for k,v in pairs(self.hidelist)do
table.insert(list,{k,v})
end

ZongHuiController:send_254_132(#list,list)
end
end

function UIZongHuiWin:onControllBtn()
local data=self.zhList[self.selectid]
local id=data.id

local ishide=self.inithidelist[id]

if self.hidelist[id]then
ishide=self.hidelist[id]
end


if ishide==1 then
ishide=0
elseif ishide==0 then
ishide=1
else
ishide=1
end

self.hidelist[id]=ishide
self:refreshItemControllBtn(ishide)
end


function UIZongHuiWin:onSelectBtn(index)
if index==self.selectid then
return
end
local oldIndex=self.selectid
self.selectid=index

local grid=self.taskScroller:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildActive(itemidx.select,true)


local data=self.zhList[index]
local unlock=data.unlock
if unlock then
local id=data.id
local ishide=self.inithidelist[id]
if ishide==2 and not self.hidelist[id]then
self.hidelist[id]=1
end
end
end
if oldIndex then
local oldgrid=self.taskScroller:getChildScrollViewItemWidget(oldIndex-1)
if oldgrid then
oldgrid:SetChildActive(itemidx.select,false)
end
end


self:freshRightPanel()
end




function UIZongHuiWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)

self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.config=cfg_sectbadgeconfig()
self.selectid=1

self:freshList()


self:freshRightPanel()
end


function UIZongHuiWin:onHide()

end
function UIZongHuiWin:onBtnClose()
self:closeSelf()
end


function UIZongHuiWin:getSortList()
local list={}
local zhdata=ZongHuiModel:getBadgeList()

for k,v in ipairs(self.config)do
local id=v.id
local _weight=v.weight
local finishtime=0
local ishide=2
if zhdata[id]then
finishtime=zhdata[id].param_4
ishide=zhdata[id].param_3
end

if self.hidelist[id]then
ishide=self.hidelist[id]
end
self.inithidelist[id]=ishide

local _unlock=finishtime>0
local active=_unlock and 1 or 0
local _sort=_weight+active*10000
table.insert(list,{id=id,unlock=_unlock,sort=_sort})
end
if#list>1 then
table.sort(list,function(a,b)
return a.sort>b.sort
end)
end
return list
end

function UIZongHuiWin:freshList()
local list=self:getSortList()
local zhdata=ZongHuiModel:getBadgeList()
self.zhList=list
self.zhDataList=zhdata


local dataNum=#list
if dataNum>0 then
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,3)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
if widget then
local data=list[i]
local id=data.id
local unlock=data.unlock
local cfg=self.config[id]
local ishide=self.inithidelist[id]


widget:SetChildText(itemidx.name,cfg.name)

widget:SetChildCSImageSprite(itemidx.icon,abname,cfg.icon)

widget:SetChildGray(itemidx.icon,not unlock)

widget:SetChildActive(itemidx.hide,ishide==0 and unlock)

widget:SetChildActive(itemidx.new,ishide==2 and unlock)

widget:SetChildActive(itemidx.select,self.selectid==i)


widget:SetChildButtonClick(itemidx.btn,function()
if _this==nil then return end
self:onSelectBtn(i)
end)
end
end
end
end


function UIZongHuiWin:freshRightPanel()
local widget=self.rightpanel:getWidgetBase()
local data=self.zhList[self.selectid]
if data then
self.rightpanel:setActive(true)
local id=data.id
local unlock=data.unlock
local cfg=self.config[id]
local zhdata=self.zhDataList
local ishide=self.inithidelist[id]
local finishtime=0
local jindu=0
if zhdata[id]then
jindu=zhdata[id].param_2
finishtime=zhdata[id].param_4
end


local desc=cfg.desc
widget:SetChildText(rightidx.desc1,desc)


widget:SetChildActive(rightidx.timebg,finishtime>0)
if finishtime>0 then

local str=FMT.fmt("道历{0}年完成",finishtime)
widget:SetChildText(rightidx.time,str)
end


local unlocakdesc=cfg.unlocakdesc
if unlock then
widget:SetChildText(rightidx.desc2,unlocakdesc)
else
local unlock_cdn=cfg.unlock_cdn
local cfg_jindu=unlock_cdn[2]
local str=FMT.fmt('{0}（{1}/{2}）',unlocakdesc,jindu,cfg_jindu)
widget:SetChildText(rightidx.desc2,str)
end


if unlock then
self.controllBtn:setActive(true)
if self.hidelist[id]then
ishide=self.hidelist[id]
end
self:refreshItemControllBtn(ishide)
else
self.controllBtn:setActive(false)
end


local arrWidget=widget:GetChildWidgetBase(rightidx.arrDescItem)
local attrdesc=cfg.attrdesc
for k,v in ipairs(item_Arr)do
local attrtxt=attrdesc[k]
if attrtxt then
arrWidget:SetChildActive(item_Arr[k],true)
if unlock then
arrWidget:SetChildText(item_ArrTxt[k],attrtxt)
else
local str=FMT.fmt('<color=#549327>{0}</color>',attrtxt)
arrWidget:SetChildText(item_ArrTxt[k],str)
end
else
arrWidget:SetChildActive(item_Arr[k],false)
end
end
else
self.rightpanel:setActive(false)
end
end

function UIZongHuiWin:refreshItemControllBtn(ishide)
local isShow=ishide==1
local isNew=ishide==2
self.winlua:SetChildActive(self.controllClose:getID(),not isShow)
self.winlua:SetChildActive(self.controllOpen:getID(),isShow)

local grid=self.taskScroller:getChildScrollViewItemWidget(self.selectid-1)
if grid then
grid:SetChildActive(itemidx.hide,not isShow and not isNew)
grid:SetChildActive(itemidx.new,isNew)
end
end



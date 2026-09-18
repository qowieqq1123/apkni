







def_class("UIXianJieBJFourWin",UIWindowBase)









function UIXianJieBJFourWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.center=UIObject.get(self,2)
self.inputField=UIInputField.get(self,3)
self.Placeholder=UIText.get(self,4)
self.btnpanel=UIObject.get(self,5)
self.Content=UIText.get(self,6)
self.tipsText=UIText.get(self,7)
self.qxbtn=UIButton.get(self,8)
self.tjbtn=UIButton.get(self,9)
self.bjdesc=UIText.get(self,10)
self.listbtn=UIButton.get(self,11)
self.rwScrollView=UIObject.get(self,12)
self.deletbtn=UIButton.get(self,13)
self.xgbtn=UIButton.get(self,14)
self.iconimg=UIImage.get(self,15)
self.icontxt=UIText.get(self,16)
self.idesctxt=UIText.get(self,17)
self.panel3=UIObject.get(self,19)
self.rwScrollView3=UIObject.get(self,20)
self.jumptobtn=UIButton.get(self,21)

self.qxbtn:setButtonClick(function()self:onQxbtn()end)

self.tjbtn:setButtonClick(function()self:onTjbtn()end)

self.listbtn:setButtonClick(function()self:onListbtn()end)

self.deletbtn:setButtonClick(function()self:onDeletbtn()end)

self.xgbtn:setButtonClick(function()self:onXgbtn()end)

self.jumptobtn:setButtonClick(function()self:onJumptobtn()end)



end


function UIXianJieBJFourWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.qxbtn);self.qxbtn=nil;
_UIObject_release(self.tjbtn);self.tjbtn=nil;
_UIObject_release(self.bjdesc);self.bjdesc=nil;
_UIObject_release(self.listbtn);self.listbtn=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.deletbtn);self.deletbtn=nil;
_UIObject_release(self.xgbtn);self.xgbtn=nil;
_UIObject_release(self.iconimg);self.iconimg=nil;
_UIObject_release(self.icontxt);self.icontxt=nil;
_UIObject_release(self.idesctxt);self.idesctxt=nil;
_UIObject_release(self.panel3);self.panel3=nil;
_UIObject_release(self.rwScrollView3);self.rwScrollView3=nil;
_UIObject_release(self.jumptobtn);self.jumptobtn=nil;
end
















local _this
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"
local leftitem=
{
selfitem=0,
icon=1,
select=2,
select2=3,
postxt=4,
desctxt=5,
btn=6,
tag=7,
}




function UIXianJieBJFourWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectIcon=1
self.nowContent=''
self.alllist={}
self.selectidx=0
self.myselectidx=0
end


function UIXianJieBJFourWin:__delete()
self:unbindComponents()
if UIManager:isActive('UIXianJieBJThreeWin')then
UIManager:closeWindow('UIXianJieBJThreeWin')
end
_this=nil
end



function UIXianJieBJFourWin:onQxbtn()
self:closeSelf()
end

function UIXianJieBJFourWin:onDeletbtn()
end

function UIXianJieBJFourWin:onXgbtn()
end

function UIXianJieBJFourWin:onTjbtn()
end

function UIXianJieBJFourWin:onListbtn()
self:showleftpanel()
end

function UIXianJieBJFourWin:onJumptobtn()
local bjdata=self.alllist[self.selectidx]
if bjdata then
local sceneidx=bjdata.sceneidx
local x=bjdata.x
local y=bjdata.y
local func=function()
_this:closeWin()
end
xianjieController:jumpGrid(sceneidx,x,y,func,false)
end
end




function UIXianJieBJFourWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
if argtable then
self.posx=argtable.posx
self.posy=argtable.posy
self.sceneidx=argtable.sceneidx

self.alllist=self:leftsort()
if self.alllist and next(self.alllist)then
for k,v in ipairs(self.alllist)do
if v.x==self.posx and v.y==self.posy and v.sceneidx==self.sceneidx then
self.selectidx=k
self.myselectidx=k
end
end
end
else
self.selectidx=1
end
if self.selectidx==0 then
logErr(FMT.fmt("传入的坐标数据后端35-2没有记录:x:{0},y:{1},sceneidx:{2} ",self.posx,self.posy,self.sceneidx))
return
end

self.jumptobtn:setActive(false)
self:leftdata()
self:rightdata()
if self.selectidx-1>=0 then
self.rwScrollView3:setChildScrollViewSelectItem(self.selectidx-1,false,false,false)
end
end

function UIXianJieBJFourWin:getXJZmData(actorId)
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end
return zmData
end

function UIXianJieBJFourWin:onHide()

end
function UIXianJieBJFourWin:closeWin()
self:closeSelf()
end


function UIXianJieBJFourWin:checklengthover(str,limitnum)
if not str then return''end
if limitnum==8 then
local c=string.toTable(str)
local newstr=''
if c and#c>=limitnum then
newstr=string.format("%s%s%s%s%s%s%s%s...",c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8])
return newstr or str
else
return str
end
end
return str
end

function UIXianJieBJFourWin:leftsort()
local allbjdata=xianjieModel:getRDdata()
local list={}
if allbjdata and next(allbjdata)then
for k,v in pairs(allbjdata)do
if v.icon>0 then
table.insert(list,v)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.guid>b.guid
end)
end
return list
end

function UIXianJieBJFourWin:onLeftBtn(idx)
if idx==self.selectidx then
return
end
local oldidx=self.selectidx
self.selectidx=idx

local grid=self.rwScrollView3:getChildScrollViewItemWidget(idx-1)
if grid then
grid:SetChildActive(leftitem.select,true)
grid:SetChildActive(leftitem.select2,true)
end
local gridold=self.rwScrollView3:getChildScrollViewItemWidget(oldidx-1)
if gridold then
gridold:SetChildActive(leftitem.select,false)
gridold:SetChildActive(leftitem.select2,false)
end
self:rightdata()
end

function UIXianJieBJFourWin:leftdata()
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
local alllist=self.alllist
local len=#alllist
self.rwScrollView3:setChildScrollViewCreateGrids(len,1)
local grids=self.rwScrollView3:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=alllist[i]
item:SetChildCSImageSprite(leftitem.icon,abname,tbarry[data.icon][1])
local posstr=FMT.fmt("<color=#ca631d>({0},{1})</color>",data.x,data.y)
item:SetChildText(leftitem.postxt,posstr)
local descstr=self:checklengthover(data.content,8)
item:SetChildText(leftitem.desctxt,descstr)

item:SetChildActive(leftitem.select,self.selectidx==i)
item:SetChildActive(leftitem.select2,self.selectidx==i)
item:SetChildActive(leftitem.tag,self.myselectidx==i)

item:SetChildButtonClick(leftitem.btn,function()
if _this==nil then return end
self:onLeftBtn(i)
end)
end
end

function UIXianJieBJFourWin:rightdata()
local bjdata=self.alllist[self.selectidx]
self.selectIcon=bjdata.icon
self.nowContent=bjdata.content
local actorid=bjdata.actorid

local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
self.winlua:SetChildCSImageSprite(self.iconimg:getID(),abname,tbarry[self.selectIcon][1])

local str='由仙界祖师标记'
self.idesctxt:setText(self.nowContent)
if actorid then
local zmdata=self:getXJZmData(tostring(actorid))
if zmdata then
str=FMT.fmt("由<color=#ca631d>{0}</color>标记",zmdata.actorname)
end
end
self.icontxt:setText(str)

if self.selectidx==self.myselectidx then
self.jumptobtn:setActive(false)
else
self.jumptobtn:setActive(true)
end
end
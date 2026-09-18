







def_class("UIXianJieBJTwoWin",UIWindowBase)









function UIXianJieBJTwoWin:bindComponents()

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
self.posjumpbtn=UIButton.get(self,11)
self.rwScrollView=UIObject.get(self,12)
self.deletbtn=UIButton.get(self,13)
self.xgbtn=UIButton.get(self,14)
self.rwScrollView2=UIObject.get(self,15)

self.qxbtn:setButtonClick(function()self:onQxbtn()end)

self.tjbtn:setButtonClick(function()self:onTjbtn()end)

self.posjumpbtn:setButtonClick(function()self:onPosjumpbtn()end)

self.deletbtn:setButtonClick(function()self:onDeletbtn()end)

self.xgbtn:setButtonClick(function()self:onXgbtn()end)



end


function UIXianJieBJTwoWin:unbindComponents()
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
_UIObject_release(self.posjumpbtn);self.posjumpbtn=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.deletbtn);self.deletbtn=nil;
_UIObject_release(self.xgbtn);self.xgbtn=nil;
_UIObject_release(self.rwScrollView2);self.rwScrollView2=nil;
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
}




function UIXianJieBJTwoWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectIcon=1
self.nowContent=''
self.alllist={}
self.selectidx=0
end


function UIXianJieBJTwoWin:__delete()
self:unbindComponents()
if UIManager:isActive('UIXianJieBJOneWin')then
UIManager:closeWindow('UIXianJieBJOneWin')
end
_this=nil
end

function UIXianJieBJTwoWin:onTjbtn()
end

function UIXianJieBJTwoWin:onQxbtn()
end


function UIXianJieBJTwoWin:onDeletbtn()
local bjdata=self.alllist[self.selectidx]
if bjdata and bjdata.guid then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXJBJdelettips)
if flag then
xianjieController:send_35_68(bjdata.guid)
_this:closeSelf()
return
end
local str='是否删除当前仙盟标记？'
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
choosetext='今日不再提示',
allowclickBG=false,
okcallback=function(...)
xianjieController:send_35_68(bjdata.guid)

end,
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXJBJdelettips,flag)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function UIXianJieBJTwoWin:onXgbtn()
local content=self.inputField:getInputFieldValue()
local bjdata=self.alllist[self.selectidx]
local bjicon=bjdata.icon
local bjcontent=bjdata.content

if self.selectIcon==bjicon and content==bjcontent then
UIManager.info('标记信息无修改')
return
end

if content==''then
UIManager.info('标记信息不能为空')
return
end
local num=string.lenEx(content)
if num and num>self.limitnum then
UIManager.info('内容超过字数限制')
return
end
if bjdata and bjdata.guid then
local sceneidx=bjdata.sceneidx
local posx=bjdata.x
local posy=bjdata.y
local cbid=bjdata.cbid
xianjieController:send_35_67(bjdata.guid,self.selectIcon,content,sceneidx,posx,posy,cbid)
end
end

function UIXianJieBJTwoWin:onPosjumpbtn()
local bjdata=self.alllist[self.selectidx]
if bjdata then
local sceneidx=bjdata.sceneidx
local x=bjdata.x
local y=bjdata.y
local func=function()
UIManager:closeWindow('UIXianJieBJOneWin')
_this:closeWin()
end

xianjieController:jumpGrid(sceneidx,x,y,func,false)
end
end




function UIXianJieBJTwoWin:onShow(argtable,afterOnloaded)



self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
local cfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"flag")
self.maxnum=cfg[1]
self.limitnum=cfg[2]
self.inputField:setChildInputFieldChange(true,function(...)self:onTextChange(...)end)

self.alllist=self:leftsort()
if argtable then
self.posx=argtable.posx
self.posy=argtable.posy
self.sceneidx=argtable.sceneidx
for k,v in ipairs(self.alllist)do
if v.x==self.posx and v.y==self.posy and v.sceneidx==self.sceneidx then
self.selectidx=k
end
end
if self.selectidx==0 then
self.selectidx=1
end
else
self.selectidx=1
end
if self.selectidx==0 then
logErr(FMT.fmt("传入的坐标数据后端35-2没有记录:x:{0},y:{1},sceneidx:{2} ",self.posx,self.posy,self.sceneidx))
return
end

self:leftdata()
self:rightdata()
if self.selectIcon-1>=0 then
self.rwScrollView:setChildScrollViewSelectItem(self.selectIcon-1,false,false,false)
end
self:bjnumberpanel()
end


function UIXianJieBJTwoWin:onHide()

end
function UIXianJieBJTwoWin:closeWin()
self:closeSelf()
end


function UIXianJieBJTwoWin:onTextChange()
local content=self.inputField:getInputFieldValue()
self.Content:setText(content)
local num=string.lenEx(content)
local str=''
if num>self.limitnum then
str=string.format("<color=#c82c2c>%d</color>/%d字",num,self.limitnum)
else
str=string.format("<color=#ca631d>%d</color>/%d字",num,self.limitnum)
end
self.tipsText:setText(str)
self:checkbtnGray()
end

function UIXianJieBJTwoWin:getbjnumber()
return#self.alllist
end

function UIXianJieBJTwoWin:bjnumberpanel()
local maxnums=self:getbjnumber()
local str=''
if maxnums>=self.maxnum then
str=string.format("已添加标记数：<color=#c82c2c>%d</color>/%d条",maxnums,self.maxnum)
else
str=string.format("已添加标记数：<color=#ca631d>%d</color>/%d条",maxnums,self.maxnum)
end
self.bjdesc:setText(str)
end


function UIXianJieBJTwoWin:seticonpanel()
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
local len=#tbarry
self.rwScrollView:setChildScrollViewCreateGrids(len,len)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
widget:SetChildCSImageSprite(1,abname,tbarry[i][1])
widget:SetChildActive(2,self.selectIcon==i)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
self:onSelectBtn(i)
end)
end
end
function UIXianJieBJTwoWin:onSelectBtn(index)
if index==self.selectIcon then
return
end
local oldIndex=self.selectIcon
self.selectIcon=index

local grid=self.rwScrollView:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildActive(2,true)
end
if oldIndex then
local oldgrid=self.rwScrollView:getChildScrollViewItemWidget(oldIndex-1)
if oldgrid then
oldgrid:SetChildActive(2,false)
end
end
self:checkbtnGray()
end

function UIXianJieBJTwoWin:checkbtnGray()
local isgray=false
local content=self.inputField:getInputFieldValue()
local bjdata=self.alllist[self.selectidx]
local bjicon=bjdata.icon
local bjcontent=bjdata.content
if self.selectIcon==bjicon and content==bjcontent then
isgray=true
end

if content==''then
isgray=true
end
local num=string.lenEx(content)
if num and num>self.limitnum then
isgray=true
end
self.winlua:SetChildGray(self.xgbtn:getID(),isgray)
end


function UIXianJieBJTwoWin:severfresh(flag)
_this:freshdata(flag)
end

function UIXianJieBJTwoWin:freshdata(flag)
if flag==1 then

self.alllist=self:leftsort()
if#self.alllist==0 then
UIManager.info('标记列表数据已全部删除')
self:closeSelf()
return
end
self.selectidx=1
self:leftdata()
self:rightdata()
self:bjnumberpanel()
elseif flag==2 then

if self.selectidx then
local grid=self.rwScrollView2:getChildScrollViewItemWidget(self.selectidx-1)
if grid then
local old_data=self.alllist[self.selectidx]
local new_data=xianjieModel:getRDdataByPos(old_data.x,old_data.y,old_data.sceneidx)
self.alllist[self.selectidx]=new_data
if new_data then
grid:SetChildCSImageSprite(leftitem.icon,abname,new_data.icon)
local descstr=self:checklengthover(new_data.content,8)
grid:SetChildText(leftitem.desctxt,descstr)
end
end
self:rightdata()
end
else

self.alllist=self:leftsort()
if#self.alllist==0 then
UIManager.info('标记列表数据已被全部删除')
self:closeSelf()
return
end
UIManager.info('标记列表数据已更新')
self.selectidx=1
self:leftdata()
self:rightdata()
self:bjnumberpanel()
end
end


function UIXianJieBJTwoWin:checklengthover(str,limitnum)
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

function UIXianJieBJTwoWin:leftsort()
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

function UIXianJieBJTwoWin:leftdata()
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
local alllist=self.alllist
local len=#alllist
self.rwScrollView2:setChildScrollViewCreateGrids(len,1)
local grids=self.rwScrollView2:getChildScrollViewItemWidgets()
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
item:SetChildButtonClick(leftitem.btn,function()
if _this==nil then return end
self:onLeftBtn(i)
end)
end
if self.selectidx-1>=0 then
self.rwScrollView2:setChildScrollViewSelectItem(self.selectidx-1,false,false,false)
end
end

function UIXianJieBJTwoWin:onLeftBtn(idx)
if idx==self.selectidx then
return
end
local oldidx=self.selectidx
self.selectidx=idx

local grid=self.rwScrollView2:getChildScrollViewItemWidget(idx-1)
if grid then
grid:SetChildActive(leftitem.select,true)
grid:SetChildActive(leftitem.select2,true)
end
local gridold=self.rwScrollView2:getChildScrollViewItemWidget(oldidx-1)
if gridold then
gridold:SetChildActive(leftitem.select,false)
gridold:SetChildActive(leftitem.select2,false)
end

self:rightdata()
end

function UIXianJieBJTwoWin:rightdata()
local bjdata=self.alllist[self.selectidx]
self.selectIcon=bjdata.icon
self.nowContent=bjdata.content


self.inputField:setInputFieldValue(self.nowContent or'')
local content=self.nowContent or''
self.Content:setText(content)
local num=string.lenEx(content)
local str=''
if num>self.limitnum then
str=string.format("<color=#c82c2c>%d</color>/%d",num,self.limitnum)
else
str=string.format("<color=#ca631d>%d</color>/%d",num,self.limitnum)
end
self.tipsText:setText(str)
self.winlua:SetChildGray(self.xgbtn:getID(),true)

self:seticonpanel()
end


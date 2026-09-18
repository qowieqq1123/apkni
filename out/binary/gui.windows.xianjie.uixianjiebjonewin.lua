







def_class("UIXianJieBJOneWin",UIWindowBase)









function UIXianJieBJOneWin:bindComponents()

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

self.qxbtn:setButtonClick(function()self:onQxbtn()end)

self.tjbtn:setButtonClick(function()self:onTjbtn()end)

self.listbtn:setButtonClick(function()self:onListbtn()end)

self.deletbtn:setButtonClick(function()self:onDeletbtn()end)

self.xgbtn:setButtonClick(function()self:onXgbtn()end)



end


function UIXianJieBJOneWin:unbindComponents()
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
end
















local _this
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"




function UIXianJieBJOneWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectIcon=1
self.nowContent=''
end


function UIXianJieBJOneWin:__delete()
self:unbindComponents()
_this=nil
end



function UIXianJieBJOneWin:onQxbtn()
self:closeSelf()
end

function UIXianJieBJOneWin:onDeletbtn()
if self.bjdata and self.bjdata.guid then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXJBJdelettips)
if flag then
xianjieController:send_35_68(_this.bjdata.guid)
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
xianjieController:send_35_68(_this.bjdata.guid)
_this:closeSelf()
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

function UIXianJieBJOneWin:onXgbtn()
local content=self.inputField:getInputFieldValue()
if self.bjdata then
local bjicon=self.bjdata.icon
local bjcontent=self.bjdata.content

if self.selectIcon==bjicon and content==bjcontent then
UIManager.info('标记信息无修改')
return
end
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
if self.bjdata and self.bjdata.guid then
xianjieController:send_35_67(self.bjdata.guid,self.selectIcon,content,self.sceneidx,self.posx,self.posy,self.cbid)
self:closeSelf()
end
end

function UIXianJieBJOneWin:onTjbtn()
local content=self.inputField:getInputFieldValue()
if self.bjdata then
local bjicon=self.bjdata.icon
local bjcontent=self.bjdata.content

if self.selectIcon==bjicon and content==bjcontent then
UIManager.info('标记信息无修改')
return
end
end

if content==''then
UIManager.info('标记信息不能为空')
return
end

local maxnums=self:getbjnumber()
if maxnums>=self.maxnum then
UIManager.info('当前可标记数量已达上限，请先删除标记')
return
end
local num=string.lenEx(content)
if num and num>self.limitnum then
UIManager.info('内容超过字数限制')
return
end

xianjieController:send_35_66(self.selectIcon,content,self.sceneidx,self.posx,self.posy,self.cbid)
self:closeSelf()
end

function UIXianJieBJOneWin:onListbtn()
local _posx=self.posx
local _posy=self.posy
local _sceneidx=self.sceneidx
UIManager:showWindow('UIXianJieBJTwoWin',{posx=_posx,posy=_posy,sceneidx=_sceneidx})

end




function UIXianJieBJOneWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
local cfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"flag")
self.maxnum=cfg[1]
self.limitnum=cfg[2]

if argtable then
self.posx=argtable.posx
self.posy=argtable.posy
self.sceneidx=argtable.sceneidx
end
if self.posx and self.posy and self.sceneidx then
self.inputField:setChildInputFieldChange(true,function(...)self:onTextChange(...)end)

self.bjdata=xianjieModel:getRDdataByPos(self.posx,self.posy,self.sceneidx)

local str=''
if self.bjdata then
self.cbid=self.bjdata.cbid
self.selectIcon=self.bjdata.icon
self.nowContent=self.bjdata.content


self.inputField:setInputFieldValue(self.nowContent or'')
local content=self.nowContent or''
self.Content:setText(content)
local num=string.lenEx(content)
if num>self.limitnum then
str=string.format("<color=#c82c2c>%d</color>/%d",num,self.limitnum)
else
str=string.format("<color=#ca631d>%d</color>/%d",num,self.limitnum)
end
self:setbjflag(false)
else
self.cbid=argtable.cbid or-22
str=string.format("<color=#ca631d>%d</color>/%d",0,self.limitnum)
self:setbjflag(true)
end
self.tipsText:setText(str)
self.winlua:SetChildGray(self.tjbtn:getID(),true)
self.winlua:SetChildGray(self.xgbtn:getID(),true)

self:seticonpanel()
if self.selectIcon-1>=0 then
self.rwScrollView:setChildScrollViewSelectItem(self.selectIcon-1,false,false,false)
end
else
logErr(FMT.fmt('传入的标记坐标为nil,x={0},y={1},sceneidx={2}',self.posx,self.posy,self.sceneidx))
end

self:bjnumberpanel()
end


function UIXianJieBJOneWin:onHide()

end
function UIXianJieBJOneWin:closeWin()
self:closeSelf()
end


function UIXianJieBJOneWin:setbjflag(flag)
self.qxbtn:setActive(flag)
self.tjbtn:setActive(flag)
self.deletbtn:setActive(not flag)
self.xgbtn:setActive(not flag)
end


function UIXianJieBJOneWin:onTextChange()
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


function UIXianJieBJOneWin:getbjnumber()
local allbjdata=xianjieModel:getRDdata()
local num=0
if allbjdata and next(allbjdata)then
for k,v in pairs(allbjdata)do
if v.icon>0 then
num=num+1
end
end
end
return num
end

function UIXianJieBJOneWin:bjnumberpanel()
local maxnums=self:getbjnumber()
local str=''
if maxnums>=self.maxnum then
str=string.format("已添加标记数：<color=#c82c2c>%d</color>/%d条",maxnums,self.maxnum)
else
str=string.format("已添加标记数：<color=#ca631d>%d</color>/%d条",maxnums,self.maxnum)
end
self.bjdesc:setText(str)
self.listbtn:setActive(maxnums>1)
end


function UIXianJieBJOneWin:seticonpanel()
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
function UIXianJieBJOneWin:onSelectBtn(index)
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


function UIXianJieBJOneWin:checkbtnGray()
local isgray=false
local content=self.inputField:getInputFieldValue()
if self.bjdata then
local bjicon=self.bjdata.icon
local bjcontent=self.bjdata.content
if self.selectIcon==bjicon and content==bjcontent then
isgray=true
end

end
if content==''then
isgray=true
end
local num=string.lenEx(content)
if num and num>self.limitnum then
isgray=true
end
self.winlua:SetChildGray(self.tjbtn:getID(),isgray)
self.winlua:SetChildGray(self.xgbtn:getID(),isgray)
end


function UIXianJieBJOneWin:severfresh()
_this:freshdata()
end


function UIXianJieBJOneWin:freshdata()
self.bjdata=xianjieModel:getRDdataByPos(self.posx,self.posy,self.sceneidx)
if self.bjdata then
self.selectIcon=self.bjdata.icon
self.nowContent=self.bjdata.content
self.inputField:setInputFieldValue(self.nowContent or'')
self:onTextChange()
self:setbjflag(false)
else
self:setbjflag(true)
end
self:checkbtnGray()


local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
widget:SetChildActive(2,self.selectIcon==i)
end

self:bjnumberpanel()
end

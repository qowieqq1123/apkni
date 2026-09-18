







def_class("UIXianJieRecordWin",UIWindowBase)









function UIXianJieRecordWin:bindComponents()

self.uiPanel=UIObject.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.item1=UIObject.get(self,4)
self.item2=UIObject.get(self,5)
self.item3=UIObject.get(self,6)
self.item4=UIObject.get(self,7)
self.taskScroller=UIObject.get(self,8)
self.alldeletbtn=UIButton.get(self,9)
self.alldetxt=UIText.get(self,10)
self.allgoubtn=UIButton.get(self,11)
self.nogimg=UIObject.get(self,12)
self.gimg=UIObject.get(self,13)
self.dlpanel=UIObject.get(self,14)
self.itempanel=UIObject.get(self,15)
self.monterpanel=UIObject.get(self,16)
self.noImgs=UIObject.get(self,17)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.alldeletbtn:setButtonClick(function()self:onAlldeletbtn()end)

self.allgoubtn:setButtonClick(function()self:onAllgoubtn()end)



end


function UIXianJieRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.alldeletbtn);self.alldeletbtn=nil;
_UIObject_release(self.alldetxt);self.alldetxt=nil;
_UIObject_release(self.allgoubtn);self.allgoubtn=nil;
_UIObject_release(self.nogimg);self.nogimg=nil;
_UIObject_release(self.gimg);self.gimg=nil;
_UIObject_release(self.dlpanel);self.dlpanel=nil;
_UIObject_release(self.itempanel);self.itempanel=nil;
_UIObject_release(self.monterpanel);self.monterpanel=nil;
_UIObject_release(self.noImgs);self.noImgs=nil;
end
















local _this
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"
local s_name=
{
[1]="icon_xianjie_tese",
[2]="icon_xianjie_youhao",
[3]="icon_xianjie_didui",
}
local itemidx=
{
bg=1,
selimng=2,
btn=3,
txt=4,
}
local dataidx=
{
icon=1,
name=2,
desc1=3,
desc2=4,
timetxt=5,
chenkbtn=6,
nogou=7,
gou=8,
jumpbtn=9,
delbtn=10,
xiugaibtn=11,
sharebtn=12,
}



function UIXianJieRecordWin:onLoaded(...)
_this=self
self:bindComponents()
self.topitems={self.item1,self.item2,self.item3,self.item4}
self.selectidx=1
self.gxlist={}
self.gxlistnum=0
self.isallselect=false
end


function UIXianJieRecordWin:__delete()
self:unbindComponents()
self.gxlist={}
self.gxlistnum=0
_this=nil
end




function UIXianJieRecordWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:playEnterAnim()
end
self.selectidx=1
self.gxlist={}
self.gxlistnum=0
self.isallselect=false
self.nowtime=timeHelper.getServerShortTime()
self:initTopInfo()
self:showDeletePanel()
self.gimg:setActive(self.isallselect)
self:freshdata()

end

function UIXianJieRecordWin:onHide()

end

function UIXianJieRecordWin:onMaskBlock()
if _this==nil then return end
if self.closeLock then return end
self:onCloseBtn()
end

function UIXianJieRecordWin:onCloseBtn()
if _this==nil then return end
if self.closeLock then return end
self:playLeaveAnim()
end

function UIXianJieRecordWin:playEnterAnim()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(1,0.2,nil)
end
function UIXianJieRecordWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end



function UIXianJieRecordWin:initTopInfo()
for k,v in ipairs(self.topitems)do
local widget=v:getWidgetBase()
if self.selectidx==k then
widget:SetChildActive(itemidx.selimng,true)
else
widget:SetChildActive(itemidx.selimng,false)
end
widget:SetChildText(itemidx.txt,xianjie_RecordName[k-1]or"")
widget:SetChildButtonClick(itemidx.btn,function()
self:onSelectBtn(k)
end)
end
end

function UIXianJieRecordWin:freshdata()
local list=self:getSortList(self.selectidx)
self.AllDatalist=list
local dataNum=#list
if dataNum>0 then


self.noImgs:setActive(false)
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local _data=list[i]
local specialtype=_data[5]
local ishujian=_data[9]
item:SetChildCSImageSprite(dataidx.icon,abname,s_name[specialtype])
item:SetChildText(dataidx.name,_data[4]or"")


local scentype=_data[1]
local sname=""
if scentype==1 then
sname="仙界"
elseif scentype==2 then
sname="魔界"
else
sname="仙域"
end
item:SetChildText(dataidx.desc1,sname)


local posstr=FMT.fmt("({0}，{1})",_data[2],_data[3])
item:SetChildText(dataidx.desc2,posstr)


local curTime=_data[6]or 0

local timetxt=FMT.fmt('{0}前',timeHelper.format_time_stamp3(self.nowtime-curTime))
item:SetChildText(dataidx.timetxt,timetxt)


local nowkey=self:getKey(scentype,_data[2],_data[3])
if self.gxlist[nowkey]then
item:SetChildActive(dataidx.gou,true)
else
item:SetChildActive(dataidx.gou,false)
end


if not ishujian then
item:SetChildActive(dataidx.sharebtn,false)
end


item:SetChildButtonClick(dataidx.jumpbtn,function()
if _this==nil then return end
self:jumpbtn(i,scentype,_data[2],_data[3],_data[7])
end)

item:SetChildButtonClick(dataidx.delbtn,function()
if _this==nil then return end
self:deletebtn(i,scentype,_data[2],_data[3],_data[4])
end)

item:SetChildButtonClick(dataidx.xiugaibtn,function()
if _this==nil then return end
self:xiugaibtn(i,scentype,_data[2],_data[3],_data[8],_data[7],_data[9])
end)

item:SetChildButtonClick(dataidx.sharebtn,function()
if _this==nil then return end
self:sharebtn(i,scentype,_data[2],_data[3],_data[8],_data[7])
end)

item:SetChildButtonClick(dataidx.chenkbtn,function()
if _this==nil then return end
self:checkbtn(item,i,scentype,_data[2],_data[3])
end)
end
end
else


self.noImgs:setActive(true)
self.taskScroller:setActive(false)
end
end

function UIXianJieRecordWin:getSortList(selectidx)
local templist={}
local alllist=xianjieController:getXJPointRecordData()
if selectidx==1 then
templist=table.weakCopy(alllist)
else
local specialtype=selectidx-1
for k,v in ipairs(alllist)do
if v[5]and v[5]==specialtype then
templist[#templist+1]=v
end
end
end

if templist and#templist>1 then
table.sort(templist,function(a,b)
return a[6]>b[6]
end)
end

return templist
end


function UIXianJieRecordWin:allfreshupdata()
_this.gxlist={}
_this.gxlistnum=0
_this.isallselect=false
_this:showDeletePanel()
_this:freshdata()
end

function UIXianJieRecordWin:onefreshupdata(arg)
if arg then
local nowkey=_this:getKey(arg[1],arg[2],arg[3])
_this:setKey(nowkey,false)
_this:showDeletePanel()
_this:freshdata()
end
end

function UIXianJieRecordWin:onefreshxiugai(arg)
local index=arg[1]
local _data=arg[2]
if index and _data then
_this.nowtime=timeHelper.getServerShortTime()
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local item=grids[index-1]
if item then

local specialtype=_data[5]
item:SetChildCSImageSprite(dataidx.icon,abname,s_name[specialtype])
item:SetChildText(dataidx.name,_data[4]or"")

local posstr=FMT.fmt("({0}，{1})",_data[2],_data[3])
item:SetChildText(dataidx.desc2,posstr)

local curTime=_data[6]or 0
local num=(_this.nowtime-curTime)<1 and 1 or _this.nowtime-curTime
local timetxt=FMT.fmt('{0}前',timeHelper.format_time_stamp3(num))
item:SetChildText(dataidx.timetxt,timetxt)
end
end
end


function UIXianJieRecordWin:onSelectBtn(index)
if self.selectidx==index then
return
end
local oldidx=self.selectidx
self.selectidx=index

if self.topitems[oldidx]then
local oldwidget=self.topitems[oldidx]:getWidgetBase()
oldwidget:SetChildActive(itemidx.selimng,false)
end
if self.topitems[self.selectidx]then
local widget=self.topitems[self.selectidx]:getWidgetBase()
widget:SetChildActive(itemidx.selimng,true)
end
self:allfreshupdata()
end

function UIXianJieRecordWin:jumpbtn(index,sceneType,gridX,gridZ,Point_Share)
local sceneidx=xianjieModel:getSceneIndex(sceneType)
local func=function()














end

xianjieController:jumpGrid(sceneidx,gridX,gridZ,func,true)
end

function UIXianJieRecordWin:deletebtn(index,sceneType,gridX,gridZ,_name)


local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("你确定删除记录名称为 <color=#7d3b17>“{0}”</color> 的地点吗？",_name),
oktext='确认',
canceltext='取消',
okcallback=function(...)
if _this==nil then return end

xianjieController:deletePointRecordData(sceneType,gridX,gridZ)
end,
showclosebtn=false,
}
self.comDialog=UIDialogManager.newDialog(showdata)
self.comDialog:show()
end

function UIXianJieRecordWin:xiugaibtn(index,sceneType,gridX,gridZ,sharename,Point_Share,ishujian)
local temp=
{
gridX=gridX,
gridZ=gridZ,
exidex=index,
Point_Share=Point_Share,
nameStr=sharename,
sharename=sharename,
ishujian=ishujian,
}
self:showWindow("UIXianJieRecAddWin",temp)

end

function UIXianJieRecordWin:sharebtn(index,sceneType,gridX,gridZ,sharename,Point_Share)
local data=
{
x=gridX,
y=gridZ,
icon1="icon_sjgdbiaoshi_1",
msgName=sharename,
shareType=Point_Share,
scenceType=sceneType,
name=sharename,
shareName=sharename,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end


function UIXianJieRecordWin:checkbtn(item,index,sceneType,gridX,gridZ)
local nowkey=self:getKey(sceneType,gridX,gridZ)
if self.gxlist[nowkey]then
item:SetChildActive(dataidx.gou,false)
self:setKey(nowkey,false)
self.isallselect=false
self.gimg:setActive(self.isallselect)
else
item:SetChildActive(dataidx.gou,true)
self:setKey(nowkey,true)
end

self:showDeletePanel()
end

function UIXianJieRecordWin:onAllgoubtn()
self.isallselect=not self.isallselect
self.gimg:setActive(self.isallselect)
if self.AllDatalist then
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=self.AllDatalist[i]
local nowkey=self:getKey(data[1],data[2],data[3])
if self.isallselect then
item:SetChildActive(dataidx.gou,true)
self:setKey(nowkey,true)
else
item:SetChildActive(dataidx.gou,false)
self:setKey(nowkey,false)
end
end
end
local str=FMT.fmt("删除所选({0})",self.gxlistnum)
self.alldetxt:setText(str)
end
end

function UIXianJieRecordWin:onAlldeletbtn()
if self.gxlist and next(self.gxlist)then
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("你确定删除<color=#7d3b17>{0}个</color>选中的记录地点吗？",_this.gxlistnum),
oktext='确认',
canceltext='取消',
okcallback=function(...)
if _this==nil then return end

xianjieController:deleteManeyPointRecordData(_this.gxlist)
end,
showclosebtn=false,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end
end


function UIXianJieRecordWin:showDeletePanel()
if self.gxlist and next(self.gxlist)then
self.dlpanel:setActive(true)
self.taskScroller:setChildSizeDelta(472,428)
local str=FMT.fmt("删除所选({0})",self.gxlistnum)
self.alldetxt:setText(str)
self.gimg:setActive(self.isallselect)
else
self.dlpanel:setActive(false)
self.taskScroller:setChildSizeDelta(472,500)
self.alldetxt:setText("删除所选")
end
end
function UIXianJieRecordWin:getKey(sceneType,gridX,gridZ)
return FMT.fmt("{0}_{1}_{2}",sceneType,gridX,gridZ)
end
function UIXianJieRecordWin:setKey(_key,type)
if type then
if not self.gxlist[_key]then
self.gxlist[_key]=1
self.gxlistnum=self.gxlistnum+1
end
else
if self.gxlist[_key]then
self.gxlist[_key]=nil
self.gxlistnum=self.gxlistnum-1
end
end
end










def_class("UIXianjieXSzongmenWin",UIWindowBase)









function UIXianjieXSzongmenWin:bindComponents()

self.root=UIObject.get(self,0)
self.paiqianBtn=UIButton.get(self,1)
self.taskScrollerView=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)

self.paiqianBtn:setButtonClick(function()self:onPaiqianBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianjieXSzongmenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.paiqianBtn);self.paiqianBtn=nil;
_UIObject_release(self.taskScrollerView);self.taskScrollerView=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _this
local zmitemIdx=
{
zmitem=0,
root=1,
icon=2,
name=3,
btn=4,
desc=5,
select=6,
tz=7,
progress=8,
progresstxt=9,
lvl=10,
tzimg=11,
}



function UIXianjieXSzongmenWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectid=1
self.zmGuid=0
end


function UIXianjieXSzongmenWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianjieXSzongmenWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.taskIndex=argtable.taskIndex
self.taskId=argtable.taskId
local cfg=cfg_zongmenxuanshangtaskbaseconfig_get(1)

self.xjxstFreeNum=cfg.xjxstFreeNum
self.xjxstFeeNum=cfg.xjxstFeeNum
self.xjxstTaskItem=cfg.xjxstTaskItem
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5728,1,nil,eAnimationID.stand)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
self.oldzmGuid=nil
local old=XianjieXuanShangModel:getTaskDataSinglebyIndex(self.taskIndex)
if old and old.zmGuid then
self.oldzmGuid=old.zmGuid
end
self:initinfo()
end


function UIXianjieXSzongmenWin:onHide()

end


function UIXianjieXSzongmenWin:oncloseClick()
self:closeSelf()
end

function UIXianjieXSzongmenWin:onClickTeDianItem(item,tzcfg,isgray,idx,bigidx,len)



local args={}
args.posWidget=item
local name=tzcfg.name
local framecolor=tzcfg.framecolor
local desc={tzcfg.desc}
args.title=name
args.framecolor=framecolor
args.desclist=desc
if bigidx>4 and bigidx==len then
args.pivot=Vector2(1,0)
else
args.pivot=Vector2(0,0)
end
UIManager:showWindow('UIDescribeTips2',args)
end

function UIXianjieXSzongmenWin:onPaiqianBtn()
local nowfree=XianjieXuanShangModel:getfreeNumUse()
if nowfree<self.xjxstFreeNum then

local firsttaskId=XianjieXuanShangModel:getTaskIdbyIdx(self.taskIndex)
if firsttaskId==0 then
XianjieXuanShangController:send_7_56(self.taskId,self.zmGuid,self.taskIndex)
else
if firsttaskId==self.taskId then
local list={self.taskId}
XianjieXuanShangController:send_7_59(#list,list)
else
XianjieXuanShangController:send_7_56(self.taskId,self.zmGuid,self.taskIndex)
end
end
XianjieXuanShangController:closeXJXSwin()
else
local nowUse=XianjieXuanShangModel:getfeeNumUse()
if nowUse<self.xjxstFeeNum then
local costItemId=self.xjxstTaskItem[1][1]
local costItemNum=self.xjxstTaskItem[1][2]
local bagcount=itemsModel.getCount(costItemId)
local content="是否确认消耗{0}x<color=#7d3b17>{1}</color>执行<color=#7d3b17>{2}</color>次任务？\n\n剩余额外任务次数：<color=#7d3b17>{3}</color>"
local itemIconName=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
content=FMT.fmt(content,iconStr,costItemNum,1,self.xjxstFeeNum-nowUse)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function(...)
if bagcount<costItemNum then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(costItemId)))
gainControl:showGainWin(costItemId)
else
local firsttaskId=XianjieXuanShangModel:getTaskIdbyIdx(self.taskIndex)
if firsttaskId==0 then
XianjieXuanShangController:send_7_56(self.taskId,self.zmGuid,self.taskIndex)
else
if firsttaskId==self.taskId then
local list={self.taskId}
XianjieXuanShangController:send_7_59(#list,list)
else
XianjieXuanShangController:send_7_56(self.taskId,self.zmGuid,self.taskIndex)
end
end
end
XianjieXuanShangController:closeXJXSwin()
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
UIManager.info("每日接取任务次数已达上限")
end
end
end

function UIXianjieXSzongmenWin:onChooseBtn(index,zmGuid)
if self.selectid==index then
return
end
local oldselect=self.selectid
self.selectid=index
self.zmGuid=zmGuid

local grids=self.taskScrollerView:getChildScrollViewItemWidgets()
if grids then
local olditem=grids[oldselect-1]
if olditem then
olditem:SetChildActive(zmitemIdx.select,false)
end
local newitem=grids[self.selectid-1]
if newitem then
newitem:SetChildActive(zmitemIdx.select,true)
end
end
end

function UIXianjieXSzongmenWin:initinfo()
local taskId=self.taskId
local taskcfg=cfg_xianjiexuanshangtaskconfig_get(taskId)
local zmlsit2=XianjieXuanShangController:getAllWorldZMdata(self.oldzmGuid)
local zmlsit=self:SortZmList(zmlsit2)
local len=#zmlsit
self.taskScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.taskScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for idx=1,count do
local widget=grids[idx-1]
local infoData=zmlsit[idx]
local serial=infoData.serial

local name=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
local icon=systemZongMenModel:getIconName(infoData.id,infoData.level)
widget:SetChildText(zmitemIdx.name,name)
widget:SetChildCSImageIcon(zmitemIdx.icon,icon,false)
widget:SetChildActive(zmitemIdx.select,self.selectid==idx)
if self.selectid==idx then
self.zmGuid=serial
end


local xs_level=infoData.xs_level
if xs_level<=0 then xs_level=1 end
local xs_exp=infoData.xs_exp

widget:SetChildText(zmitemIdx.lvl,FMT.fmt("宗门等级：{0}级",xs_level))
local lvlcfg=cfg_syssectxslvconfig_get(xs_level)
local nextexp=lvlcfg.exp
if nextexp then

widget:SetChildUIProgressbar(zmitemIdx.progress,xs_exp,nextexp,false)
widget:SetChildText(zmitemIdx.progresstxt,FMT.fmt("{0}/{1}",xs_exp,nextexp))
else
widget:SetChildUIProgressbar(zmitemIdx.progress,1,1,false)
widget:SetChildText(zmitemIdx.progresstxt,"已满级")
end


local ishavetz=false
local istzvalue
local xtzmtzItem=XianjieXuanShangModel:getZMtezhiDatabyGuid(infoData.id)

if xtzmtzItem then
local tzList=xtzmtzItem
if tzList then
widget:SetChildScrollViewCreateGrids(zmitemIdx.tz,#tzList,#tzList)
local grids2=widget:GetChildScrollViewItemWidgets(zmitemIdx.tz)
local count2=grids2.Count
for i=1,count2 do
local item=grids2[i-1]
local tzid=tzList[i]
local tzcfg=cfg_syssecttzconfig_get(tzid)
local xstTaskIdlist=tzcfg.xstTaskId
local isgray=false
if xstTaskIdlist[taskId]~=1 then
isgray=true
else
ishavetz=true
istzvalue=tzcfg.tezhijc
end
local framecolor=tzcfg.framecolor

local _name=tzcfg.name
_name=UIDiscipleModel.getSpecialityNameStr(_name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(framecolor)
item:SetChildCSImageSprite(0,abName,frameIcon)
item:SetChildGray(0,isgray)
item:SetChildText(1,_name)

item:SetChildButtonClick(0,function()
if _this==nil then return end
self:onClickTeDianItem(item,tzcfg,isgray,i,idx,len)
end)
end

widget:SetChildActive(zmitemIdx.tzimg,ishavetz)


if taskcfg.jcitemid then
local uptxt

local str=taskcfg.jcitemid
local xstTaskAdd=lvlcfg.xstTaskAdd
local value=xstTaskAdd[taskId]
if istzvalue then
if not value then
value=0
end
value=value+istzvalue
end
if value>0 then
uptxt=FMT.fmt("{0}+{1}%",str,value*100)
end
if uptxt then
widget:SetChildActive(zmitemIdx.desc,true)
widget:SetChildText(zmitemIdx.desc,uptxt)
else
widget:SetChildActive(zmitemIdx.desc,false)
end
end
end
end


widget:SetChildButtonClick(zmitemIdx.btn,function()
if _this==nil then return end
self:onChooseBtn(idx,serial)
end)
end
end

function UIXianjieXSzongmenWin:SortZmList(zmlist)
if#zmlist>1 then
local taskId=self.taskId
for k,v in ipairs(zmlist)do
local infoData=v
local ishavetz=0
local istzvalue=0
local xs_level=infoData.xs_level or 0
local xtzmtzItem=XianjieXuanShangModel:getZMtezhiDatabyGuid(infoData.id)
if xtzmtzItem then
local tzList=xtzmtzItem
if tzList then
for i=1,#tzList do
local tzid=tzList[i]
local tzcfg=cfg_syssecttzconfig_get(tzid)
local framecolor=tzcfg.framecolor
local xstTaskIdlist=tzcfg.xstTaskId
if xstTaskIdlist[taskId]~=1 then
else
ishavetz=framecolor
istzvalue=tzcfg.tezhijc or 0

local lvlcfg=cfg_syssectxslvconfig_get(xs_level)
if lvlcfg and lvlcfg.xstTaskAdd then
local value=lvlcfg.xstTaskAdd[taskId]or 0
istzvalue=istzvalue+value
end

end
end
end
end
v.pxsort=ishavetz*100000+istzvalue*10000+xs_level
end

table.sort(zmlist,function(a,b)
return a.pxsort>b.pxsort
end)
end
return zmlist
end

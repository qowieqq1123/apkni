







def_class("UIXMKuFangRJWin",UIWindowBase)









function UIXMKuFangRJWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.donateScroller=UILoopListView.new(self,1)
self.funcItem_1=UIBaseItem.get(self,2)
self.funcItem_2=UIBaseItem.get(self,3)
self.funcItem_3=UIBaseItem.get(self,4)
self.funcList=UIObject.get(self,5)
self.menu_1=UIButton.get(self,6)
self.menu_2=UIButton.get(self,7)
self.menuList=UIObject.get(self,8)
self.noItemTips=UIText.get(self,9)
self.noItemTipsTxt=UIText.get(self,10)
self.root=UIObject.get(self,11)
self.taskScroller=UILoopListView.new(self,12)
self.tipIcon=UIImage.get(self,13)
self.tipsTxt=UIText.get(self,14)
self.tipsTxt2=UIText.get(self,15)
self.titleTxt=UIText.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.donateScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.menu_1:setButtonClick(function()self:onMenu_1()end)

self.menu_2:setButtonClick(function()self:onMenu_2()end)

self.taskScroller:bindLoopListView(function(...)
self:onFreshAction_2(...)
end,function(...)
self:onStartAction_2(...)
end)self.funcItem={
self.funcItem_1,
self.funcItem_2,
self.funcItem_3,
}
self.menu={
self.menu_1,
self.menu_2,
}



end


function UIXMKuFangRJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.donateScroller:deleteSelf();self.donateScroller=nil;
_UIObject_release(self.funcItem_1);self.funcItem_1=nil;
_UIObject_release(self.funcItem_2);self.funcItem_2=nil;
_UIObject_release(self.funcItem_3);self.funcItem_3=nil;
_UIObject_release(self.funcList);self.funcList=nil;
_UIObject_release(self.menu_1);self.menu_1=nil;
_UIObject_release(self.menu_2);self.menu_2=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.noItemTipsTxt);self.noItemTipsTxt=nil;
_UIObject_release(self.root);self.root=nil;
self.taskScroller:deleteSelf();self.taskScroller=nil;
_UIObject_release(self.tipIcon);self.tipIcon=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.tipsTxt2);self.tipsTxt2=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
self.funcItem=nil;
self.menu=nil;
end

















local _menuTypeEnum={
log=1,
donate=2,
}


local _funcTypeEnum={
today=1,
yesterday=2,
b_yesterday=3,
}

local body_id={
back=2016,
menu=2017,
}
local menu_slot_name='button_dytab'

local getMenuAttchmentName=function(isSelect)
local name
if isSelect then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
return name
end

local _this

local abNmae="ui/windows/xianmeng/xianmengkufang_atlas_pak.ab"
local iocnTypeName={
'image_xianmengkufang_wz2',
'image_xianmengkufang_wz3',
'image_xianmengkufang_wz4',
}

function UIXMKuFangRJWin:onLoaded(...)
self:bindComponents()
_this=self

self.selectFuncIdx=_funcTypeEnum.today
self.selectMenuIdx=_menuTypeEnum.log

local _recv_20_148=function(...)
if _this==nil then return end
self:recv_20_148(...)
end
self:addProNotify(20,148,_recv_20_148)
end


function UIXMKuFangRJWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXMKuFangRJWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
xianmengController:req_XianMeng_DonationStatistics()
end

self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)

self:refreshAll()

if xianmengModel:checkShowOpenInfo()then
UIManager.info("新的一天已开始，捐赠记录已更新")
xianmengModel:writeOpenDonateWinTime()
end
end


function UIXMKuFangRJWin:onHide()

end


function UIXMKuFangRJWin:refreshAll()
self:freshFuncList()
self:freshMenuList()
self:freshFuncPanel()
end





function UIXMKuFangRJWin:onCloseBtn()
self:closeSelf()
end


function UIXMKuFangRJWin:refreshKuFangJXPanel()
local info=xianmengModel:getXMJuanXianLogData()
local temp={}
if info and next(info)~=nil then
local temp2={}
for i=#info,1,-1 do
temp2[#temp2+1]=info[i]
end
for k,v in ipairs(temp2)do
if v.jsonStr then
local argsstr=jsonHelper.decode(v.jsonStr)
temp[#temp+1]={str=argsstr,logType=v.logType}
end
end
end

local isNotEmpty=#temp>0

self.taskScroller:setActive(isNotEmpty)
self.noItemTips:setActive(not isNotEmpty)

if isNotEmpty then
_this.taskScroller:initData("pinturewardItem",temp)
end
end



function UIXMKuFangRJWin:onFreshAction_2(index,widget,data)
local item=widget
local cfg=cfg_xianmengjuanxianlogconfig()
if data.logType and data.str then
local logType=data.logType

local logtable=cfg[logType].log

local name=data.str[1]
local zmNmae=data.str[2]



if logType==1 then
local cfg_str_zm=logtable[1]
local cfg_str=logtable[2]
local itemId=tonumber(data.str[3]or 1)
local itemnum=tonumber(data.str[4]or 0)
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local str=FMT.fmt("{0}枚{1}",itemnum,itemConfig.name)
local item_name=FMT.cfmt(color,str)
local string=""
if type(zmNmae)~="string"or zmNmae==""then
string=FMT.fmt(cfg_str,name,item_name)
item:SetChildText(1,string)
else
string=FMT.fmt(cfg_str_zm,name,zmNmae,item_name)
item:SetChildText(1,string)
end
elseif logType==2 then
local costItemList=data.str[3]or{}
local getItemList=data.str[4]or{}
local posName=data.str[6]or""
local cfg_str=logtable[1]
local costStr=""
for i,v in ipairs(costItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#costItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
costStr=costStr..item_name
end
local getStr=""
for i,v in ipairs(getItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#getItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
getStr=getStr..item_name
end
local endStr=FMT.fmt(cfg_str,posName,name,costStr,getStr)
item:SetChildText(1,endStr)
elseif logType==3 then
local fpItemList=data.str[3]or{}
local targetName=data.str[4]or""
local posName=data.str[6]or""
local cfg_str=logtable[1]
local fpStr=""
for i,v in ipairs(fpItemList)do
local itemId=v[1]
local itemnum=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local onestr=FMT.fmt(i==#fpItemList and"{0}*{1}"or"{0}*{1}、",itemConfig.name,itemnum)
local item_name=FMT.cfmt(color,onestr)
fpStr=fpStr..item_name
end
local endStr=FMT.fmt(cfg_str,posName,name,fpStr,targetName)
item:SetChildText(1,endStr)
end

item:SetChildCSImageSprite(0,abNmae,iocnTypeName[data.logType])
item:ForceLayoutVertical(1)
local txtY=item:GetChildRectHeight(1)
local itemHiget=txtY+30
item:SetChildSizeDelta(2,638,itemHiget)
local time=data.str[5]
if time then
local timeStr=timeHelper.getFormatByShortStamp(time)



item:SetChildText(3,timeStr)
else
item:SetChildText(3,"")
end

end

end


function UIXMKuFangRJWin:onStartAction_2()
end


local _posColor={"#ca631d","#ca631d","#6833c0","#549327"}
local _nameColor="#7d3b17"
function UIXMKuFangRJWin:onFreshAction(index,widget,data)
local itemList=data.itemList
local itemLen=table.numsEx(itemList)

local itemSortList=data.itemSortList or{}

if not next(itemSortList)then
data.itemSortList=itemSortList

for itemid,itemnum in pairs(itemList)do
itemSortList[#itemSortList+1]={itemid,itemnum}
end

if#itemSortList>1 then

table.sort(itemSortList,function(a,b)
return a[1]>b[1]
end)
end
end

local name=data.menberData.actorname

local pos=xianmengModel:getXMMemberPost(data.menberData.actorid)
local posname=xianmengModel.getXMPostName(pos,true)



local desc=string.format("<color=%s>%s</color>",_nameColor,name)
local itemListDesc
if itemLen==0 then
desc=string.format("%s 尚未进行捐献",desc)
elseif itemLen>0 then
itemListDesc=""
itemList={}

local itemName,itemColor,onestr
for index,itemData in ipairs(itemSortList)do
itemColor=itemsConfig.getItemColor(itemData[1])
itemName=itemsConfig.getItemName(itemData[1])
onestr=FMT.fmt(index==#itemSortList and"{0}*{1}"or"{0}*{1}、",itemName,tostring(itemData[2]))
itemListDesc=string.format("%s%s",itemListDesc,FMT.cfmt(itemColor,onestr))
end
desc=string.format("%s累计捐赠了 %s",desc,itemListDesc)
end

widget:SetChildText(2,posname)
widget:SetChildText(0,desc)

widget:ForceLayoutVertical(0)
local txtY=widget:GetChildRectHeight(0)
local itemHiget=txtY+30
widget:SetChildSizeDelta(1,638,itemHiget)
end

function UIXMKuFangRJWin:onStartAction()
end



function UIXMKuFangRJWin:freshMenuList()
local selectMenuIdx=self.selectMenuIdx

local func2=function(index,animWiget)
local isSelect=selectMenuIdx==index
local name=getMenuAttchmentName(isSelect)

animWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,name)
end

for i,v in ipairs(self.menu)do
local anim=self.menu[i]
local animWiget=anim:getWidgetBase()
local cb=function()
func2(i,animWiget)
end
animWiget:SetChildUIModelShowTarget(0,body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,cb)
end
end

function UIXMKuFangRJWin:onClickMenu(index)
local preAnim=_this.menu[_this.selectMenuIdx]
local preAnimWiget=preAnim:getWidgetBase()
local preName=getMenuAttchmentName(false)
preAnimWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,preName)

_this.selectMenuIdx=index
local anim=_this.menu[_this.selectMenuIdx]
local animWiget=anim:getWidgetBase()
local name=getMenuAttchmentName(true)
animWiget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
animWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,name)

self.selectFuncIdx=_funcTypeEnum.today

self:freshFuncPanel()
end

function UIXMKuFangRJWin:onMenu_1()
if self.selectMenuIdx==_menuTypeEnum.log then return end
self:onClickMenu(_menuTypeEnum.log)
end



function UIXMKuFangRJWin:onMenu_2()
if self.selectMenuIdx==_menuTypeEnum.donate then return end
self:onClickMenu(_menuTypeEnum.donate)
end







function UIXMKuFangRJWin:freshFuncList()
local widget
for idx,item in ipairs(self.funcItem)do
widget=item:getWidgetBase()

widget:SetChildActive(0,self.selectFuncIdx==idx)

widget:SetBaseItemClickEvent(-1,function(...)
self:onClickFunc(idx)
end)
end
end

function UIXMKuFangRJWin:freshFuncPanel()
local isShowLog=self.selectMenuIdx==_menuTypeEnum.log
local isShowDonate=self.selectMenuIdx==_menuTypeEnum.donate

self.taskScroller:setActive(self.selectMenuIdx==_menuTypeEnum.log)
self.donateScroller:setActive(self.selectMenuIdx==_menuTypeEnum.donate)
self.funcList:setActive(self.selectMenuIdx==_menuTypeEnum.donate)

if isShowLog then
self.titleTxt:setText("库房记录")
self:refreshKuFangJXPanel()
elseif isShowDonate then
self.titleTxt:setText("捐赠记录")
self:refreshDonatePanel()
end
end

function UIXMKuFangRJWin:refreshDonatePanel()
local donateItemList=xianmengModel:get_DonationStatistics_Log_DayType_Sort_List(self.selectFuncIdx)

local isNotEmpty=false
for index,data in ipairs(donateItemList)do
if data.hasItemNum>0 then
isNotEmpty=true
break
end
end

self.noItemTips:setActive(not isNotEmpty)
self.donateScroller:setActive(isNotEmpty)

if isNotEmpty then
self.donateScroller:initData("logItem",donateItemList)
end
end

function UIXMKuFangRJWin:onClickFunc(index)
local pItem=self.funcItem[self.selectFuncIdx]
local pWidget=pItem:getWidgetBase()
pWidget:SetChildActive(0,false)

self.selectFuncIdx=index
local item=self.funcItem[self.selectFuncIdx]
local widget=item:getWidgetBase()
widget:SetChildActive(0,true)

self:freshFuncPanel()
end

function UIXMKuFangRJWin:recv_20_148(len,list)
if self.selectMenuIdx==_menuTypeEnum.donate then
self:refreshDonatePanel()
end
end

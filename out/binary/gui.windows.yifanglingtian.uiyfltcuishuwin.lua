







def_class("UIYFLTcuishuWin",UIWindowBase)









function UIYFLTcuishuWin:bindComponents()

self.AllSelect=UIObject.get(self,0)
self.AllSelectBtn=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.cost1=UIText.get(self,3)
self.cost2=UIText.get(self,4)
self.CuiShuBtn=UIButton.get(self,5)
self.cuishuEffect=UIObject.get(self,6)
self.icon1=UIImage.get(self,7)
self.icon2=UIImage.get(self,8)
self.inforoot=UIObject.get(self,9)
self.itemroot=UIObject.get(self,10)
self.List=UIObject.get(self,11)
self.lyroot=UIObject.get(self,12)
self.money1Btn=UIButton.get(self,13)
self.money2Btn=UIButton.get(self,14)
self.moneyRoot1=UIObject.get(self,15)
self.moneyRoot2=UIObject.get(self,16)
self.noinfobg=UIObject.get(self,17)
self.rightPanel=UIObject.get(self,18)
self.title=UIText.get(self,19)

self.AllSelectBtn:setButtonClick(function()self:onAllSelectBtn()end)

self.CuiShuBtn:setButtonClick(function()self:onCuiShuBtn()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.money2Btn:setButtonClick(function()self:onMoney2Btn()end)



end


function UIYFLTcuishuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.AllSelect);self.AllSelect=nil;
_UIObject_release(self.AllSelectBtn);self.AllSelectBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.CuiShuBtn);self.CuiShuBtn=nil;
_UIObject_release(self.cuishuEffect);self.cuishuEffect=nil;
_UIObject_release(self.icon1);self.icon1=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.inforoot);self.inforoot=nil;
_UIObject_release(self.itemroot);self.itemroot=nil;
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.lyroot);self.lyroot=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.money2Btn);self.money2Btn=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.noinfobg);self.noinfobg=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIYFLTcuishuWin:onLoaded(...)
self:bindComponents()




end


function UIYFLTcuishuWin:__delete()
self:unbindComponents()
end




function UIYFLTcuishuWin:onShow(argtable,afterOnloaded)

self:refresh()
end


function UIYFLTcuishuWin:onHide()

end

function UIYFLTcuishuWin:refresh()
self.ison={}
self.everyPlantTime={}
local itemIdList={}
self.PlantDatatb=YiFangLingTianModel:GetCanCuiShuPlantData()
self.max=#self.PlantDatatb

table.sort(self.PlantDatatb,function(a,b)
local itemConfig_a=itemsConfig.getConfig(a.item_id)
local colora=itemConfig_a.color
local itemConfig_b=itemsConfig.getConfig(b.item_id)
local colorb=itemConfig_b.color
if colora~=colorb then
return colora<colorb
else
return a.item_id<b.item_id
end
end)

if#self.PlantDatatb>0 then
self.inforoot:setActive(true)
self.noinfobg:setActive(false)
for k,v in ipairs(self.PlantDatatb)do

if v.item_id>0 then
itemIdList[#itemIdList+1]=#itemIdList+1
end
end

self.Content:setChildLayoutGroupCreateItems(self.max,function(index)
self:refreshListItem(index,true)
end)









else
self.inforoot:setActive(false)
self.noinfobg:setActive(true)
end
self:CuiShuBtnShow()
self:refreshTopwin()
self.selectAll=false
self.AllSelect:setActive(self.selectAll)
end



function UIYFLTcuishuWin:onStartAction()

end


function UIYFLTcuishuWin:onFreshAction(index,widget)

end
local abname='ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab'
local itemcmp=
{
sorttype=0,
plantBg=1,
icon=2,
txt_name=3,
txt_year=4,
select=5,
next=6,
reducetime=7,
}

function UIYFLTcuishuWin:refreshListItem(idx,click)
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
if item==nil then

return
end

local itemdata=self.PlantDatatb[idx]

local nowindex=YiFangLingTianModel:GetNextJieDuan(itemdata.item_id,itemdata.total_times)

local shownowindex=YiFangLingTianModel:GetNowIndexBybegintimes(itemdata.item_id,itemdata.total_times)
if not nowindex then

return
end
local nextdatatime=self:residueJieDuan(itemdata.item_id,nowindex)
local sortTypeNamesList=self:judeGroupType(itemdata.item_id,nowindex)
item:SetChildDropDownOption(itemcmp.sorttype,sortTypeNamesList)
item:SetChildDropDownChangeAction(itemcmp.sorttype,function(id)self:onDropdownChange(id,idx,nextdatatime,itemdata,item)end)

local itemId_A=itemdata.item_id
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,itemId_A)
local itemid=conf.groupstage_itemid[shownowindex]
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconname=iconHelper.getIconName(itemid)
local str=string.format("image_yifanglingtianxys_%d",color)
item:SetChildCSImage(itemcmp.plantBg,abname,str,true)
item:SetChildCSImageIcon(itemcmp.icon,iconname)
item:SetChildText(itemcmp.txt_name,conf.tips_plantname)
item:SetChildButtonClick(itemcmp.plantBg,function(...)
UIManager:showWindow("UIYFLTTipsWin",{x=itemdata.x,y=itemdata.y})
end)

local year=gameUtilityModel.calculateGameYearFloor(itemdata.total_times)
local mubiao=nextdatatime[1]
local nowtime=itemdata.total_times
local needtime=mubiao-nowtime
self.everyPlantTime[idx]={needtime}
self:ChangeYear(idx,item)
item:SetChildActive(itemcmp.reducetime,false)

item:SetChildToggle(itemcmp.select,false)
item:SetChildToggleChange(itemcmp.select,function(name,isOn)
if isOn then
if not self.ison then
self.ison={}
end

self.ison[#self.ison+1]={idx}
if not self.isonnum then
self.isonnum=0
end
self.isonnum=self.isonnum+1
else
if next(self.ison)then
for k,v in ipairs(self.ison)do
if v[1]==idx then
table.remove(self.ison,k)
break
end
end
end
item:SetChildActive(itemcmp.reducetime,false)

if not self.isonnum then
self.isonnum=1
end
self.isonnum=self.isonnum-1
end
if self.isonnum>=self.max then
self.selectAll=true
self.AllSelect:setActive(true)
else
self.selectAll=false
self.AllSelect:setActive(self.selectAll)
end
self:ChangeReduceYear()
self:CuiShuBtnShow()

end)
local idx=YiFangLingTianController:xyToIdx(itemdata.x,itemdata.y)
local gezistage=YiFangLingTianModel:GetPlantGrowthStage(idx)
item:SetChildText(itemcmp.txt_year,conf.tips_stagetxt[gezistage])

self:ChangeReduceYear()
end


function UIYFLTcuishuWin:ChangeYear(idx,item)
if not item then
item=self.logGridPanelCmp:GetShownItemByIndex(idx-1)
item=item.Widget
end

local needtime=self.everyPlantTime[idx]and self.everyPlantTime[idx][1]or 0

local needyear=gameUtilityModel.calculateGameYearFloor(needtime)

item:SetChildText(itemcmp.next,needyear.."年")

end



function UIYFLTcuishuWin:ChangeReduceYear()
if next(self.ison)then

local lynum,itemnum,lyreduce,itemreduce=YiFangLingTianModel:Get_HaveItemAndLy()
local lytime=lynum*lyreduce
local itemtime=itemnum*itemreduce
for k,v in ipairs(self.ison)do
local idx=v[1]
local needtime=self.everyPlantTime[idx]and self.everyPlantTime[idx][1]or 0
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
if item then
local itemdata=self.PlantDatatb[idx]
local year=gameUtilityModel.calculateGameYearFloor(itemdata.total_times)
local canreduceTime=lynum*lyreduce+itemnum*itemreduce
if canreduceTime>=needtime then
item:SetChildActive(itemcmp.reducetime,true)
local reduceyear=gameUtilityModel.calculateGameYearFloor(needtime)
item:SetChildText(itemcmp.reducetime,"-"..reduceyear.."年")

if lynum*lyreduce>=needtime then
lynum=lynum-math.ceil(needtime/lyreduce)
else
lynum=0
itemnum=itemnum-math.ceil(needtime/itemreduce)
end

elseif canreduceTime>0 then
item:SetChildActive(itemcmp.reducetime,true)
local reduceyear=gameUtilityModel.calculateGameYearFloor(canreduceTime)
item:SetChildText(itemcmp.reducetime,"-"..reduceyear.."年")

lynum=0
itemnum=0
else
item:SetChildActive(itemcmp.reducetime,false)
end
end
end

end

end



function UIYFLTcuishuWin:judeGroupType(itemid,nowindex)
local group_stagetxt=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,"group_stagetxt")
local stagetb={}
for i=nowindex+1,#group_stagetxt do
stagetb[#stagetb+1]=group_stagetxt[i]
end
return stagetb
end

function UIYFLTcuishuWin:residueJieDuan(itemid,nowindex)
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,"group_conf")
local datatimeTb={}
for k,v in ipairs(group_conf)do
if nowindex<k then
datatimeTb[#datatimeTb+1]=v[1]
end
end
return datatimeTb
end


function UIYFLTcuishuWin:CuiShuBtnShow()





local lytable,itemlist=self:JudeCuiShuData()
local lynum,itemnum,lyreduce,itemreduce,itemid=YiFangLingTianModel:Get_HaveItemAndLy()
local uselynum=0
local useitemnum=0
if next(lytable)then
for k,v in ipairs(lytable)do
uselynum=uselynum+v[3]
end
end
if next(itemlist)then
for k,v in ipairs(itemlist)do
useitemnum=useitemnum+v[4]
end
end





if useitemnum>itemnum then
useitemnum=itemnum
end
self.CuiShuBtn:setActive(true)
self.cost1:setText(uselynum..'滴')
self.cost2:setText(useitemnum..'个')
local lt_constcfg=cfg_yifanglintianconfig().const_def
local itemid2=lt_constcfg.ly_itemid
local iconname1=iconHelper.getIconName(itemid2)
self.icon1:setImageIcon(iconname1)
local iconname2=iconHelper.getIconName(itemid)
self.icon2:setImageIcon(iconname2)
end


function UIYFLTcuishuWin:JudeCuiShuData()
local lynum,itemnum,lyreduce,itemreduce,itemid=YiFangLingTianModel:Get_HaveItemAndLy()
local lytime=lynum*lyreduce
local itemtime=itemnum*itemreduce
local lytable={}
local itemlist={}
if(lytime+itemtime)<=0 then

return{},{}
end
if not self.ison then
return{},{}
end

for k,v in ipairs(self.ison)do
local idx=v[1]
local data=self.PlantDatatb[idx]
local needtime=self.everyPlantTime[idx]and self.everyPlantTime[idx][1]or 0
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
if lynum>0 then

local canreduce=lynum*lyreduce
if canreduce>=needtime and lynum>0 then

local num=math.ceil(needtime/lyreduce)
lytable[#lytable+1]={data.x,data.y,num}
lynum=lynum-num
needtime=0
elseif lynum>0 then

needtime=needtime-lyreduce*lynum
lytable[#lytable+1]={data.x,data.y,lynum}
lynum=0
end
end


if lynum<=0 and needtime>0 then

local canreduce_item=itemnum*itemreduce
if canreduce_item>=needtime and itemnum>0 then

local num=math.ceil(needtime/itemreduce)
itemlist[#itemlist+1]={data.x,data.y,itemid,num}
itemnum=itemnum-num
needtime=0
elseif itemnum>0 then

itemlist[#itemlist+1]={data.x,data.y,itemid,itemnum}
itemnum=0

end
end

end
return lytable,itemlist
end

function UIYFLTcuishuWin:onClickClose()
self:closeSelf()
end

function UIYFLTcuishuWin:onDropdownChange(id,idx,nextdatatime,data,item)
local mubiao=nextdatatime[id+1]
local nowtime=data.total_times

local needtime=mubiao-nowtime
if needtime<0 then
self:refresh()
end
self.everyPlantTime[idx]={needtime}
self:ChangeYear(idx,item)
self:ChangeReduceYear()
self:CuiShuBtnShow()
end


function UIYFLTcuishuWin:onCuiShuBtn()
local lynum,itemnum,lyreduce,itemreduce,itemid=YiFangLingTianModel:Get_HaveItemAndLy()
local lytime=lynum*lyreduce
local itemtime=itemnum*itemreduce
local lytable={}
local itemlist={}
if(lytime+itemtime)<=0 then
UIManager.info("灵液和甘露水珠不足")
return
end
lytable,itemlist=self:JudeCuiShuData()
if not next(lytable)and not next(itemlist)then
UIManager.info("尚未选择灵植")
end
local flag=false
if next(lytable)then
YiFangLingTianController:req_3_83(#lytable,lytable)
flag=true
end

if next(itemlist)then
YiFangLingTianController:req_3_87(#itemlist,itemlist)
flag=true
end
if flag then

self.cuishuEffect:setChildShowEffect(20415,true)
end

end


function UIYFLTcuishuWin:refreshTopwin()

local widget1=self.moneyRoot1:getWidgetBase()
local lynum,havenum,lyreducetime,itemreducetime,itemid=YiFangLingTianModel:Get_HaveItemAndLy()
self.moneyType=itemid
local moneyVal=0
if moneyConfig.isMoney(self.moneyType)then
moneyVal=moneyModel.getMoney(self.moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(self.moneyType,'getItemCountByItemID',self.moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget1:SetChildIcon(0,iconHelper.getIconName(self.moneyType),false)
widget1:SetChildText(1,moneyStr)
widget1:SetChildActive(2,true)


local widget2=self.moneyRoot2:getWidgetBase()
local lt_constcfg=cfg_yifanglintianconfig().const_def
local itemid2=lt_constcfg.ly_itemid
self.moneyType2=itemid2
local moneyVal=lynum

local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget2:SetChildIcon(0,iconHelper.getIconName(self.moneyType2),false)
widget2:SetChildText(1,moneyStr)
widget2:SetChildActive(2,true)
end


function UIYFLTcuishuWin:onMoney1Btn()
if self.moneyType then
gainControl:showGainWin(self.moneyType)
end
end

function UIYFLTcuishuWin:onMoney2Btn()
YiFangLingTianModel:openlyGainWin()
end





function UIYFLTcuishuWin:onAllSelectBtn()
self.selectAll=not self.selectAll
if self.selectAll then
local flag=self:judeIsEnough()
if not flag then
local callback=function()
for idx=1,self.max do
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
local itemdata=self.PlantDatatb[idx]
item:SetChildToggle(itemcmp.select,true)
end
self.selectAll=true
end
local cancelcallback=function()
self.selectAll=false
self.AllSelect:setActive(false)
end
self:showDialog("绿液和甘露水珠不足催熟全部灵植，祖师是否继续选择全部灵植催熟？",callback,"确定",cancelcallback)
else
for idx=1,self.max do
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
local itemdata=self.PlantDatatb[idx]
item:SetChildToggle(itemcmp.select,true)
end
self.selectAll=true
end
else
for idx=1,self.max do
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
local itemdata=self.PlantDatatb[idx]
item:SetChildToggle(itemcmp.select,false)
end
end
self.AllSelect:setActive(self.selectAll)


self:CuiShuBtnShow()

end


function UIYFLTcuishuWin:judeIsEnough()
local lynum,itemnum,lyreduce,itemreduce,itemid=YiFangLingTianModel:Get_HaveItemAndLy()
for idx=1,self.max do
local item=self.Content:getChildLayoutGroupGridItem(idx-1)
local itemdata=self.PlantDatatb[idx]
local needtime=self.everyPlantTime[idx]and self.everyPlantTime[idx][1]or 0

if lynum>0 then

local canreduce=lynum*lyreduce
if canreduce>=needtime and lynum>0 then

local num=math.ceil(needtime/lyreduce)
lynum=lynum-num
needtime=0
elseif lynum>0 then

needtime=needtime-lyreduce*lynum
lynum=0
end
end

if lynum<=0 and needtime>0 then

local canreduce_item=itemnum*itemreduce
if canreduce_item>=needtime and itemnum>0 then

local num=math.ceil(needtime/itemreduce)
itemnum=itemnum-num
needtime=0
elseif itemnum>0 then

itemnum=0

return false
else

return false
end
end
end
return true
end




function UIYFLTcuishuWin:showDialog(content,callback,ok,cancelcallback,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
cancelcallback=cancelcallback
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

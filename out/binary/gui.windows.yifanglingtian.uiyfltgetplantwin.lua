







def_class("UIYFLTGetPlantWin",UIWindowBase)









function UIYFLTGetPlantWin:bindComponents()

self.CaiZhaiBtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.gotoBtn=UIButton.get(self,2)
self.gototext=UIText.get(self,3)
self.infoPanel=UIObject.get(self,4)
self.List=UIObject.get(self,5)
self.noinfobg=UIObject.get(self,6)
self.title=UIText.get(self,7)

self.CaiZhaiBtn:setButtonClick(function()self:onCaiZhaiBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIYFLTGetPlantWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.CaiZhaiBtn);self.CaiZhaiBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.gototext);self.gototext=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.noinfobg);self.noinfobg=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIYFLTGetPlantWin:onLoaded(...)
self:bindComponents()
self.title:setText("采摘灵植")
end


function UIYFLTGetPlantWin:__delete()
self:unbindComponents()
end




function UIYFLTGetPlantWin:onShow(argtable,afterOnloaded)

self:refreshList(true)
end


function UIYFLTGetPlantWin:onHide()

end

local abname='ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab'
local itemcmp=
{
plantitem=0,
select=1,
plantBg=2,
icon=3,
txt_name=4,
txt_year=5,
next=6,
}
function UIYFLTGetPlantWin:refreshList(init)

self.plantData=YiFangLingTianModel:GetCanPickPlant()
table.sort(self.plantData,function(a,b)
local flag_a=YiFangLingTianModel:JudeIsFinishByid(a.item_id,a.total_times)
local flag_b=YiFangLingTianModel:JudeIsFinishByid(b.item_id,b.total_times)
if flag_b and not flag_a then
return false
elseif flag_b==flag_a then
local itemConfig_a=itemsConfig.getConfig(a.item_id)
local colora=itemConfig_a.color
local itemConfig_b=itemsConfig.getConfig(b.item_id)
local colorb=itemConfig_b.color
return colora>colorb
else
return true
end

end)

self.max=#self.plantData
self.List:setActive(true)
self.CaiZhai={}
if init then
self.Content:setChildLayoutGroupCreateItems(self.max,function(index)
self:refreshListItem(index,true)
end)
else
for i=1,self.max do
self:refreshListItem(i)
end
end

self.noinfobg:setActive(self.max<=0)
self.infoPanel:setActive(self.max>0)
local plant_tab=YiFangLingTianModel:GetCanCuiShuPlantData()
if#plant_tab>0 then
self.gototext:setText("前往催熟")
else
self.gototext:setText("前往种植")
end
end

function UIYFLTGetPlantWin:refreshListItem(index,click)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local itemdata=self.plantData[index]
if itemdata then

local shownowindex=YiFangLingTianModel:GetNowIndexBybegintimes(itemdata.item_id,itemdata.total_times)

local itemId_A=itemdata.item_id
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,itemId_A)
local itemid=conf.groupstage_itemid[shownowindex]

local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconname=iconHelper.getIconName(itemid)
local str=string.format("image_yifanglingtianxys_%d",color)
item:SetChildCSImage(itemcmp.plantBg,abname,str,true)
item:SetChildCSImageIcon(itemcmp.icon,iconname)
item:SetChildText(itemcmp.txt_name,itemConfig.name)
item:SetBaseItemClickEvent(-1,function(...)
UIManager:showWindow("UIYFLTTipsWin",{x=itemdata.x,y=itemdata.y})
end)

local year=gameUtilityModel.calculateGameYearFloor(itemdata.total_times)

local maxyear=YiFangLingTianModel:GetMaxYear(itemId_A)
if year>=maxyear then
item:SetChildText(itemcmp.txt_year,maxyear.."年")
item:SetChildText(itemcmp.next,string.format("<color=#549327>完全成熟</color>"))
local x=itemdata.x
local y=itemdata.y
if not self.CaiZhai[x]then
self.CaiZhai[x]={}
end
self.CaiZhai[x][y]=true
else

local nexttime,needtime=YiFangLingTianModel:GetNextYear(itemId_A,itemdata.total_times)
local nextyear=gameUtilityModel.calculateGameYearFloor(needtime)
item:SetChildText(itemcmp.txt_year,year.."年")
item:SetChildText(itemcmp.next,nextyear.."年")
end

item:SetChildToggle(itemcmp.select,year>=maxyear)
item:SetChildToggleChange(itemcmp.select,function(name,isOn)
local x=itemdata.x
local y=itemdata.y
if isOn==true then
local group_conf=conf.group_conf
local maxtime=group_conf[#group_conf][1]
local growtime=itemdata.total_times
if growtime>maxtime then
if not self.CaiZhai[x]then
self.CaiZhai[x]={}
end
self.CaiZhai[x][y]=true
else
local itemConfig=itemsConfig.getConfig(itemId_A)
local callback=function()
if not self.CaiZhai[x]then
self.CaiZhai[x]={}
end
self.CaiZhai[x][y]=true
end
local str=string.format("<color=%s>%s</color>尚未成长至“%s”，\n祖师是否提前采摘？",FONT_COLOR_VAL[itemConfig.color],conf.tips_plantname,conf.tips_stagetxt[#conf.tips_stagetxt])
local cancelCallback=function()
item:SetChildToggle(itemcmp.select,false)
end
self:showDialog(str,callback,cancelCallback)
end
else
if self.CaiZhai[x]and self.CaiZhai[x][y]then
self.CaiZhai[x][y]=false
end
end
end)
end
end

function UIYFLTGetPlantWin:onCaiZhaiBtn()
local caizhailist={}
for k,v in pairs(self.CaiZhai)do
for k1,v1 in pairs(v)do
if v1 then
caizhailist[#caizhailist+1]={k,k1}
end
end
end
if#caizhailist>0 then
YiFangLingTianController:req_3_84(#caizhailist,caizhailist)
self:onClickClose()
else
UIManager.info("请选择要采摘的植物")
end

end


function UIYFLTGetPlantWin:onClickClose()
self:closeSelf()
end


function UIYFLTGetPlantWin:onGotoBtn()

local plant_tab=YiFangLingTianModel:GetCanCuiShuPlantData()
if#plant_tab>0 then
UIManager:showWindow("UIYFLTcuishuWin")
end
self:onClickClose()
end


function UIYFLTGetPlantWin:showDialog(content,callback,cancelcallback,ok,cancel)
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
cancelcallback=cancelcallback,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
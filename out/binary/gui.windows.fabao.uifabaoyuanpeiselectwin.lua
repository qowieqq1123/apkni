







def_class("UIFabaoYuanPeiSelectWin",UIWindowBase)









function UIFabaoYuanPeiSelectWin:bindComponents()

self.Contect=UIObject.get(self,0)
self.Dropdown=UIDropdownEx.get(self,1)
self.Dropdown2=UIDropdownEx.get(self,2)
self.filterBtn=UIButton.get(self,3)
self.Item_Label=UIText.get(self,4)
self.Item_Label1=UIText.get(self,5)
self.title=UIText.get(self,6)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)



end


function UIFabaoYuanPeiSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Contect);self.Contect=nil;
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
_UIObject_release(self.Item_Label1);self.Item_Label1=nil;
_UIObject_release(self.title);self.title=nil;
end


















function UIFabaoYuanPeiSelectWin:onLoaded(...)
self:bindComponents()
self.Dropdown:setChangeAction(function(...)self:onDropdownChange(1,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(2,...)end)
self.droplist={}
self.dropnames={}
self.filterIdxList={}

self.yuanpeiFilter={}


local droplist={}
local dropnames={'全部'}
for k,v in pairs(FABAO_YUANPEI_MAT_TYPE)do
droplist[#droplist+1]=v
end
table.sort(droplist,function(a,b)
return a<b
end)
for i,v in ipairs(droplist)do
dropnames[#dropnames+1]=cfg_fabaoyuanpeitypeconfig_get(v).name
end
self.droplist[1]=droplist
self.dropnames[1]=dropnames
self.filterIdxList[1]=0


local droplist={}
local dropnames={'全部'}
local cfgs=cfg_fabaoyuanpeitypeconfig()
local droplist={}
for i,v in pairs(FABAO_MAT_TYPE)do
droplist[#droplist+1]=v
end
table.sort(droplist,function(a,b)
return a<b
end)
for i,v in ipairs(droplist)do
dropnames[#dropnames+1]=cfg_fabaoyuanpeitypeconfig_get(v).name
end
self.droplist[2]=droplist
self.dropnames[2]=dropnames
self.filterIdxList[2]=0

self:initDrop()
end

function UIFabaoYuanPeiSelectWin:__delete()
self:unbindComponents()
self.yuanpeiFilterWinActiveState=false
tipsManager.closeTips()
end

function UIFabaoYuanPeiSelectWin:onShow(argtable,afterOnloaded)
local itemguid=argtable.itemguid
self.selectguid=itemguid
self.yuanpeiFilterWinActiveState=false

self:freshInfo()
end

function UIFabaoYuanPeiSelectWin:onHide()

end



function UIFabaoYuanPeiSelectWin:freshInfo()
local filter={}

filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabaoYuanPei


local filterIdx=self.filterIdxList[1]or 0
if filterIdx>0 then
filter[ITEM_FILTER_TYPE.eItemType1]=self.droplist[1][filterIdx]
end


local filterIdx=self.filterIdxList[2]or 0
if filterIdx>0 then
filter[ITEM_FILTER_TYPE.eYuanPeiOwnerFabaoType]=self.droplist[2][filterIdx]
end

local list=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,next(self.yuanpeiFilter)==nil and filter or self.yuanpeiFilter)


local sortTag={}
for i,v in ipairs(list)do
local itemid=v.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local selectTag=tostring(self.selectguid)==tostring(v.itemguid)and 1 or 0
sortTag[tostring(v.itemguid)]=selectTag*10000+itemCfg.color*1000-i-itemid/100000
end
if#list>1 then
table.sort(list,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
end
local len=#list
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local item=list[i]
local itemid=item.itemid
local itemguid=item.itemguid
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local czid=benMingFaBaoHelper.getCiZhui(itemid)
local czcfg=cfg_disciplefabaoczconfig_get(czid)
local czname=czcfg.name
local needlevel=itemCfg.level
local level=zongmenModel:getLevel()
local levelStr=level>=needlevel and''or FMT.cfmt(FONT_COLOR.eRedColor,'（{0}级）',needlevel)
local name=needlevel and FMT.fmt('{0}{1}',itemCfg.name,levelStr)or
itemCfg.name
local isput=tostring(self.selectguid)==tostring(itemguid)

if isput then
self.selectIdx=i
self:onSelect(itemguid,itemid,nil,i,false)
end

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),false)
widget:SetChildButtonClick(1,function()
local formType=TIPS_FORM_TYPE.eFaBaoYuanPeiSelect
if isput then formType=nil end
self:onSelect(itemguid,itemid,formType,i,true)
end)
widget:SetChildText(2,name)
widget:SetChildText(3,FMT.fmt('本命词缀：{0}',czname))
widget:SetChildButtonClick(4,function()
local formType=TIPS_FORM_TYPE.eFaBaoYuanPeiSelect
if isput then formType=nil end
self:onSelect(itemguid,itemid,formType,i,true)
end,true)
widget:SetChildActive(5,isput)
widget:SetChildActive(6,isput)
end)
end

function UIFabaoYuanPeiSelectWin:initDrop()
self.Dropdown:setOption(self.dropnames[1])
self.Dropdown:setValue(0)

self.Dropdown2:setOption(self.dropnames[2])
self.Dropdown2:setValue(0)
end

function UIFabaoYuanPeiSelectWin:onDropdownChange(dropIndex,index)
if self.filterIdxList[dropIndex]==index then return end
self.filterIdxList[dropIndex]=index
self:freshInfo()
end

function UIFabaoYuanPeiSelectWin:onSelect(itemguid,itemid,formType,i,showTips)

if showTips then
if UIManager:isActive("UIFaBaoYuanPeiFilterWin")then
UIManager:closeWindow("UIFaBaoYuanPeiFilterWin")
end

tipsManager.showTips({formType=formType,
itemguid=itemguid,
itemid=itemid,
closeCallback=function()
if self.yuanpeiFilterWinActiveState then
self:onFilterBtn()
end
end
})
end

local oldidx=self.selectIdx
self.selectIdx=i
self.selectguid=itemguid
if oldidx then
local widget=self.Contect:getChildLayoutGroupGridItem(oldidx-1)
widget:SetChildActive(5,false)
widget:SetChildActive(6,false)
end
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
widget:SetChildActive(5,true)
widget:SetChildActive(6,true)
end

function UIFabaoYuanPeiSelectWin:onFilterBtn()
local args={
yuanpeiFilter=self.yuanpeiFilter or{},

safeguardCachedFilterDataCallback=function(filter)
self.yuanpeiFilter=filter
end,


refreshItemsCallback=function(filter)
self.yuanpeiFilter=filter




self:freshInfo()
end,

closeCallback=function()


self.yuanpeiFilterWinActiveState=false
end
}

self:showWindow("UIFaBaoYuanPeiFilterWin",args)

self.yuanpeiFilterWinActiveState=true
end

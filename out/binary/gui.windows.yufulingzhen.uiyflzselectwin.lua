







def_class("UIYFLZSelectWin",UIWindowBase)









function UIYFLZSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollView=UILoopListView.new(self,1)
self.comboBox=UIObject.get(self,2)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIYFLZSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
end



















function UIYFLZSelectWin:onLoaded(...)
self:bindComponents()

self.lzNames={'全部灵阵','金','木','水','火','土'}

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.comboBox:setChildComboBoxInit(function(...)self:onComboxChange(...)end)
end

function UIYFLZSelectWin:onComboxChange(index)
self.selectIndex=index
local isOpen=not self.isOpen
if not self.isOpen then self.isOpen=true end
self:setItemList(isOpen)
end


function UIYFLZSelectWin:__delete()
self:unbindComponents()
end




function UIYFLZSelectWin:onShow(argtable,afterOnloaded)
self.index=argtable.index
self.yfGuid=argtable.yfGuid
self.selectCallback=argtable.selectCallback
self.tuijianIdx=argtable.tuijianIdx
if self.index==6 then
self.selectIndex=6
self.comboBox:setActive(false)
self:setItemList(true)
else
self.comboBox:setChildComboBoxOption(0,self.lzNames)
end


end


function UIYFLZSelectWin:onHide()

end

function UIYFLZSelectWin:getDatas()
local stype=self.selectIndex
local items=lingzhenBagModel:getBagItems()

local list={}
for i,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if(stype==0 and cfg.type1~=6)or stype==cfg.type1 then
table.insert(list,v)
end
end
table.sort(list,function(a,b)
return UIYuFuLingZhenControl:getItemLevel(a.itemid)>UIYuFuLingZhenControl:getItemLevel(b.itemid)
end)

local data=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)
if data and data.zhentuId>0 and data.len>0 then
local kdata=data.kongList[self.index]
if kdata then
table.insert(list,1,{
itemid=kdata.itemId,level=UIYuFuLingZhenControl:getItemLevel(kdata.itemId),itemguid=table.concat({mathHelper.int64_to_string(self.yfGuid),self.index},"-"),isEquip=true,
yufuGuid=self.yfGuid,
kongIndex=self.index,
})
end
end

return list
end

function UIYFLZSelectWin:setItemList(open)
self.datas=self:getDatas()
if open then
if#self.datas==0 then
local index=self.tuijianIdx
if not index or self.index==6 then
index=6
end
local name=UIYuFuLingZhenControl:getPrefixName(index)
UIManager.error("没有"..name.."灵阵")
local oneId=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"baseItemGroup")
gainControl:showGainWin(oneId[index])
self:closeSelf()
return
end
end












local _slotName='item'
self.scrollView:initData(_slotName,self.datas)
end
function UIYFLZSelectWin:onStartAction()

end
function UIYFLZSelectWin:onFreshAction(i,widget,data)
self:onFreshWidget(i,widget,data)
end

function UIYFLZSelectWin:onFreshWidget(i,item,data)

local selectCall=self.selectCallback
local xianqian=function(id)
if not self.selectCallback then
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
local kdata=UIYuFuLingZhenControl:getXianQianData(self.yfGuid,self.index)
if kdata then

UIYuFuLingZhenControl:reqLZXieXia(dzId,self.yfGuid,1,{self.index})
end
local data=self.datas[id]
UIYuFuLingZhenControl:reqLZXiangQian(dzId,self.yfGuid,1,{{data.itemguid,self.index}})
else
local data=self.datas[id]
self.selectCallback(data.itemguid,data.yufuGuid,data.kongIndex)
end


self:onCloseClick()
end
local xiexia=function(id)
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yfGuid)
UIYuFuLingZhenControl:reqLZXieXia(dzId,self.yfGuid,1,{self.index})
self:onCloseClick()
end

local level=UIYuFuLingZhenControl:getItemLevel(data.itemid)
local itemCfg=itemsConfig.getConfig(data.itemid)
local color=UIYuFuLingZhenControl:getItemColorById(data.itemid,data.itemguid,level)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
item:SetChildCSImageSprite(6,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(itemCfg)

item:SetChildIcon(0,icon,true)
self:setAttr(item,data.itemid)
local cfg=itemsConfig.getConfig(data.itemid)
item:SetChildText(1,cfg.name)
local check1=not data.isEquip and selectCall==nil
local check2=data.isEquip and selectCall==nil
local check3=selectCall~=nil

item:SetChildActive(4,check1)
item:SetChildActive(5,check2)
item:SetChildActive(7,check3)
if check1 then
item:SetChildButtonClickWithID(4,xianqian,i)
end
if check2 then
item:SetChildButtonClickWithID(5,xiexia,i)
end
if check3 then
item:SetChildButtonClickWithID(7,xianqian,i)
end
item:SetChildButtonClickWithID(0,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=data.itemid,itemguid=data.itemguid,attach={yfguid=data.yufuGuid,kongIndex=data.kongIndex}})
end,i)
item:SetChildText(8,cfg.level)

if not data.isEquip and cfg.type1~=6 then
local itemCount=data.itemcount
item:SetChildActive(9,itemCount>1)
item:SetChildText(10,itemCount)
else
item:SetChildActive(9,false)
end

end


function UIYFLZSelectWin:setAttr(item,itemid)
local attrs=UIYuFuLingZhenControl:getAttrs(itemid)
for i=1,2 do
local attr=attrs[i]
if attr then

local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(i+1,FMT.fmt('{0}：{1}',name,str))
else
item:SetChildText(i+1,'')
end
end
end




function UIYFLZSelectWin:onCloseClick()
self:closeSelf()
end
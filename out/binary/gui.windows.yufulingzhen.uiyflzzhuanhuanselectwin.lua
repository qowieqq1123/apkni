







def_class("UIYFLZZhuanHuanSelectWin",UIWindowBase)









function UIYFLZZhuanHuanSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollView=UILoopListView.new(self,1)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIYFLZZhuanHuanSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
end



















function UIYFLZZhuanHuanSelectWin:onLoaded(...)
self:bindComponents()
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIYFLZZhuanHuanSelectWin:__delete()
self:unbindComponents()
end




function UIYFLZZhuanHuanSelectWin:onShow(argtable,afterOnloaded)
self.leftIndex=argtable.leftIndex
self.leftItemId=argtable.leftItemId
self.level=argtable.level
self.selectCallback=argtable.selectCallback

self:setItemList()
end


function UIYFLZZhuanHuanSelectWin:onHide()

end

function UIYFLZZhuanHuanSelectWin:getDatas()
local items={1,2,3,4,5}
local ItemIdList={}
for i,v in ipairs(items)do
local ItemId=self.leftItemId+(v-self.leftIndex)*10
table.insert(ItemIdList,ItemId)
end
table.remove(ItemIdList,self.leftIndex)
return ItemIdList
end

function UIYFLZZhuanHuanSelectWin:setItemList()
self.datas=self:getDatas()
local _slotName='item'
self.scrollView:initData(_slotName,self.datas)
end

function UIYFLZZhuanHuanSelectWin:onStartAction()

end

function UIYFLZZhuanHuanSelectWin:onFreshAction(i,widget,data)
self:onFreshWidget(i,widget,data)
end

function UIYFLZZhuanHuanSelectWin:onFreshWidget(i,item,data)
local ItemIdList=self:getDatas()
local xuanzhe=function(id)
local itemid=ItemIdList[id]
self.selectCallback(itemid)
self:onCloseClick()
end
local level=UIYuFuLingZhenControl:getItemLevel(ItemIdList[i])
local itemCfg=itemsConfig.getConfig(ItemIdList[i])
local color=UIYuFuLingZhenControl:getItemColorbyItemId(ItemIdList[i])
local pz=UIYuFuLingZhenControl:getPZIconName(color)
item:SetChildCSImageSprite(4,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(itemCfg)
item:SetChildIcon(0,icon,true)
self:setAttr(item,ItemIdList[i])
item:SetChildText(1,itemCfg.name)
item:SetChildButtonClickWithID(5,xuanzhe,i)
item:SetChildText(6,level)
item:SetChildButtonClickWithID(0,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=ItemIdList[i]})
end,i)
end

function UIYFLZZhuanHuanSelectWin:setAttr(item,itemid)
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



function UIYFLZZhuanHuanSelectWin:onCloseClick()
self:closeSelf()
end
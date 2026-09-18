







def_class("UICommonUseItemDialougeWithIconWin",UIWindowBase)









function UICommonUseItemDialougeWithIconWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.linkImageText=UILinkImageText.get(self,1)
self.goodItem=UIObject.get(self,2)
self.cancelBtn=UIButton.get(self,3)
self.cancelText=UIText.get(self,4)
self.commitText=UIText.get(self,5)



end


function UICommonUseItemDialougeWithIconWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.linkImageText);self.linkImageText=nil;
_UIObject_release(self.goodItem);self.goodItem=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.commitText);self.commitText=nil;
end



















function UICommonUseItemDialougeWithIconWin:onLoaded(...)
self:bindComponents()
end


function UICommonUseItemDialougeWithIconWin:__delete()
self:unbindComponents()
end




function UICommonUseItemDialougeWithIconWin:onShow(argtable,afterOnloaded)

self.titleTxt:setText(argtable.title or'提示')

local desc=argtable.desc or''
self.linkImageText:setText(desc)

local item=self.goodItem:getChildWidgetBase()
local itemid=argtable.itemid
local itemnum=argtable.itemnum
local num_str=tostring(itemnum)
self.itemid=itemid
self.needNum=argtable.needNum
if self.needNum then
if itemnum<self.needNum then
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
num_str=FMT.fmt('<color={0}>{1}</color>',col,itemnum)
end
end
local conf={itemid=itemid,itemcount=num_str,showname=false,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)

local showCancel=argtable.showCancel
if showCancel==nil then showCancel=true end
self.cancelBtn:setActive(showCancel)
if showCancel then
self.cancelText:setText(argtable.cancelName or'取消')
end
self.commitText:setText(argtable.commitName or'确定')

self.cancelCB=argtable.cancelCB
self.commitCB=argtable.commitCB
end

function UICommonUseItemDialougeWithIconWin:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UICommonUseItemDialougeWithIconWin:onCommitBtn()
if self.needNum then
local has=bagModel.getItemCountById(self.itemid)
if has<self.needNum then
local name=itemsConfig.getItemName(self.itemid)
UIManager.error(FMT.fmt('{0}不足',name))
return
end
end
local cb=self.commitCB
self:closeSelf()
if cb then
cb()
end
end

function UICommonUseItemDialougeWithIconWin:onCancelBtn()
local cb=self.cancelCB
self:closeSelf()
if cb then
cb()
end
end


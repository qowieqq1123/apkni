







def_class("UIMoneyPanel",UIWindowBase)









function UIMoneyPanel:bindComponents()

self.scrollview=UIObject.get(self,0)



end


function UIMoneyPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
end
















local _this




function UIMoneyPanel:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
end


function UIMoneyPanel:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
end




function UIMoneyPanel:onShow(argtable,afterOnloaded)
if argtable then
local typelist=argtable
local len=#typelist
self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.scrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollview:getChildScrollViewItemWidgets()
self.moneyIndexs={}
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local mtype=typelist[index]
self.moneyIndexs[mtype]=index
item:SetChildIcon(0,iconHelper.getIconName(mtype),true)
item:SetChildText(1,moneyModel.getMoney(mtype))
item:SetChildButtonClickWithID(2,function(id)
UIManager.info(id)
end,mtype)
end
end
end

function UIMoneyPanel.on_money_change(moneyType,lastval,newval)
local index=_this.moneyIndexs[moneyType]
if index then
local item=_this.scrollview:getChildScrollViewItemWidget(index-1)
item:SetChildText(0,newval)
end
end


function UIMoneyPanel:OnEnable()

end


function UIMoneyPanel:OnDisable()

end



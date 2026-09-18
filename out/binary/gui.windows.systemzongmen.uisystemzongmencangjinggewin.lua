







def_class("UISystemZongMenCangJingGeWin",UIWindowBase)









function UISystemZongMenCangJingGeWin:bindComponents()

self.root=UIObject.get(self,0)
self.leftBtn=UIButton.get(self,1)
self.rightBtn=UIButton.get(self,2)
self.gfItem_1=UIObject.get(self,3)
self.gfItem_2=UIObject.get(self,4)
self.gfItem_3=UIObject.get(self,5)
self.gfItem_4=UIObject.get(self,6)
self.gfItem_5=UIObject.get(self,7)
self.gfItem_6=UIObject.get(self,8)
self.gfItem_7=UIObject.get(self,9)
self.gfItem_8=UIObject.get(self,10)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)
self.gfItem={
self.gfItem_1,
self.gfItem_2,
self.gfItem_3,
self.gfItem_4,
self.gfItem_5,
self.gfItem_6,
self.gfItem_7,
self.gfItem_8,
}



end


function UISystemZongMenCangJingGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.gfItem_1);self.gfItem_1=nil;
_UIObject_release(self.gfItem_2);self.gfItem_2=nil;
_UIObject_release(self.gfItem_3);self.gfItem_3=nil;
_UIObject_release(self.gfItem_4);self.gfItem_4=nil;
_UIObject_release(self.gfItem_5);self.gfItem_5=nil;
_UIObject_release(self.gfItem_6);self.gfItem_6=nil;
_UIObject_release(self.gfItem_7);self.gfItem_7=nil;
_UIObject_release(self.gfItem_8);self.gfItem_8=nil;
self.gfItem=nil;
end
















local _this=nil

local _itemCmp={
this=-1,
icon=0,
iconBg=1,
name=2,
element=3,
button=4,
effect=5,
}
local _colorEffectLookup={
[0]=10155,10145,10146,10147,10148,10149
}



function UISystemZongMenCangJingGeWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)

for i,v in ipairs(self.gfItem)do
local widget=v:getWidgetBase()
widget:SetChildButtonClick(_itemCmp.button,function()
self:onClickItem(i)
end)
end




end


function UISystemZongMenCangJingGeWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end




function UISystemZongMenCangJingGeWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.page=1
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eCangJingGe)then
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eCangJingGe)
self:refreshView()
end
end


function UISystemZongMenCangJingGeWin:onHide()

end



function UISystemZongMenCangJingGeWin:onLeftBtn()
self.page=math.max(self.page-1,1)
self:refreshView()
end

function UISystemZongMenCangJingGeWin:onRightBtn()
self.page=math.min(self.page+1,math.ceil(#self.detailInfo.gongfaList/#self.gfItem))
self:refreshView()
end

function UISystemZongMenCangJingGeWin:refreshView()
local gfList=self.detailInfo.gongfaList
local count=#gfList
for i,v in ipairs(self.gfItem)do
local widget=v:getWidgetBase()
local gfId=gfList[(self.page-1)*#self.gfItem+i]
widget:SetChildActive(_itemCmp.this,gfId~=nil)
if gfId then
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfId)

local elements=UIGongFaModel:getGFElements(gfId)
local elementIcon=ELEMENT_TYPE.getIcon(elements[1])
widget:SetChildCSImageSprite(_itemCmp.element,globalABLookup.global,elementIcon)

widget:SetChildText(_itemCmp.name,cfg.name)

local color=UIGongFaModel:getGFColor(gfId)


widget:SetChildIcon(_itemCmp.icon,iconHelper.getGongFaIcon(cfg.icon),false)
widget:SetChildShowEffect(_itemCmp.effect,_colorEffectLookup[cfg.color],true)
end
end
self.leftBtn:setActive(self.page>1)
self.rightBtn:setActive(self.page<math.ceil(#self.detailInfo.gongfaList/#self.gfItem))







end























function UISystemZongMenCangJingGeWin:onClickItem(index)
local gfID=self.detailInfo.gongfaList[(self.page-1)*#self.gfItem+index]
UIManager:showWindow('UIGongFaTipsFourWin',{gfID=gfID})

end

function UISystemZongMenCangJingGeWin.onSystemZMDetailInfo(partType,serial)
if _this.serial==serial and partType==systemZongMenDetailDataPart.eCangJingGe then
_this.detailInfo=systemZongMenModel:getDetailPartInfo(_this.serial,systemZongMenDetailDataPart.eCangJingGe)
_this:refreshView()
end
end
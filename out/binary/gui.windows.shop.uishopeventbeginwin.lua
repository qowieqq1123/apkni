







def_class("UIShopEventBeginWin",UIWindowBase)









function UIShopEventBeginWin:bindComponents()

self.title=UIText.get(self,0)
self.dizi=UIObject.get(self,1)
self.desc=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)
self.tips=UIText.get(self,4)



end


function UIShopEventBeginWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tips);self.tips=nil;
end
















local _this




function UIShopEventBeginWin:onLoaded(...)
self:bindComponents()

_this=self

self.buttonSkin={'button_tyanniu_1','button_tyanniu_2','button_tyanniu_3','button_tyanniu_5'}

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UIShopEventBeginWin:__delete()
self:unbindComponents()

_this=nil
end




function UIShopEventBeginWin:onShow(argtable,afterOnloaded)
local bdData=argtable
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,bdData.build_id)
local eventId=UIShopModel:getShopEventId(bdData.un_build_id)
local data=cfg.event_list[eventId]

self.bdId=bdData.un_build_id
self.eventId=eventId

self.title:setText(data.title or'')
self.desc:setText(data.desc or'')
self.tips:setText(chatEmotHelper.decodeEmot(data.tips or''))

local len=#data.select
self.scrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local bd=data.select[i+1]
item:SetChildText(0,bd.name)
local skin=bd.skin or 1
item:SetChildCSImageSprite(1,self.abName,self.buttonSkin[skin])
end

if tostring(bdData.dizi_id)~='0'then
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(bdData.dizi_id)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.dizi:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
end
end


function UIShopEventBeginWin:onHide()

end

function UIShopEventBeginWin.on_item_click(clicknum,index)
_this:onEventSelect(index)
end

function UIShopEventBeginWin:onEventSelect(index)
UIShopControl:reqHandleShopEvent(self.bdId)
self:onCloseClick()
end




function UIShopEventBeginWin:onCloseClick()
self:closeSelf()
end
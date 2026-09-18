







def_class("UIXM_XMDG_reliveWin",UIWindowBase)









function UIXM_XMDG_reliveWin:bindComponents()

self.goodRoot=UIObject.get(self,0)
self.goodGridPanel=UIObject.get(self,1)



end


function UIXM_XMDG_reliveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.goodRoot);self.goodRoot=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
end
















local _this=nil


function UIXM_XMDG_reliveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_reliveWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_reliveWin:onHide()

end




function UIXM_XMDG_reliveWin:onShow(argtable,afterOnloaded)
self.goodRoot:setLocalPos(argtable.posx,argtable.posy,0)
self.curDZguid=argtable.dzguid

if self.googslist==nil then
self.googslist=cfgHelper.get2(cfg_guilddigongbaseconfig_get,1,'relive')
end
self.goodGridPanel:setChildLayoutGroupCreateItems(#self.googslist,function(idx)
if _this==nil then return end
_this:initgoodGridItem(nil,idx)
end)
end

function UIXM_XMDG_reliveWin:initgoodGridItem(item,idx)
if item==nil then
item=self.goodGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local d=self.googslist[idx]
local itemid=d[1]
local itemnum=d[2]
local hasnum=itemsModel.getCount(itemid)
local countStr=''
local showCountBG=false
if hasnum<itemnum then
countStr=FMT.fmt('<color=#c82c2c>{0}/{1}</color>',hasnum,itemnum)
else
countStr=FMT.fmt('{0}/{1}',hasnum,itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
item:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onUseGood(idx)
end)
end

function UIXM_XMDG_reliveWin:onUseGood(idx)
local d=self.googslist[idx]
local itemid=d[1]
local itemnum=d[2]
local hasnum=itemsModel.getCount(itemid)
if hasnum<itemnum then
UIManager.error('道具不足')
gainControl:showCommonGainWin_item(itemid)
return
end

xianmengdigongController:send_20_114(self.curDZguid,idx)
end


function UIXM_XMDG_reliveWin:onGoodsPanel()
self:closeGoodsPanel()
end

function UIXM_XMDG_reliveWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end









def_class("UIUseTianMingItemWin",UIWindowBase)









function UIUseTianMingItemWin:bindComponents()

self.okButton=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.descTxt=UIText.get(self,2)
self.goodsPanel=UIObject.get(self,3)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIUseTianMingItemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.goodsPanel);self.goodsPanel=nil;
end
















local _this


function UIUseTianMingItemWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIUseTianMingItemWin:__delete()
_this=nil
self:unbindComponents()
local isSysOpen=systemModel.isOpen(SYSTEM_DEFINE.eLingCuiShangDian)
if not self.isSysOpen and isSysOpen then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.LingCuiShopLuaFunc)
end
end


function UIUseTianMingItemWin:onHide()

end




function UIUseTianMingItemWin:onShow(argtable,afterOnloaded)
local list=dzLingCuiShopController:findFullTianMingItems()
local c=#list
self.goodsPanel:setChildLayoutGroupCreateItems(c)
local grids=self.goodsPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=list[i]
local itemid=d[2]
local itemnum=d[3]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local cfg=itemsConfig.getConfig(itemid)
local funcparam=cfg.funcparam
itemid=funcparam.money_id
itemnum=funcparam.money_num*itemnum
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showname=false}
prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local desc_str=cfgHelper.getlang('use_tianming_item_tips')
self.descTxt:setText(desc_str)

local isSysOpen=false
if c>0 then
isSysOpen=systemModel.isOpen(SYSTEM_DEFINE.eLingCuiShangDian)
local list2={}
for i,v in ipairs(list)do
table.insert(list2,{v[2],v[3]})
end
bagProtocolControl.req_use_item_list(c,list2)
end
self.isSysOpen=isSysOpen
end

function UIUseTianMingItemWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UIUseTianMingItemWin:onOkButton()
self:closeSelf()
end

function UIUseTianMingItemWin:onCloseBtn()
self:closeSelf()
end
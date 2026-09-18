







def_class("UIGuPiaoZhangDieWin",UIWindowBase)









function UIGuPiaoZhangDieWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.gridContent=UIObject.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIGuPiaoZhangDieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
end



















function UIGuPiaoZhangDieWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoZhangDieWin:__delete()
self:unbindComponents()
end




function UIGuPiaoZhangDieWin:onShow(argtable,afterOnloaded)
local actorData=shangHangModel:getActorGuPiaoDataList()

local leaveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eShangHangData,"actorData",nil)



if not leaveData or next(actorData)==nil then
self:closeSelf()
return
end

local cData=self:compareData(actorData,leaveData)
local moneyIconStr=''
self.gridContent:setChildLayoutGroupCreateItems(#cData,function(index)
local itemCmp=self.gridContent:getChildLayoutGroupGridItem(index-1)
local itemData=cData[index]

local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,itemData.stock_id)
itemCmp:SetChildText(1,cfg.name)
local icon=shangHangModel.getGuPiaoIcon(itemData.stock_id)
itemCmp:SetChildIcon(0,icon,false)
itemCmp:SetChildText(2,FMT.fmt("{0} {1}",moneyIconStr,mathHelper.formatNumber5(itemData.oldBuy,2)))
local up=(itemData.newBuy-itemData.oldBuy)>0
if up then
itemCmp:SetChildText(3,FMT.fmt("<color=#c82c2c>{0} {1}</color>",moneyIconStr,mathHelper.formatNumber5(itemData.newBuy,2)))
elseif(itemData.newBuy-itemData.oldBuy)<0 then
itemCmp:SetChildText(3,FMT.fmt("<color=#549327>{0} {1}</color>",moneyIconStr,mathHelper.formatNumber5(itemData.newBuy,2)))
else
itemCmp:SetChildText(3,FMT.fmt("<color=#171311>{0} {1}</color>",moneyIconStr,mathHelper.formatNumber5(itemData.newBuy,2)))
end



itemCmp:SetChildText(4,FMT.fmt("{0}%",itemData.oldYingLi))
local up=(itemData.newYingLi-itemData.oldYingLi)>0
if up then
itemCmp:SetChildText(5,FMT.fmt("<color=#c82c2c>{0}%</color>",itemData.newYingLi))
elseif(itemData.newYingLi-itemData.oldYingLi)<0 then
itemCmp:SetChildText(5,FMT.fmt("<color=#549327>{0}%</color>",itemData.newYingLi))
else
itemCmp:SetChildText(5,FMT.fmt("{0}%",itemData.newYingLi))
end


end)
end

function UIGuPiaoZhangDieWin:compareData(actorData,leaveData)
local list={}
local newData=nil
local price=nil
for i,v in pairs(leaveData)do
newData=actorData[v.stock_id]
if newData then
price=shangHangModel:getGuPiaoPrice(v.stock_id)

table.insert(list,{stock_id=v.stock_id,
oldBuy=v.buy_price,
newBuy=newData.stock_cnt*price,
oldYingLi=v.yingli,
newYingLi=shangHangModel.calcYingLi(newData.buy_price,newData.stock_cnt,price)})
end
end
return list
end


function UIGuPiaoZhangDieWin:onHide()

end





function UIGuPiaoZhangDieWin:onCloseBtn()
self:closeSelf()
end


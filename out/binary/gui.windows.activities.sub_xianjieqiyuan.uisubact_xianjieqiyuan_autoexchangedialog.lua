







def_class("UISubAct_xianjieqiyuan_AutoExchangeDialog",UIWindowBase)









function UISubAct_xianjieqiyuan_AutoExchangeDialog:bindComponents()

self.okButton=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.descTxt=UIText.get(self,2)
self.goodsPanel=UIObject.get(self,3)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_xianjieqiyuan_AutoExchangeDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.goodsPanel);self.goodsPanel=nil;
end
















local _this




function UISubAct_xianjieqiyuan_AutoExchangeDialog:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_xianjieqiyuan_AutoExchangeDialog:__delete()
_this=nil
self:unbindComponents()
end




function UISubAct_xianjieqiyuan_AutoExchangeDialog:onShow(argtable,afterOnloaded)
self.dataList=argtable.itemData
self.dataCnt=#self.dataList
self.goodsPanel:setChildLayoutGroupCreateItems(self.dataCnt)
local grids=self.goodsPanel:getChildLayoutGroupGridList()
local sItemId,tItemId
for i=1,self.dataCnt do
local item=grids[i-1]
local d=self.dataList[i]
sItemId=d[1]
local sItemNum=d[2]
local itemcount,showCountBG
if sItemNum>1 then
itemcount=tostring(sItemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=sItemId,itemcount=itemcount,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local cfg=itemsConfig.getConfig(sItemId)
local funcparam=cfg.funcparam
local reward_list=funcparam.reward_list
tItemId=reward_list[1]
local tItemPer=reward_list[2]
local tItemNum=sItemNum*tItemPer
if tItemNum>1 then
itemcount=tostring(tItemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
conf={itemid=tItemId,itemcount=itemcount,showCountBG=showCountBG,showname=false}
prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
local actName=cfgHelper.get2(cfg_subactivitytypeconfig_get,SUB_ACTIVITY_TYPE.eXianJieQiYuan,"name")
local sItemName=itemsConfig.getColorName(sItemId)
local tItemName=itemsConfig.getColorName(tItemId)
self.descTxt:setText(FMT.fmt("{0}活动已结束，剩余的{1}已是否兑换为{2}？",actName,sItemName,tItemName))
end


function UISubAct_xianjieqiyuan_AutoExchangeDialog:onHide()

end



function UISubAct_xianjieqiyuan_AutoExchangeDialog:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UISubAct_xianjieqiyuan_AutoExchangeDialog:onOkButton()
bagProtocolControl.req_use_item_list(self.dataCnt,self.dataList)
self:closeSelf()
end

function UISubAct_xianjieqiyuan_AutoExchangeDialog:onCloseBtn()
self:closeSelf()
end

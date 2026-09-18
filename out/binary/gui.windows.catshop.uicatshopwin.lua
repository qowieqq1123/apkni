







def_class("UICatShopWin",UIWindowBase)









function UICatShopWin:bindComponents()

self.root=UIObject.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.receiveBtn=UIButton.get(self,2)
self.receiveText=UIText.get(self,3)
self.receiveIcon=UIObject.get(self,4)
self.scrollview=UIObject.get(self,5)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UICatShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveText);self.receiveText=nil;
_UIObject_release(self.receiveIcon);self.receiveIcon=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end
















local _itemIndex={
root=0,
item=1,
rwitem=2,
name=3,
rate=4,
rate_text=5,
sell_btn=6,
receive=7,
goto_btn=8,
sp_icon=9,
}

local _this=nil




function UICatShopWin:onLoaded(...)
self:bindComponents()

_this=self

self.costDict={}

self.rateText={}

self.scrollview:setChildScrollViewInit(0,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UICatShopWin:__delete()
self:unbindComponents()

_this=nil

uiAIManager:clearUIWinData('UICatShopWin')

notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end

function UICatShopWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this.costDict[itemid]then
_this:refreshList()
end
end

function UICatShopWin.on_money_changed(moneyType,lastVal,val)
if _this.costDict[moneyType]then
_this:refreshList()
end
end

function UICatShopWin:getRateText(rate)
local rt=self.rateText[rate]or rate
rt=FMT.fmt('{0}倍',rt)
return rt
end




function UICatShopWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UICatShopWin:onHide()

end

function UICatShopWin:refresh()
self:refreshList()
self:refreshReward()
self:refreshModel()
end

function UICatShopWin:refreshModel()
if self.isInitModel then
return
end
self.isInitModel=true
self:createCat({-376,-45},function(bt)
local widget=bt:getSharedVar('stWidget')
local index=bt:getSharedVar('stIndex')
widget:SetChildUIModelShowFlipX(index,true)
end)
end

function UICatShopWin:createCat(pos,callback)
local aiCfg=cfgHelper.get1(cfg_catshopaiconfig_get,1)
local initData={
sepaktime=aiCfg.speak_time,
speakrate=aiCfg.speak_rate,
speakHUDParent=1,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local cfg=cfgHelper.get1(cfg_catsalesmanbasicconfig_get,1)
local model=cfg.ui_model
uiAIManager:createUIObject('UICatShopWin','bt_ui_cat_shop',INSTANCE_TYPE.eUIDisciple,model,
tran,vpos,initData,nil,function(bt)
callback(bt)
end)
end

function UICatShopWin:getDatas()
local datas=UICatShopControl:getDatas()
local list={}
for k,v in pairs(datas)do
table_insert(list,v)
end
table.sort(list,function(a,b)
if not a.accept and b.accept then
return true
elseif a.accept and not b.accept then
return false
else
return a.idx<b.idx
end
end)
return list
end

function UICatShopWin:refreshList()
self.costDict={}
local datas=self:getDatas()
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
local itemId=data.item_id
local itemCount=data.item_num
self.costDict[itemId]=true
widgetHelper.setNormalRewardItem(item,_itemIndex.item,{itemId,itemCount,checkAmount=true})
widgetHelper.setNormalRewardItem(item,_itemIndex.rwitem,{data.reward_id,data.reward_num})
item:SetChildText(_itemIndex.name,data.pool_name)
local showRate=data.times>1
item:SetChildActive(_itemIndex.rate,showRate)
if showRate then
item:SetChildText(_itemIndex.rate_text,self:getRateText(data.times))
end
item:SetChildActive(_itemIndex.sell_btn,not data.accept)
item:SetChildActive(_itemIndex.receive,data.accept)
if not data.accept then
item:SetChildButtonClick(_itemIndex.sell_btn,function()
if UICatShopControl:isCanExchange(data.idx,true)then
UICatShopControl:reqExchange(data.idx)
else
gainControl:showGainWin(itemId)
end
end)
end
item:SetChildGraphicGray(_itemIndex.root,data.accept,true)
item:SetChildGraphicGray(_itemIndex.sell_btn,not UICatShopControl:isCanExchange(data.idx))

local exId=data.extra_id
if exId>0 then
item:SetChildActive(_itemIndex.sp_icon,true)
local excfg=cfgHelper.get1(cfg_catsalesmanextraconfig_get,exId)
if not UICatShopControl:checkCatShopExtraCondition(excfg.condition)then
item:SetChildActive(_itemIndex.goto_btn,true)
item:SetChildActive(_itemIndex.sell_btn,false)
item:SetChildButtonClick(_itemIndex.goto_btn,function()
jumpManager:jump(excfg.jump)
end)
else
item:SetChildActive(_itemIndex.goto_btn,false)
end
else
item:SetChildActive(_itemIndex.goto_btn,false)
item:SetChildActive(_itemIndex.sp_icon,false)
end
end
end

function UICatShopWin:refreshReward()
local rewards=UICatShopControl:getRewards()
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,5))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
if UICatShopControl:isReveive()then
self.receiveBtn:setActive(false)
self.receiveText:setText('奖励已领取')
self.receiveIcon:setActive(true)
else
local complete=UICatShopControl:isComplete()
self.receiveBtn:setActive(complete)
self.receiveText:setText('完成全部收购清单即可领取')
self.receiveIcon:setActive(false)
end
end




function UICatShopWin:onReceiveBtn()
UICatShopControl:reqReceive()
end

function UICatShopWin:onCLoseClick()

UICatShopControl:closeUI(nil,true)
end
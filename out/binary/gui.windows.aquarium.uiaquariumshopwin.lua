







def_class("UIAquariumShopWin",UIWindowBase)









function UIAquariumShopWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.cd=UIText.get(self,1)



end


function UIAquariumShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.cd);self.cd=nil;
end
















local _item_index=
{
beike=0,
icon=1,
count=2,
bg1=3,
bg2=4,
name=5,
costIcon=6,
costValue=7,
dazhe=8,
zhekou=9,
shouqing=10,
click=11,
countbg=12,
}




function UIAquariumShopWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIAquariumShopWin:__delete()
self:unbindComponents()
end

function UIAquariumShopWin:getDatas()
local datas=UIAquariumControl:getGoodsDatas()
local list={}
for k,v in pairs(datas)do
local scfg=cfgHelper.get1(cfg_yuelongchishopconfig_get,v.goodsid)
table.insert(list,{data=v,order=scfg.order})
end
table.sort(list,function(a,b)
return a.order<b.order
end)
local ret={}
for i,v in ipairs(list)do
table.insert(ret,v.data)
end
return ret
end




function UIAquariumShopWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIAquariumShopWin:getCD()
local currtime=gameUtilityModel.getServerLongTime()
local zerotime=timeHelper.getTodayZeroStamp()
local fivetime=zerotime+18000
if currtime>=fivetime then
return fivetime+86400-currtime
else
return fivetime-currtime
end
end

function UIAquariumShopWin:showCD()
self:clearTimer()
local cd=self:getCD()
local etime=gameUtilityModel.getServerLongTime()+cd
local tick=function()
local dtime=etime-gameUtilityModel.getServerLongTime()
if dtime>0 then
self.cd:setText(FMT.fmt('补货倒计时：\n{0}',timeHelper.format_time_stamp11(dtime)))
else
self.cd:setText('即将刷新')
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end

function UIAquariumShopWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIAquariumShopWin:refresh()
self:showCD()

self.datas=self:getDatas()
local len=#self.datas
len=math.ceil(len/2)
self.scrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local ii=i*2
local data=self.datas[ii-1]
local widget=item:GetChildWidgetBase(0)
self:setGoods(widget,data,ii-1)
data=self.datas[ii]
if data then
item:SetChildActive(1,true)
widget=item:GetChildWidgetBase(1)
self:setGoods(widget,data,ii)
else
item:SetChildActive(1,false)
end
end
end

function UIAquariumShopWin:setGoods(widget,data,index)
local scfg=cfgHelper.get1(cfg_yuelongchishopconfig_get,data.goodsid)
local lastNum=scfg.max-data.bought
local tipsAttach={
isBuy=lastNum>0,
index=index,
selectNumCmpArgs={
numFormat='<color=#f1ce78>数量：</color>{0}/{1}',
min=1,
max=lastNum,
curr=1,
}
}
local color=itemsConfig.getItemColor(scfg.itemid)
widget:SetChildCSImageSprite(_item_index.beike,self.abName,'image_yzgsdpinzhi_'..color)
widget:SetChildButtonClick(_item_index.click,function()
itemsComponentHelper.onItemClickEx(scfg.itemid,nil,nil,tipsAttach)
end)
widget:SetChildIcon(_item_index.icon,iconHelper.getIconName(scfg.itemid),true)
widget:SetChildText(_item_index.count,lastNum)
local boutique=scfg.boutique
widget:SetChildActive(_item_index.bg1,not boutique)
widget:SetChildActive(_item_index.bg2,boutique)
widget:SetChildText(_item_index.name,itemsConfig.getItemName(scfg.itemid))
local zkval=data.discount
local price=scfg.price
widget:SetChildIcon(_item_index.costIcon,moneyModel.getIconNameEx(price[1]),false)
local pval=math.ceil(price[2]*zkval*0.01)
widget:SetChildText(_item_index.costValue,pval)
if zkval<100 then
widget:SetChildActive(_item_index.dazhe,true)
widget:SetChildText(_item_index.zhekou,pfwindowslController:convertDiscount_yuenan(FMT.fmt('{0}折',zkval*0.1)))
else
widget:SetChildActive(_item_index.dazhe,false)
end
widget:SetChildActive(_item_index.shouqing,lastNum<=0)
widget:SetChildActive(_item_index.countbg,lastNum>1)
end

function UIAquariumShopWin:handleBuy(index,num)
local data=self.datas[index]
local scfg=cfgHelper.get1(cfg_yuelongchishopconfig_get,data.goodsid)
local price=scfg.price
local have=moneyModel.getMoney(price[1])
local zkval=data.discount
local need=math.ceil(price[2]*zkval*0.01*num)
if have>=need then
UIAquariumControl:reqBuyGoods(data.goodsid,num)
else
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(price[1])))
gainControl:showGainWin(price[1])
end
end


function UIAquariumShopWin:onHide()

end




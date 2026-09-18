







def_class("UIMoneyDetailWin",UIWindowBase)









function UIMoneyDetailWin:bindComponents()

self.Content=UIObject.get(self,0)
self.creater=UIGameobjectClone.new(self,1)
self.layout=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)



end


function UIMoneyDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end
















local cmpIndex=
{
text=0,
icon=1,
progressBar=2,
progressText=3,
name_2=4,
}
local _this



function UIMoneyDetailWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

end

function UIMoneyDetailWin:__delete()
_this=nil
self:unbindComponents()
end

function UIMoneyDetailWin:onShow(argtable,afterOnloaded)
local isInit=false
if argtable and argtable.isInit then
isInit=argtable.isInit
end



if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),18)
else
self.winlua:SetChildLocalPosX(self.layout:getID(),-300)

self:showMoneyDetailPanel(isInit)
end

self:initList()
self:refresh()
end

function UIMoneyDetailWin:onHide()

end



function UIMoneyDetailWin:create()
local argtable={
eMoneyType.mtLingCao,
eMoneyType.mtLingMu,
eMoneyType.mtTieKuang,
eMoneyType.mtXuanTie,
eMoneyType.mtFuZhi,
eMoneyType.mtZhenShi,
eMoneyType.mtLingPai,
}



local config={}
for i,v in ipairs(argtable)do
local singleInfo={}
singleInfo.name='UIChildMoneyDetail'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.args=v
config[#config+1]=singleInfo
end
self.creater:createObjectList(config)
end

function UIMoneyDetailWin:initList()
self.moneyList={
eMoneyType.mtLingCao,
eMoneyType.mtLingMu,
eMoneyType.mtTieKuang,
eMoneyType.mtXuanTie,
eMoneyType.mtFuZhi,
eMoneyType.mtZhenShi,
eMoneyType.mtLingPai,
}

if TaiXuCangModel:getBuildingData()then
self.moneyList[#self.moneyList+1]=eMoneyType.mtXianQi
self.moneyList[#self.moneyList+1]=eMoneyType.mtMoQi
end

local count=#self.moneyList
self.scrollView:setChildScrollViewCreateGrids(count,1)

self.moneyList_lookup={}
for i=1,count do
local moneyType=self.moneyList[i]
self.moneyList_lookup[moneyType]=i
end
end


function UIMoneyDetailWin:refresh()
local txcBuilding=TaiXuCangModel:getBuildingData()

local grids=self.scrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
local moneyType=self.moneyList[i]
local val=moneyModel.getMoney(moneyType)
local iconname=iconHelper.getIconName(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local max=zongmenModel:getWarehouseLimit(moneyType)
if moneyType==eMoneyType.mtLingPai then
max=moneyModel.getMoneyMax(eMoneyType.mtLingPai)
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,val,max,0)
elseif moneyType==eMoneyType.mtXianQi or moneyType==eMoneyType.mtMoQi then
if txcBuilding then

local cfg=cfgHelper.get(cfg_taixucangconfig_get,txcBuilding.level)
local protect=cfg.protect
local pMoney=protect[moneyType]
local total=math.floor(pMoney+pMoney*TaiXuCangModel:getProtectAdd(moneyType)/100)
local r=1
if val>total then r=total/val end
item:SetChildActive(4,true)
item:SetChildActive(5,true)
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,r*100,100,0)
item:SetChildAnchoredPos(5,148*(r),0)
end
else
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,val,max,0)
end
local proText=val<max and val or'满库'

item:SetChildCSImageIcon(cmpIndex.icon,iconname,true)
item:SetChildText(cmpIndex.text,moneyName)

item:SetChildText(cmpIndex.progressText,val)
end
end

function UIMoneyDetailWin:refreshMoneyItem(index)
local item=self.scrollView:getChildScrollViewItemWidget(index-1)
local moneyType=self.moneyList[index]
local val=moneyModel.getMoney(moneyType)
local iconname=iconHelper.getIconName(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local max=zongmenModel:getWarehouseLimit(moneyType)
if moneyType==eMoneyType.mtLingPai then
max=moneyModel.getMoneyMax(eMoneyType.mtLingPai)
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,val,max,0)
elseif moneyType==eMoneyType.mtXianQi or moneyType==eMoneyType.mtMoQi then
local txcBuilding=TaiXuCangModel:getBuildingData()
if txcBuilding then
local cfg=cfgHelper.get(cfg_taixucangconfig_get,txcBuilding.level)
local protect=cfg.protect
local pMoney=protect[moneyType]
local total=math.floor(pMoney+pMoney*TaiXuCangModel:getProtectAdd(moneyType)/100)
local r=1
if val>total then r=total/val end
item:SetChildActive(4,true)
item:SetChildActive(5,true)
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,r*100,100,0)

item:SetChildAnchoredPos(5,148*(r),0)
end
else
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,val,max,0)
end
local proText=val<max and val or'满库'

item:SetChildCSImageIcon(cmpIndex.icon,iconname,true)
item:SetChildText(cmpIndex.text,moneyName)

item:SetChildText(cmpIndex.progressText,val)
end


function UIMoneyDetailWin:showMoneyDetailPanel()
self:clearShowPanelTweener()
local endVal=18
self.winlua:SetChildLocalPosX(self.layout:getID(),-300)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end

function UIMoneyDetailWin:hideMoneyDetailPanel(callBack)
self:clearShowPanelTweener()
local endVal=-300
self.winlua:SetChildLocalPosX(self.layout:getID(),18)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,callBack)
end

function UIMoneyDetailWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local index=_this.moneyList_lookup[moneyType]
if index then
_this:refreshMoneyItem(index)
end
end

function UIMoneyDetailWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end
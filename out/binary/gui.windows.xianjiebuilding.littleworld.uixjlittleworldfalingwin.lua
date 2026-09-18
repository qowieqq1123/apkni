







def_class("UIXJLittleWorldFaLingWin",UIWindowBase)









function UIXJLittleWorldFaLingWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.money=UIText.get(self,1)
self.money2=UIText.get(self,2)
self.moneyIcon=UIImage.get(self,3)
self.moneyIcon2=UIImage.get(self,4)
self.scroll=UIObject.get(self,5)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXJLittleWorldFaLingWin")end)



end


function UIXJLittleWorldFaLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.money);self.money=nil;
_UIObject_release(self.money2);self.money2=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyIcon2);self.moneyIcon2=nil;
_UIObject_release(self.scroll);self.scroll=nil;
end



















function UIXJLittleWorldFaLingWin:onLoaded(...)
self:bindComponents()
self.cdTimer={}
end


function UIXJLittleWorldFaLingWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldFaLingWin:onShow(argtable,afterOnloaded)
local selectId=argtable and argtable.selectId
self:onListFresh(selectId)
end


function UIXJLittleWorldFaLingWin:onHide()

end

function UIXJLittleWorldFaLingWin:onListFresh(selectId)
local data={}
local lv=LittleWorldModel:getLittleWorldLevel()
local cfg=cfg_smallworldorderconfig()
local index=1
for i,v in pairs(cfg)do

table.insert(data,v)

if selectId==v.id then
index=i
end
end

local xhVal=LittleWorldModel:getLittleWorldXianghuo()or 0

local num=#data
self.scroll:setChildScrollViewCreateGrids(num,num)
local grids=self.scroll:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local flConfig=data[i]

grid:SetChildText(0,flConfig.name)
grid:SetChildIcon(1,FMT.fmt("icon_lw_faling_{0}",flConfig.icon),true)
grid:SetChildText(2,flConfig.desc)

local durtion=flConfig.durtion
local effect=flConfig.effect

local itemEffect
for i,v in ipairs(effect)do
if v[1]==1 then
itemEffect=v
break
end
end

if itemEffect then
local iconname=iconHelper.getIconName(itemEffect[2][1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
grid:SetChildText(3,FMT.fmt("立即获得：{0}<color=#549327>{1}</color>",iconStr,mathHelper.formatNumber(itemEffect[2][2])))
else
grid:SetChildText(3,durtion~=nil and FMT.fmt("持续时间：{0}",timeHelper.format_time_stamp3(durtion))or"")
end

local unlock=lv>=flConfig.unlock_lv

local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eFaLingCostChange)
local cost=mathHelper.floor(flConfig.cost*(1-(addVal/100)))

grid:SetChildText(7,flConfig.plot_desc)

local str=""
str=str..FMT.fmt("香火值：<color={1}>-{0}</color>",cost,"#c82c2c")
if flConfig.cost_stability then
str=str..FMT.fmt("\n稳定度：<color={1}>-{0}</color>",flConfig.cost_stability,"#c82c2c")
grid:SetChildLocalPosX(8,-10)
else
grid:SetChildLocalPosX(8,20)
end

grid:SetChildText(4,str)
local cd=flConfig.cd_time
local now=timeHelper.getServerShortTime()
local last=LittleWorldModel:getLastFaLingTime(flConfig.id)

grid:SetChildActive(5,unlock)
if not unlock then
grid:SetChildText(6,FMT.fmt("<color=#c82c2c>小世界{0}级解锁</color>",flConfig.unlock_lv))
else
if durtion then
if self.cdTimer[i]then
self:stopTimerByID(self.cdTimer[i])
self.cdTimer[i]=nil
end
if last then
if now-last<=durtion then
grid:SetChildText(6,FMT.fmt("持续时间：<color=#aae252>{0}</color>",timeHelper.format_time_stamp3(durtion-(now-last))))
grid:SetChildActive(5,false)
self.cdTimer[i]=self:setTimer(1,0,function()
local now=timeHelper.getServerShortTime()
grid:SetChildText(6,FMT.fmt("持续时间：<color=#aae252>{0}</color>",timeHelper.format_time_stamp3(durtion-(now-last))))
if durtion-(now-last)<0 then
self:stopTimerByID(self.cdTimer[i])
self.cdTimer[i]=nil
self:setCDTimer(i,grid,last,cd)
end
end)
else
self:setCDTimer(i,grid,last,cd)
end

end
else
self:setCDTimer(i,grid,last,cd)
end
end




grid:SetChildButtonClick(5,function()
if lv>=flConfig.unlock_lv then
if xhVal>=cost then
LittleWorldController.req_37_70(flConfig.id)
else
UIManager.error("香火值不足")
end
else
UIManager.error(FMT.fmt("小世界{0}级解锁",flConfig.unlock_lv))
end


end)
end

self.scroll:setChildScrollViewSelectItem(index-1)
self:refreshMoney()
end

function UIXJLittleWorldFaLingWin:setCDTimer(i,grid,last,cd)
if cd then
local now=timeHelper.getServerShortTime()
if last and now-last<=cd then
grid:SetChildText(6,FMT.fmt("冷却时间：<color=#f36666>{0}</color>",timeHelper.format_time_stamp3(cd-(now-last))))
grid:SetChildActive(5,false)
self.cdTimer[i]=self:setTimer(1,0,function()
local now=timeHelper.getServerShortTime()
grid:SetChildText(6,FMT.fmt("冷却时间：<color=#f36666>{0}</color>",timeHelper.format_time_stamp3(cd-(now-last))))
if cd-(now-last)<0 then
grid:SetChildText(6,"")
grid:SetChildActive(5,true)
if self.cdTimer[i]then
self:stopTimerByID(self.cdTimer[i])
self.cdTimer[i]=nil
end
end
end)
else
grid:SetChildActive(5,true)
grid:SetChildText(6,"")
end
else
grid:SetChildActive(5,true)
grid:SetChildText(6,"")
end
end

function UIXJLittleWorldFaLingWin:refreshMoney()
self.moneyIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtIncense))
self.money:setText(FMT.fmt("香火值 {0}",LittleWorldModel:getLittleWorldXianghuo()or 0))
self.money2:setText(FMT.fmt("稳定度 {0}",LittleWorldModel:getLittleWorldStability()))
end



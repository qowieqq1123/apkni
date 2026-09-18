







def_class("UISubAct_TianMoRuQin_BuyMoneyDialog",UIWindowBase)









function UISubAct_TianMoRuQin_BuyMoneyDialog:bindComponents()

self.background=UIButton.get(self,0)
self.buyBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)
self.least=UIText.get(self,3)
self.selectCntSlider=UIObject.get(self,4)
self.tips=UILinkImageText.get(self,5)
self.handleImg=UIObject.get(self,6)
self.maxCnt=UIButton.get(self,7)
self.subBtn=UIButton.get(self,8)
self.addBtn=UIButton.get(self,9)
self.selectCntText=UIText.get(self,10)

self.background:setButtonClick(function()self:onBackground()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UISubAct_TianMoRuQin_BuyMoneyDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.least);self.least=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
end















local _this=nil

local moneyEx={[2]=3}



function UISubAct_TianMoRuQin_BuyMoneyDialog:onLoaded(...)
self:bindComponents()
_this=self
self.num=1
self._onSliderChange=function(...)
self:onSliderChange(...)
end

end


function UISubAct_TianMoRuQin_BuyMoneyDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_TianMoRuQin_BuyMoneyDialog:onShow(argtable,afterOnloaded)
self.maxNum=argtable.max
self.callback=argtable.callback

self.onceNum=argtable.onceNum
self.buyId=argtable.buyId
self.least:setText(FMT.fmt("今日剩余次数：{0}",self.maxNum))

local moneys={}
for i,v in ipairs(argtable.costList)do
for j,w in ipairs(v)do
table.insert(moneys,w[1])
end
end
self:showWindow('UITopMoneyWin2',{moneys={moneys}})

self.costList={}
local sumLookup={}
for i,v in ipairs(argtable.costList)do
for j,w in ipairs(v)do
local itemdId=w[1]
local itemNum=w[2]
sumLookup[itemdId]=(sumLookup[itemdId]or 0)+itemNum
end
local temp={}
for j,w in pairs(sumLookup)do
table.insert(temp,{j,w})
end
table.sort(temp,function(a,b)
return a[1]<b[1]
end)
self.costList[i]=temp
end

self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.num,1,self.maxNum,self._onSliderChange)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.num)
end


function UISubAct_TianMoRuQin_BuyMoneyDialog:onHide()

end





function UISubAct_TianMoRuQin_BuyMoneyDialog:onBuyBtn()
local costList=self.costList[self.num]
for i,v in ipairs(costList)do
local itemId=v[1]
local need=v[2]
local enough=false
if not moneySystem:useMoney(itemId,need,function()enough=true end,WARNING_TYPE.eWarning,moneyEx[itemId])then
return
end
if not enough then
return
end
end

if self.callback then
self.callback(self.num)
end
self:closeSelf()
end



function UISubAct_TianMoRuQin_BuyMoneyDialog:onCancelBtn()
self:closeSelf()
end



function UISubAct_TianMoRuQin_BuyMoneyDialog:onMaxCnt()
self.num=self.numMax
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.num)
end



function UISubAct_TianMoRuQin_BuyMoneyDialog:onSubBtn()
if self.num<=1 then return end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.num-1)
end



function UISubAct_TianMoRuQin_BuyMoneyDialog:onAddBtn()
if self.num>=self.maxNum then return end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.num+1)
end

function UISubAct_TianMoRuQin_BuyMoneyDialog:onBackground()
self:closeSelf()
end

function UISubAct_TianMoRuQin_BuyMoneyDialog:onSliderChange(value)
local costList=self.costList[value]
if not costList then
loggerUtil.logWarnFMT("天魔入侵购买货币问题：{0},{1},{2}",value,self.maxNum,serializeHelper.serialize(self.costList))
return
end
local costStr=nil
for i,v in ipairs(costList)do
local splite=costStr and"、"or""
local costId=v[1]
local costNum=v[2]
local costIconName=iconHelper.getIconName(costId)
local costIconStr=chatEmotHelper.getIconEmotMesg(costIconName,40)
local haveNum=itemsModel.getCount(costId)
local costColor=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
if haveNum>=costNum then
costColor=FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
end
costStr=FMT.fmt('{0}{1}{2}<color={4}>{3}</color>',costStr or"",splite,costIconStr,costNum,costColor)
end

local getId=self.buyId
local getNum=value*self.onceNum
local getName=itemsConfig.getItemName(getId)
local getColor=FONT_COLOR_VAL[itemsConfig.getItemColor(getId)]

local str=FMT.fmt("是否花费{0}购买<color={3}>{1}*{2}</color>",costStr,getName,getNum,getColor)
self.tips:setText(str)
self.selectCntText:setText(value)

self.num=value
end
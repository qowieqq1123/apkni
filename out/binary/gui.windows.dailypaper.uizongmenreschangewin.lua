







def_class("UIZongmenResChangeWin",UIWindowBase)









function UIZongmenResChangeWin:bindComponents()

self.resourceList=UIObject.get(self,0)



end


function UIZongmenResChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.resourceList);self.resourceList=nil;
end

















local showMoneyType={6,4,8,5,10,9}


function UIZongmenResChangeWin:onLoaded(...)
self:bindComponents()
end


function UIZongmenResChangeWin:__delete()
self:unbindComponents()
end




function UIZongmenResChangeWin:onShow(argtable,afterOnloaded)
self.mode=argtable.mode
if self.mode==1 then
self.costDatas=self:getSellCost()
end
self:refresh()
end

function UIZongmenResChangeWin:getSellCost()
local datas=UIShopControl:getSellCountData()
local list={}
for i,v in ipairs(datas.costList or{})do
for ii,vv in ipairs(v.incomeList)do
local c=list[vv.param_1]or 0
c=c-vv.param_2
list[vv.param_1]=c
end
end

return list
end

function UIZongmenResChangeWin:refresh()
local num=#showMoneyType
self.resourceList:setChildLayoutGroupCreateItems(num)
local gridlist=self.resourceList:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]

local moneyType=showMoneyType[i]
local moneyName=moneyModel.getMoneyName(moneyType)
local moneyCnt
if self.mode==1 then
moneyCnt=self.costDatas[moneyType]or 0
else
moneyCnt=UIDailyPaperModel:checkMoneyChange(moneyType)
end
local str=''
if moneyCnt>=0 then
str=FMT.fmt('{0}+{1}',moneyName,moneyCnt)
else
str=FMT.fmt('<color=#c82c2c>{0}{1}</color>',moneyName,moneyCnt)
end
local iconName=iconHelper.getIconName(moneyType)
item:SetChildCSImageIcon(0,iconName,false)
item:SetChildText(1,str)
end
end


function UIZongmenResChangeWin:onHide()

end




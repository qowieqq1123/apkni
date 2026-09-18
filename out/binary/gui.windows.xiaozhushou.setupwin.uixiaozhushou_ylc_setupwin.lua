







def_class("UIXiaoZhuShou_YLC_SetupWin",UIWindowBase)









function UIXiaoZhuShou_YLC_SetupWin:bindComponents()

self.btnGouA=UIObject.get(self,0)
self.btnGouB=UIObject.get(self,1)
self.filterItemA_1=UIObject.get(self,2)
self.filterItemA_2=UIObject.get(self,3)
self.filterItemA_3=UIObject.get(self,4)
self.filterItemA_4=UIObject.get(self,5)
self.filterItemA_5=UIObject.get(self,6)
self.filterItemB_1=UIObject.get(self,7)
self.filterItemB_2=UIObject.get(self,8)
self.filterItemB_3=UIObject.get(self,9)
self.filterItemB_4=UIObject.get(self,10)
self.filterItemB_5=UIObject.get(self,11)
self.filterItemC_1=UIObject.get(self,12)
self.filterItemC_2=UIObject.get(self,13)
self.filterItemC_3=UIObject.get(self,14)
self.filterItemC_4=UIObject.get(self,15)
self.filterItemC_5=UIObject.get(self,16)
self.filterItemD_1=UIObject.get(self,17)
self.filterItemD_2=UIObject.get(self,18)
self.filterItemD_3=UIObject.get(self,19)
self.filterItemD_4=UIObject.get(self,20)
self.filterItemD_5=UIObject.get(self,21)
self.setAllBtnA=UIButton.get(self,22)
self.setAllBtnB=UIButton.get(self,23)

self.setAllBtnA:setButtonClick(function()self:onSetAllBtnA()end)

self.setAllBtnB:setButtonClick(function()self:onSetAllBtnB()end)
self.filterItemA={
self.filterItemA_1,
self.filterItemA_2,
self.filterItemA_3,
self.filterItemA_4,
self.filterItemA_5,
}
self.filterItemB={
self.filterItemB_1,
self.filterItemB_2,
self.filterItemB_3,
self.filterItemB_4,
self.filterItemB_5,
}
self.filterItemC={
self.filterItemC_1,
self.filterItemC_2,
self.filterItemC_3,
self.filterItemC_4,
self.filterItemC_5,
}
self.filterItemD={
self.filterItemD_1,
self.filterItemD_2,
self.filterItemD_3,
self.filterItemD_4,
self.filterItemD_5,
}



end


function UIXiaoZhuShou_YLC_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnGouA);self.btnGouA=nil;
_UIObject_release(self.btnGouB);self.btnGouB=nil;
_UIObject_release(self.filterItemA_1);self.filterItemA_1=nil;
_UIObject_release(self.filterItemA_2);self.filterItemA_2=nil;
_UIObject_release(self.filterItemA_3);self.filterItemA_3=nil;
_UIObject_release(self.filterItemA_4);self.filterItemA_4=nil;
_UIObject_release(self.filterItemA_5);self.filterItemA_5=nil;
_UIObject_release(self.filterItemB_1);self.filterItemB_1=nil;
_UIObject_release(self.filterItemB_2);self.filterItemB_2=nil;
_UIObject_release(self.filterItemB_3);self.filterItemB_3=nil;
_UIObject_release(self.filterItemB_4);self.filterItemB_4=nil;
_UIObject_release(self.filterItemB_5);self.filterItemB_5=nil;
_UIObject_release(self.filterItemC_1);self.filterItemC_1=nil;
_UIObject_release(self.filterItemC_2);self.filterItemC_2=nil;
_UIObject_release(self.filterItemC_3);self.filterItemC_3=nil;
_UIObject_release(self.filterItemC_4);self.filterItemC_4=nil;
_UIObject_release(self.filterItemC_5);self.filterItemC_5=nil;
_UIObject_release(self.filterItemD_1);self.filterItemD_1=nil;
_UIObject_release(self.filterItemD_2);self.filterItemD_2=nil;
_UIObject_release(self.filterItemD_3);self.filterItemD_3=nil;
_UIObject_release(self.filterItemD_4);self.filterItemD_4=nil;
_UIObject_release(self.filterItemD_5);self.filterItemD_5=nil;
_UIObject_release(self.setAllBtnA);self.setAllBtnA=nil;
_UIObject_release(self.setAllBtnB);self.setAllBtnB=nil;
self.filterItemA=nil;
self.filterItemB=nil;
self.filterItemC=nil;
self.filterItemD=nil;
end



















function UIXiaoZhuShou_YLC_SetupWin:onLoaded(...)
self:bindComponents()

self.datasA={'小型鱼','中型鱼','大型鱼'}
self.datasB={'绿品','蓝品','紫品','橙品','红品'}
self.btnGouA:setActive(false)
self.btnGouB:setActive(false)
self.setAllFlagA=false
self.setAllFlagB=false

local sellData=UIAquariumControl:getSellCheckData()
if sellData then
self.rcSelectA=sellData[1]
self.rcSelectB=sellData[2]
self.rcSelectC=sellData[3]
self.rcSelectD=sellData[4]
else
self.rcSelectA={}
self.rcSelectB={}
self.rcSelectC={true,true,true}
self.rcSelectD={true,true,true,true,true}
end
end


function UIXiaoZhuShou_YLC_SetupWin:__delete()
self:unbindComponents()
local data={self.rcSelectA,self.rcSelectB,self.rcSelectC,self.rcSelectD}
UIAquariumControl:setSellCheckData(data)
end




function UIXiaoZhuShou_YLC_SetupWin:onShow(argtable,afterOnloaded)
local clcikCB=function(index)
self:handleSelect(index)
end
self:setFilter(self.filterItemA,self.datasA,self.rcSelectA,0,clcikCB)
self:setFilter(self.filterItemB,self.datasB,self.rcSelectB,10,clcikCB)
self:setFilter(self.filterItemC,self.datasA,self.rcSelectC,20,clcikCB)
self:setFilter(self.filterItemD,self.datasB,self.rcSelectD,30,clcikCB)
end


function UIXiaoZhuShou_YLC_SetupWin:onHide()

end

function UIXiaoZhuShou_YLC_SetupWin:handleSelect(index)
if index<10 then
self:setSelect(self.filterItemA,self.rcSelectA,index)
elseif index<20 then
self:setSelect(self.filterItemB,self.rcSelectB,index-10)
elseif index<30 then
self:setSelect(self.filterItemC,self.rcSelectC,index-20)
else
self:setSelect(self.filterItemD,self.rcSelectD,index-30)
end
end

function UIXiaoZhuShou_YLC_SetupWin:setSelect(widgetList,selectList,index)
local item=widgetList[index]
local select=not selectList[index]
selectList[index]=select
local widget=item:getWidgetBase()
widget:SetChildActive(0,select)
end

function UIXiaoZhuShou_YLC_SetupWin:setFilter(widgetList,nameList,selectList,startIndex,clcikCB)
for i,v in ipairs(widgetList)do
local name=nameList[i]
if name then
v:setActive(true)
local widget=v:getWidgetBase()
widget:SetChildActive(0,selectList[i]==true)
widget:SetChildText(1,name)
widget:SetChildButtonClickWithID(2,clcikCB,startIndex+i)
else
v:setActive(false)
end
end
end



function UIXiaoZhuShou_YLC_SetupWin:onSetAllBtnA()
if self.setAllFlagA then
self.rcSelectA={}
self.rcSelectB={}
else
self.rcSelectA={true,true,true}
self.rcSelectB={true,true,true,true,true}
end

self.setAllFlagA=not self.setAllFlagA
self.btnGouA:setActive(self.setAllFlagA)

for i,v in ipairs(self.datasA)do
local widget=self.filterItemA[i]:getWidgetBase()
widget:SetChildActive(0,self.rcSelectA[i])
end
for i,v in ipairs(self.datasB)do
local widget=self.filterItemB[i]:getWidgetBase()
widget:SetChildActive(0,self.rcSelectB[i])
end
end

function UIXiaoZhuShou_YLC_SetupWin:onSetAllBtnB()
if self.setAllFlagB then
self.rcSelectC={}
self.rcSelectD={}
else
self.rcSelectC={true,true,true}
self.rcSelectD={true,true,true,true,true}
end

self.setAllFlagB=not self.setAllFlagB
self.btnGouB:setActive(self.setAllFlagB)

for i,v in ipairs(self.datasA)do
local widget=self.filterItemC[i]:getWidgetBase()
widget:SetChildActive(0,self.rcSelectC[i])
end
for i,v in ipairs(self.datasB)do
local widget=self.filterItemD[i]:getWidgetBase()
widget:SetChildActive(0,self.rcSelectD[i])
end
end
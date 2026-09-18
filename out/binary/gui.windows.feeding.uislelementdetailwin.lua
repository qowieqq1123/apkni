







def_class("UISLElementDetailWin",UIWindowBase)









function UISLElementDetailWin:bindComponents()

self.emScrollView=UIObject.get(self,0)
self.expScrollView=UIObject.get(self,1)



end


function UISLElementDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.emScrollView);self.emScrollView=nil;
_UIObject_release(self.expScrollView);self.expScrollView=nil;
end
















local _this




function UISLElementDetailWin:onLoaded(...)
self:bindComponents()

_this=self

self.emScrollView:setChildScrollViewInit(0,true,self.on_element_click,nil)
self.expScrollView:setChildScrollViewInit(0,true,nil,nil)
end


function UISLElementDetailWin:__delete()
self:unbindComponents()

_this=nil
end

function UISLElementDetailWin.on_element_click(num,index)
local data=_this.elementData[index+1]
local widget=_this.emScrollView:getChildScrollViewItemWidget(index)
local pos=widget:GetChildUIScreenPos(0)
UIShouLanControl:showElementInfoWin(pos,{0,-35},data[2],data[1]==1)
end




function UISLElementDetailWin:onShow(argtable,afterOnloaded)
local slId=argtable.slId
local lsId=argtable.lsId
self:setElementList(slId,lsId)
self:setExpInfoList(slId,lsId)
end


function UISLElementDetailWin:onHide()

end

function UISLElementDetailWin:setElementList(slId,lsId)
local lsData=lingshouModel:getLingShouData(lsId)
self.elementData=feedingSystem:getElementDataM(lsData.cfg)
local attrs=feedingSystem:getElementDataSL(slId,1)
local checklist={{},{}}
for i,v in ipairs(attrs)do
checklist[v[1]][v[2]]=true
end
feedingSystem:setElementList(self.winlua,self.emScrollView:getID(),self.elementData,checklist)
end

function UISLElementDetailWin:setExpInfoList(slId,lsId)




















end




function UISLElementDetailWin:onCloseCLick()
self:closeSelf()
end
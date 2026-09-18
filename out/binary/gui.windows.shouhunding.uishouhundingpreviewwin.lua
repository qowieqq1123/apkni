







def_class("UIShouHunDingPreviewWin",UIWindowBase)









function UIShouHunDingPreviewWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.scrollView_1=UIScrollView.get(self,2)
self.scrollView_2=UIScrollView.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.scrollView={
self.scrollView_1,
self.scrollView_2,
}



end


function UIShouHunDingPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollView_1);self.scrollView_1=nil;
_UIObject_release(self.scrollView_2);self.scrollView_2=nil;
self.scrollView=nil;
end















local _this=nil
local _col=4



function UIShouHunDingPreviewWin:onLoaded(...)
self:bindComponents()
_this=self

for i,v in ipairs(self.scrollView)do
self.winlua:SetChildUIBaseScrollBindAction(v:getID(),function(index,widget)
self:onItemBind(i,index,widget)
end)
self.winlua:SetChildUIBaseScrollClickAction(v:getID(),itemsComponentHelper.onItemClickEx)
end
end


function UIShouHunDingPreviewWin:__delete()
self:unbindComponents()
_this=nil
end




function UIShouHunDingPreviewWin:onShow(argtable,afterOnloaded)
self:getScrollViewData()
for i,v in ipairs(self.scrollView)do
self:refreshScrollView(i)
end
end


function UIShouHunDingPreviewWin:onHide()

end




function UIShouHunDingPreviewWin:onCloseBtn()
UIFullXJForceControl:closeWindow(self.__name)
end

function UIShouHunDingPreviewWin:onBackground()
self:closeSelf()
end

function UIShouHunDingPreviewWin:getScrollViewData()
self.data=shouhundingModel:getPreviewData()
end

function UIShouHunDingPreviewWin:refreshScrollView(index)
local dataList=self.data[index]
local scrollView=self.scrollView[index]
local count=#dataList
local row=math.ceil(count/_col)
self.winlua:SetChildUIBaseScrollGridsByNum(scrollView:getID(),count,row,_col,false)
end

function UIShouHunDingPreviewWin:onItemBind(viewIdx,itemIdx,widget)
local itemId=self.data[viewIdx][itemIdx]
if itemId then
local _conf={itemid=itemId,itemcount="",showCountBG=false,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
widget:SetChildPropData(-1,_prop)
end
end

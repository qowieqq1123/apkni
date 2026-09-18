







def_class("UIWanBaoXunBaoDui_SelectItemNumWin",UIWindowBase)









function UIWanBaoXunBaoDui_SelectItemNumWin:bindComponents()

self.root=UIObject.get(self,0)
self.bg=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.sliderpart=UIObject.get(self,3)
self.numSlider=UISlider.get(self,4)
self.reduce=UIButton.get(self,5)
self.add=UIButton.get(self,6)
self.num=UIText.get(self,7)
self.operateBtn=UIButton.get(self,8)

self.reduce:setButtonClick(function()self:onReduce()end)

self.add:setButtonClick(function()self:onAdd()end)

self.operateBtn:setButtonClick(function()self:onOperateBtn()end)



end


function UIWanBaoXunBaoDui_SelectItemNumWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.sliderpart);self.sliderpart=nil;
_UIObject_release(self.numSlider);self.numSlider=nil;
_UIObject_release(self.reduce);self.reduce=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.operateBtn);self.operateBtn=nil;
end



















function UIWanBaoXunBaoDui_SelectItemNumWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_SelectItemNumWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_SelectItemNumWin:onShow(argtable,afterOnloaded)
self.itemid=argtable.itemid
self.guid=argtable.guid
self.maxNum=argtable.maxNum
self.callback=argtable.callback
self.selectNum=0
local itemconfig=itemsConfig.getConfig(self.itemid)
local num=itemsModel.getCount(self.itemid)
self.name:setText(itemconfig.name)
self.maxNum=math.min(self.maxNum,num)


self.numSlider:setChildSliderInit(self.maxNum,0,self.maxNum,function(value)
self.selectNum=value
self.num:setText(value)
end)
self.num:setText(self.maxNum)
end


function UIWanBaoXunBaoDui_SelectItemNumWin:onHide()

end





function UIWanBaoXunBaoDui_SelectItemNumWin:onReduce()
if self.selectNum-1>=0 then
self.selectNum=self.selectNum-1
self.numSlider:setChildSliderValue(self.selectNum)
self.num:setText(self.selectNum)
end
end



function UIWanBaoXunBaoDui_SelectItemNumWin:onAdd()
if self.selectNum+1<=self.maxNum then
self.selectNum=self.selectNum+1
self.numSlider:setChildSliderValue(self.selectNum)
self.num:setText(self.selectNum)
end
end



function UIWanBaoXunBaoDui_SelectItemNumWin:onOperateBtn()
self.callback(self.itemid,self.guid,self.selectNum)
self:closeSelf()
end


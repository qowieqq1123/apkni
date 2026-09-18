







def_class("UISubAct_xianguyijiWin_ShowPrizeTop",UIWindowBase)









function UISubAct_xianguyijiWin_ShowPrizeTop:bindComponents()

self.nameImg=UIImage.get(self,0)
self.numTx=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.tipsTx=UILinkImageText.get(self,3)



end


function UISubAct_xianguyijiWin_ShowPrizeTop:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end















local _abName="ui/windows/activities/sub_xianguyiji/xianguyiji_base_atlas_pak.ab"



function UISubAct_xianguyijiWin_ShowPrizeTop:onLoaded(...)
self:bindComponents()
end


function UISubAct_xianguyijiWin_ShowPrizeTop:__delete()
self:unbindComponents()
end




function UISubAct_xianguyijiWin_ShowPrizeTop:onShow(argtable,afterOnloaded)

if argtable then
self.numTx:setText(argtable.num or"")
if argtable.name then
self.nameImg:setSprite(_abName,argtable.name)
else
self.nameImg:setImageIcon("",false)
end
self.winlua:ForceLayoutRect(self.root:getID())
self.tipsTx:setText(argtable.tips or"")
end
end


function UISubAct_xianguyijiWin_ShowPrizeTop:onHide()

end












def_class("UISubAct_dongtianfudi_posLock_Win",UIWindowBase)









function UISubAct_dongtianfudi_posLock_Win:bindComponents()

self.tip1=UIText.get(self,0)
self.tip2=UIText.get(self,1)
self.tip3=UIText.get(self,2)
self.spinebg=UIObject.get(self,3)
self.root=UIObject.get(self,4)



end


function UISubAct_dongtianfudi_posLock_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tip1);self.tip1=nil;
_UIObject_release(self.tip2);self.tip2=nil;
_UIObject_release(self.tip3);self.tip3=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.root);self.root=nil;
end


















local _this=nil

function UISubAct_dongtianfudi_posLock_Win:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_dongtianfudi_posLock_Win:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_dongtianfudi_posLock_Win:onShow(argtable,afterOnloaded)
self.tip1:setText("定位功能开启后,祖师可定位<color=#CA631D>洞天福地</color>,将只会在该福地中进行探索")
self.tip2:setText("(探索时只会获得定位福地特有的宝物奖励)")
self.tip3:setText(FMT.fmt("再探索<color=#C82C2C>{0}</color>次洞天福地可开启定位功能",argtable and argtable[1]or 0))
_this.root:setChildCanvasGroupDOFade(1,0.5)
self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,true,0.3,nil)
end


function UISubAct_dongtianfudi_posLock_Win:onHide()

end



function UISubAct_dongtianfudi_posLock_Win:onClickClose()
self:closeSelf()
end

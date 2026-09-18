







def_class("UIXianGongShiLiWin",UIWindowBase)









function UIXianGongShiLiWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.click_JiuYuan=UIButton.get(self,1)
self.click_PengLai=UIButton.get(self,2)
self.click_XianGong=UIButton.get(self,3)
self.click_YuJing=UIButton.get(self,4)
self.desc_JiuYuan=UIText.get(self,5)
self.desc_PengLai=UIText.get(self,6)
self.desc_XianGong=UIText.get(self,7)
self.desc_YuJing=UIText.get(self,8)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.click_JiuYuan:setButtonClick(function()self:onClick_JiuYuan()end)

self.click_PengLai:setButtonClick(function()self:onClick_PengLai()end)

self.click_XianGong:setButtonClick(function()self:onClick_XianGong()end)

self.click_YuJing:setButtonClick(function()self:onClick_YuJing()end)
self.click={
["JiuYuan"]=self.click_JiuYuan,
["PengLai"]=self.click_PengLai,
["XianGong"]=self.click_XianGong,
["YuJing"]=self.click_YuJing,
}
self.desc={
["JiuYuan"]=self.desc_JiuYuan,
["PengLai"]=self.desc_PengLai,
["XianGong"]=self.desc_XianGong,
["YuJing"]=self.desc_YuJing,
}



end


function UIXianGongShiLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.click_JiuYuan);self.click_JiuYuan=nil;
_UIObject_release(self.click_PengLai);self.click_PengLai=nil;
_UIObject_release(self.click_XianGong);self.click_XianGong=nil;
_UIObject_release(self.click_YuJing);self.click_YuJing=nil;
_UIObject_release(self.desc_JiuYuan);self.desc_JiuYuan=nil;
_UIObject_release(self.desc_PengLai);self.desc_PengLai=nil;
_UIObject_release(self.desc_XianGong);self.desc_XianGong=nil;
_UIObject_release(self.desc_YuJing);self.desc_YuJing=nil;
self.click=nil;
self.desc=nil;
end



















function UIXianGongShiLiWin:onLoaded(...)
self:bindComponents()
end


function UIXianGongShiLiWin:__delete()
self:unbindComponents()
end




function UIXianGongShiLiWin:onShow(argtable,afterOnloaded)
local shiLiCfg=cfg_xianjieforceconfig()
self.desc_YuJing:setText(shiLiCfg[1].shiLiDesc)
self.desc_XianGong:setText(shiLiCfg[2].shiLiDesc)
self.desc_PengLai:setText(shiLiCfg[3].shiLiDesc)
self.desc_JiuYuan:setText(shiLiCfg[4].shiLiDesc)
end


function UIXianGongShiLiWin:onHide()

end


function UIXianGongShiLiWin:onBtnClose()
self:closeSelf()
end

function UIXianGongShiLiWin:onClick_XianGong()
self:showWindow("UIXianGongShiLiDetailsWin",1)
end

function UIXianGongShiLiWin:onClick_YuJing()
self:showWindow("UIXianGongShiLiDetailsWin",2)
end

function UIXianGongShiLiWin:onClick_PengLai()
self:showWindow("UIXianGongShiLiDetailsWin",3)
end

function UIXianGongShiLiWin:onClick_JiuYuan()
self:showWindow("UIXianGongShiLiDetailsWin",4)
end
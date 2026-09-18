







def_class("UISFPYfazetipsWin",UIWindowBase)









function UISFPYfazetipsWin:bindComponents()

self.arrow1=UIObject.get(self,0)
self.skillDescTxt=UIText.get(self,1)
self.skillIcon=UIImage.get(self,2)
self.tiptxtbtn=UIButton.get(self,3)
self.arrow2=UIObject.get(self,4)
self.arrowbtn=UIButton.get(self,5)
self.faZeList=UIObject.get(self,6)
self.fazeMask=UIButton.get(self,7)

self.tiptxtbtn:setButtonClick(function()self:onTiptxtbtn()end)

self.arrowbtn:setButtonClick(function()self:onArrowbtn()end)

self.fazeMask:setButtonClick(function()self:onFazeMask()end)



end


function UISFPYfazetipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow1);self.arrow1=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.tiptxtbtn);self.tiptxtbtn=nil;
_UIObject_release(self.arrow2);self.arrow2=nil;
_UIObject_release(self.arrowbtn);self.arrowbtn=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.fazeMask);self.fazeMask=nil;
end



















function UISFPYfazetipsWin:onLoaded(...)
self:bindComponents()
end


function UISFPYfazetipsWin:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UISiFangPingYaoMainWin","onFazeMask")
end




function UISFPYfazetipsWin:onShow(argtable,afterOnloaded)
local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local ygzj_cfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local faze_list=ygzj_cfg.faze_list
local issz=SiFangPingYaoController:checkshangzhendz()
if issz then
faze_list=ygzj_cfg.faze_list3
end

self.faZeList:setChildScrollViewCreateGrids(#faze_list,1)
local grids=self.faZeList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local id=faze_list[i][1]
local cfg=cfgHelper.getSSlawRule(id)
grid:SetChildCSImageIcon(1,cfg.image,false)
grid:SetChildText(0,cfg.name)
grid:SetChildText(2,cfg.desc)
end
end


function UISFPYfazetipsWin:onHide()

end





function UISFPYfazetipsWin:onTiptxtbtn()
end


function UISFPYfazetipsWin:onArrowbtn()
end


function UISFPYfazetipsWin:onFazeMask()
UIManager:closeWindow("UISFPYfazetipsWin")
end


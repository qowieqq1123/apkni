







def_class("UI_win_lotteryRule",UIWindowBase)









function UI_win_lotteryRule:bindComponents()

self.list=UIObject.get(self,0)



end


function UI_win_lotteryRule:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end
















local _this=nil



function UI_win_lotteryRule:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_win_lotteryRule:__delete()
self:unbindComponents()
_this=nil
end




function UI_win_lotteryRule:onShow(argtable,afterOnloaded)



self.configstr=argtable.configstr
self.configidx=argtable.configidx or 1
local config={}
if'UIMoJie_SYMZMainWin'==self.configstr then
config=cfg_devildomshenyuanmizangconfig_get(self.configidx)
if not config then
config=cfg_devildomshenyuanmizangconfig_get(1)
end
end

local datas=config.reward_rule
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local str=datas[index]
item:SetChildText(0,str)
end)
self.winlua:ForceLayoutRect(self.list:getID())
end


function UI_win_lotteryRule:onHide()

end




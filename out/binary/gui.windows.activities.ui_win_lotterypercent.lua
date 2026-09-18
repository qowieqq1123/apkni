







def_class("UI_win_lotteryPercent",UIWindowBase)









function UI_win_lotteryPercent:bindComponents()

self.list=UIObject.get(self,0)



end


function UI_win_lotteryPercent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end
















local _this=nil




function UI_win_lotteryPercent:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_win_lotteryPercent:__delete()
self:unbindComponents()
_this=nil
end




function UI_win_lotteryPercent:onShow(argtable,afterOnloaded)



self.configstr=argtable.configstr
self.configidx=argtable.configidx or 1
local config={}
if'UIMoJie_SYMZMainWin'==self.configstr then
config=cfg_devildomshenyuanmizangconfig_get(self.configidx)
if not config then
config=cfg_devildomshenyuanmizangconfig_get(1)
end
end

local datas=config.reward_percent
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
item:SetChildText(0,data[1])
item:SetChildText(1,FMT.fmt("{0}%",data[2]/100))
end)
end


function UI_win_lotteryPercent:onHide()

end




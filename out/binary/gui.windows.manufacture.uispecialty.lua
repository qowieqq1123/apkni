







def_class("UISpecialty",UIWindowBase)









function UISpecialty:bindComponents()

self.title=UIText.get(self,0)
self.scrollview=UIObject.get(self,1)
self.tipsBtn=UIButton.get(self,2)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UISpecialty:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
end



















function UISpecialty:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISpecialty:__delete()
self:unbindComponents()
end




function UISpecialty:onShow(argtable,afterOnloaded)
self.bdData=argtable
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.title:setText(FMT.fmt('{0}特产',cfg.name))
self:refreshItemList()
end


function UISpecialty:onHide()

end

function UISpecialty:refreshItemList()
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
local specialty=cfg.specialty
local level=zongmenModel:getLevel()
local rewards
for i,v in ipairs(specialty)do
if level>=v[1]and level<=v[2]then
rewards=v[3]
end
end
if not rewards then
rewards=specialty[1][3]
end
if not rewards then
return
end
self.scrollview:setChildScrollViewCreateGrids(#rewards,4)

local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{data,0})
end
end




function UISpecialty:onTipsBtn()
UIManager:showWindow('UICommonHelpWin',{x=-175,y=250,htype=3,overflow={1,1},content=cfgHelper.getlang('specialty_help')})
end

function UISpecialty:onCloseClick()
self:closeSelf()
end
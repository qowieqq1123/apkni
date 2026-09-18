







def_class("UIAquariumMarketWin",UIWindowBase)









function UIAquariumMarketWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.jindu1=UIObject.get(self,2)
self.jindu2=UIObject.get(self,3)
self.jindu3=UIObject.get(self,4)
self.tips=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)
self.up_value_1=UIText.get(self,7)
self.up_value_2=UIText.get(self,8)
self.up_value_3=UIText.get(self,9)
self.up_value={
self.up_value_1,
self.up_value_2,
self.up_value_3,
}



end


function UIAquariumMarketWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jindu1);self.jindu1=nil;
_UIObject_release(self.jindu2);self.jindu2=nil;
_UIObject_release(self.jindu3);self.jindu3=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.up_value_1);self.up_value_1=nil;
_UIObject_release(self.up_value_2);self.up_value_2=nil;
_UIObject_release(self.up_value_3);self.up_value_3=nil;
self.up_value=nil;
end



















function UIAquariumMarketWin:onLoaded(...)
self:bindComponents()

self.dyABName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.root:setChildCanvasGroupAlpha(0)
self.model:setChildUIModelShowTarget(4497,1,nil,eAnimationID.enter)
self.tweener=self.root:setChildCanvasGroupDOFade(1,0.5,nil)
self.tweener:SetDelay(0.75)
end

function UIAquariumMarketWin:stopTweener()
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
end


function UIAquariumMarketWin:__delete()
self:unbindComponents()
self:stopTweener()
UIManager:callWindowFunc('UIAquariumBagWin','setMarketBtn')
end

function UIAquariumMarketWin:getDatas()
local datas=UIAquariumControl:getReclaimData()
local list={}
for k,v in pairs(datas)do
table.insert(list,k)
end
return list
end




function UIAquariumMarketWin:onShow(argtable,afterOnloaded)
local mval1=UIAquariumControl:getMarketValue(1)
self.up_value_1:setText(FMT.fmt('{0}%',mval1))
local mval2=UIAquariumControl:getMarketValue(2)
self.up_value_2:setText(FMT.fmt('{0}%',mval2))
local mval3=UIAquariumControl:getMarketValue(3)
self.up_value_3:setText(FMT.fmt('{0}%',mval3))

local hval1=mval1*0.01*210
self.jindu1:setChildSizeDeltaEx(3,0,hval1)
local hval2=mval2*0.01*210
self.jindu2:setChildSizeDeltaEx(3,0,hval2)
local hval3=mval3*0.01*210
self.jindu3:setChildSizeDeltaEx(3,0,hval3)

local datas=self:getDatas()
local len=#datas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local hbId=datas[i]
local info=UIAquariumControl:getInfoCfgByHBId(hbId)
local cfg=itemsConfig.getConfig(info.show_item)
item:SetChildCSImageSprite(0,self.dyABName,'image_cyhyyupj_'..cfg.color)
item:SetChildIcon(1,iconHelper.getIconName(cfg.icon),true)
item:SetChildButtonClick(1,function()
itemsComponentHelper.onItemClickEx(info.show_item)
end)
end

self.tips:setText(FMT.fmt('今日以下鱼类将达到{0}%涨幅收取',UIAquariumControl:getReclaimValue()))
end


function UIAquariumMarketWin:onHide()

end




function UIAquariumMarketWin:onCloseClick()
self:closeSelf()
end
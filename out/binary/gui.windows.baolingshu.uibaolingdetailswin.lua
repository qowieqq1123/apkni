







def_class("UIBaoLingDetailsWin",UIWindowBase)









function UIBaoLingDetailsWin:bindComponents()

self.scrollerView=UIObject.get(self,0)



end


function UIBaoLingDetailsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
end



















function UIBaoLingDetailsWin:onLoaded(...)
self:bindComponents()
local _onClickItem=function(...)
self:onClickItemCallback(...)
end
self.scrollerView:setChildScrollViewInit(0.5,true,_onClickItem,nil)
end


function UIBaoLingDetailsWin:__delete()
self:unbindComponents()
end




function UIBaoLingDetailsWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.showType=argtable and argtable.showType or 1
local cjType=argtable.cjType
local allConfig
if self.showType==1 then
allConfig=cfgHelper.get1(cfg_baolingtreeprobabilityconfig_get,cjType)
elseif self.showType==2 then

local actId=qiYuanShuModel:getQiYuanActId()or-1
allConfig=cfgHelper.get1(cfg_wishtreeprobabilityconfig_get,actId)
end
local list={}
local isInPickUpNow=false
if cjType==1 and self.showType==1 then

isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
end
for i,v in ipairs(allConfig)do
if not isInPickUpNow then
if v.rates~=nil then
table.insert(list,v)
end
else
if v.pickUpRates~=nil then
table.insert(list,v)
end
end
end
table.sort(list,function(a,b)
return a.sortid<b.sortid
end)


self.scrollerView:setChildScrollViewCreateGrids(#list,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local config=list[i]
if item then
local titleName=config.typeName
local color=config.gubaoColor
if config.gubaoColor then
local colorlookup=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
if colorlookup[config.gubaoColor]then
titleName=colorlookup[config.gubaoColor]
end
end
if color then
item:SetChildText(0,FMT.cfmt(config.gubaoColor,titleName))
else
item:SetChildText(0,titleName)
end
local rateCfg
if not isInPickUpNow then
rateCfg=config.rates
else
rateCfg=config.pickUpRates
end
local rewards
if self.showType==1 then
rewards=baoLingShuModel:getShowDatas(rateCfg)
elseif self.showType==2 then
rewards=qiYuanShuModel:getShowDatas(rateCfg)
end
local probability=rewards[3]
if color then
item:SetChildText(1,FMT.cfmt(config.gubaoColor,'{0}%',probability))
else
item:SetChildText(1,FMT.fmt('{0}%',probability))
end
end
end
end
end


function UIBaoLingDetailsWin:onHide()

end




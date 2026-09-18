







def_class("UI_XJYZ_resultWin",UIWindowBase)









function UI_XJYZ_resultWin:bindComponents()

self.conditionScrollView=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)
self.notRewardTxt=UIText.get(self,2)
self.rewardPanel=UIObject.get(self,3)
self.title=UIText.get(self,4)



end


function UI_XJYZ_resultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.conditionScrollView);self.conditionScrollView=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.notRewardTxt);self.notRewardTxt=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UI_XJYZ_resultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_XJYZ_resultWin:__delete()
self:unbindComponents()
_this=nil
end




function UI_XJYZ_resultWin:onShow(argtable,afterOnloaded)
local gx_id=argtable.gx_id
local rewards=argtable.rewards or{}
local isFrist=argtable.isFrist
local star=argtable.star
local oldStarList=argtable.oldStarList
local starList=XianJunYanZhenModel:getGxStarList(gx_id)

local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,gx_id)

self.notRewardTxt:setActive(not isFrist)
self.rewardPanel:setActive(isFrist)
self.title:setActive(isFrist)
if isFrist then
local num=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(num)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local reward=rewards[i]
local itemid=reward.itemid
local itemNum=reward.num
local itemcount,showCountBG
if itemNum>1 then
itemcount=mathHelper.formatNumber(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

local starLen=#cfg.star_conf+1
self.conditionScrollView:setChildScrollViewCreateGrids(starLen,starLen)
local grids=self.conditionScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local isWc=true
local oldHasStar=true
if i>1 then
isWc=starList[i-1]~=nil
oldHasStar=oldStarList[i-1]~=nil
end
local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
widget:SetChildCSImageSprite(0,abname,isWc and"image_xianjunyanzhen_rw02"or"image_xianjunyanzhen_rw01")

local desc,isLock=XianJunYanZhenModel:getDescStr(gx_id,cfg.star_conf[i-1],i,oldHasStar and isWc)
widget:SetChildActive(1,not isLock)
widget:SetChildActive(3,isLock)
if isLock then
widget:SetChildText(2,FMT.cfmt1(FONT_COLOR.eGrayColor,'{0}',desc))
else
widget:SetChildCSImageSprite(1,globalABLookup.global,isWc and"icon_tydxingxing_1"or"icon_tydxingxing_2")
local color=isWc and FONT_COLOR.eTitle2Color or FONT_COLOR.eGrayWhiteTxtColor
widget:SetChildText(2,FMT.cfmt(color,'{0}',desc))
end
end
local len=math.min(starLen,3)
self.conditionScrollView:setChildSizeDelta(370*len,46)
self.conditionScrollView:setChildScrollRectEnable(starLen>3)
end

function UI_XJYZ_resultWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId})
end


function UI_XJYZ_resultWin:onHide()

end





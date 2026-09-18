







def_class("UIXianGouGuangGaoDialogWin",UIWindowBase)









function UIXianGouGuangGaoDialogWin:bindComponents()

self.title=UIText.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.sureBtn=UIButton.get(self,2)
self.skipBtn=UIButton.get(self,3)
self.textRoot=UIObject.get(self,4)
self.itemName=UIText.get(self,5)
self.icon2=UIImage.get(self,6)
self.cost=UIText.get(self,7)
self.buyLimit=UIText.get(self,8)
self.dialogText=UILinkImageText.get(self,9)
self.icon=UIImage.get(self,10)
self.buyLimit3=UIText.get(self,11)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIXianGouGuangGaoDialogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.textRoot);self.textRoot=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.buyLimit);self.buyLimit=nil;
_UIObject_release(self.dialogText);self.dialogText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.buyLimit3);self.buyLimit3=nil;
end



















function UIXianGouGuangGaoDialogWin:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIXianGouGuangGaoDialogWin:__delete()
self:unbindComponents()
end




function UIXianGouGuangGaoDialogWin:onShow(argtable,afterOnloaded)
self.config=argtable
self.title:setText(argtable.name)
local itemid=cfg_advertconfig().const_def.itemid
self.price={itemid,1}

self.supportPlayflag=adController:supportPlayAD()

local itemId=self.price[1]
local cost=self.price[2]
local icon=iconHelper.getIconName(itemId)
local name=itemsConfig.getItemName(itemId)
self.buyLimit:setText(name)
self.itemName:setText(name)
self.icon:setChildIcon(icon)
self.icon2:setChildIcon(icon)
local dialogName=FMT.fmt("<color=#7D3B17>{0}</color>",name)
local iconStr=chatEmotHelper.getIconEmotMesg(icon,32)
local str=argtable.dialog or"是否观看广告或者使用{0}{1}获得奖励？"
self.dialogText:setText(FMT.fmt(str,iconStr,dialogName))
if not self.supportPlayflag then
local str="是否观看广告获得奖励？"
self.dialogText:setText(FMT.fmt(str))
self.dialogText:setChildAnchoredPosition(Vector3(32,-42,0))
end

if argtable.rewards then
local rewards=rechargeModel:getXianGouLiBaoRewards(argtable.rewards)
self.scrollerView:setChildScrollViewCreateGrids(#rewards,#rewards)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
else
self.scrollerView:setActive(false)
self.textRoot:setChildAnchoredPosition(Vector3(0,25,0))
end
if itemsModel.getCount(self.price[1])>=self.price[2]then
self.cost:setText(FMT.fmt("{0}/{1}",itemsModel.getCount(self.price[1]),self.price[2]))
else
self.cost:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",itemsModel.getCount(self.price[1]),self.price[2]))
end

if not self.supportPlayflag then
self.buyLimit3:setActive(false)
self.skipBtn:setActive(false)
self.sureBtn:setChildAnchoredPosition(Vector3(22,-117,0))
end
end


function UIXianGouGuangGaoDialogWin:onHide()

end

function UIXianGouGuangGaoDialogWin:onClickRewardItem(clickCount,index)
local cfgs=self.config.rewards
local rewards=rechargeModel:getXianGouLiBaoRewards(cfgs)
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end





function UIXianGouGuangGaoDialogWin:onSureBtn()

local cb=self.config.callback
if self.config.extra then
local id=self.config.extra.id
local ext=self.config.extra.ext
adController:playAD(id,ext,cb,0)
else
local id=self.config.adid
local ext=adController:getParam(self.config.id)
adController:playAD(id,ext,cb,0)
end

self:closeSelf()
end



function UIXianGouGuangGaoDialogWin:onSkipBtn()
local cb=self.config.callback
if self.config.extra then
local id=self.config.extra.id
local ext=self.config.extra.ext
adController:playAD(id,ext,cb,1)
else
local id=self.config.adid
local ext=adController:getParam(self.config.id)
adController:playAD(id,ext,cb,1)
end

self:closeSelf()
end


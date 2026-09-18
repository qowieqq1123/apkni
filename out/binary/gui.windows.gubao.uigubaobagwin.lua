







def_class("UIGuBaoBagWin",UIWindowBase)









function UIGuBaoBagWin:bindComponents()

self.creater=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.noGoodTips=UIObject.get(self,2)



end


function UIGuBaoBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.noGoodTips);self.noGoodTips=nil;
end
















local _this=nil


function UIGuBaoBagWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGuBaoBagWin:__delete()
self:unbindComponents()
_this=nil
end


function UIGuBaoBagWin:onHide()

end

function UIGuBaoBagWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function UIGuBaoBagWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

local func=function()
self:initGoodListPanel()
end
if afterOnloaded then
self:delayDo(0.1,func)
else
func()
end
end

function UIGuBaoBagWin:onShowArgRecv(argtable)
self:initGoodListPanel()
end

function UIGuBaoBagWin:getGoodList()
local list=gubaoLookup:getGoodsSortList()
self.goodlist=list
end

function UIGuBaoBagWin:initGoodListPanel()
self:getGoodList()
local pagenum=#self.goodlist
local func=function(idx)
local item=self.creater:getChildLayoutGroupGridItem(idx-1)
self:refreshPageItem(item,idx)
end
self.creater:setChildLayoutGroupCreateItems(pagenum,func)
self.noGoodTips:setActive(pagenum<=0)





end

function UIGuBaoBagWin:getPageName(pageData)
if pageData.typo==1 then

return'可激活'
elseif pageData.typo==2 then

return'未激活'
elseif pageData.typo==3 then

return'已激活'
elseif pageData.typo==4 then

return'通用碎片'
elseif pageData.typo==5 then

return'混沌古宝碎片'
end
end

function UIGuBaoBagWin:refreshPageItem(item,pageidx)
local pageData=self.goodlist[pageidx]
local name=self:getPageName(pageData)
item:SetChildText(0,name)

local childnum=#pageData.childlist
local func=function(idx)
local childItem=item:GetChildLayoutGroupGridItem(1,idx-1)
childItem:SetChildButtonClick(2,function()
self:onChildItemClick(pageidx,idx)
end)
self:refreshChildItem(childItem,pageidx,idx)
end
item:SetChildLayoutGroupCreateItems(1,childnum,func)








end

function UIGuBaoBagWin:refreshChildItem(item,pageidx,childidx)
local pageData=self.goodlist[pageidx]
local itemData=pageData.childlist[childidx]
local itemid=itemData.itemid
local gbid=gubaoLookup:good2GuBao(itemid)


local num=itemData.itemcount
local num_str
local showCountBG
if num>1 then
num_str=tostring(num)
showCountBG=true
else
num_str=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=num_str,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)

local name_str
if gbid then
local gbcfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
name_str=gbcfg.name
else
name_str=itemsConfig.getItemName(itemid)
end
item:SetChildText(3,name_str)

local showProgress=pageData.typo==2
item:SetChildActive(1,showProgress)
if showProgress then
local cur=bagModel.getItemCountById(itemid)
local max=cfgHelper.get3(cfg_gubaoconfig_get,gbid,'active',itemid)
if cur>max then cur=max end
item:SetChildProgressValue(1,cur,max)
item:SetChildProgressText(1,string.format('%d/%d',cur,max))
end

local reddot=false
if pageData.typo==2 then

reddot=gubaoLookup:checkEnoughPieceGoodWithChangePiece(gbid)
end
item:SetChildActive(4,reddot)
end



function UIGuBaoBagWin:onChildItemClick(pageidx,childidx)
local pageData=self.goodlist[pageidx]
local itemData=pageData.childlist[childidx]
local itemid=itemData.itemid
local gbid=gubaoLookup:good2GuBao(itemid)
local tipsType
if gbid then
tipsType=TIPS_TYPE.eCommonGubaoMetrial
else
tipsType=TIPS_TYPE.eCommonGubaoMetrial2
end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGubaoBag,tipsType=tipsType,itemid=itemid,itemguid=itemData.itemguid})
end

function UIGuBaoBagWin:onRewardBtn()
UIManager:showWindow('UIGuBaoRewardWin')
end


function UIGuBaoBagWin:rec_active(gbid)
self:initGoodListPanel()
end

function UIGuBaoBagWin:rec_fenjie(goodlist)
self:initGoodListPanel()
end
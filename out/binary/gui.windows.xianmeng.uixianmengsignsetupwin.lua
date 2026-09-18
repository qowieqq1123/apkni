







def_class("UIXianMengSignSetupWin",UIWindowBase)









function UIXianMengSignSetupWin:bindComponents()

self.signBGIcon=UIImage.get(self,0)
self.signKuangIcon=UIImage.get(self,1)
self.signIcon=UIImage.get(self,2)
self.changeBtnText=UIText.get(self,3)
self.costObj=UIButton.get(self,4)
self.costNumTxt=UIText.get(self,5)
self.costIcon=UIImage.get(self,6)
self.itemGridPanel=UIObject.get(self,7)
self.pageBtnsGrid=UIObject.get(self,8)

self.costObj:setButtonClick(function()self:onCostObj()end)



end


function UIXianMengSignSetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.changeBtnText);self.changeBtnText=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.costNumTxt);self.costNumTxt=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
_UIObject_release(self.pageBtnsGrid);self.pageBtnsGrid=nil;
end

















local pageConfig=
{
[xianmengIconType.eIcon]={
name='图案',
},
[xianmengIconType.eBG]={
name='底图',
},
[xianmengIconType.eKuang]={
name='边框',
},
}
local _this=nil


function UIXianMengSignSetupWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageTypeList={
xianmengIconType.eIcon,
xianmengIconType.eBG,

}
end


function UIXianMengSignSetupWin:__delete()

AudioManager.playCloseUI()
_this=nil
self:unbindComponents()
end


function UIXianMengSignSetupWin:onHide()

end

function UIXianMengSignSetupWin:resetSelectIndex()
local defaultImage=self.oldSignImage
local curSelectType=nil
local defaultIconID=nil
local curIconID=nil
if self.page==xianmengIconType.eIcon then
curIconID=self.signImage.icon
defaultIconID=defaultImage.icon
elseif self.page==xianmengIconType.eBG then
curIconID=self.signImage.bg
defaultIconID=defaultImage.bg
elseif self.page==xianmengIconType.eKuang then
curIconID=self.signImage.kuang
defaultIconID=defaultImage.kuang
end
self.defaultIconID=defaultIconID
self.selectlist=cfgHelper.get1(cfg_guildiconconfig_get,self.page)or{}
self.curSelectIndex=nil
for i,v in ipairs(self.selectlist)do
if v.partid==curIconID then
self.curSelectIndex=i
end
end
if self.curSelectIndex==nil then
self.curSelectIndex=1
end
end




function UIXianMengSignSetupWin:onShow(argtable,afterOnloaded)
self.page=argtable.menuPageIndex or xianmengIconType.eIcon
self.onChangeFunc=argtable.onChangeFunc
self.changType=argtable.changType

local defaultImage
if self.changType==1 then
defaultImage=xianmengModel:getXMSignRecored()or xianmengModel.getDefualtGuildIamge()
else
defaultImage=xianmengModel:getGuildImage()
end
self.oldSignImage=defaultImage

local signImage=table.deepCopy(self.oldSignImage)
self.signImage=signImage

self:resetSelectIndex()


if self.changType==2 then
local cost=cfgHelper.get4(cfg_guildbaseconfig_get,1,'consume',3,1)
self.needItemID=cost[1]
self.needItemNum=cost[2]
local hasnum
if itemsConfig.isMoney(self.needItemID)then
hasnum=moneyModel.getMoney(self.needItemID)
else
hasnum=bagControl.invokeFuncByItemId(self.needItemID,'getItemCountByItemID',self.needItemID)
end
self.hasItemNum=hasnum
else
self.needItemID=nil
self.needItemNum=nil
self.hasItemNum=nil
end
self:initPageBtns()
self:refreshSignView()
self:refreshCostView()
self:refreshSelectView()
local changeBtn_str=self.changType==1 and'确定'or'更换'
self.changeBtnText:setText(changeBtn_str)
end

function UIXianMengSignSetupWin:onPageClick(pageType)
if self.page==pageType then return end
local old=self.page
if old~=nil then
local olditem=self.pageBtnsGrid:getChildLayoutGroupGridItem(old-1)
self:changePageSelect(olditem,false)
end
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(pageType-1)
self:changePageSelect(item,true)
self.page=pageType

self.selectlist=cfgHelper.get1(cfg_guildiconconfig_get,self.page)or{}
self:resetSelectIndex()
self:refreshSelectView()
end

function UIXianMengSignSetupWin:initPageBtns()
local func=function(index)
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(index-1)
self:refreshPageBtn(item,index)
end
self.pageBtnsGrid:setChildLayoutGroupCreateItems(#self.pageTypeList,func)
end

function UIXianMengSignSetupWin:refreshPageBtn(item,index)
local pageType=self.pageTypeList[index]
local pcfg=pageConfig[pageType]
item:SetChildButtonClick(0,function()
self:onPageClick(pageType)
end)
local isSelect=pageType==self.page
self:changePageSelect(item,isSelect)

item:SetChildText(1,pcfg.name)
end

function UIXianMengSignSetupWin:changePageSelect(item,isSelect)
local iconname=isSelect and'button_xiaoyeqian_1'or'button_xiaoyeqian_2'
item:SetChildCSImageSprite(0,globalABLookup.global,iconname)
end

function UIXianMengSignSetupWin:refreshSignView()
local image=self.signImage
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

function UIXianMengSignSetupWin:refreshCostView()
local hasChange=false
hasChange=hasChange or self.signImage.icon~=self.oldSignImage.icon
hasChange=hasChange or self.signImage.bg~=self.oldSignImage.bg
hasChange=hasChange or self.signImage.kuang~=self.oldSignImage.kuang

local showcost=self.needItemID~=nil and hasChange
self.costObj:setActive(showcost)
self.showcost=showcost
if showcost then
local numstr
if self.hasItemNum>=self.needItemNum then
numstr=tostring(self.needItemNum)
else
numstr=FMT.fmt('<color=#E33021>{0}</color>',self.needItemNum)
end
self.costNumTxt:setText(numstr)
local iconName=iconHelper.getIconName(self.needItemID)
self.costIcon:setImageIcon(iconName,false)
end
end

function UIXianMengSignSetupWin:refreshSelectView()
local func=function(idx)
local item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
self:refreshSelectItem(item,idx)
end
self.itemGridPanel:setChildLayoutGroupCreateItems(#self.selectlist,func)
end

function UIXianMengSignSetupWin:refreshSelectItem(item,index)
local cfg=self.selectlist[index]

item:SetChildCSImageSprite(0,globalABLookup.xianmengicons,cfg.icon)

local showSign=self.defaultIconID==cfg.partid
item:SetChildActive(1,showSign)

local showselect=index==self.curSelectIndex
item:SetChildActive(2,showselect)

item:SetChildButtonClick(3,function()
self:onItemClick(index)
end)
end

function UIXianMengSignSetupWin:onItemClick(index)
if self.curSelectIndex==index then return end
if self.curSelectIndex then
local oldItem=self.itemGridPanel:getChildLayoutGroupGridItem(self.curSelectIndex-1)
oldItem:SetChildActive(2,false)
end
self.curSelectIndex=index
local curItem=self.itemGridPanel:getChildLayoutGroupGridItem(index-1)
curItem:SetChildActive(2,true)

local cfg=self.selectlist[index]
if self.page==xianmengIconType.eIcon then
self.signImage.icon=cfg.partid
elseif self.page==xianmengIconType.eBG then
self.signImage.bg=cfg.partid
elseif self.page==xianmengIconType.eKuang then
self.signImage.kuang=cfg.partid
end

self:refreshSignView()
self:refreshCostView()
end

function UIXianMengSignSetupWin:onCostObj()
itemsComponentHelper.onItemClickEx(self.needItemID,-1,-1,nil)
end

function UIXianMengSignSetupWin:onChangeBtn()

AudioManager.playBtnClick()
if self.showcost then
if self.hasItemNum<self.needItemNum then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.needItemID)))
return
end
end
local flag=true
if self.onChangeFunc then
flag=self.onChangeFunc(self.signImage)
end
if flag then
self:closeSelf()
end
end
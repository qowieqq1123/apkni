







def_class("UIFuncShopMenuWin",UIWindowBase)









function UIFuncShopMenuWin:bindComponents()

self.animDB=UIObject.get(self,0)
self.animFan=UIObject.get(self,1)
self.background=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)
self.menu=UIObject.get(self,4)
self.mouse1=UIObject.get(self,5)
self.mouse2=UIObject.get(self,6)
self.scrollView=UIScrollView.get(self,7)
self.title=UIText.get(self,8)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIFuncShopMenuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animDB);self.animDB=nil;
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.mouse1);self.mouse1=nil;
_UIObject_release(self.mouse2);self.mouse2=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIFuncShopMenuWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)

end


function UIFuncShopMenuWin:__delete()
self:unbindComponents()
UIManager:closeWindow('UITopMoneyWin')
if self.closeCB then
self.closeCB()
end
end


local otherwin=
{
[eFuncShopType.eXianMeng]="UIXianMengShopWin",
[eFuncShopType.eshanhaishop]="UIZZSH_ShopWin",
[eFuncShopType.eXianZhan_DaoJu]="UIXianZhan_ShopWin",
[eFuncShopType.eXianZhan_GuBao]="UIXianZhan_ShopWin",
[eFuncShopType.eXianZhan_SheJiTu]="UIXianZhan_ShopWin",
[eFuncShopType.eMojieSaiJi]="UIMJ_ShopWin",
}




function UIFuncShopMenuWin:onShow(argtable,afterOnloaded)
local shopId=argtable.shopId
self.shopId=shopId

self.closeCB=argtable.closeCB

self:refreshMenu(shopId)

if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end


local subArgs={shopId=shopId,parentWin=self}
if self.canvasIdx then
subArgs.canvasIdx=self.canvasIdx+1
end
self:showWindow("UIFuncShopGroupWin",subArgs)

self:showShopWindow(shopId)
end


function UIFuncShopMenuWin:onHide()

end



local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

function UIFuncShopMenuWin:refreshMenu(shopId)
local menu=funcShopModel:get_menu(shopId)

local tNum=#menu
if tNum>0 then
table.sort(menu,function(a,b)return a.shopIndex<b.shopIndex end)
self.menuList=menu
self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>3)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(menu)do
self:fillMenu(i,v,shopId)
end
if not self.isInit then
self.scrollView:setChildCanvasGroupAlpha(0)
self.scrollView:setChildCanvasGroupDOFade(1,0.5):SetDelay(0.5)
self.animFan:setActive(true)
self.animFan:setChildUIModelShowTarget(2007,1,nil,eAnimationID.enter)
self.isInit=true
end

end
end

function UIFuncShopMenuWin:fillMenu(index,data,shopId)
local assetConfig=cfg_fulltabassetconfig_get(data.icon)
local nomalicon=assetConfig.nomalicon
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,shopId==data.id)
if shopId==data.id then
self.selectMenuIdx=index
end
end

function UIFuncShopMenuWin:on_click_callback(id,index,guid,attach)

if self.selectMenuIdx==index then
return
end
local shopId=self.menuList[index].id
if shopId==eFuncShopType.eXianMeng then
local funcCfg=funcShopModel.FuncShopTypeFunc[shopId]
if(not funcCfg)or(funcCfg and funcCfg.checkOpen())then
if not funcShopModel:checkInit(shopId)then
funcShopController.send_23_1(shopId)
end
self:showShopWindow(shopId)
else
return
end
elseif shopId==eFuncShopType.eshanhaishop then
local funcCfg=funcShopModel.FuncShopTypeFunc[shopId]
if(not funcCfg)or(funcCfg and funcCfg.checkOpen())then
if not funcShopModel:checkInit(shopId)then
funcShopController.send_23_1(shopId)
end
self:showShopWindow(shopId)
else
return
end
else
if not funcShopModel:checkInit(shopId)then
funcShopController.send_23_1(shopId)
end
self:showShopWindow(shopId)


end
if self.selectMenuIdx then
local item=self.scrollView:getGridObjectByindex(self.selectMenuIdx-1)
if item then
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,false)
end
if self.menuList[self.selectMenuIdx]and self.menuList[self.selectMenuIdx].id==eFuncShopType.eXianMeng then
self:hideWindow("UIXianMengShopWin")
elseif self.menuList[self.selectMenuIdx]and self.menuList[self.selectMenuIdx].id==eFuncShopType.eshanhaishop then

self:hideWindow("UIZZSH_ShopWin")
elseif self.menuList[self.selectMenuIdx]and self.menuList[self.selectMenuIdx].id==eFuncShopType.eMojieSaiJi then

self:hideWindow("UIMJ_ShopWin")
end
end
local item=self.scrollView:getGridObjectByindex(index-1)
if item then
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,true)
end

local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
self.title:setText(shopCfg.name)
self.selectMenuIdx=index
end


function UIFuncShopMenuWin:showShopWindow(shopId)

local showflag=true
for k,v in pairs(otherwin)do
if UIManager:isActive(v)then
self:hideWindow(v)
end
end

for k,v in pairs(otherwin)do
if shopId==k then
self:showWindow(v,{shopId=shopId,canvasIdx=self.canvasIdx})
showflag=false
end
end


if showflag then
self:showWindow("UIFuncShopWin",{shopId=shopId,canvasIdx=self.canvasIdx})
else
self:hideWindow("UIFuncShopWin")
end
local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
self.title:setText(shopCfg.name)
end

function UIFuncShopMenuWin:refreshGroupClick(shopId)
self:closeSelf()
end


function UIFuncShopMenuWin:onBtnClose()
self:closeSelf()
end


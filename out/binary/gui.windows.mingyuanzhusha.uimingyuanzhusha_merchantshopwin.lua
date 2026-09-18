







def_class("UIMingYuanZhuSha_MerchantShopWin",UIWindowBase)









function UIMingYuanZhuSha_MerchantShopWin:bindComponents()

self.bg=UIObject.get(self,0)
self.bg2=UIObject.get(self,1)
self.btns=UIObject.get(self,2)
self.bwDetailBtn=UIButton.get(self,3)
self.centerLayout=UIObject.get(self,4)
self.discipleStateBtn=UIButton.get(self,5)
self.gotoBtn=UIButton.get(self,6)
self.gotoLayout=UIObject.get(self,7)
self.merchantModel=UIObject.get(self,8)
self.Root=UIObject.get(self,9)
self.shopItem_1=UIObject.get(self,10)
self.shopItem_2=UIObject.get(self,11)
self.shopItem_3=UIObject.get(self,12)
self.shopItemList=UIObject.get(self,13)
self.uiRoot=UIObject.get(self,14)

self.bwDetailBtn:setButtonClick(function()self:onBwDetailBtn()end)

self.discipleStateBtn:setButtonClick(function()self:onDiscipleStateBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)
self.shopItem={
self.shopItem_1,
self.shopItem_2,
self.shopItem_3,
}



end


function UIMingYuanZhuSha_MerchantShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.bwDetailBtn);self.bwDetailBtn=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.discipleStateBtn);self.discipleStateBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.gotoLayout);self.gotoLayout=nil;
_UIObject_release(self.merchantModel);self.merchantModel=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.shopItem_1);self.shopItem_1=nil;
_UIObject_release(self.shopItem_2);self.shopItem_2=nil;
_UIObject_release(self.shopItem_3);self.shopItem_3=nil;
_UIObject_release(self.shopItemList);self.shopItemList=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.shopItem=nil;
end
















local _this

local _itemCmpIndex={
infoPart=0,
bwImg=1,
name=2,
funcIcon=3,
desc=4,
costBg=5,
moneyIcon=6,
costTxt=7,
funcBtn=8,
funcBtnTxt=9,
}

local _ab="ui/windows/mingyuanzhusha/mingyuanzhusha_atlas_pak.ab"

local _getShopItemCfg=function(type)
local rand_item_list=cfgHelper.get2(cfg_mingyuanzhushanpcconfig_get,_this.npcId,'rand_item_list')or defaultT
local randCfg=rand_item_list[type]
if randCfg then
return randCfg
end
local fixedCfg=cfgHelper.get3(cfg_mingyuanzhushanpcconfig_get,_this.npcId,'item_list',type)
if fixedCfg then
return fixedCfg
end
end


local _funcShopItemFresh=function(_self,index,obj,data)
local item=obj:getWidgetBase()

local type=data.param_2
local isUsed=data.param_4==1

local cfg=cfgHelper.get1(cfg_mingyuanzhushafuncconfig_get,type)
local conf=_getShopItemCfg(type)
local cost=conf[2]


item:SetChildCSImageSprite(_itemCmpIndex.bwImg,_ab,cfg.icon)

item:SetChildText(_itemCmpIndex.name,cfg.name)
item:SetChildText(_itemCmpIndex.desc,cfg.desc)

item:SetChildActive(_itemCmpIndex.costBg,not isUsed)

if not isUsed then
local moneyIcon=iconHelper.getIconName(_this.costMoneyId)
item:SetChildIcon(_itemCmpIndex.moneyIcon,moneyIcon,false)
local isEnough=itemsModel.checkItemEnough(_this.costMoneyId,cost)
item:SetChildText(_itemCmpIndex.costTxt,toColorString(isEnough and FONT_COLOR.eNomalBlackColor or FONT_COLOR.eRedColor,cost))
end

item:SetChildGray(_itemCmpIndex.funcBtn,isUsed)
item:SetChildText(_itemCmpIndex.funcBtnTxt,isUsed and cfg.btnInfoList[2]or cfg.btnInfoList[1])

item:SetChildButtonClick(_itemCmpIndex.funcBtn,function()
if _this==nil then return end
if isUsed then return end

_self:itemClick(index,obj,data,cost)
end,true)
end


local _weaponShopItemFresh=function(_self,index,obj,data)
local item=obj:getWidgetBase()

local type=data.param_2
local bwId=data.param_3
local isUsed=data.param_4==1



local cfg=cfgHelper.get1(cfg_mingyuanzhushabaowuconfig_get,bwId)

item:SetChildIcon(_itemCmpIndex.bwImg,cfg.icon,false)
item:SetChildText(_itemCmpIndex.name,cfg.name)

local desc=skillModel:getSkillDesc(cfg.skill[1],cfg.skill[2])
item:SetChildText(_itemCmpIndex.desc,desc)

item:SetChildActive(_itemCmpIndex.costBg,not isUsed)

if not isUsed then
local moneyIcon=iconHelper.getIconName(_this.costMoneyId)
item:SetChildIcon(_itemCmpIndex.moneyIcon,moneyIcon,false)
local isEnough=itemsModel.checkItemEnough(_this.costMoneyId,cfg.cost)
item:SetChildText(_itemCmpIndex.costTxt,toColorString(isEnough and FONT_COLOR.eNomalBlackColor or FONT_COLOR.eRedColor,cfg.cost))
end

item:SetChildGray(_itemCmpIndex.funcBtn,isUsed)
item:SetChildText(_itemCmpIndex.funcBtnTxt,isUsed and'已购买'or'购买')

item:SetChildButtonClick(_itemCmpIndex.funcBtn,function()
if _this==nil then return end
if isUsed then return end

_self:itemClick(index,obj,data,cfg.cost)
end,true)
end

local _shopItemFuncs={
[MYZSMerchantShopType.eRecovery]={
freshItem=_funcShopItemFresh,
itemClick=function(_self,index,obj,data,cost)
local moneyId=myzsModel:getBaseConfig("money_type")

itemsModel:useItem(moneyId,cost,function()
local args={
funcType=MYZSMerchantShopType.eRecovery,
commitBtnTxt="恢复",
cost=cost,
selectDiscipleCount=1,
commitCallBack=function(...)
_self:useFunc(index,obj,data,...)
end
}
_this:showWindow("UIMingYuanZhuSha_FuncSelectDiscipleWin",args)
end,WARNING_TYPE.eWarning)

end,
useFunc=function(_self,index,obj,data,dzGuidList)
myzsController.reqInteraction(MYZSInteractionType.eBuyItem,index,#dzGuidList,dzGuidList)
end,
},
[MYZSMerchantShopType.eRevival]={
freshItem=_funcShopItemFresh,
itemClick=function(_self,index,obj,data,cost)
local moneyId=myzsModel:getBaseConfig("money_type")
itemsModel:useItem(moneyId,cost,function()
local args={
funcType=MYZSMerchantShopType.eRevival,
commitBtnTxt="恢复",
cost=cost,
selectDiscipleCount=1,
commitCallBack=function(...)
_self:useFunc(index,obj,data,...)
end
}
_this:showWindow("UIMingYuanZhuSha_FuncSelectDiscipleWin",args)
end,WARNING_TYPE.eWarning)
end,
useFunc=function(_self,index,obj,data,dzGuidList)
myzsController.reqInteraction(MYZSInteractionType.eBuyItem,index,#dzGuidList,dzGuidList)
end,
},
[MYZSMerchantShopType.eWeapon]={
freshItem=_weaponShopItemFresh,
itemClick=function(_self,index,obj,data,cost)

local moneyId=myzsModel:getBaseConfig("money_type")
itemsModel:useItem(moneyId,cost,function()
_self:useFunc(index,obj,data)
end,WARNING_TYPE.eWarning)

end,
useFunc=function(_self,index,obj,data)
myzsController.reqInteraction(MYZSInteractionType.eBuyItem,index,0,defaultT)
end,
},
}




function UIMingYuanZhuSha_MerchantShopWin:onLoaded(...)
self:bindComponents()

_this=self

self.centerLayout:setChildCanvasGroupAlpha(0)

self:addProNotify(13,34,self.recv_13_34)
self:addProNotify(13,35,self.recv_13_35)

self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

self:showWindow('UITopMoneyWin2',{moneys={{eMoneyType.mtmingyuanzhusha,1}}})
end


function UIMingYuanZhuSha_MerchantShopWin:__delete()

_this=nil

self:closeWindow('UITopMoneyWin2')
self:unbindComponents()
end




function UIMingYuanZhuSha_MerchantShopWin:onShow(argtable,afterOnloaded)
self:initData()
self:refreshAll()

if afterOnloaded then
self.bg2:setChildUIModelShowTarget(5680,1,nil,eAnimationID.enter)
self.gotoLayout:setChildCanvasGroupAlpha(0)
self.bg:setChildUIModelShowTarget(5681,1,nil,eAnimationID.enter,false,false,0.2,function()
_this:delayDo(0.3,function()
_this.centerLayout:setChildCanvasGroupDOFade(1,0.2)
_this.gotoLayout:setChildCanvasGroupDOFade(1,0.2)
end)
end)
end
end


function UIMingYuanZhuSha_MerchantShopWin:onHide()

end

function UIMingYuanZhuSha_MerchantShopWin:initData()
self.levelItemList=myzsModel:getCurLevelItemList()
self.npcId=myzsModel:getCurrentTargetObjectID()
self.costMoneyId=myzsModel:getBaseConfig('money_type')
end

function UIMingYuanZhuSha_MerchantShopWin:refreshAll()
self:refreshMerchantModel()
self:refreshShopItemList()
end

function UIMingYuanZhuSha_MerchantShopWin:refreshMerchantModel()
local merchantModelId=myzsModel:getBaseConfig('merchantModelId')

self.merchantModel:setChildUIModelShowTarget(merchantModelId,0.8,{},3500)
self.merchantModel:setChildUIModelShowFlipX(true)
end

function UIMingYuanZhuSha_MerchantShopWin:refreshShopItemList()
for index,obj in ipairs(self.shopItem)do
local data=self.levelItemList[index]

local shopItemType=data.param_2

self:invokeShopItemFunc(shopItemType,'freshItem',index,obj,data)
end
end


function UIMingYuanZhuSha_MerchantShopWin:invokeShopItemFunc(type,funcName,...)
local funcs=_shopItemFuncs[type]
if funcs==nil then
logErr("商品类型未处理",type)
return
end
if funcs[funcName]==nil then
logErr("商品类型 无对应 方法",funcName)
return
end

funcs[funcName](funcs,...)
end

function UIMingYuanZhuSha_MerchantShopWin:useShopItem(type,...)
self:invokeShopItemFunc(type,'useFunc',...)
end


function UIMingYuanZhuSha_MerchantShopWin:freshShopItemByUsed(index)
local data=self.levelItemList[index]
local obj=self.shopItem[index]
local shopItemType=data.param_2
self:invokeShopItemFunc(shopItemType,'freshItem',index,obj,data)
end

function UIMingYuanZhuSha_MerchantShopWin.recv_13_34(interaction_type,idx,discipleDataListLen,discipleDataList)
_this:refreshAll()
end

function UIMingYuanZhuSha_MerchantShopWin.recv_13_35(level,discipleListLen,discipleList,nextShopItemListLen,nextShopItemList)
_this:closeSelf()
end

function UIMingYuanZhuSha_MerchantShopWin.on_money_changed(mtype)
if mtype==_this.needChangeMoneyId then
_this:refreshMoney()
end
end





function UIMingYuanZhuSha_MerchantShopWin:onBwDetailBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eMYZS_BWDetail,{})
end



function UIMingYuanZhuSha_MerchantShopWin:onDiscipleStateBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eMYZS_DisicpleState,{})
end



function UIMingYuanZhuSha_MerchantShopWin:onGotoBtn()

myzsController.reqGotoNextLevel(0,defaultT)
self:closeSelf()
end


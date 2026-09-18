







def_class("UIDiscipleLinggen_MCBKTeQuanWin",UIWindowBase)









function UIDiscipleLinggen_MCBKTeQuanWin:bindComponents()

self.artWord=UIObject.get(self,0)
self.back=UIButton.get(self,1)
self.buyBtn=UIButton.get(self,2)
self.buyInfo=UIText.get(self,3)
self.buyRoot=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.desc_1=UIText.get(self,6)
self.desc_2=UIText.get(self,7)
self.desc_3=UIText.get(self,8)
self.descRoot=UIObject.get(self,9)
self.openRewardList=UIObject.get(self,10)
self.openRewardRoot=UIObject.get(self,11)
self.purchasedImg=UIObject.get(self,12)
self.rewardItem_1=UIObject.get(self,13)
self.rewardItem_2=UIObject.get(self,14)
self.rewardItem_3=UIObject.get(self,15)
self.rewardItem_4=UIObject.get(self,16)
self.Root=UIObject.get(self,17)
self.ruleBtn=UIButton.get(self,18)
self.spineBg=UIObject.get(self,19)
self.uiRoot=UIObject.get(self,20)

self.back:setButtonClick(function()self:onBack()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.desc={
self.desc_1,
self.desc_2,
self.desc_3,
}
self.rewardItem={
self.rewardItem_1,
self.rewardItem_2,
self.rewardItem_3,
self.rewardItem_4,
}



end


function UIDiscipleLinggen_MCBKTeQuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.artWord);self.artWord=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.buyInfo);self.buyInfo=nil;
_UIObject_release(self.buyRoot);self.buyRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc_1);self.desc_1=nil;
_UIObject_release(self.desc_2);self.desc_2=nil;
_UIObject_release(self.desc_3);self.desc_3=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.openRewardList);self.openRewardList=nil;
_UIObject_release(self.openRewardRoot);self.openRewardRoot=nil;
_UIObject_release(self.purchasedImg);self.purchasedImg=nil;
_UIObject_release(self.rewardItem_1);self.rewardItem_1=nil;
_UIObject_release(self.rewardItem_2);self.rewardItem_2=nil;
_UIObject_release(self.rewardItem_3);self.rewardItem_3=nil;
_UIObject_release(self.rewardItem_4);self.rewardItem_4=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.desc=nil;
self.rewardItem=nil;
end



















function UIDiscipleLinggen_MCBKTeQuanWin:onLoaded(...)
self:bindComponents()

self.config=cfgHelper.get1(cfg_mizangbaokubaseconfig_get,1)

self:addProNotify(2,204,function()
self:onCloseBtn()
end)
end


function UIDiscipleLinggen_MCBKTeQuanWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_MCBKTeQuanWin:onShow(argtable,afterOnloaded)
mzbkModel:markOneTimeReddot()

self:refreshAll()
end


function UIDiscipleLinggen_MCBKTeQuanWin:onHide()

end





function UIDiscipleLinggen_MCBKTeQuanWin:onBuyBtn()
payControl.reqPay(self.config.czid)
end

function UIDiscipleLinggen_MCBKTeQuanWin:onBack()
self:closeSelf()
end

function UIDiscipleLinggen_MCBKTeQuanWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleLinggen_MCBKTeQuanWin:onRuleBtn()
local d={}
d.mode=3
d.title="说明"
d.name='dz_mzbk_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end



function UIDiscipleLinggen_MCBKTeQuanWin:refreshAll()






local isActive=mzbkModel:checkActiveTeQuan()
self.purchasedImg:setActive(isActive)
self.buyBtn:setActive(not isActive)

if not isActive then
local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,self.config.czid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
str=FMT.fmt("永久开启\n{0}开启",str)
self.buyInfo:setText(str)
end

for index,item in ipairs(self.desc)do
local key=FMT.fmt(self.config.descLang,index)
local desc=cfgHelper.get1(cfg_lang_get,key)or"特权说明内容"
item:setText(desc)
end

for index,itemObj in ipairs(self.rewardItem)do
local item=itemObj:getWidgetBase(-1)
local itemData=self.config.items[index]

local isShow=itemData~=nil
itemObj:setActive(isShow)
if isShow then
local itemid=itemData[1]
local itemcount=itemData[2]
local showCountBG=itemcount>1

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,propData)

item:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClick(itemid)
end)
end
end
end
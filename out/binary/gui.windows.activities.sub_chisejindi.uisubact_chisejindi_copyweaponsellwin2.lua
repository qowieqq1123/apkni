







def_class("UISubAct_ChiSeJinDi_CopyWeaponSellWin2",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.empty=UIObject.get(self,1)
self.itemList=UIObject.get(self,2)
self.moneyBg=UIButton.get(self,3)
self.moneyIcon=UIImage.get(self,4)
self.moneyNum=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)
self.sellBtn=UIButton.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)



end


function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
end















local _this=nil
local _itemCmp={
widget=-1,
colorBg=0,
moneyIcon=1,
moneyNum=2,
color=3,
image=4,
name=5,
starList=6,
headBg=7,
head=8,
selected=9,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _gbAB="ui/windows/gubao/sharedtextures/gubaomainicons.ab"



function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onLoaded(...)
self:bindComponents()
_this=self

self.selectLookup={}

socketManager:addNotify(249,241,self.on_249_241)
end


function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,241,self.on_249_241)
end




function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin


self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:updateData()

self:initView()
self:refreshMoney()
self:refreshView()
end


function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onHide()

end




function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onMoneyBg()
tipsManager.showTips({itemid=self.config.chanceMoney})
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onSellBtn()
if next(self.selectLookup)==nil then
UIManager.error("请先选择出售宝物")
return
end

UIDialogManager.getCommonDialog(nil,"确定出售选中宝物？",function()
local temp={}
for i,v in pairs(self.selectLookup)do
table.insert(temp,i)
end
call_activitiesHandle_func("activitiesHandle_chisejindi","reqSellCopyItem",self.actId,self.subId,eChiSeJinDiRoundType.Weapon,temp)
end)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onClickItem(item,id)
self.selectLookup[id]=(not self.selectLookup[id])or nil
item:SetChildActive(_itemCmp.selected,self.selectLookup[id])
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onLongTouchItem(weapon)
local args={
itemid=weapon,
funType=TIPS_FUNC_TYPE.eChiSeJinDiWeapon,
attach={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
}
tipsManager.showTips(args)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:refreshItem(item,id)
local pos=self.onLookup[id]
local weaponClient=self.config.treasureClient[id]
local weaponServer=self.config.treasure[id]
local color=weaponServer[6]
local name=weaponClient[1]
local imageName=weaponClient[2]
local effect=weaponClient[4]
local price=weaponServer[5]
local star=self.info:getCopyItemStar(id)
local selected=self.selectLookup[id]
item:SetChildCSImageSprite(_itemCmp.colorBg,_abName,FMT.fmt("image_chiseshilian_pzdb{0}",color))
item:SetChildText(_itemCmp.name,name)

item:SetChildCSImageIcon(_itemCmp.image,imageName,false)
item:SetChildLayoutGroupCreateItems(_itemCmp.starList,star)
item:SetChildCSImageIcon(_itemCmp.moneyIcon,iconHelper.getIconName(self.config.chanceMoney),false)
item:SetChildText(_itemCmp.moneyNum,price)
item:SetChildActive(_itemCmp.selected,selected or false)
item:SetChildActive(_itemCmp.headBg,pos~=nil)
if pos then
local disciple=self.teamData[pos].disciple
local discipleServer=self.config.disciple[disciple]
local dColor=discipleServer[5]
local inside=self.config.discipleInside[disciple]
local modelParams={
body=inside[1],
componets=inside[2]or{},
}
comHelper.setChildModelHeadIconBGByColor(item,_itemCmp.headBg,dColor)
comHelper.setChildModelRawImageEx(_itemCmp.head,item,modelParams,eHeadCenterType.eHead)
end
item:SetChildButtonClick(_itemCmp.widget,function()
self:onClickItem(item,id)
end)
item:SetChildLongTouch(_itemCmp.widget,0,1,function(...)self:onLongTouchItem(id)end)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:onClickSell(id)
UIDialogManager.getCommonDialog(nil,"确定出售该宝物？",function()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqSellCopyItem",self.actId,self.subId,eChiSeJinDiRoundType.Weapon,id)
end)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:initView()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:refreshMoney()
local moneyStr=mathHelper.formatNumber(self.copyData.money)
self.moneyNum:setText(moneyStr)
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:updateData()
self.onLookup=self.info:getTeamLookup_Weapon()
self.weaponDatas=self.copyData.weaponList

if#self.weaponDatas>1 then
local weaponServer=self.config.treasure
table.sort(self.weaponDatas,function(a,b)
local colorA=weaponServer[a][6]
local colorB=weaponServer[b][6]
if colorA~=colorB then
return colorA>colorB
else
return a<b
end
end)
end
end

function UISubAct_ChiSeJinDi_CopyWeaponSellWin2:refreshView()
local len=#self.weaponDatas
local have=len>0
self.scrollView:setActive(have)
self.empty:setActive(not have)
if have then
self.itemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local id=self.weaponDatas[index]
self:refreshItem(item,id)
end)
end
end


function UISubAct_ChiSeJinDi_CopyWeaponSellWin2.on_249_241(actId,subId,roundtype,len,ids)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoney()
for i,v in ipairs(ids)do
_this.selectLookup[v]=nil
end
_this:updateData()
_this:refreshView()
end
end
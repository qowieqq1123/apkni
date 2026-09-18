







def_class("UISubAct_GuBaoShiLian_GuBaoWin",UIWindowBase)









function UISubAct_GuBaoShiLian_GuBaoWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.gubaoItem_1=UIObject.get(self,2)
self.gubaoItem_2=UIObject.get(self,3)
self.gubaoItem_3=UIObject.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.tipsArrow=UIObject.get(self,6)
self.tipsList=UIObject.get(self,7)
self.tipsPanel=UIButton.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.tipsPanel:setButtonClick(function()self:onTipsPanel()end)
self.gubaoItem={
self.gubaoItem_1,
self.gubaoItem_2,
self.gubaoItem_3,
}



end


function UISubAct_GuBaoShiLian_GuBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gubaoItem_1);self.gubaoItem_1=nil;
_UIObject_release(self.gubaoItem_2);self.gubaoItem_2=nil;
_UIObject_release(self.gubaoItem_3);self.gubaoItem_3=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.tipsArrow);self.tipsArrow=nil;
_UIObject_release(self.tipsList);self.tipsList=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
self.gubaoItem=nil;
end















local _this=nil
local _gubaoCmp={
icon=0,
name=1,
awakeSign=2,
starGrid=3,
active=4,
detailBtn=5,
currTx=6,
nextTx=7,
}



function UISubAct_GuBaoShiLian_GuBaoWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_GuBaoShiLian_GuBaoWin:__delete()
self:unbindComponents()
end




function UISubAct_GuBaoShiLian_GuBaoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.gubaoIDs=argtable.gubaoIDs
if self.gubaoIDs==nil then
self.gubaoIDs={}
for id,temp in pairs(self.config.gubao_up1)do
table.insert(self.gubaoIDs,id)
end
for id,temp in pairs(self.config.gubao_up2)do
if not self.config.gubao_up1[id]then
table.insert(self.gubaoIDs,id)
end
end
table.sort(self.gubaoIDs)
end
self:refreshView()
self:onTipsPanel()
end


function UISubAct_GuBaoShiLian_GuBaoWin:onHide()

end




function UISubAct_GuBaoShiLian_GuBaoWin:onBackground()
self:onCloseBtn()
end


function UISubAct_GuBaoShiLian_GuBaoWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UISubAct_GuBaoShiLian_GuBaoWin:onJumpBtn()
if self.config.gubao_group_jump then
local check=fullScreenUI.checkFull(UIFullFightPrepareControl)
jumpManager:jump(self.config.gubao_group_jump)

if check then
fightController:closeSelectStage()
jumpManager:clearJump()
end
end
end


function UISubAct_GuBaoShiLian_GuBaoWin:onTipsPanel()
self.tipsPanel:setActive(false)
end

function UISubAct_GuBaoShiLian_GuBaoWin:showTipsPanel(index)
local gubaoID=self.gubaoIDs[index]
if gubaoID==nil then return end
local gubaoData=gubaoModel:getDataByID(gubaoID)
local gubaoCfg=cfgHelper.get1(cfg_gubaoconfig_get,gubaoID)
local gubaoItem=self.gubaoItem[index]:getChildWidgetBase()
local screenPos=gubaoItem:GetChildUIScreenPos(_gubaoCmp.detailBtn)
self.tipsPanel:setActive(true)
self.tipsArrow:setChildUIScreenPos(screenPos+Vector3.right*168/2)
local starMaxLv=gubaoCfg.star and#gubaoCfg.star or 0
local awakeMaxLv=gubaoCfg.awake and#gubaoCfg.awake or 0
local levelLine=gubaoData and(gubaoData.gubaostar+gubaoData.gubaojxlv)or-1
self.tipsList:setChildLayoutGroupCreateItems(starMaxLv+awakeMaxLv+1,function(index)
local idx=index-1
local item=self.tipsList:getChildLayoutGroupGridItem(idx)
local prefix=nil
if idx>starMaxLv then
if awakeMaxLv<=1 then
prefix="觉醒"
else
prefix=FMT.fmt("觉醒{0}",idx-starMaxLv)
end
else
prefix=FMT.fmt("{0}星",idx)
end
local skillDesc=self.config.gubao_effect_desc[gubaoID][idx][1]
local descStr=FMT.fmt("[{0}]{1}",prefix,skillDesc)
if idx<=levelLine then
descStr=FMT.cfmt3("aae252",descStr)
end
item:SetChildText(0,descStr)
end)
self.winlua:ForceLayoutRect(self.tipsList:getID())
end

function UISubAct_GuBaoShiLian_GuBaoWin:refreshView()
for index,obj in ipairs(self.gubaoItem)do
local item=obj:getChildWidgetBase()
local gubaoID=self.gubaoIDs[index]
local gubaoCfg=cfgHelper.get1(cfg_gubaoconfig_get,gubaoID)
local isSpe=gubaoModel:isSpecial(gubaoID)
local gbData=gubaoModel:getDataByID(gubaoID)
local isLD=liandonModel:getLianDonLinkageIdByItemId(gubaoID,ITEM_CONFIG_TYPE.eGuBao)>0
item:SetChildCSImageIcon(_gubaoCmp.icon,gubaoModel:getGuBaoIconName(gubaoCfg.icon),true)
item:SetChildGraphicGray(_gubaoCmp.icon,gbData==nil)
item:SetChildText(_gubaoCmp.name,gubaoCfg.name)
item:SetChildActive(_gubaoCmp.awakeSign,gbData~=nil and gbData.gubaojxlv>0)
item:SetChildActive(_gubaoCmp.active,gbData~=nil)
item:SetChildButtonClick(_gubaoCmp.detailBtn,function()
self:onClickDetail(index)
end)
local starWidget=item:GetChildWidgetBase(_gubaoCmp.starGrid)
for i=1,5 do
starWidget:SetChildGraphicGray(i-1,gbData==nil or i>gbData.gubaostar)
end

local starMaxLv=gubaoCfg.star and#gubaoCfg.star or 0
local awakeMaxLv=gubaoCfg.awake and#gubaoCfg.awake or 0
if not gbData then
local desc=self.config.gubao_effect_desc[gubaoID][0][1]
item:SetChildText(_gubaoCmp.currTx,FMT.cfmt3("f36666","未激活"))
item:SetChildText(_gubaoCmp.nextTx,FMT.fmt("下级加成：{0}",desc))
elseif gbData.gubaostar<starMaxLv or gbData.gubaojxlv<awakeMaxLv then
local sumLv=gbData.gubaostar+gbData.gubaojxlv
local cDesc=self.config.gubao_effect_desc[gubaoID][sumLv][1]
local nDesc=self.config.gubao_effect_desc[gubaoID][sumLv+1][1]
item:SetChildText(_gubaoCmp.currTx,FMT.fmt("当前加成：<color=#aae252>{0}</color>",cDesc))
item:SetChildText(_gubaoCmp.nextTx,FMT.fmt("下级加成：{0}",nDesc))
else
local desc=self.config.gubao_effect_desc[gubaoID][starMaxLv+awakeMaxLv][1]
item:SetChildText(_gubaoCmp.currTx,FMT.fmt("当前加成：<color=#aae252>{0}</color>",desc))
item:SetChildText(_gubaoCmp.nextTx,FMT.cfmt3("f36666","已满级"))
end
end
end

function UISubAct_GuBaoShiLian_GuBaoWin:onClickDetail(index)
self:showTipsPanel(index)
end
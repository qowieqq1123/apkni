







def_class("UIXianGongShiLiDetailsWin",UIWindowBase)









function UIXianGongShiLiDetailsWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.btnJoin=UIButton.get(self,1)
self.btnJoinNotOpen=UIButton.get(self,2)
self.btnMember=UIButton.get(self,3)
self.imgShengWangEmoji=UIImage.get(self,4)
self.imgShengWangLevel=UIImage.get(self,5)
self.imgShiLi=UIImage.get(self,6)
self.imgShiLiName=UIObject.get(self,7)
self.kaiFang=UIObject.get(self,8)
self.npcContent=UIObject.get(self,9)
self.shengWangProgress=UIObject.get(self,10)
self.shiLiDesc=UIText.get(self,11)
self.shiLiGuanZhi=UIText.get(self,12)
self.shiLiMenu_1=UIObject.get(self,13)
self.shiLiMenu_2=UIObject.get(self,14)
self.shiLiMenu_3=UIObject.get(self,15)
self.shiLiMenu_4=UIObject.get(self,16)
self.weiKaiFang=UIObject.get(self,17)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnJoin:setButtonClick(function()self:onBtnJoin()end)

self.btnJoinNotOpen:setButtonClick(function()self:onBtnJoinNotOpen()end)

self.btnMember:setButtonClick(function()self:onBtnMember()end)
self.shiLiMenu={
self.shiLiMenu_1,
self.shiLiMenu_2,
self.shiLiMenu_3,
self.shiLiMenu_4,
}



end


function UIXianGongShiLiDetailsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnJoin);self.btnJoin=nil;
_UIObject_release(self.btnJoinNotOpen);self.btnJoinNotOpen=nil;
_UIObject_release(self.btnMember);self.btnMember=nil;
_UIObject_release(self.imgShengWangEmoji);self.imgShengWangEmoji=nil;
_UIObject_release(self.imgShengWangLevel);self.imgShengWangLevel=nil;
_UIObject_release(self.imgShiLi);self.imgShiLi=nil;
_UIObject_release(self.imgShiLiName);self.imgShiLiName=nil;
_UIObject_release(self.kaiFang);self.kaiFang=nil;
_UIObject_release(self.npcContent);self.npcContent=nil;
_UIObject_release(self.shengWangProgress);self.shengWangProgress=nil;
_UIObject_release(self.shiLiDesc);self.shiLiDesc=nil;
_UIObject_release(self.shiLiGuanZhi);self.shiLiGuanZhi=nil;
_UIObject_release(self.shiLiMenu_1);self.shiLiMenu_1=nil;
_UIObject_release(self.shiLiMenu_2);self.shiLiMenu_2=nil;
_UIObject_release(self.shiLiMenu_3);self.shiLiMenu_3=nil;
_UIObject_release(self.shiLiMenu_4);self.shiLiMenu_4=nil;
_UIObject_release(self.weiKaiFang);self.weiKaiFang=nil;
self.shiLiMenu=nil;
end


















local ab='ui/windows/xiangong/xiangongshili_atlas_pak.ab'
local shiLiStaticCfg={
{name='image_xiangongtzwz_1',bg='image_xiangongtzdcc_1',id=2},
{name='image_xiangongtzwz_3',bg='image_xiangongtzdcc_2',id=1},
{name='image_xiangongtzwz_2',bg='image_xiangongtzdcc_3',id=3},
{name='image_xiangongtzwz_4',bg='image_xiangongtzdcc_4',id=4},
}

function UIXianGongShiLiDetailsWin:onLoaded(...)
self:bindComponents()
end


function UIXianGongShiLiDetailsWin:__delete()
self:unbindComponents()
end




function UIXianGongShiLiDetailsWin:onShow(argtable,afterOnloaded)
self.selectPage=argtable or 1
self:initShiLiMenu()
self:refreshDetailWin()
self:refreshNpcWin()
end

function UIXianGongShiLiDetailsWin:initShiLiMenu()
for i,v in ipairs(self.shiLiMenu)do
local widget=v:getWidgetBase()
widget:SetChildActive(0,i==self.selectPage)
widget:SetChildButtonClick(1,function()
self:onCilckMenu(i)
end)
end
end

function UIXianGongShiLiDetailsWin:refreshDetailWin()
local cfg=shiLiStaticCfg[self.selectPage]
local shiLiCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,cfg.id)
self.imgShiLi:setSprite(ab,cfg.bg)
self.imgShiLiName:setSprite(ab,cfg.name)
self.shiLiGuanZhi:setText(string.format("势力官职：%d/%d",0,30))
self.shiLiDesc:setText(shiLiCfg.shiLiDesc)
end

function UIXianGongShiLiDetailsWin:refreshNpcWin()
local cfg=shiLiStaticCfg[self.selectPage]
local shiLiCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,cfg.id)
local npcList=shiLiCfg.npcList
self.npcContent:setChildLayoutGroupCreateItems(#npcList,function(index)
local item=self.npcContent:getChildLayoutGroupGridItem(index-1)
local npcid=npcList[index]
local imagecfg=npcModel:getNPCImageCfg(npcid)

comHelper.setChildModelRawImage_npc(item,imagecfg.id,0,0,eHeadCenterType.eHead,nil,false)

item:SetChildText(1,imagecfg.name)

local func=function()
local npcid=npcList[index]
local winParams={
titleName='仙友信息',
extraWin='UINPCInfoWin',
extraParams={npcid=npcid,canvasIdx=8,},
canvasIdx=8,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)

end
item:SetChildButtonClick(2,func,true)
end)
end

function UIXianGongShiLiDetailsWin:onCilckMenu(idx)
if self.selectPage~=idx then
local widget=self.shiLiMenu[self.selectPage]:getWidgetBase()
widget:SetChildActive(0,false)
self.selectPage=idx
widget=self.shiLiMenu[self.selectPage]:getWidgetBase()
widget:SetChildActive(0,true)
self:refreshDetailWin()
end
end


function UIXianGongShiLiDetailsWin:onBtnClose()
self:closeSelf()
end

function UIXianGongShiLiDetailsWin:onBtnJoin()

end

function UIXianGongShiLiDetailsWin:onBtnJoinNotOpen()

end

function UIXianGongShiLiDetailsWin:onBtnMember()

end


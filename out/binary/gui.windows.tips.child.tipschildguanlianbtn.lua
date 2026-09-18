







def_class("tipsChildGuanLianBtn",UICloneObject)





tipsChildGuanLianBtn.abName="ui/windows/tips/child/tipschildguanlianbtn.ab"

tipsChildGuanLianBtn.assetName="tipsChildGuanLianBtn"


function tipsChildGuanLianBtn:bindComponents()

self.closeTag=UIObject.get(self,0)
self.guanlian=UIButton.get(self,1)
self.Icon=UIImage.get(self,2)
self.itembg=UIImage.get(self,3)
self.openTag=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.root2=UIObject.get(self,6)
self.Text=UIText.get(self,7)
self.toggleBtn=UIButton.get(self,8)

self.guanlian:setButtonClick(function()self:onGuanlian()end)

self.toggleBtn:setButtonClick(function()self:onToggleBtn()end)

end


function tipsChildGuanLianBtn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.guanlian);self.guanlian=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.toggleBtn);self.toggleBtn=nil;
end









function tipsChildGuanLianBtn:onLoaded(...)
self:bindComponents()
end


function tipsChildGuanLianBtn:__delete()
self:unbindComponents()
end
local abname="ui/windows/common/liandong_atlas_pak.ab"
local colorcmp=
{
[eQualityColor.eRed]='image_yishigongfadi_04',
[eQualityColor.eOrange]='image_yishigongfadi_03',
[eQualityColor.ePurple]='image_yishigongfadi_02',
[eQualityColor.eBlue]='image_yishigongfadi_05',
}



function tipsChildGuanLianBtn:onShow(argtable,afterOnloaded)
self.root2:setActive(false)
self.data=argtable.argtable
self.itemid=self.data.itemid
self.guanlian_id=self.data.guanlian_id
self.tipsType=self.data.tipsType
if self.data.GFid then

self.itemid=self.data.GFid
self:SetGFWin()
elseif self.tipsType==TIPS_TYPE.eCommonGubao or self.tipsType==TIPS_TYPE.eCommonGubaoMetrial then
if self.data.gbid then

self.itemid=self.data.gbid
end

self:SetGBWin()
elseif self.tipsType==TIPS_TYPE.eCommonXianBao then

self:SetXBWin()
local flag=xianbaoModel:CheckCanShowMax(self.itemid,self.data.formType)

self.root2:setActive(flag)
if flag then
local data=self.data
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach
local starlv=attach.starlv or 0
local maxlv=xianbaoConfig.getXBMaxStar(self.itemid)
local isMax=starlv>=maxlv
self.closeTag:setActive(not isMax)
self.openTag:setActive(isMax)
end

end

end

function tipsChildGuanLianBtn:onToggleBtn()
local attach=self.attach
local itemid=self.itemid
local starlv=attach.starlv or 0
local maxStarlv=xianbaoConfig.getXBMaxStar(itemid)
local isMax=starlv>=maxStarlv
tipsManager.setAttachArgs(attach,'starlv',isMax and 0 or maxStarlv)
tipsManager.freshTips()
end


function tipsChildGuanLianBtn:onHide()

end


function tipsChildGuanLianBtn:SetXBWin()

local itemid_1=xianbaoModel:checkActiveItemID(self.itemid)
local itemConfig_1=itemsConfig.getConfig(itemid_1)
self:SetItem(itemConfig_1,"异世仙宝")
end


function tipsChildGuanLianBtn:SetGBWin()

local itemid_1=gubaoLookup:gubao2GoodActive(self.itemid)
local itemConfig_1=itemsConfig.getConfig(itemid_1)
self:SetItem(itemConfig_1,"异世古宝")
end


function tipsChildGuanLianBtn:SetGFWin()

local gfid=self.itemid

local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfid)
local itemidtable=gongfaLookup:checkpiecesgongfa(gfid)
local itemid=itemidtable[1]
local itemConfig_1=itemsConfig.getConfig(itemid)
self.Icon:setImageIcon(iconHelper.getItemIconName(itemConfig_1.icon),false)
self.itembg:setSprite(abname,colorcmp[cfg.color])
self.Text:setText("异世功法")
end


function tipsChildGuanLianBtn:onGuanlian()
local arg={self.itemid,self.guanlian_id,self.tipsType}
if self.data.GFid then
arg.GFid=self.data.GFid
end
UIManager:showWindow("UIGuanLianWin",arg)
end





function tipsChildGuanLianBtn:SetItem(itemConfig,str)
self.Icon:setImageIcon(iconHelper.getItemIconName(itemConfig.icon),false)
self.itembg:setSprite(abname,colorcmp[itemConfig.color])
self.Text:setText(str)
end



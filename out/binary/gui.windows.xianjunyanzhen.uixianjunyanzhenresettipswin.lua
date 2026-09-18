







def_class("UIXianJunYanZhenResetTipsWin",UIWindowBase)









function UIXianJunYanZhenResetTipsWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.leftMonsterContent=UIObject.get(self,1)
self.mbg=UIObject.get(self,2)
self.monsterPanel=UIObject.get(self,3)
self.okBtn=UIButton.get(self,4)
self.panel=UIObject.get(self,5)
self.rightMonsterContent=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.xiushi1=UIImage.get(self,8)
self.xiushi2=UIImage.get(self,9)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UIXianJunYanZhenResetTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.leftMonsterContent);self.leftMonsterContent=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.monsterPanel);self.monsterPanel=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.rightMonsterContent);self.rightMonsterContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.xiushi1);self.xiushi1=nil;
_UIObject_release(self.xiushi2);self.xiushi2=nil;
end
















local _this



function UIXianJunYanZhenResetTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJunYanZhenResetTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJunYanZhenResetTipsWin:onShow(argtable,afterOnloaded)
self.gx_id=argtable.gx_id

self:refreshMonster()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.mbg:setChildUIModelShowTarget(772158,1,{},eAnimationID.enter)
self:delayDo(0.3,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UIXianJunYanZhenResetTipsWin:onHide()

end

function UIXianJunYanZhenResetTipsWin:refreshMonster()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.gx_id)
local monsterLen=#cfg.mon_groub_list
local isGrayLookup={}
local monsterIdList={}
for i=1,monsterLen do
local isKill=XianJunYanZhenModel:getIsKill(self.gx_id,i)
local isMultiBattle=cfg.multi_battle_mon_id~=nil and cfg.multi_battle_mon_id[i]~=nil
if isKill then
isGrayLookup[i]=true
end
if isKill or isMultiBattle then
table.insert(monsterIdList,i)
end
end
local len=#monsterIdList
self.monsterPanel:setActive(len>0)
self.panel:setChildSizeDelta(720,len>0 and 260 or 150)
if len==0 then
return
end
self.leftMonsterContent:setChildLayoutGroupCreateItems(len)
for i=1,len do
local item=self.leftMonsterContent:getChildLayoutGroupGridItem(i-1)
local idx=monsterIdList[i]
local monster=cfg.mon_groub_list[idx]
local monsterId=monster[1]

local isGray=isGrayLookup[idx]~=nil
item:SetChildGray(0,isGray)
item:SetChildCSImageSprite(0,globalABLookup.global,"image_gwtouxiangpjk_5")
comHelper.setChildModelRawImage_monsterGroup(item,monsterId,1,0,eHeadCenterType.eHead,1,isGray)
end

self.rightMonsterContent:setChildLayoutGroupCreateItems(len)
for i=1,len do
local item=self.rightMonsterContent:getChildLayoutGroupGridItem(i-1)
local idx=monsterIdList[i]
local monster=cfg.mon_groub_list[idx]
local monsterId=monster[1]

item:SetChildCSImageSprite(0,globalABLookup.global,"image_gwtouxiangpjk_5")
comHelper.setChildModelRawImage_monsterGroup(item,monsterId,1,0,eHeadCenterType.eHead)
end

end





function UIXianJunYanZhenResetTipsWin:onBackBtn()
UIFullXianJunYanZhenControl:closeWindow(self.winlua.name)
end



function UIXianJunYanZhenResetTipsWin:onOkBtn()
local curGxId=XianJunYanZhenModel:getCurGxId()
local curGxStar=XianJunYanZhenModel:getGxStar(curGxId)
if curGxId~=self.gx_id and XianJunYanZhenModel:getIsHasGxLog(curGxId)and curGxStar==0 then
local content=FMT.fmt('当前正在挑战<color=#7d3b17>第{0}关</color>，是否放弃<color=#7d3b17>第{0}关</color>挑\n战进度，选择当前关卡挑战？',curGxId,curGxId)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
XianJunYanZhenController:send_42_2(_this.gx_id)
_this:onBackBtn()
end,
showclosebtn=false,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
else
XianJunYanZhenController:send_42_2(self.gx_id)
self:onBackBtn()
end
end


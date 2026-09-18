







def_class("UIXianJie_JiJie_YBDPvPCndWin",UIWindowBase)









function UIXianJie_JiJie_YBDPvPCndWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.btnReset=UIButton.get(self,1)
self.btnConfirm=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.titleName=UIText.get(self,4)
self.selfXMChildGroup=UIObject.get(self,5)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_JiJie_YBDPvPCndWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.selfXMChildGroup);self.selfXMChildGroup=nil;
end
















local _this
local _itemCmpIndex={
name=0,
toggle=1,
tick=2,
clickMask=3,
}




function UIXianJie_JiJie_YBDPvPCndWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_YBDPvPCndWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_JiJie_YBDPvPCndWin:onShow(argtable,afterOnloaded)
self:refresh(true)
end


function UIXianJie_JiJie_YBDPvPCndWin:onHide()

end

function UIXianJie_JiJie_YBDPvPCndWin:refresh(isInit)

if isInit then
self:initSelfXMSelectList()
end
self:refreshSelfXMPanel(isInit)


end

function UIXianJie_JiJie_YBDPvPCndWin:refreshSelfXMPanel(isInit)
local optionList=self:getXMPostList()
if isInit then
self.selfXMChildGroup:setChildLayoutGroupCreateItems(#optionList,function(index)
local widget=self.selfXMChildGroup:getChildLayoutGroupGridItem(index-1)
self:refreshSelfXMOptionItem(widget,index,isInit)
end)
else
local grids=self.selfXMChildGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshSelfXMOptionItem(widget,i,isInit)
end
end
end

function UIXianJie_JiJie_YBDPvPCndWin:refreshSelfXMOptionItem(widget,index,isInit)
local optionList=self:getXMPostList()
local optionCfg=optionList[index]
if optionCfg then
widget:SetChildActive(-1,true)
local isCanChange=optionCfg.isCanChange
widget:SetChildActive(_itemCmpIndex.clickMask,not isCanChange)
widget:SetChildActive(_itemCmpIndex.tick,not isCanChange)
widget:SetChildActive(_itemCmpIndex.toggle,isCanChange)
local nameStr=optionCfg.name
if isCanChange then

local isSelect=self.selectList and self.selectList[index]or false
widget:SetChildToggle(_itemCmpIndex.toggle,isSelect)
if isInit then
widget:SetChildToggleChange(_itemCmpIndex.toggle,function(name,isOn)
if not _this then return end
self.selectList[index]=isOn
end)

widget:SetChildButtonClick(_itemCmpIndex.clickMask,function(name,isOn)
return
end,true)

end
else
nameStr=FMT.cfmt(FONT_COLOR.eNomalGrayColor,nameStr)
widget:SetChildButtonClick(_itemCmpIndex.clickMask,function(name,isOn)
return UIManager.error("盟主和副盟主无法取消权限")
end,true)
end


widget:SetChildText(_itemCmpIndex.name,nameStr)
else
widget:SetChildActive(-1,false)
end
end

function UIXianJie_JiJie_YBDPvPCndWin:getXMPostList()
if self.selectPostList then
return self.selectPostList
end

local allPostCfg=cfg_guildpositionconfig()
local selectPostList={}
for i,cfg in ipairs(allPostCfg)do
local postId=cfg.id
local privilege=cfg.privilege
local isCanChange=true
if privilege and privilege[GUILD_PRIVILE_TYPE.gptFLInvite]then
isCanChange=false
end

selectPostList[#selectPostList+1]={
postId=postId,
name=cfg.name,
isCanChange=isCanChange,
}
end

self.selectPostList=selectPostList
return self.selectPostList
end

function UIXianJie_JiJie_YBDPvPCndWin:initSelfXMSelectList()
local ybdData=xianjieModel:getJiJieYBDData()
local postSelectList=ybdData.postList or{}
local optionList=self:getXMPostList()
self.selectList={}
for i,v in ipairs(optionList)do
local posId=v.postId
local isSelect=postSelectList[posId]
if isSelect then
self.selectList[i]=isSelect
end
end
end




function UIXianJie_JiJie_YBDPvPCndWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_YBDPvPCndWin:onBtnReset()

self.selectList={}
self:refresh()
end



function UIXianJie_JiJie_YBDPvPCndWin:onBtnConfirm()
local list={}
if self.selectList then
for posId,isSelect in pairs(self.selectList)do
if isSelect then
list[#list+1]=posId
end
end
end
xianjieController:reqMassYBDSetPostLimitList(eYbdType.ZhanZhengYbd,list)
end



function UIXianJie_JiJie_YBDPvPCndWin:onCloseBtn()
self:closeSelf()
end


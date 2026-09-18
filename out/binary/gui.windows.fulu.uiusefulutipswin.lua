







def_class("UIUseFuluTipsWin",UIWindowBase)









function UIUseFuluTipsWin:bindComponents()

self.root=UIObject.get(self,0)
self.info=UIObject.get(self,1)
self.itemIcon=UIImage.get(self,2)
self.itemName=UIText.get(self,3)
self.buffName=UIText.get(self,4)
self.buffIcon=UIImage.get(self,5)
self.buffEffectText=UIText.get(self,6)
self.buffTimeText=UIText.get(self,7)
self.buffTypePanel=UIObject.get(self,8)
self.effectTypePanel=UIObject.get(self,9)
self.simpleDesc=UIText.get(self,10)
self.desc=UIText.get(self,11)
self.effectIcon=UIImage.get(self,12)



end


function UIUseFuluTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.itemIcon);self.itemIcon=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.buffName);self.buffName=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.buffEffectText);self.buffEffectText=nil;
_UIObject_release(self.buffTimeText);self.buffTimeText=nil;
_UIObject_release(self.buffTypePanel);self.buffTypePanel=nil;
_UIObject_release(self.effectTypePanel);self.effectTypePanel=nil;
_UIObject_release(self.simpleDesc);self.simpleDesc=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effectIcon);self.effectIcon=nil;
end

















function UIUseFuluTipsWin:onLoaded(...)
self:bindComponents()
end


function UIUseFuluTipsWin:__delete()
self:unbindComponents()
end




function UIUseFuluTipsWin:onShow(argtable,afterOnloaded)
if argtable then
self.itemId=argtable.itemId
self.funcparam=argtable.funcparam
self.selectShowType=argtable.showType
self.num=argtable.num or 1
else
logErr("没有传入符箓道具相关数据 请检查前端传参是否正确")
return
end

self:refresh()
end


function UIUseFuluTipsWin:onHide()

end

function UIUseFuluTipsWin:refresh()
local itemCfg=itemsConfig.getConfig(self.itemId)


local itemName=itemCfg.name
local color=itemCfg.color
local itemNameStr=FMT.cfmt(color,itemName)
self.itemName:setText(itemNameStr)


local itemIconName=iconHelper.getIconName(self.itemId)
self.itemIcon:setImageIcon(itemIconName,true)

if self.selectShowType==USE_FULU_TIPS_SHOW_TYPE.eBuffType then
self:refreshBuffTypePanel()
elseif self.selectShowType==USE_FULU_TIPS_SHOW_TYPE.eEffectType then
self:refreshEffectTypePanel()
end
end

function UIUseFuluTipsWin:refreshBuffTypePanel()
self.buffTypePanel:setActive(true)
self.effectTypePanel:setActive(false)


local homeBuffId=self.funcparam.gsid
local homeBuffConfig=cfg_guildstateconfig_get(homeBuffId)
local homeBuffName=homeBuffConfig.name
self.buffName:setText(FMT.fmt("\"{0}\"",homeBuffName))


local buffIconName=iconHelper.getzmStateIcon(homeBuffConfig.icon)
self.buffIcon:setImageIcon(buffIconName)


local effectText=homeBuffModel:getBuffDescByStateId(homeBuffId)
self.buffEffectText:setText(effectText)


local isShowTime=homeBuffConfig.showtime~=false
self.buffTimeText:setActive(isShowTime)
if isShowTime then

local time=homeBuffModel:getBuffDuration(homeBuffConfig.duration*self.num)
if time>=86400 then
self.buffTimeText:setText(timeHelper.format_time_stamp11(time,true))
else
self.buffTimeText:setText(timeHelper.format_time_stamp5(time))
end
end
end

function UIUseFuluTipsWin:refreshEffectTypePanel()
self.buffTypePanel:setActive(false)
self.effectTypePanel:setActive(true)


local simpleDescText=self.funcparam.simpledesc
if not simpleDescText then
logErr(FMT.fmt("道具:{0} 的功能参数未配置简单描述文本simpledesc",self.itemId))
simpleDescText="未知效果"
end
self.simpleDesc:setText(FMT.fmt("\"{0}\"",simpleDescText))


local itemDescText=self.funcparam.desc
if not itemDescText then
logErr(FMT.fmt("道具:{0} 的功能参数未配置详细描述文本desc",self.itemId))
itemDescText="未知描述"
end
self.desc:setText(itemDescText)


local effectIconName=self.funcparam.efficon
if not effectIconName then
logErr(FMT.fmt("道具:{0} 的功能参数未配置效果图标efficon",self.itemId))
effectIconName=""
end
local abName="ui/windows/fulu/fuluusetipseff_atlas_pak.ab"
self.effectIcon:setSprite(abName,effectIconName)
end












def_class("UIXM_LXWJ_RankTwoWin",UIWindowBase)









function UIXM_LXWJ_RankTwoWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.noItemTips=UIText.get(self,3)
self.rankGridPanel=UIObject.get(self,4)



end


function UIXM_LXWJ_RankTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_RankTwoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_RankTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_RankTwoWin:onHide()

end




function UIXM_LXWJ_RankTwoWin:onShow(argtable,afterOnloaded)
local needRefresh=lingxuwenjianModel:checkRefreshRank2()
if not needRefresh then
self.refreshMark=true
self:refreshView()
else
self.refreshMark=nil
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.playering=true
self.frameSp:setChildUIModelShowTarget(4748,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.playering=nil
if _this.refreshMark==true then
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end
end)
end)
else
if needRefresh then
self.root:setChildCanvasGroupAlpha(0)
end
end
end

function UIXM_LXWJ_RankTwoWin:refreshView()
if self.playering==nil then
self.root:setChildCanvasGroupAlpha(1)
end
self.rankList=lingxuwenjianModel:getRanklist2()
local num=#self.rankList
local isShow=num>0
self.rankScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]

item:SetChildText(0,FMT.fmt('第{0}赛季',data.session))

local image=xianmengModel.splitGuildIcon(data.guildicon)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local sname=loginModel:getServerName(data.serverid)
local name_str
if sname~=nil and sname~=''then
name_str=FMT.fmt('{0}\n{1}',data.guildname,sname)
else
name_str=data.guildname
end
item:SetChildText(4,name_str)
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('虚位以待')
end
end

function UIXM_LXWJ_RankTwoWin:rec_ranklist()
self.refreshMark=true
self:refreshView()
end
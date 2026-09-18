







def_class("UIXM_LXWJ_pipeiWin",UIWindowBase)









function UIXM_LXWJ_pipeiWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.leftInfoItem=UIObject.get(self,2)
self.rightInfoItem=UIObject.get(self,3)



end


function UIXM_LXWJ_pipeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftInfoItem);self.leftInfoItem=nil;
_UIObject_release(self.rightInfoItem);self.rightInfoItem=nil;
end
















local _this=nil


function UIXM_LXWJ_pipeiWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_pipeiWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_pipeiWin:onHide()

end




function UIXM_LXWJ_pipeiWin:onShow(argtable,afterOnloaded)
local raceState=lingxuwenjianModel:getLunState()
local titleAnimID
if raceState==eLXWJ_State.eFight then

titleAnimID=2040
else

titleAnimID=2045
end
self:refreshView()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4750,1,{},titleAnimID,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.15,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end
end

function UIXM_LXWJ_pipeiWin:refreshView()
self:refreshLeftInfo()
self:refreshRightInfo()
end

function UIXM_LXWJ_pipeiWin:refreshLeftInfo()
local widget=self.leftInfoItem:getWidgetBase()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local xmname=xianmengModel:getXMName()
widget:SetChildText(3,xmname)

local score=lingxuwenjianModel:getScore()
local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
widget:SetChildCSImageSprite(4,abname,icon)
local score_str=FMT.fmt('{0}({1})',name,score)
widget:SetChildText(5,score_str)

local result=lingxuwenjianModel:checkBattleResult()
local isshow=result~=nil
widget:SetChildActive(6,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon5(result,true)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end

function UIXM_LXWJ_pipeiWin:refreshRightInfo()
local widget=self.rightInfoItem:getWidgetBase()
local enemyData=lingxuwenjianModel:getEnemyData()
local image=xianmengModel.splitGuildIcon(enemyData.enemyguildicon)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local xmname=enemyData.enemyname
widget:SetChildText(3,xmname)

local score=lingxuwenjianModel:getEnemyScore()or 0
local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
widget:SetChildCSImageSprite(4,abname,icon)
local score_str=FMT.fmt('{0}({1})',name,score)
widget:SetChildText(5,score_str)

local result=lingxuwenjianModel:checkBattleResult()
local isshow=result~=nil
widget:SetChildActive(6,isshow)
if isshow then
local abname_,icon_=lingxuwenjianModel:getResultIcon5(result,false)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end









def_class("UIMoJieMoJunAreaEffectInfoWin",UIWindowBase)









function UIMoJieMoJunAreaEffectInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc1=UIText.get(self,2)
self.desc2=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.skillList=UIObject.get(self,5)
self.spine=UIObject.get(self,6)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoJieMoJunAreaEffectInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.spine);self.spine=nil;
end
















local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"




function UIMoJieMoJunAreaEffectInfoWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieMoJunAreaEffectInfoWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunAreaEffectInfoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

local xijiEffect=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"xijiEffect")
local quyuEffect=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"quyuEffect2")
self.desc1:setText(FMT.fmt("每次攻打开始后，每隔{0}触发1次<color=#c82c2c>袭击</color>效果",timeHelper.format_time_stamp7(xijiEffect[1])))
self.desc2:setText(FMT.fmt("魔君生命每降低{0}%时，将从以下效果中随机触发1种",quyuEffect[1]/100))

local cfgs=cfg_seasonmojuneffectconfig()
local list={}
for i=1,3 do
table.insert(list,cfgs[i])
end
if list and#list>1 then
table.sort(list,function(a,b)
return a.sort<b.sort
end)
end
self.skillList:setChildLayoutGroupCreateItems(#list,function(index)
local widget=self.skillList:getChildLayoutGroupGridItem(index-1)
local cfg=list[index]

local nameColor=cfg.addType==1 and"#ca631d"or"#6833c0"
local descColor=cfg.addType==1 and"#7d3b17"or"#463165"
local bgIcon=cfg.addType==1 and"image_zhengtaomojun_5"or"image_zhengtaomojun_6"

widget:SetChildCSImageSprite(1,_abname,cfg.icon)
widget:SetChildCSImageSprite(4,_abname,bgIcon)
widget:SetChildText(3,FMT.fmt("<color={0}>{1}</color>",descColor,cfg.effectDesc2 or cfg.effectDesc))
if cfg.effectTime then
widget:SetChildText(2,FMT.fmt("<color={0}>{1}（持续{2}分钟）</color>",nameColor,cfg.name,cfg.effectTime/60))
else
widget:SetChildText(2,FMT.fmt("<color={0}>{1}</color>",nameColor,cfg.name))
end
end)

self.root:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6274,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UIMoJieMoJunAreaEffectInfoWin:onHide()

end





function UIMoJieMoJunAreaEffectInfoWin:onBackground()
self:onCloseBtn()
end

function UIMoJieMoJunAreaEffectInfoWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end
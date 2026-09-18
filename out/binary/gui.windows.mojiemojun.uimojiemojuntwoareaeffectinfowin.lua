







def_class("UIMoJieMoJunTwoAreaEffectInfoWin",UIWindowBase)









function UIMoJieMoJunTwoAreaEffectInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc1=UIText.get(self,2)
self.desc2=UIText.get(self,3)
self.root=UIObject.get(self,4)
self.skillList=UIObject.get(self,5)
self.spine=UIObject.get(self,6)
self.desc3=UIText.get(self,7)
self.skillItem=UIObject.get(self,8)
self.skillItem2=UIObject.get(self,9)
self.skillItem3=UIObject.get(self,10)
self.skillItem4=UIObject.get(self,11)
self.spine2=UIObject.get(self,12)
self.root2=UIObject.get(self,13)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoJieMoJunTwoAreaEffectInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.desc3);self.desc3=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.skillItem3);self.skillItem3=nil;
_UIObject_release(self.skillItem4);self.skillItem4=nil;
_UIObject_release(self.spine2);self.spine2=nil;
_UIObject_release(self.root2);self.root2=nil;
end
















local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"




function UIMoJieMoJunTwoAreaEffectInfoWin:onLoaded(...)
self:bindComponents()
self.skilllists={self.skillItem,self.skillItem2,self.skillItem3}
end


function UIMoJieMoJunTwoAreaEffectInfoWin:__delete()
self:unbindComponents()
end




function UIMoJieMoJunTwoAreaEffectInfoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id


local quyuEffect=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"quyuEffect2")
self.desc1:setText(FMT.fmt("每次攻打开始后，每隔<color=#ca631d>{0}</color>将从以下阵法随机触发1种",timeHelper.format_time_stamp7(quyuEffect[2])))
self.desc3:setText(FMT.fmt("魔君生命每降低{0}%时，会触发1次<color=#ca631d>袭击</color>效果",quyuEffect[1]/100))

local cfgs=cfg_seasonmojuneffectconfig()
local list={}
for i=4,6 do
table.insert(list,cfgs[i])
end
if list and#list>1 then
table.sort(list,function(a,b)
return a.sort<b.sort
end)
end



















for index=1,#list do
local widget=self.skilllists[index]:getWidgetBase()
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
end


local widget2=self.skillItem4:getWidgetBase()
local cfg2=cfgs[7]
local nameColor=cfg2.addType==1 and"#ca631d"or"#6833c0"
local descColor=cfg2.addType==1 and"#7d3b17"or"#463165"
local bgIcon=cfg2.addType==1 and"image_zhengtaomojun_5"or"image_zhengtaomojun_6"
widget2:SetChildCSImageSprite(1,_abname,cfg2.icon)
widget2:SetChildCSImageSprite(4,_abname,bgIcon)
widget2:SetChildText(3,FMT.fmt("<color={0}>{1}</color>",descColor,cfg2.effectDesc2 or cfg2.effectDesc))
if cfg2.effectTime then
widget2:SetChildText(2,FMT.fmt("<color={0}>{1}（持续{2}分钟）</color>",nameColor,cfg2.name,cfg2.effectTime/60))
else
widget2:SetChildText(2,FMT.fmt("<color={0}>{1}</color>",nameColor,cfg2.name))
end

self.root:setChildCanvasGroupAlpha(0)
self.root2:setChildCanvasGroupAlpha(0)
self.spine:setChildUIModelShowTarget(6438,1,{},eAnimationID.enter,false,false,0)
self.spine2:setChildUIModelShowTarget(6437,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.6,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.root2:setChildCanvasGroupDOFade(1,0.2)
end)
end


function UIMoJieMoJunTwoAreaEffectInfoWin:onHide()

end





function UIMoJieMoJunTwoAreaEffectInfoWin:onBackground()
self:onCloseBtn()
end

function UIMoJieMoJunTwoAreaEffectInfoWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end
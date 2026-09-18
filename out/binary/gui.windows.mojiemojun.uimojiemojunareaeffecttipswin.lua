







def_class("UIMoJieMoJunAreaEffectTipsWin",UIWindowBase)









function UIMoJieMoJunAreaEffectTipsWin:bindComponents()

self.gotoBtn=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.skillBg=UIImage.get(self,2)
self.skillDesc=UIText.get(self,3)
self.skillIcon=UIImage.get(self,4)
self.skillName=UIText.get(self,5)
self.skillTips=UIObject.get(self,6)
self.spine=UIObject.get(self,7)
self.talkDesc=UIText.get(self,8)
self.talkPanel=UIObject.get(self,9)
self.titleIcon=UIImage.get(self,10)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIMoJieMoJunAreaEffectTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillBg);self.skillBg=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillName);self.skillName=nil;
_UIObject_release(self.skillTips);self.skillTips=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.talkPanel);self.talkPanel=nil;
_UIObject_release(self.titleIcon);self.titleIcon=nil;
end
















local _this
local _abname="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"




function UIMoJieMoJunAreaEffectTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMoJieMoJunAreaEffectTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieMoJunAreaEffectTipsWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.confid=argtable.confid
self.areaId=argtable.areaId
self.idx=argtable.idx
self.zfindex=argtable.zfindex


self.MJZJID=xianjieModel:getMoJunZhangJieID()
if self.MJZJID==MoJunZhangJieID.one then
local myAteaId=xianjieModel:getMoJunMyAreaId()
self.skillTips:setActive(not self.areaId or self.areaId==myAteaId)

local cfg=cfg_seasonmojuneffectconfig_get(self.confid)
local nameColor="#bb8cf1"
if cfg.addType==1 then
nameColor="#f1ce78"
end
self.skillName:setText(FMT.fmt("<color={0}>{1}</color>",nameColor,cfg.name))
self.skillDesc:setText(cfg.effectDesc)

self.skillIcon:setCSImageSprite(_abname,cfg.icon)
self.titleIcon:setCSImageSprite(_abname,cfg.addType==1 and"image_mojieui_wz3"or"image_mojieui_wz4")

local mojunData=xianjieModel:getMoJunData()
local isMoJun,isMoJunInit=xianjieModel:isMoJunBuild(mojunData.build_id)
local modelId=isMoJunInit and cfg.bgModelIds[1]or cfg.bgModelIds[2]
self.root:setChildCanvasGroupAlpha(0)
self.talkPanel:setChildCanvasGroupAlpha(0)
self.talkPanel:setActive(true)
self.spine:setChildUIModelShowTarget(modelId,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self:delayDo(0.7,function()
self:setTalkInfo()
end)
elseif self.MJZJID==MoJunZhangJieID.two then
local cfg=cfg_seasonmojuneffectconfig_get(self.confid)
local effectType=cfg.effectType
self._effectType=effectType
self._cfg=cfg
local effectParam=cfg.effectParam
local flag=false
if effectType==3 then
else
flag=self:checkZFpos(effectType,effectParam)
end
self.skillTips:setActive(flag)
local nameColor="#bb8cf1"
self.skillName:setText(FMT.fmt("<color={0}>{1}</color>",nameColor,cfg.name))
self.skillDesc:setText(cfg.effectDesc)

self.skillIcon:setCSImageSprite(_abname,cfg.icon)
local titleIcon=cfg.titleIcon
self.titleIcon:setCSImageSprite(_abname,titleIcon)

local mojunData=xianjieModel:getMoJunData()
local isMoJun,isMoJunInit=xianjieModel:isMoJunBuild(mojunData.build_id)
local modelId=isMoJunInit and cfg.bgModelIds[1]or cfg.bgModelIds[2]
self.root:setChildCanvasGroupAlpha(0)
self.talkPanel:setChildCanvasGroupAlpha(0)
self.talkPanel:setActive(true)
self.spine:setChildUIModelShowTarget(modelId,1,{},eAnimationID.enter,false,false,0)
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
end)
self:delayDo(0.7,function()
self:setTalkInfo()
end)
end
end


function UIMoJieMoJunAreaEffectTipsWin:onHide()

end

function UIMoJieMoJunAreaEffectTipsWin:setTalkInfo()
local cfg=cfg_seasonmojuneffectconfig_get(self.confid)
local talkData=cfg.talk or{}
local t1=talkData[1]or 1
local t2=talkData[2]or 1
local _t=t1+t2
local list=talkData[3]
local len=#list
local talkFunc=function()
if not _this then return end
_this.talkPanel:setChildCanvasGroupDOFade(1,0.2)
_this.talkDesc:setText(list[math.random(1,len)])
_this:delayDo(t1,function()
_this.talkPanel:setChildCanvasGroupDOFade(0,0.2)
end)
end
self:setTimer(_t,0,talkFunc)
talkFunc()
end




function UIMoJieMoJunAreaEffectTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIMoJieMoJunAreaEffectTipsWin:onGotoBtn()
if self.MJZJID==MoJunZhangJieID.two then
local effectType=self._effectType
local cfg=self._cfg
local effectParam=cfg.effectParam
local zhenfajump=cfg.zhenfajump
local zmData=xianjieModel:getMyZongMenData()
local canjump=false
if effectType then
if effectType==ZhenFaeffectType.guaXiang then
if zmData then
local gridX=zmData.gridX
local gridZ=zmData.gridZ
local effectIndex=self.zfindex
if xianjieModel:checkZFGridLimit(effectIndex,gridX,gridZ)then
canjump=true
end
end
if canjump then
xianjieModel:jumpMyZongMen()
else

local effectIndex=self.zfindex
local effectParam2=effectParam[2]
local posParam=effectParam2[effectIndex]
local gridX_c=posParam[1]or 100
local gridZ_c=posParam[2]or 100
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,nil,false)
end

elseif effectType==ZhenFaeffectType.ranLing then
if zmData then
if xianjieModel:checkRanLingZFPos(zmData.gridX,zmData.gridZ,effectParam[3],effectParam[4],effectParam[5],effectParam[6])then
canjump=true
end
end
if canjump then
xianjieModel:jumpMyZongMen()
else

local gridX_c=zhenfajump[1]or 100
local gridZ_c=zhenfajump[2]or 100
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,nil,false)
end

elseif effectType==ZhenFaeffectType.douZhuan then
if self:checkIsInDouZhuanZhenFaPos(effectParam)then
canjump=true
end
if canjump then
xianjieModel:jumpMyZongMen()
else

local effectIndex=self.zfindex or 1
local pos=zhenfajump[effectIndex]
local gridX_c=pos[1]or 100
local gridZ_c=pos[2]or 100
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,nil,false)
end
end
end
else
if self.idx then
xianjieController:jumpMoJieMoJunEffect(self.idx)
else

local curSceneType=xianjieModel:getScenceType()
if not curSceneType or not xianjienSceneType:isMoJie(curSceneType)then

local sceneType=xianjieModel:getCurrentMoJieSceneType()
xianjieController:jumpXianJie(sceneType)
else
xianjieModel:jumpMyZongMen()
end
end
end
self:onCloseBtn()
end


function UIMoJieMoJunAreaEffectTipsWin:checkZFpos(effectType,effectParam)
if effectType==ZhenFaeffectType.guaXiang then
local guildid=xianmengModel:getMyXMGuildID()
if guildid then
xianmengController:reqXMMemberListCheckCD(guildid)
end
local xmlist=xianmengModel:getSearchXMMemberList(guildid)
if xmlist and next(xmlist)then
for k,actorData in pairs(xmlist)do
local zmData=xianjieModel:getZongMenData(actorData.actorid)
if zmData then

local gridX=zmData.gridX
local gridZ=zmData.gridZ
local effectIndex=self.zfindex or 0
if xianjieModel:checkZFGridLimit(effectIndex,gridX,gridZ)then
return true
end
end
end
end
return false
elseif effectType==ZhenFaeffectType.ranLing then
local flag=xianjieModel:checkIsInRanLingZF()
return flag
elseif effectType==ZhenFaeffectType.douZhuan then
local flag=self:checkIsInDouZhuanZhenFaPos(effectParam)
return flag
end
end


function UIMoJieMoJunAreaEffectTipsWin:checkIsInDouZhuanZhenFaPos(effectParam)
local actorid=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorid)
if zmData then
local effectIndex=self.zfindex
if self:checkIsInDouZhuanZhenFa(zmData.gridX,zmData.gridZ,effectParam[2],effectParam[3],effectParam[4],effectIndex)then
return true
end
end
return false
end
function UIMoJieMoJunAreaEffectTipsWin:checkIsInDouZhuanZhenFa(x,y,cx,cy,r,effectIndex)
local r_sq=r*r
for temp_x=x,x+2-1 do
for temp_y=y,y+2-1 do
local dx,dy=temp_x-cx,temp_y-cy
local dist_sq=dx*dx+dy*dy
if dist_sq<=r_sq then
if effectIndex==1 then

if temp_x<=cx and temp_y>=cy then
return true
end
elseif effectIndex==2 then

if temp_x>=cx and temp_y>=cy then
return true
end
elseif effectIndex==3 then

if temp_x>=cx and temp_y<=cy then
return true
end
elseif effectIndex==4 then

if temp_x<=cx and temp_y<=cy then
return true
end
end
end
end
end
return false
end









def_class("UIWenXinGuanUnknownWin",UIWindowBase)









function UIWenXinGuanUnknownWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.directBtn=UIButton.get(self,1)
self.Effect_devil=UIObject.get(self,2)
self.Effect_stand=UIObject.get(self,3)
self.iconDevil=UIObject.get(self,4)
self.iconImmortal=UIObject.get(self,5)
self.iconPeople=UIImage.get(self,6)
self.modelRoot=UIObject.get(self,7)
self.progress=UIObject.get(self,8)
self.Root=UIObject.get(self,9)
self.unknownBg=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.directBtn:setButtonClick(function()self:onDirectBtn()end)
self.Effect={
["devil"]=self.Effect_devil,
["stand"]=self.Effect_stand,
}



end


function UIWenXinGuanUnknownWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.directBtn);self.directBtn=nil;
_UIObject_release(self.Effect_devil);self.Effect_devil=nil;
_UIObject_release(self.Effect_stand);self.Effect_stand=nil;
_UIObject_release(self.iconDevil);self.iconDevil=nil;
_UIObject_release(self.iconImmortal);self.iconImmortal=nil;
_UIObject_release(self.iconPeople);self.iconPeople=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.unknownBg);self.unknownBg=nil;
self.Effect=nil;
end


















local endPos={35,30}
local immortalPosList={-241,-215,-188,-157,-123,-94,-66}
local devilPosList={237,209,183,152,118,88,60}

local abname="ui/windows/wenxinguan/wenxinguan_atlas_pak.ab"


function UIWenXinGuanUnknownWin:onLoaded(...)
self:bindComponents()
end


function UIWenXinGuanUnknownWin:__delete()
self:unbindComponents()
end




function UIWenXinGuanUnknownWin:onShow(argtable,afterOnloaded)
if argtable then
self.dzGuid=argtable.guid

if argtable.return_jump_param then
self.return_jump_param=argtable.return_jump_param
end
end

self:showBgModel()
self:showXMZPos()
self:refreshActorModel()
self:doFadePanel()
end


function UIWenXinGuanUnknownWin:onHide()

end

function UIWenXinGuanUnknownWin:doFadePanel()
local tweener=self.Root:setChildCanvasGroupDOFade(1,0.5)
tweener:SetEase(DG.Tweening.Ease.Linear)
end

function UIWenXinGuanUnknownWin:showXMZPos()
self.xmz_xian,self.xmz_mo=WenXinGuanModel:getDzXMZ(self.dzGuid)
self.iconPeople:setCSImageSprite(abname,iconXMType.normal)

if self.xmz_xian>0 then
if self.xmz_xian>=8 then
local pos=endPos[1]
self.iconImmortal:setChildDOAnchorPosX(0,0)
self.iconImmortal:setChildDOAnchorPosY(pos,0)
else
local pos=immortalPosList[self.xmz_xian]
self.iconImmortal:setChildDOAnchorPosX(pos,0)
end
end

if self.xmz_mo>0 then
if self.xmz_mo>=8 then
local pos=endPos[2]
self.iconDevil:setChildDOAnchorPosX(0,0)
self.iconDevil:setChildDOAnchorPosY(pos,0)
else
local pos=devilPosList[self.xmz_mo]
self.iconDevil:setChildDOAnchorPosX(pos,0)
end
end
end

function UIWenXinGuanUnknownWin:refreshActorModel()
local dzScale=1
local animId=eAnimationID.stand
local info=UIDiscipleModel:getDiscipleImageInfo(self.dzGuid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)

self.modelRoot:setChildUIModelShowTarget(modelParams.body,dzScale,modelParams.componets,animId)
self.modelRoot:setChildUIModelShowFlipX(false)
end

function UIWenXinGuanUnknownWin:showBgModel()
local animId=eAnimationID.stand
self.unknownBg:setChildUIModelShowTarget(5520,1,{},animId,false,false,0)
end





function UIWenXinGuanUnknownWin:onCloseBtn()


if not self.return_jump_param then

local guid=self.dzGuid
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
UIManager:showWindow('UIDiscipleJingJieWin',{guid=guid})
else
jumpManager:jump(self.return_jump_param)
end
end

function UIWenXinGuanUnknownWin:hideAndShow(flag)
self.progress:setActive(flag)
end


function UIWenXinGuanUnknownWin:onDirectBtn()
local startCallback=function()
self:hideAndShow(false)
WenXinGuanModel:setMemoryTransferWin(self.dzGuid)
UIManager:showWindow("UIWenXinGuanTransferWin",{guid=self.dzGuid})

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end

UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end
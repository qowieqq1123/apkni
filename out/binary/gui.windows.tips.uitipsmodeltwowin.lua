







def_class("UITipsModelTwoWin",UIWindowBase)









function UITipsModelTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.normalmodel=UIObject.get(self,1)
self.normalImage=UIImage.get(self,2)
self.bubbleframeRoot=UIImage.get(self,3)
self.headKuang=UIImage.get(self,4)
self.bubbleModel=UIObject.get(self,5)
self.emotRoot=UIObject.get(self,6)
self.emoticon=UIImage.get(self,7)



end


function UITipsModelTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.normalmodel);self.normalmodel=nil;
_UIObject_release(self.normalImage);self.normalImage=nil;
_UIObject_release(self.bubbleframeRoot);self.bubbleframeRoot=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.bubbleModel);self.bubbleModel=nil;
_UIObject_release(self.emotRoot);self.emotRoot=nil;
_UIObject_release(self.emoticon);self.emoticon=nil;
end

















local _this
local ShowModelType=
{
eNormalImage=1,
eNormalModel=2,
eBubbleFrame=3,
eHeadKuang=4,
eBigEmot=5,
}

local ShowModelFun=
{
[ShowModelType.eNormalImage]=function()
_this:showNormalImage()
end,
[ShowModelType.eNormalModel]=function()
_this:showNormalModel()
end,
[ShowModelType.eBubbleFrame]=function()
_this:showBubbleFrameModel()
end,
[ShowModelType.eHeadKuang]=function()
_this:showHeadKuangModel()
end,
[ShowModelType.eBigEmot]=function()
_this:showBigEmotModel()
end,
}


local InitShowPramFun=
{
[18]={
[1]=function()
_this:InitShowPram_HeadKuang()
end,
[2]=function()
_this:InitShowPram_BubbleFrame()
end,
[4]=function()
_this:InitShowPram_BigEmot()
end
}
}


local _movePosX=
{
[TIPS_MOVE_POS.eRight]=300,
[TIPS_MOVE_POS.eLeft]=-300,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}



function UITipsModelTwoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UITipsModelTwoWin:__delete()
_this=nil
self:unbindComponents()
end




function UITipsModelTwoWin:onShow(argtable,afterOnloaded)


self.itemId=argtable and argtable.itemId
self.moveType=argtable and argtable.moveType
if not self.itemId then
logErr("展示tips模型界面2 未传入道具id 请前端检查调用窗口位置代码")
end

self.itemCfg=itemsConfig.getConfig(self.itemId)

self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)
self:initShowModel()

if self.showType then
ShowModelFun[self.showType]()
else
logErr(FMT.fmt("找不到道具{0}对应的展示类型 请确认是否支持该类型道具展示",self.itemId))
end
end


function UITipsModelTwoWin:onHide()

end


function UITipsModelTwoWin:initShowModel()
local itemType1=self.itemCfg.type1
local itemType2=self.itemCfg.type2
self.showType=nil
self.showPram={}

if itemType1 and InitShowPramFun[itemType1]then
if itemType2 and InitShowPramFun[itemType1][itemType2]then
InitShowPramFun[itemType1][itemType2]()
else
InitShowPramFun[itemType1]()
end
end
end


function UITipsModelTwoWin:hideAllModel()
self.normalmodel:setActive(false)
self.normalImage:setActive(false)
self.bubbleframeRoot:setActive(false)
self.headKuang:setActive(false)
self.emotRoot:setActive(false)
end


function UITipsModelTwoWin:InitShowPram_HeadKuang()
local relevantPram=self.itemCfg.relevantPram
local headKuangId=relevantPram.relevantId
local headKuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headKuangId)
if headKuangCfg then
self.showType=ShowModelType.eHeadKuang
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
self.showPram={headKuangId=headKuangId,headKuangIcon=headKuangCfg.icon,size=size,offset=offset}
end
end


function UITipsModelTwoWin:InitShowPram_BubbleFrame()
local relevantPram=self.itemCfg.relevantPram
local bubbleFrameId=relevantPram.relevantId
local bubbleFrameCfg=cfgHelper.get1(cfg_bubbleframeconfig_get,bubbleFrameId)
if bubbleFrameCfg then
self.showType=ShowModelType.eBubbleFrame
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
self.showPram={bubbleFrameId=bubbleFrameId,bubbleFrameIcon=bubbleFrameCfg.icon,bubbleFrameModel=bubbleFrameCfg.setmodel,size=size,offset=offset}
end
end


function UITipsModelTwoWin:InitShowPram_BigEmot()
local relevantPram=self.itemCfg.relevantPram
local bigEmotId=relevantPram.relevantId
local bigEmotCfg=cfgHelper.get1(cfg_chatebigmotconfig_get,bigEmotId)
if bigEmotCfg then
self.showType=ShowModelType.eBigEmot
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
self.showPram={emotid=bigEmotId,size=size,offset=offset}
end
end


function UITipsModelTwoWin:showNormalImage()

self:hideAllModel()

local imageName=self.showPram.imageName
self.normalImage:setImageIcon(imageName,true)
self.normalImage:setScale(Vector3.New(self.showPram.size,self.showPram.size,self.showPram.size))
self.normalImage:setChildAnchoredPosition(Vector2.New(self.showPram.offset[1],self.showPram.offset[2]))
self.normalImage:setActive(true)
end


function UITipsModelTwoWin:showNormalModel()

self:hideAllModel()
self.normalmodel:setChildUIModelShowTarget(self.showPram.modelId,self.showPram.size,{},self.showPram.anim)
self.normalmodel:setChildUIModelShowTargetOffset(self.showPram.offset[1],self.showPram.offset[2])
self.normalmodel:setActive(true)
end


function UITipsModelTwoWin:showHeadKuangModel()

self:hideAllModel()
local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(self.showPram.headKuangId)
playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID(),self.showPram.headKuangIcon,kuangAnimType,kuangAnim,nil,enterAnimId)

self.headKuang:setScale(Vector3.New(self.showPram.size,self.showPram.size,self.showPram.size))
self.headKuang:setChildAnchoredPosition(Vector2.New(self.showPram.offset[1],self.showPram.offset[2]))
self.headKuang:setActive(true)
end


function UITipsModelTwoWin:showBubbleFrameModel()

self:hideAllModel()

local bgmodel=self.showPram.bubbleFrameModel
if bgmodel then
self.winlua:SetChildUIModelEnableInitUISpinePara(self.bubbleModel:getID(),false,true)
self.bubbleModel:setChildUIModelShowTarget(bgmodel,1,{},eAnimationID.stand)
else
local kuangIconName=iconHelper.getChatKuangIcon(self.showPram.bubbleFrameIcon)
self.bubbleframeRoot:setImageIcon(kuangIconName,false)
end
self.bubbleframeRoot:setScale(Vector3.New(self.showPram.size,self.showPram.size,self.showPram.size))
self.bubbleframeRoot:setChildAnchoredPosition(Vector2.New(self.showPram.offset[1],self.showPram.offset[2]))
self.bubbleframeRoot:setActive(true)
end


function UITipsModelTwoWin:showBigEmotModel()

self:hideAllModel()

local bigEmotName=iconHelper.getBigEmotIcon(self.showPram.emotid)

self.emoticon:setImageIcon(bigEmotName,false)

self.emotRoot:setScale(Vector3.New(self.showPram.size,self.showPram.size,self.showPram.size))
self.emotRoot:setChildAnchoredPosition(Vector2.New(self.showPram.offset[1],self.showPram.offset[2]))
self.emotRoot:setActive(true)
end


function UITipsModelTwoWin:onAniComplete()
if self.moveType then
self.winlua:SetChildDOLocalMoveX(self.root:getID(),_movePosX[self.moveType],0.3)
end
end
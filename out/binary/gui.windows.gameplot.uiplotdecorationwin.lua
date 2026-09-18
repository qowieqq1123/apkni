







def_class("UIPlotDecorationWin",UIWindowBase)









function UIPlotDecorationWin:bindComponents()

self.back=UIImage.get(self,0)
self.blackFade=UIObject.get(self,1)
self.effectList=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.spineObj=UIObject.get(self,4)



end


function UIPlotDecorationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.blackFade);self.blackFade=nil;
_UIObject_release(self.effectList);self.effectList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spineObj);self.spineObj=nil;
end
















local _this




function UIPlotDecorationWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIPlotDecorationWin:__delete()
_this=nil
self:unbindComponents()
end




function UIPlotDecorationWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}

if argtable.canvas then
self.winlua:SetCanvasIndex(-1,argtable.canvas)
end

local m_cav=self:getChildCanvas(-1)
if argtable.effectIdList then
local effectLen=#argtable.effectIdList
self.effectList:setChildLayoutGroupCreateItems(effectLen,function(index)
if _this==nil then return end
local item=_this.effectList:getChildLayoutGroupGridItem(index-1)
local effectId=argtable.effectIdList[index]
item:SetChildShowEffectEx(-1,effectId,m_cav[1],m_cav[2]+1,true)
end)
end

if argtable.modelId then
local size=argtable.modelSize or 1
local components=argtable.modelCompnents or{}
local animation=argtable.modelAniamtion or eAnimationID.stand
local offset=argtable.offset

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.spineObj:getID(),true,true,true)
self.spineObj:setChildUIModelShowTarget(argtable.modelId,size,components,animation)
if offset then
self.spineObj:setChildAnchoredPos(offset[1],offset[2])
end
end

local isShowBack=argtable.backArgs~=nil
self.back:setActive(isShowBack)
if isShowBack then
local backArgs=argtable.backArgs
if backArgs.iconName and backArgs.ab then
self.back:setCSImageSprite(backArgs.ab,backArgs.iconName)
end

if backArgs.color then
local color=backArgs.color
local wb=self.back:getWidgetBase()
wb:SetChildColor(-1,Color.New(color[1],color[2],color[3],color[4]))
end
end

self:showblackFade(argtable)

if argtable.autoCloseTime then
self:delayDo(argtable.autoCloseTime,function()
self:closeWindow()
end)
end
end


function UIPlotDecorationWin:onHide()

end

function UIPlotDecorationWin:onShowArgRecv(args)
self:onShow(args)
end

function UIPlotDecorationWin:changeEffect(args)
args=args or{}

if args.effectIdList then
local grids=self.effectList:getChildLayoutGroupGridList()
for index=1,grids.Count do
local effectId=args.effectIdList[index]
local isShow=effectId~=nil
effectId=effectId or 0
local item=grids[index-1]
item:SetChildShowEffect(-1,effectId,isShow)
end
else
self.effectList:setChildLayoutGroupClearAllItems()
end
end

function UIPlotDecorationWin:changeModel(args)
if args.modelId then
local size=args.modelSize or 1
local components=args.modelCompnents or{}
local animation=args.modelAniamtion or eAnimationID.stand

self.spineObj:setChildUIModelShowTarget(args.modelId,size,components,animation)
else
self.spineObj:setChildUIModelRemoveTarget()
end
end

function UIPlotDecorationWin:showblackFade(argtable)
local isShowBlackFade=argtable.blackFadeDuration and argtable.blackFadeDuration>0
self.blackFade:setActive(isShowBlackFade)
if isShowBlackFade then
self.blackFade:setChildCanvasGroupAlpha(0)
if self.blackFadeDt then
self.blackFadeDt:Complete()

end
self.blackFade:setChildCanvasGroupDOFade(1,argtable.blackFadeDuration)
end
end


function UIPlotDecorationWin:closeWindow()
self:closeSelf()
end




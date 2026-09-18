







def_class("UIDiscipleShuWuSkillTipsWin",UIWindowBase)









function UIDiscipleShuWuSkillTipsWin:bindComponents()

self.blackImg=UIButton.get(self,0)
self.buttonRoot=UIObject.get(self,1)
self.Content=UIObject.get(self,2)
self.costInfo=UIObject.get(self,3)
self.costInfoTitle=UIText.get(self,4)
self.costScrollView=UIObject.get(self,5)
self.currSkillDesc=UIText.get(self,6)
self.currSkillInfo=UIObject.get(self,7)
self.infoLayout=UIObject.get(self,8)
self.levelUpBtn=UIButton.get(self,9)
self.levelUpBtnText=UIText.get(self,10)
self.menu_anim_1=UIObject.get(self,11)
self.menuAnimGrid=UIObject.get(self,12)
self.needLevel=UIText.get(self,13)
self.nextSkillDesc=UIText.get(self,14)
self.nextSkillInfo=UIObject.get(self,15)
self.root=UIObject.get(self,16)
self.skillItem=UIObject.get(self,17)
self.title1=UIObject.get(self,18)
self.title2=UIObject.get(self,19)
self.title3=UIObject.get(self,20)

self.blackImg:setButtonClick(function()self:onBlackImg()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)
self.menu_anim={
self.menu_anim_1,
}



end


function UIDiscipleShuWuSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costInfo);self.costInfo=nil;
_UIObject_release(self.costInfoTitle);self.costInfoTitle=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.currSkillDesc);self.currSkillDesc=nil;
_UIObject_release(self.currSkillInfo);self.currSkillInfo=nil;
_UIObject_release(self.infoLayout);self.infoLayout=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.needLevel);self.needLevel=nil;
_UIObject_release(self.nextSkillDesc);self.nextSkillDesc=nil;
_UIObject_release(self.nextSkillInfo);self.nextSkillInfo=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
self.menu_anim=nil;
end
















local _this




function UIDiscipleShuWuSkillTipsWin:onLoaded(...)
self:bindComponents()
_this=self

self.costScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDiscipleShuWuSkillTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleShuWuSkillTipsWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.level=argtable.level
self.dzId=argtable.dzId
self.noButton=argtable.noButton
self.dzData=UIDiscipleModel:getDiscipleData(self.dzId)
self.istops=argtable.istops

self:refresh()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.02,function()
_this.root:setChildCanvasGroupDOFade(1,0.6)
end)
end
end


function UIDiscipleShuWuSkillTipsWin:onHide()

end

function UIDiscipleShuWuSkillTipsWin:refresh(level)
self.level=level or self.level

local swcfg=UIDiscipleModel:getShuWuDZConfig(self.dzData.id)
local isActive=self.level>0

self.skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,self.id,self.level)
self.nextSkillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,self.id,self.level+1)
self.infoCfg=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,self.id)

local widget=self.skillItem:getChildWidgetBase()
local icon=iconHelper.getSkillIcon(self.infoCfg.icon)
widget:SetChildIcon(0,icon,true)
widget:SetChildText(1,self.infoCfg.name)
if isActive then
widget:SetChildText(2,FMT.fmt('{0}级',self.level))
else
widget:SetChildText(2,'未激活')
end

self.bdId=swcfg.bdId
local desc
if isActive then
desc=UIDiscipleModel:getShuWuSkillDesc(self.skillCfg.bonus[1],self.dzData.id)
else
desc=UIDiscipleModel:getShuWuSkillDesc(self.nextSkillCfg.bonus[1],self.dzData.id)
end
self.currSkillDesc:setText(desc)

local showNext=isActive and self.nextSkillCfg~=nil
self.title2:setActive(showNext)
self.nextSkillInfo:setActive(showNext)
if showNext then
desc=UIDiscipleModel:getShuWuSkillNextDesc(self.nextSkillCfg.bonus[1],self.dzData.id)
self.nextSkillDesc:setText(desc)
end

local showCost=not isActive or showNext
self.title3:setActive(showCost)
self.costInfo:setActive(showCost)
if showCost then
local nlevel=self.skillCfg.qiaojiang
local name,order=UIDiscipleModel:getShuWuQJLevelInfo(self.bdId,nlevel)
self.needLevel:setText(FMT.fmt('弟子成为{0}{1}阶',name,order))

local consume=self.skillCfg.consume
local len=#consume
self.costScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.costScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=consume[i]
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],checkAmount=true})
end
end

self:showBtn(not self.noButton and showCost,isActive and'升级'or'激活')


self.widget:SetChildLayoutElementEnable(self.infoLayout:getID(),false)

self:delayDo(0.02,function()
local maxH=270
local infoHeight=_this.Content:getChildRectHeight()
if infoHeight>=maxH then
_this.widget:SetChildLayoutElementEnable(_this.infoLayout:getID(),true)
_this.widget:SetChildLayoutElementPreferredHeight(_this.infoLayout:getID(),maxH)

_this.winlua:SetChildLocalPosY(_this.root:getID(),286)
elseif infoHeight>210 then
_this.winlua:SetChildLocalPosY(_this.root:getID(),256+(infoHeight-210)/2)
end
end)
end

function UIDiscipleShuWuSkillTipsWin:showBtn(bShow,btnName)
self.buttonRoot:setActive(false)
self.menuAnimGrid:setActive(bShow)
if bShow then
local anim=self.menu_anim[1]
anim:setChildUIModelShowTarget(2017,1,{},eAnimationID.common_window_enter,false,false,0,nil)
local func1=function()
self.buttonRoot:setActive(true)
self.buttonRoot:setChildCanvasGroupAlpha(0)
self.buttonRoot:setChildCanvasGroupDOFade(1,1,nil)
end
self:delayDo(0.3,func1)
self.levelUpBtnText:setText(btnName)
end
end

function UIDiscipleShuWuSkillTipsWin:checkClose()
if not UIDiscipleController:checkShuWuQJSkillLevelUp(self.dzData,self.skillCfg,true)then
self:onBlackImg()
end
end



function UIDiscipleShuWuSkillTipsWin:onBlackImg()
self:closeSelf()
end

function UIDiscipleShuWuSkillTipsWin:onLevelUpBtn()
if UIDiscipleController:checkShuWuQJSkillLevelUp(self.dzData,self.skillCfg,true)then
local cfg=UIDiscipleModel:getShuWuDZConfig(self.dzData.id)
local index
for i,v in ipairs(cfg.skill)do
if self.id==v then
index=i
break
end
end
UIDiscipleController:reqQiaoJiangSkillLevelUp(self.dzId,index)
end
end

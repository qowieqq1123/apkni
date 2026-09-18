







def_class("UIXianZhiLevelUpWin",UIWindowBase)









function UIXianZhiLevelUpWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.left=UIObject.get(self,2)
self.model=UIObject.get(self,3)
self.right=UIObject.get(self,4)
self.Root=UIObject.get(self,5)
self.title=UIObject.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianZhiLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpPartIndex={
level=0,
starList=1,
attrList=2,
skillDesc=3,
}




function UIXianZhiLevelUpWin:onLoaded(...)
self:bindComponents()
end


function UIXianZhiLevelUpWin:__delete()
self:unbindComponents()
end




function UIXianZhiLevelUpWin:onShow(argtable,afterOnloaded)

self.curXzId=argtable.curXzId
self.oldXzId=argtable.oldXzId

local gbid=cfgHelper.get2(cfg_xianzhibaseconfig_get,1,'gbid')
self.curGbLv=gubaoModel:getSkillLv(gbid)
self.oldGbLv=self.curGbLv-1

self:refreshAll()

local spineCallBack=function()
self.title:setChildShowEffect(20430,true)
end
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgSpine:getID(),true,true,true)
self.bgSpine:setChildUIModelShowTarget(5551,1,nil,eAnimationID.enter,false,false,0.1,spineCallBack)
end


function UIXianZhiLevelUpWin:onHide()

end

function UIXianZhiLevelUpWin:refreshAll()

local isShowSKillEffect=xianzhiConfig.checkShowSkillEffectDesc(self.oldXzId,self.curXzId)


local leftWb=self.left:getWidgetBase()
self:refreshPart(leftWb,self.oldXzId,self.oldGbLv,'#171311',isShowSKillEffect)


local rigtWb=self.right:getWidgetBase()
self:refreshPart(rigtWb,self.curXzId,self.curGbLv,'#549327',isShowSKillEffect)

self.model:setChildUIModelShowTarget(5552,0.8,nil,eAnimationID.stand)
end

function UIXianZhiLevelUpWin:refreshPart(wb,xzId,gblv,color,isShowSKillEffect)
local gbid=cfgHelper.get2(cfg_xianzhibaseconfig_get,1,'gbid')
local xzLvCfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzId)


local jctian=xzLvCfg.jctian
local levelStr=FMT.fmt("仙职：{0}重天",mathHelper.numberToChinese(jctian))
wb:SetChildText(CmpPartIndex.level,levelStr)


local starIdx=xzLvCfg.star
local totalStarNum=xianzhiModel:getXzTotalStarNum(xzId)
wb:SetChildLayoutGroupCreateItems(CmpPartIndex.starList,totalStarNum,function(index)
local sitem=wb:GetChildLayoutGroupGridItem(CmpPartIndex.starList,index-1)
local isLight=starIdx>=index
sitem:SetChildActive(0,isLight)
end)


local gbData=gubaoModel:getDataByID(gbid)
local attrLookup={}
gubaoModel:calculationAttrLookup(attrLookup,gbid,gbData.gubaolhlv,gbData.gubaostar,gbData.gubaojxlv,gblv)
local gbAttrList=attrListHelper.sortByLookup(attrLookup)
wb:SetChildLayoutGroupCreateItems(CmpPartIndex.attrList,#gbAttrList,function(index)
local aitem=wb:GetChildLayoutGroupGridItem(CmpPartIndex.attrList,index-1)

local attr=gbAttrList[index]
local str=helper.getAttributeStr(attr[1],attr[2],nil,"{0}：{1}")
str=toColorStringX(color,str)
aitem:SetChildText(0,str)
end)

wb:SetChildActive(CmpPartIndex.skillDesc,isShowSKillEffect)
if isShowSKillEffect then
local xianzhiCfgs=cfg_xianzhiconfig()
local flPercent=xianzhiCfgs[xzId].flPercent
local desc=FMT.fmt("仙职每日俸禄+{0}%",flPercent*100)
wb:SetChildText(CmpPartIndex.skillDesc,toColorStringX(color,desc))
end
end





function UIXianZhiLevelUpWin:onCloseBtn()
local oldXzId=self.oldXzId
local curXzId=self.curXzId
UIFullXianTuChengJiuControl:closeWindow('UIXianZhiLevelUpWin')
xianzhiController.checkShowActiveBeishi(oldXzId,curXzId)
end


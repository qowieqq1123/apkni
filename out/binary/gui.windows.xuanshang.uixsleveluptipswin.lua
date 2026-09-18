







def_class("UIXSLevelUpTipsWin",UIWindowBase)









function UIXSLevelUpTipsWin:bindComponents()

self.top=UIObject.get(self,0)
self.bottom=UIObject.get(self,1)
self.center=UIObject.get(self,2)
self.title=UIText.get(self,3)
self.des=UIText.get(self,4)
self.titleC=UIText.get(self,5)
self.desC=UIText.get(self,6)
self.tipsRoot=UIObject.get(self,7)
self.fullTips=UIText.get(self,8)
self.tips2=UIText.get(self,9)
self.tips1=UIText.get(self,10)
self.textProb_5=UIText.get(self,11)
self.textProb_3=UIText.get(self,12)
self.textProb_2=UIText.get(self,13)
self.textProb_1=UIText.get(self,14)
self.textProb_4=UIText.get(self,15)
self.textNextProb_1=UIText.get(self,16)
self.textNextProb_2=UIText.get(self,17)
self.textNextProb_3=UIText.get(self,18)
self.textNextProb_4=UIText.get(self,19)
self.textNextProb_5=UIText.get(self,20)
self.textProb={
self.textProb_1,
self.textProb_2,
self.textProb_3,
self.textProb_4,
self.textProb_5,
}
self.textNextProb={
self.textNextProb_1,
self.textNextProb_2,
self.textNextProb_3,
self.textNextProb_4,
self.textNextProb_5,
}



end


function UIXSLevelUpTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.titleC);self.titleC=nil;
_UIObject_release(self.desC);self.desC=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.tips2);self.tips2=nil;
_UIObject_release(self.tips1);self.tips1=nil;
_UIObject_release(self.textProb_5);self.textProb_5=nil;
_UIObject_release(self.textProb_3);self.textProb_3=nil;
_UIObject_release(self.textProb_2);self.textProb_2=nil;
_UIObject_release(self.textProb_1);self.textProb_1=nil;
_UIObject_release(self.textProb_4);self.textProb_4=nil;
_UIObject_release(self.textNextProb_1);self.textNextProb_1=nil;
_UIObject_release(self.textNextProb_2);self.textNextProb_2=nil;
_UIObject_release(self.textNextProb_3);self.textNextProb_3=nil;
_UIObject_release(self.textNextProb_4);self.textNextProb_4=nil;
_UIObject_release(self.textNextProb_5);self.textNextProb_5=nil;
self.textProb=nil;
self.textNextProb=nil;
end



















function UIXSLevelUpTipsWin:onLoaded(...)
self:bindComponents()

self.tips={
self.tips1,
self.tips2,
}
end


function UIXSLevelUpTipsWin:__delete()
self:unbindComponents()
end




function UIXSLevelUpTipsWin:onShow(argtable,afterOnloaded)
local level=UIXuanShangControl:getXuanShangLevel()
self.title:setText(FMT.fmt('{0}级效果',level))
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtasklevelconfig_get,level)
self.des:setText(cfg.nextLevelDesc)

local allWeight=0
local weightList={}
for i,v in ipairs(cfg.colorWeight)do
weightList[v[1]]=v[2]
allWeight=allWeight+v[2]
end
for i,v in ipairs(self.textProb)do
local curWeight=weightList[i]or 0
v:setText(FMT.fmt('{0}%',math.floor(1000*curWeight/allWeight)/10))
end

local nextcfg=cfgHelper.get1(cfg_zongmenxuanshangtasklevelconfig_get,level+1)
if nextcfg then
self.center:setActive(true)
self.titleC:setText('下级效果')
self.desC:setText(nextcfg.nextLevelDesc)

local allWeight=0
local weightList={}
for i,v in ipairs(nextcfg.colorWeight)do
weightList[v[1]]=v[2]
allWeight=allWeight+v[2]
end
for i,v in ipairs(self.textNextProb)do
local curWeight=weightList[i]or 0
v:setText(FMT.fmt('{0}%',math.floor(1000*curWeight/allWeight)/10))
end

self.tipsRoot:setActive(true)
self.fullTips:setText('')
for i=1,2 do
local v=cfg.levelCondition[i]
local tips=self.tips[i]
if v then
tips:setActive(true)
local num=UIXuanShangControl:getJinduByColor(v[2])
local color=num>=v[1]and'#76d81e'or'#cacaca'
tips:setText(FMT.fmt('<color={4}>完成{0}个{1}品质及以上的任务（{2}/{3}）</color>',
v[1],eQualityColorName[v[2]],num,v[1],color))
else
tips:setActive(false)
end
end
else
self.center:setActive(false)
self.tipsRoot:setActive(false)
self.fullTips:setText('已满级')
end
end


function UIXSLevelUpTipsWin:onHide()

end




function UIXSLevelUpTipsWin:onCloseClick()
self:closeSelf()
end
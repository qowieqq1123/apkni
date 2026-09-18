







def_class("UIChuanGongResultWin_LingShou",UIWindowBase)









function UIChuanGongResultWin_LingShou:bindComponents()

self.infoPanelA=UIObject.get(self,0)
self.infoPanelB=UIObject.get(self,1)



end


function UIChuanGongResultWin_LingShou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanelA);self.infoPanelA=nil;
_UIObject_release(self.infoPanelB);self.infoPanelB=nil;
end
















local _this

local _infoCmpIndex={
head=0,
name=1,
jj1=2,
jj2=3,
xm1=4,
xm2=5,
sproot=6,
c1=7,
c2=8,
ql2=9,
c3=10,
jn2=11,
c4=12,
sp=13,
ql1=14,
jn1=15
}




function UIChuanGongResultWin_LingShou:onLoaded(...)
self:bindComponents()

_this=self
end


function UIChuanGongResultWin_LingShou:__delete()

_this=nil
self:unbindComponents()
end




function UIChuanGongResultWin_LingShou:onShow(argtable,afterOnloaded)
self.lsGuidSrc=argtable.exArgs.lsGuidSrc
self.lsGuidDest=argtable.exArgs.lsGuidDest
self.oldSrcJJ=argtable.exArgs.oldSrcJJ
self.oldSrcXM=argtable.exArgs.oldSrcXM
self.oldSrcQL=argtable.exArgs.oldSrcQL
self.oldSrcJN=argtable.exArgs.oldSrcJN
self.oldDestJJ=argtable.exArgs.oldDestJJ

self:refreshAll()
end


function UIChuanGongResultWin_LingShou:onHide()

end




function UIChuanGongResultWin_LingShou:getNameColor(lv1,lv2)
local color
if lv1>lv2 then
color='#c82c2c'
elseif lv1<lv2 then
color='#549327'
else
color='#000000'
end
return color
end

function UIChuanGongResultWin_LingShou:getColorStr(lv1,lv2,str)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,str)
return name
end

function UIChuanGongResultWin_LingShou:refreshAll()
self:refreshLeft()
self:refreshRight()
end

function UIChuanGongResultWin_LingShou:refreshLeft()
local lsData=lingshouModel:getLingShouData2(self.lsGuidSrc)
local widget=self.infoPanelA:getChildWidgetBase()
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_infoCmpIndex.head,0,eHeadCenterType.eHead,1)
widget:SetChildText(_infoCmpIndex.name,lsData.name)

widget:SetChildText(_infoCmpIndex.jj1,lingshouModel.getJJNameEx(self.oldSrcJJ,2))
widget:SetChildText(_infoCmpIndex.jj2,self:getColorStr(self.oldSrcJJ,lsData.jj_lvl,lingshouModel.getJJNameEx(lsData.jj_lvl,2)))

local xmName1=lingshouModel:switchLevelToStageName_XueMai(self.oldSrcXM)
widget:SetChildText(_infoCmpIndex.xm1,xmName1)
local xmName2=lingshouModel:switchLevelToStageName_XueMai(lsData.xuemai_val)
widget:SetChildText(_infoCmpIndex.xm2,self:getColorStr(self.oldSrcXM,lsData.xuemai_val,xmName2))

widget:SetChildText(_infoCmpIndex.ql1,self.oldSrcQL)
widget:SetChildText(_infoCmpIndex.ql2,self:getColorStr(self.oldSrcQL,lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI),lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)))

widget:SetChildText(_infoCmpIndex.jn1,FMT.fmt('{0}级',self.oldSrcJN))
widget:SetChildText(_infoCmpIndex.jn2,self:getColorStr(self.oldSrcQL,lsData.skill_level,FMT.fmt('{0}级',lsData.skill_level)))

local isLHSS=lingshouModel:checkLingshouZiZhiIsReduce(self.lsGuidSrc)
widget:SetChildActive(_infoCmpIndex.sproot,isLHSS)
end

function UIChuanGongResultWin_LingShou:refreshRight()
local lsData=lingshouModel:getLingShouData2(self.lsGuidDest)
local widget=self.infoPanelB:getChildWidgetBase()
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_infoCmpIndex.head,0,eHeadCenterType.eHead,1)
widget:SetChildText(_infoCmpIndex.name,lsData.name)

widget:SetChildText(_infoCmpIndex.jj1,lingshouModel.getJJNameEx(self.oldDestJJ,2))
widget:SetChildText(_infoCmpIndex.jj2,self:getColorStr(self.oldDestJJ,lsData.jj_lvl,lingshouModel.getJJNameEx(lsData.jj_lvl,2)))
end

function UIChuanGongResultWin_LingShou:onCloseClick()
self:closeSelf()
end
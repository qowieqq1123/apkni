







def_class("UIChuanGongResultWin",UIWindowBase)









function UIChuanGongResultWin:bindComponents()

self.infoPanelA=UIObject.get(self,0)
self.infoPanelB=UIObject.get(self,1)



end


function UIChuanGongResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanelA);self.infoPanelA=nil;
_UIObject_release(self.infoPanelB);self.infoPanelB=nil;
end



















function UIChuanGongResultWin:onLoaded(...)
self:bindComponents()
end


function UIChuanGongResultWin:__delete()
self:unbindComponents()
end

function UIChuanGongResultWin:getNameColor(lv1,lv2)
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

function UIChuanGongResultWin:getJJName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getJJNameEx(lv2))
return name
end

function UIChuanGongResultWin:getLTName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getLTNameEx(lv2))
return name
end




function UIChuanGongResultWin:onShow(argtable,afterOnloaded)
local infoData=argtable
local infoA=infoData[1]
local widgetA=self.infoPanelA:getChildWidgetBase()
local name=UIDiscipleModel:getDiscipleName(infoA.dzId)
comHelper.setChildModelRawImage(widgetA,infoA.dzId,0,0,eHeadCenterType.eHead)
widgetA:SetChildText(1,name)
widgetA:SetChildText(2,UIDiscipleModel:getJJNameEx(infoA.jingjie1))
widgetA:SetChildText(3,self:getJJName(infoA.jingjie1,infoA.jingjie2))
widgetA:SetChildText(4,UIDiscipleModel:getLTNameEx(infoA.lianti1))
widgetA:SetChildText(5,self:getLTName(infoA.lianti1,infoA.lianti2))

widgetA:SetChildActive(8,infoA.jingjie1~=infoA.jingjie2)
widgetA:SetChildActive(9,infoA.lianti1~=infoA.lianti2)

local sptype=infoA.sptype
if sptype then
widgetA:SetChildActive(6,true)
local spitem=widgetA:GetChildWidgetBase(7)
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eChuangShang,sptype[2])
UIDiscipleModel.refreshSpecialityItemEx(spitem,cfg)
spitem:SetChildButtonClick(0,function()
UIManager:showWindow('UISpecialityWin',{item=spitem,node='bottom',guid=infoA.dzId,config=cfg})
end)
else
widgetA:SetChildActive(6,false)
end

local infoB=infoData[2]
local widgetB=self.infoPanelB:getChildWidgetBase()
name=UIDiscipleModel:getDiscipleName(infoB.dzId)
comHelper.setChildModelRawImage(widgetB,infoB.dzId,0,0,eHeadCenterType.eHead)
widgetB:SetChildText(1,name)
widgetB:SetChildText(2,UIDiscipleModel:getJJNameEx(infoB.jingjie1))
widgetB:SetChildText(3,self:getJJName(infoB.jingjie1,infoB.jingjie2))
widgetB:SetChildText(4,UIDiscipleModel:getLTNameEx(infoB.lianti1))
widgetB:SetChildText(5,self:getLTName(infoB.lianti1,infoB.lianti2))
widgetB:SetChildActive(6,false)

widgetB:SetChildActive(8,infoB.jingjie1~=infoB.jingjie2)
widgetB:SetChildActive(9,infoB.lianti1~=infoB.lianti2)

local exArgs=infoData.exArgs
if exArgs then
for i,v in ipairs(exArgs.tips)do
UIManager.info(v)
end
if exArgs.cddVal then
UIManager.info(FMT.fmt('获得传道点数{0}',exArgs.cddVal))
end
end
end


function UIChuanGongResultWin:onHide()

end

function UIChuanGongResultWin:onCloseClick()
UIDiscipleController:showPrize_daoyan()
self:closeSelf()
end




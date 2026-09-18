







def_class("UIChuanGongResultWin_JingNeng",UIWindowBase)









function UIChuanGongResultWin_JingNeng:bindComponents()

self.infoPanelA=UIObject.get(self,0)
self.infoPanelB=UIObject.get(self,1)



end


function UIChuanGongResultWin_JingNeng:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanelA);self.infoPanelA=nil;
_UIObject_release(self.infoPanelB);self.infoPanelB=nil;
end



















function UIChuanGongResultWin_JingNeng:onLoaded(...)
self:bindComponents()
end


function UIChuanGongResultWin_JingNeng:__delete()
self:unbindComponents()
end




function UIChuanGongResultWin_JingNeng:onShow(argtable,afterOnloaded)
local infoData=argtable
local infoA=infoData[1]
local infoB=infoData[2]
local widgetA=self.infoPanelA:getChildWidgetBase()
local name=UIDiscipleModel:getDiscipleName(infoA.dzId)
comHelper.setChildModelRawImage(widgetA,infoA.dzId,0,0,eHeadCenterType.eHead)
widgetA:SetChildText(1,name)

widgetA:SetChildLayoutGroupCreateItems(2,8)
local descExGrid=widgetA:GetChildLayoutGroupGridList(2)
for i=1,descExGrid.Count do
local grid=descExGrid[i-1]
local lv=infoA.levelList[i]
grid:SetChildText(1,FMT.fmt("<color=#7d3b17>{0} </color>{1}级",UIDiscipleModel:getDiscipleJobName(i),lv))
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,i,'icon')
grid:SetChildCSImageSprite(0,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))

grid:SetChildText(2,lv>0 and"0级"or"")
grid:SetChildActive(3,lv>0)
end




local widgetB=self.infoPanelB:getChildWidgetBase()
name=UIDiscipleModel:getDiscipleName(infoB.dzId)
comHelper.setChildModelRawImage(widgetB,infoB.dzId,0,0,eHeadCenterType.eHead)
widgetB:SetChildText(1,name)

widgetB:SetChildLayoutGroupCreateItems(2,8)
local descExGrid=widgetB:GetChildLayoutGroupGridList(2)
for i=1,descExGrid.Count do
local grid=descExGrid[i-1]
local level=infoB.levelList[i]
grid:SetChildText(1,FMT.fmt("<color=#7d3b17>{0} </color>{1}级",UIDiscipleModel:getDiscipleJobName(i),level))
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,i,'icon')
grid:SetChildCSImageSprite(0,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
local aLevel=infoA.levelList[i]
grid:SetChildText(2,aLevel>level and FMT.fmt("{0}级",aLevel)or"")
grid:SetChildActive(3,aLevel>level)
end










end


function UIChuanGongResultWin_JingNeng:onHide()

end

function UIChuanGongResultWin_JingNeng:getNameColor(lv1,lv2)
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




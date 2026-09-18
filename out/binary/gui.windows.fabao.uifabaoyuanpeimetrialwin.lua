







def_class("UIFabaoYuanPeiMetrialWin",UIWindowBase)









function UIFabaoYuanPeiMetrialWin:bindComponents()

self.canvasInfo=UIObject.get(self,0)
self.Contect=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.title=UIText.get(self,3)



end


function UIFabaoYuanPeiMetrialWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.canvasInfo);self.canvasInfo=nil;
_UIObject_release(self.Contect);self.Contect=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end


















function UIFabaoYuanPeiMetrialWin:onLoaded(...)
self:bindComponents()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-230,0.3)
end

function UIFabaoYuanPeiMetrialWin:__delete()
self:unbindComponents()
end

function UIFabaoYuanPeiMetrialWin:onShow(argtable,afterOnloaded)
local fbtype=argtable.type
local color=argtable.color

local title=FMT.fmt('使用以下材料炼制的{0}品质法宝',FMT.cfmt(color,eQualityColorName[color]))
self.title:setText(title)

local masStage=self:openMaxStage()
local cfg=cfg_fabaoyuanpeitypeconfig_get(fbtype)
local fabaomaterias=cfg.fabaomaterias
local list={}
for i=1,masStage do
list=table.concatTableX(list,fabaomaterias[i])
end
local len=#list
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local itemid=list[i]
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local stage=itemCfg.stage


widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemid),false)
widget:SetChildText(2,itemCfg.name)
widget:SetChildActive(3,stage~=nil)
widget:SetChildText(4,FMT.fmt('{0}阶',stage))
widget:SetChildText(4,FMT.fmt('{0}阶',stage))

widget:SetBaseItemClickEvent(-1,function()
local args={
skillID=itemCfg.shentong,
skillLv=1,
attend=eSkillTipsType.eDZSTSkill,
canvasIdx=10,
item=self.canvasInfo:getWidgetBase(),
move_pos='right',
notShowBuffDescRoot=true,
}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end)
end)
end

function UIFabaoYuanPeiMetrialWin:onHide()

end



function UIFabaoYuanPeiMetrialWin:openMaxStage()
local stage=1
local curStage=stage
while true do
local stageStr=(FMT.fmt('eFaBao{0}',stage))
local sysyid=SYSTEM_DEFINE[stageStr]
if sysyid then
if not systemModel.isOpen(sysyid)then break end
else
break
end
curStage=stage
stage=stage+1
end
return curStage
end

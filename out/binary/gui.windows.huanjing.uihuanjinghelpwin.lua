







def_class("UIHuanJingHelpWin",UIWindowBase)









function UIHuanJingHelpWin:bindComponents()

self.panel1=UIObject.get(self,0)
self.panel2=UIObject.get(self,1)



end


function UIHuanJingHelpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
end
















local _item_index={
icon=0,
title=1,
name=2,
desc=3,
tips=4,
scrollView=5,
}




function UIHuanJingHelpWin:onLoaded(...)
self:bindComponents()
end


function UIHuanJingHelpWin:__delete()
self:unbindComponents()
end




function UIHuanJingHelpWin:onShow(argtable,afterOnloaded)
local chapter=UIHuanJingControl:getChapter()
local cfg=cfgHelper.get1(cfg_chapternewconfig_get,chapter)
self:setPanel(self.panel1,cfg.help[1])
self:setPanel(self.panel2,cfg.help[2])
end


function UIHuanJingHelpWin:onHide()

end

function UIHuanJingHelpWin:setPanel(panel,data)
local widget=panel:getChildWidgetBase()
local cfg=cfgHelper.getSSlawRule(data.fzId)
widget:SetChildIcon(_item_index.icon,cfg.image,true)
widget:SetChildText(_item_index.name,cfg.name)
widget:SetChildText(_item_index.title,data.title)
widget:SetChildText(_item_index.desc,data.desc or cfg.desc)
widget:SetChildText(_item_index.tips,data.tips)

local icons=data.icons
local len=#icons
widget:SetChildScrollViewInit(_item_index.scrollView,0.5,true,nil,nil)
widget:SetChildScrollViewCreateGrids(_item_index.scrollView,len,math.min(len,3))
local grids=widget:GetChildScrollViewItemWidgets(_item_index.scrollView)
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local tdata=icons[i+1]
if tdata[1]==1 then
local jobicon=UIDiscipleModel:getJobIconName(tdata[2])
item:SetChildCSImageSprite(0,globalABLookup.global,jobicon)
item:SetChildText(1,'')
item:SetChildButtonClick(0,nil)
elseif tdata[1]==2 then
local skillCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,tdata[2])
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildText(1,skillCfg.name)
item:SetChildButtonClick(0,function()
UIManager:showWindow('UIGongFaTipsFourWin',{gfID=tdata[2]})
end)
elseif tdata[1]==3 then
local skillCfg=fabaoConfig.getShentongConfig(tdata[2])
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),true)
item:SetChildText(1,skillCfg.name)
item:SetChildButtonClick(0,function()
local args={skillID=tdata[2],skillLv=1,attend=eSkillTipsType.eDZSTSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end)
end
end
end




function UIHuanJingHelpWin:onCLoseClick()
self:closeSelf()
end
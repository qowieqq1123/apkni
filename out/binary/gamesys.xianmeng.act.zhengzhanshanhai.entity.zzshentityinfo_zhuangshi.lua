









local zzshEntityInfo_zhuangshi={}


function zzshEntityInfo_zhuangshi:refreshLocalPos()
self.g_x=self.data[1]
self.g_y=self.data[2]
self.l_x=self.g_x
self.l_y=self.g_y
end

function zzshEntityInfo_zhuangshi:getIconName()
local zsid=self.data[3]
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local cfg
if shSeasonId==-1 then
cfg=cfgHelper.get2(cfg_zhengzhanshanhaizsconfig_get,zsid)
else
local mapId=zhengzhanshanhaiController:getZZSHCfg("bgmapid")
cfg=cfgHelper.get(cfg_zhengzhanshanhaizsnewconfig_get,mapId,zsid)
end
local iconID=cfg.icon
local flipx=cfg.flipx
local abname=FMT.fmt('ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/{0}.ab',iconID)
local iconname=tostring(iconID)
return abname,iconname,flipx
end


function zzshEntityInfo_zhuangshi:onCreate(widget)
widget:SetChildLocalPos(-1,self.g_x,self.g_y,0)
local abname,iconname,flipx=self:getIconName()
widget:SetChildCSImageSprite(0,abname,iconname)
if flipx then
widget:SetChildScale(0,Vector3(-1,1,1))
else
widget:SetChildScale(0,Vector3(1,1,1))
end
end


function zzshEntityInfo_zhuangshi:onReleaseWidget(widget)
widget:SetChildIcon(0,'',false)
end


function zzshEntityInfo_zhuangshi:onDelete()

end

return zzshEntityInfo_zhuangshi
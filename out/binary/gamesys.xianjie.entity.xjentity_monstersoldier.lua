









local xjEntity_monsterSoldier={}


function xjEntity_monsterSoldier:onInit()
self:initData()
end

function xjEntity_monsterSoldier:initData()
local data=self.data
self.cfg=data.cfg
self.parent=data.parent
self.pos=data.pos
self.size=data.size
end


function xjEntity_monsterSoldier:onCreateWidget(widget)
local parent=self.parent
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,parent.entityType)

local body=self.cfg[1]
local scale=self.cfg[4]
local flip=self.cfg[5]==1
local before=self.cfg[6]==1
local sortOrder=entCfg.sortOrder-1
if before then sortOrder=entCfg.sortOrder+1 end
widget:SetChildSceneEntityCreateModel(0,body,{},'Entity',sortOrder,scale,nil,false)
widget:SetChildSceneEntityFlipX(0,flip)
end


function xjEntity_monsterSoldier:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntity_monsterSoldier:onDelete()

end

return xjEntity_monsterSoldier
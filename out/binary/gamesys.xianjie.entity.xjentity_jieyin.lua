









local xjEntity_JieYin={}


function xjEntity_JieYin:onInit()
local data=self.data

self.entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,XJ_ENTITY_TYPE.eJieYin)

self.pos=Vector3(data.pos[1],data.pos[2],data.pos[3])
self.size=Vector2.New(10,10)
self.lodLevel=self.entCfg.lodLevel
end


function xjEntity_JieYin:onSelectHandle(widget,isSelect)

end


function xjEntity_JieYin:onCreateWidget(widget)

end



function xjEntity_JieYin:onRemoveWidget(widget)

end


function xjEntity_JieYin:onMyClick(boxParams)

end

function xjEntity_JieYin:onDelete()

end

return xjEntity_JieYin
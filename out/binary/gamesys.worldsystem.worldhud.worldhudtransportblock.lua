









worldHUDTransportBlock=simple_class(worldHUDBase)
worldHUDTransportBlock.name="worldHUDTransportBlock"

function worldHUDTransportBlock:onCreate()
self.cfg=cfgHelper.get2(cfg_worldblocktransportconfig_get,self.data[2],self.data[3])

self.cmp:SetChildText(1,self.cfg.name)
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end

function worldHUDTransportBlock:onUpdate()
local isRepaired=chuanSongZhenModel:getFlagBit(self.data[2],self.data[3])
self.cmp:SetChildActive(0,not isRepaired)
end
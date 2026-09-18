









worldHUDYYHYNpc=simple_class(worldHUDBase)
worldHUDYYHYNpc.name="worldHUDYYHYNpc"

function worldHUDYYHYNpc:onCreate()
local data=YiYuHuiYouModel:getNPCIdlistbyGuid(self.data[2])
self.cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,data.npcid)

self.cmp:SetChildText(1,self.cfg.name)
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end










worldHUDPoetryArena=simple_class(worldHUDBase)
worldHUDPoetryArena.name="worldHUDPoetryArena"

function worldHUDPoetryArena:onCreate()
local data=poetryArenaModel:getArenaData(self.data[2])
self.cfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,data.id)

self.cmp:SetChildText(1,self.cfg.name)
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end
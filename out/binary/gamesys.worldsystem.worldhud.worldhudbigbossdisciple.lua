









worldHUDBigBossDisciple=simple_class(worldHUDBase)
worldHUDBigBossDisciple.name="worldHUDBigBossDisciple"

function worldHUDBigBossDisciple:onCreate()
self:newName()
self:doShow(true)
worldHUDBase.onCreate(self)
end

function worldHUDBigBossDisciple:newName()





local nameStr=worldLeaderModel:getAIName()

self.cmp:SetChildText(0,nameStr)
end

function worldHUDBigBossDisciple:doShow(show)
self.cmp:SetChildActive(1,show)
end
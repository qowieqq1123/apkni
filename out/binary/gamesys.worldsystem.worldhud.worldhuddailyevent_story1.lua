









worldHUDDailyEvent_Story1=simple_class(worldHUDBase)
worldHUDDailyEvent_Story1.name="worldHUDDailyEvent_Story1"

function worldHUDDailyEvent_Story1:onCreate()
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)

worldHUDBase.onCreate(self)
end

function worldHUDDailyEvent_Story1:onUpdate()

end
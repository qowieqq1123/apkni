









worldHUDResPoint_Event=simple_class(worldHUDBase)
worldHUDResPoint_Event.name="worldHUDResPoint_Event"

function worldHUDResPoint_Event:onCreate()
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
self.cmp:SetChildButtonClick(1,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Event:onUpdate()





end
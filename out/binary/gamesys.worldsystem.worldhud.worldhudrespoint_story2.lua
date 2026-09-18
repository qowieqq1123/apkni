









worldHUDResPoint_Story2=simple_class(worldHUDBase)
worldHUDResPoint_Story2.name="worldHUDResPoint_Story2"

function worldHUDResPoint_Story2:onCreate()
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)

worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Story2:onUpdate()

end
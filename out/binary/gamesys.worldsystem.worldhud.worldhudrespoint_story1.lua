









worldHUDResPoint_Story1=simple_class(worldHUDBase)
worldHUDResPoint_Story1.name="worldHUDResPoint_Story1"

function worldHUDResPoint_Story1:onCreate()
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)

worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Story1:onUpdate()

end
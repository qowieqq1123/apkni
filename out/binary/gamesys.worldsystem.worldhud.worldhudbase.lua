









worldHUDBase=simple_class()
worldHUDBase.name="worldHUDBase"

function worldHUDBase:__init(info)
self.key=info.key
self.cmp=info.cmp
self.data=info.data
self.script=info.script
end

function worldHUDBase:onCreate()
self:onUpdate()
end

function worldHUDBase:onUpdate()

end

function worldHUDBase:onVisible(visible)
self.cmp:SetChildActive(-1,visible)
end

function worldHUDBase:onDestory()

end

function worldHUDBase:onFlipX(flip)

end
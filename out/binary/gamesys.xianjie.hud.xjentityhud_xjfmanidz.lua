









local xjEntityHud_XJFMAniDz={}


function xjEntityHud_XJFMAniDz:onInit()
self.needFollow=true



self.showhud=self.data.showhud
self.hudName=self.data.hudName
end


function xjEntityHud_XJFMAniDz:onCreateWidget(widget)
if self.showhud then
widget:SetChildActive(1,true)
widget:SetChildText(2,self.hudName)
else
widget:SetChildActive(1,false)
end

end


function xjEntityHud_XJFMAniDz:onSelectHandle(widget,isSelect)

end


function xjEntityHud_XJFMAniDz:onRemoveWidget(widget)

end



function xjEntityHud_XJFMAniDz:onUpdate()

end

return xjEntityHud_XJFMAniDz

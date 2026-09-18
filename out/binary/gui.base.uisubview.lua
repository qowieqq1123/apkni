











UISubView=simple_class(UIBaseView)

local CS_CreateSubWindow=CS.UIManager.CreateSubWindow


function UISubView:__init(parent_view)
self.parent_view=parent_view
self.close_mode=UICloseMode.eDisable
end

function UISubView:GetParentView()
return self.parent_view
end

function UISubView:CreateWinlua(prefab)
return CS_CreateSubWindow(prefab,self.parent_view.winlua.transform)
end

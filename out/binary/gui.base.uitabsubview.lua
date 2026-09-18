











UITabSubView=simple_class(UISubView)

function UITabSubView:__init(parent_view)
self.tab_type=1
self.open_callback=nil
self.close_callback=nil
end

function UITabSubView:OpenCallback()
if self.open_callback then
self.open_callback()
end
end

function UITabSubView:CloseCallback()
if self.close_callback then
self.close_callback()
end
end

function UITabSubView:SetTabType(type_tab)
self.tab_type=type_tab
end

function UITabSubView:SetOpenCallback(callback)
self.open_callback=callback
end

function UITabSubView:SetCloseCallback(callback)
self.close_callback=callback
end

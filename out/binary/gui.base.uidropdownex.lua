





UIDropdownEx=UIDropdown




function UIDropdownEx:setDropdownLayoutedAction(action)
self.__owner.widget:SetChildDropDownLayoutedAction(self.__id,action)
end

function UIDropdownEx:setDropdownCreatedAction(action)
self.__owner.widget:SetChildDropDownCreatedAction(self.__id,action)
end

function UIDropdownEx:setDropdownClickAction(action)
self.__owner.widget:SetChildDropDownClickAction(self.__id,action)
end

function UIDropdownEx:setDropdownSubmitAction(action)
self.__owner.widget:SetChildDropDownSubmitAction(self.__id,action)
end

function UIDropdownEx:setDropdownCancelAction(action)
self.__owner.widget:SetChildDropDownCancelAction(self.__id,action)
end

function UIDropdownEx:getDropdownItemWidget(index)
return self.__owner.widget:GetChildDropDownItemWidget(self.__id,index)
end



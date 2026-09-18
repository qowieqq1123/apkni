




UILinkImageText=UIObject

function UILinkImageText:setText(text)
if self.__text==text then return end





self.__text=text
self.__owner.widget:SetChildText(self.__id,text)
end

function UILinkImageText:setLinkImageClickAction(action)
self.__owner.widget:SetChildLinkImageTextClickAction(self.__id,action)
end

function UILinkImageText:setLinkImageMultiLineAction(action)
self.__owner.widget:SetChildLinkImageTextMultiLineAction(self.__id,action)
end

function UILinkImageText:setLinkImageAlignment(num)
self.__owner.widget:SetChildTextAlignment(self.__id,num)
end

function UILinkImageText:setLinkImageTextBuildFinishAction(action)
self.__owner.widget:SetChildLinkImageTextBuildFinishAction(self.__id,action)
end

function UILinkImageText:setLinkImageTextReset()
self.__owner.widget:SetChildLinkImageTextResetData(self.__id)
end


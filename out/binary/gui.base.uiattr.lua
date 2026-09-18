UIAttr=UIObject


function UIAttr:setAttr(lab,val)
self.__owner:setChildAttr(self.__id,lab,val)
end



function UIAttr:setAttrCompareFloatValue(fBase,fTarget)
self.__owner:setChildAttrCompareFloatValue(self.__id,fBase,fTarget)
end



function UIAttr:setAttrFloatValue(value,animated)
self.__owner:setChildAttrFloatValue(self.__id,value,animated)
end




function UIAttr:setAttrInitLabelAndValue(labelName,fBase,fTarget)
self.__owner:setChildAttrInitLabelAndValue(self.__id,labelName,fBase,fTarget)
end





function UIAttr:setAttrInitLabelAndValueWithPercent(labelName,fBase,fTarget,percent)
self.__owner:setChildAttrInitLabelAndValueWithPercent(self.__id,labelName,fBase,fTarget,percent)
end



function UIAttr:setAttrInitLabelIcon(labelName,attrName)
self.__owner:setChildAttrInitLabelIcon(self.__id,labelName,attrName)
end



function UIAttr:setAttrInitValue(fBase,fTarget)
self.__owner:setChildAttrInitValue(self.__id,fBase,fTarget)
end





function UIAttr:setAttrInitValueAndIcon(labelName,attrName,fBase,fTarget)
self.__owner:setChildAttrInitValueAndIcon(self.__id,labelName,attrName,fBase,fTarget)
end




function UIAttr:setAttrLabelAndFloatValue(labelName,value,animated)
self.__owner:setChildAttrLabelAndFloatValue(self.__id,labelName,value,animated)
end


function UIAttr:setAttrValue(value)
self.__owner:setChildAttrValue(self.__id,value)
end

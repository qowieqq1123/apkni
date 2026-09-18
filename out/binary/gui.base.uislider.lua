UISlider=UIObject



function UISlider:setSlider(value,min,max,callback)
self.__owner:setChildSlider(self.__id,value,min,max,callback)
end

function UISlider:setChildSliderRefresh(value)
self.__owner:setChildSliderRefresh(self.__id,value)
end

function UISlider:setChildSliderInit(value,min,max,callback)
self.__owner:setChildSliderInit(self.__id,value,min,max,callback)
end

function UISlider:setChildSliderValue(value)
self.__owner:setChildSliderValue(self.__id,value)
end
UIProgressBarAni=UIObject

function UIProgressBarAni:animate(target)
self.__owner.widget:SetProgressBarAni(self.__id,target)
end

function UIProgressBarAni:animateTwoParams(target,maxVal)
self.__owner.widget:SetProgressBarAniWithTwoParams(self.__id,target,maxVal)
end

function UIProgressBarAni:animateThreeParams(target,maxVal,duration)
self.__owner.widget:SetProgressBarAniWithThreeParams(self.__id,target,maxVal,duration)
end

function UIProgressBarAni:animateFourParams(target,maxVal,duration,reverse)
self.__owner.widget:SetProgressBarAniWithFourParams(self.__id,target,maxVal,duration,reverse)
end

function UIProgressBarAni:animateFiveParams(current,target,maxVal,duration,reverse)
self.__owner.widget:SetProgressBarAniWithFiveParams(self.__id,current,target,maxVal,duration,reverse or false)
end

function UIProgressBarAni:setUpdateAction(action)
self.__owner.widget:SetProgressBarAniUpdateAction(self.__id,action)
end

function UIProgressBarAni:setFinishAction(action)
self.__owner.widget:SetProgressBarAniFinishAction(self.__id,action)
end


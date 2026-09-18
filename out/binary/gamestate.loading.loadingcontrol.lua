loadingControl={}

function loadingControl.playEndProgress(delay)
delay=delay or 0
UIManager:callWindowFunc('UILoading','endProgressAni',delay)
end


function loadingControl:openSceneCloud()

if UIManager:isActive('UILoading',true)then
loadControl.setCloseTag(true)
end

if not loadControl.isLoadFinsh()then
return
end

if UIManager:isActive('UILoading',true)then

loadControl.setCloseTag(true)
loadControl.tryCloseLoading()
return
end


if UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")then

return
end



end



function loadingControl.openCloud(func,closeDelay,autoClose)
if closeDelay then
autoClose=false
if closeDelay<0 then closeDelay=1 end
end
UIManager:showWindow("UICommonLoadingCloud",{
startCallback=func,
closeDelay=closeDelay,
autoClose=autoClose,
})
end

function loadingControl.closeCloud()
UIManager:callWindowFunc('UICommonLoadingCloud','endAni')
end

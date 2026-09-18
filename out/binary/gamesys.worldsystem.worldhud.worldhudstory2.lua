









worldHUDStory2=simple_class(worldHUDBase)
worldHUDStory2.name="worldHUDStory2"

local childCmp={
speakBg=0,
speakWord=1,
}

function worldHUDStory2:onCreate()
self.cmp:SetChildActive(childCmp.speakBg,false)
self.cmp:SetChildText(childCmp.speakWord,"")
end

function worldHUDStory2:onUpdate()

end

function worldHUDStory2:onDestory()
self:hideEmot()
end

function worldHUDStory2:showEmot(emot,cd,callback)

self.cmp:SetChildText(childCmp.speakWord,chatEmotHelper.decodeEmot(emot))
self.cmp:SetChildActive(childCmp.speakBg,true)
self.cmp:ForceLayoutRect(childCmp.speakBg)
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
if cd then
self.emotTimer=timer.new()
self.emotTimer:start(cd,function()
self:hideEmot()
if callback then
callback()
end
end,1)
end
end

function worldHUDStory2:hideEmot()
self.cmp:SetChildActive(childCmp.speakBg,false)
self.cmp:SetChildText(childCmp.speakWord,"")
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end
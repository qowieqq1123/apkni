









worldHUDStory=simple_class(worldHUDBase)
worldHUDStory.name="worldHUDStory"

local childCmp={
speakBg=0,
speakWord=1,
}

function worldHUDStory:onCreate()
self.cmp:SetChildActive(childCmp.speakBg,false)
self.cmp:SetChildText(childCmp.speakWord,"")
end

function worldHUDStory:onUpdate()

end

function worldHUDStory:onDestory()
self:hideEmot()
end

function worldHUDStory:showEmot(emot,cd,callback)

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

function worldHUDStory:hideEmot()
self.cmp:SetChildActive(childCmp.speakBg,false)
self.cmp:SetChildText(childCmp.speakWord,"")
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end










worldHUDTour=simple_class(worldHUDBase)
worldHUDTour.name="worldHUDTour"

local childCmp={
emotBg=0,
emotTx=1,
tagImg=2,
}

function worldHUDTour:onCreate()
self:showTag(true)
self.cmp:SetChildActive(childCmp.emotBg,false)
self.cmp:SetChildText(childCmp.emotTx,"")
end

function worldHUDTour:onUpdate()

end

function worldHUDTour:onDestory()
self:hideEmot()
end

function worldHUDTour:showEmot(emot,cd,callback)

self.cmp:SetChildActive(childCmp.emotBg,true)
self.cmp:SetChildText(childCmp.emotTx,chatEmotHelper.decodeEmot(emot))
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

function worldHUDTour:hideEmot()
self.cmp:SetChildActive(childCmp.emotBg,false)
self.cmp:SetChildText(childCmp.emotTx,"")
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end

function worldHUDTour:showTag(show)
self.cmp:SetChildActive(childCmp.tagImg,show)
end

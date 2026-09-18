







def_class("UIGoodReviewsWin",UIWindowBase)









function UIGoodReviewsWin:bindComponents()

self.bg=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.assessBtnA=UIButton.get(self,3)
self.assessBtnB=UIButton.get(self,4)
self.assessBtnC=UIButton.get(self,5)

self.assessBtnA:setButtonClick(function()self:onAssessBtnA()end)

self.assessBtnB:setButtonClick(function()self:onAssessBtnB()end)

self.assessBtnC:setButtonClick(function()self:onAssessBtnC()end)



end


function UIGoodReviewsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.assessBtnA);self.assessBtnA=nil;
_UIObject_release(self.assessBtnB);self.assessBtnB=nil;
_UIObject_release(self.assessBtnC);self.assessBtnC=nil;
end



















function UIGoodReviewsWin:onLoaded(...)
self:bindComponents()
end


function UIGoodReviewsWin:__delete()
self:unbindComponents()
end




function UIGoodReviewsWin:onShow(argtable,afterOnloaded)
local cfg=cfgHelper.get1(cfg_pinglunyindaoconfig_get,argtable.cfgId)
self.cfg=cfg
self.desc:setText(cfg.desc)
self.data=argtable.data
self.rtype=argtable.rtype
end


function UIGoodReviewsWin:onHide()

end



function UIGoodReviewsWin:onAssessBtnA()
UIGoodReviewsControl:setNextReviewsTime(self.cfg.cd1)
UIGoodReviewsControl:addReviewsCount()
UIGoodReviewsControl:recordAndSaveData(self.data)
UIGoodReviewsControl:jumpToReview()
UIGoodReviewsControl:uploadReview(self.rtype,0,1)
self:closeSelf()
end

function UIGoodReviewsWin:onAssessBtnB()
UIGoodReviewsControl:setNextReviewsTime(self.cfg.cd2)
UIGoodReviewsControl:recordAndSaveData(self.data)
UIGoodReviewsControl:uploadReview(self.rtype,0,0)
UIManager.info('评价已提交，望祖师继续督促改进')
self:closeSelf()
end

function UIGoodReviewsWin:onAssessBtnC()
UIGoodReviewsControl:setNextReviewsTime(self.cfg.cd2)
UIGoodReviewsControl:recordAndSaveData(self.data)

UIGoodReviewsControl:uploadReview(self.rtype,0,0)
UIManager.info('评价已提交，望祖师继续督促改进')
self:closeSelf()
end

function UIGoodReviewsWin:onCloseClick()
UIGoodReviewsControl:recordAndSaveData(self.data)
UIGoodReviewsControl:uploadReview(self.rtype,1,0)
self:closeSelf()
end
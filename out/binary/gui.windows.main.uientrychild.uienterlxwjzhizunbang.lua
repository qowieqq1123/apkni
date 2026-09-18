







def_class("UIEnterLXWJZhiZunBang",UICloneObject)





UIEnterLXWJZhiZunBang.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterLXWJZhiZunBang.assetName="UIEnterNomalItem"


function UIEnterLXWJZhiZunBang:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterLXWJZhiZunBang:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end







function UIEnterLXWJZhiZunBang:onLoaded(...)
self:bindComponents()
self.onLimitActReddotChange_=function(...)
self:onLimitActReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
end


function UIEnterLXWJZhiZunBang:__delete()
self:stopSelfTimer()
self:unbindComponents()
self.act_id=nil

notifySystem:removelistener(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
self.onLimitActReddotChange_=nil
end

function UIEnterLXWJZhiZunBang:onLimitActReddotChange(act_id)
if self.act_id~=act_id then return end

self:refreshReddot()
end


function UIEnterLXWJZhiZunBang:onHide()

end




function UIEnterLXWJZhiZunBang:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local params=info.params
self.act_id=LIMIT_ACT_TYPE.eLingXuWenJian

self.model:setChildUIModelRemoveTarget()
self.icon:setActive(true)
local abname=globalABLookup.mainEntrySprite
local iconname='button_hdrk_0027'
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.reddot:setActive(false)
self.widget:SetChildText(2,'')

self:startTimer()
self:refreshReddot()

self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow('UIXM_LXWJ_zhizunbang_win')
end,true)
self.widget:SetChildButtonClick(0,function()
UIManager:showWindow('UIXM_LXWJ_zhizunbang_win')
end,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIEnterLXWJZhiZunBang:refreshReddot()
local flag=lingxuwenjianModel:checkLikeRedot()
self.reddot:setActive(flag)
end

function UIEnterLXWJZhiZunBang:startTimer()
self.widget:SetChildActive(4,true)

self.stamp=os.time()+limitActivitiesModel:getActStartLeftTime(LIMIT_ACT_TYPE.eLingXuWenJian)

self:stopSelfTimer()

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterLXWJZhiZunBang:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterLXWJZhiZunBang:onIcon()

end

function UIEnterLXWJZhiZunBang:onClickBg()

end
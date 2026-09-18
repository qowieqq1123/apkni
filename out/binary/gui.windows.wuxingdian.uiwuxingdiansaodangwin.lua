







def_class("UIWuXingDianSaoDangWin",UIWindowBase)









function UIWuXingDianSaoDangWin:bindComponents()

self.creator=UIObject.get(self,0)
self.goBtn=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.wxd_1=UIObject.get(self,3)
self.wxd_2=UIObject.get(self,4)
self.wxd_3=UIObject.get(self,5)
self.wxd_4=UIObject.get(self,6)
self.wxd_5=UIObject.get(self,7)
self.reddot=UIObject.get(self,8)
self.goTxt=UIText.get(self,9)

self.goBtn:setButtonClick(function()self:onGoBtn()end)
self.wxd={
self.wxd_1,
self.wxd_2,
self.wxd_3,
self.wxd_4,
self.wxd_5,
}



end


function UIWuXingDianSaoDangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creator);self.creator=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.wxd_1);self.wxd_1=nil;
_UIObject_release(self.wxd_2);self.wxd_2=nil;
_UIObject_release(self.wxd_3);self.wxd_3=nil;
_UIObject_release(self.wxd_4);self.wxd_4=nil;
_UIObject_release(self.wxd_5);self.wxd_5=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.goTxt);self.goTxt=nil;
self.wxd=nil;
end

















local _modelList={4874,4875,4876,4877,4878}
local _effectList={10388,10389,10390,10391,10392}
local _grayABformat='ui/windows/wuxingdian/sharedtextures/wxd_men_{0}.ab'
local _grayAssetformat='wxd_men_{0}'

function UIWuXingDianSaoDangWin:onLoaded(...)
self:bindComponents()
self.reddot:setActive(false)
end

function UIWuXingDianSaoDangWin:__delete()
self:unbindComponents()
end

function UIWuXingDianSaoDangWin:onShow(argtable,afterOnloaded)
for i,v in ipairs(self.wxd)do
local widget=v:getWidgetBase()
local wxdId=i
local layer=wuXingDianModel:getFinishLayer(wxdId)
local name=FMT.fmt('{0}殿',wuXingDianTypeName[wxdId])
local ret,args=wuXingDianModel:isWXDOpen(wxdId)
local desc=ret and FMT.fmt('{0}层',layer)or'未开启'
widget:SetChildText(0,FMT.fmt('{0}：<color=#ca631dff>{1}</color>',name,desc))
if ret then
widget:SetChildUIModelShowTarget(1,_modelList[i],1,{},0)

else
widget:SetChildUIModelShowTarget(1,_modelList[i],1,{},12)

end
end
local rewards=wuXingDianModel:getSaoDangRewards()or{}
local sortTag={}
for i,v in ipairs(rewards)do
v.showStage=true
if v.range then
v.range[1]=mathHelper.formatNumber4(v.range[1],1)
v.range[2]=mathHelper.formatNumber4(v.range[2],1)
end
local color=itemsConfig.getConfig(v[1]).color or 0
sortTag[v[1]]=color*1000000+v[1]
end

table.sort(rewards,function(a,b)
return sortTag[a[1]]>sortTag[b[1]]
end)
local len=#rewards
self.title:setActive(len==0)
if len>0 then
self.winlua:SetChildLayoutGroupCreateItems(self.creator:getID(),len,function(index)
local reward=rewards[index]
if reward[2]<0 then reward[2]=-1 end
local widget1=self.winlua:GetChildLayoutGroupGridItem(self.creator:getID(),index-1)
widgetHelper.setNormalRewardItem(widget1,-1,reward)
end)
end
self:freshReddot()
end

function UIWuXingDianSaoDangWin:freshReddot()
local ret=wuXingDianModel:isCanSaoDang()

self.goBtn:setImageExGray(not ret)
self.goTxt:setText(ret and'扫荡'or'已扫荡')
end

function UIWuXingDianSaoDangWin:onHide()

end





function UIWuXingDianSaoDangWin:onGoBtn()
local ret,args=wuXingDianModel:isCanSaoDang()
if not ret then
if args==0 then
UIManager.error('暂时无法扫荡')
else
UIManager.error('今日已扫荡完毕')
end
return
end
socketManager:send_25_19(0)
end

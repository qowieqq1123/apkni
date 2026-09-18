







def_class("UIDouFaTaiCredentialsListWin",UIWindowBase)









function UIDouFaTaiCredentialsListWin:bindComponents()

self.scrollerView=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.mask=UIButton.get(self,2)
self.tipsText=UIText.get(self,3)
self.nullTips=UIText.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIDouFaTaiCredentialsListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.nullTips);self.nullTips=nil;
end















local item_index=
{
rankImg=0,
rank=1,
name=2,
iconHead=3,
}

local abName='ui/windows/doufatai/doufatai_atlas_pak.ab'




function UIDouFaTaiCredentialsListWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
lundaodahuiController.req_17_35()
end


function UIDouFaTaiCredentialsListWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiCredentialsListWin:onShow(argtable,afterOnloaded)
self:refreshCredentialsList()
end


function UIDouFaTaiCredentialsListWin:onHide()

end

function UIDouFaTaiCredentialsListWin:refreshCredentialsList()
self.credentialsList=lundaodahuiModel:getCredentialsList()
if not self.credentialsList or not next(self.credentialsList)then

self.tipsText:setActive(false)
self.nullTips:setActive(true)
return
end
self.tipsText:setActive(true)
self.nullTips:setActive(false)
self.scrollerView:setChildScrollViewCreateGrids(#self.credentialsList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.credentialsList[i]

local name=playerModel:getOtherActorName(data.name)
item:SetChildText(item_index.name,name)

item:SetChildActive(item_index.iconHead,data.name~='')
item:SetChildActive(4,data.name=='')
local widget=item:GetChildWidgetBase(item_index.iconHead)
playerController:setHeadIcon(widget,0,{scale=0.6,iconInfo=data.iconInfo})
widget:SetChildButtonClick(2,function(...)
if data.name~=''then
self:onClickPlayer(i)
end
end)

local rank=data.dftRank
item:SetChildText(item_index.rank,rank)
local showRankBg=i<=3
if i<=3 then
local imgName=FMT.fmt('icon_phbmingci_{0}',i)
item:SetChildCSImageSprite(item_index.rankImg,abName,imgName)
end
end
end

function UIDouFaTaiCredentialsListWin:onClickPlayer(index)
local credentialsList=self.credentialsList
local rank=index
local data=credentialsList[rank]


douFaTaiController:req_actor_detail_new(data.actorId,DOUFATAI_ROBOTTYPE.player,DOUFATAI_LOOK_TYPE.eRank,true)
end




function UIDouFaTaiCredentialsListWin:onCloseBtn()
self:closeSelf()
end

function UIDouFaTaiCredentialsListWin:onMask()
self:onCloseBtn()
end










def_class("UIDouFaTaiCredentialsListWin2",UIWindowBase)









function UIDouFaTaiCredentialsListWin2:bindComponents()

self.mask=UIButton.get(self,0)
self.scrollerView=UIObject.get(self,1)
self.tipsText=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.nullTips=UIText.get(self,4)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDouFaTaiCredentialsListWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.nullTips);self.nullTips=nil;
end















local item_index=
{
rankImg=0,
rank=1,
name=2,
iconHead=3,
empty=4,
me=5,
}

local abName='ui/windows/doufatai/doufatai_atlas_pak.ab'




function UIDouFaTaiCredentialsListWin2:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
lundaodahuiController.req_17_35()
end


function UIDouFaTaiCredentialsListWin2:__delete()
self:unbindComponents()
end




function UIDouFaTaiCredentialsListWin2:onShow(argtable,afterOnloaded)
self:refreshCredentialsList()
end


function UIDouFaTaiCredentialsListWin2:onHide()

end

function UIDouFaTaiCredentialsListWin2:refreshCredentialsList()
self.credentialsList=douFaTaiModel:get_rank_data()or{}
local openDay=lundaodahuiModel:checkLocalOpenDay()
if not self.credentialsList or not next(self.credentialsList)or not openDay then

self.tipsText:setActive(false)


if not openDay then
self.nullTips:setText("由于开服天数不足\n本服祖师暂不可参赛下届论道大会")
end

self.nullTips:setActive(true)
return
end
self.tipsText:setActive(true)
self.nullTips:setActive(false)
local len=8



self.scrollerView:setChildScrollViewCreateGrids(len+1,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.credentialsList[i]
if data and i<=8 then

local name=playerModel:getOtherActorName(data.name)
item:SetChildText(item_index.name,name)

item:SetChildActive(item_index.iconHead,true)
local widget=item:GetChildWidgetBase(item_index.iconHead)
playerController:setHeadIcon(widget,0,{scale=0.6,iconInfo=data.iconInfo})
widget:SetChildButtonClick(2,function(...)
self:onClickPlayer(i)
end)
item:SetChildActive(item_index.empty,data.name=='')
local rank=i
item:SetChildText(item_index.rank,rank)
item:SetChildActive(item_index.me,playerModel:getActorID()==data.actor_id)
else
item:SetChildActive(item_index.iconHead,false)


item:SetChildActive(item_index.empty,true)

if i==len+1 then
item:SetChildText(item_index.name,FMT.cfmt(FONT_COLOR.eGrayColor,"<size=22>赛季结束后,根据区服\n数动态增加参赛名额</size>"))
item:SetChildText(item_index.rank,"?")
else
item:SetChildText(item_index.name,FMT.cfmt(FONT_COLOR.eGrayColor,"虚位以待"))
item:SetChildText(item_index.rank,i)
end
end



if i<=3 and i<=len then
local imgName=FMT.fmt('icon_phbmingci_{0}',i)
item:SetChildCSImageSprite(item_index.rankImg,abName,imgName)
end

end
end

function UIDouFaTaiCredentialsListWin2:onClickPlayer(index)
local credentialsList=self.credentialsList
local rank=index
local data=credentialsList[rank]


douFaTaiController:req_actor_detail_new(data.actor_id,DOUFATAI_ROBOTTYPE.player,DOUFATAI_LOOK_TYPE.eRank,true)
end




function UIDouFaTaiCredentialsListWin2:onCloseBtn()
self:closeSelf()
end

function UIDouFaTaiCredentialsListWin2:onMask()
self:onCloseBtn()
end


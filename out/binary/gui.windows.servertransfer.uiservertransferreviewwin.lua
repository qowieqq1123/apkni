







def_class("UIServerTransferReviewWin",UIWindowBase)









function UIServerTransferReviewWin:bindComponents()

self.actorListPanel=UIObject.get(self,0)
self.back=UIObject.get(self,1)
self.changeDesc=UIButton.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.notOpenTips=UIObject.get(self,4)
self.reviewLogBtn=UIButton.get(self,5)
self.root=UIObject.get(self,6)
self.tipsText=UIText.get(self,7)
self.xianYuGrade=UIText.get(self,8)
self.xmDescText=UIText.get(self,9)
self.xyGradeFlag=UIImage.get(self,10)
self.zmNum_1=UIText.get(self,11)
self.zmNum_2=UIText.get(self,12)
self.zmNum_3=UIText.get(self,13)
self.zmNum_4=UIText.get(self,14)
self.zmNum_5=UIText.get(self,15)

self.changeDesc:setButtonClick(function()self:onChangeDesc()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.reviewLogBtn:setButtonClick(function()self:onReviewLogBtn()end)
self.zmNum={
self.zmNum_1,
self.zmNum_2,
self.zmNum_3,
self.zmNum_4,
self.zmNum_5,
}



end


function UIServerTransferReviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.changeDesc);self.changeDesc=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.notOpenTips);self.notOpenTips=nil;
_UIObject_release(self.reviewLogBtn);self.reviewLogBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.xianYuGrade);self.xianYuGrade=nil;
_UIObject_release(self.xmDescText);self.xmDescText=nil;
_UIObject_release(self.xyGradeFlag);self.xyGradeFlag=nil;
_UIObject_release(self.zmNum_1);self.zmNum_1=nil;
_UIObject_release(self.zmNum_2);self.zmNum_2=nil;
_UIObject_release(self.zmNum_3);self.zmNum_3=nil;
_UIObject_release(self.zmNum_4);self.zmNum_4=nil;
_UIObject_release(self.zmNum_5);self.zmNum_5=nil;
self.zmNum=nil;
end


















local _abName="ui/windows/servertransfer/servertransferspriteatlas_pak.ab"

function UIServerTransferReviewWin:onLoaded(...)
self:bindComponents()
end


function UIServerTransferReviewWin:__delete()
self:unbindComponents()
end




function UIServerTransferReviewWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.6)
end)
self.back:setChildSpineAnimation(eAnimationID.common_window_enter,1)
end
self.transferDatas=ServerTransferModel:getTransferDatas()

local xianyu_pj_level=ServerTransferModel:getXianYuGrade()
self.xyGradeFlag:setSprite(_abName,string.format("image_pojieyueqian_wz%d",xianyu_pj_level))
self:refreshNotice()
local isOpenAct=ServerTransferController:checkServerTransferTimeOpen()
self.notOpenTips:setActive(not isOpenAct)
self.tipsText:setText("异界迁移活动尚未开放")
self.actorListPanel:setActive(isOpenAct)
if isOpenAct then
self:refreshMemberList()
end
self:refreshGradeZongMenList()
end


function UIServerTransferReviewWin:refreshNotice()
local cross_id=loginModel:getCrossServerId()
local notice=ServerTransferModel:getXianYuDetailsNotice(cross_id)
if not notice or notice==""then
notice=cfgHelper.get2(cfg_switchserverlevelbasicconfig_get,1,"def_notice")
end
self.xmDescText:setText(notice)
end


function UIServerTransferReviewWin:refreshGradeZongMenList()
local can_enter_zm=ServerTransferModel:getXianYuTransferZongMenNum()
local canSwitchList=self.transferDatas.canSwitchList or defaultT
for grade,v in ipairs(self.zmNum)do
local max_num=can_enter_zm[grade]or 0
local cur_num=canSwitchList[grade]or 0
local str=ServerTransferModel:getZongMenGradeName(grade)
local color=(cur_num<=0 and max_num>0)and"#C82C2C"or"#549327"
v:setText(string.format("%s宗门			<color=%s>%d/%d</color>",str,color,cur_num,max_num))
end
end

function UIServerTransferReviewWin:refreshMemberList()
local list=self.transferDatas.applyList or defaultT
local temp={}
for i,v in ipairs(list)do
if v.state==-1 then
table.insert(temp,v)
end
end
self.memberList=temp
local c=#self.memberList
self.actorListPanel:setActive(c>0)
self.notOpenTips:setActive(c<=0)
if c<=0 then
self.tipsText:setText("暂无异界来客")
else
self.actorListPanel:setChildScrollViewCreateGrids(c,1)
local grids=self.actorListPanel:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshItem(grids[i-1],i)
end
end
end

function UIServerTransferReviewWin:refreshItem(item,index)
if item==nil then
item=self.actorListPanel:getChildScrollViewItemWidget(index-1)
end

if item then
local actorData=self.memberList[index]
playerController:setHeadIcon(item,2,{iconInfo=actorData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

item:SetChildText(3,tostring(actorData.level))

item:SetChildText(4,actorData.actor_name)

local fightnum=tonumber(tostring(actorData.fight_val))
local fight_str=FMT.fmt('实力：{0}',mathHelper.formatNumber3(fightnum))
item:SetChildText(5,fight_str)

local zm_pj_level=actorData.zm_pj_level
local color=ServerTransferModel:getZongMenGradeColor(zm_pj_level)
item:SetChildText(6,string.format("<color=%s>%s宗门</color>",color,ServerTransferModel:getZongMenGradeName(zm_pj_level)))

item:SetChildButtonClick(7,function()
ServerTransferController:send_254_98(actorData.actor_id,0)
end)

item:SetChildButtonClick(8,function()
ServerTransferController:send_254_98(actorData.actor_id,1)
end)

item:SetChildCSImageSprite(9,globalABLookup.globa4,ServerTransferModel:getZongMenGradeIcon(zm_pj_level))

item:SetChildButtonClick(0,function()

end)
end
end

function UIServerTransferReviewWin:onItemClick(index)
local actorData=self.memberList[index]
local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,actorData.actor_id)then
otherPlayerController:openOtherPlayerInfoWin(actorData.actor_id,nil,nil,{serverid=actorData.cross_id})
end
end


function UIServerTransferReviewWin:onChangeDesc()
local cross_id=loginModel:getCrossServerId()
self:showWindow("UIServerTransferXianYuNoticeWin",cross_id)
end

function UIServerTransferReviewWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='serverTransferReview_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIServerTransferReviewWin:onReviewLogBtn()
self:showWindow("UIServerTransferLogWin")
end

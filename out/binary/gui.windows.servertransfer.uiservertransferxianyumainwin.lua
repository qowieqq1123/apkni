







def_class("UIServerTransferXianYuMainWin",UIWindowBase)









function UIServerTransferXianYuMainWin:bindComponents()

self.applyBubble=UIButton.get(self,0)
self.applyTx=UIText.get(self,1)
self.bgSpine=UIObject.get(self,2)
self.cancelButton=UIButton.get(self,3)
self.filterBtn=UIButton.get(self,4)
self.filterBtnClose=UIObject.get(self,5)
self.filterBtnOpen=UIObject.get(self,6)
self.filterToggleBg=UIObject.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.leftBtn=UIButton.get(self,9)
self.myRealmItem=UIObject.get(self,10)
self.planetSpine=UIObject.get(self,11)
self.playerFight=UIText.get(self,12)
self.playerHead=UIObject.get(self,13)
self.playerName=UIText.get(self,14)
self.realmWidgetList=UIObject.get(self,15)
self.reviewBtn=UIButton.get(self,16)
self.reviewBtnReddot=UIObject.get(self,17)
self.rightBtn=UIButton.get(self,18)
self.root=UIObject.get(self,19)
self.searchBtn=UIButton.get(self,20)
self.searchCancelBtn=UIButton.get(self,21)
self.searchInput=UIInputField.get(self,22)
self.shopBtn=UIButton.get(self,23)
self.shopBtnReddot=UIObject.get(self,24)
self.stateDetailBtn=UIButton.get(self,25)
self.transferState=UIText.get(self,26)
self.uiRoot=UIObject.get(self,27)
self.xianYuBtn=UIButton.get(self,28)
self.xianYuBtnClose=UIObject.get(self,29)
self.xianYuBtnOpen=UIObject.get(self,30)
self.zmGrade=UIText.get(self,31)

self.applyBubble:setButtonClick(function()self:onApplyBubble()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.reviewBtn:setButtonClick(function()self:onReviewBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.stateDetailBtn:setButtonClick(function()self:onStateDetailBtn()end)

self.xianYuBtn:setButtonClick(function()self:onXianYuBtn()end)



end


function UIServerTransferXianYuMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBubble);self.applyBubble=nil;
_UIObject_release(self.applyTx);self.applyTx=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.filterBtnClose);self.filterBtnClose=nil;
_UIObject_release(self.filterBtnOpen);self.filterBtnOpen=nil;
_UIObject_release(self.filterToggleBg);self.filterToggleBg=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.myRealmItem);self.myRealmItem=nil;
_UIObject_release(self.planetSpine);self.planetSpine=nil;
_UIObject_release(self.playerFight);self.playerFight=nil;
_UIObject_release(self.playerHead);self.playerHead=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.realmWidgetList);self.realmWidgetList=nil;
_UIObject_release(self.reviewBtn);self.reviewBtn=nil;
_UIObject_release(self.reviewBtnReddot);self.reviewBtnReddot=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.shopBtnReddot);self.shopBtnReddot=nil;
_UIObject_release(self.stateDetailBtn);self.stateDetailBtn=nil;
_UIObject_release(self.transferState);self.transferState=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.xianYuBtn);self.xianYuBtn=nil;
_UIObject_release(self.xianYuBtnClose);self.xianYuBtnClose=nil;
_UIObject_release(self.xianYuBtnOpen);self.xianYuBtnOpen=nil;
_UIObject_release(self.zmGrade);self.zmGrade=nil;
end


















local nameColorByGrade={
'#F36666',
'#F1CE78',
'#D09DFF',
'#5AC0E2',
'#A9E152',
}
local _abName='ui/windows/servertransfer/servertransferspriteatlas_pak.ab'
local _this=nil

function UIServerTransferXianYuMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.isFilterTransferable=false
self.isOpenXianYuTianLan=false
self.nameSearchList={}
self.talkTween={}
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
self.requestCrossNameCallBack=function()
if self and not self.isClose then
self:CrossNameCallBack()
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
end


function UIServerTransferXianYuMainWin:__delete()
loginRequestUpdate:unregisterRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
self:unbindComponents()
_this=nil
end
function UIServerTransferXianYuMainWin:CrossNameCallBack()
self:refreshRealmItem()
end



function UIServerTransferXianYuMainWin:onShow(argtable,afterOnloaded)
self.realmWidgets=self.realmWidgetList:getChildCommonLayoutGroupWidgetList()
self.realmWidgetCount=self.realmWidgets.Count
self.anim=false
self:refreshSelfInfo()
self:refreshRealmInfo()
self:refreshApplyBtn()

local actOpen=ServerTransferController:checkServerTransferTimeOpen()

local showReview=ServerTransferModel:checkXianYuReviewPermission()
self.reviewBtn:setActive(showReview)

self.shopBtn:setActive(actOpen)

self.filterToggleBg:setActive(actOpen)

self:refreshFilterBtn()

self:refreshXianYuBtn()

self:refreshShopBtnReddot()

self:refreshReviewBtnReddot()

if argtable and argtable.openShop then
self:onShopBtn()
end
end

function UIServerTransferXianYuMainWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UIServerTransferXianYuMainWin:refreshSelfInfo()
local fight=mathHelper.int64_to_number(ServerTransferModel:getHistoryFight())
local hasLimit=ServerTransferController:checkServerTransferLimit()
playerController:setHeadIcon(self.winlua,self.playerHead:getID(),{iconInfo=nil,scale=HEAD_SCALE_TYPE.e60x60})
self.playerName:setText(playerModel:getActorName())
self.playerFight:setText(string.format("历史巅峰战力：<color=#CA631D>%s</color>",mathHelper.formatNumber3(fight)))
self.zmGrade:setText(string.format("当前宗门评级：<color=%s>%s宗门</color>",ServerTransferModel:getZongMenGradeColor(),ServerTransferModel:getZongMenGradeName()))
self.transferState:setText(string.format("状态：%s",hasLimit and"<color=#C82C2C>跃迁受限</color>"or"正常"))
end


function UIServerTransferXianYuMainWin:refreshRealmInfo()
local showRealms={}

if self.isFilterTransferable then
if not self.transferableRealms then
local realms=ServerTransferModel:getXianYuLeaderList()
self.transferableRealms={}
local zm_grade=ServerTransferModel:getZongMenGrade()
local self_cross_id=loginModel:getCrossServerId()
for _,realm in ipairs(realms)do
local cross_id=realm.cross_id
local xianyu_pj_level=realm.xianyu_level
local can_enter_zm=ServerTransferModel:getXianYuTransferZongMenNum(xianyu_pj_level)
if can_enter_zm[zm_grade]and can_enter_zm[zm_grade]>0 and cross_id~=self_cross_id then
table.insert(self.transferableRealms,realm)
end
end
end
showRealms=self.transferableRealms
else
showRealms=ServerTransferModel:getXianYuLeaderList()
end
self.notSearchRealms=showRealms

local searchRealms=self:refreshSearchRealmInfo(showRealms)
if searchRealms then
self.showRealms=searchRealms
else
self.showRealms=showRealms
end
self:refreshSelfRealm()
self:refreshRealmItem()
end


function UIServerTransferXianYuMainWin:refreshSelfRealm()
self.myRealm=nil
local cross_id=loginModel:getCrossServerId()
local temp={}
for i,v in ipairs(self.showRealms)do
if cross_id==v.cross_id then
self.myRealm=v
else
table.insert(temp,v)
end
end
self.showRealms=temp
self.realmPage=1
self.maxRealmPage=math.ceil(#temp/self.realmWidgetCount)
self:refreshXianYuArrow()
end


function UIServerTransferXianYuMainWin:refreshSearchRealmInfo(realms)
if self.inputstr~=nil then
local temp={}
local temp_search={}
local search=realms or self.showRealms
for i,v in ipairs(search)do
local cross_id=v.cross_id
local str=self.nameSearchList[cross_id]
if str==nil then
str=UIDiscipleModel.getSearchName(cross_id,loginModel:getCrossZoneName(cross_id))
self.nameSearchList[cross_id]=str
end
local d={v,str}
table.insert(temp_search,d)
end
if#temp_search>0 then
for i,v in ipairs(temp_search)do
local str=v[2]
if string.find(str,self.inputstr)then
table.insert(temp,v[1])
end
end
end
if#temp>0 then
return temp
end
end
end


function UIServerTransferXianYuMainWin:refreshRealmItem()
local setWidgetInfo=function(widget,realm)
if realm then
local xianyu_pj_level=realm.xianyu_level
widget:SetChildActive(-1,true)
widget:SetChildScale(7,xianyu_pj_level>xianYuGradeEnum.eChaoQun and Vector3(0.9,0.9,0.9)or Vector3.one)
widget:SetChildCSImageSprite(6,_abName,string.format("image_pojieyueqian_xq%d",xianyu_pj_level))
playerController:setHeadIcon(widget,0,{iconInfo=realm.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
widget:SetChildText(1,realm.name)
widget:SetChildText(2,string.format("<color=%s>%s</color>",nameColorByGrade[xianyu_pj_level],loginModel:getCrossZoneName(realm.cross_id)))
widget:SetChildCSImageSprite(3,_abName,string.format("image_pojieyueqian_wz%d",xianyu_pj_level))
widget:SetChildActive(3,self.isOpenXianYuTianLan)
widget:SetChildActive(4,self.isOpenXianYuTianLan)
widget:SetChildButtonClick(6,function()
ServerTransferController:send_35_162(realm.cross_id)
end)
else
widget:SetChildActive(-1,false)
end
end
local pageStartIdx=(self.realmPage-1)*self.realmWidgetCount
for index=1,self.realmWidgetCount do
local widget=self.realmWidgets[index-1]
local realm=self.showRealms[index+pageStartIdx]
setWidgetInfo(widget,realm)
end

local widget=self.myRealmItem:getWidgetBase()
local realm=self.myRealm
setWidgetInfo(widget,realm)
end


function UIServerTransferXianYuMainWin:refreshRealmItemXianYuTianLan()
local setWidgetInfo=function(widget,realm,index)
if realm then
widget:SetChildActive(3,self.isOpenXianYuTianLan)





end
end
local pageStartIdx=(self.realmPage-1)*self.realmWidgetCount
for index=1,self.realmWidgetCount do
local widget=self.realmWidgets[index-1]
local realm=self.showRealms[index+pageStartIdx]
setWidgetInfo(widget,realm,index)
end

local widget=self.myRealmItem:getWidgetBase()
local realm=self.myRealm
setWidgetInfo(widget,realm)
end


function UIServerTransferXianYuMainWin:doSpeaking_player(index,widget,speakObjWidgetIdx,speakTextWidgetIdx)
local speakStr='天上地下，唯我独尊！'
local speed=30
widget:SetChildCanvasGroupAlpha(speakObjWidgetIdx,1)
widget:SetChildTrendsTextPlay(speakTextWidgetIdx,speakStr,speed,nil)
self:doTalkAnim_player(index,widget,speakObjWidgetIdx,speakTextWidgetIdx)
end

function UIServerTransferXianYuMainWin:doTalkAnim_player(index,widget,speakObjWidgetIdx,speakTextWidgetIdx)
if self.talkTween[index]~=nil then
self.talkTween[index]:Kill()
self.talkTween[index]=nil
end

widget:SetChildScale(speakObjWidgetIdx,Vector3.zero)
self:delayDo(0.01,function()

self.talkTween[index]=widget:SetChildDOScale(speakObjWidgetIdx,1.2,0.2,function()
if _this==nil then return end
_this.talkTween[index]=nil
_this.talkTween[index]=widget:SetChildDOScale(speakObjWidgetIdx,0.9,0.1,function()
if _this==nil then return end
_this.talkTween[index]=nil
end)
end)
end)
end

function UIServerTransferXianYuMainWin:playChangeAnim()
self.anim=true
for index=1,self.realmWidgetCount do
local widget=self.realmWidgets[index-1]
widget:SetChildCanvasGroupDOFade(-1,0,0.5)
playerController:setHeadIcon(widget,0,nil)
end
self.winlua:SetChildSpineAnimation(self.planetSpine:getID(),3461,1,function()
self:refreshRealmItem()
for index=1,self.realmWidgetCount do
local widget=self.realmWidgets[index-1]
widget:SetChildCanvasGroupDOFade(-1,1,0.15)
end
self.winlua:SetChildSpineAnimation(self.planetSpine:getID(),2412,1,function()
self.anim=false
end)
end)
end

function UIServerTransferXianYuMainWin:refreshFilterBtn()
self.filterBtnOpen:setActive(self.isFilterTransferable)
self.filterBtnClose:setActive(not self.isFilterTransferable)
end

function UIServerTransferXianYuMainWin:refreshXianYuBtn()
self.xianYuBtnOpen:setActive(self.isOpenXianYuTianLan)
self.xianYuBtnClose:setActive(not self.isOpenXianYuTianLan)
end

function UIServerTransferXianYuMainWin:refreshXianYuArrow()
self.leftBtn:setActive(self.realmPage>1)
self.rightBtn:setActive(self.realmPage<self.maxRealmPage)
end

function UIServerTransferXianYuMainWin:refreshApplyBtn()
local transferCrossServerId=ServerTransferModel:getTransferCrossServerId()
local isShow=transferCrossServerId and transferCrossServerId>0
self.applyBubble:setActive(isShow)
if isShow then
self.applyTx:setText(string.format("正在申请：%s ...",loginModel:getCrossZoneName(transferCrossServerId)))
end
end

function UIServerTransferXianYuMainWin:refreshShopBtnReddot()
local reddot=ServerTransferModel:checkTransferServerShopReddot()
self.shopBtnReddot:setActive(reddot)
end

function UIServerTransferXianYuMainWin:refreshReviewBtnReddot()
local reddot=ServerTransferModel:checkTransferServerReviewReddot()
self.reviewBtnReddot:setActive(reddot)
end

function UIServerTransferXianYuMainWin:onSearchBtn()
if self.anim then return end
local inputstr=self.searchInput:getInputFieldValue()
if inputstr==''or inputstr==nil then
if self.inputstr~=nil then
self.inputstr=nil
self:refreshRealmInfo()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('名称含敏感字符')
return
end
local old=self.inputstr
self.inputstr=inputstr
local searchRealms=self:refreshSearchRealmInfo(self.notSearchRealms)
if not searchRealms then
self.inputstr=old
UIManager.info('查无此仙域')
return
end
self.showRealms=searchRealms
self:refreshSelfRealm()
self.searchInput:setInputFieldValue('')
self:refreshRealmItem()
end

function UIServerTransferXianYuMainWin:onSearchCancelBtn()
if self.inputstr==nil then return end
if self.anim then return end
self:clearSearchInput()
self:refreshRealmInfo()
end

function UIServerTransferXianYuMainWin:onSearchChange(str)
self:refreshInputBtns(str)
end

function UIServerTransferXianYuMainWin:refreshInputBtns(change_str)
if change_str==nil then
change_str=self.searchInput:getInputFieldValue()
end
local showCancel=self.inputstr~=nil and change_str==''
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIServerTransferXianYuMainWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIServerTransferXianYuMainWin:onLeftBtn()
if self.realmPage<=1 or self.anim then
return
end
self.realmPage=self.realmPage-1
self:refreshXianYuArrow()

self:playChangeAnim()
end

function UIServerTransferXianYuMainWin:onRightBtn()
if self.realmPage>=self.maxRealmPage or self.anim then
return
end
self.realmPage=self.realmPage+1
self:refreshXianYuArrow()

self:playChangeAnim()
end

function UIServerTransferXianYuMainWin:onCancelButton()
UIFullServerTransferControl:closeUI(true,true)
end

function UIServerTransferXianYuMainWin:onFilterBtn()
if self.anim then return end
self.isFilterTransferable=not self.isFilterTransferable
self:refreshFilterBtn()
self:refreshRealmInfo()
end

function UIServerTransferXianYuMainWin:onReviewBtn()

ServerTransferController:send_254_100(true)
end

function UIServerTransferXianYuMainWin:onStateDetailBtn()
self:showWindow("UIServerTransferConditionWin")
end

function UIServerTransferXianYuMainWin:onXianYuBtn()
if self.anim then return end
self.isOpenXianYuTianLan=not self.isOpenXianYuTianLan
self:refreshXianYuBtn()
self:refreshRealmItemXianYuTianLan()
end

function UIServerTransferXianYuMainWin:onShopBtn()
self:showWindow("UIServerTransferShopWin")
end

function UIServerTransferXianYuMainWin:onHelpBtn()





self:showWindow("UIServerTransferRuleWin")
end

function UIServerTransferXianYuMainWin:onApplyBubble()
local transferCrossServerId=ServerTransferModel:getTransferCrossServerId()
local isShow=transferCrossServerId and transferCrossServerId>0
if isShow then
ServerTransferController:send_35_162(transferCrossServerId)
end
end
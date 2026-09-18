







def_class("UISystemZongMenGiftWin",UIWindowBase)









function UISystemZongMenGiftWin:bindComponents()

self.chatBg=UIObject.get(self,0)
self.chatTx=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.dzModel=UIButton.get(self,3)
self.giftBtn=UIButton.get(self,4)
self.gifted=UIText.get(self,5)
self.giftList=UIObject.get(self,6)
self.giftTx=UIText.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.progressTx=UIText.get(self,9)
self.relationProgress_1=UIProgress.get(self,10)
self.relationProgress_2=UIProgress.get(self,11)
self.relationTx=UIText.get(self,12)
self.renownAddIcon=UIImage.get(self,13)
self.renownAddTx=UIText.get(self,14)
self.renownArrow=UIObject.get(self,15)
self.renownNowIcon=UIImage.get(self,16)
self.renownNowTx=UIText.get(self,17)
self.replaceBtn=UIButton.get(self,18)
self.selectBtn=UIButton.get(self,19)
self.zmName=UIText.get(self,20)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.dzModel:setButtonClick(function()self:onDzModel()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.replaceBtn:setButtonClick(function()self:onReplaceBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)
self.relationProgress={
self.relationProgress_1,
self.relationProgress_2,
}



end


function UISystemZongMenGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chatBg);self.chatBg=nil;
_UIObject_release(self.chatTx);self.chatTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.gifted);self.gifted=nil;
_UIObject_release(self.giftList);self.giftList=nil;
_UIObject_release(self.giftTx);self.giftTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.relationProgress_1);self.relationProgress_1=nil;
_UIObject_release(self.relationProgress_2);self.relationProgress_2=nil;
_UIObject_release(self.relationTx);self.relationTx=nil;
_UIObject_release(self.renownAddIcon);self.renownAddIcon=nil;
_UIObject_release(self.renownAddTx);self.renownAddTx=nil;
_UIObject_release(self.renownArrow);self.renownArrow=nil;
_UIObject_release(self.renownNowIcon);self.renownNowIcon=nil;
_UIObject_release(self.renownNowTx);self.renownNowTx=nil;
_UIObject_release(self.replaceBtn);self.replaceBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.zmName);self.zmName=nil;
self.relationProgress=nil;
end
















local _this=nil
local _item_kid={
item=0,
slider=1,
add=2,
del=3,
num=4,
black=5,
}
local _commonABName="ui/windows/systemzongmen/systemzongmen_atlas_pak.ab"



function UISystemZongMenGiftWin:onLoaded(...)
self:bindComponents()
_this=self
self.selecteds={}
self.add=0
self.plus=0
notifySystem:listenNotify(notifyConfig.onSystemZMGiftNum,self.onSystemZMGiftNum)
notifySystem:listenNotify(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)
notifySystem:listenNotify(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function UISystemZongMenGiftWin:__delete()
UIManager:hideWindow('UITopMoneyWin')
self:killChatTween()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMGiftNum,self.onSystemZMGiftNum)
notifySystem:removelistener(notifyConfig.onSystemZMInfoChange,self.onSystemZMInfoChange)
notifySystem:removelistener(notifyConfig.onSystemZMMoneyNumChange,self.onSystemZMMoneyNumChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.onDisciplePosChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
end




function UISystemZongMenGiftWin:onShow(argtable,afterOnloaded)
self.serial=argtable
self.infoData=systemZongMenModel:getInfoData(self.serial)
self:updateList()
self:updateProgress()
self:updatePlus()
self:setRight()
self:setLeft()
self:setDzModel()
self:refreshSpeak()

local moneyTypes={}
for i,v in ipairs(self.mList)do
table.insert(moneyTypes,{v.id})
end
self:showWindow("UITopMoneyWin",moneyTypes)
end


function UISystemZongMenGiftWin:onHide()

end



function UISystemZongMenGiftWin:onCloseBtn()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenGiftWin")
end


function UISystemZongMenGiftWin:onGiftBtn()
local haveCount=systemZongMenModel:getGiftCount(self.serial)
if haveCount==nil then
return
end
local checkCount=cfgHelper.get2(cfg_syszongmensonglibaseconfig_get,1,"dayNum")
if haveCount>=checkCount then
UIManager.error("一天内不可对同个宗门重复赠礼")
return
end

local rewards={}
for i,v in ipairs(self.mList)do
local num=self.selecteds[v.id]
if num>0 then
table.insert(rewards,{v.id,num*v.per})
end
end

if#rewards>0 then
local name=systemZongMenModel:getNameStr(self.infoData.id,self.infoData.nameIdx)
local args={
title='赠   送',
desc1=FMT.fmt('<color=#171311>确认将以下物品赠予</color><color=#CA631D>{0}</color>',name),
desc2='<color=#65615F>(同一个宗门每天只能赠礼一次)</color>',
rewards=rewards,
rewardTitle=-1,
showCancel=true,
cancelName=nil,
commitName='确定',
cancelCB=nil,
formatNumber=1,
commitCB=function()
systemZongMenController:req_gift(self.serial,rewards)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
else
UIManager.info("请选择需要赠送的物品")
end
end


function UISystemZongMenGiftWin:onHelpBtn()
local d={}
d.mode=3
d.title="赠礼"
d.name='systemZongMen_gift_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISystemZongMenGiftWin:onAppointBtn()
if not zongmenModel:haveBuildByBuildType(SLG_SYSTEM_TYPE.eZongMen)then
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eZongMen)
return
end
local bdType=cfgHelper.get2(cfg_guildposconfig_get,eZongMenPostType.eJieYin,"build_id")
if not zongmenModel:haveBuildByBuildType(bdType)then
zongmenModel:noBuildingTips(bdType)
return
end
local list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
local dis_guid=#list>0 and list[1].discipleguid or nil
UIManager:showWindow('UISectPalacePostInfoWin',{postType=eZongMenPostType.eJieYin,dis_guid=dis_guid})
end

function UISystemZongMenGiftWin:onDzModel()
self:onAppointBtn()
end

function UISystemZongMenGiftWin.onSystemZMGiftNum(serial,num)
if _this.serial==serial then
_this:refreshButton()
_this:refreshSpeak()
end
end

function UISystemZongMenGiftWin.onSystemZMInfoChange(serial,eType,oldVal,newVal)
if _this.serial==serial and eType==systemZongMenInfoUpdateType.eRelation and newVal==systemZongMenRelationType.eDiDui then
UIManager:invokeUIMethod("UISystemZongMenInfoWin","closeWindow","UISystemZongMenGiftWin")
UIManager.error("对方拒绝接见我方使节")
end
end

function UISystemZongMenGiftWin.onSystemZMMoneyNumChange(serial,eType,newVal,oldVal)
if _this.serial==serial and eType==systemZongMenInfoMoneyType.eShengWang then
_this.infoData=systemZongMenModel:getInfoData(serial)
_this:updateProgress()
_this:refreshProgress()
end
end

function UISystemZongMenGiftWin.onMoneyChanged(mType,oldVal,newVal)
for i,v in pairs(_this.mList)do
if mType==v.id then
local cfg=cfgHelper.get1(cfg_syszongmensongliconfig_get,_this.infoData.id)
local limit=cfg.hbMax[v.id]
if ZongMenDaoShiController:isOpenZongMenDaoShi()and not ZongMenDaoShiController:isZongMenDaoShiComplete()then
limit=limit+(cfg.hbMaxEx[v.id]or 0)
end
v.max=limit and math.min(newVal,limit)or newVal

local item=_this.giftList:getChildLayoutGroupGridItem(i-1)
local max=math.floor(v.max/v.per)
local cur=math.min(_this.selecteds[v.id],max)

_this.selecteds[v.id]=cur
item:SetChildSliderInit(_item_kid.slider,cur,0,max,function(value)
_this:onSliderChange(i,value)
end)
item:SetChildText(_item_kid.num,FMT.fmt("{0}/{1}",mathHelper.formatNumber(cur*v.per),mathHelper.formatNumber(v.max)))
item:SetChildGraphicGray(_item_kid.slider,v.max<v.per,true)

_this:updatePlus()
_this:refreshProgress()
end
end
end

function UISystemZongMenGiftWin:afterGift(serial,delta,itemList,gxNum,isBack)
if _this.serial==serial then
local temp={}
for i,v in ipairs(_this.mList)do
if _this.selecteds[v.id]>0 then
temp[v.id]=true
_this.selecteds[v.id]=0
end
end
_this.add=0
_this.plus=0
for i,v in ipairs(_this.mList)do
if temp[v.id]then
local item=self.giftList:getChildLayoutGroupGridItem(i-1)
item:SetChildSliderValue(_item_kid.slider,0)
end
end
_this:refreshProgress2()
_this:refreshSpeak()

if isBack then
if gxNum>0 then
if itemList==nil then
itemList={}
end
local fakeItem=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"money_show_item",systemZongMenInfoMoneyType.eZongMenGongXiang)
if fakeItem then
table.insert(itemList,1,{param_1=fakeItem,param_2=gxNum})
end
end
self:showWindow("UISystemZongMenGiftBackWin",{serial=_this.serial,delta=delta,gxNum=gxNum,rewards=itemList})
else
self:showWindow("UISystemZongMenGiftBackWin",{serial=_this.serial,delta=delta,gxNum=gxNum,})
end
end
end

function UISystemZongMenGiftWin:setDzModel()
local list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
local have=#list>0
self.elder=have and list[1].discipleguid or nil
self.dzModel:setActive(have)
self.replaceBtn:setActive(have)
self.selectBtn:setActive(not have)
if have then
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.elder,false,1)
self.dzModel:setChildUIModelRemoveTarget()
self.dzModel:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand)
self.dzModel:setChildUIModelShowFlipX(true)
end
end

function UISystemZongMenGiftWin:setLeft()
local nameStr=systemZongMenModel:getNameStr(self.infoData.id,self.infoData.nameIdx)
self.zmName:setText(FMT.fmt("<color=#634D36>赠送宗门：</color>{0}",nameStr))

self:refreshProgress()
end

function UISystemZongMenGiftWin:updateProgress()
local renownValue=self.infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local renownIndex=systemZongMenModel:getRenownIndex(self.infoData.id,renownValue)
local zmType=cfgHelper.get2(cfg_syssectconfig_get,self.infoData.id,"type")
local baseCfg=cfgHelper.get1(cfg_syssectbaseconfig_get,1)
local renown_list=baseCfg.renown_list[zmType]
local sect_money_limit=baseCfg.sect_money_limit[systemZongMenInfoMoneyType.eShengWang]
self.rMin=renown_list[renownIndex-1]or sect_money_limit[1]
self.rMax=(renown_list[renownIndex]or sect_money_limit[2])-self.rMin
self.rCur=renownValue-self.rMin
self.oMax=sect_money_limit[2]
self.oMin=sect_money_limit[1]
end

function UISystemZongMenGiftWin:refreshProgress()
local reputationValue=self.infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local reputationIndex=systemZongMenModel:getRenownIndex(self.infoData.id,reputationValue)
self.reputationStr=systemZongMenModel:getRenownName(reputationIndex)
local reputationIconName=systemZongMenModel:getRenownIcon(reputationIndex)
self.renownNowTx:setText(self.reputationStr)
self.renownNowIcon:setSprite(_commonABName,reputationIconName)

self.relationProgress_2:setProgressValue(self.rCur,self.rMax)
self:refreshProgress2()
self:refreshSpeak()
end

function UISystemZongMenGiftWin:updatePlus()
self.add=0
local cfg=cfgHelper.get1(cfg_syszongmensongliconfig_get,self.infoData.id)
for i,v in ipairs(self.mList)do
local num=self.selecteds[v.id]
if num>0 then
num=num*v.per
local temp=num*cfg.hbXiShu[v.id]
self.add=self.add+temp
end
end
local mk=cfgHelper.get2(cfg_syszongmensonglibaseconfig_get,1,"yhdMenKan")
local ml=0
if self.elder then
ml=UIDiscipleModel:getDiscipleBaseAttr(self.elder,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
end
self.add=self.add*(1+ml*cfg.mlXiShu)
self.plus=math.max(self.add-mk,0)
end

function UISystemZongMenGiftWin:refreshProgress2()
local renownValue=self.infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local value=Mathf.Clamp(renownValue+self.plus,self.oMin,self.oMax)
self.relationProgress_1:setProgressValue(value-self.rMin,self.rMax)

local num=self.infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local str=tostring(num)
if self.add>0 then
str=FMT.fmt("{0}<color=#ACE452>(+{1})</color>",num,math.floor(value-renownValue))
end
self.progressTx:setText(str)

if self.plus>0 then
local reputationValue=self.infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]+self.plus
local reputationIndex=systemZongMenModel:getRenownIndex(self.infoData.id,reputationValue)
local reputationStr=systemZongMenModel:getRenownName(reputationIndex)
if self.reputationStr~=reputationStr then
self.renownArrow:setActive(true)
self.renownAddIcon:setActive(true)
local reputationIconName=systemZongMenModel:getRenownIcon(reputationIndex)
self.renownAddTx:setText(reputationStr)
self.renownAddIcon:setSprite(_commonABName,reputationIconName)
return
end
end
self.renownArrow:setActive(false)
self.renownAddIcon:setActive(false)
end

function UISystemZongMenGiftWin:setRight()
self:refreshList()
self:refreshButton()
end

function UISystemZongMenGiftWin:updateList()
local cfg=cfgHelper.get1(cfg_syszongmensongliconfig_get,self.infoData.id)
local hbXiShu=cfg.hbXiShu
self.mList={}
for id,factor in pairs(hbXiShu)do
local per=cfgHelper.get3(cfg_syszongmensonglibaseconfig_get,1,"hbDanWei",id)
local limit=cfg.hbMax[id]
if ZongMenDaoShiController:isOpenZongMenDaoShi()and not ZongMenDaoShiController:isZongMenDaoShiComplete()then
limit=limit+(cfg.hbMaxEx[id]or 0)
end
local max=moneyModel.getMoney(id)
max=limit and math.min(max,limit)or max
self.selecteds[id]=0
table.insert(self.mList,{id=id,per=per,max=max})
end
table.sort(self.mList,function(a,b)
return a.id<b.id
end)
end

function UISystemZongMenGiftWin:refreshList()
self.giftList:setChildLayoutGroupCreateItems(#self.mList,function(index)
self:initListItem(index)
end)
end

function UISystemZongMenGiftWin:initListItem(index)
local info=self.mList[index]
local mId=info.id
local per=info.per
local item=self.giftList:getChildLayoutGroupGridItem(index-1)





local itemConf={itemid=mId,itemcount="",showCountBG=false,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(_item_kid.item,propData)
item:SetBaseItemClickEvent(_item_kid.item,function(...)
itemsComponentHelper.onItemClick(...)
end)
local _addCb=function()
self:onClickAdd(index)
end
local _delCb=function()
self:onClickDel(index)
end
item:SetChildButtonClick(_item_kid.add,function()
self:onClickAdd(index)
end)
item:SetChildButtonClick(_item_kid.del,function()
self:onClickDel(index)
end)
item:SetChildLongPress(_item_kid.add,_item_kid.add,function(id)
self:onClickAdd(index)
end,nil)
item:SetChildLongPress(_item_kid.del,_item_kid.del,function(id)
self:onClickDel(index)
end,nil)
local per=info.per
local num=info.max
local max=math.floor(num/per)
item:SetChildSliderInit(_item_kid.slider,0,0,max,function(value)
self:onSliderChange(index,value)
end)
item:SetChildText(_item_kid.num,FMT.fmt("{0}/{1}",0,mathHelper.formatNumber(num)))

item:SetChildGraphicGray(_item_kid.slider,num<per,true)
end

function UISystemZongMenGiftWin:onClickAdd(index)
local info=self.mList[index]
local mId=info.id
local max=math.floor(info.max/info.per)
self.selecteds[mId]=math.min(self.selecteds[mId]+1,max)
self:refreshSlider(index)
end

function UISystemZongMenGiftWin:onClickDel(index)
local info=self.mList[index]
local mId=info.id
self.selecteds[mId]=math.max(self.selecteds[mId]-1,0)
self:refreshSlider(index)
end

function UISystemZongMenGiftWin:refreshSlider(index)
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local info=self.mList[index]
local mId=info.id
local mNum=self.selecteds[mId]
item:SetChildSliderValue(_item_kid.slider,mNum)
local per=info.per
local max=info.max
mNum=mNum*per
item:SetChildText(_item_kid.num,FMT.fmt("{0}/{1}",mathHelper.formatNumber(mNum),mathHelper.formatNumber(max)))

self:updatePlus()
self:refreshProgress2()
self:refreshSpeak()
end

function UISystemZongMenGiftWin:onSliderChange(index,value)


local info=self.mList[index]
if info.per>info.max then
return
end
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local mId=info.id
self.selecteds[mId]=value
local per=info.per
local mNum=value*per
local max=info.max
item:SetChildText(_item_kid.num,FMT.fmt("{0}/{1}",mathHelper.formatNumber(mNum),mathHelper.formatNumber(max)))

self:updatePlus()
self:refreshProgress2()
self:refreshSpeak()
end

function UISystemZongMenGiftWin:refreshButton()
local count=systemZongMenModel:getGiftCount(self.serial)

self.giftBtn:setActive(count~=nil)
if count then
local max=cfgHelper.get2(cfg_syszongmensonglibaseconfig_get,1,"dayNum")
self.giftTx:setText(FMT.fmt("赠礼 ({0}/{1})",count,max))
self.giftBtn:setActive(count<max)
self.gifted:setActive(count>=max)
end
end

function UISystemZongMenGiftWin:refreshSpeak()
if self.elder then
local haveCount=systemZongMenModel:getGiftCount(self.serial)
if haveCount then
local checkCount=cfgHelper.get2(cfg_syszongmensonglibaseconfig_get,1,"dayNum")
if haveCount>=checkCount then
local str="今日已赠礼过该宗门了"
self:doSpeak(str)
return
end

local show=self.add>0
if show then
local cfg=cfgHelper.get1(cfg_syszongmensongliconfig_get,self.infoData.id)
local str=nil
for i=#cfg.dialog1,1,-1 do
local info=cfg.dialog1[i]
if self.plus>info[1]then
str=info[2]
break
end
end
if not str then
str=cfg.dialog1[i][2]
end
self:doSpeak(str)
return
end
end
end
self.chatBg:setChildCanvasGroupAlpha(0)
self.speakWorld=nil
self:killChatTween()
end

function UISystemZongMenGiftWin:doSpeak(word)
if self.speakWorld~=word then
self:killChatTween()
self.speakWorld=word
self.chatTx:setChildTrendsTextPlay(self.speakWorld,40,nil)

self.chatBg:setChildCanvasGroupAlpha(1)
self.chatBg:setScale(Vector3.zero)

self.chatTweener=Lua.SequenceProxy.New()
self.chatTweener:AppendInterval(0.2)
local tweener1=self.chatBg:setChildDOScale(1.2,0.2)
self.chatTweener:Append(tweener1)
local tweener2=self.chatBg:setChildDOScale(1,0.1)
self.chatTweener:Append(tweener2)
end
end

function UISystemZongMenGiftWin:killChatTween()
if self.chatTweener and self.chatTweener:IsActive()then
self.chatTweener:Kill()
end
end

function UISystemZongMenGiftWin:onReplaceBtn()
self:onAppointBtn()
end

function UISystemZongMenGiftWin:onSelectBtn()
self:onAppointBtn()
end

function UISystemZongMenGiftWin.onDisciplePosChange(dis_guid,old,pos)
if old==eZongMenPostType.eJieYin or pos==eZongMenPostType.eJieYin then
_this:setDzModel()
_this:refreshSpeak()
_this:updatePlus()
_this:refreshProgress()
end
end

function UISystemZongMenGiftWin.onNewDay5am()
systemZongMenController:req_giftInfo(_this.serial)
end

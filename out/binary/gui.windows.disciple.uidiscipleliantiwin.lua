







def_class("UIDiscipleLianTiWin",UIWindowBase)









function UIDiscipleLianTiWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.backEffect=UIObject.get(self,1)
self.brokeBtn=UIButton.get(self,2)
self.brokeEffect=UIObject.get(self,3)
self.brokeGoodGrid=UIObject.get(self,4)
self.brokePanel=UIObject.get(self,5)
self.closeQuick=UIButton.get(self,6)
self.ctNameText=UIText.get(self,7)
self.ctSpine=UIObject.get(self,8)
self.cuiTiBtn=UIButton.get(self,9)
self.cuiTiChongZhiBtn=UIButton.get(self,10)
self.cuiTiChongZhiReddot=UIObject.get(self,11)
self.cuitiEffect=UIObject.get(self,12)
self.cuiTiReddot=UIObject.get(self,13)
self.descBtn=UIButton.get(self,14)
self.gainWayList=UIObject.get(self,15)
self.gainWayPanel=UIObject.get(self,16)
self.gainWayTips=UIText.get(self,17)
self.jumpBtn=UIButton.get(self,18)
self.jumpBtnPanel=UIObject.get(self,19)
self.jumpBtnText=UIText.get(self,20)
self.leftLTRoot=UIObject.get(self,21)
self.leftQZRoot=UIObject.get(self,22)
self.listUnline=UIObject.get(self,23)
self.lowGradeDanYaoPriorityToggle=UIToggleButton.get(self,24)
self.ltFrame=UIObject.get(self,25)
self.ltGoodList=UIObject.get(self,26)
self.ltLvNameText=UIText.get(self,27)
self.ltLvNameText2=UIText.get(self,28)
self.ltLvNameText3=UIText.get(self,29)
self.ltProgress=UIObject.get(self,30)
self.ltRoot=UIObject.get(self,31)
self.quickAddBtn=UIButton.get(self,32)
self.quickArrow=UIObject.get(self,33)
self.quickBegin=UIText.get(self,34)
self.quickBg=UIObject.get(self,35)
self.quickBroke=UIText.get(self,36)
self.quickBtn=UIButton.get(self,37)
self.quickCostEmpty=UIObject.get(self,38)
self.quickCostList=UIObject.get(self,39)
self.quickCostOther=UIObject.get(self,40)
self.quickCostView=UIObject.get(self,41)
self.quickEnd=UIText.get(self,42)
self.quickPanel=UIObject.get(self,43)
self.quickProgressBarGreen=UIProgress.get(self,44)
self.quickProgressBarYellow=UIProgress.get(self,45)
self.quickResetBtn=UIButton.get(self,46)
self.quickRoot=UIObject.get(self,47)
self.quickSlider=UIObject.get(self,48)
self.quickSliderGroup=UIObject.get(self,49)
self.quickSliderHandle=UIObject.get(self,50)
self.quickSubBtn=UIButton.get(self,51)
self.quickUseBtn=UIButton.get(self,52)
self.qxzTxt=UIText.get(self,53)
self.qzAttrGrid=UIObject.get(self,54)
self.qzGoodList=UIObject.get(self,55)
self.qzGroupsGrid=UIObject.get(self,56)
self.qzRoot=UIObject.get(self,57)
self.talkObj=UIObject.get(self,58)
self.tipsText=UIText.get(self,59)
self.toggle1Btn=UIButton.get(self,60)
self.toggle2Btn=UIButton.get(self,61)

self.brokeBtn:setButtonClick(function()self:onBrokeBtn()end)

self.closeQuick:setButtonClick(function()self:onCloseQuick()end)

self.cuiTiBtn:setButtonClick(function()self:onCuiTiBtn()end)

self.cuiTiChongZhiBtn:setButtonClick(function()self:onCuiTiChongZhiBtn()end)

self.descBtn:setButtonClick(function()self:onDescBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.quickAddBtn:setButtonClick(function()self:onQuickAddBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.quickResetBtn:setButtonClick(function()self:onQuickResetBtn()end)

self.quickSubBtn:setButtonClick(function()self:onQuickSubBtn()end)

self.quickUseBtn:setButtonClick(function()self:onQuickUseBtn()end)

self.toggle1Btn:setButtonClick(function()self:onToggle1Btn()end)

self.toggle2Btn:setButtonClick(function()self:onToggle2Btn()end)



end


function UIDiscipleLianTiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.brokeBtn);self.brokeBtn=nil;
_UIObject_release(self.brokeEffect);self.brokeEffect=nil;
_UIObject_release(self.brokeGoodGrid);self.brokeGoodGrid=nil;
_UIObject_release(self.brokePanel);self.brokePanel=nil;
_UIObject_release(self.closeQuick);self.closeQuick=nil;
_UIObject_release(self.ctNameText);self.ctNameText=nil;
_UIObject_release(self.ctSpine);self.ctSpine=nil;
_UIObject_release(self.cuiTiBtn);self.cuiTiBtn=nil;
_UIObject_release(self.cuiTiChongZhiBtn);self.cuiTiChongZhiBtn=nil;
_UIObject_release(self.cuiTiChongZhiReddot);self.cuiTiChongZhiReddot=nil;
_UIObject_release(self.cuitiEffect);self.cuitiEffect=nil;
_UIObject_release(self.cuiTiReddot);self.cuiTiReddot=nil;
_UIObject_release(self.descBtn);self.descBtn=nil;
_UIObject_release(self.gainWayList);self.gainWayList=nil;
_UIObject_release(self.gainWayPanel);self.gainWayPanel=nil;
_UIObject_release(self.gainWayTips);self.gainWayTips=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jumpBtnPanel);self.jumpBtnPanel=nil;
_UIObject_release(self.jumpBtnText);self.jumpBtnText=nil;
_UIObject_release(self.leftLTRoot);self.leftLTRoot=nil;
_UIObject_release(self.leftQZRoot);self.leftQZRoot=nil;
_UIObject_release(self.listUnline);self.listUnline=nil;
_UIObject_release(self.lowGradeDanYaoPriorityToggle);self.lowGradeDanYaoPriorityToggle=nil;
_UIObject_release(self.ltFrame);self.ltFrame=nil;
_UIObject_release(self.ltGoodList);self.ltGoodList=nil;
_UIObject_release(self.ltLvNameText);self.ltLvNameText=nil;
_UIObject_release(self.ltLvNameText2);self.ltLvNameText2=nil;
_UIObject_release(self.ltLvNameText3);self.ltLvNameText3=nil;
_UIObject_release(self.ltProgress);self.ltProgress=nil;
_UIObject_release(self.ltRoot);self.ltRoot=nil;
_UIObject_release(self.quickAddBtn);self.quickAddBtn=nil;
_UIObject_release(self.quickArrow);self.quickArrow=nil;
_UIObject_release(self.quickBegin);self.quickBegin=nil;
_UIObject_release(self.quickBg);self.quickBg=nil;
_UIObject_release(self.quickBroke);self.quickBroke=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.quickCostEmpty);self.quickCostEmpty=nil;
_UIObject_release(self.quickCostList);self.quickCostList=nil;
_UIObject_release(self.quickCostOther);self.quickCostOther=nil;
_UIObject_release(self.quickCostView);self.quickCostView=nil;
_UIObject_release(self.quickEnd);self.quickEnd=nil;
_UIObject_release(self.quickPanel);self.quickPanel=nil;
_UIObject_release(self.quickProgressBarGreen);self.quickProgressBarGreen=nil;
_UIObject_release(self.quickProgressBarYellow);self.quickProgressBarYellow=nil;
_UIObject_release(self.quickResetBtn);self.quickResetBtn=nil;
_UIObject_release(self.quickRoot);self.quickRoot=nil;
_UIObject_release(self.quickSlider);self.quickSlider=nil;
_UIObject_release(self.quickSliderGroup);self.quickSliderGroup=nil;
_UIObject_release(self.quickSliderHandle);self.quickSliderHandle=nil;
_UIObject_release(self.quickSubBtn);self.quickSubBtn=nil;
_UIObject_release(self.quickUseBtn);self.quickUseBtn=nil;
_UIObject_release(self.qxzTxt);self.qxzTxt=nil;
_UIObject_release(self.qzAttrGrid);self.qzAttrGrid=nil;
_UIObject_release(self.qzGoodList);self.qzGoodList=nil;
_UIObject_release(self.qzGroupsGrid);self.qzGroupsGrid=nil;
_UIObject_release(self.qzRoot);self.qzRoot=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.toggle1Btn);self.toggle1Btn=nil;
_UIObject_release(self.toggle2Btn);self.toggle2Btn=nil;
end
















local _this=nil
local jumpbuildid=6
local listChange
local listChange2
local qzGroupChange
local tipsShowTime=5
local toggleTitle=
{
'炼体丹','奇珍'
}
local _quickUseUnit=20000



function UIDiscipleLianTiWin:onLoaded(...)
_this=self
self:bindComponents()
self.toggleWidget1=self.toggle1Btn:getWidgetBase()
self.toggleWidget2=self.toggle2Btn:getWidgetBase()
self.toggle2Btn:setActive(systemModel.isOpen(SYSTEM_DEFINE.eQiZhen))
listChange=true
listChange2=true
qzGroupChange=true
self.ltGoodList:setChildScrollViewInit(0.5,true,nil,nil)
self.qzGoodList:setChildScrollViewInit(0.5,true,nil,nil)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
self:addNotify(notifyConfig.onDiscipleLTChange,self.onDiscipleLTChange)
self:addNotify(notifyConfig.onDiscipleQiZhenChange,self.onDiscipleQiZhenChange)
self:addNotify(notifyConfig.onDiscipleCuiTiChange,self.onDiscipleCuiTiChange)
self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:addProNotify(1,18,self.on_1_18)
self.toggleWidget1:SetChildText(1,toggleTitle[1])
self.toggleWidget2:SetChildText(1,toggleTitle[2])
self.lowGradeDanYaoPriorityToggle:setToggleChange(function(...)
self:onLowGradeDyPriorityToggleChanged(...)
end)
end


function UIDiscipleLianTiWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(0,false)
self.brokeEffect:setChildShowEffect(0,false)
self:unbindComponents()

if self.waitQuickUse then
UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
end

if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
end


function UIDiscipleLianTiWin:onHide()

end

function UIDiscipleLianTiWin.on_1_18(len,array)
local waitQuickProto=_this.waitQuickProto
if waitQuickProto then
for idx=1,len do
local data=array[idx]
local guid=data.param_1
if mathHelper.compareInt64(guid,_this.disciple_guid)then
local itemid=data.param_2
local num=data.param_3
local key=FMT.fmt("{0}_{1}",itemid,num)
waitQuickProto.items[key]=nil
end
end
_this:checkWaitQuickProto()
end
end

function UIDiscipleLianTiWin.onItemListChanged(args)
if _this==nil then return end

_this:refreshQZToggleBtnReddot()

qzGroupChange=true
listChange2=true
if _this.curSelectPage==2 then

_this:refreshQZGroupsGrid()

_this:refreshQZGoodsList()

_this:refreshCuiTiReddot()

_this:refreshCuiTiSpine()
end
end

function UIDiscipleLianTiWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
local change=false

if _this.curSelectPage==1 then
local isNew=_this.items_lookup_new[itemid]
local change_idx=_this.items_lookup[itemid]
local check=isNew==true or change_idx~=nil
change=check

if isNew==true or(check and newcount==0)then
listChange=true
end

if change then
if not listChange and change_idx~=nil then
local showEffect=oldcount>newcount and _this.quickData==nil
_this:refreshGoodListItem(nil,change_idx,showEffect)

local idx=_this.quickGoods_lookup[itemid]
if idx then
local data=_this.quickGoods[idx]
local newNum=bagModel.getItemCountById(itemid)
data[3]=newNum
end
end
_this:refreshGoodList()
end
else
local change_idx=_this.items_lookup2[itemid]
change=change_idx~=nil
if change_idx~=nil then
if newcount==0 or oldcount==0 then
listChange2=true
end
end

if change then
_this.change_idx=change_idx
local num=oldcount-newcount
if num>0 then
_this:useQZGoodBack(itemid,num)
end
end
end


if _this.showBroke then
local netData=UIDiscipleModel:getDiscipleData(_this.disciple_guid)
local ltlv=netData.liantilv
local costlist=UIDiscipleModel:getDiscipleLTBrokeCost(_this.disciple_guid,ltlv)
for k,v in pairs(costlist)do
if v[1]==itemid then
_this:refreshBrokePanel()
end
end
end
end

function UIDiscipleLianTiWin.onShowDiscipleChanged(eType,datas,effectData)
if _this==nil then return end
UIFuncItemUseModel.onShowDiscipleChanged(eType,datas)




local itemid=effectData.itemid
local change=false

if _this.quickData then
return
end

if _this.curSelectPage==1 then
local change_idx=_this.items_lookup[itemid]
change=change_idx~=nil
if change then
local num=effectData.usednum+effectData.freenum
if num>0 then
_this:useGoodBack(itemid,num)
end
end
end
end

function UIDiscipleLianTiWin.onDiscipleLTChange(dis_guid,oldlv,lv)
if _this==nil then return end
if oldlv~=lv then
if mathHelper.compareInt64(dis_guid,_this.disciple_guid)then

_this:refreshQZToggleBtnReddot()

_this:refreshQZAllGroupItemReddot()

listChange2=true
if _this.curSelectPage==2 then
_this:refreshQZGoodsList()
end
end
end
end

function UIDiscipleLianTiWin.onDiscipleQiZhenChange(dis_guid,isclear)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end


_this:refreshQZToggleBtnReddot()

_this:refreshLeftInfoEx()

if isclear then
listChange2=true
qzGroupChange=true
if _this.curSelectPage==2 then
_this.curQZGroupIndex=nil

_this:refreshQZGroupsGrid()

_this:refreshQZGoodsList()
end
else

_this:refreshQZGroupItemReddot(nil,_this.curQZGroupIndex)
if listChange2 then

if _this.curSelectPage==2 then
_this:refreshQZGoodsList()
end
else

if _this.change_idx then
local group=_this.qzGroupList[_this.curQZGroupIndex]
local list=group.list
local data=list[_this.change_idx]
local netData=UIDiscipleModel:getDiscipleData(_this.disciple_guid)
_this:handleQZGoodItemData(netData,data)
if data.isfull then
listChange2=true
_this:refreshQZGoodsList()
else
_this:refreshQZGoodItemEx(_this.change_idx,true)
end
end
end
end
end

function UIDiscipleLianTiWin.onDiscipleCuiTiChange(dis_guid)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

local netData=UIDiscipleModel:getDiscipleData(_this.disciple_guid)

_this.ctlv=netData.qzctlv

_this:refreshLeftInfoEx()

_this:refreshQZToggleBtnReddot()

qzGroupChange=true
listChange2=true
if _this.curSelectPage==2 then

_this:refreshQZGroupsGrid()

_this:refreshQZGoodsList()

_this:refreshCuiTiReddot()

_this:refreshCuiTiSpine()
end
end




function UIDiscipleLianTiWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(discipleLookup.confgs.ltbackeffectID,true)
self.disciple_guid=argtable.guid
self.useItem=nil

if argtable.selectPage then
self.curSelectPage=argtable.selectPage
else
self.curSelectPage=1
local can=UIDiscipleModel:canDiscipleLTBroke(self.disciple_guid)
local isOpen=UIDiscipleModel:checkDZQiZhenOpen()
if not can and isOpen then
local isReddot,idx=UIDiscipleModel:checkDZQiZhenReddot(self.disciple_guid)
local isReddot2=UIDiscipleModel:checkDZCuiTiReddot(self.disciple_guid)
if isReddot then
self.curSelectPage=2
self.curQZGroupIndex=idx
elseif isReddot2 then
self.curSelectPage=2
end
end
end


self.lowGradeDyPriority=false
self.lowGradeDanYaoPriorityToggle:setToggle(self.lowGradeDanYaoPriority)

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.ctlv=netData.qzctlv
self:refreshView()
self:refreshToggleListView()

if self.curSelectPage==1 then
self:refreshBrokePanel()
end


end



function UIDiscipleLianTiWin:onToggle1Btn()
if self.isPlaying then return end
self:onToggleBtn(1)
end

function UIDiscipleLianTiWin:onToggle2Btn()
if self.isPlaying then return end
self:onToggleBtn(2)
end

function UIDiscipleLianTiWin:onToggleBtn(idx)
if self.curSelectPage==idx then
return
end
if idx==2 then
if not UIDiscipleModel:checkDZQiZhenOpen(true)then
return
end
end
self.curSelectPage=idx
self:refreshLeftInfo()
self:refreshToggleListView()

end

function UIDiscipleLianTiWin:refreshQZToggleBtn()

local isOpen=UIDiscipleModel:checkDZQiZhenOpen()
self.toggleWidget2:SetChildActive(2,not isOpen)

self:refreshQZToggleBtnReddot()
end
function UIDiscipleLianTiWin:refreshQZToggleBtnReddot()

local isReddot=UIDiscipleModel:checkDZQiZhenSystemReddot(self.disciple_guid)
self.toggleWidget2:SetChildActive(3,isReddot)
end

function UIDiscipleLianTiWin:refreshToggleListView()
if self.curSelectPage==1 then
self.toggleWidget1:SetChildCSImageSprite(0,globalABLookup.global,'button_xiaoyeqian_1')
self.toggleWidget2:SetChildCSImageSprite(0,globalABLookup.global,'button_xiaoyeqian_2')
self.ltRoot:setActive(true)
self.qzRoot:setActive(false)
self:refreshGoodList()
self:refreshBrokePanel()
else
self.toggleWidget1:SetChildCSImageSprite(0,globalABLookup.global,'button_xiaoyeqian_2')
self.toggleWidget2:SetChildCSImageSprite(0,globalABLookup.global,'button_xiaoyeqian_1')
self.ltRoot:setActive(false)
self.qzRoot:setActive(true)
self:refreshQZGroupsGrid()
self:refreshQZGoodsList()
end
end





function UIDiscipleLianTiWin:refreshView(force)
if not force and self.quickData then
self:refreshLTQuick()
return
end

local old_ltlv=self.cur_ltlv

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local n,p,pN=UIDiscipleModel:getLTNameX(ltlv)
self.ltLvNameText:setText(FMT.fmt('{0}{1}',n,pN))
local layer_str=''
if p~=nil then
layer_str=FMT.fmt('{0}层',p)
end
self.ltLvNameText2:setText(layer_str)


local ltexp=netData.liantiexp
local nxltexp=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'exp')
self.cur_ltlv=ltlv
if old_ltlv==nil then old_ltlv=ltlv end

local isfull=false
if nxltexp<=0 then
isfull=true
end
if isfull then
ltexp=1
nxltexp=1
else
if ltexp>nxltexp then
ltexp=nxltexp
end
end
local exp_str=''
if not isfull then
exp_str=FMT.fmt('{0}/{1}',ltexp,nxltexp)
else
exp_str='已满级'
end
local rate=ltexp/nxltexp
local bFunc=function()
if _this==nil then return end
_this.progressMove=true
end
local eFunc=function()
if _this==nil then return end
_this.progressMove=false
if force or _this.showBroke~=_this.needBroke then
_this:refreshBrokePanel()
end
end
helper.playProgressAnim2(progressAnimationType.eCommon,self.ltProgress,rate,ltlv-old_ltlv,bFunc,eFunc,nil,1)
self.ltLvNameText3:setText(exp_str)


local isOpen=UIDiscipleModel:checkDZQiZhenOpen()
self.toggleWidget2:SetChildActive(2,not isOpen)

self:refreshLeftInfo()
self:refreshQZToggleBtn()
end

function UIDiscipleLianTiWin:refreshLeftInfo()
if self.curSelectPage==1 then
self.leftLTRoot:setActive(true)
self.leftQZRoot:setActive(false)
self:refreshLTInfo()
else
self.leftLTRoot:setActive(false)
self.leftQZRoot:setActive(true)
self:refreshQZInfo()
end
end

function UIDiscipleLianTiWin:refreshLeftInfoEx()
if self.curSelectPage==1 then
self:refreshLTInfo()
else
self:refreshQZInfo()
end
end

function UIDiscipleLianTiWin:refreshLTInfo()

local isfull=UIDiscipleModel.checkLTFull(self.cur_ltlv)

local attrlist=self:getLerpAttrList(self.disciple_guid,isfull)
local c=#attrlist
self.attrGrid:setChildLayoutGroupCreateItems(c)
local attrGridList=self.attrGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=attrGridList[i-1]
local attr=attrlist[i]
local show=attr~=nil
item:SetChildActive(0,show)
if show then
local attrID=attr[1]
local attrValue=attr[2]
local addValue=attr[3]
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrID,'attrname')
item:SetChildText(1,attrname..'：')
item:SetChildText(2,helper.getAttributeStr1(attrID,attrValue))
local isadd=addValue>0
item:SetChildActive(3,isadd)
if isadd then
item:SetChildText(4,addValue)
end
end
end
end

function UIDiscipleLianTiWin:refreshQZInfo()
local lookup=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen)
local lookup2=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eCuiTi)
local attrlist={}
local attrTypes={eAttributeType.eATK,eAttributeType.eDEF,eAttributeType.eHP}
for i,v in ipairs(attrTypes)do
local n=lookup[v]or 0
n=n+(lookup2[v]or 0)
attrlist[#attrlist+1]={v,n}
end
local rate=UIDiscipleModel:getDZQiZhan2LianTianRate(self.disciple_guid)
rate=rate+UIDiscipleModel:getDZCuiTi2LianTianRate(self.disciple_guid)
attrlist[#attrlist+1]={-1,rate}

local c=#attrlist
self.qzAttrGrid:setChildLayoutGroupCreateItems(c)
local attrGridList=self.qzAttrGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=attrGridList[i-1]
local attr=attrlist[i]
local attrID=attr[1]
local attrValue=attr[2]
if attrID~=-1 then
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrID,'attrname')
item:SetChildText(1,attrname..'：')
item:SetChildText(2,helper.getAttributeStr1(attrID,attrValue))
else
item:SetChildText(1,'炼体属性：')
item:SetChildText(2,FMT.fmt('{0}%',attrValue))
end
end

self.ctNameText:setText(UIDiscipleModel:getCuiTiName(self.disciple_guid,3))

self:refreshQiXueZhi()

self:refreshCuiTiReddot()
self:refreshCuiTiSpine()
self:refreshResetBtn()
end


function UIDiscipleLianTiWin:refreshResetBtn()
local flag=UIDiscipleModel:showQZBtn(self.disciple_guid)
self.cuiTiChongZhiBtn:setActive(flag)
end






function UIDiscipleLianTiWin:refreshGoodList(needRefresh)
local hasCanUse
if needRefresh or listChange then
hasCanUse=false
listChange=false
self:getGoodList()
local cc=#self.goodlist
self.ltGoodList:setChildScrollViewCreateGrids(cc,1)
local goodGrid=self.ltGoodList:getChildScrollViewItemWidgets()
for i=1,cc do
local item=goodGrid[i-1]
self:refreshGoodListItem(item,i)
local data=self.goodlist[i]
local fix=data[2]
if fix then
hasCanUse=true
end
end
end

if hasCanUse~=nil then
self:refreshGainWayPanel(not hasCanUse)
end

local openQuick=systemModel.isOpen(SYSTEM_DEFINE.eQuickLevelUp)
self.quickBtn:setActive(openQuick)
self.ltFrame:setChildSizeDelta(474,openQuick and 436 or 485)
end

function UIDiscipleLianTiWin:refreshGoodListItem(item,index,showEffect)
if item==nil then
item=self.ltGoodList:getChildScrollViewItemWidget(index-1)
end
local data=self.goodlist[index]
local cfg=data[1]
local itemID=cfg.id
local itemNum=bagModel.getItemCountById(itemID)
local conf={itemid=itemID,itemcount=itemNum,showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eLeft,...)end)

item:SetChildText(1,itemsConfig.getItemName(itemID))

local funcparam=cfg.funcparam
local curexp=funcparam.exp
local addexp=UIDiscipleModel:calculationLTMedicineGrow(self.disciple_guid,curexp,itemID)
local desc_str=FMT.fmt('炼体经验+{0}',addexp)
if funcparam.attr6~=nil then
desc_str=desc_str..'\n'..FMT.fmt('{0}+{1}',UIDiscipleModel:getDiscipleBaseAttrName(funcparam.attr6[1][1]),funcparam.attr6[1][2])
end
item:SetChildText(2,desc_str)

local cb=function(idx)
self:onGoodUpBtnClick(idx,itemID)
end
local fncb=function(idx)
self:onGoodUpBtnClick_fn(idx,itemID)
end
item:SetChildLongPress(3,index,cb,fncb)

local fix=data[2]
local is_gray=not fix
item:SetChildImageExGray(3,is_gray)

item:SetChildActive(4,is_gray)

if showEffect then
item:SetChildShowEffect(5,10088,true)
end
end

function UIDiscipleLianTiWin:getGoodList()
local templist=itemsLookup:get_function_items(item_funtion_type.lt_jingyandan)or{}
local list={}
for k,v in pairs(templist)do
if v.type3 and v.type3==1 then
else
table.insert(list,v)
end
end
self.goodlist={}
self.quickGoods={}
self.quickGoods_lookup={}
self.items_lookup={}
self.items_lookup_new={}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
local funcparam=v.funcparam
local fix=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,v.id)
local needReconfirmWeight=v.reconfirmText and 1000 or 0
local d={v,fix,funcparam.exp,v.stage or 0,needReconfirmWeight}
table.insert(self.goodlist,d)

local extra=funcparam.extra
local attr6=funcparam.attr6
if fix and not extra and not attr6 then
local addExp=UIDiscipleModel:calculationLTMedicineGrow(self.disciple_guid,funcparam.exp,v.id)
d={v,funcparam.exp,num,addExp}
table.insert(self.quickGoods,d)
end
else
self.items_lookup_new[v.id]=true
end
end
if#self.goodlist>0 then
table.sort(self.goodlist,function(a,b)
if a[2]==b[2]then
if a[5]==b[5]then
return a[3]>b[3]
else
return a[5]<b[5]
end
else
local aa=a[2]==true and 1 or 0
local bb=b[2]==true and 1 or 0
return aa>bb
end
end)
for i,v in ipairs(self.goodlist)do
self.items_lookup[v[1].id]=i
end
end

if#self.quickGoods>0 then
if#self.quickGoods>1 then
table.sort(self.quickGoods,function(a,b)
if a[2]~=b[2]then

if _this.lowGradeDanYaoPriority then
return a[2]<b[2]
else
return a[2]>b[2]
end
end

return a[1].id<b[1].id
end)
end

for i,v in ipairs(self.quickGoods)do
self.quickGoods_lookup[v[1].id]=i
end
end
end

function UIDiscipleLianTiWin:showTips(isshow)

self.tipsText:setActive(isshow)
if isshow then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,jumpbuildid,'name')
local str=FMT.fmt('点击前往 <color=#2dcd19>【{0}】</color> 炼制炼体丹',name)
self.tipsText:setText(str)
end
end

function UIDiscipleLianTiWin:onTipsClick()



local goFunc=function()
local jumpParam={type=0,id=501}
local flag=jumpManager:jump(jumpParam)
return flag
end
UIFullCommonControl:showWindow_BackDiscipleMain(goFunc,self.disciple_guid)
end

function UIDiscipleLianTiWin:refreshBrokePanel()
self.needBroke=UIDiscipleModel:checkDiscipleLTNeedBroke(self.disciple_guid)
self.showBroke=self.needBroke and not self.progressMove
self.brokePanel:setActive(self.showBroke)
if self.showBroke then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local costlist=UIDiscipleModel:getDiscipleLTBrokeCost(self.disciple_guid,ltlv)
local grid=self.brokeGoodGrid:getChildCommonLayoutGroupWidgetList()
for i=1,5 do
local data=costlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local needNum=data[2]
local hasNum=0
if itemsConfig.isMoney(itemID)then
hasNum=moneyModel.getMoney(itemID)
else
hasNum=bagModel.getItemCountById(itemID)
end
local str=string.format('%d/%d',hasNum,needNum)
local grayNum=0
if hasNum<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif hasNum<needNum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=true,showStage=true,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local isEnough=hasNum>=needNum
if isEnough then
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eRight,...)end)
else
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick_gain(...)end)
end
end
end
end
end

function UIDiscipleLianTiWin:getLerpAttrListEx(guid,isfull,before,after)
local result={}
local temp1=UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,false,before[1],before[2])
local temp2=temp1
if not isfull or before[1]~=after[1]or before[2]~=after[2]then
temp2=UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,false,after[1],after[2])
end
for k,v in pairsBySortKey(temp1)do
result[#result+1]={k,v,temp2[k]-v}
end
return result
end

function UIDiscipleLianTiWin:getLerpAttrList(guid,isfull)
local temp1=UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,false)
local result={}
local temp2
if isfull then
temp2=temp1
else
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local ex_rate=1

local ltLookup
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local job=imageInfo.job
local ltlv=netData.liantilv
local disciplelianticonfig=cfg_disciplelianticonfig_get(ltlv)

local liantiexp=netData.liantiexp
local ll_expattr=cfgHelper.getdef1(cfg_disciplelianticonfig,'expattr')
local ll_exp_precent=0
if disciplelianticonfig.exp>0 then
ll_exp_precent=liantiexp/disciplelianticonfig.exp
end
if ll_exp_precent>1 then
ll_exp_precent=1
end
local ll_rate=math.floor(ll_exp_precent*100/ll_expattr)
ll_rate=ll_rate+1
if ll_rate>=10 then
ltlv=ltlv+1
ll_rate=0
end
temp2=UIDiscipleModel:calculationDiscipleLTAttr(job,ltlv,ll_rate,ex_rate,false)
end
for k,v in pairsBySortKey(temp1)do
result[#result+1]={k,v,temp2[k]-v}
end
return result
end

function UIDiscipleLianTiWin:onGoodItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end

function UIDiscipleLianTiWin:onGoodItemClick_gain(itemid,index,itemguid,attach)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local costlist=UIDiscipleModel:getDiscipleLTBrokeCost(self.disciple_guid,ltlv)
local needCount
for k,v in pairs(costlist)do
if v[1]==itemid then
needCount=v[2]
break
end
end
gainControl:showCommonGainWin_item(itemid,{needCount=needCount})
end

function UIDiscipleLianTiWin:stopItemLongPress(idx)
local item=self.ltGoodList:getChildScrollViewItemWidget(idx-1)
if item then
item:SetChildLongPressStop(3)
item:SetChildShowEffect(5,0,false)
end
end

function UIDiscipleLianTiWin:checkIsSpecItem(itemID)
local itemcfg=itemsConfig.getConfig(itemID)
local funcparam=itemcfg.funcparam
if funcparam~=nil then
local extraList=funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[2][3]or v[2][5]or v[2][6]or v[2][7]then
return true
end
end
end
return false
end

function UIDiscipleLianTiWin:checkGoodUpUseCondition(idx,itemID)
if self.isPlaying then
return false
end

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,ltlv)
local ltexp=netData.liantiexp
local nxltexp=cfg.exp

if nxltexp==0 then
UIManager.error('炼体已满级')
return false
end

local itemNum=bagModel.getItemCountById(itemID)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
return false
end


local fix,cond=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,itemID)
if not fix then
if cond then
local item=self.ltGoodList:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(-190,30)
local cond_str=self:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end

local itemCfg=itemsHelper:get_item_config(itemID)
local reconfirmText=itemCfg.reconfirmText
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eItemHideReconfirmDialog)
local isHideReconfirmDialog=check or self.useItemID==itemID
if self.useItemID~=itemID then
self.checkNextUseSameItem=nil
end
local _fun=function(iscallback)
if reconfirmText then

local isShowDialog=not isHideReconfirmDialog
local showAttrText=""
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(self.disciple_guid,itemID,true)
if has6AttrCondition then
local tempCheckNextUseSameItemFlag=false
for _,v in ipairs(conditionList)do
local attrName=UIDiscipleModel:getDiscipleBaseAttrName(v.attrType)
showAttrText=FMT.fmt("{0}\n<size=26>弟子基础{1}：<color=#ca631d>{2}</color></size>",showAttrText,attrName,v.actuallyAttr)
if v.actuallyAttr>=v.minAttr and v.actuallyAttr<=v.maxAttr then
tempCheckNextUseSameItemFlag=true
elseif self.checkNextUseSameItem and v.actuallyAttr>v.maxAttr then
isShowDialog=true
self.checkNextUseSameItem=nil
end
end
if tempCheckNextUseSameItemFlag then
self.checkNextUseSameItem=true
end
end
if isShowDialog then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if _this==nil then return end
_this.useItemID=itemID
bagProtocolControl.req_dizi_use_item(_this.disciple_guid,itemID,1)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eItemHideReconfirmDialog)






















return false
end
end
if iscallback then
if _this==nil then return end
_this.useItemID=itemID
bagProtocolControl.req_dizi_use_item(_this.disciple_guid,itemID,1)
return false
else
return true
end
end

if ltexp>=nxltexp then
if cfg.consume~=nil then
local falg=true
local attrName=nil
local maxAttr=0
if reconfirmText then
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(self.disciple_guid,itemID,true)
if not has6AttrCondition then
has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrConditionEX(self.disciple_guid,itemID,true)
end
if has6AttrCondition then
falg=false
for _,v in ipairs(conditionList)do
if v.actuallyAttr>=v.minAttr and v.actuallyAttr<=v.maxAttr then
falg=true
break
end
local name=UIDiscipleModel:getDiscipleBaseAttrName(v.attrType)
if not attrName then
attrName=name
else
attrName=FMT.fmt("{0}、{1}",attrName,name)
end
maxAttr=v.maxAttr
end
end
end

if falg and self:checkIsSpecItem(itemID)then
local contentStr="弟子当前境界<color=#CB6A28>经验已满</color>，使用将只获得道具效果而不获得境界经验，是否继续使用？"
local okcallback=function(...)
return _fun(true)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
else
if reconfirmText and not falg then
UIManager.error(FMT.fmt("弟子{0}超过{1}，境界经验已满，请先突破境界",attrName,maxAttr+1))
else
UIManager.error('炼体等级已达上限，请先完成突破！')
end
return false
end
end
end
return _fun()
end

function UIDiscipleLianTiWin:onGoodUpBtnClick(idx,itemID)
if not self:checkGoodUpUseCondition(idx,itemID)then
self:stopItemLongPress(idx)
return
end

local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local max=bagModel.getItemCountById(itemID)
if num>max then
num=max
end
self.useItemID=itemID
bagProtocolControl.req_dizi_use_item(self.disciple_guid,itemID,num)
end

function UIDiscipleLianTiWin:onGoodUpBtnClick_fn(idx,itemID)
self.useGoodTime=nil

self:recordClickCount()
end

function UIDiscipleLianTiWin:onBrokeBtn()
if self.isPlaying then return end
if not UIDiscipleModel:checkLTBrokeCondition(self.disciple_guid,true,1)then
return
end

UIDiscipleController:requireDiscipleUpLianTi(self.disciple_guid)
end

function UIDiscipleLianTiWin:rec_upback(oldlv,lv)
if self.quickData then
return
end
if oldlv==lv then
self:refreshView()
self:refreshBrokePanel()
end
end

function UIDiscipleLianTiWin:rec_brokeback()
if self.waitQuickProto then
self.waitQuickProto.broke=self.waitQuickProto.broke-1
self:checkWaitQuickProto()
return
end

local oldlv=self.quickData and self.quickData.sLv or self.cur_ltlv
local oldGrade=UIDiscipleModel:getLTGrade(oldlv)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local curGrade=UIDiscipleModel:getLTGrade(ltlv)
local bigBroke=curGrade~=oldGrade
if bigBroke then

self:refreshBrokePanel()
self:playBrokeAnim()
else
UIManager.info('突破成功')
self:refreshView()
self:refreshBrokePanel()

end
end

function UIDiscipleLianTiWin:playBrokeAnim()
self.isPlaying=true
local func=function()
if _this==nil then return end
self.playTimer=nil
self.isPlaying=false
self.brokeEffect:setChildShowEffect(0,false)
self:refreshGoodList(true)
if self.quickData then
self:getQuickData()
self:initQuickPanel()
self:refreshView()
else
self:refreshView()
end
end
self.playTimer=self:setTimer(3.2,1,func)
self.brokeEffect:setChildShowEffect(discipleLookup.confgs.ltbrokeeffectID,true)


AudioManager.playAudio(618)
end

function UIDiscipleLianTiWin:onDescBtn()
local rule_srt=cfgHelper.get1(cfg_lang_get,'disciple_lt_desc_1')
local pos=Vector2.New(-14,12)
local func=function()
self.descBtn:setSprite(globalABLookup.global,'button_tyjieshao_1')
end
UIManager:showWindow('UIConditionTipsOne',{str=rule_srt,posItem=self.descBtn,pos=pos,showType=1,callback=func})
self.descBtn:setSprite(globalABLookup.global,'button_tyjieshao_2')
end



function UIDiscipleLianTiWin:refreshQZGroupsGrid()
if qzGroupChange then
qzGroupChange=false
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ctlv=netData.qzctlv
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local jobid=imageInfo.job
self.qzGroupList=UIDiscipleModel:getQiZhenGroupList(jobid,ctlv,true)

local num=#self.qzGroupList
if self.curQZGroupIndex==nil and num>0 then
for i=1,num do
if UIDiscipleModel:checkDZQiZhenGroupReddotEx(netData,i)then
self.curQZGroupIndex=i
break
end
end
if self.curQZGroupIndex==nil then
self.curQZGroupIndex=1
end
end
self.qzGroupsGrid:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
_this:refreshQZGroupItem(nil,idx)
end)
end
end

function UIDiscipleLianTiWin:refreshQZGroupItem(item,idx)
if item==nil then
item=self.qzGroupsGrid:getChildLayoutGroupGridItem(idx-1)
end
local group=self.qzGroupList[idx]

local name_str=FMT.fmt('{0}阶',idx)
item:SetChildText(1,name_str)

local abname=globalABLookup.diciplemain
local iconname=FMT.fmt('image_qizhenjy_{0}',idx)
item:SetChildCSImageSprite(3,abname,iconname)

local islock=self.ctlv<group.ctlv
item:SetChildActive(2,islock)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onQZGroupItemClick(idx)
end)

self:refreshQZGroupItemSelect(item,idx,self.curQZGroupIndex==idx)

self:refreshQZGroupItemReddot(item,idx)
end

function UIDiscipleLianTiWin:refreshQZGroupItemSelect(item,idx,flag)
if item==nil then
item=self.qzGroupsGrid:getChildLayoutGroupGridItem(idx-1)
end
local abname=globalABLookup.global
local iconname
if flag then
iconname='button_yeqiantab_2'
else
iconname='button_yeqiantab_1'
end
item:SetChildCSImageSprite(0,abname,iconname)
end

function UIDiscipleLianTiWin:refreshQZAllGroupItemReddot()
if self.qzGroupList then
local num=#self.qzGroupList
if num>0 then
for idx=1,num do
self:refreshQZGroupItemReddot(nil,idx)
end
end
end
end
function UIDiscipleLianTiWin:refreshQZGroupItemReddot(item,idx)
if item==nil then
item=self.qzGroupsGrid:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local isReddot=UIDiscipleModel:checkDZQiZhenGroupReddot(self.disciple_guid,idx)
item:SetChildActive(4,isReddot)
end

function UIDiscipleLianTiWin:onQZGroupItemClick(idx)
local group=self.qzGroupList[idx]
if self.ctlv<group.ctlv then
UIManager.error(FMT.fmt('淬体{0}开启',UIDiscipleModel:getCuiTiNameEx(group.ctlv,1)))
return
end

if self.curQZGroupIndex==idx then return end

if self.curQZGroupIndex then
self:refreshQZGroupItemSelect(nil,self.curQZGroupIndex,false)
end
self:refreshQZGroupItemSelect(nil,idx,true)
self.curQZGroupIndex=idx

self:refreshQZGoodsList(true)
end

function UIDiscipleLianTiWin:refreshQZGoodsList(needRefresh)
if needRefresh or listChange2 then
listChange2=false
local items_lookup2={}
self.items_lookup2=items_lookup2
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local group=self.qzGroupList[self.curQZGroupIndex]
local list
local num=0
if group then
list=group.list
num=#list
for i,data in ipairs(list)do
self:handleQZGoodItemData(netData,data)
end
end
if num>1 then
table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
if num>0 then
for i,data in ipairs(list)do
local itemid=data.cfg.id
items_lookup2[itemid]=i
end
end

self.qzGoodList:setChildScrollViewCreateGrids(num,1)
local goodGrid=self.qzGoodList:getChildScrollViewItemWidgets()
for i=1,num do
local item=goodGrid[i-1]
self:refreshQZGoodItem(item,i)
end
end
self:showTips(false)
end

function UIDiscipleLianTiWin:handleQZGoodItemData(netData,data)
local itemid=data.cfg.id
local ltlv=netData.liantilv
local fix_lv=true
if data.cfg.lianti then
fix_lv=ltlv>=data.cfg.lianti
end
local usenum,max_usenum,hasnum,isfull,isfull_f,f_ctlv=UIDiscipleModel:getDZQiZhenItemProgressEx(netData,itemid)
local state
if not isfull then
if hasnum>0 and fix_lv then
state=3
else
state=2
end
else
state=1
end
local itemConfig=itemsConfig.getConfig(itemid)
data.weight=state*10+itemConfig.color or 0
data.state=state
data.usenum=usenum
data.max_usenum=max_usenum
data.isfull=isfull
data.isfull_f=isfull_f
data.fix_lv=fix_lv
data.f_ctlv=f_ctlv
end

function UIDiscipleLianTiWin:refreshQZGoodItemEx(index,showEffect)
local group=self.qzGroupList[self.curQZGroupIndex]
if group==nil then return end
local list=group.list
local data=list[index]
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self:handleQZGoodItemData(netData,data)

local item=self.qzGoodList:getChildScrollViewItemWidget(index-1)
if item then
self:refreshQZGoodItem(item,index,showEffect)
end
end

function UIDiscipleLianTiWin:refreshQZGoodItem(item,index,showEffect)
if item==nil then
item=self.qzGoodList:getChildScrollViewItemWidget(index-1)
end
local group=self.qzGroupList[self.curQZGroupIndex]
local list=group.list
local data=list[index]

local usenum=data.usenum
local max_usenum=data.max_usenum
local isfull=data.isfull
local isfull_f=data.isfull_f
local cfg=data.cfg
local itemid=cfg.id
local hasnum=bagModel.getItemCountById(itemid)
local state=data.state
local itemcount
if hasnum<=0 then
itemcount=toColorString(FONT_COLOR.eRedColor,hasnum)
else
itemcount=tostring(hasnum)
end
local conf={itemid=itemid,itemcount=itemcount,showname=false,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eLeft,...)end)

local name_str=FMT.fmt('{0}（{1}/{2}）',itemsConfig.getItemName(itemid),usenum,max_usenum)
item:SetChildText(1,name_str)

local desc_str=''
local dnum=0
if cfg.attr then
for i,v in ipairs(cfg.attr)do
dnum=dnum+1
local str=helper.getAttributeStr(v[1],v[2],1,'{0}+{1}')
if dnum==1 then
desc_str=str
elseif dnum%2==0 then
desc_str=FMT.fmt('{0}　{1}',desc_str,str)
else
desc_str=FMT.fmt('{0}\n{1}',desc_str,str)
end
end
end
if cfg.percent then
dnum=dnum+1
local str=FMT.fmt('炼体属性+{0}%',cfg.percent)
if dnum==1 then
desc_str=str
elseif dnum%2==0 then
desc_str=FMT.fmt('{0}　{1}',desc_str,str)
else
desc_str=FMT.fmt('{0}\n{1}',desc_str,str)
end
end
item:SetChildText(2,desc_str)

local cb=function(index)
self:onQZGoodItemClick(index,itemid)
end
local fncb=function(index)
self:onQZGoodItemClick_fn(index,itemid)
end
item:SetChildLongPress(3,index,cb,fncb)

local fix=state==3
local is_gray=not fix
item:SetChildImageExGray(3,is_gray)



if showEffect then
item:SetChildShowEffect(5,10088,true)
end
end

function UIDiscipleLianTiWin:stopItemLongPress_qz(index)
local item=self.qzGoodList:getChildScrollViewItemWidget(index-1)
if item then
item:SetChildLongPressStop(3)
end
end

function UIDiscipleLianTiWin:checkQZGoodUseCondition(index,itemid)
if self.isPlaying then
return false
end

local group=self.qzGroupList[self.curQZGroupIndex]
local list=group.list
local data=list[index]

local isfull_f=data.isfull_f
if isfull_f then
UIManager.error('服用数量已达上限')
return false
end

local isfull=data.isfull
if isfull then
local str=FMT.fmt('{0}可提升上限',UIDiscipleModel:getCuiTiNameEx(data.f_ctlv+1,1))
UIManager.error(str)
return false
end

local itemNum=bagModel.getItemCountById(itemid)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemid,nil,{needCount=-1})
return false
end

local fix_lv=data.fix_lv
if not fix_lv then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local t_ltlv=data.cfg.lianti
UIManager.error(FMT.fmt('炼体需达到{0}期（{1}/{2}）',UIDiscipleModel:getLTName(t_ltlv),ltlv,t_ltlv))
return false
end

return true
end

function UIDiscipleLianTiWin:onQZGoodItemClick(index,itemid)
if not self:checkQZGoodUseCondition(index,itemid)then
self:stopItemLongPress_qz(index)
return
end
local group=self.qzGroupList[self.curQZGroupIndex]
local list=group.list
local data=list[index]

local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=3 then
num=10
elseif lerp>=2 then
num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local max=bagModel.getItemCountById(itemid)
local usenum=data.usenum
local max_usenum=data.max_usenum
local n=max_usenum-usenum
num=math.min(num,n,max)

UIDiscipleController:reqUseQiZhen(self.disciple_guid,itemid,num)
end

function UIDiscipleLianTiWin:onQZGoodItemClick_fn(index,itemid)
self.useGoodTime=nil
self:recordClickCount()
end




function UIDiscipleLianTiWin:refreshQiXueZhi()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local str=FMT.fmt('气血值：<color=#f7f7f7>{0}</color>',netData.qzctexp)
self.qxzTxt:setText(str)
end

function UIDiscipleLianTiWin:refreshCuiTiReddot()
local isReddot=UIDiscipleModel:checkDZCuiTiReddotEx(self.disciple_guid)
self.cuiTiReddot:setActive(isReddot)
end

function UIDiscipleLianTiWin:refreshCuiTiSpine()
local isOpen=UIDiscipleModel:checkDZQiZhenOpen()

local spineid,effectid
if isOpen then
spineid,effectid=UIDiscipleModel:getCuiTiFloorSpine(self.ctlv)

end
if spineid~=nil then
if self.cuitiSpine~=spineid then
self.cuitiSpine=spineid
self.cuitiEffect:setChildShowEffect(0,false)
self.ctSpine:setChildUIModelShowTarget(spineid,0.25,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.5,function()
_this.cuitiEffect:setChildShowEffect(effectid,true)
end)
end)
else

end
else
self.ctSpine:setChildUIModelRemoveTarget()
self.cuitiEffect:setChildShowEffect(0,false)
end
end

function UIDiscipleLianTiWin:onCuiTiBtn()
self:showWindow('UIDiscipleCuiTiWin',{dis_guid=self.disciple_guid})
end

function UIDiscipleLianTiWin:onCuiTiChongZhiBtn()
self:showWindow('UIDiscipleResetCuiTiWin',{dis_guid=self.disciple_guid})
end







function UIDiscipleLianTiWin:getUseGoodStr(cond)
local str=''
local line=0
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,cond)
if lianti~=nil then
local lt_name=UIDiscipleModel:getLTNameX(lianti[1])
str=str..FMT.fmt('{0}期弟子才可以服用',lt_name)
line=line+1
end
return str
end

function UIDiscipleLianTiWin:useGoodBack(itemid,num)
UIDiscipleModel:useLTGoodBack(self.disciple_guid,itemid,1,num)
end

function UIDiscipleLianTiWin:useQZGoodBack(itemid,num)


end

function UIDiscipleLianTiWin:recordClickCount()
if self.clickTime==nil or(Time.realtimeSinceStartup-self.clickTime<0.5)then
self.clickCount=self.clickCount==nil and 1 or(self.clickCount+1)
else
self.clickCount=0
end
if self.clickCount>=5 then
self.clickCount=0


self:showTalk('长按可批量使用物品')
end
self.clickTime=Time.realtimeSinceStartup
end

function UIDiscipleLianTiWin:showTalk(talkStr)
self:clearTalk()

self.talkObj:setActive(true)
local talkWidget=self.talkObj:getChildWidgetBase()
talkWidget:SetChildText(0,talkStr)
self.talkObj:setChildCanvasGroupAlpha(0)
self.talkObj:setChildCanvasGroupDOFade(1,0.1,nil)
self.talkObj:setScale(Vector3.New(0,0,0))
self.talkObj:setChildDOScale(1,0.2,nil)

local func=function()
self:clearTalk()
end
self.talkTimer=self:delayDo(tipsShowTime,func)
end

function UIDiscipleLianTiWin:clearTalk()
if self.talkTimer~=nil then
self.talkObj:setActive(false)
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
end



function UIDiscipleLianTiWin:refreshGainWayPanel(isShow)
local isHasItem=false
local isHasGainWay=false
isHasItem=#self.goodlist>0
if isShow then

self:stopItemLongPress(1)
self.gainWayTips:setText(FMT.fmt('库房无弟子当前境界可服用的{0}',toggleTitle[self.curSelectPage]))


local gainWayList=self:getGainWaySortList()
local gainWayCount=#gainWayList
isHasGainWay=gainWayCount>0
self.gainWayList:setChildLayoutGroupCreateItems(gainWayCount)
local grids=self.gainWayList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
local info=gainWayList[i]
local jump=info.jump
local hasJump=jump~=nil
local unLock,errArgs=gainControl:isUnlock(info)
local active=hasJump and unLock or false
local desc,state=gainControl:getJumpDesc(info,unLock)
item:SetChildText(1,desc)
item:SetChildText(6,state)
item:SetChildActive(2,not unLock)
item:SetChildActive(5,unLock)
local showArrow=gainControl:checkShowArrow(jump,active,state)
item:SetChildActive(3,showArrow)
item:SetChildButtonClick(4,function(...)
if _this==nil then return end
if active then
gainControl:handleJump(jump)
else
if not unLock then
gainControl:showTips(errArgs)
else


end
end
end)
end
end
self.gainWayPanel:setActive(isShow and isHasGainWay)
self.listUnline:setActive(isShow and isHasItem)

local name=cfgHelper.get2(cfg_monijybuildconfig_get,jumpbuildid,'name')
local str=FMT.fmt('点击前往 <color=#ca631d>【{0}】</color> 炼制{1}',name,toggleTitle[self.curSelectPage])
self.jumpBtnText:setText(str)
self.jumpBtnPanel:setActive(isHasGainWay or isHasItem)
self:showTips(isShow and not isHasGainWay and not isHasItem)
end

function UIDiscipleLianTiWin:getGainWaySortList()
local list={}
local produce=cfgHelper.get(cfg_danyaogainwayconfig_get,1,"liantiProduce")
list=gainControl:getGainSortList(produce)
return list
end

function UIDiscipleLianTiWin:onJumpBtn()
local goFunc=function()
local jumpParam={type=0,id=501}
local flag=jumpManager:jump(jumpParam)
return flag
end
UIFullCommonControl:showWindow_BackDiscipleMain(goFunc,self.disciple_guid)
end


function UIDiscipleLianTiWin:onQuickUseBtn()

if self.needBroke then
UIManager.info("需要先突破境界")
return
end

local quickData=self.quickData
if quickData then
if quickData.aExp>0 then
local callback=function()
self:doQuickUse()
end

if dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleQuickUseDanYao)then
callback()
else
local tLv=quickData.sLv+quickData.aLv
local sGrade=UIDiscipleModel:getLTGrade(quickData.sLv)
local tGrade=UIDiscipleModel:getLTGrade(tLv)
local sameGrade=sGrade==tGrade
local beforeTx=UIDiscipleModel:getLTNameEx(quickData.sLv)
local afterTx=sameGrade and UIDiscipleModel:getLTNameEx(tLv)or FMT.fmt("{0}圆满",UIDiscipleModel:getLTName(quickData.sLv))
local show_data={
type='UIDialougeLevelUp',
title='提示',
content="是否消耗大量丹药进行炼体快速升级",
beforeTx=beforeTx,
afterTx=afterTx,
oktext='确定',
canceltext='取消',
okcallback=callback,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eDiscipleQuickUseDanYao,flag)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
else
UIManager.info("请先选择境界")
end
end
end

function UIDiscipleLianTiWin:doQuickUse()
local sendList={}
local quickData=self.quickData
local total=0
for i,v in ipairs(quickData.costList)do
total=total+v[2]
end

local tLv=quickData.sLv+quickData.aLv
local sGrade=UIDiscipleModel:getLTGrade(quickData.sLv)
local tGrade=UIDiscipleModel:getLTGrade(tLv)
local sameGrade=sGrade==tGrade
local addShowLv=sameGrade and quickData.aLv or(quickData.aLv-1)
local showLv=sameGrade and tLv or(tLv-1)

local cosume={1,0}
local upBroke={1,0}
for i=0,total,_quickUseUnit do
local sum=math.min(total-i,_quickUseUnit)
local sendUnit={}
sendUnit.list={}

local expSum=0
while sum>0 do
local since=cosume[2]
local index=cosume[1]
local costData=quickData.costList[index]
local least=costData[2]-since
if sum>=least then
cosume[1]=index+1
cosume[2]=0
table.insert(sendUnit.list,{costData[1].id,least})
expSum=expSum+costData[3]*least
else
cosume[2]=cosume[2]+sum
table.insert(sendUnit.list,{costData[1].id,sum})
expSum=expSum+costData[3]*sum
end
sum=sum-least
end

local upNum=0
while expSum>0 do
local index=upBroke[1]
local tLv=quickData.sLv+index-1
local dExp=quickData.dExpList[index]

if index==#quickData.dExpList or dExp==nil then
local curCfg=cfgHelper.get1(cfg_disciplelianticonfig_get,tLv)
if curCfg and curCfg.consume==nil then
dExp=curCfg.exp
else
upBroke[1]=index
upBroke[2]=0
break
end
end

if dExp then
local pass=upBroke[2]
local least=dExp-pass
if expSum>=least then
upNum=upNum+1
upBroke[1]=index+1
upBroke[2]=0
expSum=expSum-least
else
upBroke[2]=pass+expSum
break
end
end

end
sendUnit.broke=upNum

table.insert(sendList,sendUnit)
end







self.waitQuickUse=sendList
local count=#sendList
local reqFunc=function(index)
local unit=sendList[index]
local list=unit.list
local array={}
local temp={}
for i,v in ipairs(list)do
table.insert(array,{self.disciple_guid,v[1],v[2]})
temp[FMT.fmt("{0}_{1}",v[1],v[2])]=true
end
bagProtocolControl.req_dizi_use_item_list(#array,array)
local brokeNum=unit.broke
local brokeArray={}
for i=1,brokeNum do
table.insert(brokeArray,self.disciple_guid)
end
if#brokeArray>0 then
UIDiscipleController:requireDiscipleUpLianTiList(brokeArray)
end
self.waitQuickProto={
items=temp,
broke=brokeNum,
}
end
if count>0 then
local completeFunc=function()
self:closeWindow("UICommonLoadingWinEx")
self:getQuickData()
if self:initQuickPanel()then
self:refreshView(true)

end
self.waitQuickUse=nil
self.waitQuickProto=nil
UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
end
local overFunc=function()
self.waitQuickUse=nil
self.waitQuickProto=nil
UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
self:closeWindow("UICommonLoadingWinEx")
self:onCloseQuick()
UIManager.info("升级处理超时中断")
end
local checkFunc=function()
return self.waitQuickProto==nil
end
local args={
title="正在升级",
count=count,
onSeg=reqFunc,
onComplete=completeFunc,
onOver=overFunc,
onCheck=checkFunc,
effect=20455,
}
self:showWindow("UICommonLoadingWinEx",args)
UIDiscipleController:setSkipUpdataDiscipleAutoBroke(self.disciple_guid)



end
end





function UIDiscipleLianTiWin:onQuickBtn()

if self.needBroke then
UIManager.info("需要先突破境界")
return
end

if self.quickGoods==nil then
self:getGoodList()
end

local canAddMax=self:getGoodListCanAddMax()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltexp=netData.liantiexp
local ltlv=netData.liantilv
local nxltexp=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'exp')
local deltaExp=nxltexp-ltexp
if canAddMax<deltaExp then
UIManager.info("当前丹药不足以提升一级")
return
end

self.quickPanel:setActive(true)
self:getQuickData(canAddMax)
self:initQuickPanel()

self:doQuickEnterAnim()
end

function UIDiscipleLianTiWin:doQuickEnterAnim()
self.quickRoot:setChildCanvasGroupAlpha(0)
local cb=function()
if not _this or not _this.isVisible then return end
self.quickLoad=true
self:delayDo(0.3,function()
if not _this or not _this.isVisible then return end
self.quickRoot:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
if self.quickLoad then
self.winlua:SetChildModelAnimationStop(self.quickBg:getID(),eAnimationID.bd_stand,0)
self.quickBg:setChildModelAnimationState(eAnimationID.bd_stand,1)
cb()
else
self.quickBg:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
end
end

function UIDiscipleLianTiWin:onCloseQuick()
self.quickData=nil
self.quickPanel:setActive(false)



self:refreshView(true)
end

function UIDiscipleLianTiWin:getGoodListCanAddMax()
local canAddMax=0
for i,v in ipairs(self.quickGoods)do
local cfg=v[1]
local exp=v[2]
local num=v[3]
local addexp=v[4]
canAddMax=canAddMax+addexp*num
end
return canAddMax
end

function UIDiscipleLianTiWin:getQuickData(canAddMax)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local data={}
data.sExp=netData.liantiexp
data.sLv=netData.liantilv
data.aExp=0
data.aLv=0
data.oAddLv=0
data.costList={}
data.dExpList={}
data.aExpMax=canAddMax or self:getGoodListCanAddMax()

local lvCfg=cfg_disciplelianticonfig()
local cLvCfg=lvCfg[data.sLv]
local progressMax=cLvCfg.exp
local progressValue=data.sExp
local deltaExp=cLvCfg.exp-data.sExp
table.insert(data.dExpList,deltaExp)

local tempLv=0
local tempExp=data.aExpMax
if tempExp>=deltaExp then
tempLv=1
end
tempExp=tempExp-deltaExp

for i=data.sLv-1,0,-1 do
local tempCfg=lvCfg[i]
if tempCfg.grade==cLvCfg.grade then
progressMax=progressMax+tempCfg.exp
progressValue=progressValue+tempCfg.exp
else
break
end
end

for i=data.sLv+1,#lvCfg do
local tempCfg=lvCfg[i]
if tempCfg.exp>0 and tempCfg.grade==cLvCfg.grade then
progressMax=progressMax+tempCfg.exp
table.insert(data.dExpList,tempCfg.exp)
if tempExp>=tempCfg.exp then
tempLv=tempLv+1
end
tempExp=tempExp-tempCfg.exp
else
break
end
end
data.progressMax=progressMax
data.progressValue=progressValue
data.aLvMax=tempLv

self.quickData=data
end

function UIDiscipleLianTiWin:initQuickPanel()
local data=self.quickData

if UIDiscipleModel:checkDiscipleLTNeedBroke(self.disciple_guid)then
self:onCloseQuick()
return false
end

if data.aLvMax==0 then
self:onCloseQuick()
UIManager.info("剩余当前丹药不足以提升一级")
return false
end



local valueY=math.floor(data.progressValue/data.progressMax*10000)
local valueG=math.floor((data.progressValue+data.aExp)/data.progressMax*10000)
self.quickProgressBarYellow:setProgressValue(valueY,10000)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
local curStr=data.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",data.progressValue+data.aExp)or data.progressValue
local str=FMT.fmt("{0}/{1}",curStr,data.progressMax)
self.quickProgressBarYellow:setChildProgressText(str)

local full=UIDiscipleModel.checkLTFull(data.sLv)
self.quickBroke:setActive(self.needBroke or full)
self.quickUseBtn:setActive(not self.needBroke and not full)
self.quickResetBtn:setActive(not self.needBroke and not full)
self.quickSlider:setActive(not self.needBroke and not full)
self.quickCostOther:setActive(not self.needBroke and not full)

self.quickCostView:setActive(false)

if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
if not self.needBroke and not full then
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end


self.quickCostList:setChildLayoutGroupCreateItems(0)
self.quickCostList:setChildAnchoredPos(0,0)

if not self.needBroke and not full then
local gray=#data.costList<=0
self.quickUseBtn:setChildGraphicGray(gray)
self.quickResetBtn:setChildGraphicGray(gray)
self.quickBegin:setText(UIDiscipleModel:getLTNameEx(data.sLv))


self.quickEnd:setText("????")

self.quickSlider:setChildSliderInit(data.aLv,0,data.aLvMax,function(value)
self:onQuickSliderValueChange(value)
end)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
else
self.quickBroke:setText(full and"已满级"or"需要突破境界")
end

return true
end

function UIDiscipleLianTiWin:onQuickSliderValueChange(value)
if self.quickSliderValue==value and not self.quickSliderChange then return end
self.quickSliderValue=value
self.quickSliderChange=nil

if self.quickSliderStop then
self.quickSliderStop=nil
return
end

local data=self.quickData
data.oAddLv=data.aLv
data.aLv=value
local oAddExp=data.aExp
data.aExp=0
local temp=0
for i=1,value do
local dExp=data.dExpList[i]
temp=temp+dExp
end
table.clear(data.costList)
for i,v in ipairs(self.quickGoods)do
local cfg=v[1]
local exp=v[2]
local num=v[3]
local addExp=v[4]
local total=addExp*num
local sort={
cfg.stage or 0,
cfg.color,
-cfg.id,
}
if temp>=total then
table.insert(data.costList,{cfg,num,addExp,sort})
temp=temp-total
data.aExp=data.aExp+total
else
local count=math.ceil(temp/addExp)
table.insert(data.costList,{cfg,count,addExp,sort})
total=count*addExp
temp=temp-total
data.aExp=data.aExp+total
break
end
end

table.sort(data.costList,function(a,b)
local sortA=a[4]
local sortB=b[4]
for i=1,3 do
local tempA=sortA[i]
local tempB=sortB[i]
if tempA~=tempB then
return tempA>tempB
end
end
return true
end)

local haveAdd=value>0


self.quickCostView:setActive(haveAdd)

if oAddExp<=0 and data.aExp>0 then
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
elseif oAddExp>0 and data.aExp<=0 then
if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end

self.quickUseBtn:setChildGraphicGray(not haveAdd)
self.quickResetBtn:setChildGraphicGray(not haveAdd)
local endStr="????"
if haveAdd then
local tLv=data.sLv+data.aLv
local sGrade=UIDiscipleModel:getLTGrade(data.sLv)
local tGrade=UIDiscipleModel:getLTGrade(tLv)
if sGrade~=tGrade then
endStr=FMT.fmt("{0}圆满",UIDiscipleModel:getLTName(data.sLv))
else
endStr=UIDiscipleModel:getLTNameEx(tLv)
end
local costCnt=#data.costList
self.quickCostList:setChildLayoutGroupCreateItems(costCnt,function(index)
self:initQuickCostItem(index)
end)

end
self.quickEnd:setText(endStr)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
local valueG=math.floor((data.progressValue+data.aExp)/data.progressMax*10000)
local curStr=data.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",data.progressValue+data.aExp)or data.progressValue
local str=FMT.fmt("{0}/{1}",curStr,data.progressMax)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
self.quickProgressBarYellow:setChildProgressText(str)


end

function UIDiscipleLianTiWin:initQuickCostItem(index)
local quickData=self.quickData
local item=self.quickCostList:getChildLayoutGroupGridItem(index-1)
local data=quickData.costList[index]
local cfg=data[1]
local num=data[2]
local conf={itemid=cfg.id,itemcount=num,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)



item:SetChildLongPress(1,0,function(id)
self:onClickQuickCostItemDeletePressCallback(index)
end,function()
self:onClickQuickCostItemDeletePressFinish()
end)
end

function UIDiscipleLianTiWin:onClickQuickCostItemDeletePressCallback(index)
local num=1
if self.quickCostItemDeletePress~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.quickCostItemDeletePress
if lerp>=10 then
num=100
elseif lerp>=6 then
num=50
elseif lerp>=3 then

num=10
elseif lerp>=2 then

num=5
end
else
self.quickCostItemDeletePress=Time.realtimeSinceStartup
end
self:onClickQuickCostItemDelete(index,num)
end

function UIDiscipleLianTiWin:onClickQuickCostItemDeletePressFinish()
self.quickCostItemDeletePress=nil
end

function UIDiscipleLianTiWin:onClickQuickCostItemDelete(index,minus)
local quickData=self.quickData
local data=quickData.costList[index]
local num=data[2]
num=math.max(num-minus,0)
local _num=data[2]-num
data[2]=num
local tempExp=quickData.aExp-data[3]*_num
local tempLv=0
local oldLv=quickData.aLv
local oAddExp=quickData.aExp
quickData.aExp=tempExp
for i,v in ipairs(quickData.dExpList)do
if tempExp>=v then
tempLv=i
tempExp=tempExp-v
else
break
end
end
quickData.oAddLv=quickData.aLv
quickData.aLv=tempLv

if num<=0 then
table.remove(quickData.costList,index)
self.quickCostList:setChildLayoutGroupCreateItems(#quickData.costList,function(index)
self:initQuickCostItem(index)
end)
else
local item=self.quickCostList:getChildLayoutGroupGridItem(index-1)
local prop={}
prop[PropIndex(DataPropKey.eWidgetText,3)]=tostring(num)
item:SetChildPropData(0,prop)
end

local costCnt=#quickData.costList
local haveCost=costCnt>0
self.quickCostView:setActive(haveCost)

if oAddExp<=0 and quickData.aExp>0 then
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
elseif oAddExp>0 and quickData.aExp<=0 then
if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end



self.quickUseBtn:setChildGraphicGray(not haveCost)
self.quickResetBtn:setChildGraphicGray(not haveCost)




if oldLv~=tempLv then
local tLv=quickData.sLv+quickData.aLv
local sGrade=cfgHelper.get2(cfg_disciplelianticonfig_get,quickData.sLv,'grade')
local tGrade=cfgHelper.get2(cfg_disciplelianticonfig_get,tLv,'grade')
local endStr="????"
if haveCost then
if sGrade~=tGrade then
endStr=FMT.fmt("{0}圆满",UIDiscipleModel:getLTName(quickData.sLv))
else
endStr=UIDiscipleModel:getLTNameEx(tLv)
end
end
self.quickEnd:setText(endStr)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
self.quickSliderStop=true
self.quickSliderChange=true
self.quickSlider:setChildSliderValue(quickData.aLv)
end

local valueG=math.floor((quickData.progressValue+quickData.aExp)/quickData.progressMax*10000)
local curStr=quickData.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",quickData.progressValue+quickData.aExp)or quickData.progressValue
local str=FMT.fmt("{0}/{1}",curStr,quickData.progressMax)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
self.quickProgressBarYellow:setChildProgressText(str)


end

function UIDiscipleLianTiWin:onQuickAddBtn()
local curSlinder=self.quickSliderValue or 0
local data=self.quickData
if curSlinder<data.aLvMax then
self.quickSlider:setChildSliderValue(curSlinder+1)
end
end

function UIDiscipleLianTiWin:onQuickSubBtn()
local curSlinder=self.quickSliderValue or 0
if curSlinder>0 then
self.quickSlider:setChildSliderValue(curSlinder-1)
elseif#self.quickData.costList>0 then
self.quickSliderValue=nil
self.quickSlider:setChildSliderValue(0)
end
end

function UIDiscipleLianTiWin:refreshLTQuick()
local quickData=self.quickData

local tLv=quickData.sLv+quickData.aLv
local tFull=UIDiscipleModel.checkLTFull(tLv)
local sGrade=UIDiscipleModel:getLTGrade(quickData.sLv)
local tGrade=UIDiscipleModel:getLTGrade(tLv)
local sameGrade=sGrade==tGrade
local addShowLv=sameGrade and quickData.aLv or(quickData.aLv-1)
local showLv=addShowLv+quickData.sLv

local n,p,pN=UIDiscipleModel:getLTNameX(showLv)
self.ltLvNameText:setText(FMT.fmt('{0}{1}',n,pN))

local layer_str=p~=nil and FMT.fmt('{0}层',p)or''
self.ltLvNameText2:setText(layer_str)

local exp_str="已满级"
local exp_progress=1
local curExp=quickData.sExp
if not tFull then
local maxExp=quickData.sExp+quickData.dExpList[1]
if quickData.aExp>0 then
if quickData.aLv>0 then
if sameGrade then
local temp=quickData.aExp
for i=1,quickData.aLv do
temp=temp-quickData.dExpList[i]
end
curExp=temp
maxExp=cfgHelper.get2(cfg_disciplelianticonfig_get,tLv,"exp")
else
local tempExp=cfgHelper.get2(cfg_disciplelianticonfig_get,showLv,"exp")
curExp=tempExp
maxExp=tempExp
end
else
curExp=curExp+quickData.aExp
end
end
curExp=math.min(curExp,maxExp)
exp_str=FMT.fmt("{0}/{1}",curExp,maxExp)
exp_progress=curExp/maxExp
end
self.ltLvNameText3:setText(exp_str)
local dLv=quickData.aLv-quickData.oAddLv
helper.playProgressAnim(self.ltProgress,exp_progress,dLv,nil,nil,nil,1)


local before={quickData.sLv,quickData.sExp}
local after={showLv,curExp}
local attrlist=self:getLerpAttrListEx(self.disciple_guid,tFull,before,after)
local c=#attrlist
self.attrGrid:setChildLayoutGroupCreateItems(c)
local attrGridList=self.attrGrid:getChildLayoutGroupGridList()

for i=1,c do
local item=attrGridList[i-1]
local attr=attrlist[i]
local show=attr~=nil
item:SetChildActive(0,show)
if show then
local attrID=attr[1]
local attrValue=attr[2]
local addValue=attr[3]
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrID,'attrname')
item:SetChildText(1,attrname..'：')
item:SetChildText(2,helper.getAttributeStr1(attrID,attrValue))
local isadd=addValue>0
item:SetChildActive(3,isadd)
if isadd then
item:SetChildText(4,addValue)
end
end
end

self:refreshBrokePanel()
end

function UIDiscipleLianTiWin:checkWaitQuickProto()
if self.waitQuickProto and next(self.waitQuickProto.items)==nil and self.waitQuickProto.broke<=0 then
self.waitQuickProto=nil
if not self.waitQuickUse then











UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
end
end

end

function UIDiscipleLianTiWin:onQuickResetBtn()
if self.quickData and self.quickData.aExp>0 then
self:getQuickData()
self:initQuickPanel()
end
end

function UIDiscipleLianTiWin:onLowGradeDyPriorityToggleChanged(name,isOn,data)
self.lowGradeDanYaoPriority=isOn

if self.quickData then
self:getGoodList()
self:getQuickData()
self:initQuickPanel()
end
end









def_class("UIDiscipleJingJieWin",UIWindowBase)









function UIDiscipleJingJieWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.backEffect=UIObject.get(self,1)
self.backEffect2=UIObject.get(self,2)
self.brokeBtn=UIButton.get(self,3)
self.brokePanel=UIObject.get(self,4)
self.closeQuick=UIButton.get(self,5)
self.descSatiety=UIText.get(self,6)
self.descText=UIText.get(self,7)
self.descText1=UIText.get(self,8)
self.descText2=UIText.get(self,9)
self.djLimit=UIObject.get(self,10)
self.djLimitText=UIObject.get(self,11)
self.fabaoRoot=UIObject.get(self,12)
self.fbBtn=UIButton.get(self,13)
self.fbeffect=UIObject.get(self,14)
self.fbicon=UIObject.get(self,15)
self.fbiconbg=UIImage.get(self,16)
self.filterSatietyBtn=UIButton.get(self,17)
self.filterSatietySelect=UIObject.get(self,18)
self.gainWayList1=UIObject.get(self,19)
self.gainWayList2=UIObject.get(self,20)
self.gainWayPanel1=UIObject.get(self,21)
self.gainWayPanel2=UIObject.get(self,22)
self.gainWayTips1=UIText.get(self,23)
self.gainWayTips2=UIText.get(self,24)
self.goodlist1=UIObject.get(self,25)
self.goodlist2=UIObject.get(self,26)
self.haveOpenQuick=UIObject.get(self,27)
self.jjLvNameText=UIText.get(self,28)
self.jjLvNameText2=UIText.get(self,29)
self.jjLvNameText3=UIText.get(self,30)
self.jjPointsGrid=UIObject.get(self,31)
self.jjProgress=UIImage.get(self,32)
self.jjProgressBack=UIImage.get(self,33)
self.jumpBtn=UIButton.get(self,34)
self.jumpBtnPanel=UIObject.get(self,35)
self.jumpBtnText=UIText.get(self,36)
self.listUnline1=UIObject.get(self,37)
self.listUnline2=UIObject.get(self,38)
self.lowGradeDanYaoPriorityToggle=UIToggleButton.get(self,39)
self.notOpenQuick=UIObject.get(self,40)
self.questionBtn=UIButton.get(self,41)
self.questionBtn3=UIButton.get(self,42)
self.quickAddBtn=UIButton.get(self,43)
self.quickArrow=UIObject.get(self,44)
self.quickBegin=UIText.get(self,45)
self.quickBg=UIObject.get(self,46)
self.quickBroke=UIText.get(self,47)
self.quickBtn=UIButton.get(self,48)
self.quickCostEmpty=UIObject.get(self,49)
self.quickCostList=UIObject.get(self,50)
self.quickCostOther=UIObject.get(self,51)
self.quickCostView=UIObject.get(self,52)
self.quickEnd=UIText.get(self,53)
self.quickPanel=UIObject.get(self,54)
self.quickProgressBarGreen=UIProgress.get(self,55)
self.quickProgressBarYellow=UIProgress.get(self,56)
self.quickResetBtn=UIButton.get(self,57)
self.quickRoot=UIObject.get(self,58)
self.quickSlider=UIObject.get(self,59)
self.quickSliderGroup=UIObject.get(self,60)
self.quickSliderHandle=UIObject.get(self,61)
self.quickSubBtn=UIButton.get(self,62)
self.quickUseBtn=UIButton.get(self,63)
self.satietyBottom=UIObject.get(self,64)
self.satietyTips=UIText.get(self,65)
self.talkObj=UIObject.get(self,66)
self.tipsText=UIText.get(self,67)
self.toggle1=UIToggleButton.get(self,68)
self.toggle2=UIToggleButton.get(self,69)
self.toggleImage1=UIImage.get(self,70)
self.toggleImage2=UIImage.get(self,71)
self.toggleTxt1=UIText.get(self,72)
self.toggleTxt2=UIText.get(self,73)
self.wxgBtn=UIButton.get(self,74)
self.wxgreddot=UIObject.get(self,75)
self.xianmoDaoHeng=UIText.get(self,76)
self.xianmoIcon=UIImage.get(self,77)
self.xianmoReddot=UIObject.get(self,78)
self.xianmoSkillPanel=UIObject.get(self,79)
self.xianmoXinFaBtn=UIButton.get(self,80)
self.xmSkill_1=UIObject.get(self,81)
self.xmSkill_2=UIObject.get(self,82)
self.xmSkill_3=UIObject.get(self,83)
self.yyPauseTxt=UIText.get(self,84)
self.yyTxt=UIText.get(self,85)

self.brokeBtn:setButtonClick(function()self:onBrokeBtn()end)

self.closeQuick:setButtonClick(function()self:onCloseQuick()end)

self.fbBtn:setButtonClick(function()self:onFbBtn()end)

self.filterSatietyBtn:setButtonClick(function()self:onFilterSatietyBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)

self.questionBtn3:setButtonClick(function()self:onQuestionBtn3()end)

self.quickAddBtn:setButtonClick(function()self:onQuickAddBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.quickResetBtn:setButtonClick(function()self:onQuickResetBtn()end)

self.quickSubBtn:setButtonClick(function()self:onQuickSubBtn()end)

self.quickUseBtn:setButtonClick(function()self:onQuickUseBtn()end)

self.wxgBtn:setButtonClick(function()self:onWxgBtn()end)

self.xianmoXinFaBtn:setButtonClick(function()self:onXianmoXinFaBtn()end)
self.xmSkill={
self.xmSkill_1,
self.xmSkill_2,
self.xmSkill_3,
}



end


function UIDiscipleJingJieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.backEffect2);self.backEffect2=nil;
_UIObject_release(self.brokeBtn);self.brokeBtn=nil;
_UIObject_release(self.brokePanel);self.brokePanel=nil;
_UIObject_release(self.closeQuick);self.closeQuick=nil;
_UIObject_release(self.descSatiety);self.descSatiety=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.descText2);self.descText2=nil;
_UIObject_release(self.djLimit);self.djLimit=nil;
_UIObject_release(self.djLimitText);self.djLimitText=nil;
_UIObject_release(self.fabaoRoot);self.fabaoRoot=nil;
_UIObject_release(self.fbBtn);self.fbBtn=nil;
_UIObject_release(self.fbeffect);self.fbeffect=nil;
_UIObject_release(self.fbicon);self.fbicon=nil;
_UIObject_release(self.fbiconbg);self.fbiconbg=nil;
_UIObject_release(self.filterSatietyBtn);self.filterSatietyBtn=nil;
_UIObject_release(self.filterSatietySelect);self.filterSatietySelect=nil;
_UIObject_release(self.gainWayList1);self.gainWayList1=nil;
_UIObject_release(self.gainWayList2);self.gainWayList2=nil;
_UIObject_release(self.gainWayPanel1);self.gainWayPanel1=nil;
_UIObject_release(self.gainWayPanel2);self.gainWayPanel2=nil;
_UIObject_release(self.gainWayTips1);self.gainWayTips1=nil;
_UIObject_release(self.gainWayTips2);self.gainWayTips2=nil;
_UIObject_release(self.goodlist1);self.goodlist1=nil;
_UIObject_release(self.goodlist2);self.goodlist2=nil;
_UIObject_release(self.haveOpenQuick);self.haveOpenQuick=nil;
_UIObject_release(self.jjLvNameText);self.jjLvNameText=nil;
_UIObject_release(self.jjLvNameText2);self.jjLvNameText2=nil;
_UIObject_release(self.jjLvNameText3);self.jjLvNameText3=nil;
_UIObject_release(self.jjPointsGrid);self.jjPointsGrid=nil;
_UIObject_release(self.jjProgress);self.jjProgress=nil;
_UIObject_release(self.jjProgressBack);self.jjProgressBack=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.jumpBtnPanel);self.jumpBtnPanel=nil;
_UIObject_release(self.jumpBtnText);self.jumpBtnText=nil;
_UIObject_release(self.listUnline1);self.listUnline1=nil;
_UIObject_release(self.listUnline2);self.listUnline2=nil;
_UIObject_release(self.lowGradeDanYaoPriorityToggle);self.lowGradeDanYaoPriorityToggle=nil;
_UIObject_release(self.notOpenQuick);self.notOpenQuick=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.questionBtn3);self.questionBtn3=nil;
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
_UIObject_release(self.satietyBottom);self.satietyBottom=nil;
_UIObject_release(self.satietyTips);self.satietyTips=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.toggle1);self.toggle1=nil;
_UIObject_release(self.toggle2);self.toggle2=nil;
_UIObject_release(self.toggleImage1);self.toggleImage1=nil;
_UIObject_release(self.toggleImage2);self.toggleImage2=nil;
_UIObject_release(self.toggleTxt1);self.toggleTxt1=nil;
_UIObject_release(self.toggleTxt2);self.toggleTxt2=nil;
_UIObject_release(self.wxgBtn);self.wxgBtn=nil;
_UIObject_release(self.wxgreddot);self.wxgreddot=nil;
_UIObject_release(self.xianmoDaoHeng);self.xianmoDaoHeng=nil;
_UIObject_release(self.xianmoIcon);self.xianmoIcon=nil;
_UIObject_release(self.xianmoReddot);self.xianmoReddot=nil;
_UIObject_release(self.xianmoSkillPanel);self.xianmoSkillPanel=nil;
_UIObject_release(self.xianmoXinFaBtn);self.xianmoXinFaBtn=nil;
_UIObject_release(self.xmSkill_1);self.xmSkill_1=nil;
_UIObject_release(self.xmSkill_2);self.xmSkill_2=nil;
_UIObject_release(self.xmSkill_3);self.xmSkill_3=nil;
_UIObject_release(self.yyPauseTxt);self.yyPauseTxt=nil;
_UIObject_release(self.yyTxt);self.yyTxt=nil;
self.xmSkill=nil;
end
















local angelLookup={
[1]={90},
[2]={150,30},
[3]={150,90,30},
[4]={150,120,60,30},
[5]={150,120,90,60,30},
[6]={180,150,120,60,30,0},
[7]={180,150,120,90,60,30,0},
[8]={180,155,130,105,75,50,25,0},
[9]={180,157.5,135,112.5,90,67.5,45,22.5,0},
[10]={180,160,140,120,100,80,60,40,20,0},
}
local radius=188
local _red=math.pi/180
local _quickUseUnit=20000
local list1Change
local list2Change
local _this=nil
local toggleTitle=
{
'修为','突破'
}
local jumpbuildid=6
local fullfloorTips='境界层级已满'
local tipsShowTime=5

local jjProgressImg=
{
[1]={{"image_dizijjrx_1","image_dizijjrx_2"},},
[2]={{"image_xianrenjindu_1","image_xianrenjindu_2"},},
[3]={{"image_mojindu_1","image_mojindu_2"},},
[4]={{"image_xianmoweixuan_1","image_xianmoweixuan_2"},},
}

local jjActiveEffect=
{
20632,
20631,
}

local jjChangeEffect=
{
20633,
20634,
20635,
}


local _excludedNingQiDanIds={
11001,
11002,
11003,
11004,
11005
}

local _colorBg=fabaoConfig.bmQualityBg

function UIDiscipleJingJieWin:onLoaded(...)
_this=self
self:bindComponents()
self.toggle1:setToggleChange(function(name,isOn)
self:onToggleChange(1,isOn)
end)
self.toggle2:setToggleChange(function(name,isOn)
self:onToggleChange(2,isOn)
end)
self.lowGradeDanYaoPriorityToggle:setToggleChange(function(...)
self:onLowGradeDyPriorityToggleChanged(...)
end)
list1Change=true
list2Change=true
self.goodlist1:setChildScrollViewInit(0.5,true,nil,nil)
self.goodlist2:setChildScrollViewInit(0.5,true,nil,nil)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:listenNotify(notifyConfig.onDiscipleSatietyChange,self.onDiscipleSatietyChange)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

self:addProNotify(1,18,self.on_1_18)

self.toggleTxt1:setText(toggleTitle[1])
self.toggleTxt2:setText(toggleTitle[2])

if self.throwExpTime==nil then
self.throwExpTime=Time.realtimeSinceStartup
end
self:addNotify(notifyConfig.onFabaoAbsorbExpChange,function(...)
self:onFabaoAbsorbExpChange(...)
end)

self.quickJJfilter0Satiety=false
self.m_cav=self:getChildCanvas(-1)
end


function UIDiscipleJingJieWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(0,false)
UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:removelistener(notifyConfig.onDiscipleSatietyChange,self.onDiscipleSatietyChange)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end

if self.backFunc then
self.backFunc()
end
end


function UIDiscipleJingJieWin:onHide()

end

function UIDiscipleJingJieWin.on_1_18(len,array)
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

function UIDiscipleJingJieWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
local change=false
if _this.curSelectPage==1 then
local isNew=_this.items_lookup_1_new[itemid]
local change_idx=_this.items_lookup_1[itemid]
local check=isNew==true or change_idx~=nil
change=check

if isNew==true or(check and newcount==0)then
list1Change=true
end

if change then
if not list1Change and change_idx~=nil then
local showEffect=oldcount>newcount and _this.quickData==nil
_this:refreshToggle1ListItem(nil,change_idx,showEffect)

local idx=_this.quickGoods_lookup[itemid]
if idx then
local data=_this.quickGoods[idx]
data[3]=bagModel.getItemCountById(itemid)
end
end
list1Change=true
_this:refreshToggle1ListView()
end
else
local isNew=_this.items_lookup_2_new[itemid]
local change_idx=_this.items_lookup_2[itemid]
local check=isNew==true or change_idx~=nil
change=check

if isNew==true or(check and newcount==0)then
list2Change=true
end

if change then
if not list2Change and change_idx~=nil then
local showEffect=oldcount>newcount
_this:refreshToggle2ListItem(nil,change_idx,showEffect)
end
_this:refreshToggle2ListView()
end
end







end

function UIDiscipleJingJieWin.onDiscipleJJChange(disguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
if _this.waitQuickProto==nil then
_this:refreshView()
elseif old_jjlv~=jingjielv then
_this.waitQuickProto.auto=false
_this:checkWaitQuickProto()
end
local oldfloor=UIDiscipleModel:getJJFloor(old_jjlv)
local floor=UIDiscipleModel:getJJFloor(jingjielv)
if oldfloor~=floor then
if _this.curSelectPage==1 then
list1Change=true
_this:refreshToggle1ListView()
else
list2Change=true
_this:refreshToggle2ListView()
end
else
fightUpRemindController:postDiZiFight(disguid,oldFight,newFight)
end
end
end

function UIDiscipleJingJieWin.onDiscipleSatietyChange(disguid,old,cur)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
if _this.quickData and not _this.waitQuickProto then
_this:refreshQuickSatiety()
return
end

local netData=UIDiscipleModel:getDiscipleData(disguid)
if UIDiscipleModel:checkDiscipleSatietyFull(netData)then
if _this.curSelectPage==1 then
list1Change=true
_this:refreshToggle1ListView()
end
end
end
end

function UIDiscipleJingJieWin.onDiscipleJJBroke(disguid,res)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
if _this.quickData==nil then
_this:initTimer()
end
end
end

function UIDiscipleJingJieWin.onShowDiscipleChanged(eType,datas,effectData)
if _this==nil then return end
UIFuncItemUseModel.onShowDiscipleChanged(eType,datas)




local itemid=effectData.itemid
local change=false

if _this.quickData then
return
end

if _this.curSelectPage==1 then
local change_idx=_this.items_lookup_1[itemid]
change=change_idx~=nil
else
local change_idx=_this.items_lookup_2[itemid]
change=change_idx~=nil
end
if change then
local num=effectData.usednum+effectData.freenum
if num>0 then
local args={}
if effectData.freenum>0 then
args={}
local netData=UIDiscipleModel:getDiscipleData(_this.disciple_guid)
local rate1,rate2=dzSpecialityGrowEffectController:getXiuWeiDanYaoNotCostRateLookup(netData)
args.freenum=effectData.freenum
args.freerate=rate2
end
_this:useGoodBack(itemid,effectData.usednum,args)
end
end
end




function UIDiscipleJingJieWin:onShow(argtable,afterOnloaded)
self.progressMove=false
self.jjPointMove=false
self.backEffect:setChildShowEffect(discipleLookup.confgs.jjbackeffectID,true)
self.disciple_guid=argtable.guid
self.backFunc=argtable.backFunc

self.curSelectPage=argtable.selectPage or 1
self:refreshToggleListView()
if self.curSelectPage==1 then
self.toggle1:setToggle(true)
else
self.toggle2:setToggle(true)
end


self.lowGradeDyPriority=false
self.lowGradeDanYaoPriorityToggle:setToggle(self.lowGradeDanYaoPriority)

self:refreshView()
self:freshFaBaoYunYang()

self:initTimer()
self:refreshWxgBtn()
self:refreshXianMoSkill()
end

function UIDiscipleJingJieWin:initTimer()
self:stopTimerByName('refreshTimer')
self.needBroke=self:checkShowBroke()
self:refreshBrokePanel()
if not self.needBroke then
local func=function()
self:progressTimer()
end
self.refreshTimer=self:setTimer(1,0,func)
end
end

function UIDiscipleJingJieWin:refreshBrokePanel()
self.showBroke=self.needBroke and not self.progressMove
self.brokePanel:setActive(self.showBroke)

local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local check,sys,isHide=UIDiscipleModel:checkJJBrokeNeedSystem(jjlv)
if isHide then
self.brokePanel:setActive(false)
return
end
local dzXianMoVoc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
if(not check and self.showBroke)and sys==SYSTEM_DEFINE.eJiuChongTianJieComplete and JiuChongTianJieEnterModel:getOpenTianJieSec()>0 then
self.djLimit:setActive(true)
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
self.djLimitText:setActive(isGuoFu)
self.backEffect:setChildShowEffectEx(discipleLookup.confgs.jjbackeffectID2,self.m_cav[1],self.m_cav[2]+2,true)
else
self.djLimit:setActive(false)
if dzXianMoVoc==1 or dzXianMoVoc==2 then
self.backEffect:setChildAnchoredPosition(Vector2(0,35))
self.backEffect:setChildShowEffect(dzXianMoVoc==1 and 20481 or 20482,true)
elseif WenXinGuanModel:checkDzWXGState(self.disciple_guid)then
self.backEffect:setChildAnchoredPosition(Vector2(0,35))
self.backEffect:setChildShowEffect(20483,true)
else
self.backEffect:setChildAnchoredPosition(Vector2(3,0))
self.backEffect:setChildShowEffect(discipleLookup.confgs.jjbackeffectID,true)
end
end
if self.showBroke and zongmenModel:getLevel()<=16 then
weakGuideController:beginGuide(1292)
end
end

function UIDiscipleJingJieWin:refreshWxgBtn()
if not systemModel.isOpen(SYSTEM_DEFINE.eWenXinGuan)then
self.wxgBtn:setActive(false)
return
end

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local level=netData.jingjielv

if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)then
if not systemModel.isOpen(SYSTEM_DEFINE.eWenXinGuan)or level<90 then return end
else
if level<90 then return end
end

local iconName="button_wenxinguanrukou_1"
local abname='ui/windows/wenxinguan/wenxinguan_enter_atlas_pak.ab'
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
local state=WenXinGuanModel:checkDzWXGState(self.disciple_guid)

if xm_voc==0 then
if state then iconName='button_zhuanzhiyulan'end
self.wxgBtn:setCSImageSprite(abname,iconName)
self.wxgBtn:setActive(true)
self:refreshReddot()
self.xianmoXinFaBtn:setActive(false)
else
self.wxgBtn:setActive(false)
self.xianmoXinFaBtn:setActive(true)
self:refreshXianMoReddot()
self.xianmoIcon:setSprite('ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab',xm_voc==1 and'button_xiandaoxiuxing _1'or'button_modaoxiuxing_1')
self:initDaoHengTimer()
end
end

function UIDiscipleJingJieWin:initDaoHengTimer()
self:stopTimerByName('refreshDaoHengTimer')
self:refreshXianMoDaoHeng()
self.discipleDaoHeng=nil
local func=function()
self:refreshXianMoDaoHengTimer()
end
self.refreshDaoHengTimer=self:setTimer(10,0,func)
end

function UIDiscipleJingJieWin:refreshXianMoDaoHengTimer()
local max=UIDiscipleModel:getDiscipleXinFaTotalExp(self.disciple_guid)
local lastDaoHeng=self.discipleDaoHeng
self.discipleDaoHeng=UIDiscipleModel:getDiscipleDaoHeng(self.disciple_guid)
if lastDaoHeng and lastDaoHeng~=self.discipleDaoHeng then
self:refreshXianMoDaoHeng()
local str='道行+1'
commonTipsHelper.addThrowOutAndSliderTips(1,str)
end
local isXianMo=UIDiscipleModel:checkDiscipleXianMoVoc(self.disciple_guid)
if self.discipleDaoHeng>=max or not isXianMo then
self:stopTimerByName('refreshDaoHengTimer')
end
end

function UIDiscipleJingJieWin:refreshXianMoDaoHeng()
self.xianmoDaoHeng:setText(string.format("%d年",UIDiscipleModel:getDiscipleDaoHeng(self.disciple_guid)))
end

function UIDiscipleJingJieWin:refreshXianMoSkill()
local isShow=UIDiscipleModel:checkDiscipleXianMoVoc(self.disciple_guid)
self.xianmoSkillPanel:setActive(isShow)
if isShow then
local skillList=UIDiscipleModel:getDiscipleXianMoSkillList(self.disciple_guid)
for i,v in ipairs(self.xmSkill)do
local widget=v:getWidgetBase()
local skill=skillList[i]
local skillid,level,unlockDaoHeng=skill[1],skill[2],skill[3]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local icon=iconHelper.getSkillIcon(skillCfg.icon)
widget:SetChildIcon(0,icon,false)
widget:SetChildImageExGray(0,level<=0)
widget:SetChildActive(1,level>0)
widget:SetChildText(2,string.format("%d级",level))
widget:SetChildActive(3,level<=0)
widget:SetChildButtonClick(0,function()
local args={
skillLv=level,
changLv=false,
fromCfg=true,
skillDesc=level>0 and string.format("%d级",level)or string.format("道行%d年\n且突破激活",unlockDaoHeng),
skillID=skillid,
dis_guid=self.disciple_guid,
attend=eSkillTipsType.eDZSkill,
item=widget,
pivot=Vector2(0.5,0),
}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end)
end
end
end

function UIDiscipleJingJieWin:progressTimer()
self:refreshJJProgress()

local curTime=Time.realtimeSinceStartup
local lerpTime=curTime-self.throwExpTime
if lerpTime>=5 then
self.throwExpTime=Time.realtimeSinceStartup
if worldController:checkNoticiateBlockOpen()then
local lerpExp=UIDiscipleModel:calculationJJTimeGrow(self.disciple_guid,5)
local str=FMT.fmt('+{0}修为',lerpExp)
commonTipsHelper.addThrowOutAndSliderTips(1,str)
end
end

local show_broke=self:checkShowBroke()
if show_broke then
self:initTimer()
end
end

function UIDiscipleJingJieWin:refreshJJProgress(force)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local refreshPoint=false
local showPointTips=false
local checkLevelUp=false
local showPointEffect=false
local old_jjlv=self.cur_jjlv
local old_jjpoint=self.cur_jjpoint
local jjlv,point,curjjexp,nxjjexp=UIDiscipleModel:getDiscipleJJLevelAndPoint2(self.disciple_guid)

self.cur_jjlv=jjlv
self.cur_jjpoint=point
if old_jjlv==nil then old_jjlv=jjlv end
if old_jjpoint==nil then
old_jjpoint=point
refreshPoint=true
end
if old_jjpoint~=point then
refreshPoint=true
showPointEffect=true
end
if old_jjlv~=jjlv then
refreshPoint=true
checkLevelUp=true
end
showPointTips=old_jjlv==jjlv and point~=old_jjpoint and point>old_jjpoint

local isfull=UIDiscipleModel:checkJJLevelFull(jjlv)
if isfull then
curjjexp=1
nxjjexp=1
else
if curjjexp>nxjjexp then
curjjexp=nxjjexp
end
end
local exp_str=''
if not isfull then
exp_str=FMT.fmt('{0}/{1}',curjjexp,nxjjexp)
else
exp_str='已满级'
end
local rate=curjjexp/nxjjexp
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
helper.playProgressAnim2(progressAnimationType.eCommon,self.jjProgress,rate,jjlv-old_jjlv,bFunc,eFunc,nil,1)
self.jjLvNameText3:setText(exp_str)


if refreshPoint then
if not checkLevelUp then

self:refreshJJPoint(jjlv,point,old_jjpoint,showPointEffect)
else

local old_point_piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,old_jjlv,'average')
local old_showPoint=old_point_piece~=nil

if old_showPoint then

self.jjPointMove=true
self:refreshJJPoint2(old_jjlv)
local func=function()
local point_piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'average')
local showPoint=point_piece~=nil
if showPoint then

self:refreshJJPoint(jjlv,point,0,true)
else

self.jjPointsGrid:setActive(false)
end
self.jjPointMove=false
end
self:delayDo(0.18,func)
else

local point_piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'average')
local showPoint=point_piece~=nil
if showPoint then

self:refreshJJPoint(jjlv,point,0,true)
else

end
end
end
end


if showPointTips then
UIManager.info('点亮星点')
end
end

function UIDiscipleJingJieWin:refreshLeftProgress(isfull,curExp,maxExp,deltaLv)
local exp_str=isfull and'已满级'or FMT.fmt('{0}/{1}',curExp,maxExp)
self.jjLvNameText3:setText(exp_str)

if deltaLv==nil then
self.jjProgress:setChildIconFillAmount(curExp/maxExp)
else
helper.playProgressAnim(self.jjProgress,curExp/maxExp,deltaLv,nil,nil,nil,1)
end
end

function UIDiscipleJingJieWin:refreshLeftPoint(level,point)
local piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,level,'average')
local showPoint=piece~=nil
self.jjPointsGrid:setActive(showPoint)
if showPoint then
local point_num=piece-1
point_num=math.min(point_num,10)
local angellist=angelLookup[point_num]
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
local func=function(index)
local item=self.jjPointsGrid:getChildLayoutGroupGridItem(index-1)
local angel=angellist[index]
local x=radius*math.cos(angel*_red)
local y=radius*math.sin(angel*_red)
item:SetChildAnchoredPosition(-1,Vector2(x,y))
local iconanme
if index>point then
iconanme='image_wusezhuzi_1'
else
local p_lv=math.ceil(index/point_num)
if p_lv==1 then
iconanme='image_lansezhuzi_1'
else
iconanme='image_jinsezhuzi_1'
end
end
item:SetChildCSImageSprite(0,globalABLookup.diciplemain,iconanme)
if xm_voc==1 or xm_voc==2 then
item:SetChildShowEffect(2,xm_voc==1 and 20479 or 20480,index<=point)
end
end
self.jjPointsGrid:setChildLayoutGroupCreateItems(point_num,func)
end
end

function UIDiscipleJingJieWin:onFabaoAbsorbExpChange(itemguid,dzguid,newRate)
if tostring(dzguid)~=tostring(self.disciple_guid)then return end
self:freshFaBaoYunYang()
end

function UIDiscipleJingJieWin:onYunYangChange(dzguid)
if tostring(dzguid)~=tostring(self.disciple_guid)then return end
self:freshFaBaoYunYang()
self:freshXiuweiListView()
end

function UIDiscipleJingJieWin:freshFaBaoYunYang()
local dzguid=self.disciple_guid
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip==nil then
self.fabaoRoot:setActive(false)
return
end
local isDressSelf=benMingFaBaoHelper.isDressSelf(equip)
if not isDressSelf then
self.fabaoRoot:setActive(false)
return
end
self.fabaoRoot:setActive(true)
local isAbsorbExp=benMingFaBaoHelper.isAbsorbExp(dzguid)
local isYunYang=fabaoModel.isYunYang(equip)
local itemCfg=itemsConfig.getConfig(equip.itemid)
self.yyTxt:setActive(isYunYang)
self.yyPauseTxt:setActive(not isYunYang)
self.fbeffect:setChildShowEffect(10264,isYunYang)
self.fbiconbg:setSprite(globalABLookup.global,_colorBg[itemCfg.color])
self.fbicon:setChildIcon(itemsModel.getIconName(equip),true)
end

function UIDiscipleJingJieWin:refreshView(force)
if not force and self.quickData then
self:refreshJJQuick()
return
end
self.jjPointPage=self.jjPointPage or 1
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local str_1=''
local str_2=''
if p~=nil then
str_1=FMT.fmt('{0}{1}',n,pN)
str_2=FMT.fmt('{0}阶',p)
else
str_1=n
end
self.jjLvNameText:setText(str_1)
self.jjLvNameText2:setText(str_2)


self:refreshJJProgress(force)
self:refreshJJProgressSprite(self.jjPointPage)



local isfull=UIDiscipleModel:checkJJLevelFull(jjlv)
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



local getPointImgTab=function(pageIndex,tabIndex)
return jjProgressImg[tabIndex][pageIndex]or jjProgressImg[tabIndex][#jjProgressImg[tabIndex]]
end
function UIDiscipleJingJieWin:refreshJJProgressSprite(pageIndex)
pageIndex=pageIndex or 1
local dzXianMoVoc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
local tab=getPointImgTab(pageIndex,1)
if dzXianMoVoc==1 then
tab=getPointImgTab(pageIndex,2)
elseif dzXianMoVoc==2 then
tab=getPointImgTab(pageIndex,3)
elseif WenXinGuanModel:checkDzWXGState(self.disciple_guid)then
tab=getPointImgTab(pageIndex,4)
end
local iconProgressBack=tab[1]
local iconProgress=tab[2]

self.jjProgressBack:setSprite("ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",iconProgressBack)
self.jjProgress:setSprite("ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",iconProgress)
end

local point_anim_pos=Vector2.New(-1.3,131.8)

function UIDiscipleJingJieWin:refreshJJPoint(jjlv,jjpoint,old_jjpoint,showPointEffect)
local point_piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'average')
local showPoint=point_piece~=nil
self.jjPointsGrid:setActive(showPoint)
if showPoint then
local point_num=point_piece-1
local page_num=1

if point_num>10 then
page_num=math.ceil(point_num/6)
point_num=6
end

local maxPointNum=math.min(point_num,10)
local cur_page=math.floor(jjpoint/maxPointNum)
if jjpoint==point_piece-1 then
cur_page=cur_page-1
end

local old_jjpointtPage=self.jjPointPage
self.jjPointPage=cur_page+1

self:refreshJJProgressSprite(cur_page+1)

local angellist=angelLookup[maxPointNum]
local showEffectPointIndexLookup={}
if showPointEffect then
if jjpoint>old_jjpoint then
for i=old_jjpoint+1,jjpoint do
local j=i%maxPointNum
if j==0 then j=maxPointNum end
showEffectPointIndexLookup[j]=true
end
end
end
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
local func=function(index)
local item=self.jjPointsGrid:getChildLayoutGroupGridItem(index-1)
local pointIdx=index+cur_page*maxPointNum
local angel=angellist[index]
local x=radius*math.cos(angel*_red)
local y=radius*math.sin(angel*_red)


item:SetChildAnchoredPosition(-1,Vector2(x,y))

local iconanme
local effectid
if pointIdx>jjpoint then
iconanme='image_wusezhuzi_1'
else
local p_lv=math.ceil(index/maxPointNum)
if p_lv==1 then
effectid=10126
iconanme='image_lansezhuzi_1'
else
effectid=10127
iconanme='image_jinsezhuzi_1'
end
if xm_voc==1 then
effectid=jjActiveEffect[1]
iconanme='image_wusezhuzi_1'
elseif xm_voc==2 then
effectid=jjActiveEffect[2]
iconanme='image_wusezhuzi_1'
end
end

item:SetChildCSImageSprite(0,globalABLookup.diciplemain,iconanme)
if showEffectPointIndexLookup[pointIdx]==true then
item:SetChildShowEffect(1,effectid,true)

end
if xm_voc==1 or xm_voc==2 then
item:SetChildShowEffect(2,xm_voc==1 and 20479 or 20480,pointIdx<=jjpoint)
end
end
self.jjPointsGrid:setChildLayoutGroupCreateItems(maxPointNum,func)

if self.firstPageFresh and old_jjpointtPage~=self.jjPointPage then
local effectid=jjChangeEffect[1]
if xm_voc==1 then
effectid=jjChangeEffect[2]
elseif xm_voc==2 then
effectid=jjChangeEffect[3]
end
self.backEffect2:setChildShowEffect(effectid,true)

local points=self.jjPointsGrid:getChildLayoutGroupGridList()
for i=1,points.Count do
local item=points[i-1]

local angel=angellist[i]
local x=radius*math.cos(angel*_red)
local y=radius*math.sin(angel*_red)
local seq=Lua.SequenceProxy.New()
local tweener=item:SetChildDOAnchorPos(-1,point_anim_pos,1.2)
seq:Append(tweener)
seq:Append(item:SetChildDOScale(-1,0,0))
seq:AppendInterval(0.15)
tweener=item:SetChildDOAnchorPos(-1,Vector3.New(x,y+10,0),0)
seq:Append(item:SetChildDOScale(-1,1,0))
seq:Append(tweener)
tweener=item:SetChildDOAnchorPosY(-1,y,0.3,nil)
seq:Append(tweener)
end
end
self.firstPageFresh=true
end
end


function UIDiscipleJingJieWin:refreshJJPoint2(jjlv)
self.jjPointsGrid:setActive(true)
local old_point_piece=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'average')
local old_point_num=old_point_piece-1

local page_num=1
if old_point_num>10 then
page_num=math.ceil(old_point_num/6)
old_point_num=6
end

local old_maxPointNum=math.min(old_point_num,10)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
local grid=self.jjPointsGrid:getChildLayoutGroupGridList()
for i=1,grid.Count do
local item=grid[i-1]
local iconanme
local effectid
local p_lv=math.ceil(i/old_maxPointNum)
if p_lv==1 then
effectid=10126
iconanme='image_lansezhuzi_1'
else
effectid=10127
iconanme='image_jinsezhuzi_1'
end
if xm_voc==1 then
effectid=jjActiveEffect[1]
iconanme='image_wusezhuzi_1'
elseif xm_voc==2 then
effectid=jjActiveEffect[2]
iconanme='image_wusezhuzi_1'
end
item:SetChildCSImageSprite(0,globalABLookup.diciplemain,iconanme)
item:SetChildShowEffect(1,effectid,true)
if xm_voc==1 or xm_voc==2 then
item:SetChildShowEffect(2,xm_voc==1 and 20479 or 20480,true)
end
end
end



function UIDiscipleJingJieWin:getLerpAttrListEx(guid,isfull,before,after)
local result={}
local temp1=UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,false,before[1],before[2])
local temp2=temp1
if not isfull or before[1]~=after[1]or before[2]~=after[2]then
temp2=UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,false,after[1],after[2])
end
for k,v in pairsBySortKey(temp1)do
result[#result+1]={k,v,temp2[k]-v}
end
return result
end

function UIDiscipleJingJieWin:getLerpAttrList(guid,isfull)
local temp1=UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,false)
local result={}
local temp2
if isfull then
temp2=temp1
else
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local ex_rate=1

temp2={}
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local job=imageInfo.job
local jjlv,point=UIDiscipleModel:getDiscipleJJLevelAndPoint(guid)
point=point+1
local jjcfg=cfg_disciplejingjieconfig_get(jjlv)
if jjcfg.attr[job]then
if jjcfg.expattr then
local expattrLookup={}
local expattr=jjcfg.expattr[job]
if expattr then
for i,v in ipairs(expattr)do
expattrLookup[v[1]]=v[2]
end
end
local add
for i,v in ipairs(jjcfg.attr[job])do
temp2[v[1]]=temp2[v[1]]or 0
add=expattrLookup[v[1]]or 0
temp2[v[1]]=temp2[v[1]]+math.floor(v[2]*ex_rate)+math.floor(add*point*ex_rate)
end
else
local next_jjcfg=cfg_disciplejingjieconfig_get(jjlv+1)
if next_jjcfg.attr[job]then
for i,v in ipairs(next_jjcfg.attr[job])do
temp2[v[1]]=temp2[v[1]]or 0
temp2[v[1]]=temp2[v[1]]+math.floor(v[2]*ex_rate)
end
end
end
end
end
for k,v in pairsBySortKey(temp1)do
result[#result+1]={k,v,temp2[k]-v}
end
return result
end

function UIDiscipleJingJieWin:onToggleChange(idx,isOn)
if isOn==true then
if self.curSelectPage==idx then
return
end
self.curSelectPage=idx
self:refreshToggleListView()
end
end

function UIDiscipleJingJieWin:refreshToggleListView()
if self.curSelectPage==1 then
self.toggleImage1:setSprite(globalABLookup.global,'button_xiaoyeqian_1')
self.toggleImage2:setSprite(globalABLookup.global,'button_xiaoyeqian_2')
self.goodlist1:setActive(true)
self.goodlist2:setActive(false)
self:refreshToggle1ListView()
else
self.toggleImage1:setSprite(globalABLookup.global,'button_xiaoyeqian_2')
self.toggleImage2:setSprite(globalABLookup.global,'button_xiaoyeqian_1')
self.goodlist1:setActive(false)
self.goodlist2:setActive(true)
self:refreshToggle2ListView()
end

end

function UIDiscipleJingJieWin:freshXiuweiListView()
self:getGoodDataList1()
local dataNum=#self.goodDataList1
self.goodlist1:setChildScrollViewCreateGrids(dataNum,1)

local goodGrid=self.goodlist1:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshListItemXiuwei(item,i)
end
end

function UIDiscipleJingJieWin:refreshListItemXiuwei(item,index)
if item==nil then
item=self.goodlist1:getChildScrollViewItemWidget(index-1)
end
local data=self.goodDataList1[index]
local cfg=data[1]
local itemID=cfg.id


local funcparam=cfg.funcparam
local curexp=funcparam.exp
local addexp=UIDiscipleModel:calculationJJMedicineGrow(self.disciple_guid,curexp,itemID)
local desc_str=FMT.fmt('修为+{0}',addexp)
if funcparam.attr6~=nil then
desc_str=FMT.fmt('{0}\n{1}+{2}',desc_str,UIDiscipleModel:getDiscipleBaseAttrName(funcparam.attr6[1][1]),funcparam.attr6[1][2])
end
item:SetChildText(2,desc_str)
end

function UIDiscipleJingJieWin:refreshToggle1ListView()
local hasCanUse
if list1Change then
list1Change=false
hasCanUse=false
self:getGoodDataList1()
local dataNum=#self.goodDataList1
self.goodlist1:setChildScrollViewCreateGrids(dataNum,1)

local goodGrid=self.goodlist1:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshToggle1ListItem(item,i)
local data=self.goodDataList1[i]
local fix=data[2]
if fix then
hasCanUse=true
end
end
end





local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
self.curSatiety=UIDiscipleModel:getDiscipleJJSatiety(self.disciple_guid)
local cur=self.curSatiety
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local max1,max2=UIDiscipleModel:getDZMaxSatiety(netData)

self.maxSatiety=max2
self.maxSatietyEx=max1
local fullSatiety=false
if cur>=max2 then
cur=max2
fullSatiety=true
end
local rate=math.floor((cur/max1)*100)
local s=tostring(rate)
if fullSatiety then
s=FMT.fmt('<color=#C82C2C>{0}%</color>',s)
else
s=FMT.fmt('{0}%',s)
end
local str=FMT.fmt('<color=#7d3b17>修为丹饱食度：</color>{0}',s)

local openQuick=systemModel.isOpen(SYSTEM_DEFINE.eQuickLevelUp)
self.notOpenQuick:setActive(not openQuick)
self.haveOpenQuick:setActive(openQuick)
if openQuick then
self.descSatiety:setText(str)
else
self.descText:setText(str)
self.descText1:setText('')
self.descText2:setText('')
end


if hasCanUse~=nil then
self:refreshGainWayPanel(1,not hasCanUse)
else
self:refreshGainWayPanel(1,self.list1GainWayShow or false)
end
end

function UIDiscipleJingJieWin:refreshToggle1ListItem(item,index,showEffect)
if item==nil then
item=self.goodlist1:getChildScrollViewItemWidget(index-1)
end
local data=self.goodDataList1[index]
local cfg=data[1]
local itemID=cfg.id
local itemNum=bagModel.getItemCountById(itemID)
local conf={itemid=itemID,itemcount=itemNum,showname=false,showCountBG=true,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildText(1,itemsConfig.getItemName(itemID))

local funcparam=cfg.funcparam
local curexp=funcparam.exp
local addexp=UIDiscipleModel:calculationJJMedicineGrow(self.disciple_guid,curexp,itemID)
local guidstr=tostring(self.disciple_guid)
local rate=DiscipleCoupleModel:getCoupleDzRate(guidstr)
if rate>0 then
addexp=math.floor(curexp*(rate/100)+addexp)
end

local desc_str=FMT.fmt('修为+{0}',addexp)
if funcparam.attr6~=nil then
desc_str=FMT.fmt('{0}\n{1}+{2}',desc_str,UIDiscipleModel:getDiscipleBaseAttrName(funcparam.attr6[1][1]),funcparam.attr6[1][2])
end
item:SetChildText(2,desc_str)

local repeatType=REPEAT_TYPE.eUseExpByAbsorbExp
local clickCount=0
local cb=function(idx)
clickCount=clickCount+1
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,repeatType)
if flag then
clickCount=0
else
if clickCount>1 then return end
end
local func=function()
clickCount=0
if not self or self.isClose then return end
self:onGoodUpBtnClick(idx,itemID)
end
local absorbExpRate=fabaoModel.getAbsorbExpRate(self.disciple_guid)
if absorbExpRate>0 then
local cancelfunc=function()clickCount=0 end
local closecallback=function()clickCount=0 end
local desc=FMT.fmt('本命法宝蕴养中，50%的丹药修为将被法宝吸收，确定要使用吗？\n<color=#ca631d>（丹药显示的修为值已扣除50%）</color>')
self.dialogue=UIDialogManager.getConfirmDialog3(self.dialogue,desc,func,repeatType,cancelfunc,closecallback)
else
func()
end
end

local fncb=function(idx)
self:onGoodUpBtnClick_fn(idx,itemID)
end
item:SetChildLongPress(3,index,cb,fncb)

local fix=data[2]
local is_gray=not fix
item:SetChildImageExGray(3,is_gray)

item:SetChildActive(4,is_gray)

item:SetChildNewBieComponentId(5,FMT.fmt('UIDiscipleJingJieWin.GoodItemXW_{0}.newBieButton',index))
item:SetChildButtonClick(5,function()
self:onGoodUpBtnClick_newbie(index,itemID)
end)

if showEffect then
item:SetChildShowEffect(6,10088,true)
end
end

function UIDiscipleJingJieWin:getGoodDataList1()
self.quickGoods={}
self.quickGoods_lookup={}
self.goodDataList1={}
self.items_lookup_1={}
self.items_lookup_1_new={}
local templist=itemsLookup:get_function_items(item_funtion_type.jj_xiuweidan)or{}
local list={}
for k,v in pairs(templist)do
if v.type3 and v.type3==1 then
else
table.insert(list,v)
end
end
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local satietyMinus=dzSpecialityGrowEffectController:getDanYaoBaoShiDuRateLookup(netData)
local swEffecData=UIDiscipleModel:getShuWuDZGlobalDYEffectData()
satietyMinus=satietyMinus+(swEffecData[2]or 0)
satietyMinus=math.min(satietyMinus,100)
for k,v in pairs(list)do
if itemsLookup:checkDicipleUseItemCondition_pass(self.disciple_guid,v.id)then
local num=bagModel.getItemCountById(v.id)
if num>0 then
local funcparam=v.funcparam
local fix=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,v.id)
fix=fix and itemsLookup:checkSatiety(self.disciple_guid,v.id,false)
local needReconfirmWeight=v.reconfirmText and 1000 or 0
local d={v,fix,funcparam.exp,v.stage or 0,needReconfirmWeight}
table.insert(self.goodDataList1,d)

local extra=funcparam.extra
local attr6=funcparam.attr6
if fix and not extra and not attr6 then
local addexp=UIDiscipleModel:calculationJJMedicineGrow(self.disciple_guid,funcparam.exp,v.id)
local curexp=funcparam.exp
local rate=DiscipleCoupleModel:getCoupleDzRate(tostring(self.disciple_guid))
if rate>0 then
addexp=math.floor(curexp*(rate/100)+addexp)
end
local satiety=math.ceil((100+satietyMinus)/100*(funcparam.satiety or 0))

d={v,curexp,num,satiety,addexp}
table.insert(self.quickGoods,d)

self.isOnlyNingQiDanAvailable=table.containsValue(_excludedNingQiDanIds,v.id)
end
else
self.items_lookup_1_new[v.id]=true
end
end
end
if#self.goodDataList1>0 then
table.sort(self.goodDataList1,function(a,b)
if a[2]==b[2]then
if a[5]==b[5]then
if a[3]==b[3]then
return a[4]>b[4]
else
return a[3]>b[3]
end
else
return a[5]<b[5]
end
else
local aa=a[2]==true and 1 or 0
local bb=b[2]==true and 1 or 0
return aa>bb
end
end)
for i,v in ipairs(self.goodDataList1)do
self.items_lookup_1[v[1].id]=i
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

function UIDiscipleJingJieWin:refreshToggle2ListView()
local hasCanUse
if list2Change then
hasCanUse=false
list2Change=false
self:getGoodDataList2()
local dataNum=#self.goodDataList2
self.goodlist2:setChildScrollViewCreateGrids(dataNum,1)

local goodGrid=self.goodlist2:getChildScrollViewItemWidgets()
for i=1,dataNum do
local item=goodGrid[i-1]
self:refreshToggle2ListItem(item,i)
local data=self.goodDataList2[i]
local fix=data[2]
if fix then
hasCanUse=true
end
end
end
self.notOpenQuick:setActive(true)
self.haveOpenQuick:setActive(false)

local str
if not UIDiscipleModel:checkJJFullFloorEx(self.disciple_guid)then
local rate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(self.disciple_guid)

str=FMT.fmt('<color=#7d3b17>突破成功率：</color>{0}%',rate)
else
str=fullfloorTips
end
self.descText1:setText(str)

local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local jjfloor=UIDiscipleModel:getJJFloor(jjlv)
local useCount=UIDiscipleModel:getTuPoDanUseCount(self.disciple_guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(jjfloor)
self.descText2:setText(FMT.fmt('<color=#7d3b17>已服用丹药：</color>{0}/{1}',useCount,limitCnt))
self.descText:setText('')


if hasCanUse~=nil then
self:refreshGainWayPanel(2,not hasCanUse)
else
self:refreshGainWayPanel(2,self.list2GainWayShow or false)
end
end

function UIDiscipleJingJieWin:refreshToggle2ListItem(item,index,showEffect)
if item==nil then
item=self.goodlist2:getChildScrollViewItemWidget(index-1)
end
local data=self.goodDataList2[index]
local cfg=data[1]
local itemID=cfg.id
local itemNum=bagModel.getItemCountById(itemID)
local conf={itemid=itemID,itemcount=itemNum,showname=false,showCountBG=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

item:SetChildText(1,itemsConfig.getItemName(itemID))

local funcparam=cfg.funcparam
local desc_str=FMT.fmt('{0}概率+{1}%',UIDiscipleModel:rateJJName(funcparam.condition),funcparam.rate)
item:SetChildText(2,desc_str)

item:SetChildButtonClick(3,function()
self:onGoodRateBtnClick(index,itemID)
end)

local fix=data[2]
local is_gray=not fix
item:SetChildImageExGray(3,is_gray)

item:SetChildActive(4,is_gray)

item:SetChildNewBieComponentId(5,FMT.fmt('UIDiscipleJingJieWin.GoodItemDJ_{0}.newBieButton',index))
item:SetChildButtonClick(5,function()
self:onGoodRateBtnClick_newbie(index,itemID)
end)

if showEffect then
item:SetChildShowEffect(6,10088,true)
end
end

function UIDiscipleJingJieWin:getGoodDataList2()
self.goodDataList2={}
self.items_lookup_2={}
self.items_lookup_2_new={}
local list=itemsLookup:get_function_items(item_funtion_type.jj_tupodan)or{}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
local funcparam=v.funcparam
local fix=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,v.id)
local d={v,fix,funcparam.rate,v.stage}
table.insert(self.goodDataList2,d)
else
self.items_lookup_2_new[v.id]=true
end
end
if#self.goodDataList2>0 then
table.sort(self.goodDataList2,function(a,b)
if a[2]==b[2]then
if a[3]==b[3]then
return a[4]>b[4]
else
return a[3]>b[3]
end
else
local aa=a[2]==true and 1 or 0
local bb=b[2]==true and 1 or 0
return aa>bb
end
end)
for i,v in ipairs(self.goodDataList2)do
self.items_lookup_2[v[1].id]=i
end
end
end

function UIDiscipleJingJieWin:showTips(isshow)

self.tipsText:setActive(isshow)
if isshow then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,jumpbuildid,'name')
local str=FMT.fmt('点击前往 <color=#2dcd19>【{0}】</color> 炼制{1}丹',name,toggleTitle[self.curSelectPage])
self.tipsText:setText(str)
end
end

function UIDiscipleJingJieWin:onTipsClick()



local goFunc=function()
local jumpParam={type=0,id=501}
local flag=jumpManager:jump(jumpParam)
return flag
end
UIFullCommonControl:showWindow_BackDiscipleMain(goFunc,self.disciple_guid)
end

function UIDiscipleJingJieWin:checkShowBroke()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)and jjlv<cfgHelper.getdef1(cfg_disciplejingjieconfig,'showMax')
return show_broke
end

function UIDiscipleJingJieWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end
end

function UIDiscipleJingJieWin:stopItemLongPress(idx)
local item=self.goodlist1:getChildScrollViewItemWidget(idx-1)
if item then
item:SetChildLongPressStop(3)
item:SetChildShowEffect(6,0,false)
end
end

function UIDiscipleJingJieWin:checkSatiety(itemID,isWarning)
local itemcfg=itemsConfig.getConfig(itemID)
local funcparam=itemcfg.funcparam
if funcparam~=nil then
local satiety=funcparam.satiety
if satiety~=nil and satiety>0 then
if self.curSatiety>=self.maxSatiety then
if isWarning then
UIManager.error('修为丹饱食度已满')
end
return false
end
end
end
return true
end

function UIDiscipleJingJieWin:checkIsSpecItem(itemID)
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

function UIDiscipleJingJieWin:checkGoodUpUseCondition(idx,itemID)
local guid=self.disciple_guid
local itemNum=bagModel.getItemCountById(itemID)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
return false
end


if not itemsLookup:checkSatiety(guid,itemID,true)then
return false
end

local netData=UIDiscipleModel:getDiscipleData(guid)
local jingjielv=netData.jingjielv
local cfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,jingjielv)
local curjjexp=UIDiscipleModel:calculationJJExp(guid)
local nxjjexp=cfg.exp

if nxjjexp<=0 then
UIManager.error('境界已满')
return false
end


local fix,cond=itemsLookup:checkDicipleUseItemCondition(guid,itemID)
if not fix then
if cond then
local item=self.goodlist1:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(-190,30)
local cond_str=UIDiscipleModel:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end

local useItemFunc=function()
if _this==nil then return end
_this.useItemID=itemID
return bagProtocolControl.req_dizi_use_item(_this.disciple_guid,itemID,1)
end

local dzName=UIDiscipleModel:getDiscipleColorName(guid)
local itemName=itemsConfig.getColorName(itemID)
local itemCfg=itemsHelper:get_item_config(itemID)
local checkSpecialityFunc=function()

local isAddSpeciality=false
local specialityTypeList={}
local specialityList={}
local funcparam=itemCfg.funcparam
local extraList=funcparam and funcparam.extra or{}

for i,v in ipairs(extraList)do
if v[2][5]then
local list=v[2][5][2]or{}
for _,specialityItem in ipairs(list)do
local specialityType=specialityItem[1]
table.insert(specialityTypeList,specialityType)
for _,specialityId in ipairs(specialityItem[2])do
table.insert(specialityList,{specialityType,specialityId})
end
end
end
end
isAddSpeciality=specialityTypeList and next(specialityTypeList)or false
if isAddSpeciality then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
local isHideFullSpecialityTipsDialog=check or _this.finishCheckSpecialityItemID==itemID
if isHideFullSpecialityTipsDialog then

return true
end


local isFullSpeciality=false
local fullType
local spName
for i,v in ipairs(specialityTypeList)do
local specialityType=v
if specialityType==DISCIPLE_SPECIALITY_TYPE.eTalent then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,guid)
if isMax then
isFullSpeciality=true
fullType=DISCIPLE_SPECIALITY_TYPE.eTalent
break
end
elseif specialityType==DISCIPLE_SPECIALITY_TYPE.eBody then

local isMax=UIDiscipleModel.checkSpecialtyCountMax(specialityType,guid)
if isMax then
local list=UIDiscipleModel:getDiscipleSpeciality(guid,specialityType)
spName=UIDiscipleModel:getSpecialityName(specialityType,list[1].param_1)
fullType=DISCIPLE_SPECIALITY_TYPE.eBody
isFullSpeciality=true
break
end
end
end

if isFullSpeciality and not isHideFullSpecialityTipsDialog then

local contentStr
if fullType==DISCIPLE_SPECIALITY_TYPE.eTalent then
local notSpeaceItemName=string.replaceSpace(itemName)
contentStr=FMT.fmt("弟子{0}拥有的天赋数量已达上限，使用{1}不会再获得天赋，确定要使用吗？",dzName,notSpeaceItemName)
elseif fullType==DISCIPLE_SPECIALITY_TYPE.eBody then
local colorName=FMT.cfmt(FONT_COLOR.ePurpleColor,spName)
contentStr=FMT.fmt("弟子{0}已经拥有{1}，无法再获得新的体质了，使用可能会浪费道具的效果\n确定要使用吗？",dzName,colorName)
end
local okcallback=function(...)
_this.finishCheckSpecialityItemID=itemID
useItemFunc()
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eItemHideFullSpecialityTipsDialog)
return false
end
end

return true
end


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
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(guid,itemID,true)
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

if self:isAddSpecialityItem(itemID,DISCIPLE_SPECIALITY_TYPE.eBody)then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
end
if isShowDialog then
local contentStr=FMT.fmt("{0}{1}",reconfirmText,showAttrText)
local okcallback=function(...)
if checkSpecialityFunc()then
return useItemFunc()
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eItemHideReconfirmDialog)
return false
end
end

if not checkSpecialityFunc()then
return false
end

if iscallback then
return useItemFunc()
else
return true
end
end


if curjjexp>=nxjjexp then
if UIDiscipleModel:checkNextJJNeedBroke(jingjielv)then
if UIDiscipleModel:checkJJBrokeByHand(jingjielv)then
local falg=true
local attrName=nil
local maxAttr=0
if reconfirmText then
local has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrCondition(guid,itemID,true)
if not has6AttrCondition then
has6AttrCondition,conditionList=UIFuncItemUseModel:checkHasBase6AttrConditionEX(guid,itemID,true)
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
if checkSpecialityFunc()then
return _fun(true)
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback)
return false
else
if reconfirmText and not falg then
UIManager.error(FMT.fmt("弟子{0}超过{1}，境界经验已满，请先突破境界",attrName,maxAttr))
else
UIManager.error('需要突破境界')
end
return false
end
else

FeiShengTaiController.sendJingJieBroke(guid)
end
else

UIDiscipleController:requireRefreshDiscipleInfo(guid)
end
end
return _fun()
end

function UIDiscipleJingJieWin:onGoodUpBtnClick(idx,itemID)
if self.jjPointMove then
return
end
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

function UIDiscipleJingJieWin:onGoodUpBtnClick_fn(idx,itemID)
self.useGoodTime=nil
self:recordClickCount()
end

function UIDiscipleJingJieWin:onGoodUpBtnClick_newbie(idx,itemID)
if self.jjPointMove then
return
end
if not self:checkGoodUpUseCondition(idx,itemID)then
return
end


self.useItemID=itemID
bagProtocolControl.req_dizi_use_item(self.disciple_guid,itemID,1)
end

function UIDiscipleJingJieWin:checkGoodRateUseCondition(idx,itemID)
local guid=self.disciple_guid
local itemNum=bagModel.getItemCountById(itemID)
if itemNum<=0 then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
return false
end

if UIDiscipleModel:checkJJFullFloorEx(guid)then
UIManager.error(fullfloorTips)
return false
end

local rate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(guid)
if rate>=100 then
UIManager.error(FMT.fmt('{0}概率已达100%',self:rateJJName_cur()))
return false
end


local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local jjfloor=UIDiscipleModel:getJJFloor(jjlv)
local useCount=UIDiscipleModel:getTuPoDanUseCount(guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(jjfloor)
if useCount>=limitCnt then
UIManager.info('服用丹药次数已满')
return false
end


local fix,cond=itemsLookup:checkDicipleUseItemCondition(guid,itemID)
if not fix then
if cond then
local item=self.goodlist2:getChildScrollViewItemWidget(idx-1)
local pos=Vector2.New(-190,30)
local cond_str=UIDiscipleModel:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return false
end
return true
end

function UIDiscipleJingJieWin:onGoodRateBtnClick(idx,itemID)
if not self:checkGoodRateUseCondition(idx,itemID)then
return
end
bagProtocolControl.req_dizi_use_item(self.disciple_guid,itemID,1)
end

function UIDiscipleJingJieWin:onGoodRateBtnClick_newbie(idx,itemID)
if not self:checkGoodRateUseCondition(idx,itemID)then
return
end


bagProtocolControl.req_dizi_use_item(self.disciple_guid,itemID,1)
end

function UIDiscipleJingJieWin:onBrokeBtn()
local show_broke=self:checkShowBroke()
if not show_broke then return end

local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local check,sys,isHide=UIDiscipleModel:checkJJBrokeNeedSystem(jjlv,true,true)
if not check then
if isHide or sys~=SYSTEM_DEFINE.eJiuChongTianJie or(sys==SYSTEM_DEFINE.eJiuChongTianJie and JiuChongTianJieEnterModel:getOpenTianJieSec()>0)then
return
end
end
if not UIDiscipleModel:checkJJAutoBrokeConditon3(jjlv,true)then
return
end









if UIDiscipleModel:checkJJAutoBrokeConditon(jjlv)then

local disguid=self.disciple_guid
local args={guid=disguid}
local goFunc=function()
UIFullCommonControl:showDuJieWindowEx(args)
end
UIFullCommonControl:showDuJieWindow(goFunc,args,disguid)
self:closeSelf()
else

local isOverMaxFeiShengLv=UIDiscipleModel:checkJJIsOverMaxFeiShengLv(jjlv)
local isJumpFeiShengTai=not isOverMaxFeiShengLv
if isJumpFeiShengTai then

local buildID=SLG_SYSTEM_TYPE.eFeiShengTai2
if not zongmenModel:haveBuildByBuildId(buildID)then
return
end
local jumpParam={type=0,id=JUMP_TYPE.efeishengtai,args={}}
jumpManager:jump(jumpParam)
if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)then
self:closeSelf()
end
else
local isHasAfterTXCost=UIDiscipleModel:checkJJIsHasAfterTXCost(jjlv)
if not isHasAfterTXCost then

UIManager.error("暂未开启")
return
end
local disguid=self.disciple_guid
local args={guid=disguid}
local goFunc=function()
UIFullCommonControl:showDuJieWindowEx_AfterTianXian(args)
end
UIFullCommonControl:showDuJieWindow(goFunc,args,disguid,true)
self:closeSelf()
end
end
end

function UIDiscipleJingJieWin:onQuestionBtn(posItem)
local pos=Vector2.New(16,15)

local rule_str
if self.curSelectPage==1 then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local max1,max2,add=UIDiscipleModel:getDZMaxSatiety(netData)
local cur=self.curSatiety
if cur>max2 then
cur=max2
end
local str1=mathHelper.formatNumber2(cur)
local str2=mathHelper.formatNumber2(max1)
local lerp=add
if lerp>0 then
str2=FMT.fmt('{0}(+{1})',str2,mathHelper.formatNumber2(lerp))
elseif lerp<0 then
lerp=-lerp
str2=FMT.fmt('{0}(-{1})',str2,mathHelper.formatNumber2(lerp))
end
rule_str=FMT.fmt(cfgHelper.get1(cfg_lang_get,'disciple_jj_desc_1'),str1,str2)
else
rule_str=FeiShengTaiModel:DiscipleBrokeSuccessRateStr(self.disciple_guid)
end
posItem=posItem or self.questionBtn
UIManager:showWindow('UIConditionTipsOne',{str=rule_str,posItem=posItem,pos=pos,showType=2})
end

function UIDiscipleJingJieWin:onFbBtn()
if self.quickData then
self:onCloseQuick()
end
UIManager:showWindow('UIDiZiFabaoYunYangTips',{dzguid=self.disciple_guid})
end

function UIDiscipleJingJieWin:onJumpBtn()
local goFunc=function()
local jumpParam={type=0,id=501}
local flag=jumpManager:jump(jumpParam)
return flag
end
UIFullCommonControl:showWindow_BackDiscipleMain(goFunc,self.disciple_guid)
end


function UIDiscipleJingJieWin:useGoodBack(itemid,num,args)
local win=UIManager:findActiveWindow('UIDiscipleJingJieBrokeWin')
if win then return end
UIDiscipleModel:useJJGoodBack(self.disciple_guid,itemid,1,num,args)
end

function UIDiscipleJingJieWin:rateJJName_cur()
if not UIDiscipleModel:checkJJFullFloorEx(self.disciple_guid)then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local floor=UIDiscipleModel:getJJFloor(jjlv)
floor=floor+1
return UIDiscipleModel:getJJFloorName(floor)
end
return'突破'
end

function UIDiscipleJingJieWin:recordClickCount()
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

function UIDiscipleJingJieWin:showTalk(talkStr)
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

function UIDiscipleJingJieWin:clearTalk()
if self.talkTimer~=nil then
self.talkObj:setActive(false)
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
end



function UIDiscipleJingJieWin:refreshGainWayPanel(type,isShow)
local panelObj
local tipsObj
local listObj
local listUnlineObj
local isHasItem
if type==1 then
panelObj=self.gainWayPanel1
tipsObj=self.gainWayTips1
listObj=self.gainWayList1
listUnlineObj=self.listUnline1
isHasItem=#self.goodDataList1>0
self.list1GainWayShow=isShow
elseif type==2 then
panelObj=self.gainWayPanel2
tipsObj=self.gainWayTips2
listObj=self.gainWayList2
listUnlineObj=self.listUnline2
isHasItem=#self.goodDataList2>0
self.list2GainWayShow=isShow
end

local isHasGainWay=false
if isShow then

self:stopItemLongPress(1)
tipsObj:setText(FMT.fmt('库房无弟子当前境界可服用的{0}丹',toggleTitle[self.curSelectPage]))


local gainWayList=self:getGainWaySortListByType(type)
local gainWayCount=#gainWayList
isHasGainWay=gainWayCount>0
listObj:setChildLayoutGroupCreateItems(gainWayCount)
local grids=listObj:getChildLayoutGroupGridList()
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
panelObj:setActive(isShow and isHasGainWay)
listUnlineObj:setActive(isShow and isHasItem)

local name=cfgHelper.get2(cfg_monijybuildconfig_get,jumpbuildid,'name')
local str=FMT.fmt('点击前往 <color=#ca631d>【{0}】</color> 炼制{1}丹',name,toggleTitle[self.curSelectPage])
self.jumpBtnText:setText(str)
self.jumpBtnPanel:setActive(isHasGainWay or isHasItem)
self:showTips(isShow and not isHasGainWay and not isHasItem)
end

function UIDiscipleJingJieWin:getGainWaySortListByType(type)
local list={}
local produce
if type==1 then
produce=cfgHelper.get(cfg_danyaogainwayconfig_get,1,"jingjieProduce")
elseif type==2 then
produce=cfgHelper.get(cfg_danyaogainwayconfig_get,1,"tupoProduce")
end
list=gainControl:getGainSortList(produce)
return list
end


function UIDiscipleJingJieWin:isAddSpecialityItem(itemID,temptype)
local itemCfg=itemsHelper:get_item_config(itemID)
local isAddSpeciality=false
local funcparam=itemCfg.funcparam
local extraList=funcparam and funcparam.extra or{}

for i,v in ipairs(extraList)do
if v[2][5]then
local list=v[2][5][2]or{}
for _,specialityItem in ipairs(list)do
local specialityType=specialityItem[1]
if temptype==specialityType then
isAddSpeciality=true
break
end
end
end
end
return isAddSpeciality
end




function UIDiscipleJingJieWin:refreshReddot()
local state=WenXinGuanModel:checkDzWXGState(self.disciple_guid)
local reddot=WenXinGuanModel:dzIsHaveReddot(self.disciple_guid)
if state then
reddot=UIDiscipleModel:checkDiscipleXianMoTransferReddot(self.disciple_guid)
end

self.wxgreddot:setActive(reddot)
end

function UIDiscipleJingJieWin:refreshXianMoReddot()
local reddot=UIDiscipleModel:checkDiscipleXianMoXinFaReddot(self.disciple_guid)
self.xianmoReddot:setActive(reddot)
end

function UIDiscipleJingJieWin:onWxgBtn()
if not systemModel.isOpen(SYSTEM_DEFINE.eWenXinGuan)then
UIManager.error("问心系统暂未开启")
return
end

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)and jjlv<99
if jjlv<90 or jjlv==90 and not show_broke then
UIManager.error("弟子境界未达到渡劫圆满且满经验，无法参与问心关")
return
end

if not WenXinGuanModel:judgeIsCanEnter(self.disciple_guid)and not JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
UIManager.error("弟子需要完成红尘劫后才能参与问心")
return
end

local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
if isShuWUDZ then
UIManager.error("庶务弟子不愿意参与问心关")
return
end

local isPlotDZ=UIDiscipleModel:isPlotDisciple(self.disciple_guid)
if netData.disciplename=='白子灵'then isPlotDZ=true end
if isPlotDZ then
UIManager.error("弟子红尘未了，无法进入问心关")
return
end

local guid=self.disciple_guid

local curID=WenXinGuanModel:getDtDzGuid()

local state=WenXinGuanModel:checkDzWXGState(self.disciple_guid)

if curID and curID~=self.disciple_guid and not state then
guid=curID
end














local arg=
{
guid=guid,
isFull=true,
}

local jumpType
local winName=WenXinGuanModel:checkDzIsFinishWXG(guid)

if winName=="UIWenXinGuanEnterWin"then
jumpType=JUMP_TYPE.eWenXinGuan
elseif winName=="UIWenXinGuanMainWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Main
elseif winName=="UIWenXinGuanTransferImmortalWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Immortal
elseif winName=="UIWenXinGuanTransferDevilWin"then
jumpType=JUMP_TYPE.eWenXinGuan_Devli
elseif winName=="UIWenXinGuanUnknownWin"then
local state=WenXinGuanModel:getMemoryTransferWin(guid)
if not state then
jumpType=JUMP_TYPE.eWenXinGuan_Unknow
else
jumpType=JUMP_TYPE.eWenXinGuan_Transfer
end
end


if curID and curID~=self.disciple_guid and not state then
local netData=UIDiscipleModel:getDiscipleData(curID)
local contentStr=FMT.fmt('弟子<color=#549327>{0}</color>正在经历问心关，是否前往完成该弟子的问心关?',netData.disciplename)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='前往',
canceltext='取消',
okcallback=function()
jumpManager:jump({id=jumpType,args=arg})
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

else
jumpManager:jump({id=jumpType,args=arg})
end

WenXinGuanModel:setReddotState()
end


function UIDiscipleJingJieWin:onXianmoXinFaBtn()
local dis_guid=self.disciple_guid
local startCallback=function()
UIManager:showWindow("UIXianMoZhuanZhi_mainWin",dis_guid)
end
loadingControl.openCloud(startCallback,0.5)
self:closeSelf()
end

function UIDiscipleJingJieWin:onQuickUseBtn()

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
local sFloor=UIDiscipleModel:getJJFloor(quickData.sLv)
local tFloor=UIDiscipleModel:getJJFloor(tLv)
local sameFloor=sFloor==tFloor
local beforeTx=UIDiscipleModel:getJJNameEx(quickData.sLv)
local afterTx=sameFloor and UIDiscipleModel:getJJNameEx(tLv)or FMT.fmt("{0}圆满",UIDiscipleModel:getJJFloorName(sFloor))
local show_data={
type='UIDialougeLevelUp',
title='提示',
content="是否消耗大量丹药进行修为快速升级",
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

function UIDiscipleJingJieWin:doQuickUse()
local sendList={}
local quickData=self.quickData
local total=0
for i,v in ipairs(quickData.costList)do
total=total+v[2]
end

local tLv=quickData.sLv+quickData.aLv
local sFloor=UIDiscipleModel:getJJFloor(quickData.sLv)
local tFloor=UIDiscipleModel:getJJFloor(tLv)
local sameFloor=sFloor==tFloor
local addShowLv=sameFloor and quickData.aLv or(quickData.aLv-1)
local showLv=sameFloor and tLv or(tLv-1)

local cosume={1,0}
local upBroke={1,0}
for i=0,total,_quickUseUnit do
local sum=math.min(total-i,_quickUseUnit)
local sendUnit={}
while sum>0 do
local since=cosume[2]
local index=cosume[1]
local costData=quickData.costList[index]
local least=costData[2]-since
if sum>=least then
cosume[1]=index+1
cosume[2]=0
table.insert(sendUnit,{costData[1].id,least})
else
cosume[2]=cosume[2]+sum
table.insert(sendUnit,{costData[1].id,sum})
end
sum=sum-least
end

table.insert(sendList,sendUnit)
end

self.waitQuickUse={
list=sendList,
auto=not sameFloor and not UIDiscipleModel:checkJJBrokeByHand(showLv)
}

local count=#sendList
local reqFunc=function(index)
local list=sendList[index]
local array={}
local temp={}
for i,v in ipairs(list)do
table.insert(array,{self.disciple_guid,v[1],v[2]})
temp[FMT.fmt("{0}_{1}",v[1],v[2])]=true
end
bagProtocolControl.req_dizi_use_item_list(#array,array)
if self.waitQuickUse.auto and index==#sendList then
FeiShengTaiController.sendJingJieBroke(self.disciple_guid)
end
self.waitQuickProto={
items=temp,
auto=self.waitQuickUse.auto,
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
effect=20456,
}
self:showWindow("UICommonLoadingWinEx",args)
UIDiscipleController:setSkipUpdataDiscipleAutoBroke(self.disciple_guid)



end
end





function UIDiscipleJingJieWin:onQuickBtn()
local jjexp=UIDiscipleModel:calculationJJExp(self.disciple_guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local sectlv=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'sectlv')
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
local zmLv=zongmenModel:getLevel()
if nxjjexp<=jjexp and sectlv and zmLv<sectlv then
local max_sectlv=cfgHelper.getglobal1('maxlv')
if sectlv>=max_sectlv then
UIManager.info("弟子还未领悟更高境界，还请祖师静候")
else
UIManager.info(FMT.fmt('宗门等级需达到{0}级',sectlv))
end
return
end


if self.needBroke then
UIManager.info("需要先突破境界")
return
end

if self.quickGoods==nil then
self:getGoodDataList1()
end
local canAddMax,canAddMax1=self:getGoodListCanAddMax()
local deltaExp=nxjjexp-jjexp
if canAddMax<deltaExp then
UIManager.info("当前丹药不足以提升一级")
return
end

self.quickPanel:setActive(true)
self:getQuickData(canAddMax,canAddMax1)
self:initQuickPanel()

self:stopTimerByName('refreshTimer')
self:doQuickEnterAnim()
end

function UIDiscipleJingJieWin:doQuickEnterAnim()
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

function UIDiscipleJingJieWin:onCloseQuick()

if self.lowGradeDanYaoPriorityToggle:getToggle()then
self.nonTriggerEvent=true
self.lowGradeDanYaoPriorityToggle:setToggle(false)
end
self.quickData=nil
self.quickJJfilter0Satiety=false
self.quickPanel:setActive(false)


self.cur_jjlv=nil
self.cur_jjpoint=nil
self:refreshView(true)
self:initTimer()
end

function UIDiscipleJingJieWin:getGoodListCanAddMax()
local canAddMax=0
local canAddMax1=0
local sumSatiety=0
for i,v in ipairs(self.quickGoods)do
local cfg=v[1]
local exp=v[2]
local num=v[3]
local satiety=v[4]
local addexp=v[5]

if not(self.lowGradeDanYaoPriority and table.containsValue(_excludedNingQiDanIds,cfg.id))then
local least=self.maxSatiety-self.curSatiety-sumSatiety
local temp=math.floor(least/satiety)
local numSatiety=satiety>0 and temp or num
if num<=numSatiety then
canAddMax=canAddMax+addexp*num
sumSatiety=sumSatiety+satiety*num
else
canAddMax=canAddMax+addexp*numSatiety
sumSatiety=sumSatiety+satiety*numSatiety
end

if satiety>0 then
if num<=temp then
canAddMax1=canAddMax1+addexp*num
else
canAddMax1=canAddMax1+addexp*numSatiety
end
end
end
end
return canAddMax,canAddMax1
end

function UIDiscipleJingJieWin:getQuickData(canAddMax,canAddMax1)
if canAddMax==nil or canAddMax1==nil then
canAddMax,canAddMax1=self:getGoodListCanAddMax()
end
local data={}
data.sExp=UIDiscipleModel:calculationJJExp(self.disciple_guid)
data.sLv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
data.sPoint=UIDiscipleModel:getDiscipleJJPoint(data.sLv,data.sExp)
data.sSatiety=self.curSatiety
data.aExp=0
data.aLv=0
data.oAddLv=0
data.aSatiety=0
data.costList={}
data.dExpList={}
data.aExpMax=canAddMax
data.aExpMax1=canAddMax1

local lvCfg=cfg_disciplejingjieconfig()
local cLvCfg=lvCfg[data.sLv]
local progressMax=cLvCfg.exp
local progressValue=data.sExp
local deltaExp=cLvCfg.exp-data.sExp
table.insert(data.dExpList,deltaExp)

local zmLv=zongmenModel:getLevel()
local sectlv=cLvCfg.sectlv
for i=data.sLv-1,0,-1 do
local tempCfg=lvCfg[i]
sectlv=sectlv or tempCfg.sectlv
if tempCfg.floor==cLvCfg.floor then
progressMax=progressMax+tempCfg.exp
progressValue=progressValue+tempCfg.exp
else
break
end
end

local checkSectLv=sectlv==nil or zmLv>=sectlv
local tempLv=0
local tempExp=data.aExpMax
if tempExp>=deltaExp and(deltaExp>0 or checkSectLv)then
tempLv=1
end
tempExp=tempExp-deltaExp

local tempLv1=0
local tempExp1=data.aExpMax1
if tempExp1>=deltaExp and(deltaExp>0 or checkSectLv)then
tempLv1=1
end
tempExp1=tempExp1-deltaExp

if checkSectLv then
local lastLv=sectlv
for i=data.sLv+1,#lvCfg do
local tempCfg=lvCfg[i]
if tempCfg.exp>0 and tempCfg.floor==cLvCfg.floor and(lastLv==nil or zmLv>=lastLv)then
progressMax=progressMax+tempCfg.exp
table.insert(data.dExpList,tempCfg.exp)
if tempExp>=tempCfg.exp then
tempLv=tempLv+1
end
tempExp=tempExp-tempCfg.exp

if tempExp1>=tempCfg.exp then
tempLv1=tempLv1+1
end
tempExp1=tempExp1-tempCfg.exp
lastLv=tempCfg.sectlv or lastLv
else
break
end
end
end

data.progressMax=progressMax
data.progressValue=math.min(progressValue,progressMax)
data.aLvMax=tempLv
data.aLvMax1=tempLv1

self.quickData=data

if tempLv1<=0 then
self.quickJJfilter0Satiety=false
end
end

function UIDiscipleJingJieWin:initQuickPanel(noAnim)
local data=self.quickData

if self:checkShowBroke()then
self:onCloseQuick()
return false
end

if data.aLvMax==0 then
self:onCloseQuick()
return false
end



local valueY=math.floor(data.progressValue/data.progressMax*10000)
local valueG=math.floor((data.progressValue+data.aExp)/data.progressMax*10000)
self.quickProgressBarYellow:setProgressValue(valueY,10000)
self.quickProgressBarGreen:setProgressValue(valueG,10000)
local curStr=data.aExp>0 and FMT.fmt("<color=#76d81e>{0}</color>",data.progressValue+data.aExp)or data.progressValue
local str=FMT.fmt("{0}/{1}",curStr,data.progressMax)
self.quickProgressBarYellow:setChildProgressText(str)

local full=UIDiscipleModel:checkJJLevelFull(data.sLv)
self.quickBroke:setActive(self.needBroke or full)
self.quickUseBtn:setActive(not self.needBroke and not full)
self.quickResetBtn:setActive(not self.needBroke and not full)
self.quickCostOther:setActive(not self.needBroke and not full)
self.quickSlider:setActive(not self.needBroke and not full)

self.quickCostView:setActive(false)

if self.quickCostEmptyTween and self.quickCostEmptyTween:IsActive()then
self.quickCostEmptyTween:Kill()
self.quickCostEmptyTween=nil
end

if noAnim then
self.quickCostEmpty:setChildCanvasGroupAlpha(1)
else
self.quickCostEmpty:setChildCanvasGroupAlpha(0)
if not self.needBroke and not full then
self.quickCostEmptyTween=self.quickCostEmpty:setChildCanvasGroupDOFade(1,0.2)
end
end

self:refreshQuickSatiety()
self:initFilterSatietyBtn()

self.quickCostList:setChildLayoutGroupCreateItems(0)
self.quickCostList:setChildAnchoredPos(0,0)

if not self.needBroke and not full then
local noneCost=#data.costList<=0
self.quickUseBtn:setChildGraphicGray(noneCost)
self.quickResetBtn:setChildGraphicGray(noneCost)
self.quickBegin:setText(UIDiscipleModel:getJJNameEx(data.sLv))
self.quickEnd:setText("????")
self.quickSlider:setChildSliderInit(data.aLv,0,self.quickJJfilter0Satiety and data.aLvMax1 or data.aLvMax,function(value)
self:onQuickSliderValueChange(value)
end)
self.winlua:ForceLayoutRect(self.quickSliderGroup:getID())
else
self.quickBroke:setText(full and"已满级"or"需要突破境界")
end
return true
end

function UIDiscipleJingJieWin:onQuickSliderValueChange(value)
if self.quickSliderValue==value and not self.quickSliderChange then return end
local down=value<(self.quickSliderValue or 0)
self.quickSliderValue=value
self.quickSliderChange=nil

if self.quickSliderStop then
self.quickSliderStop=nil
return
end

local data=self.quickData
local oAddExp=data.aExp
data.oAddLv=data.aLv
data.aLv=value
data.aExp=0
data.aSatiety=0
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
local satiety=v[4]
local addExp=v[5]


local isExcludedNingQiDanInLowGradePriority=self.lowGradeDanYaoPriority and table.containsValue(_excludedNingQiDanIds,cfg.id)

if not isExcludedNingQiDanInLowGradePriority
and(not self.quickJJfilter0Satiety or satiety>0)then
local leastStatiety=self.maxSatiety-data.sSatiety-data.aSatiety
local expNum=math.ceil(temp/addExp)
local satietyNum=satiety>0 and math.floor(leastStatiety/satiety)or num
local useNum=math.min(num,expNum,satietyNum)
if useNum>0 then
data.aExp=data.aExp+addExp*useNum
temp=temp-addExp*useNum
data.aSatiety=data.aSatiety+satiety*useNum
local sort={
cfg.stage or 0,
cfg.color,
-cfg.id,
}
table.insert(data.costList,{cfg,useNum,addExp,satiety,sort})
end
end
end
table.sort(data.costList,function(a,b)
local sortA=a[5]
local sortB=b[5]
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

self:refreshQuickSatiety()
self.quickUseBtn:setChildGraphicGray(not haveAdd)
self.quickResetBtn:setChildGraphicGray(not haveAdd)

local endStr="????"
if haveAdd then
local tLv=data.sLv+data.aLv
local sFloor=UIDiscipleModel:getJJFloor(data.sLv)
local tFloor=UIDiscipleModel:getJJFloor(tLv)
if sFloor~=tFloor then
endStr=FMT.fmt("{0}圆满",UIDiscipleModel:getJJFloorName(sFloor))
else
endStr=UIDiscipleModel:getJJNameEx(tLv)
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

function UIDiscipleJingJieWin:initQuickCostItem(index)
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

function UIDiscipleJingJieWin:onClickQuickCostItemDeletePressCallback(index)
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

function UIDiscipleJingJieWin:onClickQuickCostItemDeletePressFinish()
self.quickCostItemDeletePress=nil
end

function UIDiscipleJingJieWin:onClickQuickCostItemDelete(index,minus)
local quickData=self.quickData
local data=quickData.costList[index]
local num=data[2]
num=math.max(num-minus,0)
local _num=data[2]-num
data[2]=num
local tempExp=quickData.aExp-data[3]*_num
local tempSatiety=quickData.aSatiety-data[4]*_num
local tempLv=0
local oldLv=quickData.aLv
local oAddExp=quickData.aExp
quickData.aExp=tempExp
quickData.aSatiety=tempSatiety
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
self:refreshQuickSatiety()

if oldLv~=tempLv then
local tLv=quickData.sLv+quickData.aLv
local sFloor=UIDiscipleModel:getJJFloor(quickData.sLv)
local tFloor=UIDiscipleModel:getJJFloor(tLv)
local endStr=""
if haveCost then
if sFloor~=tFloor then
endStr=FMT.fmt("{0}圆满",UIDiscipleModel:getJJFloorName(tFloor))
else
endStr=UIDiscipleModel:getJJNameEx(tLv)
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

function UIDiscipleJingJieWin:onQuickAddBtn()
local curSlinder=self.quickSliderValue or 0
local data=self.quickData
local max=self.quickJJfilter0Satiety and data.aLvMax1 or data.aLvMax
if curSlinder<max then
self.quickSlider:setChildSliderValue(curSlinder+1)
end
end

function UIDiscipleJingJieWin:onQuickSubBtn()
local curSlinder=self.quickSliderValue or 0
if curSlinder>0 then
self.quickSlider:setChildSliderValue(curSlinder-1)
elseif#self.quickData.costList>0 then
self.quickSliderValue=nil
self.quickSlider:setChildSliderValue(0)
end
end

function UIDiscipleJingJieWin:refreshJJQuick()
local quickData=self.quickData


local tLv=quickData.sLv+quickData.aLv
local tFull=UIDiscipleModel:checkJJLevelFull(tLv)
local sFloor=UIDiscipleModel:getJJFloor(quickData.sLv)
local tFloor=UIDiscipleModel:getJJFloor(tLv)
local sameFloor=sFloor==tFloor
local addShowLv=sameFloor and quickData.aLv or(quickData.aLv-1)
local showLv=addShowLv+quickData.sLv

local n,p,pN=UIDiscipleModel:getJJNameX(showLv)
local str_1=''
local str_2=''
if p~=nil then
str_1=FMT.fmt('{0}{1}',n,pN)
str_2=FMT.fmt('{0}阶',p)
else
str_1=n
end
self.jjLvNameText:setText(str_1)
self.jjLvNameText2:setText(str_2)

local before={quickData.sLv,quickData.sPoint}
local tCfg=cfgHelper.get1(cfg_disciplejingjieconfig_get,showLv)
local tPoint,tExp,mExp
if sameFloor then
local temp=quickData.aExp
if addShowLv>0 then
for i=1,addShowLv do
temp=temp-quickData.dExpList[i]
end
else
temp=temp+quickData.sExp
end
temp=math.min(temp,tCfg.exp)
tPoint,tExp,mExp=UIDiscipleModel:getDiscipleJJPoint(showLv,temp)
else
tPoint,tExp,mExp=UIDiscipleModel:getDiscipleJJPoint(showLv,tCfg.exp)
end

local after={showLv,tPoint}
local dLv=quickData.aLv-quickData.oAddLv
self:refreshLeftProgress(tFull,tExp,mExp,dLv)
self:refreshLeftPoint(after[1],after[2])


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

self.needBroke=self:checkShowBroke()
self:refreshBrokePanel()
end

function UIDiscipleJingJieWin:onQuestionBtn2()
self:onQuestionBtn(self.questionBtn2)
end

function UIDiscipleJingJieWin:refreshQuickSatiety()
local quickData=self.quickData
if quickData then
local color="161412"
local tSatiety=quickData.sSatiety+quickData.aSatiety
if quickData.aSatiety>0 then
color="C82C2C"





end
local rate=math.floor((math.min(tSatiety,self.maxSatiety)/self.maxSatietyEx)*100)
local satietyStr=FMT.fmt("饱食度：{0}",FMT.cfmt3(color,"{0}%",rate))
self.satietyTips:setText(satietyStr)
self.winlua:ForceLayoutRect(self.satietyTips:getID())
self.winlua:ForceLayoutRect(self.satietyBottom:getID())
end
end

function UIDiscipleJingJieWin:checkWaitQuickProto()
if self.waitQuickProto and next(self.waitQuickProto.items)==nil and not self.waitQuickProto.auto then
self.waitQuickProto=nil
if not self.waitQuickUse then











UIDiscipleController:setSkipUpdataDiscipleAutoBroke()
end
end
end

function UIDiscipleJingJieWin:onQuickResetBtn()
if self.quickData and self.quickData.aExp>0 then
self:getQuickData()
self:initQuickPanel()
end
end

function UIDiscipleJingJieWin:onQuestionBtn3()
self:onQuestionBtn(self.questionBtn3)
end

function UIDiscipleJingJieWin:resetQuickDataSelect()
local data=self.quickData
data.aExp=0
data.aLv=0
data.oAddLv=0
data.aSatiety=0
data.costList={}
end

function UIDiscipleJingJieWin:onFilterSatietyBtn()
self.quickJJfilter0Satiety=not self.quickJJfilter0Satiety
self:refreshFilterSatietySelect()
self:resetQuickDataSelect()
self:initQuickPanel(true)
end

function UIDiscipleJingJieWin:refreshFilterSatietySelect()
self.filterSatietySelect:setActive(self.quickJJfilter0Satiety)
end

function UIDiscipleJingJieWin:initFilterSatietyBtn()
local show=self.quickData.aLvMax1>0
self.filterSatietyBtn:setActive(show)
if show then
self:refreshFilterSatietySelect()
end
self.winlua:ForceLayoutRect(self.satietyBottom:getID())
end

function UIDiscipleJingJieWin:onLowGradeDyPriorityToggleChanged(name,isOn,data)
if self.nonTriggerEvent then
self.nonTriggerEvent=false
return
end






if self.quickData then
if self.isOnlyNingQiDanAvailable then
self.nonTriggerEvent=true
self.lowGradeDanYaoPriorityToggle:setToggle(false)
UIManager.info("当前选项不可使用凝气丹")
return
elseif isOn then
self.lowGradeDanYaoPriority=isOn


local jjexp=UIDiscipleModel:calculationJJExp(self.disciple_guid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
if self.quickGoods==nil then
self:getGoodDataList1()
end
local canAddMax,canAddMax1=self:getGoodListCanAddMax()
local deltaExp=nxjjexp-jjexp
if canAddMax<deltaExp then
self.lowGradeDanYaoPriority=false
self.nonTriggerEvent=true
self.lowGradeDanYaoPriorityToggle:setToggle(false)
UIManager.info("当前丹药不足以提升一级")
return
end
end
end

self.lowGradeDanYaoPriority=isOn
if self.quickData then
self:getGoodDataList1()
self:resetQuickDataSelect()
self:initQuickPanel(true)
end
end









def_class("UIZheXianLingDaoTuWin",UIWindowBase)









function UIZheXianLingDaoTuWin:bindComponents()

self.lingpaModel=UIObject.get(self,0)
self.lingpaiTarget=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.spine=UIObject.get(self,3)
self.daotu=UIObject.get(self,4)
self.nextTitleIcon=UIImage.get(self,5)
self.nextTitle=UIText.get(self,6)
self.nextLimit=UIText.get(self,7)
self.btnJuan=UIButton.get(self,8)
self.effect1=UIObject.get(self,9)
self.btnZJ1_2=UIButton.get(self,10)
self.btnZJ1_3=UIButton.get(self,11)
self.btnZJ1_4=UIButton.get(self,12)
self.btnZJ1_5=UIButton.get(self,13)
self.btnZJ1_1=UIButton.get(self,14)
self.nextRoot=UIObject.get(self,15)
self.daoTuRoot=UIObject.get(self,16)
self.effect=UIObject.get(self,17)

self.btnJuan:setButtonClick(function()self:onBtnJuan()end)

self.btnZJ1_2:setButtonClick(function()self:onBtnZJ1_2()end)

self.btnZJ1_3:setButtonClick(function()self:onBtnZJ1_3()end)

self.btnZJ1_4:setButtonClick(function()self:onBtnZJ1_4()end)

self.btnZJ1_5:setButtonClick(function()self:onBtnZJ1_5()end)

self.btnZJ1_1:setButtonClick(function()self:onBtnZJ1_1()end)
self.btnZJ1={
self.btnZJ1_1,
self.btnZJ1_2,
self.btnZJ1_3,
self.btnZJ1_4,
self.btnZJ1_5,
}



end


function UIZheXianLingDaoTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lingpaModel);self.lingpaModel=nil;
_UIObject_release(self.lingpaiTarget);self.lingpaiTarget=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.daotu);self.daotu=nil;
_UIObject_release(self.nextTitleIcon);self.nextTitleIcon=nil;
_UIObject_release(self.nextTitle);self.nextTitle=nil;
_UIObject_release(self.nextLimit);self.nextLimit=nil;
_UIObject_release(self.btnJuan);self.btnJuan=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.btnZJ1_2);self.btnZJ1_2=nil;
_UIObject_release(self.btnZJ1_3);self.btnZJ1_3=nil;
_UIObject_release(self.btnZJ1_4);self.btnZJ1_4=nil;
_UIObject_release(self.btnZJ1_5);self.btnZJ1_5=nil;
_UIObject_release(self.btnZJ1_1);self.btnZJ1_1=nil;
_UIObject_release(self.nextRoot);self.nextRoot=nil;
_UIObject_release(self.daoTuRoot);self.daoTuRoot=nil;
_UIObject_release(self.effect);self.effect=nil;
self.btnZJ1=nil;
end

















local _skinType=
{
eShanLin=1,
}

local _skinCfg=
{

[_skinType.eShanLin]=
{
ab='character/spinelib/ui/ui_shijianzhuanzhou_skeletondata.ab',
asset='UI_zhexianlingMain_SkeletonData',
skin='UI_zhexianlingMain',
}
}

function UIZheXianLingDaoTuWin:onLoaded(...)
self:bindComponents()
self.btnChapters=self.btnZJ1
end

function UIZheXianLingDaoTuWin:__delete()
self:unbindComponents()
end

function UIZheXianLingDaoTuWin:onShow(argtable,afterOnloaded)
self:freshInfo(true)
end

function UIZheXianLingDaoTuWin:onHide()
if self.playtimer1 then
self:stopTimerByID(self.playtimer1)
end
if self.playtimer2 then
self:stopTimerByID(self.playtimer2)
end
if self.playtimer3 then
self:stopTimerByID(self.playtimer3)
end
self.winlua:SetChildCanvasGroupDOFade(self.daotu:getID(),0,0.5)
self.winlua:SetChildUIModelShowFadeToColor(self.spine:getID(),UnityEngine.Color(1,1,1,0),0.5,0,nil)
end

function UIZheXianLingDaoTuWin:freshInfo(load)
local rewardBook=zheXianLingModel:isRewardCurrentBook()
self.daoTuRoot:setActive(not rewardBook)
self.nextRoot:setActive(rewardBook)

AudioManager.playAudio(536)
if rewardBook then
if load then
local func=function()
if self and not self.isClose then
local func1=function()
self:freshNextTitlePanel()
end
self:playBg(func1)
end
end
self:playAni(func)
else
self:freshNextTitlePanel()
end
else
if load then
local func=function()
if self and not self.isClose then
local func1=function()
self:freshDaoTu()
end
self:playBg(func1)
end
end
self:playAni(func)
else
self:freshDaoTu()
end
end
end

function UIZheXianLingDaoTuWin:playAni(func)
self.spine:setActive(false)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.playtimer1=self:delayDo(0.8,func)
end

function UIZheXianLingDaoTuWin:playBg(func)
local skinType=_skinType.eShanLin
local skinCfg=_skinCfg[skinType]
self.winlua:SetChildCanvasGroupAlpha(self.daotu:getID(),0)
self.spine:setActive(true)
self.winlua:SetChildCanvasGroupAlpha(self.spine:getID(),1)
self.winlua:SetChildUIModelShowTarget(self.spine:getID(),3039,1,{},2051,false,false,0,
function()
if self and not self.isClose and func then
func()
end
end)
self:fadeIn(0.1)
end

function UIZheXianLingDaoTuWin:fadeIn(delay)
local func=function()
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
end
local func1=function()
self.winlua:SetChildCanvasGroupDOFade(self.daotu:getID(),1,0.3)
end
if delay>0 then
self.playtimer2=self:delayDo(delay,func)
self.playtimer3=self:delayDo(delay+1.5,func1)
else
func()
end
if webGLHelper:isRunWebGL()then
self:delayDo(delay+3,function()
self.winlua:SetChildModelAnimationStop(self.spine:getID(),0)
end)
end
end

function UIZheXianLingDaoTuWin:freshDaoTu()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapter_id=data.chapter_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local chapterids=bookCfg.chapterids
local len=#chapterids
local name=bookCfg.name
local book_id_str=mathHelper.numberToChinese(book_id)


local widgetBook=self.btnJuan:getWidgetBase()
widgetBook:SetChildText(0,FMT.fmt('卷{0}',book_id_str))
widgetBook:SetChildCSImageSprite(1,globalABLookup.zhexianling,bookCfg.nameicon)
widgetBook:SetChildIcon(2,bookCfg.wanfaicon,false)
widgetBook:SetChildText(3,bookCfg.wanfatitle)
widgetBook:SetChildActive(4,zheXianLingModel:isFinishCurrentBook())


local maxlen=#chapterids
for i,v in ipairs(self.btnChapters)do
local btnWidget=v:getWidgetBase()
local chapterid=chapterids[i]
local has=chapterid~=nil
local slotname=FMT.fmt('2_{0}',i+5)

btnWidget:SetChildActive(-1,has)
if has then
local chapterCfg=zheXianLingConfig.getChapterconfig(chapterid)
local name=chapterCfg.name
local isReward=zheXianLingModel:isRewardChapter(chapterid)
local _bookid,index=zheXianLingConfig.getChapterIndex(chapterid)
local chapterStr=mathHelper.numberToChinese(index)
local isCurChapter=zheXianLingModel:getChapter()==chapterid
local unStart=not isCurChapter and not isReward or false
local isDoing=isCurChapter and not isReward
local isEndChapter=maxlen==i
local isFinish=isReward
local statename=isFinish and'state_3'or isDoing and'state_2'or'state_1'
self.winlua:SetChildUIModelShowSlotAttachment(self.spine:getID(),slotname,statename)

btnWidget:SetChildText(1,name)
self.btnChapters[i]:setButtonClick(function()
if not zheXianLingModel:isRewardChapter(chapterid)then
UIManager:showWindow('UIZheXianLingZJDescWin',{index=i,bookid=book_id,chapterid=chapterid})
else
UIManager:showWindow('UIZheXianLingZJFinishWin',{index=i,bookid=book_id,chapterid=chapterid})
end
end,true)
else
self.winlua:SetChildLoadSlot(self.spine:getID(),slotname,-1)
end
end
end

function UIZheXianLingDaoTuWin:freshNextTitlePanel()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local nextid=bookCfg.nextid
if nextid then
local desc=zheXianLingModel:getOpenBookCnd(nextid)
self.nextLimit:setText(desc)
self.nextTitle:setText('全新卷章即将开启')
else
self.nextLimit:setText('')
self.nextTitle:setText('所有卷章已完成')
end
end





function UIZheXianLingDaoTuWin:onBtnJuan()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local chapterid=data.chapter_id


UIManager:showWindow('UIZheXianLingZongJuanDescWin',{bookid=book_id,chapterid=chapterid})








end



function UIZheXianLingDaoTuWin:onBtnZJ1()
end



function UIZheXianLingDaoTuWin:onBtnZJ2()
end



function UIZheXianLingDaoTuWin:onBtnZJ3()
end



function UIZheXianLingDaoTuWin:onBtnZJ4()
end



function UIZheXianLingDaoTuWin:onBtnZJ5()
end



function UIZheXianLingDaoTuWin:onBtnZJ6()
end


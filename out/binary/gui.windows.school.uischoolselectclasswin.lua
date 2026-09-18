







def_class("UISchoolSelectClassWin",UIWindowBase)









function UISchoolSelectClassWin:bindComponents()

self.ScrollerScript=UIEnhancedScrollerLua.get(self,0)
self.scGainText=UIText.get(self,1)
self.scGainExpText=UIText.get(self,2)



end


function UISchoolSelectClassWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.scGainText);self.scGainText=nil;
_UIObject_release(self.scGainExpText);self.scGainExpText=nil;
end

















local UISchoolScroller=simple_class(UIEnhancedScroller)

local _this

local schoolAB='ui/windows/school/sharedtextures/schoolsprite.ab'
local classNameImg={
[DISCIPLE_PROSKILL_TYPE.ePeiZhi]=1,
[DISCIPLE_PROSKILL_TYPE.eDanDao]=3,
[DISCIPLE_PROSKILL_TYPE.eShangDao]=7,
[DISCIPLE_PROSKILL_TYPE.eFuLu]=5,
[DISCIPLE_PROSKILL_TYPE.eLianQi]=4,
[DISCIPLE_PROSKILL_TYPE.eZhenFa]=6,
[DISCIPLE_PROSKILL_TYPE.eSiYang]=8,
[DISCIPLE_PROSKILL_TYPE.eJuLing]=2,
}


function UISchoolSelectClassWin:onLoaded(...)
self:bindComponents()
_this=self
self.enhancedscrollscript=UISchoolScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
end


function UISchoolSelectClassWin:__delete()
_this=nil
self:unbindComponents()
end




function UISchoolSelectClassWin:onShow(argtable,afterOnloaded)
self.showClasList=UISchoolModel:get_sort_class()
self:initSelectClassPanel()
self:initBottomInfo()
end


function UISchoolSelectClassWin:onHide()

end

function UISchoolSelectClassWin:initBottomInfo()
local moneyType=eMoneyType.mtChuanDao
local moneyName=moneyModel.getMoneyName(moneyType)
local gainMoneyNum=cfgHelper.get2(cfg_collegebaseconfig_get,1,'chuandaonum')
self.scGainText:setText(FMT.fmt(cfgHelper.getlang('school_tips_1'),gainMoneyNum,moneyName))
self.scGainExpText:setText(cfgHelper.getlang('school_tips_2'))
end

function UISchoolSelectClassWin:initSelectClassPanel()
local dataNum=#self.showClasList
self.enhancedscrollscript:initData(self.showClasList,300,dataNum)
end

function UISchoolScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISchoolScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISchoolScroller:RefreshCell(dataIndex,cellIndex,cell)
local classConfig=_this.showClasList[dataIndex]
local item=cell
local zongmengLv=zongmenModel:getLevel()
local unLockLv=classConfig.unlocklevel
local lock=zongmengLv<unLockLv
item:SetChildGray(0,lock)
item:SetChildCSImageSprite(0,schoolAB,FMT.fmt('image_shujichatu_{0}',classNameImg[classConfig.id]))
item:SetChildCSImageSprite(1,schoolAB,FMT.fmt('title_shujiming_{0}',classNameImg[classConfig.id]))
item:SetChildActive(2,lock)
item:SetChildActive(3,lock)

local isnew=UISchoolModel:getClassIsNewState(classConfig.id)
item:SetChildActive(4,isnew)
if lock then
item:SetChildText(3,FMT.fmt('宗门 <color=#c82c2cff>{0}</color> 级',unLockLv))
end
end

function UISchoolScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex)

_this.selectIndex=dataIndex

AudioManager.playBtnClick()

local classConfig=_this.showClasList[dataIndex+1]
local zongmengLv=zongmenModel:getLevel()
local unLockLv=classConfig.unlocklevel
local lock=zongmengLv<unLockLv
if lock then
UIManager.error('未达到教学要求，请选择已解封的课程')
else
UIManager:invokeUIMethod('UISchoolMainWin','setClassId',classConfig.id)
_this:onCloseSCPanelBtn()
end
end


function UISchoolSelectClassWin:onCloseSCPanelBtn()
self:closeSelf()
UISchoolModel:set_class_isNewState()
end


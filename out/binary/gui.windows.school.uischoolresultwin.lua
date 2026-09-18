







def_class("UISchoolResultWin",UIWindowBase)









function UISchoolResultWin:bindComponents()

self.passPanel=UIObject.get(self,0)
self.gradePanel=UIObject.get(self,1)
self.effect=UIObject.get(self,2)
self.roleResultList=UIObject.get(self,3)
self.classIcon=UIImage.get(self,4)
self.classNameText=UIText.get(self,5)
self.gainIcon=UIImage.get(self,6)
self.gainMoneyName=UIText.get(self,7)
self.gainCount=UIText.get(self,8)



end


function UISchoolResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.passPanel);self.passPanel=nil;
_UIObject_release(self.gradePanel);self.gradePanel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.roleResultList);self.roleResultList=nil;
_UIObject_release(self.classIcon);self.classIcon=nil;
_UIObject_release(self.classNameText);self.classNameText=nil;
_UIObject_release(self.gainIcon);self.gainIcon=nil;
_UIObject_release(self.gainMoneyName);self.gainMoneyName=nil;
_UIObject_release(self.gainCount);self.gainCount=nil;
end


















local jobab='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab'
local schoolab='ui/windows/school/sharedtextures/schoolsprite.ab'
local colorframeab='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local itemIndex=
{
back=0,
headImg=1,
dzName=2,
progressbar=3,
classLevel=4,
jiantou=5,
progressText=6,
}


local sixAttrType=3
local sixAttrName=''



function UISchoolResultWin:onLoaded(...)
self:bindComponents()
self.roleResultList:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISchoolResultWin:__delete()
self:unbindComponents()
if not self.isAutoClassResult then
local win=UIManager:findActiveWindow('UISchoolMainWin')
if win then
win:playAnimation(UISchoolModel.curAniState.classOver)
win:hideExpObj()
win:killExpObjTween()
end
end
end




function UISchoolResultWin:onShow(argtable,afterOnloaded)
self.classType=argtable[1]
self.times=argtable[2]or 1
self.resultData=argtable[3]
self.isAutoClassResult=argtable[4]
if not self.resultData then
local resultData=UISchoolModel:get_study_result()
self.resultData=resultData or{}
end

self:delayDo(2,function(...)
self.passPanel:setActive(false)
self.gradePanel:setActive(true)
self:freshResultInfo()
end)

self.effect:setChildShowEffect(10065,true)
end


function UISchoolResultWin:onHide()

end

function UISchoolResultWin:freshResultInfo()



local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
sixAttrName=sixAttrCfg[sixAttrType].name

local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,self.classType,'icon')
self.classIcon:setSprite(jobab,FMT.fmt('image_gongzhongtp_{0}',icon))

local className=cfgHelper.get2(cfg_collegecourseconfig_get,self.classType,'name')
self.classNameText:setText(className)

local getMoney=cfgHelper.get2(cfg_collegebaseconfig_get,1,'chuandaonum')
getMoney=getMoney*self.times
local moneyType=eMoneyType.mtChuanDao
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)
self.gainIcon:setImageIcon(iconName)
self.gainMoneyName:setText(FMT.fmt('获得{0}：',moneyName))
self.gainCount:setText(getMoney)
self:initStudyResult()
end



function UISchoolResultWin:sortResultData(data)
local list=table.deepCopy(data)
for i,v in ipairs(list)do
local exp=tonumber(tostring(v.exp))
v.sortTag=exp
end
table.sort(list,function(a,b)return a.sortTag>b.sortTag end)
return list
end

function UISchoolResultWin:initStudyResult()
local dataNum=#self.resultData
local sortData=self:sortResultData(self.resultData)
self.roleResultList:setChildScrollViewCreateGrids(dataNum,dataNum)

local grids=self.roleResultList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local diziData=sortData[i]
local guid=diziData.dzGuild

local skillData=diziData.skillData
if not skillData then
skillData=UISchoolModel:getOldDiZiProSkillData(guid)
end

local classLevel=skillData[1]

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(itemIndex.back,colorframeab,discipleColorToFrame2[color])

comHelper.setChildModelRawImage(item,guid,itemIndex.headImg,0,eHeadCenterType.eHead)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(itemIndex.dzName,name)

local addExp=tonumber(tostring(diziData.exp))
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local maxexp=explist[classLevel]
item:SetProgressBarAniWithThreeParams(itemIndex.progressbar,addExp,maxexp,1)
item:SetChildText(itemIndex.progressText,FMT.fmt('+{0}',addExp))

local upLevel=UISchoolModel:getUpLevelNum(guid,self.classType,addExp,skillData)
item:SetChildActive(itemIndex.jiantou,upLevel>0)

local maxLevel=explist[classLevel+1]==nil
local levelStr=maxLevel and'满级'or FMT.fmt('{0}级',classLevel)
item:SetChildText(itemIndex.classLevel,levelStr)
end
end
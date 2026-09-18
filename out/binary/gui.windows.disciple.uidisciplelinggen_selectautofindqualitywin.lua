







def_class("UIDiscipleLinggen_SelectAutoFindQualityWin",UIWindowBase)









function UIDiscipleLinggen_SelectAutoFindQualityWin:bindComponents()

self.cancelBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.confirmBtn=UIButton.get(self,2)
self.emptyList=UIObject.get(self,3)
self.mcList=UIScrollView.get(self,4)
self.noColorTips=UIText.get(self,5)
self.noSkillTips=UIText.get(self,6)
self.pzList=UIObject.get(self,7)
self.Root=UIObject.get(self,8)
self.tile=UIText.get(self,9)
self.tip=UILinkImageText.get(self,10)
self.uiRoot=UIObject.get(self,11)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)



end


function UIDiscipleLinggen_SelectAutoFindQualityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.emptyList);self.emptyList=nil;
_UIObject_release(self.mcList);self.mcList=nil;
_UIObject_release(self.noColorTips);self.noColorTips=nil;
_UIObject_release(self.noSkillTips);self.noSkillTips=nil;
_UIObject_release(self.pzList);self.pzList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tile);self.tile=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end















local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}



function UIDiscipleLinggen_SelectAutoFindQualityWin:onLoaded(...)
self:bindComponents()

local _bindAction=function(...)
self:bindGrid(...)
end
self.mcList:bindScrollWidget(_bindAction)

local _clickAction=function(...)
self:onClickMcItem(...)
end
self.mcList:setClickAction(_clickAction)

self.mcColorDataList={}
self.mcDataList={}
self.mcTotalDataList={}
for index=eQualityColor.eGreen,eQualityColor.eRed do
self.mcColorDataList[index]={}
end
end


function UIDiscipleLinggen_SelectAutoFindQualityWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_SelectAutoFindQualityWin:onShow(argtable,afterOnloaded)

self.discipleGuid=argtable.discipleGuid
self.optionDataList=argtable.optionDataList
self.colorList=argtable.colorList or{}
self.autoCount=argtable.autoCount
self.modeType=argtable.modeType
self.useItemData=argtable.useItemData

if self.useItemData and self.useItemData.condition.color then
self.colorList={self.useItemData.condition.color}
end

self:refreshAll()
end


function UIDiscipleLinggen_SelectAutoFindQualityWin:onHide()

end





function UIDiscipleLinggen_SelectAutoFindQualityWin:onCancelBtn()
self:closeSelf()
end



function UIDiscipleLinggen_SelectAutoFindQualityWin:onCloseBtn()
self:closeSelf()
end



function UIDiscipleLinggen_SelectAutoFindQualityWin:onConfirmBtn()
if#self.colorList<=0 then
UIManager.error("请先选择秘藏品质")
return
end

if#self.mcDataList<=0 then
UIManager.error("没有搜寻目标")
return
end

UIManager:invokeUIMethod("UIDiscipleLinggen_HiddenSkillSelectWin",'startQuickFindProgress',self.mcDataList,self.autoCount,self.optionDataList,self.colorList,self.modeType,false,self.useItemData)
UIManager:closeWindow("UIDiscipleLinggen_AutoFindOptionWin")
end



function UIDiscipleLinggen_SelectAutoFindQualityWin:refreshAll()
self:frshMcColorDataList()


if not self:checkColorListCorrentness()then
self.colorList={}
end

self:refershPzList()
self:refreshMcList()
self:refreshTips()
self:refreshBtns()
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:refershPzList()
self.pzList:setChildLayoutGroupCreateItems(5,function(index)
local grid=self.pzList:getChildLayoutGroupGridItem(index-1)

local isSelect=table.findValue(self.colorList,index)~=nil

grid:SetChildActive(0,isSelect)
grid:SetChildText(1,eQualityColorName[index])

grid:SetBaseItemClickEvent(-1,function()












if self.useItemData and self.useItemData.condition.color then
UIManager.info("明灵符已限制秘藏品质")
return
end

local selectIndex=table.findValue(self.colorList,index)

local isSelect2=selectIndex~=nil
local hIndex,sIndex
if isSelect2 then
hIndex=index
sIndex=index+1
else
hIndex=index-1
sIndex=index
end

local emptyTip=false
self.colorList={}
local _grid
for i=hIndex,1,-1 do
_grid=self.pzList:getChildLayoutGroupGridItem(i-1)
_grid:SetChildActive(0,false)
end

for i=sIndex,5 do
if next(self.mcColorDataList[i])then
_grid=self.pzList:getChildLayoutGroupGridItem(i-1)
_grid:SetChildActive(0,true)
self.colorList[#self.colorList+1]=i
else
emptyTip=true
end
end

if emptyTip then
UIManager.error("还未发现此品质秘藏，敬请期待")
end

self:refreshMcList()
self:refreshBtns()
end)
end)
end

local _col=5
function UIDiscipleLinggen_SelectAutoFindQualityWin:refreshMcList()
self:frshMcDataList()

local len=#self.mcDataList

local isShowList=len>0
self.mcList:setActive(isShowList)
self.emptyList:setActive(not isShowList)

local isShowNoColor=#self.colorList<=0
self.noColorTips:setActive(isShowNoColor)

self.cancelBtn:setActive(not isShowNoColor)
self.confirmBtn:setActive(not isShowNoColor)

if isShowList then
self.mcList:freshGridsNum(len,Mathf.Ceil(len/_col),_col,self.freshZero)
self.freshZero=true
else
local isShowNoSkill=(not isShowNoColor)
self.noSkillTips:setActive(isShowNoSkill)
end
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:bindGrid(index,item)
local data=self.mcDataList[index]

item:SetChildActive(-1,data~=nil)
if data then
local skillIconName=iconHelper.getSkillIcon(data.icon)
local desc=data.mz_desc or''

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(data.element)

item:SetChildText(CmpRecordItemIndex.name,data.name)
item:SetChildCSImageSprite(CmpRecordItemIndex.type,ab,elementIconName)
item:SetChildIcon(CmpRecordItemIndex.icon,skillIconName,false)
item:SetChildText(CmpRecordItemIndex.desc,desc)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(data.color)
item:SetChildCSImageSprite(CmpRecordItemIndex.quality,qab,qualityName)
end
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:onClickMcItem(id,index,guid,attach)
self:showWindow("UIDiscipleLinggen_LookHideSkillWin",{
boardList=self.mcDataList,
index=index
})
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:frshMcColorDataList()
local gfLookup=UIDiscipleModel:get_hiddenSkillLookup_Common_GF()
local commonLookup=UIDiscipleModel:get_hiddenSkillLookup_Common()



local id,type,group,colorGroup,list
for index,optionData in ipairs(self.optionDataList)do
id=optionData[1]
type=optionData[2]

if type==1 then
group=table.weakCopy(gfLookup[id][0][0]or defaultT)
elseif type==2 then
group=table.weakCopy(commonLookup[0]or defaultT)
elseif type==3 then

group=table.weakCopy(gfLookup[id][0][1]or defaultT)
elseif type==4 then
if group and next(group)then
table.clear(group)
end
list=UIDiscipleModel:get_Vary_Common_HiddenSkillLookUp_Color(self.discipleGuid)
for groupId,mgroup in pairs(list)do
group=table.concatTable(group,mgroup)
end
end

for _,cfg in pairs(group)do
colorGroup=self.mcColorDataList[cfg.color]
colorGroup[#colorGroup+1]=cfg
self.mcTotalDataList[#self.mcTotalDataList+1]=cfg
end
end
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:frshMcDataList()
self.mcDataList={}
local colorDataList
if next(self.colorList)then
for index,color in ipairs(self.colorList)do
colorDataList=self.mcColorDataList[color]
self.mcDataList=table.concatTable(self.mcDataList,colorDataList)
end
else
self.mcDataList=self.mcTotalDataList
end

if#self.mcDataList>0 then
table.sort(self.mcDataList,function(a,b)
if a.color==b.color then
return a.id<b.id
else
return a.color>b.color
end
end)
end



local isVary=self.modeType==2
self.mcDataList=self:filter_AutoFind_McList(self.discipleGuid,self.mcDataList,isVary)
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:filter_AutoFind_McList(discipleGuid,mcList,isVary)

if self.lookup==nil then
self.lookup=UIDiscipleModel:getHiddenSkillRandomList(discipleGuid,isVary)
end

local list={}

for index,mcData in ipairs(mcList)do
if self.lookup[mcData.id]~=nil then
list[#list+1]=mcData
end
end

return list
end


function UIDiscipleLinggen_SelectAutoFindQualityWin:refreshTips()
local isVary=self.modeType==2
local searchCfg
if isVary then
searchCfg=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'varysearch')
else
searchCfg=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'search')
end
local moneyid=searchCfg[1][1]
local snum=searchCfg[1][2]
local totalNum=snum*self.autoCount

local iconname=iconHelper.getIconName(moneyid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)

local contentFmt="消耗{0}<color=#c82c2c>{1}</color>开始自动搜寻选择的秘藏<color=#c82c2c>{2}</color>次，搜寻到选择的秘藏后将自动停止，否则直至搜寻完毕"
local content=FMT.fmt(contentFmt,iconStr,totalNum,self.autoCount)

self.tip:setText(content)
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:refreshBtns()
local dataLen=#self.mcDataList

self.confirmBtn:setGray(dataLen<=0)
end

function UIDiscipleLinggen_SelectAutoFindQualityWin:checkColorListCorrentness()
for index,color in pairs(self.colorList)do
if next(self.mcColorDataList[color])==nil then
return false
end
end
return true
end




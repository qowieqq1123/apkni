







def_class("UISubAct_fyslZenYiWin",UIWindowBase)









function UISubAct_fyslZenYiWin:bindComponents()

self.diziimg=UIObject.get(self,0)
self.fazeimg=UIObject.get(self,1)
self.fazebtn=UIButton.get(self,2)
self.dizibtn=UIButton.get(self,3)
self.fazetxt=UIText.get(self,4)
self.fazedesc=UIText.get(self,5)
self.skillItem=UIButton.get(self,6)
self.fazeitem5=UIObject.get(self,7)
self.fazeitem4=UIObject.get(self,8)
self.fazeitem3=UIObject.get(self,9)
self.fazeitem2=UIObject.get(self,10)
self.fazeitem1=UIObject.get(self,11)
self.diziitem6=UIObject.get(self,12)
self.diziitem5=UIObject.get(self,13)
self.diziitem3=UIObject.get(self,14)
self.diziitem2=UIObject.get(self,15)
self.diziitem1=UIObject.get(self,16)
self.diziitem4=UIObject.get(self,17)
self.dizidesc3=UIText.get(self,18)
self.dizidesc2=UIText.get(self,19)
self.dizidesc1=UIText.get(self,20)
self.btnClose=UIButton.get(self,21)
self.titleText=UIText.get(self,22)
self.dizipanel=UIObject.get(self,23)
self.fazepanel=UIObject.get(self,24)
self.infoPanel=UIObject.get(self,25)
self.root=UIObject.get(self,26)
self.clickMask=UIButton.get(self,27)
self.blackBG=UIButton.get(self,28)
self.Itembig1=UIObject.get(self,29)
self.Itembig2=UIObject.get(self,30)
self.Itembig3=UIObject.get(self,31)

self.fazebtn:setButtonClick(function()self:onFazebtn()end)

self.dizibtn:setButtonClick(function()self:onDizibtn()end)

self.skillItem:setButtonClick(function()self:onSkillItem()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.blackBG:setButtonClick(function()self:onBlackBG()end)



end


function UISubAct_fyslZenYiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.diziimg);self.diziimg=nil;
_UIObject_release(self.fazeimg);self.fazeimg=nil;
_UIObject_release(self.fazebtn);self.fazebtn=nil;
_UIObject_release(self.dizibtn);self.dizibtn=nil;
_UIObject_release(self.fazetxt);self.fazetxt=nil;
_UIObject_release(self.fazedesc);self.fazedesc=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.fazeitem5);self.fazeitem5=nil;
_UIObject_release(self.fazeitem4);self.fazeitem4=nil;
_UIObject_release(self.fazeitem3);self.fazeitem3=nil;
_UIObject_release(self.fazeitem2);self.fazeitem2=nil;
_UIObject_release(self.fazeitem1);self.fazeitem1=nil;
_UIObject_release(self.diziitem6);self.diziitem6=nil;
_UIObject_release(self.diziitem5);self.diziitem5=nil;
_UIObject_release(self.diziitem3);self.diziitem3=nil;
_UIObject_release(self.diziitem2);self.diziitem2=nil;
_UIObject_release(self.diziitem1);self.diziitem1=nil;
_UIObject_release(self.diziitem4);self.diziitem4=nil;
_UIObject_release(self.dizidesc3);self.dizidesc3=nil;
_UIObject_release(self.dizidesc2);self.dizidesc2=nil;
_UIObject_release(self.dizidesc1);self.dizidesc1=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dizipanel);self.dizipanel=nil;
_UIObject_release(self.fazepanel);self.fazepanel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.Itembig1);self.Itembig1=nil;
_UIObject_release(self.Itembig2);self.Itembig2=nil;
_UIObject_release(self.Itembig3);self.Itembig3=nil;
end

















local _this=nil
local tefighttype=9
local tmabname="ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab"


function UISubAct_fyslZenYiWin:onLoaded(...)
_this=self
self:bindComponents()

self.diziperfab={self.Itembig1,self.Itembig2,self.Itembig3}
self.fazeitem={self.fazeitem1,self.fazeitem2,self.fazeitem3,self.fazeitem4,self.fazeitem5,}
end


function UISubAct_fyslZenYiWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_fyslZenYiWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1
self.page=argtable[5]or 1

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)

self.bossData=self.config.boss[self.bossid]
self.monster=self.bossData[1][1][1]
self.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.monster)

if self.page==1 then
self.fazeimg:setActive(false)
self.diziimg:setActive(true)
self.dizipanel:setActive(true)
self.fazepanel:setActive(false)
else
self.fazeimg:setActive(true)
self.diziimg:setActive(false)
self.dizipanel:setActive(false)
self.fazepanel:setActive(true)
end


local lhidx=self.bossData[4]
local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]
local diziList=cfg_dizifaze.diziList
local tm=cfg_dizifaze.tm

local diziList_id={}
for k,v in pairs(diziList)do
if k then
diziList_id[#diziList_id+1]=k
end
end

local disciplesList=discipleLookup:getSortDiscipleList()
local templist={}
for k,v in ipairs(diziList_id)do
templist[#templist+1]={false,v,0,0,0,nil}
end
for k,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
for i,j in ipairs(templist)do
if diziid==j[2]then
local limitlvl_idx=#tm
for m,n in ipairs(tm)do
if netData.tmlv<=n then
limitlvl_idx=m
break
end
end
templist[i]={guid,diziid,netData.tmlv,limitlvl_idx,100,netData}
end
end
end


table.sort(templist,function(a,b)
if a[4]==b[4]then
return a[3]>b[3]
else
return a[4]>b[4]
end
end)

local maxfaze_idx=1
local maxfaze_dizi_name
for k,v in ipairs(templist)do
if maxfaze_idx==nil then
maxfaze_idx=v[4]
end
if v[4]>maxfaze_idx then
maxfaze_idx=v[4]
end
end

for i,j in ipairs(self.diziperfab)do
local widget=j:getWidgetBase()
local dizidatalist=templist[i]
if dizidatalist then
widget:SetChildActive(-1,true)
if dizidatalist[1]then

local guid=dizidatalist[1]
local netData=dizidatalist[6]

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
widget:SetChildCSImageSprite(1,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
widget:SetChildCSImageSprite(5,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
widget:SetChildActive(11,isSpDz)

widget:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(widget,guid,3,0,eHeadCenterType.eHead,nil,false)

widget:SetChildCSImageSprite(6,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
widget:SetChildText(7,lv_str)

UIDiscipleController.refreshCommonItemTianMing(widget,netData,4)

widget:SetChildActive(8,true)
widget:SetChildText(8,UIDiscipleModel:getDiscipleFightValue(guid))

local tmdazelevel=dizidatalist[4]
if maxfaze_idx==tmdazelevel then
widget:SetChildActive(9,true)
maxfaze_dizi_name=UIDiscipleModel:getDiscipleName(guid)
else
widget:SetChildActive(9,false)
end
widget:SetChildActive(9,false)

widget:SetChildButtonClick(10,function()

local tabType=FULL_TAB_TYPE.eDiscipleInfo
local subType=_this.subType
local subId=_this.subId
UIFullCommonControl:jumpDiscipleMain(guid,tabType,function()
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subId)
if#sub_actList>0 then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={isopenzenyi=true}}},function()
jumpManager:clearJump()
end)
else
UIManager.error("活动已结束")
return UIFullDiscipleMainControl:closeUI()
end
end)
end)
else


local guid=dizidatalist[1]
local diziid=dizidatalist[2]
local netData=UIDiscipleModel:getDiscipleDataByDiziId(dizidatalist[2])



local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
widget:SetChildCSImageSprite(1,abname,iconname)
widget:SetChildImageExGray(1,true)

local jobid=netData.imageInfo.job or 1
local jobicon=UIDiscipleModel:getJobIconName(jobid)
widget:SetChildCSImageSprite(5,globalABLookup.global,jobicon)
widget:SetChildImageExGray(5,true)
local isSpDz=UIDiscipleModel:isSPDisciple(diziid)
widget:SetChildActive(11,isSpDz)
widget:SetChildImageExGray(11,true)

local strname=FMT.fmt("<color=#59412d>{0}</color>",netData.disciplename)
widget:SetChildText(2,strname)



comHelper.setChildModelRawImageByDiziId(widget,diziid,3,0,eHeadCenterType.eHead,nil,true)

widget:SetChildActive(6,false)



widget:SetChildText(7,"")

UIDiscipleController.refreshCommonItemTianMing(widget,netData,4)

widget:SetChildActive(8,false)


local tmdazelevel=dizidatalist[4]
if maxfaze_idx==tmdazelevel then
widget:SetChildActive(9,true)
maxfaze_dizi_name=netData.disciplename
else
widget:SetChildActive(9,false)
end
widget:SetChildActive(9,false)

widget:SetChildButtonClick(10,function()
local dizidaoju=cfg_fuyaoshilianconfig_get(_this.subId).dizidaoju

if dizidaoju[diziid]then
gainControl:showGainWin(dizidaoju[diziid])
end
end)
end
else
widget:SetChildActive(-1,false)
end
end



local dizifazedescArry=self.config.dizifazedesc
local dizixenyidesc=dizifazedescArry[lhidx]

for k,v in ipairs(self.fazeitem)do
local item=v:getWidgetBase()
local desc=dizixenyidesc[k]
if desc then
item:SetChildActive(0,true)

item:SetChildText(2,desc[1])
item:SetChildText(3,desc[2])
if k>1 then
item:SetChildCSImageSprite(4,tmabname,desc[3])
end
else
item:SetChildActive(0,false)
end
end



local _dizixenyidesc=self.config.dizixenyidesc



local str3=FMT.fmt('推荐弟子最高可为{0}',dizixenyidesc[maxfaze_idx][2])
if#dizixenyidesc==1 then
str3='上述弟子皆可为全队提升20%伤害'
end
self.dizidesc1:setText(_dizixenyidesc[1])
self.dizidesc2:setText(_dizixenyidesc[2])
self.dizidesc3:setText(str3)
local ishave=true
for k,v in ipairs(templist)do
if v[1]then
ishave=false
end
end
if ishave then

local arry=dizifazedescArry[lhidx]
local idx=#arry
local str=arry[idx]
local str2=FMT.fmt('出战弟子最高为{0}',str[2])
if#dizixenyidesc==1 then
str2='上述弟子皆可为全队提升20%伤害'
end
self.dizidesc3:setText(str2)
end




end
end


function UISubAct_fyslZenYiWin:onHide()

end

function UISubAct_fyslZenYiWin:onBlackBG()
self:closeSelf()
end

function UISubAct_fyslZenYiWin:onBtnClose()
self:closeSelf()
end

function UISubAct_fyslZenYiWin:onClickMask()
end

function UISubAct_fyslZenYiWin:onFazebtn()
UISubAct_fyslZenYiWin:onClickshowPanel(2)
end
function UISubAct_fyslZenYiWin:onDizibtn()
UISubAct_fyslZenYiWin:onClickshowPanel(1)
end


function UISubAct_fyslZenYiWin:onClickshowPanel(index)
if _this.page==index then
return
end
_this.page=index
if index==1 then
_this.fazeimg:setActive(false)
_this.diziimg:setActive(true)
_this.dizipanel:setActive(true)
_this.fazepanel:setActive(false)
else
_this.fazeimg:setActive(true)
_this.diziimg:setActive(false)
_this.dizipanel:setActive(false)
_this.fazepanel:setActive(true)
end
end


function UISubAct_fyslZenYiWin:onClickSkill(fazeData)
local x=-146+78
local txParam=fazeData
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
local name=fazeCfg.name
local icon=fazeCfg.image
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc

local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(x,245),
}
}
self:showWindow('UISimpleTeXingTipsWin',args)
end

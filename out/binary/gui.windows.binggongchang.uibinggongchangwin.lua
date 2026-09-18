







def_class("UIBingGongChangWin",UIWindowBase)









function UIBingGongChangWin:bindComponents()

self.root=UIObject.get(self,0)
self.luzi=UIObject.get(self,1)
self.diziModel=UIObject.get(self,2)
self.selectPanel=UIObject.get(self,3)
self.selectBg=UIButton.get(self,4)
self.flyIcon=UIImage.get(self,5)
self.jinglianProgressBar=UIObject.get(self,6)
self.rightPanel=UIObject.get(self,7)
self.selectCntSlider=UIObject.get(self,8)
self.baoxiang=UIButton.get(self,9)
self.helpBtn_1=UIButton.get(self,10)
self.helpBtn_2=UIButton.get(self,11)
self.lianzhiRoot=UIObject.get(self,12)
self.btnLianzhiFinish=UIButton.get(self,13)
self.btnLianzhi=UIButton.get(self,14)
self.costItems=UIObject.get(self,15)
self.item1=UIBaseItem.get(self,16)
self.effect_4=UIObject.get(self,17)
self.effect_3=UIObject.get(self,18)
self.effect_2=UIObject.get(self,19)
self.effect_1=UIObject.get(self,20)
self.selectItemBtn=UIButton.get(self,21)
self.wieghtRoot=UIObject.get(self,22)
self.handleImg=UIObject.get(self,23)
self.subBtn=UIButton.get(self,24)
self.addBtn=UIButton.get(self,25)
self.closeBtn=UIButton.get(self,26)
self.emptyImg=UIObject.get(self,27)
self.selectname=UIText.get(self,28)
self.ScrollView=UIObject.get(self,29)
self.jieshuScrollview=UIObject.get(self,30)
self.nameBg=UIObject.get(self,31)
self.blueRoot=UIObject.get(self,32)
self.purpleRoot=UIObject.get(self,33)
self.orangeRoot=UIObject.get(self,34)
self.redRoot=UIObject.get(self,35)
self.greenRoot=UIObject.get(self,36)
self.costText=UILinkImageText.get(self,37)
self.progress=UIObject.get(self,38)
self.lianzhiTitle=UIText.get(self,39)
self.lianzhiGetBtn=UIButton.get(self,40)
self.lianzhiDesc=UIText.get(self,41)
self.jlReddot=UIObject.get(self,42)
self.handleImgCenter=UIObject.get(self,43)
self.progressBar=UIProgressBarAni.get(self,44)
self.taozhuangGrid=UIObject.get(self,45)
self.cailiaoImg=UIImage.get(self,46)
self.dzName=UIText.get(self,47)
self.scrollView2=UIObject.get(self,48)
self.skill=UIText.get(self,49)
self.btnSwitch=UIObject.get(self,50)
self.btnSelect=UIObject.get(self,51)
self.taozhuangRoot=UIObject.get(self,52)
self.countText=UIText.get(self,53)
self.cailiaoText=UILinkImageText.get(self,54)
self.item6=UIBaseItem.get(self,55)
self.sunhuilv=UIText.get(self,56)
self.diziLock=UIText.get(self,57)
self.diziInfo=UIObject.get(self,58)
self.Dropdown1=UIDropdownEx.get(self,59)
self.jinglianCount=UIText.get(self,60)
self.jinglianCountMax=UIText.get(self,61)
self.costImg=UIImage.get(self,62)
self.lianzhiNum=UIText.get(self,63)

self.selectBg:setButtonClick(function()self:onSelectBg()end)

self.baoxiang:setButtonClick(function()self:onBaoxiang()end)

self.helpBtn_1:setButtonClick(function()self:onHelpBtn_1()end)

self.helpBtn_2:setButtonClick(function()self:onHelpBtn_2()end)

self.btnLianzhiFinish:setButtonClick(function()self:onBtnLianzhiFinish()end)

self.btnLianzhi:setButtonClick(function()self:onBtnLianzhi()end)

self.selectItemBtn:setButtonClick(function()self:onSelectItemBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.lianzhiGetBtn:setButtonClick(function()self:onLianzhiGetBtn()end)
self.helpBtn={
self.helpBtn_1,
self.helpBtn_2,
}
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
self.effect_4,
}



end


function UIBingGongChangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.luzi);self.luzi=nil;
_UIObject_release(self.diziModel);self.diziModel=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.jinglianProgressBar);self.jinglianProgressBar=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.baoxiang);self.baoxiang=nil;
_UIObject_release(self.helpBtn_1);self.helpBtn_1=nil;
_UIObject_release(self.helpBtn_2);self.helpBtn_2=nil;
_UIObject_release(self.lianzhiRoot);self.lianzhiRoot=nil;
_UIObject_release(self.btnLianzhiFinish);self.btnLianzhiFinish=nil;
_UIObject_release(self.btnLianzhi);self.btnLianzhi=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.effect_4);self.effect_4=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.selectItemBtn);self.selectItemBtn=nil;
_UIObject_release(self.wieghtRoot);self.wieghtRoot=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyImg);self.emptyImg=nil;
_UIObject_release(self.selectname);self.selectname=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.jieshuScrollview);self.jieshuScrollview=nil;
_UIObject_release(self.nameBg);self.nameBg=nil;
_UIObject_release(self.blueRoot);self.blueRoot=nil;
_UIObject_release(self.purpleRoot);self.purpleRoot=nil;
_UIObject_release(self.orangeRoot);self.orangeRoot=nil;
_UIObject_release(self.redRoot);self.redRoot=nil;
_UIObject_release(self.greenRoot);self.greenRoot=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.lianzhiTitle);self.lianzhiTitle=nil;
_UIObject_release(self.lianzhiGetBtn);self.lianzhiGetBtn=nil;
_UIObject_release(self.lianzhiDesc);self.lianzhiDesc=nil;
_UIObject_release(self.jlReddot);self.jlReddot=nil;
_UIObject_release(self.handleImgCenter);self.handleImgCenter=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.taozhuangGrid);self.taozhuangGrid=nil;
_UIObject_release(self.cailiaoImg);self.cailiaoImg=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.taozhuangRoot);self.taozhuangRoot=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.cailiaoText);self.cailiaoText=nil;
_UIObject_release(self.item6);self.item6=nil;
_UIObject_release(self.sunhuilv);self.sunhuilv=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.jinglianCount);self.jinglianCount=nil;
_UIObject_release(self.jinglianCountMax);self.jinglianCountMax=nil;
_UIObject_release(self.costImg);self.costImg=nil;
_UIObject_release(self.lianzhiNum);self.lianzhiNum=nil;
self.helpBtn=nil;
self.effect=nil;
end


















local _dropItemHeight=40
local _dropViewHeight=220
local _this=nil

function UIBingGongChangWin:onLoaded(...)
self:bindComponents()
_this=self
self.weightWidgetList={self.greenRoot,self.blueRoot,self.purpleRoot,self.orangeRoot,self.redRoot,}

self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(...)end)
self.sortTypeIdx=0
self.diziSkillLevel=0
self.sortCondition={}
self.sortOrder=eSortOrder.eDown

self.selectStage=self.selectStage or 4

self:setDropdowns()
self.item1:setBaseItemClickEvent(function(...)
if not self.isClose then
self:onSelectItemClick(...)
end
end)

self.item6:setBaseItemClickEvent(function(...)
if not self.isClose then



self:showMaterialsSelectGrids(...)


end
end)



self._onProgressUpdateAction=function(...)
self:onProgressUpdateAction(...)
end
self.progressBar:setFinishAction(function(...)self:onProgressBarFinishAction(...)end)
self.progressBar:setUpdateAction(self._onProgressUpdateAction)
end


local sortToIdx={0,BGF_EQUIP_TYPE.eClothes,BGF_EQUIP_TYPE.eWeapon}
function UIBingGongChangWin:onDropdownChange(idx)
self.sortTypeIdx=sortToIdx[idx+1]

self:freshProvideSelectGrids()
end

function UIBingGongChangWin:onDropdownCreate(scrollTrans,contentTrans)
local idx=self.sortTypeIdx and self.sortTypeIdx-1 or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=idx*_dropItemHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIBingGongChangWin:setDropdowns()
local option={'全部部位','装备','武器'}
self.Dropdown1:setOption(option)
self.Dropdown1:setValue(0)
end


function UIBingGongChangWin:__delete()
self:unbindComponents()
_this=nil
uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIBingGongChangWin')
self.currDZ=nil
end


function UIBingGongChangWin:onHide()

end





function UIBingGongChangWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.2)
tween:SetDelay(0.15)
self.JINGLIANMAX=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"rewards")[1]
self.jinglianCountMax:setText(self.JINGLIANMAX)
end
if argtable then
local guid=argtable.entityId

self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)

end
self.selectCnt=1
self:freshInfo()
end

function UIBingGongChangWin:getDZId()
local selectdizi=bingGongChangModel:getDiziData()
local dzid=selectdizi and selectdizi.guid or 0
if tostring(dzid)=='0'then return end
return dzid
end

function UIBingGongChangWin:freshInfo()
self.selectCnt=1
local lianzhiData=bingGongChangModel:getLianZhiData()
if lianzhiData then
local startTime=bingGongChangModel:getStartTime()
if startTime>0 then
if lianzhiData.equipItemId~=0 then
self.showItemId=lianzhiData.equipItemId
self.selectStage=itemsConfig.getConfig(self.showItemId).stage
end
if lianzhiData.equipNum~=0 then
self.selectCnt=lianzhiData.equipNum
end
if lianzhiData.tsItemId~=0 then
self.selectMaterial=lianzhiData.tsItemId
end
end
end
local diziguid=self:getDZId()
self.diziguid=tostring(diziguid)=='0'and 0 or diziguid
self:refreshState()

self:freshDiziInfo()

self:refreshSelectEquip()
self:refreshJingLianVal()
end

function UIBingGongChangWin:hasDizi()

local selectdizi=bingGongChangModel:getDiziData()or{}
if selectdizi.guid and UIDiscipleModel:getDiscipleData(selectdizi.guid)~=nil then
return true
end
if self.isInLianZhiState and selectdizi.discipleimage and selectdizi.discipleimage~=0 then
return true
end
return false
end

function UIBingGongChangWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.dzId,config=data})
end


function UIBingGongChangWin:freshDiziInfo()
local diziguid=self.diziguid
local name=''
local haveDzBase=diziguid and diziguid~=0 and UIDiscipleModel:getDiscipleData(diziguid)~=nil
local selectdizi=bingGongChangModel:getDiziData()
local haveDz=self:hasDizi()

self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
if haveDzBase then
name=UIDiscipleModel:getDiscipleName(diziguid)
self.dzName:setText(FMT.fmt('炼制弟子：<color=#7d3b17>{0}</color>',name))

local bd_tybe_cfg=cfg_monijybuildconfig_get(SLG_SYSTEM_TYPE.eBingGongFang)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=0
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
level=UIDiscipleModel:getDiscipleJobLevel(diziguid,skill_id)
local content=string.format('%s等级：<color=#7d3b17>%s级</color>',skill_cfg.name,level)
self.skill:setText(content)
end
self.diziSkillLevel=level

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(diziguid,bd_tybe_cfg.build_type,1)
if self.dizi_speciality and#self.dizi_speciality>0 then
self.scrollView2:setActive(true)
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
local grids=self.scrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
else
self.scrollView2:setActive(false)
end
else
if haveDz then
self.dzName:setText(FMT.fmt('炼制弟子：<color=#7d3b17>{0}</color>',selectdizi.dzName))
local bd_tybe_cfg=cfg_monijybuildconfig_get(SLG_SYSTEM_TYPE.eBingGongFang)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=0
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
level=selectdizi.lqLevel
local content=string.format('%s等级：<color=#7d3b17>%s级</color>',skill_cfg.name,level)
self.skill:setText(content)
end
self.diziSkillLevel=level
end
end
self:refreshTaoChuang()
self:freshDzModel()
end

function UIBingGongChangWin:refreshProSkillLevel()
if not self:hasDizi()then
return
end

local bd_tybe_cfg=cfg_monijybuildconfig_get(SLG_SYSTEM_TYPE.eBingGongFang)
local skill_id=bd_tybe_cfg.pro_skill_id
local level=0
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
level=UIDiscipleModel:getDiscipleJobLevel(self.diziguid,skill_id)
local effect=nil
if skill_cfg.buildplant_effects then
effect=skill_cfg.buildplant_effects[level]
end
local content=string.format('%s：%s级',skill_cfg.name,level)
self.skill:setText(content)
end
self.diziSkillLevel=level
end

function UIBingGongChangWin:createDZ(pos,callback)
local diziData=bingGongChangModel:getDiziData()
local modelParams
if diziData then
if diziData.guid then
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(diziData.guid)
else
if self.isInLianZhiState then
local image=UIDiscipleModel.calculationDiscipleImageBase(diziData)
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
else
modelParams={body=1113004}
end
end
else
modelParams={body=1113004}
end



local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos={-100,-20},
rightPos={-50,-20},
waitspeak=0,


}
local tran=self.diziModel:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local model=modelParams.body
uiAIManager:createUIObject('UIBingGongChangWin','bt_ui_bgf',INSTANCE_TYPE.eUIDisciple,model,
tran,vpos,initData,{componets=modelParams.componets},function(bt)
callback(bt)
end)
end


function UIBingGongChangWin:freshDzModel()

if self.currDZ then
uiAIManager:removeUIInstance(self.currDZ)
end
self.currDZ=nil
self:createDZ(Vector2.New(-100,-20),function(bt)
self.currDZ=bt
end)
end


function UIBingGongChangWin:getSpeakText(bt,tkey)
local hasDizi=self:hasDizi()
local txt='1'
local speakText=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"speakText")
if hasDizi then
local hasMainItem=self:hasPutMainItem()
if hasMainItem then
if self.isInLianZhiState then
if self.lianZhiState==2 then
txt=speakText[5][math.random(1,#speakText[5])]
else
txt=speakText[4][math.random(1,#speakText[4])]
end
else
txt=speakText[3][math.random(1,#speakText[3])]
end
else
txt=speakText[2][math.random(1,#speakText[2])]
end
else
txt=speakText[1][math.random(1,#speakText[1])]
end

bt:setSharedVar(tkey,txt)
end

function UIBingGongChangWin:getBuildSpeakConfig(diziguid)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'lianqi')
local txt=speakList[math.random(1,#speakList)]or''
return txt
end

function UIBingGongChangWin:hasPutMainItem()
return self.showItemId~=nil
end

function UIBingGongChangWin:refreshSelectEquip()
local checkSelect=self.showItemId~=nil
self.selectItemBtn:setActive(not checkSelect)
self.item1:setActive(checkSelect)
self.costItems:setActive(checkSelect)
self.wieghtRoot:setActive(checkSelect)

if checkSelect then
local itemId=self.showItemId
local conf={showname=false}
local item_data={itemid=itemId,itemcount=0}
self.item1:setChildPropData(itemsComponentHelper.getCommonFillData(item_data,conf))

self:refreshConsume()
local proLv=self.diziSkillLevel
local cfg=cfgHelper.get(cfg_binggongfanglianqileveloddsconfig_get,proLv)
if not cfg then
local all=cfg_binggongfanglianqileveloddsconfig()
cfg=all[#all]
end
self.sunhuilv:setText(FMT.fmt("{0}%",cfg.badOdds[itemsConfig.getConfig(itemId).stage]/100))
else
self.sunhuilv:setText("0%")
end
if not self.isInLianZhiState and self.selectMaterial then
if itemsModel.getCount(self.selectMaterial)==0 then
self.selectMaterial=nil
end
end
if self.selectMaterial then

local conf={showname=false,itemcount=''}
local item_data={itemid=self.selectMaterial,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
self.item6:setChildPropData(prop)
else
local conf={showname=false,itemcount=''}
local prop=itemsComponentHelper.getCommonFillData(nil,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
self.item6:setChildPropData(prop)
end
self:refreshWeight(checkSelect)
self:resetSelectCount()
end

function UIBingGongChangWin:refreshMaterialCount(itemcount)
local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,5)]=itemcount>1
prop[PropIndex(DataPropKey.eWidgetText,4)]=itemcount>1 and itemcount or''
self.item6:setChildPropData(prop)
end

function UIBingGongChangWin:refreshWeight(flag)
self.wieghtRoot:setActive(flag)
if flag then
local itemId=self.showItemId
local selectMaterial=self.selectMaterial
local weightList=bingGongChangModel:getLianZhiWeight(itemsConfig.getConfig(itemId).stage,self.diziSkillLevel,selectMaterial)or{}

for i=1,5 do
local color=i
local cmp=self.weightWidgetList[i]
local cmpIdx=cmp:getID()
local num=weightList[color][1]
local flag=weightList[color][2]
num=num/100
if num<0 then
num=0
end
local numStr1=string.format('%.1f',num)
local num2=math.floor(num)
local num1=tonumber(numStr1)
local isIntValue=num1==num2
local numStr=isIntValue and num2 or numStr1
self.winlua:SetChildActive(cmpIdx,true)
local widget=self.winlua:GetChildWidgetBase(cmpIdx)
widget:SetChildText(0,numStr)
widget:SetChildActive(1,flag==1)
widget:SetChildActive(2,flag==2)
end
end
end

function UIBingGongChangWin:refreshTaoChuang()
local hasDizi=self.diziguid and self.diziguid~=0
if hasDizi then
if not self.suitMap then
local showSuitList=equipsHelper.getFilterSuit()
local suitMap={}
for i,v in ipairs(showSuitList)do
suitMap[v.id]=true
end
self.suitMap=suitMap
end

self.taozhuangRoot:setActive(true)
local voc=UIDiscipleModel:getDiscipleJob(self.diziguid)
local taozhuangCfg=cfgHelper.get(cfg_binggongfangtaozhuangconfig_get,voc)
if taozhuangCfg then
local ttable={}
for i,v in ipairs(taozhuangCfg.taozhuang)do
if self.suitMap[v]then
table.insert(ttable,v)
end
end
self.taozhuangGrid:setChildLayoutGroupCreateItems(#ttable)
local grids=self.taozhuangGrid:getChildLayoutGroupGridList()
for i=0,grids.Count-1 do
local tzcfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,ttable[i+1])
grids[i]:SetChildText(0,tzcfg.name)
grids[i]:SetChildIcon(1,equipsHelper.getEquipSuitIconById(tzcfg.id),true)

end
end
else
self.taozhuangRoot:setActive(false)
end
end

function UIBingGongChangWin:refreshState(lianZhiState)
if not lianZhiState then
lianZhiState=bingGongChangModel:lianZhiState()
end
self.btnLianzhi:setActive(lianZhiState==0)
self.btnLianzhiFinish:setActive(lianZhiState==2)
self.lianzhiRoot:setActive(lianZhiState==1)
self.selectCntSlider:setActive(lianZhiState==0)
self.isInLianZhiState=lianZhiState~=0
self.lianZhiState=lianZhiState

if lianZhiState==1 then
local time=timeHelper.getServerShortTime()
local perTime=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"needTime")
local needTime=perTime*self.selectCnt

local startTime=bingGongChangModel:getStartTime()
self.startTime=startTime
self.targetTime=needTime+startTime
self.needTime=needTime
self.perTime=perTime
self.progressBar:animateFiveParams((needTime-(needTime+startTime-time))/needTime*100,100,100,needTime+startTime-time+1)
self:refreshLianZhiFinNum()

self.effect_1:setChildShowEffect(10507,true)

self.effect_3:setChildShowEffect(10509,true)
self.effect_4:setChildShowEffect(10510,true)
else
self.lianzhiGetBtn:setActive(false)
for i,c in ipairs(self.effect)do
c:setChildShowEffect(0,false)
end
end
end

function UIBingGongChangWin:onProgressBarFinishAction()
self:refreshState()
end

function UIBingGongChangWin:onProgressUpdateAction(div,updateTime)

local time=timeHelper.getServerShortTime()
if self.targetTime-time<=self.needTime and self.targetTime-time>=0 then
self.lianzhiTitle:setText(FMT.fmt("（炼制时间：{0}）",timeHelper.format_time_stamp(self.targetTime-time)))
self:refreshLianZhiFinNum()
else
if self.targetTime-time<=0 then
self:refreshState(2)
end
end

end

function UIBingGongChangWin:refreshLianZhiFinNum()
local time=timeHelper.getServerShortTime()
local num=math.floor((time-self.startTime)/self.perTime)
self.lianzhiGetBtn:setActive(num>0 and self.lianZhiState~=2)
if num>0 then
self.lianzhiNum:setText(num)
end
local last=self.finNum or 0
self.finNum=num
if num>last then
self.effect_2:setChildShowEffect(10508,true)


AudioManager.playAudio(641)
end
end

function UIBingGongChangWin:resetSliderInit()
local showSlider=not self.isInLianZhiState
self.selectCntSlider:setActive(showSlider)
if showSlider then
local mixCount=1
local curSeclet=self.selectCnt
local maxCnt=self.maxUseCnt

if self.maxUseCnt<1 then
mixCount=1
curSeclet=1
maxCnt=1
else
if curSeclet<mixCount then
curSeclet=mixCount
self.selectCnt=mixCount
end
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),mixCount==1 and not self.isInLianZhiState)
self.winlua:SetChildImageRaycast(self.handleImgCenter:getID(),mixCount==1 and not self.isInLianZhiState)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),not self.isInLianZhiState)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),not self.isInLianZhiState)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,mixCount,maxCnt,self.on_slider_change)
end
end

function UIBingGongChangWin.on_slider_change(value)
_this:onSliderChange(value)
end

function UIBingGongChangWin:onSliderChange(value)
self.selectCnt=value
self:refreshCountText()
self:refreshConsume()
end

function UIBingGongChangWin:getMaxUseCnt()
local checkSelect=self.showItemId~=nil
if not checkSelect then
return 0
end
local baseConfig=cfgHelper.get(cfg_binggongfangbaseconfig_get,1)
local numMax=baseConfig.numMax

local useItem=baseConfig.useItem[self.selectStage]
local max=numMax
local moneyCount=itemsModel.getCount(useItem[1])
if moneyCount<useItem[2]*numMax then
max=math.floor(moneyCount/useItem[2])
end
local itemId=self.showItemId
if itemId then
local itemCfg=itemsConfig.getConfig(itemId)
local consumeCfg=cfg_binggongfangmaterialsconfig_get(itemCfg.stage)[itemCfg.type1]
local moneyCount=itemsModel.getCount(consumeCfg.materials[1])
local cmax=max

if moneyCount<consumeCfg.materials[2]*max then
cmax=math.floor(moneyCount/consumeCfg.materials[2])
end
max=math.min(max,cmax)
end

if self.selectMaterial then
local materialCount=itemsModel.getCount(self.selectMaterial)
if max>materialCount then
max=materialCount
end
end

return max
end

function UIBingGongChangWin:refreshCountText()
self.countText:setText(FMT.fmt("炼制数量：{0}",self.selectCnt))

local itemId=self.showItemId
if itemId then
local itemCfg=itemsConfig.getConfig(itemId)
local consumeCfg=cfg_binggongfangmaterialsconfig_get(itemCfg.stage)[itemCfg.type1]
self.cailiaoImg:setActive(true)
self.cailiaoImg:setChildIcon(iconHelper.getIconName(consumeCfg.materials[1]))
local have=itemsModel.getCount(consumeCfg.materials[1])
local need=self.selectCnt*consumeCfg.materials[2]
self.cailiaoText:setText(have>=need and FMT.fmt("需要材料：{0}",need)or FMT.fmt("需要材料：<color=#c82c2c>{0}</color>",need))
else
self.cailiaoImg:setActive(false)
self.cailiaoText:setText("需要材料：0")
end
end

function UIBingGongChangWin:refreshConsume()

if not self:hasPutMainItem()then
self.costImg:setActive(false)
self.costText:setText(0)
return
end
local selectNum=self.selectCnt or 1

local baseConfig=cfgHelper.get(cfg_binggongfangbaseconfig_get,1)
local useItem=baseConfig.useItem[self.selectStage or 3]
if useItem then
local iconname=iconHelper.getIconName(useItem[1])

self.costImg:setActive(true)
self.costImg:setChildIcon(iconname)
self.costText:setText(useItem[2]*selectNum)
end

if self.selectMaterial then
self:refreshMaterialCount(self.selectCnt)
end
end


function UIBingGongChangWin:resetSelectCount()

self.maxUseCnt=self:getMaxUseCnt()

self:resetSliderInit()

self:refreshCountText()
self:refreshConsume()
end

function UIBingGongChangWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIBingGongChangWin:showProvideSelectGrids()
if self.isInLianZhiState then
UIManager.error("炼制中")
return
end




if self.showDialogue then
self:freshProvideSelectGrids(true)
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)

end

function UIBingGongChangWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self.curPageIndex=1
self.isSetZero=false
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)


end

function UIBingGongChangWin:freshStageList()
local jieshuLimit=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"jieshuLimit")
local stageList={}
local zongmenLv=zongmenModel:getLevel()
local worldLv=zongmenModel:getWorldLevel()

for i,v in pairs(jieshuLimit)do
local wjieshuLimit=cfgHelper.get2(cfg_guildexpconfig_get,v)
if wjieshuLimit and wjieshuLimit.worldlevel<=worldLv then
table.insert(stageList,{i,v})
end
end
local num=#stageList
self.stageList=stageList
self.jieshuScrollview:setChildScrollViewCreateGrids(num,1)
local grids=self.jieshuScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
if grid then
local stage=stageList[i][1]
local zmLvLimit=stageList[i][2]
local check=zongmenLv>=zmLvLimit
grid:SetChildText(2,FMT.fmt("{0}阶",stage))
grid:SetChildButtonClick(3,function()
if check then
self:onStageClick(grid,i,stage)
else
UIManager.error(FMT.fmt("宗门{0}级开启",zmLvLimit))
end
end)
grid:SetChildActive(0,self.selectStage==stage)

if self.selectStage==stage then
self.selectStageIndex=i
end

grid:SetChildActive(1,not check)
end
end

end

function UIBingGongChangWin:checkStage(stage)
local zongmenLv=zongmenModel:getLevel()
local jieshuLimit=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"jieshuLimit")
if jieshuLimit[stage]and zongmenLv<jieshuLimit[stage]then
return false,jieshuLimit[stage]
end
return true
end

function UIBingGongChangWin:onStageClick(grid,i,stage)
if self.selectStageIndex then
local oldGrid=self.jieshuScrollview:getChildScrollViewItemWidget(self.selectStageIndex-1)
oldGrid:SetChildActive(0,false)
end
grid:SetChildActive(0,true)
self.selectStageIndex=i
self.selectStage=stage
self:freshProvideSelectGrids()
end

function UIBingGongChangWin:freshProvideSelectGrids()
self.selectStage=self.selectStage or 4
self.jieshuScrollview:setActive(true)
self.Dropdown1:setActive(true)
if not self.initStageList then
self:freshStageList()
self.initStageList=true
end
self.emptyImg:setActive(false)
self.selectname:setText("选择部位")
local list=bingGongChangController:getEquipFilter(self.sortTypeIdx,self.selectStage)
self.ScrollView:setChildScrollViewCreateGrids(#list,1)
local grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
if grid then
local itemList=list[i]
local itemid=itemList[#itemList]
for _,v in ipairs(itemList)do
if v>itemid then
itemid=v
end
end
if itemid then
grid:SetChildText(0,itemsConfig.getItemName(itemid))
local conf={showname=false}
local item_data={itemid=itemid,itemcount=0}
grid:SetChildPropData(3,itemsComponentHelper.getCommonFillData(item_data,conf))
grid:SetBaseItemClickEvent(3,itemsComponentHelper.onItemClick)

local type2=itemsConfig.getConfig(itemid).type2
local vocList=equipsHelper.getLimitVoc(type2)or{}
local vocDesc=''
local hasLimit=false
local index=1
for ii,v in ipairs(vocList)do
local vocationConfig=equipsConfig.getDiziVocationConfig(v)
local hide=vocationConfig.hide
if not hide then
local name=vocationConfig.name
local split=''
local enter=index==4 and'\n'or''
vocDesc=FMT.fmt('{0}{1}{3}[{2}]',vocDesc,split,name,enter)
hasLimit=true
index=index+1
end
end
if hasLimit then
grid:SetChildText(1,vocDesc)
else
grid:SetChildText(1,'[全职业]')
end

grid:SetChildCSImageSprite(2,globalABLookup.global,"button_chuangkou_2")
grid:SetChildText(4,self.showItemId==itemid and"已选"or"选择")
grid:SetChildCSImageSprite(2,globalABLookup.global,self.showItemId==itemid and"button_chuangkou_4"or"button_chuangkou_2")
grid:SetChildButtonClick(2,function()
self:onSelectEquip(itemid,itemList)
end)
end
end
end
end

function UIBingGongChangWin:onSelectEquip(itemid,itemList)
local check,limit=self:checkStage(self.selectStage)
if not check then
UIManager.error(FMT.fmt("宗门{0}级开启",limit))
return
end

if self.showItemId==itemid then
return
end

local old=self.showItemId
self.showItemId=itemid
if old then
UIManager.info("切换成功")
end
self:closeProvideSelectGrids()

self:refreshSelectEquip()
end


function UIBingGongChangWin:showMaterialsSelectGrids()
if self.isInLianZhiState then
UIManager.error("炼制中")
return
end
if not self:hasPutMainItem()then
UIManager.error("请选择炼制部位")
return
end
if self.showDialogue then
self:freshMaterialsSelectGrids()
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshMaterialsSelectGrids()
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
end

function UIBingGongChangWin:closeMaterialsSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false


self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)


end

function UIBingGongChangWin:freshMaterialsSelectGrids()
self.jieshuScrollview:setActive(false)
self.Dropdown1:setActive(false)
local list=bingGongChangController.getItemsMaterials(true)
table.sort(list,function(a,b)return(cfgHelper.get(cfg_binggongfangteshumaterialsconfig_get,a.itemid,"sort")or 0)<(cfgHelper.get(cfg_binggongfangteshumaterialsconfig_get,b.itemid,"sort")or 0)end)
self.ScrollView:setChildScrollViewCreateGrids(#list,1)
self.emptyImg:setActive(#list==0)
self.selectname:setText("选择材料")
local grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
if grid then
local itemData=list[i]

if itemData then

local conf={showname=false}
local item_data={itemid=itemData.itemid,itemcount=itemData.itemcount}
grid:SetChildPropData(3,itemsComponentHelper.getCommonFillData(item_data,conf))
grid:SetBaseItemClickEvent(3,itemsComponentHelper.onItemClick)
grid:SetChildText(0,itemsConfig.getItemName(itemData.itemid))
local desc=cfgHelper.get(cfg_binggongfangteshumaterialsconfig_get,itemData.itemid).desc or""
grid:SetChildText(1,FMT.fmt(desc))
grid:SetChildText(4,itemData.itemid==self.selectMaterial and"取消"or"选择")
grid:SetChildCSImageSprite(2,globalABLookup.global,itemData.itemid==self.selectMaterial and"button_chuangkou_4"or"button_chuangkou_2")
grid:SetChildButtonClick(2,function()
self:onSelectMaterial(itemData)
end)
end
end
end
end
function UIBingGongChangWin:onSelectMaterial(itemData)
if itemData.itemid==self.selectMaterial then
self.selectMaterial=nil
else
self.selectMaterial=itemData.itemid

UIManager.info("选择成功")
end


self:closeProvideSelectGrids()

self:refreshSelectEquip()

end

function UIBingGongChangWin:refreshJingLianVal()
local val=bingGongChangModel:getJingLianVal()
self.jinglianCount:setText(val)
self.jinglianProgressBar:setChildUIProgressbar(val,self.JINGLIANMAX)
self.jlReddot:setActive(val>=self.JINGLIANMAX)
end





function UIBingGongChangWin:onSelectBg()
self:closeProvideSelectGrids()
end



function UIBingGongChangWin:onCloseBtn()
end



function UIBingGongChangWin:onBtnLianzhi()

if not self:hasDizi()then
UIManager.error("未安排弟子")
return
end
if not self:hasPutMainItem()then
UIManager.error("请选择炼制部位")
return
end
local tsItemId=0
if self.selectMaterial then
tsItemId=self.selectMaterial
end
local itemId=self.showItemId
if itemId then
local itemCfg=itemsConfig.getConfig(itemId)
local consumeCfg=cfg_binggongfangmaterialsconfig_get(itemCfg.stage)[itemCfg.type1]
if itemsModel.getCount(consumeCfg.materials[1])<consumeCfg.materials[2]then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(consumeCfg.materials[1])))
gainControl:showGainWin(consumeCfg.materials[1])
return
end
end
local baseConfig=cfgHelper.get(cfg_binggongfangbaseconfig_get,1)
local useItem=baseConfig.useItem[self.selectStage]
moneySystem:useMoney(useItem[1],useItem[2]*self.selectCnt,function()
bingGongChangController.req_6_98(self.showItemId,self.selectCnt,tsItemId,self.diziguid)

AudioManager.playAudio(640)
end,WARNING_TYPE.eWarning)


end



function UIBingGongChangWin:onBtnReward()
end



function UIBingGongChangWin:onBtnStopLianzhi()
end



function UIBingGongChangWin:onSelectItemBtn()
self:showProvideSelectGrids()
end

function UIBingGongChangWin:onCloseSelect()
self:closeProvideSelectGrids()
end



function UIBingGongChangWin:onAddBtn()
if not self:hasPutMainItem()then
UIManager.error("请选择炼制部位")
return
end
if self.selectCnt==0 or self.maxUseCnt<1 then
UIManager.error("炼制材料不足")
return
end
if self.selectMaterial then
local materialCount=itemsModel.getCount(self.selectMaterial)
if self.selectCnt+1>materialCount then
UIManager.error("炼制数量不能超过天工锤数量")
return
end
end


if self.selectCnt<self.maxUseCnt then
self.selectCntSlider:setChildSliderValue(self.selectCnt+1)

else
if self.maxUseCnt==50 then
UIManager.error("炼制数量达到上限")
else
UIManager.error("炼制材料不足")
end

end
end



function UIBingGongChangWin:onSubBtn()
if not self:hasPutMainItem()then
UIManager.error("请选择炼制部位")
return
end
if self.selectCnt==0 or self.maxUseCnt<1 then
return
end
if self.selectCnt>1 then
self.selectCntSlider:setChildSliderValue(self.selectCnt-1)

end
end

function UIBingGongChangWin:onEdgeEvent()

end


function UIBingGongChangWin:onClickSelect()
if self.isInLianZhiState then
UIManager.error("炼制中")
return
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eBingGongFang)
local args={
openType=dzSelectWinOpenType.eBingGongFang,
bdData=self.bdData,
sfId=self.sfId,
funcIndex=1,
callback=function(dzId)
if dzId==0 then
bingGongChangModel:setDiziData()
else
bingGongChangModel:setDiziData({guid=dzId})
end


self:freshInfo()
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIBingGongChangWin:onBaoxiang()
local val=bingGongChangModel:getJingLianVal()
if val>=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"rewards")[1]then
bingGongChangController.req_6_97()
else
UIManager.error("装备打造不足")
end
end

function UIBingGongChangWin:onBtnLianzhiFinish()
socketManager:send_6_96()
end

function UIBingGongChangWin:onHelpBtn_1()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_bgf_help1_%s'})
end

function UIBingGongChangWin:onHelpBtn_2()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_bgf_help2_%s'})
end

function UIBingGongChangWin:onLianzhiGetBtn()
socketManager:send_6_96()
end
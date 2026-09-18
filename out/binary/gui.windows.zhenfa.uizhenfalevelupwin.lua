







def_class("UIZhenFaLevelUpWin",UIWindowBase)









function UIZhenFaLevelUpWin:bindComponents()

self.leftList=UIScrollView.get(self,0)
self.nameTx=UIText.get(self,1)
self.descTx=UIText.get(self,2)
self.levelUpList=UIObject.get(self,3)
self.costTitle=UIText.get(self,4)
self.costBtn=UIButton.get(self,5)
self.costTime=UIText.get(self,6)
self.costBan=UIText.get(self,7)
self.costList=UIScrollView.get(self,8)
self.costBtnTx=UIText.get(self,9)
self.zhenfaEffect=UIObject.get(self,10)
self.extraBtn=UIButton.get(self,11)
self.costBtnReddot=UIObject.get(self,12)

self.costBtn:setButtonClick(function()self:onCostBtn()end)

self.extraBtn:setButtonClick(function()self:onExtraBtn()end)



end


function UIZhenFaLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.levelUpList);self.levelUpList=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.costBtn);self.costBtn=nil;
_UIObject_release(self.costTime);self.costTime=nil;
_UIObject_release(self.costBan);self.costBan=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.costBtnTx);self.costBtnTx=nil;
_UIObject_release(self.zhenfaEffect);self.zhenfaEffect=nil;
_UIObject_release(self.extraBtn);self.extraBtn=nil;
_UIObject_release(self.costBtnReddot);self.costBtnReddot=nil;
end
















local _this=nil
local _selected=nil
local _filterMoney={
[eMoneyType.mtZhenShi]=true
}
local leftItemCmp={
selected=0,
icon=1,
name=2,
lock=3,
reddot=4,
}
local rightUpDescCmp={
before=0,
after=1,
tips=2,
jiantou=3,
}



function UIZhenFaLevelUpWin:onLoaded(...)
self:bindComponents()
_this=self
self:initComponents()
UIManager:showWindow("UITopMoneyWin",{{eMoneyType.mtZhenShi}})
self.gainTable={}
end


function UIZhenFaLevelUpWin:__delete()
self:unbindComponents()
_this=nil
_selected=nil
UIManager:hideWindow("UITopMoneyWin")
end




function UIZhenFaLevelUpWin:onShow(argtable,afterOnloaded)
self.sfId=argtable.sfId
self.bdData=argtable.bdData
table.sort(self.list,self.sortList)
_selected=self:findListIndex(argtable.zfId)or _selected or 1
self:refreshLeftList()
self:refreshRightPanel()

self.winlua:SetUIScrollViewBaseJumpToLockX(self.leftList:getID(),_selected)
end


function UIZhenFaLevelUpWin:onHide()

end





function UIZhenFaLevelUpWin:onPreviewBtn()
UIManager:showWindow("UIZhenFaPreviewWin",{zfId=self.list[_selected]})
end



function UIZhenFaLevelUpWin:onCostBtn()
if zhenfaModel:isZhenFaStudying(self.zfId)then
return UIManager.error("该阵法正在升级中")
end

local levelCfg=self.zfCfg.level[self.zfLv]
local costList=levelCfg[1]
for i,v in ipairs(costList)do
local isMoney=itemsConfig.isMoney(v[1])
local count=isMoney and moneyModel.getMoney(v[1])or bagModel.getItemCountById(v[1])
if count<v[2]then

return gainControl:showGainWin(v[1])
end
end

if self.zfLv>0 then
if self.bdData.dizi_id==int64.zero then
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eZhenFa,dzSelectEffectType.eZhenFa,2)

return UIManager.error("需要安排弟子")
elseif UIDiscipleModel:checkDiscipleState2(self.bdData.dizi_id,DISCIPLE_STATE_TYPE.edsDispatch)then
return UIManager.error("弟子外出中")


end
zhenfaController:send_3_202(self.sfId,self.bdData.un_build_id,self.zfId)
self:closeSelf()
else
zhenfaController:send_3_202(self.sfId,self.bdData.un_build_id,self.zfId)
end
end

function UIZhenFaLevelUpWin:onExtraBtn()
UIManager:showWindow("UIZhenFaExtraWin",{zfId=self.zfId})
end

function UIZhenFaLevelUpWin:onClickLeftList(id,index,guid,attach)
if _selected~=index then
if _selected then
self:refreshLeftItemSelected(_selected,false)
end
_selected=index
self:refreshLeftItemSelected(_selected,true)
self:refreshRightPanel()

if zhenfaModel:isZhenFaStudying(self.zfId)then
UIManager.info("该阵法正在升级中")
end
end
end

function UIZhenFaLevelUpWin:initComponents()
self.list={}
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
table.insert(self.list,i)
end
self.leftList:setClickAction(function(id,index,guid,attach)
self:onClickLeftList(id,index,guid,attach)
end)
self.leftList:freshGridsNum(#self.list,#self.list,1,false)
self.costList:setClickAction(function(...)
self:onClickItem(...)
end)
end

function UIZhenFaLevelUpWin.sortList(a,b)
local aActive=zhenfaModel:canBuildingActive(_this.bdData,a)
local bActive=zhenfaModel:canBuildingActive(_this.bdData,b)
local aScore=aActive and 1 or 0
local bScore=bActive and 1 or 0
if aScore~=bScore then
return aScore>bScore
else
local aLevel=zhenfaModel:getZhenFaData(a)
local bLevel=zhenfaModel:getZhenFaData(b)
aScore=(aLevel>0)and 1 or 0
bScore=(bLevel>0)and 1 or 0
if aScore~=bScore then
return aScore>bScore
else
return a<b
end
end
end

function UIZhenFaLevelUpWin:refreshLeftList()
for i,v in ipairs(self.list)do
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,v)
local item=self.leftList:getGridObjectByindex(i-1)
local level=zhenfaModel:getZhenFaData(v)
local isActived=level>0
local reddot=zhenfaModel:canBuildingActive(self.bdData,v)
item:SetChildActive(leftItemCmp.selected,_selected==i)
item:SetChildCSImageIcon(leftItemCmp.icon,cfg.icon,false)
item:SetChildImageExGray(leftItemCmp.icon,not isActived)
item:SetChildText(leftItemCmp.name,cfg.name)
item:SetChildActive(leftItemCmp.lock,false)
item:SetChildActive(leftItemCmp.reddot,reddot)
end
end

function UIZhenFaLevelUpWin:refreshLeftItemSelected(index,selected)
local item=self.leftList:getGridObjectByindex(index-1)
item:SetChildActive(leftItemCmp.selected,selected)
end

function UIZhenFaLevelUpWin:updateSelectedData()
self.zfId=self.list[_selected]
self.zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,self.zfId)
self.zfLv=zhenfaModel:getZhenFaData(self.zfId)
end

function UIZhenFaLevelUpWin:refreshRightPanel()
self:updateSelectedData()
self.zhenfaEffect:setChildShowEffect(self.zfCfg.effect[1],true)
local upCfg=self.zfCfg.level[self.zfLv]
local isActived=self.zfLv>0
local isMax=upCfg==nil
local isStuding=zhenfaModel:isZhenFaStudying(self.z)
if isActived then
if isMax then
self:setRightPanel_Max()
else
self:setRightPanel_LevelUp()
end
else
self:setRightPanel_Unactived()
end
end

function UIZhenFaLevelUpWin:setRightPanel_Unactived()
self.nameTx:setText(FMT.fmt("{0}（未激活）",self.zfCfg.name))
self.descTx:setText(self.zfCfg.desc[1])
local upDesc=self.zfCfg.updesc[0]
self.levelUpList:setChildLayoutGroupCreateItems(#upDesc,function(index)
local item=self.levelUpList:getChildLayoutGroupGridItem(index-1)
local info=upDesc[index]
item:SetChildText(rightUpDescCmp.tips,info[1])
item:SetChildText(rightUpDescCmp.before,info[2])
item:SetChildText(rightUpDescCmp.after,info[3])
end)
self.costTitle:setText("激活条件")
self.costBtn:setActive(true)
self.costBtnTx:setText("激  活")
local reddot=zhenfaModel:canBuildingActive(self.bdData,self.zfId)
self.costBtnReddot:setActive(reddot)
self.costTime:setText("")
self.gainTable={}
local levelCfg=self.zfCfg.level[0]
if self.bdData.level>=levelCfg[3]then
local costCfg=levelCfg[1]
local costCnt=#costCfg
self.costList:freshGridsNum(costCnt,1,costCnt,true)
self.winlua:SetChildScrollRectEnable(self.costList:getID(),costCnt>3)

local propDatas={}
for i,v in ipairs(costCfg)do
local itemid=v[1]
local need=v[2]
local itemData={
itemid=v[1],
itemcount=v[2]
}
local isMoney=itemsConfig.isMoney(itemid)
local itemCount=isMoney and moneyModel.getMoney(itemid)or bagModel.getItemCountById(itemid)or 0
local gray=itemCount<need
local itemCountStr=mathHelper.formatNumber(need,true)
if not _filterMoney[itemid]then
itemCountStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(itemCount,true),mathHelper.formatNumber(need,true))
end
if gray then
itemCountStr=FMT.cfmt(FONT_COLOR.eRedColor,itemCountStr)
end
local itemConf={
showname=false,
gray=gray and 1 or 0,
itemcount=itemCountStr,
showCountBG=true,
}
self.gainTable[itemid]=need
local propData=itemsComponentHelper.getCommonFillData(itemData,itemConf)
table.insert(propDatas,propData)
end
self.costList:initPropData(propDatas)
self.costBan:setText("")
else
self.costList:freshGridsNum(0,1,0,true)
self.winlua:SetChildScrollRectEnable(self.costList:getID(),false)
self.costBan:setText(FMT.fmt("需要天工阁建筑等级达到{0}级",levelCfg[3]))
end
end

function UIZhenFaLevelUpWin:setRightPanel_Max()
self.nameTx:setText(FMT.fmt("{0}（{1}级）",self.zfCfg.name,self.zfLv))
self.descTx:setText(self.zfCfg.desc[self.zfLv])

self.costTitle:setText("升级条件")
self.costBtn:setActive(false)
self.costTime:setText("")
self.costList:freshGridsNum(0,1,0,true)
self.winlua:SetChildScrollRectEnable(self.costList:getID(),false)
self.costBan:setText("阵法已达到最高等级")
local upDesc=self.zfCfg.updesc[self.zfLv]
self.levelUpList:setChildLayoutGroupCreateItems(#upDesc,function(index)
local item=self.levelUpList:getChildLayoutGroupGridItem(index-1)
local info=upDesc[index]
item:SetChildText(rightUpDescCmp.tips,FMT.fmt("{0}{1}",info[1],info[2]))
item:SetChildText(rightUpDescCmp.before,"")
item:SetChildText(rightUpDescCmp.after,"")
item:SetChildActive(rightUpDescCmp.jiantou,false)
end)
end

function UIZhenFaLevelUpWin:setRightPanel_LevelUp()
self.nameTx:setText(FMT.fmt("{0}（{1}级）",self.zfCfg.name,self.zfLv))
self.descTx:setText(self.zfCfg.desc[self.zfLv])
local upDesc=self.zfCfg.updesc[self.zfLv]
self.levelUpList:setChildLayoutGroupCreateItems(#upDesc,function(index)
local item=self.levelUpList:getChildLayoutGroupGridItem(index-1)
local info=upDesc[index]


item:SetChildText(rightUpDescCmp.tips,FMT.fmt("{0}{1}",info[1],info[2]))
item:SetChildText(rightUpDescCmp.before,"")
item:SetChildText(rightUpDescCmp.after,info[3])
end)
self.costTitle:setText("升级条件")
self.costBtn:setActive(true)
self.costBtnTx:setText("研  究")
self.costBtnReddot:setActive(false)
local levelCfg=self.zfCfg.level[self.zfLv]

local pro_skill_cfg=cfgHelper.get(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local effect=0
if self.bdData.dizi_id and self.bdData.dizi_id~=int64.zero then
local skillLv=UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,DISCIPLE_PROSKILL_TYPE.eZhenFa)
if pro_skill_cfg.tiangongge_discount then
local temp1=pro_skill_cfg.tiangongge_discount[skillLv]
if temp1 and temp1>0 then
effect=effect-temp1
end
end
local dzId=self.bdData.dizi_id
local netData=UIDiscipleModel:getDiscipleData(dzId)
effect=effect+dzSpecialityGrowEffectController:getZhenFaStudyRate(netData)
end
effect=math.ceil(levelCfg[2]*(1+effect/100))
self.costTime:setText(FMT.fmt("研究耗时：<color=#549327>{0}</color>",timeHelper.format_time_stamp2(effect)))

if self.bdData.level>=levelCfg[3]then
local costCfg=levelCfg[1]
local costCnt=#costCfg
self.costList:freshGridsNum(costCnt,1,costCnt,true)
self.winlua:SetChildScrollRectEnable(self.costList:getID(),costCnt>3)
local propDatas={}

for i,v in ipairs(costCfg)do
local itemid=v[1]
local need=v[2]
local itemData={
itemid=v[1],
itemcount=v[2]
}
local isMoney=itemsConfig.isMoney(itemid)
local itemCount=isMoney and moneyModel.getMoney(itemid)or bagModel.getItemCountById(itemid)or 0
local gray=itemCount<need
local itemCountStr=mathHelper.formatNumber(need,true)
if not _filterMoney[itemid]then
itemCountStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(itemCount,true),mathHelper.formatNumber(need,true))
end
if gray then
itemCountStr=FMT.cfmt(FONT_COLOR.eRedColor,itemCountStr)
end

local itemConf={
showname=false,
gray=gray and eGrayType.eGray or 0,
itemcount=itemCountStr,
showCountBG=true,
}
self.gainTable[itemid]=need
local propData=itemsComponentHelper.getCommonFillData(itemData,itemConf)
table.insert(propDatas,propData)
end
self.costList:initPropData(propDatas)
self.costBan:setText("")
else
self.costList:freshGridsNum(0,1,0,true)
self.winlua:SetChildScrollRectEnable(self.costList:getID(),false)
self.costBan:setText(FMT.fmt("需要天工阁建筑等级达到{0}级",levelCfg[3]))
end
end

function UIZhenFaLevelUpWin:refreshItem(sfId,ubdId,zfId,reSort)
if sfId==self.sfId and ubdId==self.bdData.un_build_id then
if reSort then
table.sort(self.list,self.sortList)
_selected=self:findListIndex(zfId)
self:refreshLeftList()
else
local item=self.leftList:getGridObjectByindex(_selected-1)
local level=zhenfaModel:getZhenFaData(zfId)
local isActived=level>0
item:SetChildImageExGray(leftItemCmp.icon,not isActived)
item:SetChildActive(leftItemCmp.lock,false)
local reddot=zhenfaModel:canBuildingActive(self.bdData,zfId)
item:SetChildActive(leftItemCmp.reddot,reddot)
end
if self.zfId==zfId then
self:refreshRightPanel()
end
end
end

function UIZhenFaLevelUpWin:onClickItem(itemId,index,guid,attach)
if itemId==-1 then return end
if gainControl:showGainWin(itemId,self.gainTable[itemId])then return end
itemsComponentHelper.onItemClick(itemId,index,guid,attach)
end

function UIZhenFaLevelUpWin:findListIndex(zfId)
for i,v in ipairs(self.list)do
if v==zfId then
return i
end
end
end








def_class("UIZhenFaChooseWin",UIWindowBase)









function UIZhenFaChooseWin:bindComponents()

self.leftList=UIScrollView.get(self,0)
self.nameTx=UIText.get(self,1)
self.descTx=UIText.get(self,2)
self.extraPanel=UIObject.get(self,3)
self.unactivedPanel=UIObject.get(self,4)
self.chooseBtnTx=UIText.get(self,5)
self.extraLvTx=UIText.get(self,6)
self.extraRoundTx=UIText.get(self,7)
self.extraBtn=UIButton.get(self,8)
self.chooseBtn=UIButton.get(self,9)
self.DragonBone_1=UIObject.get(self,10)
self.DragonBone_2=UIObject.get(self,11)
self.DragonBone_3=UIObject.get(self,12)
self.DragonBone_4=UIObject.get(self,13)
self.DragonBone_5=UIObject.get(self,14)
self.zhenfaEffect=UIObject.get(self,15)
self.levelUpList=UIObject.get(self,16)
self.extraPowerTx=UIText.get(self,17)

self.extraBtn:setButtonClick(function()self:onExtraBtn()end)

self.chooseBtn:setButtonClick(function()self:onChooseBtn()end)
self.DragonBone={
self.DragonBone_1,
self.DragonBone_2,
self.DragonBone_3,
self.DragonBone_4,
self.DragonBone_5,
}



end


function UIZhenFaChooseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.extraPanel);self.extraPanel=nil;
_UIObject_release(self.unactivedPanel);self.unactivedPanel=nil;
_UIObject_release(self.chooseBtnTx);self.chooseBtnTx=nil;
_UIObject_release(self.extraLvTx);self.extraLvTx=nil;
_UIObject_release(self.extraRoundTx);self.extraRoundTx=nil;
_UIObject_release(self.extraBtn);self.extraBtn=nil;
_UIObject_release(self.chooseBtn);self.chooseBtn=nil;
_UIObject_release(self.DragonBone_1);self.DragonBone_1=nil;
_UIObject_release(self.DragonBone_2);self.DragonBone_2=nil;
_UIObject_release(self.DragonBone_3);self.DragonBone_3=nil;
_UIObject_release(self.DragonBone_4);self.DragonBone_4=nil;
_UIObject_release(self.DragonBone_5);self.DragonBone_5=nil;
_UIObject_release(self.zhenfaEffect);self.zhenfaEffect=nil;
_UIObject_release(self.levelUpList);self.levelUpList=nil;
_UIObject_release(self.extraPowerTx);self.extraPowerTx=nil;
self.DragonBone=nil;
end
















local _this=nil
local _selected=nil

local leftItemCmp={
selected=0,
icon=1,
name=2,
lock=3,
}
local rightUpDescCmp={
before=0,
after=1,
tips=2,
}




function UIZhenFaChooseWin:onLoaded(...)
self:bindComponents()
_this=self
self:initComponents()
end


function UIZhenFaChooseWin:__delete()
self:unbindComponents()
_this=nil
_selected=nil
end




function UIZhenFaChooseWin:onShow(argtable,afterOnloaded)

self.team=argtable.team or{}
self.callback=argtable.callback
self.init=argtable.init
for i,v in ipairs(self.list)do
if v==self.init then
_selected=i
break
end
end
_selected=_selected or 1

self.totalLv=0
for i,v in pairs(self.team)do

local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(v)
self.DragonBone[i]:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand)
self.DragonBone[i]:setChildUIModelShowFlipX(true)
self.totalLv=self.totalLv+UIDiscipleModel:getDiscipleJobLevel(v,DISCIPLE_PROSKILL_TYPE.eZhenFa)
end

self:refreshLeftList()
self:refreshRightPanel()
end


function UIZhenFaChooseWin:onHide()

end





function UIZhenFaChooseWin:onPreviewBtn()
UIManager:showWindow("UIZhenFaPreviewWin",{zfId=self.zfId})
end



function UIZhenFaChooseWin:onChooseBtn()
if self.callback then
self.callback(self.zfId~=self.init and self.zfId or nil)
end
self:closeSelf()
end



function UIZhenFaChooseWin:onExtraBtn()
UIManager:showWindow("UIZhenFaExtraWin",{zfId=self.zfId,totalLv=self.totalLv})
end

function UIZhenFaChooseWin:onClickLeftList(id,index,guid,attach)
if _selected~=index then
if _selected then
self:refreshLeftItemSelected(_selected,false)
end
_selected=index
self:refreshLeftItemSelected(_selected,true)
self:refreshRightPanel()
end
end

function UIZhenFaChooseWin:initComponents()
self.list={}
local cfg=cfg_zhenfaconfig()
for i,v in pairs(cfg)do
table.insert(self.list,i)
end
table.sort(self.list,self.sortList)
self.leftList:setClickAction(function(id,index,guid,attach)
self:onClickLeftList(id,index,guid,attach)
end)
self.leftList:freshGridsNum(#self.list,#self.list,1,false)

end

function UIZhenFaChooseWin.sortList(a,b)
local aLevel=zhenfaModel:getZhenFaData(a)
local bLevel=zhenfaModel:getZhenFaData(b)
local aScore=aLevel>0 and 1 or 0
local bScore=bLevel>0 and 1 or 0
if aScore~=bScore then
return aScore>bScore
else
return a<b
end
end

function UIZhenFaChooseWin:refreshLeftList()
for i,v in ipairs(self.list)do
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,v)
local item=self.leftList:getGridObjectByindex(i-1)
local level=zhenfaModel:getZhenFaData(v)
local isActived=level>0
item:SetChildActive(leftItemCmp.selected,_selected==i)
item:SetChildCSImageIcon(leftItemCmp.icon,cfg.icon,false)
item:SetChildImageExGray(leftItemCmp.icon,not isActived)
item:SetChildText(leftItemCmp.name,cfg.name)
item:SetChildActive(leftItemCmp.lock,false)
end
end

function UIZhenFaChooseWin:refreshLeftItemSelected(index,selected)
local item=self.leftList:getGridObjectByindex(index-1)
item:SetChildActive(leftItemCmp.selected,selected)
end

function UIZhenFaChooseWin:updateSelectedData()
self.zfId=self.list[_selected]
self.zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,self.zfId)
self.zfLv=zhenfaModel:getZhenFaData(self.zfId)
end

function UIZhenFaChooseWin:refreshRightPanel()
self:updateSelectedData()
self.zhenfaEffect:setChildShowEffect(self.zfCfg.effect[1],true)
local isActived=self.zfLv>0
if isActived then
self:setRightPanel_Use()
else
self:setRightPanel_Unactived()
end
end

function UIZhenFaChooseWin:setRightPanel_Unactived()
self.nameTx:setText(FMT.fmt("{0}（未激活）",self.zfCfg.name))
self.descTx:setText(self.zfCfg.desc[1])
self.unactivedPanel:setActive(true)
self.extraPanel:setActive(false)
local upDesc=self.zfCfg.updesc[self.zfLv]
self.levelUpList:setChildLayoutGroupCreateItems(#upDesc,function(index)
local item=self.levelUpList:getChildLayoutGroupGridItem(index-1)
local info=upDesc[index]
item:SetChildText(rightUpDescCmp.tips,info[1])
item:SetChildText(rightUpDescCmp.before,info[2])
item:SetChildText(rightUpDescCmp.after,info[3])
end)
end

function UIZhenFaChooseWin:setRightPanel_Use()
self.nameTx:setText(FMT.fmt("{0}（{1}级）",self.zfCfg.name,self.zfLv))
self.descTx:setText(self.zfCfg.desc[self.zfLv])
self.unactivedPanel:setActive(false)
self.extraPanel:setActive(true)
self.extraLvTx:setText(FMT.fmt("队伍弟子阵法等级之和: {0}",self.totalLv))












self.extraRoundTx:setText("")
local teamLv=0
for i,v in pairs(self.zfCfg.buffdesc)do
if i<=self.totalLv then
teamLv=math.max(teamLv,i)
end
end
local powerStr=self.zfCfg.buffdesc[teamLv]and table.concat(self.zfCfg.buffdesc[teamLv],"\n")or""
self.extraPowerTx:setText(powerStr)
self.chooseBtnTx:setText(self.zfId==self.init and"取消使用"or"使用")
end

function UIZhenFaChooseWin:findLeftIndex(zfId)
for i,v in ipairs(self.list)do
if v==zfId then
return i
end
end
end

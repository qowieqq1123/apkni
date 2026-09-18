







UIFuncItemUseModel={}

local _otherValToBaseAttr={
title=false,
sortOption={"六维排序",'战力排序','品质排序','培植排序','丹道排序','商道排序','符箓排序',
'炼器排序','阵法排序','饲养排序','聚灵排序'},
sortTypeList={
-1,
eDiscipleSortType.eFightSort,
eDiscipleSortType.eColorSort,
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.ePeiZhi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eDanDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eShangDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eFuLu},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eLianQi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eZhenFa},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eSiYang},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eJuLing},
},
topPage=true,
topPageList=
{
{name="资质",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eZiZhi},attr=DISCIPLE_BASE_ATTR_TYPE.eZiZhi},
{name="根骨",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eGenGu},attr=DISCIPLE_BASE_ATTR_TYPE.eGenGu},
{name="潜力",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eQianLi},attr=DISCIPLE_BASE_ATTR_TYPE.eQianLi},
{name="魅力",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eMeiLi},attr=DISCIPLE_BASE_ATTR_TYPE.eMeiLi},
{name="聪慧",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eCongHui},attr=DISCIPLE_BASE_ATTR_TYPE.eCongHui},
{name="机缘",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eJiYuan},attr=DISCIPLE_BASE_ATTR_TYPE.eJiYuan},
},
dzItemDesc=function(self,win,dzguid,pageIndex,isSelected,funcparam)
local attr=self.topPageList[pageIndex].attr
local name=self.topPageList[pageIndex].name
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0
local desc=""
local extra
for i,v in ipairs(funcparam.extra)do
if v[2][3]and v[2][3][1]==attr then
extra=v[2][3]
end
end
if isSelected and extra and attr==extra[1]then
local add=extra[2]*win.selectCnt
desc=FMT.fmt("<color=#7d3b17>{0}：</color>{1}<color=#7fdc8b>+{2}</color>",name,val,add)
else
desc=FMT.fmt("<color=#7d3b17>{0}：</color>{1}",name,val)
end
return desc
end,
initPanelFuncName="init6AttrPanelInfo",
grayDizi=true,
showSlider=true,
checkUseFunc=function(self,win,funcparam,dzguid,pageIndex,warring,selectNum)




local canUse=true
for i,v in ipairs(funcparam.extra)do
local limit=v[1]and v[1][3]
if limit then
local attr=v[1][3][1]
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0

local tempCanUse=val>=limit[2]and val<=limit[3]
if not tempCanUse then
canUse=false
break
end
end
end
if warring and not canUse then
UIManager.error("弟子不满足使用该道具的条件")
end
return canUse
end,
resetSelectCount=function(self,win)

local dzguid=win:getCurSelectDzGuid()
local maxCnt=0
for i,v in ipairs(win.itemConfig.funcparam.extra)do
if v[2][3]then
local attr=v[2][3][1]
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0
local limit=v[1][3]
local add=v[2][3][2]

local m=math.ceil(((limit[3]+add)-val)/add)
maxCnt=maxCnt<m and m or maxCnt
end
end

local itemid=win.selectItemid

maxCnt=maxCnt>20 and 20 or maxCnt
maxCnt=maxCnt<0 and 0 or maxCnt
if itemid then
local have=bagModel.getItemCountById(itemid)
maxCnt=have<maxCnt and have or maxCnt
win.selectCnt=maxCnt
win.maxUseCnt=maxCnt==0 and 1 or maxCnt
end
end,
refreshNoItem=function(self,win)
win.tipsText:setText('暂无道具')
win.noItems:setActive(false)
end,
canAddItemList=function(self,win,item)
if item.funcparam.extra==nil then return end
local sType=self.topPageList[win.clickProSkillIdx].sortTagArg[2]
for i,v in ipairs(item.funcparam.extra)do
local funcParam=v[2]and v[2][3]and v[2][3][1]
if funcParam~=nil and sType==funcParam then
return true
end
end

return false
end,
getDefaultPageIndex=function(self,win)
local param=nil
for i,v in ipairs(self.topPageList)do
for ii,vv in ipairs(win.itemConfig.funcparam.extra)do
param=vv[2][3][1]
if param==v.sortTagArg[2]then
return i
end
end
end
return 1
end,
showHelp=function(win)
win.helpText:setText(cfgHelper.get1(cfg_lang_get,'6attr_item_rule'))
win.help:setActive(true)
end,
getMutipleTypeItemList=function()
local list1=itemsLookup:get_function_items(item_funtion_type.jj_xiuweidan)or defaultT
local list2=itemsLookup:get_function_items(item_funtion_type.lt_jingyandan)or defaultT
local list17=itemsLookup:get_function_items(item_funtion_type.attr6Add)or defaultT

return table.concatTable(list1,list2,list17)
end,
}


UIFuncItemUseModel.funcTypeArgs=
{
[item_funtion_type.tezhiAdd]=
{
title=false,
sortOption={"特质排序",'战力排序','品质排序'},
sortTypeList={-1,eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort},
topPage=true,
topPageList=
{
{name="体质",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eBody,2}},
{name="天赋",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eTalent,2}},
{name="怪癖",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eStrange,2}},
{name="道劫",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eChuangShang,2}},
},
dzItemDesc=function(self,win,dzguid,pageIndex)

local isMax,num,max=UIDiscipleModel.checkSpecialtyCountMax(self.topPageList[pageIndex].sortTagArg[2],dzguid)
return FMT.fmt('<color=#7d3b17>特质数：</color>{0}/{1}',num,max)
end,
initPanelFuncName="initAddTeZhiPanelInfo",
grayDizi=true,
showSlider=false,
checkUseFunc=function(self,win,funcparam,dzguid,pageIndex,warring,selectNum)
selectNum=selectNum or 1
local isMax,num,max=UIDiscipleModel.checkSpecialtyCountMax(self.topPageList[pageIndex].sortTagArg[2],dzguid)
local canUse=(num+selectNum)<=max
if not canUse then
if warring then
UIManager.error("弟子该类型的特质数量已到达上限")
end
return canUse
end

local funcParam=win.itemConfig.funcparam.extra[1][2][5][2][1]
local isNotJC=win.itemConfig.funcparam.extra[1][2][5][4]
local sType=funcParam[1]
local list=funcParam[2]
local have=true
for i,v in ipairs(list)do
local spe,extraFlag,extra_str=UIDiscipleModel:getDiscipleSpecialityByID(tostring(dzguid),sType,v,false,true)
if isNotJC then
extraFlag=true
end
if#list==1 and not extraFlag then
return false,extra_str
end

if not spe and extraFlag then
have=false
break
end
end
if have then
if warring then
UIManager.error("该弟子已拥有可能从该道具获得的所有特质")
end
return false
end
if isNotJC then
return true
end
local showTips=UIFuncItemUseModel:checkSpecialityGroupByList(dzguid,funcParam,true)
if showTips then
if warring then
UIManager.error("该弟子持有新增特质的互斥特质")
end
return false
end
if sType==DISCIPLE_SPECIALITY_TYPE.eStrange and pageIndex==3 then
if UIFuncItemUseModel:checkDiZiHaveTezhi(dzguid,DISCIPLE_SPECIALITY_TYPE.eTalent,19)then
canUse=false
if warring then
UIManager.error("弟子持有特质<color=#5ac0e2>中正平和</color>，无法获得新的怪癖")
end
return canUse
end
end
return canUse
end,
refreshNoItem=function(self,win)
win.tipsText:setText('暂无道具')
win.noItems:setActive(false)
end,
canAddItemList=function(self,win,item)
local sType=self.topPageList[win.clickProSkillIdx].sortTagArg[2]
local funcParam=item.funcparam.extra[1][2][5][2][1][1]
return sType==funcParam
end,
getDefaultPageIndex=function(self,win)
local param=win.itemConfig.funcparam.extra[1][2][5][2][1][1]
for i,v in ipairs(self.topPageList)do
if param==v.sortTagArg[2]then
return i
end
end
return 1
end
},
[item_funtion_type.tezhiSub]=
{
title=false,
sortOption={"特质排序",'战力排序','品质排序'},
sortTypeList={-1,eDiscipleSortType.eFightSort,eDiscipleSortType.eColorSort},
topPage=true,
topPageList=
{
{name="体质",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eBody,1}},
{name="天赋",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eTalent,1}},
{name="怪癖",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eStrange,1}},
{name="道劫",sortTagArg={eDiscipleSortType.eTeZhi,DISCIPLE_SPECIALITY_TYPE.eChuangShang,1}},
},
dzItemDesc=function(self,win,dzguid,pageIndex)
local isMax,num,max=UIDiscipleModel.checkSpecialtyCountMax(self.topPageList[pageIndex].sortTagArg[2],dzguid)
return FMT.fmt('<color=#7d3b17>特质数：</color>{0}/{1}',num,max)
end,
initPanelFuncName="initSubTeZhiPanelInfo",
grayDizi=true,
showSlider=false,
checkUseFunc=function(self,win,funcparam,dzguid,pageIndex,warring,selectNum)
selectNum=selectNum or 1
local isMax,num,max=UIDiscipleModel.checkSpecialtyCountMax(self.topPageList[pageIndex].sortTagArg[2],dzguid)
local canUse=(num-selectNum)>=0
if warring and not canUse then
UIManager.error("弟子不满足使用该道具的条件")
end
return canUse
end,
refreshNoItem=function(self,win)
win.tipsText:setText('暂无道具')
win.noItems:setActive(false)
end,
canAddItemList=function(self,win,item)
local sType=self.topPageList[win.clickProSkillIdx].sortTagArg[2]
local funcParam=item.funcparam.extra[1][2][6][2][1][1]
return sType==funcParam
end,
getDefaultPageIndex=function(self,win)
local param=win.itemConfig.funcparam.extra[1][2][6][2][1][1]
for i,v in ipairs(self.topPageList)do
if param==v.sortTagArg[2]then
return i
end
end
return 1
end
},
[item_funtion_type.attr6Add]=
{
title=false,
sortOption={"六维排序",'战力排序','品质排序','培植排序','丹道排序','商道排序','符箓排序',
'炼器排序','阵法排序','饲养排序','聚灵排序'},
sortTypeList={
-1,
eDiscipleSortType.eFightSort,
eDiscipleSortType.eColorSort,
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.ePeiZhi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eDanDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eShangDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eFuLu},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eLianQi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eZhenFa},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eSiYang},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eJuLing},
},
topPage=true,
topPageList=
{
{name="资质",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eZiZhi},attr=DISCIPLE_BASE_ATTR_TYPE.eZiZhi},
{name="根骨",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eGenGu},attr=DISCIPLE_BASE_ATTR_TYPE.eGenGu},
{name="潜力",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eQianLi},attr=DISCIPLE_BASE_ATTR_TYPE.eQianLi},
{name="魅力",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eMeiLi},attr=DISCIPLE_BASE_ATTR_TYPE.eMeiLi},
{name="聪慧",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eCongHui},attr=DISCIPLE_BASE_ATTR_TYPE.eCongHui},
{name="机缘",sortTagArg={eDiscipleSortType.eBaseAttr6,DISCIPLE_BASE_ATTR_TYPE.eJiYuan},attr=DISCIPLE_BASE_ATTR_TYPE.eJiYuan},
},
dzItemDesc=function(self,win,dzguid,pageIndex,isSelected,funcparam)
local attr=self.topPageList[pageIndex].attr
local name=self.topPageList[pageIndex].name
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0
local desc=""
local extra
for i,v in ipairs(funcparam.extra)do
if v[2][3]and v[2][3][1]==attr then
extra=v[2][3]
end
end
if isSelected and extra and attr==extra[1]then
local add=extra[2]*win.selectCnt
desc=FMT.fmt("<color=#7d3b17>{0}：</color>{1}<color=#7fdc8b>+{2}</color>",name,val,add)
else
desc=FMT.fmt("<color=#7d3b17>{0}：</color>{1}",name,val)
end
return desc
end,
initPanelFuncName="init6AttrPanelInfo",
grayDizi=true,
showSlider=true,
checkUseFunc=function(self,win,funcparam,dzguid,pageIndex,warring,selectNum)




local canUse=true
for i,v in ipairs(funcparam.extra)do
local limit=v[1]and v[1][3]
if limit then
local attr=v[1][3][1]
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0

local tempCanUse=val>=limit[2]and val<=limit[3]
if not tempCanUse then
canUse=false
break
end
end
end
if warring and not canUse then
UIManager.error("弟子不满足使用该道具的条件")
end
return canUse
end,
resetSelectCount=function(self,win)

local dzguid=win:getCurSelectDzGuid()
local maxCnt=0
for i,v in ipairs(win.itemConfig.funcparam.extra)do
if v[2][3]then
local attr=v[2][3][1]
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local val=attrList[attr]or 0
local limit=v[1][3]
local add=v[2][3][2]

local m=math.ceil(((limit[3]+add)-val)/add)
maxCnt=maxCnt<m and m or maxCnt
end
end

local itemid=win.selectItemid

maxCnt=maxCnt>20 and 20 or maxCnt
maxCnt=maxCnt<0 and 0 or maxCnt
if itemid then
local have=bagModel.getItemCountById(itemid)
maxCnt=have<maxCnt and have or maxCnt
win.selectCnt=maxCnt
win.maxUseCnt=maxCnt==0 and 1 or maxCnt
end
end,
refreshNoItem=function(self,win)
win.tipsText:setText('暂无道具')
win.noItems:setActive(false)
end,
canAddItemList=function(self,win,item)
local sType=self.topPageList[win.clickProSkillIdx].sortTagArg[2]
if item.funcparam.extra then
for i,v in ipairs(item.funcparam.extra)do
if v[2][3]then
local funcParam=v[2][3][1]
if sType==funcParam then
return true
end
end
end
end
return false
end,
getDefaultPageIndex=function(self,win)
local param=nil
for i,v in ipairs(self.topPageList)do
for ii,vv in ipairs(win.itemConfig.funcparam.extra)do
param=vv[2][3][1]
if param==v.sortTagArg[2]then
return i
end
end
end
return 1
end,
showHelp=function(win)
win.helpText:setText(cfgHelper.get1(cfg_lang_get,'6attr_item_rule'))
win.help:setActive(true)
end,
getMutipleTypeItemList=function()
local list1=itemsLookup:get_function_items(item_funtion_type.jj_xiuweidan)or defaultT
local list2=itemsLookup:get_function_items(item_funtion_type.lt_jingyandan)or defaultT
local list17=itemsLookup:get_function_items(item_funtion_type.attr6Add)or defaultT

return table.concatTable(list1,list2,list17)
end,
},
[item_funtion_type.baseAttr6]=
{
title=true,
sortOption={"六维排序",'战力排序','品质排序','培植排序','丹道排序','商道排序','符箓排序',
'炼器排序','阵法排序','饲养排序','聚灵排序'},
sortTypeList={
-1,
eDiscipleSortType.eFightSort,
eDiscipleSortType.eColorSort,
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.ePeiZhi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eDanDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eShangDao},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eFuLu},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eLianQi},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eZhenFa},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eSiYang},
{eDiscipleSortType.eProSkill,DISCIPLE_PROSKILL_TYPE.eJuLing},
},
dzItemDesc=function(self,win,dzguid,pageIndex)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local val=UIDiscipleModel:getFixAttrBaseSum(netData)
return FMT.fmt("<size=20><color=#7d3b17>六维总值：</color>{0}</size>",val)
end,
initPanelFuncName="initBaseAttr6PanelInfo",
grayDizi=true,
showSlider=false,
checkUseFunc=function(self,win,funcparam,dzguid,pageIndex,warring,selectNum)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local val=UIDiscipleModel:getFixAttrBaseSum(netData)
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local target=funcparam.target
local target_color=funcparam.color
local canUse=UIDiscipleModel:canAddBaseAttrToTarget(val,target,attrList)
if target_color then

local color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrList)
if color>=target_color then
canUse=false
end
end
if warring and not canUse then
local _colornew=getQualityColorNew(QualityColorNewType.black,target_color)
local str=FMT.fmt("仅有<color={0}>绝伦</color>品质以下弟子才可使用",_colornew)
UIManager.error(str)
return canUse
end
if warring and not canUse then
UIManager.error("弟子不满足使用该道具的条件")
end
return canUse
end,
refreshNoItem=function(self,win)
win.tipsText:setText('暂无道具')
win.noItems:setActive(false)
end,
showHelp=function(win)
win.helpText:setText(cfgHelper.get1(cfg_lang_get,'tipin_item_rule'))
win.help:setActive(true)
end,
},

[item_funtion_type.jj_xiuweidan]=_otherValToBaseAttr,
[item_funtion_type.lt_jingyandan]=_otherValToBaseAttr,
}

local tezicolor=
{
[1]="#549327",
[2]="#6833c0",
[3]="#3375c0",
[4]="#c82c2c",
}

function UIFuncItemUseModel:openFuncItemUseWin(args)
local disciplesList=discipleLookup:getSortDiscipleList()
if#disciplesList<=0 then
UIManager.info('当前没有弟子')
return false
end
local itemid=args.itemid
local funcType=args.type
local skillid=args.skillid


if itemid and args.isLingJiu then
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam

UIManager:showWindow('UIFuncSpecItemUseWin',args)
return true
end

if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam then
local itemType=funcparam.type
if itemType==item_funtion_type.liaoshang then
local haveInjury=false
for i,v in ipairs(disciplesList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local injury=UIDiscipleModel:getDiscipleInjury(guid)
if injury>0 then
haveInjury=true
break
end
end
if not haveInjury then
UIManager.info('当前弟子非常健康，无需使用')
return false
end
end
UIManager:showWindow('UIFuncItemUseWin',args)
end
elseif funcType then
UIManager:showWindow('UIFuncItemUseWin',args)
else
return false,'参数不正确'
end
return true
end

function UIFuncItemUseModel:getAllItemAddValue(itemid,selectCnt)
local value=0
if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local typo=funcparam.type
if typo==7 then

value=funcparam.exp*selectCnt
elseif typo==8 then

value=funcparam.shouyuan*selectCnt
elseif typo==9 then

value=funcparam.heal*selectCnt
elseif typo==item_funtion_type.tezhiAdd then
value=selectCnt
elseif typo==item_funtion_type.tezhiSub then
value=selectCnt
elseif typo==item_funtion_type.baseAttr6 then
value=selectCnt
elseif typo==item_funtion_type.attr6Add then
value=selectCnt
elseif typo==item_funtion_type.jj_xiuweidan then
value=selectCnt
elseif typo==item_funtion_type.lt_jingyandan then
value=selectCnt
elseif typo==item_funtion_type.eLingShouBaseAttr2 then
local funcType=9
local funcList=funcparam.extra[1][2]
local qianliBoost=funcList[funcType][2]
value=qianliBoost*selectCnt
end
end
return value
end

function UIFuncItemUseModel.getMaxUseNum(dzguid,itemid)
local maxCnt=0
if itemid then
local hasNum=bagModel.getItemCountById(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local typo=funcparam.type

if typo==item_funtion_type.pro_skill_exp then
local jobType=funcparam.skillid
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local proskillData=UIDiscipleModel:getDiscipleJobData(dzguid,jobType)
local curlv=proskillData.level
local curexp=proskillData.exp


local value=funcparam.exp
for i=0,hasNum do
local isMax=explist[curlv+1]==nil
if isMax or i==hasNum then
maxCnt=i
break
end
local maxexp=explist[curlv]
curexp=curexp+value
if curexp>=maxexp then
curlv=curlv+1
curexp=curexp-maxexp
end
end
elseif typo==item_funtion_type.liaoshang then
local injury=UIDiscipleModel:getDiscipleInjury(dzguid)
local heal=funcparam.heal
for i=0,hasNum do
if injury<=0 or i==hasNum then
maxCnt=i
break
end
injury=injury-heal
end
else
maxCnt=hasNum
end
end
return maxCnt
end


function UIFuncItemUseModel.calcAttr6ForSoul(attr_value_list,target_attr_value,attr_limit_list)
if not target_attr_value or not attr_limit_list then return end

local attr_total_value=0
for _,attr_value in pairs(attr_value_list)do
attr_total_value=attr_total_value+attr_value
end
local diff_attr_value=target_attr_value-attr_total_value
if diff_attr_value<1 then return end


local attr_left_list={}
for attr_type,attr_value in pairs(attr_value_list)do
table.insert(attr_left_list,{attr_type,math.max(0,attr_limit_list[attr_type]-attr_value)})
end
local function sortByAttrValue(a,b)return a[2]<b[2]end
table.sort(attr_left_list,sortByAttrValue)

local attr_add_list={0,0,0,0,0,0,}
local add_percent=diff_attr_value/attr_total_value
local attr_left_value=0
for i,v in ipairs(attr_left_list)do
local attr_type,max_add=v[1],v[2]
local need_add=math.ceil(attr_value_list[attr_type]*add_percent)
if max_add>0 then
if need_add>max_add then
attr_left_value=attr_left_value+(need_add-max_add)
attr_add_list[attr_type]=max_add
else
local left_value=math.floor(attr_left_value/(7-i))
local left_add=math.min(max_add-need_add,left_value)
attr_left_value=attr_left_value-left_add
attr_add_list[attr_type]=need_add+left_add
end
else
attr_left_value=attr_left_value+need_add
end
end
local total_add_value=0
for _,attr_value in pairs(attr_add_list)do
total_add_value=total_add_value+attr_value
end
return attr_add_list
end

function UIFuncItemUseModel:checkBaseAttr6ItemTips(dzguid,itemid,okcallback)
local itemConfig=itemsConfig.getConfig(itemid)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local v=UIDiscipleModel:getFixAttrBaseSum(netData)
local funcparam=itemConfig.funcparam
local target=funcparam.target
local diziName=UIDiscipleModel:getDiscipleName(dzguid)

local attrText=""
local infoAttrTextList={}
local lookup={1,2,3,4,5,6}

local index=1
local infoIndex=1
local attrList=UIDiscipleModel:getFixAttrBase(netData)
local attr_limit_list=funcparam.limit
local addList=self.calcAttr6ForSoul(attrList,target,attr_limit_list)or{}
for i,v in ipairs(lookup)do
local name=UIDiscipleModel:getDiscipleBaseAttrName(v)

local addVal=addList[v]or 0
if index%3==0 then
attrText=FMT.fmt("{0}{1}+{2}\n",attrText,name,addVal)
else
attrText=FMT.fmt("{0}{1}+{2}   ",attrText,name,addVal)
end

local infoListIndex=math.ceil(infoIndex/3)
local infoAttrText=infoAttrTextList[infoListIndex]or""
if addVal>0 then
if infoIndex%3==1 then
infoAttrTextList[infoListIndex]=FMT.fmt("{0}{1}+{2}",infoAttrText,name,addVal)
else
infoAttrTextList[infoListIndex]=FMT.fmt("{0}, {1}+{2}",infoAttrText,name,addVal)
end
infoIndex=infoIndex+1
end

index=index+1
end

local cb=function(showTips)
local func=function()
local color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx3(target)
local colorColor=FONT_COLOR_VAL[color]
UIManager.info(FMT.fmt("弟子{0}已提升至<color={1}>{2}</color>",diziName,colorColor,UIDiscipleModel.getDiscipleColorDesc(color)))

if infoAttrTextList then
for _,infoAttrText in ipairs(infoAttrTextList)do
UIManager.info(infoAttrText)
end
end
end
if okcallback then
okcallback(showTips,func)
end
end

if target-v<=10 then
local itemName=itemsConfig.getItemName(itemid)
local showdata=
{
type='UIDialouge',
title='温馨提示',
content=FMT.fmt("{0}使用{1}成效并不显著，祖师确定让其使用吗？",diziName,itemName),
attrText=attrText,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=cb,
showclosebtn=true,
}
UIManager:showWindow("UIBaseAttr6Dialouge",showdata)
else
cb(true)
end

end



function UIFuncItemUseModel:checkHasBase6AttrCondition(dzguid,itemid,isCheckDeviation)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local attrList
local fixAttrList
if isCheckDeviation then
local netData=UIDiscipleModel:getDiscipleData(dzguid)
attrList=UIDiscipleModel:getBaseAttrBaseEx(netData)
fixAttrList=UIDiscipleModel:getFixAttrBase(netData)
end
local conditionList={}
if funcparam.extra then
local extraList=funcparam and funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[1]and v[1][3]then
local limit=v[1][3]
local attrType=limit[1]
local condition={
attrType=attrType,
minAttr=limit[2],
maxAttr=limit[3],
}
local fixAttr=fixAttrList[attrType]
condition.actuallyAttr=fixAttr
if isCheckDeviation then

local attr=attrList[attrType]
condition.hasDeviation=attr~=fixAttr
end
table.insert(conditionList,condition)
end
end
end
if conditionList and next(conditionList)then
return true,conditionList
end

return false
end



function UIFuncItemUseModel:checkHasBase6AttrConditionEX(dzguid,itemid,isCheckDeviation)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local attrList
local fixAttrList
if isCheckDeviation then
local netData=UIDiscipleModel:getDiscipleData(dzguid)
attrList=UIDiscipleModel:getBaseAttrBaseEx(netData)
fixAttrList=UIDiscipleModel:getFixAttrBase(netData)
end
local conditionList={}
if funcparam.extra then
local extraList=funcparam and funcparam.extra or{}
for i,v in ipairs(extraList)do
if v[1]and v[1][9]then
local attrs=v[1][9]
for _,limit in pairs(attrs)do
local attrType=limit[1]
local condition={
attrType=attrType,
minAttr=0,
maxAttr=limit[2],
}
local fixAttr=fixAttrList[attrType]
condition.actuallyAttr=fixAttr
if isCheckDeviation then

local attr=attrList[attrType]
condition.hasDeviation=attr~=fixAttr
end
table.insert(conditionList,condition)
end
end
end
end
if conditionList and next(conditionList)then
return true,conditionList
end

return false
end

function UIFuncItemUseModel:checkTezhiAddTips(dzguid,itemid,okcallback)
local checkTezhiAddFlag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eItemUseCheckTezhiAddFlag)
if checkTezhiAddFlag then
okcallback()
return
end
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local extra=nil
local showFlag=false
if funcparam.extra then
if funcparam.extra[1][2][5]then
showFlag=funcparam.extra[1][2][5][3]==1
extra=funcparam.extra[1][2][5][2][1]
end
end
if(not extra)or(not showFlag)then
okcallback()
return
end
local sType=extra[1]
local showTips,huchiSpe=UIFuncItemUseModel:checkSpecialityGroupByList(dzguid,extra)
if not showTips then
okcallback()
return
end
local dzName=UIDiscipleModel:getDiscipleColorName(dzguid)
local content=FMT.fmt("{0}持有的特质{1}可能导致该道具无法为其增加新特质，确定要使用吗？",dzName,UIDiscipleModel:getSpecialityName(sType,huchiSpe,true))

















UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eItemUseCheckTezhiAddFlag,nil,nil)
end


function UIFuncItemUseModel:checkTeZhiSubItemTips(dzguid,itemid,okcallback,sType)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
local color=itemConfig.color
local itemname=FMT.cfmt(color,itemConfig.name)
if funcparam.tzitemdesc then
local list=UIDiscipleModel:getDiscipleSpeciality(dzguid,sType)
if list then
local v=list[1].param_1
local config=UIDiscipleModel:getSpecialityConfig(sType,v)
local name=config.name


local namecolor=tezicolor[sType]or"#6833c0"
local namestr=FMT.fmt("<color={0}>【{1}】</color>",namecolor,name)
local string=FMT.fmt(funcparam.tzitemdesc,itemname,namestr)
local show_data=
{
title='提示',
tipsText=string,
cellcallback=function()
if okcallback then
okcallback()
end
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
end
else
if okcallback then
okcallback(true)
end
end
end

function UIFuncItemUseModel:checkSpecialityGroupByList(dzguid,extra,checkAll,checkHave)
local sType=extra[1]
local list=extra[2]
local isNotJC=extra[4]
local showTips=false
local huchiSpe=nil
local checkAllList={}
local checkHaveFlag=false
local checkHaveList={}
local checkExtraFlag=false
local checkExtraList={}
local netData=UIDiscipleModel:getDiscipleData(tostring(dzguid))
for i,v in ipairs(list)do
local spe,extraFlag=UIDiscipleModel:getDiscipleSpecialityByID(tostring(dzguid),sType,v,false,true)
if not extraFlag then
table.insert(checkExtraList,v)
end
if not spe then
local haveSpe=UIDiscipleModel.checkDiscipleSpecialityGroupByID(dzguid,sType,v)
if haveSpe then
if not checkAll then
showTips=true
huchiSpe=haveSpe.param_1
break
end
table.insert(checkAllList,v)
end
else
table.insert(checkHaveList,v)
end
end
if checkAll and#list==#checkAllList then
showTips=true
huchiSpe=checkAllList
end
if checkHave and#list==#checkHaveList then
checkHaveFlag=true
end
if#list==#checkExtraList then
checkExtraFlag=true
end
return showTips,not isNotJC and huchiSpe,checkHaveFlag,not isNotJC and checkExtraFlag
end




function UIFuncItemUseModel.onDiscipleInjuryChange(discipleguid,oldInjury,injury)
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
local lerp=injury-oldInjury
if lerp~=0 then
if lerp>0 then
UIManager.info(FMT.fmt('{0}增加{1}点负伤值',dzName,lerp))
else
UIManager.info(FMT.fmt('{0}减少{1}点负伤值',dzName,lerp))
end
end
end


function UIFuncItemUseModel.onDiscipleShouYuanChange(discipleguid,old,shouyuan)
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
local lerp=shouyuan-old
if lerp~=0 then
if lerp>0 then
UIManager.info(FMT.fmt('{0}增加{1}年寿元',dzName,lerp))
else
UIManager.info(FMT.fmt('{0}减少{1}年寿元',dzName,lerp))
end
end
end


function UIFuncItemUseModel.onDiscipleJobChange(discipleguid,jobtype,oldlv,lv,oldexp,exp)
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
local jobName=cfgHelper.get2(cfg_discipleproskillconfig_get,jobtype,'name')
local lerp=UIFuncItemUseModel.getAddAllExp(oldlv,lv,oldexp,exp)
if lerp~=0 then
if lerp>0 then
UIManager.info(FMT.fmt('{0}增加{1}点{2}经验',dzName,lerp,jobName))
else
UIManager.info(FMT.fmt('{0}减少{1}点{2}经验',dzName,lerp,jobName))
end
end
end


function UIFuncItemUseModel.onDiscipleSpecialityChange(discipleguid,specialitytype,specialityid,updatetypep)
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
local typeName=UIDiscipleModel:getSpecialityTypeName(specialitytype)
local name=UIDiscipleModel:getSpecialityName(specialitytype,specialityid)
if updatetypep==0 then
UIManager.info(FMT.fmt('{0}移除了{1} {2}',dzName,typeName,name))
elseif updatetypep==1 then
UIManager.info(FMT.fmt('{0}获得了{1} {2}',dzName,typeName,name))
end
end


function UIFuncItemUseModel.onDiscipleSixAttrChange(discipleguid,attrid,old,cur)
local dzName=UIDiscipleModel:getDiscipleColorName(discipleguid)
local name=UIDiscipleModel:getDiscipleBaseAttrName(attrid)
local lerp=cur-old
if lerp~=0 then
if lerp>0 then
UIManager.info(FMT.fmt('{0} {1} +{2}',dzName,name,lerp))
else
UIManager.info(FMT.fmt('{0} {1} {2}',dzName,name,lerp))
end
end
end

function UIFuncItemUseModel.onShowDiscipleChanged(eType,datas,isSub)

if eType==ePrizeType.eDiscipleUseItem then
for changeType,dzData in pairs(datas)do
if changeType==eDiscipleChangeType.eInjuryChange then
for discipleguid,cntData in pairs(dzData)do
if isSub==true then
UIFuncItemUseModel.onDiscipleInjuryChange(discipleguid,cntData[1][1],cntData[#cntData][2])
else
for i,v in ipairs(cntData)do
UIFuncItemUseModel.onDiscipleInjuryChange(discipleguid,v[1],v[2])
end
end
end
elseif changeType==eDiscipleChangeType.eShouYuan then
for discipleguid,cntData in pairs(dzData)do
if isSub==true then
UIFuncItemUseModel.onDiscipleShouYuanChange(discipleguid,cntData[1][1],cntData[#cntData][2])
else
for i,v in ipairs(cntData)do
UIFuncItemUseModel.onDiscipleShouYuanChange(discipleguid,v[1],v[2])
end
end
end
elseif changeType==eDiscipleChangeType.eJobExpChange then
for discipleguid,cntData in pairs(dzData)do
if isSub==true then
local jobLookup={}
for i,v in ipairs(cntData)do
if jobLookup[v[1]]==nil then
jobLookup[v[1]]={}
end
table.insert(jobLookup[v[1]],v)
end
for jobtype,v in pairs(jobLookup)do
UIFuncItemUseModel.onDiscipleJobChange(discipleguid,jobtype,v[1][2],v[#v][3],v[1][4],v[#v][5])
end
else
for i,v in ipairs(cntData)do
UIFuncItemUseModel.onDiscipleJobChange(discipleguid,v[1],v[2],v[3],v[4],v[5])
end
end
end
elseif changeType==eDiscipleChangeType.eSpeciality then
for discipleguid,cntData in pairs(dzData)do
for i,v in ipairs(cntData)do
UIFuncItemUseModel.onDiscipleSpecialityChange(discipleguid,v[1],v[2],v[3])
end
end
elseif changeType==eDiscipleChangeType.eSixAttr then
for discipleguid,cntData in pairs(dzData)do
if isSub==true then
local attrLookup={}
for i,v in ipairs(cntData)do
if attrLookup[v[1]]==nil then
attrLookup[v[1]]={}
end
table.insert(attrLookup[v[1]],v)
end
for attrid,v in pairs(attrLookup)do
UIFuncItemUseModel.onDiscipleSixAttrChange(discipleguid,attrid,v[1][2],v[#v][3])
end
else
for i,v in ipairs(cntData)do
UIFuncItemUseModel.onDiscipleSixAttrChange(discipleguid,v[1],v[2],v[3])
end
end
end
end
end
end
end





function UIFuncItemUseModel:selectInjuryDisciple(dzList)
local list={}
for i,v in ipairs(dzList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local injury=UIDiscipleModel:getDiscipleInjury(guid)
if injury~=0 then
table.insert(list,v)
end
end
return list
end


function UIFuncItemUseModel:checkFuShangZhi(dzId)
local injury=UIDiscipleModel:getDiscipleInjury(dzId)
if injury<=0 then
local str='该名弟子非常健康，无需使用'
return false,str
end
return true
end



function UIFuncItemUseModel:reSortShouYuanDisciple(dzList)
local list={}
for i,v in ipairs(dzList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
if shouyuan<0 then
v.sortTag=shouyuan+10000000000
else
v.sortTag=shouyuan
end
table.insert(list,v)
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end


function UIFuncItemUseModel:checkShouYuan(dzId)
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(dzId)
if shouyuan<0 then
local str='该名弟子无限寿元，无需使用'
return false,str
end

local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzId)
local floor=UIDiscipleModel:getJJFloor(jjlv)
local overflow=cfgHelper.getdef1(cfg_disciplejingjieconfig,'floor')
local syLimit=overflow[floor]
local max=syLimit[7]
if max==nil then
logErr('最大寿元限制没有配置')
return false
end
if max==-1 then
UIManager.info('该弟子已无限寿元')
return false
end
if shouyuan>=max then
return false,cfgHelper.getlang('disciple_shouyuan_useitem_tips_1')
end
return true
end


function UIFuncItemUseModel:getProSkillNextLevel(curPro,addExp)
local curLevel=curPro.level
local curexp=curPro.exp
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local nextexp=explist[curLevel+1]
local isMax=nextexp==nil
if isMax then return curLevel end

local upLevel=curLevel
local curmaxexp=explist[curLevel]
addExp=addExp-(curmaxexp-curexp)
for i=curLevel+1,#explist do
upLevel=upLevel+1
local lvExp=explist[i]
if addExp<lvExp then
break
end
addExp=addExp-lvExp
end
return upLevel
end

function UIFuncItemUseModel.getAddAllExp(oldlv,curlv,oldexp,curexp)
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local addExp=0
if curlv>oldlv then
for i=oldlv,curlv-1 do
local lvExp=explist[i]
addExp=addExp+lvExp
end
addExp=addExp+curexp-oldexp
elseif curlv<oldlv then
for i=oldlv-1,curlv,-1 do
local lvExp=explist[i]
addExp=addExp+lvExp
end
addExp=addExp+oldexp-curexp
addExp=-addExp
else
addExp=curexp-oldexp
end
return addExp
end

function UIFuncItemUseModel:checkProSkillLvMax(proskillList,jobType)
local curPro=proskillList[jobType]
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobType,'name')
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local curexp=curPro.exp
local maxexp=explist[curPro.level]
local nextexp=explist[curPro.level+1]
local isMax=maxexp~=nil and nextexp==nil
if isMax then
local str=FMT.fmt('{0}等级已满',name)
return true,str
end
return false
end

function UIFuncItemUseModel:getHaveExpDanProskillId()
local proAllConfig=cfg_discipleproskillconfig()
local itemList=itemsLookup:get_function_items(item_funtion_type.pro_skill_exp)or{}
for i,v in ipairs(proAllConfig)do
for i1,v1 in pairs(itemList)do
local num=bagModel.getItemCountById(v1.id)
if num>0 then
local itemFunc=v1.funcparam
if v.id==itemFunc.skillid then
return v.id
end
end
end
end
return DISCIPLE_PROSKILL_TYPE.ePeiZhi
end


function UIFuncItemUseModel:checkDiZiHaveTezhi(disciple_guid,tztype,tzid)
if DISCIPLE_SPECIALITY_TYPE.eTalent~=tztype then
return false
end
local descList=UIDiscipleModel:getDiscipleSpecialityConfig(disciple_guid,true)
if descList then
for i,v in ipairs(descList)do
if v.specialitytype==tztype and v.id==tzid then
return true
end
end
end
return false
end

function UIFuncItemUseModel:reSortTeZiDisciple(dzList)
local list={}
for i,v in ipairs(dzList)do
local netdata=v.netData
local guid=netdata.net.discipleguid
local ishave=self:checkDiZiHaveTezhi(guid,DISCIPLE_SPECIALITY_TYPE.eTalent,19)and 1 or 0
if ishave>0 then
v.sortTag=ishave*100000
else
v.sortTag=i
end
table.insert(list,v)
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end


function UIFuncItemUseModel.checkReconfirmType(reconfirmType)
if reconfirmType then
if reconfirmType==1 then
return REPEAT_TYPE.eItemWine1
elseif reconfirmType==2 then
return REPEAT_TYPE.eItemWine2
elseif reconfirmType==3 then
return REPEAT_TYPE.eItemWine3
else
return FMT.fmt("reconfirmType_{0}",reconfirmType)
end
end
return REPEAT_TYPE.eItemHideReconfirmDialog
end







wanbaoXunBaoDuiHelper={}





function wanbaoXunBaoDuiHelper.getWBXBDItem(guid)
return maomaoBagModel:getItem(guid)
end





function wanbaoXunBaoDuiHelper.getJilianMaxLv(guid)
local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(guid)
local color=itemsConfig.getItemColor(itemdata.itemid)
local makeCfg=cfgHelper.get1(cfg_catequipmakeconfig_get,color)
return makeCfg.maxJLLv
end





function wanbaoXunBaoDuiHelper.getJilianValue(guid)

local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(guid)
local exp=0
if itemsConfig.isMaterials(itemdata.itemid)then
local itemCfg=itemsConfig.getConfig(itemdata.itemid)
exp=itemCfg.jlExp or 0
else
exp=wanbaoXunBaoDuiHelper.getEquipJlExpValue(guid)
end
return exp
end





function wanbaoXunBaoDuiHelper.caculateNeedMaxExp(guid)
local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(guid)
local curJlExp=(itemdata.itemData.jl_exp or 0)
local curJlLv=(itemdata.itemData.jl_lv or 0)+1
local maxLv=wanbaoXunBaoDuiHelper.getJilianMaxLv(guid)
local jlxhCfg=cfg_catequipjlxhconfig()
local exp=jlxhCfg[curJlLv].needExp-curJlExp
for lv=curJlLv+1,maxLv do
exp=exp+jlxhCfg[lv].needExp
end
return exp
end










function wanbaoXunBaoDuiHelper.transInitPropData(list,MaxNum)
local propList={}
for index=1,MaxNum do
local data=list[index]
if data then
local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(data.itemguid)
local prop=itemsComponentHelper.getCommonFillData({itemid=itemdata.itemid,itemcount=data.count},{showname=false,nomalname=false,showcount=data.count>1})
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
prop[PropIndex(DataPropKey.eWidgetActive,0)]=false
prop[PropIndex(DataPropKey.eWidgetActive,2)]=true
prop[PropIndex(DataPropKey.eWidgetActive,3)]=true
prop[PropIndex(DataPropKey.eWidgetActive,4)]=true
prop[PropIndex(DataPropKey.eWidgetActive,6)]=true
prop[PropIndex(DataPropKey.eWidgetActive,7)]=true

table.insert(propList,prop)
else

local prop={}
prop[PropIndex(DataPropKey.eWidgetActive,0)]=true
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetActive,4)]=false
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
prop[PropIndex(DataPropKey.eWidgetActive,6)]=false
prop[PropIndex(DataPropKey.eWidgetActive,7)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
table.insert(propList,prop)
end
end
return propList
end





function wanbaoXunBaoDuiHelper.getEquipJlExpValue(guid)
local itemdata=wanbaoXunBaoDuiHelper.getWBXBDItem(guid)
local totalexp=0
local itemCfg=itemsConfig.getConfig(itemdata.itemid)
local jlExpCfg=cfg_catequipjlxhconfig()
for i=1,(itemdata.itemData.jl_lv or 0)do
local exp=jlExpCfg[i].needExp
totalexp=totalexp+exp
end
totalexp=totalexp+(itemdata.itemData.jl_exp or 0)
totalexp=totalexp+itemCfg.jlExp
return totalexp
end




function wanbaoXunBaoDuiHelper.getTQChannel()
local channelCfg=cfgHelper.get1(cfg_cattequanconfig_get,1)
return channelCfg.channelid
end





function wanbaoXunBaoDuiHelper.transLineStr(str)
if pfwindowslController:checkIsGameVersion_yuenan()then
return str
else
local result=string.toTable(str)

local temp=""
for k,v in pairs(result)do
temp=FMT.fmt("{0}\n{1}",temp,v)
end
return temp
end
end





function wanbaoXunBaoDuiHelper:getCatQualityFrame(quality)
quality=quality+1
return FMT.fmt('image_miaomipzaui_{0}',quality),globalABLookup.wanbaoxunbaodui
end





function wanbaoXunBaoDuiHelper:getCatLevelFrame(quality)
quality=quality+1
return FMT.fmt('image_miaomipzbui_{0}',quality),globalABLookup.wanbaoxunbaodui
end





function wanbaoXunBaoDuiHelper:getCatRecruitFrame(quality)
quality=quality+1
return FMT.fmt('frame_zhaoshoumm_{0}',quality),globalABLookup.wanbaoxunbaodui
end





function wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(catdata)
local cfg=cfgHelper.get1(cfg_catshowconfig_get,catdata.wx_id)
local modelid=cfg.model

local componets={}
if catdata.equip_num>0 then
local equipdata=catdata.equipList[1]
local equipCfg=itemsConfig.getConfig(equipdata.itemid)
local weaponID=0
if equipCfg then
weaponID=equipCfg.imageID or 0

end
if weaponID>0 then
table_insert(componets,cfgHelper.get2(cfg_wbxbdcatweaponimageconfig_get,weaponID,'in_side'))
end
end
return modelid,componets
end






function wanbaoXunBaoDuiHelper:getCatModelParam(catdata,type)
local cfg=cfgHelper.get1(cfg_catshowconfig_get,catdata.wx_id)
local modelid=cfg.model

type=type or 1
local side=type==1 and'in_side'or'out_side'

local componets={}
if catdata.equip_num>0 then
local equipdata=catdata.equipList[1]
local equipCfg=itemsConfig.getConfig(equipdata.itemid)
local weaponID=0
if equipCfg then
weaponID=equipCfg.imageID or 0

end
if weaponID>0 then
table_insert(componets,cfgHelper.get2(cfg_wbxbdcatweaponimageconfig_get,weaponID,side))
end
end
return modelid,componets
end










function wanbaoXunBaoDuiHelper:startSpeakBt(item,speakRootIndex,contentIndex,speakContentType,speakAddSpeak,speakRemoveSpeak)
local speakWidget=item:GetChildWidgetBase(speakRootIndex)
local initData={
speakWidget=speakWidget,
contentIndex=contentIndex,
speakContentType=speakContentType,
speakAddSpeak=speakAddSpeak,
speakRemoveSpeak=speakRemoveSpeak,
}
return behaviorManager:addBehaviorTree('bt_ui_wbxbd_speak',nil,true,initData)
end






function wanbaoXunBaoDuiHelper:setEmployeeSpeakContent(item,index,speakContentType)
local speakContentOption=cfgHelper.get1(cfg_catspeekconfig_get,speakContentType)
local randomIndex=Mathf.Random(1,#speakContentOption)
local content=speakContentOption[randomIndex].content
item:SetChildText(index,content)
end




function wanbaoXunBaoDuiHelper:setSpeakContent(bt)
local speakType=bt:getSharedVar('speakType')
local speakContentOption=cfgHelper.get1(cfg_catspeekconfig_get,speakType)
local randomIndex=Mathf.Random(1,#speakContentOption)
local content=speakContentOption[randomIndex].content
bt:setSharedVar('speakContent',content)
end





function wanbaoXunBaoDuiHelper:FloorProtect(value)
return Mathf.Floor(value+0.00001)
end


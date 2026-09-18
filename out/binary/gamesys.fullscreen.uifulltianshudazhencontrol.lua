UIFullTianShuDaZhenControl=gameState.addListener(fullScreenUI.create())

function UIFullTianShuDaZhenControl:onAppStart()
local args={
fullType=FULL_TYPE.eTianShuDaZhen,
skinType=fullScreenSkinType.eSkin26,
}
self:initUI(args)
end

function UIFullTianShuDaZhenControl:showMainWindow(argstable,jump)
if not mountainControl:isOpen(mapIdType.fort,true)then return false end
if jump==nil then jump=true end
local data=zongmenModel:findBuildingDataByType(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if not data then
if jump then
UIFullTianShuDaZhenControl:showBuildDialogue()
else
UIManager.error('云港未建造，无法开启天枢大阵')
end
return false
end

local list=XianYunGangModel:getBoatList()
if list==nil or#list==0 then
if jump then
UIFullTianShuDaZhenControl:showBuildBoatDialogue()
else
UIManager.error('未建造云舟，无法开启天枢大阵')
end
return false
end

local args={
showBg=true,
viewNames={'UITianShuDaZhenWin'},
viewArgs={['UITianShuDaZhenWin']=argstable},
}
return self:showUI(args)
end

function UIFullTianShuDaZhenControl:showBuildDialogue()
local desc=FMT.fmt('云港未建造，无法开启天枢大阵,是否前往建造？')
local func=function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eXianYunGang,mapid=mapIdType.fort,isOpenRepairWin=true}},nil,JUMP_BACK.eNoBack)
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end

function UIFullTianShuDaZhenControl:showBuildBoatDialogue()
local desc=FMT.fmt('未建造云舟，无法开启天枢大阵,是否前往建造？')
local func=function()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eXianYunGang,mapid=mapIdType.fort}},nil,JUMP_BACK.eNoBack)
end
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end







local _selectData={}

function huntMonsterTeamModel:initSelectData()
_selectData={
monsters={},
disciples={},
}
end

function huntMonsterTeamModel:addSelectMonster(unitKey)
table.insert(_selectData.monsters,unitKey)
end

function huntMonsterTeamModel:clearSelectMonster()
_selectData.monsters={}
end

function huntMonsterTeamModel:isSelectMonster(unitKey)
return table.containsValue(_selectData.monsters,unitKey)
end

function huntMonsterTeamModel:getSelectMonsterCount()
return#_selectData.monsters
end

function huntMonsterTeamModel:removeSelectMonster(unitKey)
local index=table.findValue(_selectData.monsters,unitKey)
if index then
table.remove(_selectData.monsters,index)
end
end

function huntMonsterTeamModel:getSelectMonster()
return _selectData.monsters
end

function huntMonsterTeamModel:setSelectDisciple(teamList)
local disciples=fightPreSelectModel.convertFightStruct2Disciple(teamList)
_selectData.disciples=disciples
end

function huntMonsterTeamModel:setSelectDiscipleEx(saveData)
if saveData and next(saveData)then
_selectData.disciples={}
for i=1,fightPreSelectModel.maxPosNum do
if saveData[i]and UIDiscipleModel:checkDZStateToDoSomething(saveData[i],eCheckDiscipleStateOpType.eDispatch,false)then
_selectData.disciples[i]=saveData[i]
else
_selectData.disciples[i]=int64.zero
end
end
end
end

function huntMonsterTeamModel:getSelectDisciple()
return _selectData.disciples
end

function huntMonsterTeamModel:clearSelectDisciple()
_selectData.disciples={}
end

function huntMonsterTeamModel:setSelectZhenFa(zfId)
_selectData.zhenfa=zfId
end

function huntMonsterTeamModel:getSelectZhenFa()
return _selectData.zhenfa
end

function huntMonsterTeamModel:checkSelectDiscipleValid()
local disciples=self:getSelectDisciple()
if#disciples==5 then
for i,v in ipairs(disciples)do
if mathHelper.validInt64(v)then
return true
end
end
end
return false
end

function huntMonsterTeamModel:checkAndRefreshSelectMonsterList()
local monsters=self:getSelectMonster()
local removeList={}
for i,v in ipairs(monsters)do
if not huntMonsterTeamModel:checkMonsterDataExist(v)then
table.insert(removeList,i)
end
end
local rKeys={}
for i=#removeList,1,-1 do
local rKey=table.remove(monsters,removeList[i])
table.insert(rKeys,rKey)
end
return rKeys
end

function huntMonsterTeamModel:clearSelectZhenFa()
_selectData.zhenfa=nil
end

function huntMonsterTeamModel:setSelectWorld(world)
_selectData={
world=world,
monsters={},
disciples={},
zhenfa=nil,
}
end

function huntMonsterTeamModel:getSelectWorld()
return _selectData.world
end

function huntMonsterTeamModel:checkSelectWorld(world)
return self:getSelectWorld()==world
end
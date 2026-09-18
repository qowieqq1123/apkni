







local _MODULENAME="worldMonsterProtocolController"
gameState.addListener(def_table(_MODULENAME))
worldMonsterProtocolController.name=_MODULENAME



function worldMonsterProtocolController:onAppStart()
socketManager:register_receiver(5,21,worldMonsterProtocolController.recv_5_21)
socketManager:register_receiver(5,22,worldMonsterProtocolController.recv_5_22)

socketManager:register_receiver(5,24,worldMonsterProtocolController.recv_5_24)
socketManager:register_receiver(5,25,worldMonsterProtocolController.recv_5_25)


end

function worldMonsterProtocolController:onEnterState()


end

function worldMonsterProtocolController:onLeaveState()


end

























function worldMonsterProtocolController.req_fresh()
socketManager:send_5_22()
end


function worldMonsterProtocolController.req_fight(areaId,monsterGroundId,discipleCount,discipleList)
socketManager:send_5_23(areaId,monsterGroundId,discipleCount,discipleList)
end


function worldMonsterProtocolController.req_abandon(areaId,monsterGroundId)
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='放弃后怪物会离开，是否确认？',
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
socketManager:send_5_24(areaId,monsterGroundId)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function worldMonsterProtocolController.req_pos_data()

end




function worldMonsterProtocolController.recv_5_21(lastStamp,dataListLen,dataList)

chatGGModel.initMonster(dataList)
worldMonsterModel:set_last_stamp(lastStamp)
worldMonsterController:refreshTime()

local isInitTime=not initProControl.isDone()

worldMonsterController.clear_all_monster_unit()
worldMonsterModel:set_monster_list(dataListLen,dataList,isInitTime)

worldMonsterController.show_all_monster_unit()
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
worldModel:finishInit(eWorldUnitTpye.MONSTER)

huntMonsterTeamController:checkMonsterDataRefresh()
end


function worldMonsterProtocolController.recv_5_22(monsterListLen,monsterList)

if monsterListLen>0 then
for i,v in ipairs(monsterList)do
worldMonsterController.add_monster(v.quyuId,v.gwzId,v.gwzLevel,v.guidPos)
end
end
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end
























function worldMonsterProtocolController.recv_5_24(areaId,guidPos)

local monster=worldMonsterModel:get_monster_by_posId(tostring(guidPos))
if monster then
worldMonsterController:remove_monster_unit(monster.posId,monster.posData)
end
worldMonsterController.remove_monster(areaId,guidPos)
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")

worldController:resetRightView()
UIManager.info("妖怪已离去")
worldMonsterController:refreshTime()
end


function worldMonsterProtocolController.recv_5_25(lastStamp)

worldMonsterModel:set_last_stamp(lastStamp)
worldMonsterController:refreshTime()
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshTime")
end


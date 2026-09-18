worldDispatchTask_Fake=simple_class(worldDispatchTask)
worldDispatchTask_Fake.name="worldDispatchTask_Fake"

function worldDispatchTask_Fake:save()

end

function worldDispatchTask_Fake:cancel()
self:inactive()
worldTaskModel:removeTask(self.id)
notifySystem:postNotify(notifyConfig.onStopMissionInWorld,self.id,self.target_type,self.target_id)
end
function init()
  Directives = effect.getParameter("directives")
  
  local r = effect.getParameter("timerRange")
  Time = r[1] + (math.random() * (r[2] - r[1]))
	timer = 0
end

function update(dt)
	if timer < 1 then
		timer = math.min(1, timer + (dt / Time))
		
		effect.setParentDirectives(Directives..timer * 0.65)
		
		if timer == 1 then
      animator.setParticleEmitterOffsetRegion("grimacewater", mcontroller.boundBox())
			animator.burstParticleEmitter("grimacewater")
			animator.playSound("kill")
      
      local targets = world.entityQuery(
        entity.position(),
        effect.getParameter("spreadRadius"),
        {withoutEntityId = entity.id(), includedTypes = {"creature"}}
      )
      for _,id in pairs(targets) do
        world.sendEntityMessage(id, "applyStatusEffect", "pat_grimaceshake")
      end
		end
	else
    effect.addStatModifierGroup{{stat = "invisible", amount = 1}, {stat = "maxHealth", effectiveMultiplier = 0}}
	end
end